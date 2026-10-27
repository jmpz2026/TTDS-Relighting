"""Rebuild the release archives that changed for Michonne support, without the Script Editor GUI.

For each archive: extract the original from the Relight v0.2.1 release, replace the changed scripts with
freshly compiled ones (luac 5.2.4, same as the release), and rebuild with ttarchext -b.
Output goes to tools/autorelight/build/; the file list of every rebuilt archive is compared with the original.
"""
import shutil
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
MOD = HERE.parents[1] / "relight-mod"
TOOLS = Path.home() / "Tools" / "telltale"
RES = TOOLS / "script-editor" / "telltale-script-editor-win32-x64" / "resources"
TTARCHEXT, LUAC = RES / "ttarchext.exe", RES / "luac.exe"
RELEASE = TOOLS / "relight021" / "RelightV0_2_1" / "MOVE_CONTENTS_TO_GAME_ARCHIVES_FOLDER"
WORK, OUT = TOOLS / "rebuild", HERE / "build"
GAME_ID = "67"

ARCHIVES = {
    "WDC_pc_WalkingDeadM101_data_RelightMod.ttarch2": MOD / "WDC_pc_WalkingDeadM101_data",
    "WDC_pc_WalkingDeadM102_data_RelightMod.ttarch2": MOD / "WDC_pc_WalkingDeadM102_data",
    "WDC_pc_WalkingDeadM103_data_RelightMod.ttarch2": MOD / "WDC_pc_WalkingDeadM103_data",
    "Relight_Scripts_Library_RelightMod.ttarch2": MOD / "Relight_Scripts_Library",
}


def listing(archive):
    result = subprocess.run([str(TTARCHEXT), "-l", GAME_ID, str(archive), "."], capture_output=True, text=True)
    return sorted(line.split()[-1] for line in result.stdout.splitlines() if line.strip().endswith(".lua"))


def main():
    OUT.mkdir(exist_ok=True)
    problems = []
    for name, source in ARCHIVES.items():
        folder = WORK / name
        shutil.rmtree(folder, ignore_errors=True)
        folder.mkdir(parents=True)
        subprocess.run([str(TTARCHEXT), "-o", GAME_ID, str(RELEASE / name), str(folder)], check=True, capture_output=True)
        replaced = 0
        for lua in source.glob("*.lua"):
            target = folder / lua.name
            if target.exists():
                subprocess.run([str(LUAC), "-o", str(target), str(lua)], check=True)
                replaced += 1
        built = OUT / name
        built.unlink(missing_ok=True)
        subprocess.run([str(TTARCHEXT), "-b", GAME_ID, str(built), str(folder)], check=True, capture_output=True)
        same = listing(RELEASE / name) == listing(built)
        print(f"{name}: replaced {replaced} scripts, file list {'matches' if same else 'DIFFERS'}")
        if not same:
            problems.append(name)
    return 1 if problems else 0


if __name__ == "__main__":
    sys.exit(main())
