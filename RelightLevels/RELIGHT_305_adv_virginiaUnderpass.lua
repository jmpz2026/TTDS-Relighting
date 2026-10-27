--AUTO-RELIGHT GENERATED FILE (tools/autorelight/generate.py). Scene: adv_virginiaUnderpass | class: exterior/day
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
    AgentSetProperty(agent_sceneAgent, "FX Levels White Point", 0.67);
    AgentSetProperty(agent_sceneAgent, "FX Bloom Threshold", -0.19);
    AgentSetProperty(agent_sceneAgent, "FX Bloom Intensity", 0.18);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap Intensity", 9.28);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap White Point", 126.36);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap Black Point", -0.21);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap Filmic Pivot", 0.02);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap Filmic Sign", 0.14);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap Filmic Shoulder Intensity", 1.11);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap Filmic Toe Intensity", 0.53);
    AgentSetProperty(agent_sceneAgent, "FX Tonemap Far Filmic Pivot", 0.59);
    AgentSetProperty(agent_sceneAgent, "FX Vignette Falloff", 0.85);
    AgentSetProperty(agent_sceneAgent, "FX Vignette Center", -0.13);
    AgentSetProperty(agent_sceneAgent, "FX Vignette Corners", 1.03);
    AgentSetProperty(agent_sceneAgent, "HBAO Intensity", 1.92);
    AgentSetProperty(agent_sceneAgent, "HBAO Radius", 2);
    AgentSetProperty(agent_sceneAgent, "HBAO Max Radius Percent", 0.11);
    AgentSetProperty(agent_sceneAgent, "HBAO Hemisphere Bias", 0.04);
    AgentSetProperty(agent_sceneAgent, "LightEnv Shadow Light Bleed Reduction", 0.84);
end

--Fog stays as the original scene has it.
RELIGHT_ApplyEnvironmentFogSettings = function(string_scene) end

