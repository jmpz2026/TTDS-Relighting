require("RELIGHT_Include.lua");
local kScript = "FlagshipExteriorEscape"
local kScene = "adv_boatTownShoreLineView"

--Telltale Lua Script Extensions (TLSE) Development variables
TLSE_Development_SceneObject = kScene;
TLSE_Development_SceneObjectAgentName = kScene .. ".scene";
TLSE_Development_FreecamUseFOVScale = false;

--Relight variables
RELIGHT_SceneObject = kScene;
RELIGHT_SceneObjectAgentName = kScene .. ".scene";
RelightConfigLevel = RelightConfigData_SeasonM.Level_M102_FlagshipExteriorEscape;
local bTimerRunning = false
local bTimerController = null
local shouldAddCredits = function()
  return false
end
function FlagshipExterior_StartTimer()
  if bTimerController then
    return
  end
  bTimerRunning = true
  bTimerController = ChorePlay("env_flagshipExterior_escape_logic_onPeekUp_scopeOut_1.chore")
  ControllerSetScene(bTimerController, kScene)
  while bTimerRunning do
    WaitForNextFrame()
    if bTimerController and not ControllerIsPlaying(bTimerController) then
      Game_RunDialog("fail_scopeOutSituation")
      bTimerRunning = false
    end
  end
  ControllerKill(bTimerController)
  bTimerController = null
end
function FlagshipExterior_StopTimer()
  bTimerRunning = false
end
function FlagshipExterior_DialogLineWait()
  while Subtitle_GetCurrentID() ~= -1 do
    Yield()
  end
end
local OriginalTelltaleLevelStartLogic = function()
  Game_NewScene(kScene, kScript)
  AgentHide("Pete", false)
  if shouldAddCredits() then
    SceneAdd("adv_openingCredits102.scene")
  end
  SceneAdd("ui_struggle.scene")
  if LogicGet("3FlagShipExterior - Beat Norma And Randall") then
    Game_SetSceneDialogNode("cs_untiePete")
    WaitForNextFrame()
  end
  if shouldAddCredits() then
    while not SceneIsActive("adv_openingCredits102.scene") do
      WaitForNextFrame()
    end
  end
  SceneHide("adv_openingCredits102.scene", true)
  Game_StartScene(true)
end
--|||||||||||||||||||||||||||||||||||||||||||||||| LEVEL START FUNCTION ||||||||||||||||||||||||||||||||||||||||||||||||
--Main function called when the level starts: apply relight, then run the original Telltale logic.
FlagshipExteriorEscape = function()
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
