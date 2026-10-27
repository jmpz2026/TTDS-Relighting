"""Rebuild the release archives that changed for Michonne support, without the Script Editor GUI.

For each archive: extract the original from the Relight v0.2.1 release, put in freshly compiled scripts
(luac 5.2.4, same as the release; new scripts are added), and rebuild with ttarchext -b.
New archives (not in the release, like the Options > Relight menu) are built from their folder alone and get a
resource description (_resdesc_50_*.lua) written from the Script Editor template and encrypted with ttarchext.
Output goes to tools/autorelight/build/; every file of the original archive must still be in the rebuilt one.
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
NEW_ARCHIVES = {
    "WDC_pc_Menu_data_RelightMod.ttarch2": MOD / "WDC_pc_Menu_data",
}
MOD_NAME, MOD_AUTHOR, MOD_VERSION, MOD_PRIORITY = "Relight Mod", "changemymindpls1", "0.2", 950

RESDESC = """--File associated with '{mod}' by {author}, version {version}
local set = {{}}
set.name = "{set_name}"
set.setName = "{set_name}"
set.descriptionFilenameOverride = ""
set.logicalName = "<>"
set.logicalDestination = "<>"
set.priority = {priority}
set.localDir = _currentDirectory
set.enableMode = "bootable"
set.version = "trunk"
set.descriptionPriority = 0
set.gameDataName = "{set_name} Game Data"
set.gameDataPriority = {priority}
set.gameDataEnableMode = "constant"
set.localDirIncludeBase = true
set.localDirRecurse = false
set.localDirIncludeOnly = nil
set.localDirExclude =
{{
    "Packaging/",
    "_dev/"
}}
set.gameDataArchives =
{{
    _currentDirectory .. "{archive}"
}}
RegisterSetDescription(set)
"""


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
        replaced, added = compile_folder(source, folder)
        built = build(name, folder)
        same = set(listing(RELEASE / name)) <= set(listing(built))
        print(f"{name}: replaced {replaced}, added {added} scripts, original files {'kept' if same else 'MISSING'}")
        if not same:
            problems.append(name)
    for name, source in NEW_ARCHIVES.items():
        folder = WORK / name
        shutil.rmtree(folder, ignore_errors=True)
        folder.mkdir(parents=True)
        _, added = compile_folder(source, folder)
        build(name, folder)
        write_resdesc(name)
        print(f"{name}: new archive, {added} scripts")
    return 1 if problems else 0


def compile_folder(source, folder):
    replaced = added = 0
    for lua in source.glob("*.lua"):
        target = folder / lua.name
        if target.exists():
            replaced += 1
        else:
            added += 1
        subprocess.run([str(LUAC), "-o", str(target), str(lua)], check=True)
    return replaced, added


def build(name, folder):
    built = OUT / name
    built.unlink(missing_ok=True)
    subprocess.run([str(TTARCHEXT), "-b", GAME_ID, str(built), str(folder)], check=True, capture_output=True)
    return built


def write_resdesc(archive):
    logical = archive[:-len(".ttarch2")].replace("WDC_pc_", "").replace("_data", "")
    set_name = logical.replace("_RelightMod", "") + "RelightMod"
    plain = WORK / "resdesc" / f"_resdesc_50_{logical}.lua"
    plain.parent.mkdir(parents=True, exist_ok=True)
    plain.write_text(RESDESC.format(mod=MOD_NAME, author=MOD_AUTHOR, version=MOD_VERSION, set_name=set_name,
                                    priority=MOD_PRIORITY, archive=archive), encoding="utf-8", newline="\n")
    subprocess.run([str(TTARCHEXT), "-V", "7", "-e", "0", "-o", GAME_ID, str(plain), str(OUT)], check=True, capture_output=True)


if __name__ == "__main__":
    sys.exit(main())
