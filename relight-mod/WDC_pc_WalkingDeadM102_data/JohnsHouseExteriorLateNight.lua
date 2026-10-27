require("RELIGHT_Include.lua");
local kScript = "JohnsHouseExteriorLateNight"
local kScene = "adv_johnsHouseExteriorLateNight"

--Telltale Lua Script Extensions (TLSE) Development variables
TLSE_Development_SceneObject = kScene;
TLSE_Development_SceneObjectAgentName = kScene .. ".scene";
TLSE_Development_FreecamUseFOVScale = false;

--Relight variables
RELIGHT_SceneObject = kScene;
RELIGHT_SceneObjectAgentName = kScene .. ".scene";
RelightConfigLevel = RelightConfigData_SeasonM.Level_M102_JohnsHouseExteriorLateNight;
local OnLogicReady = function()
  if LogicGet("2JohnsHouseInteriorMain -  Randall") then
    Game_SetSceneDialog("env_johnsHouseExteriorLawn_randall.dlog")
    Print(" _Randall")
  elseif LogicGet("3JohnsHouseExteriorLawn -  Garage Fight") then
    Game_SetSceneDialog("env_johnsHouseExteriorLawn_garageFight.dlog")
    Print(" _Garage Fight")
  elseif LogicGet("2JohnsHouseExteriorLawn - Intruder") then
    Game_SetSceneDialog("env_johnsHouseExteriorLawn_intruders.dlog")
    Print(" _Intruder")
  else
    Game_SetSceneDialog("env_johnsHouseExterior_wall.dlog")
    Print(" _Wall")
  end
  WaitForNextFrame()
end
local OriginalTelltaleLevelStartLogic = function()
  Game_NewScene(kScene, kScript)
  SceneAdd("ui_struggle.scene")
  Game_StartScene(true)
end
Callback_OnLogicReady:Add(OnLogicReady)
--|||||||||||||||||||||||||||||||||||||||||||||||| LEVEL START FUNCTION ||||||||||||||||||||||||||||||||||||||||||||||||
--Main function called when the level starts: apply relight, then run the original Telltale logic.
JohnsHouseExteriorLateNight = function()
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
    TLSE_Development_GUI_RelightLuaExportNamePrefix = "M102_";
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
