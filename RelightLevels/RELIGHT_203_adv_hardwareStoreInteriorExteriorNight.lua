--AUTO-RELIGHT GENERATED FILE (tools/autorelight/generate.py). Scene: adv_hardwareStoreInteriorExteriorNight | class: interior/night
--Edit tools/autorelight/rules.py or data/scene_classes.csv and regenerate instead of editing this file.
--To hand-tune this scene, delete the first line of this file so the generator stops overwriting it.

--|||||||||||||||||||||||||||||||||||||||||||||||| SCENE CHANGES ||||||||||||||||||||||||||||||||||||||||||||||||
--Auto relight never deletes, duplicates or moves agents (that broke progression in 102 Motor Inn).
RELIGHT_DeleteAgentsInScene = function(string_scene) end
RELIGHT_DuplicateAgentsInScene = function(string_scene) end
RELIGHT_TransformAgentsInScene = function(string_scene) end

RELIGHT_ApplySceneSettings = function(agent_sceneAgent)
    AgentSetProperty(agent_sceneAgent, "FX anti-aliasing", true);
    AgentSetProperty(agent_sceneAgent, "FX TAA Weight", 0.1);
    AgentSetProperty(agent_sceneAgent, "FX Levels Enabled", true);
    AgentSetProperty(agent_sceneAgent, "FX Sharp Shadows Enabled", true);
    AgentSetProperty(agent_sceneAgent, "HBAO Enabled", true);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap Enabled", true);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap Type", 2);
    AgentSetProperty(agent_sceneAgent, "FX Vignette Tint Enabled", true);
    AgentSetProperty(agent_sceneAgent, "FX Vignette Tint", Color(0, 0, 0, 1));
    AgentSetProperty(agent_sceneAgent, "FX Levels White Point", 0.875);
    AgentSetProperty(agent_sceneAgent, "FX Bloom Threshold", -0.83);
    AgentSetProperty(agent_sceneAgent, "FX Bloom Intensity", 0.03);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap Intensity", 0);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap White Point", 31.25);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap Black Point", 0);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap Filmic Pivot", 0.05);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap Filmic Sign", 1);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap Filmic Shoulder Intensity", 1.19);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap Filmic Toe Intensity", 0.46);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap Far Filmic Pivot", 0.1);
    AgentSetProperty(agent_sceneAgent, "FX Vignette Falloff", 1.4);
    AgentSetProperty(agent_sceneAgent, "FX Vignette Center", 0);
    AgentSetProperty(agent_sceneAgent, "FX Vignette Corners", 0.99);
    AgentSetProperty(agent_sceneAgent, "HBAO Intensity", 2.22);
    AgentSetProperty(agent_sceneAgent, "HBAO Radius", 0.43);
    AgentSetProperty(agent_sceneAgent, "HBAO Max Radius Percent", 0.2);
    AgentSetProperty(agent_sceneAgent, "HBAO Hemisphere Bias", 0.05);
    AgentSetProperty(agent_sceneAgent, "LightEnv Shadow Light Bleed Reduction", 0.8);
end

--Fog stays as the original scene has it.
RELIGHT_ApplyEnvironmentFogSettings = function(string_scene) end

