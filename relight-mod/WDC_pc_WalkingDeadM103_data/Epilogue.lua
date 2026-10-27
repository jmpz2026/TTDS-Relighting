require("RELIGHT_Include.lua");
require("Menu_EndEpisode.lua")
local kScript = "Epilogue"
local kScene = "adv_shorelineDock"

--Telltale Lua Script Extensions (TLSE) Development variables
TLSE_Development_SceneObject = kScene;
TLSE_Development_SceneObjectAgentName = kScene .. ".scene";
TLSE_Development_FreecamUseFOVScale = false;

--Relight variables
RELIGHT_SceneObject = kScene;
RELIGHT_SceneObjectAgentName = kScene .. ".scene";
RelightConfigLevel = RelightConfigData_SeasonM.Level_M103_Epilogue;
local kEndEpisodeScene = "ui_menuEndOfEpisode.scene"
local kCreditsScene = "ui_credits.scene"
local kStatsScene = IsPlatformSmallScreen() and "ui_statsBig.scene" or "ui_stats.scene"
local OriginalTelltaleLevelStartLogic = function()
  MenuUtils_AddScene(kEndEpisodeScene)
  AgentHide("cam_ui_menuEndOfEpisode", true)
  AgentHide("ui_menuEndOfEpisode_background", true)
  AgentHide("ui_menuEndOfEpisode_backgroundOverlay", true)
  AgentHide("ui_menuEndOfEpisode_fillForeground", true)
  MenuUtils_AddScene(kCreditsScene)
  SceneHide(kCreditsScene, true)
  MenuUtils_AddScene(kStatsScene)
  SceneHide(kStatsScene, true)
  Game_NewScene(kScene, kScript)
  Navigate_Enable(false)
  Game_StartScene(true)
end
function Epilogue_EndEpisode()
  AgentHide("cam_ui_menuEndOfEpisode", false)
  AgentHide("ui_menuEndOfEpisode_background", false)
  AgentHide("ui_menuEndOfEpisode_backgroundOverlay", false)
  AgentHide("ui_menuEndOfEpisode_fillForeground", false)
  WDAchievements_Unlock("achievement_19")
  Menu_EndEpisode("WalkingDeadM103")
  Game_EndEpisode("MenuSeasonM", "Menu_Main")
end
--|||||||||||||||||||||||||||||||||||||||||||||||| LEVEL START FUNCTION ||||||||||||||||||||||||||||||||||||||||||||||||
--Main function called when the level starts: apply relight, then run the original Telltale logic.
Epilogue = function()
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