--Light candidates found in the .scene file, with their rule category. Only agents that are real
--environment lights (have "EnvLight - Intensity") are changed, and every change is relative to the original value.
local RELIGHT_AUTO_Lights =
{
    { "light_env_sun", "sun" },
    { "light_env_sun_amb", "sun" },
    { "light_fx_muzzleFlashClem", "other" },
    { "light_ENV_skyAmbient", "sun" },
    { "light_ENV_skyPoint", "sun" },
    { "light_ENV_skyPoint01", "sun" },
    { "light_ENV_skyPoint02", "sun" },
    { "light_ENV_skyPoint03", "sun" },
    { "light_ENV_skyPoint04", "sun" },
    { "light_ENV_skyPoint05", "sun" },
    { "light_ENV_ambient", "fill" },
    { "light_alt_amb_forest", "other" },
    { "light_alt_pnt_trees1", "other" },
    { "light_alt_pnt_trees2", "other" },
    { "light_alt_pnt_trees3", "other" },
    { "light_alt_pnt_trees4", "other" },
    { "light_alt_pnt_trees5", "other" },
    { "light_alt_pnt_trees6", "other" },
    { "light_alt_pnt_trees7", "other" },
    { "light_alt_pnt_trees8", "other" },
    { "light_env_pnt_treetops1", "fill" },
    { "light_env_spt_sunStrikes_1", "sun" },
    { "light_env_spt_sunStrikes_6", "sun" },
    { "light_env_spt_sunStrikes_7", "sun" },
    { "light_env_spt_sunStrikes_8", "sun" },
    { "light_alt_pnt_trees9", "other" },
    { "light_alt_pnt_trees10", "other" },
    { "light_alt_pnt_trees11", "other" },
    { "light_alt_pnt_trees12", "other" },
    { "light_alt_pnt_trees13", "other" },
    { "light_alt_pnt_trees14", "other" },
    { "light_alt_pnt_trees15", "other" },
    { "light_alt_pnt_trees16", "other" },
    { "light_alt_pnt_road1", "other" },
    { "light_alt_pnt_road2", "other" },
    { "light_alt_pnt_road3", "other" },
    { "light_env_spt_sunStrikes_2", "sun" },
    { "light_env_spt_sunStrikes_3", "sun" },
    { "light_env_spt_sunStrikes_9", "sun" },
    { "light_env_spt_sunStrikes_10", "sun" },
    { "light_env_spt_sunStrikes_11", "sun" },
    { "light_env_spt_sunStrikes_12", "sun" },
    { "light_env_spt_sunStrikes_13", "sun" },
    { "light_env_spt_sunStrikes_14", "sun" },
    { "light_env_spt_sunStrikes_15", "sun" },
    { "light_env_spt_sunStrikes_16", "sun" },
    { "light_env_spt_sunStrikes_17", "sun" },
    { "light_env_spt_sunStrikes_19", "sun" },
    { "light_env_spt_sunStrikes_20", "sun" },
    { "light_env_spt_sunStrikes_21", "sun" },
    { "light_env_spt_sunStrikes_23", "sun" },
    { "light_env_spt_sunStrikes_24", "sun" },
    { "light_env_grass_fill", "fill" },
    { "light_env_grass_fill01", "fill" },
    { "light_env_grass_fill02", "fill" },
    { "light_env_grass_fill09", "fill" },
    { "light_env_grass_fill11", "fill" },
    { "light_env_grass_fill12", "fill" },
    { "light_env_grass_fill13", "fill" },
    { "light_env_grass_fill14", "fill" },
    { "light_env_grass_fill15", "fill" },
    { "light_env_grass_fill16", "fill" },
    { "light_env_grass_fill17", "fill" },
    { "light_env_grass_fill18", "fill" },
    { "light_env_grass_fill19", "fill" },
    { "light_env_grass_fill20", "fill" },
    { "light_env_grass_fill21", "fill" },
    { "light_env_grass_fill22", "fill" },
    { "light_env_grass_fill23", "fill" },
    { "light_env_grass_fill24", "fill" },
    { "light_env_grass_fill25", "fill" },
    { "light_env_grass_fill26", "fill" },
    { "light_env_grass_fill27", "fill" },
    { "light_env_grass_fill29", "fill" },
    { "light_env_grass_fill30", "fill" },
    { "light_env_grass_fill31", "fill" },
    { "light_env_grass_fill32", "fill" },
    { "light_env_grass_fill33", "fill" },
    { "light_env_grass_fill34", "fill" },
    { "light_env_grass_fill35", "fill" },
    { "light_env_grass_fill36", "fill" },
    { "light_env_spt_sunStrikes_18", "sun" },
    { "light_env_spt_sunStrikes_25", "sun" },
    { "light_env_spt_sunStrikes_26", "sun" },
    { "light_env_spt_sunStrikes_28", "sun" },
    { "light_env_spt_sunStrikes_29", "sun" },
    { "light_env_spt_sunStrikes_30", "sun" },
    { "light_env_spt_sunStrikes_31", "sun" },
    { "light_env_grass_fill37", "fill" },
    { "light_env_spt_sunStrikes_33", "sun" },
    { "light_env_spt_sunStrikes_34", "sun" },
    { "light_env_spt_sunStrikes_35", "sun" },
    { "light_env_spt_sunStrikes_36", "sun" },
    { "light_env_spt_sunStrikes_37", "sun" },
    { "light_env_spt_sunStrikes_5", "sun" },
    { "light_env_spt_sunStrikes_38", "sun" },
    { "light_env_spt_sunStrikes_39", "sun" },
    { "light_env_grass_fill38", "fill" },
    { "light_env_grass_fill40", "fill" },
    { "light_env_grass_fill41", "fill" },
    { "light_env_grass_fill43", "fill" },
    { "light_env_grass_fill44", "fill" },
    { "light_env_grass_fill45", "fill" },
    { "light_env_grass_fill46", "fill" },
    { "light_env_grass_fill47", "fill" },
    { "light_env_grass_fill48", "fill" },
    { "light_env_grass_fill49", "fill" },
    { "light_env_grass_fill50", "fill" },
    { "light_env_grass_fill52", "fill" },
    { "light_env_grass_fill53", "fill" },
    { "light_env_pnt_treetops3", "fill" },
    { "light_env_pnt_treetops4", "fill" },
    { "light_env_grass_fill55", "fill" },
    { "light_ENV_grassSpecial", "other" },
    { "light_fx_muzzleFlashPistol", "other" },
    { "light_vfx_sunBeamAmb01", "sun" },
};

local RELIGHT_AUTO_LightSettings =
{
    fire = { dimmer = 1.25, warm = 1.08, softness = 0.3 },
    practical = { dimmer = 1.15, warm = 1.03, softness = 0.5 },
    sun = { dimmer = 1.1, warm = 1.0, softness = 0.2 },
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
RELIGHT_DOF_AUTOFOCUS_Aperture = 4.0;
RELIGHT_DOF_AUTOFOCUS_GameplayCameraNames =
{
  "Null"
};
RELIGHT_DOF_AUTOFOCUS_ObjectEntries =
{
    "Clementine",
    "Javier",
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
    FogColor = Color(0.05, 0.05, 0.05, 0.05)
};

--|||||||||||||||||||||||||||||||||||||||||||||||| RELIGHT SCENE CONFIGURATION INI ||||||||||||||||||||||||||||||||||||||||||||||||
RELIGHT_ConfigFileName_LevelPreset = RELIGHT_LevelsFolderName .. "/RELIGHT_305_adv_virginiaUnderpass.ini";
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
            DepthOfFieldAperture = 4.0,
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