--Light candidates found in the .scene file, with their rule category. Only agents that are real
--environment lights (have "EnvLight - Intensity") are changed, and every change is relative to the original value.
local RELIGHT_AUTO_Lights =
{
    { "light_env_worklamps", "practical" },
    { "light_env_doorShutterYard", "sun" },
    { "light_env_worklampLargeGlow", "practical" },
    { "light_env_worklampLarge", "practical" },
    { "light_fx_muzzleFlashShotgun", "other" },
    { "light_fx_muzzleFlashShotgunFlash2", "other" },
    { "light_fx_muzzleFlashPistol", "other" },
    { "light_fx_muzzleFlashPistolFlash2", "other" },
    { "light_fx_muzzleFlashPistolFlash3", "other" },
    { "light_fx_muzzleFlashShotgunFlash3", "other" },
    { "light_fx_muzzleFlashPistolFlash", "other" },
    { "light_fx_muzzleFlashShotgunFlash", "other" },
    { "light_fx_fireFirePit", "fire" },
    { "light_fx_smokeFirePit", "fire" },
    { "light_env_worklamp_key", "practical" },
    { "light_ENV_A_01", "fill" },
    { "light_ENV_D", "sun" },
    { "light_ENV_A_02", "fill" },
    { "light_ENV_P_01", "fill" },
    { "light_ENV_S_03", "fill" },
    { "light_ENV_S_04", "fill" },
    { "light_ENV_P_02", "fill" },
    { "light_ENV_S_05", "fill" },
    { "light_ENV_S_06", "fill" },
    { "light_ENV_S_07", "fill" },
    { "light_ENV_P_03", "fill" },
    { "light_ENV_P_04", "fill" },
    { "light_ENV_S_08", "fill" },
    { "light_ENV_S_09", "fill" },
    { "light_ENV_S_10", "fill" },
    { "light_ENV_S_11", "fill" },
    { "light_ENV_S_12", "fill" },
    { "light_ENV_S_13", "fill" },
    { "light_ENV_P_05", "fill" },
    { "light_ENV_S_14", "fill" },
    { "light_ENV_S_15", "fill" },
    { "light_ENV_S_16", "fill" },
    { "light_ENV_S_17", "fill" },
    { "light_ENV_S_18", "fill" },
    { "light_ENV_S_19", "fill" },
    { "light_ENV_S_20", "fill" },
    { "light_ENV_S_21", "fill" },
    { "light_ENV_S_22", "fill" },
    { "light_ENV_S_23", "fill" },
    { "light_ENV_S_24", "fill" },
    { "light_ENV_S_25", "fill" },
    { "light_ENV_S_26", "fill" },
    { "light_ENV_P_06", "fill" },
    { "light_ENV_P_07", "fill" },
    { "light_ENV_P_08", "fill" },
    { "light_ENV_S_27", "fill" },
    { "light_ENV_S_28", "fill" },
    { "light_ENV_S_29", "fill" },
    { "light_ENV_S_30", "fill" },
    { "light_ENV_S_31", "fill" },
    { "light_worklamp", "practical" },
    { "light_point_worklamp", "practical" },
    { "light_point_worklamp01", "practical" },
    { "light_point_flashlight", "practical" },
    { "light_point_worklamp02", "practical" },
    { "light_point_flashlight01", "practical" },
    { "light_ENV_A_03", "fill" },
    { "light_ENV_P_09", "fill" },
    { "light_ENV_P_10", "fill" },
    { "light_ENV_P_11", "fill" },
    { "light_ENV_P_12", "fill" },
    { "light_ENV_P_13", "fill" },
    { "light_ENV_P_14", "fill" },
    { "light_ENV_P_15", "fill" },
    { "light_ENV_P_16", "fill" },
    { "light_ENV_P_17", "fill" },
    { "light_ENV_P_18", "fill" },
    { "light_ENV_P_19", "fill" },
    { "light_ENV_P_20", "fill" },
    { "light_ENV_S_workLight01", "fill" },
    { "light_ENV_P_21", "fill" },
    { "light_ENV_S_32", "fill" },
    { "light_ENV_S_33", "fill" },
};

local RELIGHT_AUTO_LightSettings =
{
    fire = { dimmer = 1.25, warm = 1.08, softness = 0.3 },
    practical = { dimmer = 1.15, warm = 1.03, softness = 0.5 },
    sun = { dimmer = 1.0, warm = 1.0, softness = 0.2 },
    fill = { dimmer = 0.85, warm = 1.0, softness = 0.6 },
    other = { dimmer = 1.0, warm = 1.0, softness = 0.5 },
};

