require("RELIGHT_Include.lua");
local kScript = "FlagshipInteriorEscape"
local kScene = "adv_flagshipInterior"

--Telltale Lua Script Extensions (TLSE) Development variables
TLSE_Development_SceneObject = kScene;
TLSE_Development_SceneObjectAgentName = kScene .. ".scene";
TLSE_Development_FreecamUseFOVScale = false;

--Relight variables
RELIGHT_SceneObject = kScene;
RELIGHT_SceneObjectAgentName = kScene .. ".scene";
RelightConfigLevel = RelightConfigData_SeasonM.Level_M102_FlagshipInteriorEscape;
local OnLogicReady = function()
  Game_SetSceneDialog("env_flagshipInterior_escape_102.dlog")
end
local OriginalTelltaleLevelStartLogic = function()
  Game_NewScene(kScene, kScript)
  if LogicGet("Episode 101 - Zach is Dead") then
    ShaderOverrideTexture("Zachary", "sk54_zachary_head.d3dtx", "sk54_zachary_headGunshot.d3dtx")
    ShaderOverrideTexture("Samantha", "sk55_samantha_BodyUpper.d3dtx", "sk55_samantha_bodyUpperGregSplatter.d3dtx")
    ShaderOverrideTexture("Samantha", "sk55_samantha_head.d3dtx", "sk55_samantha_headGregSplatter.d3dtx")
  elseif LogicGet("Episode 101 - Punched Zach") then
    ShaderOverrideTexture("Zachary", "sk54_zachary_head.d3dtx", "sk54_zachary_headBruised.d3dtx")
  end
  AgentSetProperty("Greg", "Mesh sk54_greg_head - Visible", false)
  AgentSetProperty("Greg", "Mesh sk54_greg_eyesMouth - Visible", false)
  AgentSetProperty("Greg", "Mesh sk54_greg_bodyUpper - Visible", false)
  AgentSetProperty("Greg", "Mesh sk54_greg_bodyUpperZombie - Visible", true)
  ShaderOverrideTexture("Greg", "sk54_greg_bodyUpperZombie.d3dtx", "sk54_gregZombie_bodyUpperZombieBrained.d3dtx")
  if LogicGet("Episode 101 - Weapon") == "screwdriver" then
    AgentSetProperty("Greg", "Mesh sk54_greg_headZombieScrewdriver - Visible", true)
    local punchCount = LogicGet("Episode 101 - Greg Punch Count")
    if punchCount == "one" then
      ShaderOverrideTexture("Greg", "sk54_greg_headZombieScrewdriver.d3dtx", "sk54_greg_headZombieScrewdriverBeatenPunchB.d3dtx")
    elseif punchCount == "two" then
      ShaderOverrideTexture("Greg", "sk54_greg_headZombieScrewdriver.d3dtx", "sk54_greg_headZombieScrewdriverBeatenPunchC.d3dtx")
    else
      ShaderOverrideTexture("Greg", "sk54_greg_headZombieScrewdriver.d3dtx", "sk54_greg_headZombieScrewdriverBeatenPunchA.d3dtx")
    end
  else
    AgentSetProperty("Greg", "Mesh sk54_greg_headZombieDamagedB - Visible", true)
  end
  Game_StartScene(true)
end
Callback_OnLogicReady:Add(OnLogicReady)
--|||||||||||||||||||||||||||||||||||||||||||||||| LEVEL START FUNCTION ||||||||||||||||||||||||||||||||||||||||||||||||
--Main function called when the level starts: apply relight, then run the original Telltale logic.
FlagshipInteriorEscape = function()
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
