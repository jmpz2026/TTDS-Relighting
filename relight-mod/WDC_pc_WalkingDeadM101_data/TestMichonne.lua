require("RELIGHT_Include.lua");
local kScript = "TestMichonne"
local kScene = "adv_michonneZombiePets"

--Telltale Lua Script Extensions (TLSE) Development variables
TLSE_Development_SceneObject = kScene;
TLSE_Development_SceneObjectAgentName = kScene .. ".scene";
TLSE_Development_FreecamUseFOVScale = false;

--Relight variables
RELIGHT_SceneObject = kScene;
RELIGHT_SceneObjectAgentName = kScene .. ".scene";
RelightConfigLevel = RelightConfigData_SeasonM.Level_M101_TestMichonne;
local mbMichonneFreeWalk = true
local mbMoving = false
local controllerWalk1, controllerWalk2, controllerIdle1, controllerIdle2
local mbMovePlaying = false
local mbIdlePlaying = false
local mbPathingZ1 = false
local mbPathingZ2 = false
local mMoveTime = 0
local TestMichonne_SetPosition = function()
  AgentSetPos("ZombiePetMale", AgentGetWorldPos("dummy_target1"))
  AgentSetPos("ZombiePetFemale", AgentGetWorldPos("dummy_target2"))
  AgentSetPosY("ZombiePetMale", 0)
  AgentSetPosY("ZombiePetFemale", 0)
end
function TestMichonne_UpdateLoop()
  TestMichonne_SetPosition()
  while mbMichonneFreeWalk do
    TestMichonne_SetPosition()
    Yield()
  end
end
local mbStartedThread = false
local mbIsPathing = false
function TestMichonne_ZombiesFollowThread()
  mbStartedThread = true
  while mbStartedThread do
    local michonnePos = AgentGetPos("Michonne")
    local zom1Pos = AgentGetPos("ZombiePetMale")
    local zom2Pos = AgentGetPos("ZombiePetFemale")
    local distance1 = VectorDistance(michonnePos, zom1Pos)
    local distance2 = VectorDistance(michonnePos, zom2Pos)
    if distance1 > 3 then
      AgentSetProperty("ZombiePetMale", "Walk Speed Scale", 0.7)
    else
      AgentSetProperty("ZombiePetMale", "Walk Speed Scale", 0.25)
    end
    if distance2 > 3 then
      AgentSetProperty("ZombiePetFemale", "Walk Speed Scale", 0.7)
    else
      AgentSetProperty("ZombiePetFemale", "Walk Speed Scale", 0.25)
    end
    if distance1 > 2 then
      mbPathingZ1 = true
      AgentPathToAgent("ZombiePetMale", "dummy_target1", false)
      Yield()
    else
      if mbPathingZ1 then
        PathAgentStop("ZombiePetMale")
        mbPathingZ1 = false
      end
      local michonneWorldPos = AgentGetWorldPos("Michonne")
      AgentTurnTowards("ZombiePetMale", 95, michonneWorldPos)
      AgentTurnTowards("ZombiePetFemale", 95, michonneWorldPos)
    end
    if distance2 > 2 then
      mbPathingZ2 = true
      AgentPathToAgent("ZombiePetFemale", "dummy_target2", false)
      Yield()
    else
      if mbPathingZ2 then
        PathAgentStop("ZombiePetFemale")
        mbIsPathing = false
      end
      local michonneWorldPos = AgentGetWorldPos("Michonne")
      AgentTurnTowards("ZombiePetMale", 95, michonneWorldPos)
      AgentTurnTowards("ZombiePetFemale", 95, michonneWorldPos)
    end
    Yield()
  end
end
local OriginalTelltaleLevelStartLogic = function()
  Game_NewScene(kScene, kScript)
  Navigate_Enable(true)
  Game_StartScene(true)
  DirectControl_SetConstrained(true, "left")
  ThreadStart(TestMichonne_ZombiesFollowThread)
end
--|||||||||||||||||||||||||||||||||||||||||||||||| LEVEL START FUNCTION ||||||||||||||||||||||||||||||||||||||||||||||||
--Main function called when the level starts: apply relight, then run the original Telltale logic.
TestMichonne = function()
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
    TLSE_Development_GUI_RelightLuaExportNamePrefix = "M101_";
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