RELIGHT_ApplyLightingSettings = function(string_scene)
    for _, entry in ipairs(RELIGHT_AUTO_Lights) do
        local agent_light = AgentFindInScene(entry[1], string_scene);

        if (agent_light ~= nil) and AgentHasProperty(agent_light, "EnvLight - Intensity") then
            local settings = RELIGHT_AUTO_LightSettings[entry[2]];

            local number_dimmer = AgentGetProperty(agent_light, "EnvLight - Intensity Dimmer");
            if number_dimmer ~= nil then
                AgentSetProperty(agent_light, "EnvLight - Intensity Dimmer", number_dimmer * settings.dimmer);
            end

            local color_light = AgentGetProperty(agent_light, "EnvLight - Color");
            if (color_light ~= nil) and (settings.warm ~= 1.0) then
                AgentSetProperty(agent_light, "EnvLight - Color", Color(math.min(color_light.r * settings.warm, 1), color_light.g, color_light.b / settings.warm, color_light.a));
            end

            local number_shadowType = AgentGetProperty(agent_light, "EnvLight - Shadow Type");
            if (number_shadowType ~= nil) and (number_shadowType ~= 0) then
                AgentSetProperty(agent_light, "EnvLight - Shadow Softness", settings.softness);
            end
        end
    end
end

--|||||||||||||||||||||||||||||||||||||||||||||||| ADDITIONAL LOGIC ||||||||||||||||||||||||||||||||||||||||||||||||
--Relight Depth of Field Autofocus
RELIGHT_DOF_AUTOFOCUS_UseCameraDOF = true;
RELIGHT_DOF_AUTOFOCUS_UseLegacyDOF = false;
RELIGHT_DOF_AUTOFOCUS_FocalRange = 0.125;
RELIGHT_DOF_AUTOFOCUS_Aperture = 2.0;
RELIGHT_DOF_AUTOFOCUS_GameplayCameraNames =
{
  "Null"
};
RELIGHT_DOF_AUTOFOCUS_ObjectEntries =
{
    "Clementine",
    "Kenny",
    "Nick",
    "Carlos",
    "Sarah",
    "Rebecca",
    "Alvin",
    "Sarita",
    "Bonnie",
    "Mike",
    "Jane",
    "Carver",
    "Troy",
    "Reggie",
};
RELIGHT_DOF_AUTOFOCUS_Settings =
{
    TargetValidation_IsOnScreen = true,
    TargetValidation_IsVisible = true,
    TargetValidation_IsWithinDistance = true,
    TargetValidation_IsFacingCamera = true,
    TargetValidation_RejectionAngle = -0.1,
    TargetValidation_RejectionDistance = 18.5,
};
RELIGHT_DOF_AUTOFOCUS_BokehSettings =
{
    BokehBrightnessDeltaThreshold = 0.05,
    BokehBrightnessThreshold = 0.05,
    BokehBlurThreshold = 0.05,
    BokehMaxSizeClamp = 0.05,
    BokehFalloff = 0.75,
    MaxBokehBufferAmount = 1.0,
};

--Relight Volumetrics
RELIGHT_HackyCameraVolumetrics_Settings =
{
    Samples = 256,
    SampleOffset = 0.05,
    SampleStartOffset = 1.0,
    FogColor = Color(0.03, 0.03, 0.035, 0.03)
};

--|||||||||||||||||||||||||||||||||||||||||||||||| RELIGHT SCENE CONFIGURATION INI ||||||||||||||||||||||||||||||||||||||||||||||||
RELIGHT_ConfigFileName_LevelPreset = RELIGHT_LevelsFolderName .. "/RELIGHT_203_adv_hardwareStoreInteriorExteriorNight.ini";
RelightConfigData_LevelPreset = nil;
local RELIGHT_ForceRebuildINI = false;

