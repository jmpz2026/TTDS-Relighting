"""Capture before/after screenshots of generated scenes in the real game, within a time budget.

For each scene: write loadanylevel.ini, set the scene .ini to relight OFF, launch, capture the game window,
kill; then the same with relight ON. The save folder is backed up before and restored after the run,
because loading levels writes autosaves.

OFF writes a scene .ini with every switch off. ON deletes the scene .ini, so the game regenerates it with
the generated defaults. --global KEY=VALUE sets keys in RelightConfiguration_Main.ini for the run (restored after);
--only-on skips the OFF shots and --tag adds a suffix to the capture names.

Usage: python capture.py --scenes adv_drugstoreOffice adv_drugstoreExterior [--wait 45] [--budget 600]
                         [--global EnableLensFlare=false] [--only-on] [--tag noflare]
"""
import argparse
import json
import re
import shutil
import subprocess
import sys
import time
from datetime import datetime
from pathlib import Path

HERE = Path(__file__).resolve().parent
GAME = Path(r"C:\Program Files (x86)\Steam\steamapps\common\The Walking Dead The Telltale Definitive Series")
SAVES = Path.home() / "Documents" / "Telltale Games" / "The Walking Dead Definitive"
TOOLS = Path.home() / "Tools" / "telltale"
CAPTURE_PS1 = TOOLS / "capture_window.ps1"
OUT = TOOLS / "captures"

MAIN_INI = GAME / "RelightMod" / "RelightConfiguration_Main.ini"
CONFIG_VERSION = 102  # RELIGHT_CurrentConfigurationVersion
INI_OFF = ("[Main]\nExposureOffset=0\nEnableRelighting=false\nEnableDepthOfField=false\nEnableVolumetricLighting=false\n"
           "EnableColorGrading=false\nEnableLensFlare=false\n"
           "DepthOfFieldAperture=2.8\n\n[Version]\nConfigurationVersion={version}\n").format(version=CONFIG_VERSION)


def apply_globals(overrides):
    """Set [Global] keys in the main .ini, if the game already wrote it with the current version."""
    if not overrides or not MAIN_INI.exists():
        return
    text = MAIN_INI.read_text(encoding="utf-8")
    if f"ConfigurationVersion={CONFIG_VERSION}" not in text:
        return
    for key, value in overrides.items():
        text = re.sub(rf"(?m)^{key}=.*$", f"{key}={value}", text)
    MAIN_INI.write_text(text, encoding="utf-8")


def kill_game():
    subprocess.run(["taskkill", "/IM", "WDC.exe", "/F"], capture_output=True)
    time.sleep(2)


def shoot(record, relight, wait, overrides, tag):
    stem = record["lua_file"][:-len(".lua")]
    scene_ini = GAME / "RelightLevels" / f"{stem}.ini"
    scene_ini.unlink(missing_ok=True)
    if not relight:
        scene_ini.write_text(INI_OFF, encoding="utf-8")
    apply_globals(overrides)
    archive = "WalkingDead" + record["episode"]
    script = record["script"][:-len(".lua")]
    (GAME / "loadanylevel.ini").write_text(
        f"[boot]\noverrideBootSequence=true\narchiveToLoad={archive}\nscriptToLoad={script}\n", encoding="utf-8")
    subprocess.Popen([str(GAME / "WDC.exe")], cwd=str(GAME))
    time.sleep(wait)
    suffix = f"_{tag}" if tag else ""
    target = OUT / f"{record['episode']}_{record['scene']}_{'ON' if relight else 'OFF'}{suffix}.png"
    result = subprocess.run(["powershell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", str(CAPTURE_PS1),
                             "-Out", str(target)], capture_output=True, text=True)
    kill_game()
    scene_ini.unlink(missing_ok=True)  # the game regenerates it with the generated defaults
    return target.name, result.stdout.strip()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--scenes", nargs="+", required=True)
    parser.add_argument("--wait", type=int, default=45)
    parser.add_argument("--budget", type=int, default=600)
    parser.add_argument("--global", dest="overrides", nargs="*", default=[])
    parser.add_argument("--only-on", action="store_true")
    parser.add_argument("--tag", default="")
    args = parser.parse_args()
    overrides = dict(item.split("=", 1) for item in args.overrides)

    records = {}
    for path in (HERE / "data" / "scenes").glob("*.json"):
        rec = json.loads(path.read_text(encoding="utf-8"))
        records[rec["scene"]] = rec
    OUT.mkdir(parents=True, exist_ok=True)
    backup = TOOLS / "save_backups" / datetime.now().strftime("%Y%m%d_%H%M%S")
    shutil.copytree(SAVES, backup)
    main_ini_backup = MAIN_INI.read_text(encoding="utf-8") if MAIN_INI.exists() else None
    start = time.time()
    try:
        for scene in args.scenes:
            for relight in ((True,) if args.only_on else (False, True)):
                if time.time() - start + args.wait + 10 > args.budget:
                    print("budget reached, stopping")
                    return 0
                name, status = shoot(records[scene], relight, args.wait, overrides, args.tag)
                print(f"{name}: {status} ({int(time.time() - start)}s)", flush=True)
    finally:
        kill_game()
        if overrides and main_ini_backup is not None:
            MAIN_INI.write_text(main_ini_backup, encoding="utf-8")
        shutil.rmtree(SAVES)
        shutil.copytree(backup, SAVES)
        print(f"saves restored from {backup}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
