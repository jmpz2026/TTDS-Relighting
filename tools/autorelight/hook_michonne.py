"""Hook the Michonne (M101-M103) level scripts into Relight, the same way the S1-S4 scripts are.

The original mod ships the Michonne scripts untouched and the SM config with empty placeholders.
For each relight-mod/WDC_pc_WalkingDeadM10x_data/*.lua this script:
  - adds require("RELIGHT_Include.lua") and the Relight/TLSE scene variables after kScene,
  - turns `function <kScript>()` into `local OriginalTelltaleLevelStartLogic = function()`,
  - adds a new `<kScript> = function()` before SceneOpen that applies relight and then calls the original logic.
Then it rewrites RELIGHT_RelightingConfiguration_SM.lua with one entry per scene.
Idempotent: already hooked scripts are only read for the config.
"""
import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
MOD = REPO / "relight-mod"
SM_CONFIG = MOD / "Relight_Scripts_Library" / "RELIGHT_RelightingConfiguration_SM.lua"
MARKER = 'require("RELIGHT_Include.lua");'

VARIABLES = """
--Telltale Lua Script Extensions (TLSE) Development variables
TLSE_Development_SceneObject = kScene;
TLSE_Development_SceneObjectAgentName = kScene .. ".scene";
TLSE_Development_FreecamUseFOVScale = false;

--Relight variables
RELIGHT_SceneObject = kScene;
RELIGHT_SceneObjectAgentName = kScene .. ".scene";
RelightConfigLevel = RelightConfigData_SeasonM.{config_key};
"""

START_FUNCTION = """--|||||||||||||||||||||||||||||||||||||||||||||||| LEVEL START FUNCTION ||||||||||||||||||||||||||||||||||||||||||||||||
--Main function called when the level starts: apply relight, then run the original Telltale logic.
{script} = function()
  RELIGHT_ConfigurationStart();

  if (RelightConfigDevelopment.EditorMode == true) then
    TLSE_Development_Editor_CaptureOriginalSceneAgentNames();
  end

  --load this scene's external relight LUA file (if it doesn't exist or has errors, this won't run)
  if(TLSE_LoadAndUseLuaFile(RelightConfigLevel["RelightSceneLuaFile"])) then
    RELIGHT_SceneStart();
    Callback_PostUpdate:Add(RELIGHT_SceneUpdate);
  end

  RELIGHT_Global_Start();
  Callback_PostUpdate:Add(RELIGHT_Global_Update);

  if (RelightConfigDevelopment.EditorMode == true) then
    TLSE_Development_GUI_RelightLuaExportNamePrefix = "{episode}_";
    TLSE_Development_Editor_Start();
    Callback_PostUpdate:Add(TLSE_Development_Editor_Update);
    return;
  end

  if (RelightConfigDevelopment.FreeCameraOnlyMode == true) then
    TLSE_Development_CreateFreeCamera();
    Callback_PostUpdate:Add(TLSE_Development_UpdateFreeCamera);
  end

  if (RelightConfigDevelopment.PerformanceMetrics == true) then
    TLSE_Development_PerformanceMetrics_Initalize();
    Callback_PostUpdate:Add(TLSE_Development_PerformanceMetrics_Update);
  end

  if (RelightConfigDevelopment.FreeCameraOnlyMode == true and RelightConfigDevelopment.FreeCameraOnlyMode_StartSceneNormally == false) then
    return;
  end

  OriginalTelltaleLevelStartLogic();
end

"""

CONFIG_HEADER = """--||||||||||||||||||||||||||||||||||||||| INI GENERATION - RELIGHT SEASON M |||||||||||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||||||||||| INI GENERATION - RELIGHT SEASON M |||||||||||||||||||||||||||||||||||||||
--||||||||||||||||||||||||||||||||||||||| INI GENERATION - RELIGHT SEASON M |||||||||||||||||||||||||||||||||||||||
--Entries written by tools/autorelight/hook_michonne.py

RELIGHT_GenerateNewINI_SeasonM = function(number_configurationVersion)
    local data =
    {
        Version =
        {
            ConfigurationVersion = number_configurationVersion,
        },
"""

CONFIG_FOOTER = """    };

    return data;
end
"""


def hook(path, episode):
    text = path.read_text(encoding="utf-8")
    script = re.search(r'^local kScript = "([^"]+)"', text, re.M).group(1)
    scene = re.search(r'^local kScene = "([^"]+)"', text, re.M).group(1)
    config_key = f"Level_{episode}_{script}"
    if MARKER not in text:
        start = re.compile(rf"^function {re.escape(script)}\(\)", re.M)
        scene_open = re.compile(r"^SceneOpen\(kScene, kScript\)", re.M)
        if len(start.findall(text)) != 1 or len(scene_open.findall(text)) != 1:
            raise ValueError(f"{path.name}: unexpected layout")
        text = start.sub("local OriginalTelltaleLevelStartLogic = function()", text)
        text = re.sub(r'^(local kScene = "[^"]+"\n)', lambda m: m.group(1) + VARIABLES.format(config_key=config_key),
                      text, count=1, flags=re.M)
        text = scene_open.sub(lambda m: START_FUNCTION.format(script=script, episode=episode) + m.group(0), text)
        text = MARKER + "\n" + text
        path.write_text(text, encoding="utf-8", newline="\n")
    return config_key, f"RELIGHT_{episode}_{re.sub(r'.scene$', '', scene)}.lua"


def main():
    entries = []
    for folder in sorted(MOD.glob("WDC_pc_WalkingDeadM10*_data")):
        episode = folder.name.replace("WDC_pc_WalkingDead", "").replace("_data", "")
        for path in sorted(folder.glob("*.lua")):
            entries.append((episode, *hook(path, episode)))
    body = []
    current = None
    for episode, key, lua_file in entries:
        if episode != current:
            current = episode
            body.append(f"        --||||||||||||||||||||||||||||||||||||||| EPISODE {episode} |||||||||||||||||||||||||||||||||||||||")
        body.append(f'        {key} =\n        {{\n            RelightSceneLuaFile = RELIGHT_LevelsFolderName .. "/{lua_file}",\n        }},')
    SM_CONFIG.write_text(CONFIG_HEADER + "\n".join(body) + "\n" + CONFIG_FOOTER, encoding="utf-8", newline="\n")
    print(f"hooked {len(entries)} Michonne scripts, wrote {SM_CONFIG.name}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