local RELIGHT_GenerateNewINI_LevelPreset = function(number_configurationVersion)
    local data =
    {
        Version =
        {
            ConfigurationVersion = number_configurationVersion,
        },
        Main =
        {
            EnableRelighting = true,
            EnableDepthOfField = true,
            EnableVolumetricLighting = false,
            ExposureOffset = 0.0,
            DepthOfFieldAperture = 2.0,
        },
    };

    return data;
end

do --DONT TOUCH THIS CHUNK OF CODE (UNLESS YOU KNOW WHAT YOU ARE DOING)
    if TLSE_FileExists(RELIGHT_ConfigFileName_LevelPreset) == false then
        TLSE_INI_SaveINIFile(RELIGHT_ConfigFileName_LevelPreset, RELIGHT_GenerateNewINI_LevelPreset(RELIGHT_CurrentConfigurationVersion));
    end

    RelightConfigData_LevelPreset = TLSE_INI_LoadINIFile(RELIGHT_ConfigFileName_LevelPreset);

    if (not (RelightConfigData_LevelPreset["Version"]["ConfigurationVersion"] == RELIGHT_CurrentConfigurationVersion)) or (RELIGHT_ForceRebuildINI == true) then
        TLSE_INI_SaveINIFile(RELIGHT_ConfigFileName_LevelPreset, RELIGHT_GenerateNewINI_LevelPreset(RELIGHT_CurrentConfigurationVersion));
        RelightConfigData_LevelPreset = TLSE_INI_LoadINIFile(RELIGHT_ConfigFileName_LevelPreset);
    end
end

--|||||||||||||||||||||||||||||||||||||||||||||||| RELIGHT SCENE MAIN ||||||||||||||||||||||||||||||||||||||||||||||||
--(DO NOT CHANGE FUNCTION NAME OR ADD PARAMETERS) Called at the start of the level by the relight backend.
RELIGHT_SceneStart = function()
    if(RelightConfigData_LevelPreset["Main"]["EnableRelighting"] == true) then
        RELIGHT_ApplySceneSettings(RELIGHT_SceneObjectAgentName);
        RELIGHT_ApplyEnvironmentFogSettings(RELIGHT_SceneObject);
        RELIGHT_ApplyLightingSettings(RELIGHT_SceneObject);
    end

    if(RelightConfigData_LevelPreset["Main"]["EnableDepthOfField"]) then
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_main");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_main_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_mainB");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_mainB_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_YardStationB");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_YardStationA");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_mainB_Longitude_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_yardMain");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_yardMain_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_yardMain_grandparent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_yardThreeCamSplitFirst");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_yardThreeCamSplitFirst_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_yardThreeCamSplitSecond");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_yardThreeCamSplitSecond_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_yardThreeCamSplitThird");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_yardThreeCamSplitThird_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_ladder");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_ladder_parent");
        for _, string_name in ipairs(RELIGHT_DOF_AUTOFOCUS_ObjectEntries) do
            RELIGHT_DepthOfField_AddFocusTarget(string_name);
        end
        RELIGHT_DepthOfField_Setup();

        RELIGHT_DOF_AUTOFOCUS_Aperture = RelightConfigData_LevelPreset["Main"]["DepthOfFieldAperture"];
    end

    if(RelightConfigData_LevelPreset["Main"]["EnableVolumetricLighting"]) then
        RELIGHT_HackyCameraVolumetrics_Initalize();
    end

    TLSE_SetPropertyOnAllCameras(RELIGHT_SceneObject, "Exposure", RelightConfigData_LevelPreset["Main"]["ExposureOffset"]);
end

--(DO NOT CHANGE FUNCTION NAME OR ADD PARAMETERS) Called every frame after the start of the level.
RELIGHT_SceneUpdate = function()
    if(RelightConfigData_LevelPreset["Main"]["EnableDepthOfField"]) then
        RELIGHT_DepthOfField_Update();
    end

    if(RelightConfigData_LevelPreset["Main"]["EnableVolumetricLighting"]) then
        RELIGHT_HackyCameraVolumetrics_Update();
    end
end
