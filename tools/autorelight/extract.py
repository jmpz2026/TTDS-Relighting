"""Extract per-scene data needed by the auto relight generator.

For every level script in relight-mod/WDC_pc_WalkingDead*_data, read its kScene and its
RelightConfigLevel key, resolve the RelightSceneLuaFile from the season configs, extract the
matching .scene from the game archive with ttarchext, and dump the agent names found in it.

Output: tools/autorelight/data/scenes/<lua file stem>.json
"""
import argparse
import json
import re
import struct
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
MOD = REPO / "relight-mod"
CONFIG_DIR = MOD / "Relight_Scripts_Library"
OUT_DIR = Path(__file__).resolve().parent / "data" / "scenes"
CACHE_DIR = Path.home() / "Tools" / "telltale" / "extract"
TTARCHEXT = Path.home() / "Tools" / "telltale" / "script-editor" / "telltale-script-editor-win32-x64" / "resources" / "ttarchext.exe"
GAME_ARCHIVES = Path(r"C:\Program Files (x86)\Steam\steamapps\common\The Walking Dead The Telltale Definitive Series\Archives")
TTARCHEXT_GAME_ID = "67"  # The Walking Dead: The Telltale Definitive Series

IDENT = re.compile(rb"^[A-Za-z_][A-Za-z0-9_\-\.]*$")


def read_config_files():
    """Map config key (e.g. Level_101_env_drugstoreExterior) to the relight lua file name."""
    entry = re.compile(r"(Level_\w+)\s*=\s*\{\s*RelightSceneLuaFile\s*=\s*RELIGHT_LevelsFolderName\s*\.\.\s*\"/([^\"]+)\"", re.S)
    result = {}
    for path in sorted(CONFIG_DIR.glob("RELIGHT_RelightingConfiguration_S*.lua")):
        for key, lua_file in entry.findall(path.read_text(encoding="utf-8", errors="replace")):
            result[key] = lua_file
    return result


def read_level_scripts():
    """Yield (episode data folder, kScene, config key) for every level script of the mod."""
    scene_re = re.compile(r"^local kScene\s*=\s*\"([^\"]+)\"", re.M)
    level_re = re.compile(r"RelightConfigLevel\s*=\s*RelightConfigData_\w+\.(Level_\w+)")
    for path in sorted(MOD.glob("WDC_pc_WalkingDead*_data/*.lua")):
        text = path.read_text(encoding="utf-8", errors="replace")
        scene, level = scene_re.search(text), level_re.search(text)
        if scene and level:
            yield path.parent.name, scene.group(1), level.group(1), path.name


def extract_scenes(data_folder):
    """Extract all .scene files of one episode archive into the cache, once."""
    target = CACHE_DIR / data_folder
    if target.exists() and any(target.glob("*.scene")):
        return target
    target.mkdir(parents=True, exist_ok=True)
    archive = GAME_ARCHIVES / f"{data_folder}.ttarch2"
    subprocess.run([str(TTARCHEXT), "-f", "*.scene", TTARCHEXT_GAME_ID, str(archive), str(target)],
                   check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    return target


def read_strings(data):
    """Return the length-prefixed identifier strings of a MSV6 scene, in file order, without duplicates."""
    found, seen = [], set()
    for i in range(len(data) - 4):
        (length,) = struct.unpack_from("<I", data, i)
        if 3 <= length <= 128 and i + 4 + length <= len(data):
            raw = data[i + 4:i + 4 + length]
            if IDENT.match(raw):
                text = raw.decode("ascii")
                if text not in seen:
                    seen.add(text)
                    found.append(text)
    return found


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--episode", help="only this episode, e.g. 101 or M101")
    args = parser.parse_args()

    configs = read_config_files()
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    written, missing = 0, []
    for data_folder, scene, level_key, script in read_level_scripts():
        episode = data_folder.replace("WDC_pc_WalkingDead", "").replace("_data", "")
        if args.episode and episode != args.episode:
            continue
        lua_file = configs.get(level_key)
        if not lua_file:
            missing.append(f"{script}: no config entry {level_key}")
            continue
        folder = extract_scenes(data_folder)
        scene = re.sub(r"\.scene$", "", scene)
        matches = [p for p in folder.glob("*.scene") if p.stem.lower() == scene.lower()]
        if not matches:
            missing.append(f"{script}: scene {scene}.scene not in {data_folder}")
            continue
        agents = read_strings(matches[0].read_bytes())
        record = {
            "episode": episode,
            "script": script,
            "scene": scene,
            "config_key": level_key,
            "lua_file": lua_file,
            "lights": [a for a in agents if a.lower().startswith("light")],
            "cameras": [a for a in agents if a.lower().startswith("cam")],
            "agents": agents,
        }
        stem = lua_file[:-len(".lua")]
        (OUT_DIR / f"{stem}.json").write_text(json.dumps(record, indent=1), encoding="utf-8")
        written += 1
    print(f"written {written}, problems {len(missing)}")
    for line in missing:
        print("  " + line)
    return 0


if __name__ == "__main__":
    sys.exit(main())
