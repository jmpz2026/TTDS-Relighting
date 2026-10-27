require("RELIGHT_Include.lua");
local kScript = "JohnsHouseExteriorLawn_Negotiate"
local kScene = "adv_johnsHouseExteriorLawn103"

--Telltale Lua Script Extensions (TLSE) Development variables
TLSE_Development_SceneObject = kScene;
TLSE_Development_SceneObjectAgentName = kScene .. ".scene";
TLSE_Development_FreecamUseFOVScale = false;

--Relight variables
RELIGHT_SceneObject = kScene;
RELIGHT_SceneObjectAgentName = kScene .. ".scene";
RelightConfigLevel = RelightConfigData_SeasonM.Level_M103_JohnsHouseExteriorLawn_Negotiate;
local mKeepJonasDeadController, mKeepGabbyDeadController, mGateSoundThread, mGateSoundController
local SceneInit = function()
  if LogicGet("2JohnsHouseExteriorRetreat - Begun Retreat") then
    Game_SetSceneDialog("env_johnsHouseExterior_retreat.dlog")
  else
    Game_SetSceneDialog("env_johnsHouseExterior_negotiate.dlog")
  end
end
local JohnsHouseExteriorLawn_Negotiate_GateSoundThread = function()
  while true do
    local theDir = ChoredMovement_GetMoveDir()
    if theDir == 0 then
      if mGateSoundController and not ControllerIsPaused(mGateSoundController) then
        ControllerPause(mGateSoundController)
      end
    elseif not mGateSoundController then
      mGateSoundController = SoundPlayEventByName("/103/103 SFX/07_johnsHouseExterior_negotiate/sfx_gate_metal_open_long")
    elseif ControllerIsPaused(mGateSoundController) then
      ControllerPlay(mGateSoundController)
    end
    WaitForNextFrame()
  end
end
function JohnsHouseExteriorLawn_Negotiate_KeepJonasDead()
  mKeepJonasDeadController = ChorePlay("adv_johnsHouseExterior103_jonasDead.chore", 99999)
  ControllerSetLooping(mKeepJonasDeadController, true)
  AgentHide("obj_gunGlock_jonas", true)
end
function JohnsHouseExteriorLawn_Negotiate_KeepGabbyDead()
  mKeepGabbyDeadController = ChorePlay("adv_johnsHouseExterior103_gabbyDead.chore", 99999)
  ControllerSetLooping(mKeepGabbyDeadController, true)
  AgentHide("obj_rifleSniperGabby", true)
end
function JohnsHouseExteriorLawn_Negotiate_GatePushSound()
  mGateSoundThread = ThreadStart(JohnsHouseExteriorLawn_Negotiate_GateSoundThread)
end
function JohnsHouseExteriorLawn_Negotiate_KillGatePushSoundThread()
  ThreadKill(mGateSoundThread)
end
local OriginalTelltaleLevelStartLogic = function()
  Game_NewScene(kScene, kScript, SceneInit)
  Game_StartScene(true)
end
--|||||||||||||||||||||||||||||||||||||||||||||||| LEVEL START FUNCTION ||||||||||||||||||||||||||||||||||||||||||||||||
--Main function called when the level starts: apply relight, then run the original Telltale logic.
JohnsHouseExteriorLawn_Negotiate = function()
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
