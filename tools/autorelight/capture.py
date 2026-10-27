"""Capture before/after screenshots of generated scenes in the real game, within a time budget.

For each scene: write loadanylevel.ini, set the scene .ini to relight OFF, launch, capture the game window,
kill; then the same with relight ON. The save folder is backed up before and restored after the run,
because loading levels writes autosaves.

Usage: python capture.py --scenes adv_drugstoreOffice adv_drugstoreExterior [--wait 45] [--budget 600]
"""
import argparse
import json
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

INI_ON = "[Main]\nExposureOffset=0\nEnableDepthOfField=true\nEnableVolumetricLighting=false\nEnableRelighting=true\nDepthOfFieldAperture={aperture}\n\n[Version]\nConfigurationVersion=100\n"


def kill_game():
    subprocess.run(["taskkill", "/IM", "WDC.exe", "/F"], capture_output=True)
    time.sleep(2)


def shoot(record, relight, wait):
    stem = record["lua_file"][:-len(".lua")]
    scene_ini = GAME / "RelightLevels" / f"{stem}.ini"
    text = INI_ON.format(aperture=2.8)
    if not relight:
        text = text.replace("EnableRelighting=true", "EnableRelighting=false").replace("EnableDepthOfField=true", "EnableDepthOfField=false")
    scene_ini.write_text(text, encoding="utf-8")
    archive = "WalkingDead" + record["episode"]
    script = record["script"][:-len(".lua")]
    (GAME / "loadanylevel.ini").write_text(
        f"[boot]\noverrideBootSequence=true\narchiveToLoad={archive}\nscriptToLoad={script}\n", encoding="utf-8")
    subprocess.Popen([str(GAME / "WDC.exe")], cwd=str(GAME))
    time.sleep(wait)
    target = OUT / f"{record['episode']}_{record['scene']}_{'ON' if relight else 'OFF'}.png"
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
    args = parser.parse_args()

    records = {}
    for path in (HERE / "data" / "scenes").glob("*.json"):
        rec = json.loads(path.read_text(encoding="utf-8"))
        records[rec["scene"]] = rec
    OUT.mkdir(parents=True, exist_ok=True)
    backup = TOOLS / "save_backups" / datetime.now().strftime("%Y%m%d_%H%M%S")
    shutil.copytree(SAVES, backup)
    start = time.time()
    try:
        for scene in args.scenes:
            for relight in (False, True):
                if time.time() - start + args.wait + 10 > args.budget:
                    print("budget reached, stopping")
                    return 0
                name, status = shoot(records[scene], relight, args.wait)
                print(f"{name}: {status} ({int(time.time() - start)}s)", flush=True)
    finally:
        kill_game()
        shutil.rmtree(SAVES)
        shutil.copytree(backup, SAVES)
        print(f"saves restored from {backup}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
