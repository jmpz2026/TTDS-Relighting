require("RELIGHT_Include.lua");
local kScript = "ShorelineApproachWoods"
local kScene = "adv_shorelineApproachWoods"

--Telltale Lua Script Extensions (TLSE) Development variables
TLSE_Development_SceneObject = kScene;
TLSE_Development_SceneObjectAgentName = kScene .. ".scene";
TLSE_Development_FreecamUseFOVScale = false;

--Relight variables
RELIGHT_SceneObject = kScene;
RELIGHT_SceneObjectAgentName = kScene .. ".scene";
RelightConfigLevel = RelightConfigData_SeasonM.Level_M102_ShorelineApproachWoods;
local OnLogicReady = function()
  if LogicGet("1ShorelineApproachWoods - Skip to Ferry") then
    Game_SetSceneDialog("env_shorelineApproachWoods.dlog")
    RenderDelay(1)
    WaitForNextFrame()
  end
end
function isZombie(agent)
  return AgentIsParentProperty(agent, "sk54_zombieAverageMini.prop") or AgentIsParentProperty(agent, "sk55_zombieAverageMini.prop") or AgentIsParentProperty(agent, "sk54_zombieAverageMiniLow.prop") or AgentIsParentProperty(agent, "sk55_zombieAverageMiniLow.prop")
end
function ShorelineApproachWoods_ZombieBumpFemale(agent, trigger)
  if isZombie(agent) then
    PlayAnimation("ZombiePetFemale", "sk54_zombieStandA_leftShoulderBump_add.anm")
    PlayAnimation(agent, "sk54_zombieStandA_rightShoulderBump_add.anm")
  end
end
function ShorelineApproachWoods_ZombieBumpMale(agent, trigger)
  if isZombie(agent) then
    PlayAnimation("ZombiePetFemale", "sk54_zombieStandA_rightShoulderBump_add.anm")
    PlayAnimation(agent, "sk54_zombieStandA_leftShoulderBump_add.anm")
  end
end
local OriginalTelltaleLevelStartLogic = function()
  Game_NewScene(kScene, kScript)
  SceneAdd("ui_struggle.scene")
  Game_StartScene(true)
end
Callback_OnLogicReady:Add(OnLogicReady)
--|||||||||||||||||||||||||||||||||||||||||||||||| LEVEL START FUNCTION ||||||||||||||||||||||||||||||||||||||||||||||||
--Main function called when the level starts: apply relight, then run the original Telltale logic.
ShorelineApproachWoods = function()
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
