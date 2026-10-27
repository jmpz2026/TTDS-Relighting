--AUTO-RELIGHT GENERATED FILE (tools/autorelight/generate.py). Scene: adv_richmondSafehouse | class: interior/day
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
    { "light_SKY_Point", "sun" },
    { "light_SKY_Point01", "sun" },
    { "light_SKY_Point02", "sun" },
    { "light_SKY_Point03", "sun" },
    { "light_SKY_Point04", "sun" },
    { "light_SKY_Point05", "sun" },
    { "light_ENV_D_sun", "sun" },
    { "light_ENV_AMB", "fill" },
    { "light_SKY_amb", "sun" },
    { "light_MAT_AMB", "other" },
    { "light_MAT_spot01", "other" },
    { "light_MAT_spot03", "other" },
    { "light_MAT_spot04", "other" },
    { "light_MAT_point06", "other" },
    { "light_MAT_point07", "other" },
    { "light_MAT_point08", "other" },
    { "light_ENV_P_streetBounce01", "practical" },
    { "light_ENV_P_streetBounce02", "practical" },
    { "light_ENV_P_streetBounce03", "practical" },
    { "light_ENV_P_streetBounce04", "practical" },
    { "light_ENV_P_streetBounce05", "practical" },
    { "light_ENV_P_streetBounce06", "practical" },
    { "light_ENV_P_streetBounce07", "practical" },
    { "light_ENV_P_streetBounce08", "practical" },
    { "light_ENV_P_streetBounce09", "practical" },
    { "light_ENV_P_streetBounce10", "practical" },
    { "light_ENV_P_streetBounce11", "practical" },
    { "light_ENV_P_streetBounce12", "practical" },
    { "light_ENV_P_streetBounce13", "practical" },
    { "light_ENV_P_streetBounce14", "practical" },
    { "light_ENV_P_streetBounce15", "practical" },
    { "light_ENV_P_streetBounce16", "practical" },
    { "light_ENV_P_streetBounce17", "practical" },
    { "light_ENV_P_streetBounce18", "practical" },
    { "light_ENV_P_streetBounce19", "practical" },
    { "light_ENV_P_roofBounce01", "fill" },
    { "light_ENV_S_streetLight01_SH", "practical" },
    { "light_ENV_S_streetLight03_SH", "practical" },
    { "light_ENV_S_streetLight04_SH", "practical" },
    { "light_ENV_P_lampCenter01_SH", "practical" },
    { "light_ENV_P_lampCenter02_SH", "practical" },
    { "light_ENV_P_lampCenter03_SH", "practical" },
    { "light_ENV_S_streetLight05_SH", "practical" },
    { "light_ENV_P_streetBounce20", "practical" },
    { "light_ENV_P_lampCenter04", "practical" },
    { "light_ENV_P_streetBounce21", "practical" },
    { "light_ENV_P_streetBounce23", "practical" },
    { "light_ENV_P_streetBounce22", "practical" },
    { "light_ENV_P_streetBounce24", "practical" },
    { "light_ENV_P_streetBounce25", "practical" },
    { "light_ENV_S_streetLight06_SH", "practical" },
    { "light_ENV_P_streetBounce26", "practical" },
    { "light_ENV_P_streetBounce27", "practical" },
    { "light_ENV_P_streetBounce28", "practical" },
    { "light_ENV_P_streetBounce29", "practical" },
    { "light_ENV_S_streetLight07_SH", "practical" },
    { "light_ENV_P_streetBounce30", "practical" },
    { "light_ENV_P_streetBounce31", "practical" },
    { "light_ENV_P_streetBounce32", "practical" },
    { "light_ENV_P_streetBounce33", "practical" },
    { "light_ENV_P_streetBounce34", "practical" },
    { "light_ENV_P_streetBounce35", "practical" },
    { "light_ENV_P_streetBounce36", "practical" },
    { "light_ENV_P_streetBounce37", "practical" },
    { "light_ENV_P_streetBounce38", "practical" },
    { "light_ENV_P_streetBounce39", "practical" },
    { "light_ENV_P_streetBounce40", "practical" },
    { "light_ENV_P_lampCenter_SH", "practical" },
    { "light_fx_headlights", "other" },
    { "light_fx_headlights01", "other" },
    { "light_VEH_swatTruck_L", "other" },
    { "light_VEH_swatTruck_R", "other" },
    { "light_ENV_S_window01", "fill" },
    { "light_ENV_S_window02", "fill" },
    { "light_ENV_S_window03", "fill" },
    { "light_ENV_S_window04", "fill" },
    { "light_ENV_S_window01NX", "fill" },
    { "light_ENV_S_window02NX", "fill" },
    { "light_ENV_S_window03NX", "fill" },
    { "light_ENV_S_window04NX", "fill" },
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
RELIGHT_DOF_AUTOFOCUS_Aperture = 2.8;
RELIGHT_DOF_AUTOFOCUS_GameplayCameraNames =
{
  "Null"
};
RELIGHT_DOF_AUTOFOCUS_ObjectEntries =
{
    "Clementine",
    "Kate",
    "Gabe",
    "Javier",
    "Ava",
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
    FogColor = Color(0.04, 0.04, 0.04, 0.04)
};

--|||||||||||||||||||||||||||||||||||||||||||||||| RELIGHT SCENE CONFIGURATION INI ||||||||||||||||||||||||||||||||||||||||||||||||
RELIGHT_ConfigFileName_LevelPreset = RELIGHT_LevelsFolderName .. "/RELIGHT_304_adv_richmondSafehouse.ini";
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
            DepthOfFieldAperture = 2.8,
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
