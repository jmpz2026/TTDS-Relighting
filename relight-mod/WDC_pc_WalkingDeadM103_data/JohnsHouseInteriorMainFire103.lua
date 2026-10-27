require("RELIGHT_Include.lua");
local kScript = "JohnsHouseInteriorMainFire103"
local kScene = "adv_johnsHouseInteriorMainFire103"

--Telltale Lua Script Extensions (TLSE) Development variables
TLSE_Development_SceneObject = kScene;
TLSE_Development_SceneObjectAgentName = kScene .. ".scene";
TLSE_Development_FreecamUseFOVScale = false;

--Relight variables
RELIGHT_SceneObject = kScene;
RELIGHT_SceneObjectAgentName = kScene .. ".scene";
RelightConfigLevel = RelightConfigData_SeasonM.Level_M103_JohnsHouseInteriorMainFire103;
local mDeathNode = ""
local mbStartedTimer = false
local mbMoving = false
local mDeadStickWatchThread, mDeadStickChoreTimer
local kDeadStickChore = "env_johnsHouseInteriorMain103_molotov_script_doBackgroundTimer_1.chore"
local mClockSoundThread, mClockSoundController
local JohnHouse_ClockSoundThread = function()
  while true do
    local theDir = ChoredMovement_GetMoveDir()
    if theDir == 0 then
      if mClockSoundController and not ControllerIsPaused(mClockSoundController) then
        ControllerPause(mClockSoundController)
      end
    elseif not mClockSoundController then
      mClockSoundController = SoundPlayEventByName("/103/103 SFX/09_johnsHouseInteriorMain103_molotov/SFX_Clock_Move_long")
    elseif ControllerIsPaused(mClockSoundController) then
      ControllerPlay(mClockSoundController)
    end
    WaitForNextFrame()
  end
end
local JohnHouse_DeadStickWatch = function()
  local bRunWatch = true
  while bRunWatch do
    local theDir = ChoredMovement_GetMoveDir()
    if theDir == 0 then
      mbMoving = false
      if not mbStartedTimer then
        ControllerKill(mDeadStickChoreTimer)
        WaitForNextFrame()
        mbStartedTimer = true
        mDeadStickChoreTimer = ChorePlay(kDeadStickChore)
      end
    else
      if mDeadStickChoreTimer then
        mbStartedTimer = false
        ControllerKill(mDeadStickChoreTimer)
        mDeadStickChoreTimer = nil
      end
      if 0 < AgentGetProperty("logic_panicMeter", "Panic Meter - Timer") then
        local pMeter = AgentGetProperty("logic_panicMeter", "Panic Meter - Timer")
        pMeter = pMeter - 0.1
        AgentSetProperty("logic_panicMeter", "Panic Meter - Timer", pMeter)
      end
    end
    WaitForNextFrame()
    if not mbMoving and mbStartedTimer and not ControllerIsPaused(mDeadStickChoreTimer) and not ControllerIsPlaying(mDeadStickChoreTimer) then
      DlgRun("env_johnsHouseInteriorMain103_molotov.dlog", mDeathNode)
      bRunWatch = false
    end
    WaitForNextFrame()
  end
end
function JohnsHouseInteriorMainFire103_PauseDeadStickWatch()
  ControllerPause(mDeadStickChoreTimer)
end
function JohnsHouseInteriorMainFire103_UnpauseDeadStickWatch()
  ControllerPlay(mDeadStickChoreTimer)
end
function JohnsHouseInteriorMainFire103_ChoredMovement_DeadStickWatch(theDeathNode)
  AgentSetProperty("logic_panicMeter", "Panic Meter - Enabled", true)
  mDeadStickWatchThread = ThreadStart(JohnHouse_DeadStickWatch)
  mDeathNode = theDeathNode
  SceneAdd("ui_panicMeter.scene")
  WaitForNextFrame()
  AgentHide("ui_panicMeter_vignette", false)
end
function JohnsHouseInteriorMainFire103_ChoredMovement_End_DeadStickWatch()
  AgentSetProperty("logic_panicMeter", "Panic Meter - Enabled", false)
  AgentSetProperty("logic_panicMeter", "Panic Meter - Timer", 0)
  mbStartedTimer = false
  mbMoving = false
  ThreadKill(mDeadStickWatchThread)
  ControllerKill(mDeadStickChoreTimer)
end
function JohnsHouseInteriorMainFire103_ClockSoundPush()
  mClockSoundThread = ThreadStart(JohnHouse_ClockSoundThread)
end
function JohnsHouseInteriorMainFire103_KillClockSoundThread()
  ThreadKill(mClockSoundThread)
end
local OriginalTelltaleLevelStartLogic = function()
  Game_NewScene(kScene, kScript)
  Game_StartScene(true)
end
--|||||||||||||||||||||||||||||||||||||||||||||||| LEVEL START FUNCTION ||||||||||||||||||||||||||||||||||||||||||||||||
--Main function called when the level starts: apply relight, then run the original Telltale logic.
JohnsHouseInteriorMainFire103 = function()
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
