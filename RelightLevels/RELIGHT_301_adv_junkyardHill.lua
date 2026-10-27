--AUTO-RELIGHT GENERATED FILE (tools/autorelight/generate.py). Scene: adv_junkyardHill | class: exterior/day
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
    { "light_ENV_DD_SH_sunJunkHill", "sun" },
    { "light_ENV_ambFill", "fill" },
    { "light_ENV_DA_fill02", "sun" },
    { "light_ENV_DA_fill03", "sun" },
    { "light_ENV_DA_fill04", "sun" },
    { "light_ENV_SHD_DA_fill06", "fill" },
    { "light_ENV_vistaCards_skybox_amb", "sun" },
    { "light_ENV_PNT_bounce01", "fill" },
    { "light_ENV_PNT_SHD_bounce02", "fill" },
    { "light_ENV_PNT_bounce05", "fill" },
    { "light_ENV_PNT_SHD_bounce06", "fill" },
    { "light_ENV_PNT_SHD_bounce09", "fill" },
    { "light_ENV_PNT_foliageBounce02", "fill" },
    { "light_ENV_PNT_bounce11", "fill" },
    { "light_ENV_SPT_bounce", "fill" },
    { "light_ENV_SPT_bounce01", "fill" },
    { "light_ENV_PNT_bounce10", "fill" },
    { "light_ENV_SPT_SHD_trailer", "fill" },
    { "light_ENV_SPT_SHD_trailer01", "fill" },
    { "light_ENV_SPT_SHD_trailer02", "fill" },
    { "light_fx_muzzleFlash_01", "other" },
    { "light_ENV_trailer_interior_ambient", "fill" },
    { "light_ENV_PNT_bounce13", "fill" },
    { "light_ENV_PNT_skyDome", "sun" },
    { "light_ENV_PNT_skyDome01", "sun" },
    { "light_ENV_PNT_skyDome02", "sun" },
    { "light_ENV_PNT_bounce06", "fill" },
    { "light_ENV_PNT_bounce07", "fill" },
    { "light_ENV_PNT_bounce14", "fill" },
    { "light_ENV_PNT_bounce16", "fill" },
    { "light_ENV_SHD_DA_fill07", "fill" },
    { "light_ENV_SHD_DA_fill09", "fill" },
    { "light_ENV_PNT_bounce17", "fill" },
    { "light_ENV_PNT_bounce19", "fill" },
    { "light_ENV_PNT_bounce20", "fill" },
    { "light_ENV_PNT_bounce21", "fill" },
    { "light_ENV_PNT_bounce23", "fill" },
    { "light_ENV_PNT_bounce24", "fill" },
    { "light_ENV_PNT_bounce26", "fill" },
    { "light_ENV_PNT_bounce31", "fill" },
    { "light_ENV_PNT_bounce33", "fill" },
    { "light_ENV_PNT_bounce34", "fill" },
    { "light_ENV_PNT_bounce35", "fill" },
    { "light_ENV_PNT_bounce36", "fill" },
    { "light_ENV_PNT_bounce38", "fill" },
    { "light_ENV_PNT_bounce40", "fill" },
    { "light_ENV_PNT_bounce42", "fill" },
    { "light_ENV_PNT_bounce44", "fill" },
    { "light_ENV_PNT_bounce46", "fill" },
    { "light_ENV_PNT_bounce48", "fill" },
    { "light_ENV_PNT_bounce49", "fill" },
    { "light_ENV_PNT_bounce37", "fill" },
    { "light_ENV_PNT_foliageBounce03", "fill" },
    { "light_ENV_PNT_foliageBounce04", "fill" },
    { "light_ENV_PNT_foliageBounce05", "fill" },
    { "light_ENV_PNT_foliageBounce06", "fill" },
    { "light_ENV_PNT_foliageBounce07", "fill" },
    { "light_ENV_PNT_bounce39", "fill" },
    { "light_ENV_DD_SH_sun_foliage", "sun" },
    { "light_ENV_DD_SH_sun_foliage_ambient", "sun" },
    { "light_ambient_godRayFix", "fill" },
    { "light_ENV_PNT_bounce18", "fill" },
    { "light_ENV_PNT_bounce27", "fill" },
    { "light_ENV_PNT_bounce43", "fill" },
    { "light_ENV_PNT_bounce12", "fill" },
    { "light_ENV_PNT_bounce", "fill" },
    { "light_ENV_PNT_bounce45", "fill" },
    { "light_ENV_PNT_bounce47", "fill" },
    { "light_ENV_PNT_bounce08", "fill" },
    { "light_ENV_S_underTrailer01", "fill" },
    { "light_ENV_amb_grass", "fill" },
    { "light_ENV_SHD_trapdoor0", "fill" },
    { "light_ENV_SHD_DA_fill08", "fill" },
    { "light_ENV_PNT_SHD_bounce03", "fill" },
    { "light_ENV_SHD_trapdoor1", "fill" },
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
    "Kate",
    "Gabe",
    "Javier",
    "Mariana",
    "Max",
    "Badger",
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
RELIGHT_ConfigFileName_LevelPreset = RELIGHT_LevelsFolderName .. "/RELIGHT_301_adv_junkyardHill.ini";
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
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_trailerInterior_depth");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_trailerInterior_width");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_trailerInterior");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_ambulance_depth");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_ambulance_width");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_ambulance");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_trailerExterior_depth");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_trailerExterior_width");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_trailerExterior");
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
