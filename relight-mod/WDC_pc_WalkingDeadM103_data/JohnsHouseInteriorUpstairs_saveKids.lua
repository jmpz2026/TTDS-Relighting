require("RELIGHT_Include.lua");
local kScript = "JohnsHouseInteriorUpstairs_SaveKids"
local kScene = "adv_johnsHouseInteriorUpstairsFire103"

--Telltale Lua Script Extensions (TLSE) Development variables
TLSE_Development_SceneObject = kScene;
TLSE_Development_SceneObjectAgentName = kScene .. ".scene";
TLSE_Development_FreecamUseFOVScale = false;

--Relight variables
RELIGHT_SceneObject = kScene;
RELIGHT_SceneObjectAgentName = kScene .. ".scene";
RelightConfigLevel = RelightConfigData_SeasonM.Level_M103_JohnsHouseInteriorUpstairs_SaveKids;
local OnLogicReady = function()
  Game_SetSceneDialog("env_johnsHouseInteriorUpstairs_saveKids.dlog")
end
local OriginalTelltaleLevelStartLogic = function()
  Game_NewScene(kScene, kScript)
  Game_StartScene(true)
end
--|||||||||||||||||||||||||||||||||||||||||||||||| LEVEL START FUNCTION ||||||||||||||||||||||||||||||||||||||||||||||||
--Main function called when the level starts: apply relight, then run the original Telltale logic.
JohnsHouseInteriorUpstairs_SaveKids = function()
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
    TLSE_Development_GUI_RelightLuaExportNamePrefix = "M103_";
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

SceneOpen(kScene, kScript)
Callback_OnLogicReady:Add(OnLogicReady)
