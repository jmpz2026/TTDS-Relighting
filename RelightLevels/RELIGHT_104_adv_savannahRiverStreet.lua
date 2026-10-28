--AUTO-RELIGHT GENERATED FILE (tools/autorelight/generate.py). Scene: adv_savannahRiverStreet | class: exterior/day
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

--Color grade for the scene class. The scene's own tint is blended halfway to the class tint, so the
--original art direction stays; the opacity is the higher of the two.
RELIGHT_AUTO_ApplyColorGrading = function(agent_sceneAgent)
    local color_grade = Color(1.0, 0.98, 0.95, 1);
    local color_tint = Color(1, 1, 1, 1);
    local number_opacity = 0;

    if AgentGetProperty(agent_sceneAgent, "FX Color Enabled") == true then
        color_tint = AgentGetProperty(agent_sceneAgent, "FX Color Tint") or color_tint;
        number_opacity = AgentGetProperty(agent_sceneAgent, "FX Color Opacity") or 0;
    end

    AgentSetProperty(agent_sceneAgent, "FX Color Enabled", true);
    AgentSetProperty(agent_sceneAgent, "FX Color Tint", Color((color_tint.r + color_grade.r) / 2, (color_tint.g + color_grade.g) / 2, (color_tint.b + color_grade.b) / 2, 1));
    AgentSetProperty(agent_sceneAgent, "FX Color Opacity", math.max(number_opacity, 0.05));
    AgentSetProperty(agent_sceneAgent, "FX Levels Black Point", 0.005);
end

--Fog stays as the original scene has it.
RELIGHT_ApplyEnvironmentFogSettings = function(string_scene) end

--Light candidates found in the .scene file, with their rule category. Only agents that are real
--environment lights (have "EnvLight - Intensity") are changed, and every change is relative to the original value.
local RELIGHT_AUTO_Lights =
{
    { "light_fog", "other" },
    { "light_D", "other" },
    { "light_amb", "other" },
    { "light_skydome", "sun" },
    { "light_skydome01", "sun" },
    { "light_P", "other" },
    { "light_P01Car", "other" },
    { "light_P02Car", "other" },
    { "light_ambRiver", "other" },
    { "light_dirRiver", "other" },
    { "light_ambEnlighten", "other" },
    { "light_amb01", "other" },
    { "light_P01", "other" },
    { "light_P02", "other" },
    { "light_P03", "other" },
    { "light_P04", "other" },
    { "light_P05", "other" },
    { "light_P06", "other" },
    { "light_P07", "other" },
    { "light_P08", "other" },
    { "light_P09", "other" },
    { "light_P10", "other" },
    { "light_P11", "other" },
    { "light_P12", "other" },
    { "light_P13", "other" },
    { "light_P14", "other" },
    { "light_P15", "other" },
    { "light_P16", "other" },
    { "light_MATTE_a_fillAmb", "fill" },
    { "light_P17", "other" },
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
    "Lee",
    "Clementine",
    "Kenny",
    "Molly",
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

--Relight Lens Flare (only used when the scene has a sun light: none)
local RELIGHT_AUTO_SunLight = nil;
local RELIGHT_AUTO_LensFlareActive = false;
local RELIGHT_AUTO_VolumetricsActive = false;

--Relight Volumetrics
RELIGHT_HackyCameraVolumetrics_Settings =
{
    Samples = 256,
    SampleOffset = 0.05,
    SampleStartOffset = 1.0,
    FogColor = Color(0.05, 0.05, 0.05, 0.05),
    Quality = 2,
    Range = 16.0,
    SpacingPower = 1.6,
    ColorExponent = { 0.42, 0.55, 0.55 },
    QualitySamples = { 24, 48, 96 },
    Jitter = 0,
};

--|||||||||||||||||||||||||||||||||||||||||||||||| RELIGHT SCENE CONFIGURATION INI ||||||||||||||||||||||||||||||||||||||||||||||||
RELIGHT_ConfigFileName_LevelPreset = RELIGHT_LevelsFolderName .. "/RELIGHT_104_adv_savannahRiverStreet.ini";
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
            EnableVolumetricLighting = true,
            EnableColorGrading = true,
            EnableLensFlare = false,
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

--An effect runs only when the global switch (RelightConfiguration_Main.ini, Options > Relight menu)
--and the switch in this level .ini are both on.
local RELIGHT_AUTO_Enabled = function(string_key)
    return (RelightConfigGlobal[string_key] ~= false) and (RelightConfigData_LevelPreset["Main"][string_key] == true);
end

--|||||||||||||||||||||||||||||||||||||||||||||||| RELIGHT SCENE MAIN ||||||||||||||||||||||||||||||||||||||||||||||||
--(DO NOT CHANGE FUNCTION NAME OR ADD PARAMETERS) Called at the start of the level by the relight backend.
RELIGHT_SceneStart = function()
    if RELIGHT_AUTO_Enabled("EnableRelighting") then
        RELIGHT_ApplySceneSettings(RELIGHT_SceneObjectAgentName);
        RELIGHT_ApplyEnvironmentFogSettings(RELIGHT_SceneObject);
        RELIGHT_ApplyLightingSettings(RELIGHT_SceneObject);

        if RELIGHT_AUTO_Enabled("EnableColorGrading") then
            RELIGHT_AUTO_ApplyColorGrading(RELIGHT_SceneObjectAgentName);
        end
    end

    if RELIGHT_AUTO_Enabled("EnableLensFlare") and (RELIGHT_AUTO_SunLight ~= nil) and (AgentFindInScene(RELIGHT_AUTO_SunLight, RELIGHT_SceneObject) ~= nil) then
        LensFlareEffect_FlareInstances = {};
        LensFlareEffect_SourcesCount = 1;
        LensFlareEffect_Sources = { Source1 = { LightAgentName = RELIGHT_AUTO_SunLight, LightOcclusionAngle = -0.25, LightIntensityModifier = 1.0 } };
        RELIGHT_LensFlareEffect_Initalize();
        RELIGHT_AUTO_LensFlareActive = true;
    end

    if RELIGHT_AUTO_Enabled("EnableDepthOfField") then
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_intersection");
        RELIGHT_DepthOfField_AddGameplayCameraName("camAxis_cam_nav_intersection");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_intersection_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_streetHigh");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_streetHigh_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_streetWide");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_streetWide_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_stands");
        RELIGHT_DepthOfField_AddGameplayCameraName("camAxis_cam_nav_stands");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_stands_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_debrisApproach");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_debrisApproach_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_debrisApproach_parent_depth");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_debris");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_debris_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_sideStreet");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_sideStreet_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_cornerStand");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_cornerStand_depth");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_alleyWay");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_FIGHT_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_FIGHT");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_AlleywayACTION_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_AlleywayACTION");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_grabKennyHand");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_LeeSneak_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_LeeSneak");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_grabKennyHand_parent");
        for _, string_name in ipairs(RELIGHT_DOF_AUTOFOCUS_ObjectEntries) do
            RELIGHT_DepthOfField_AddFocusTarget(string_name);
        end
        RELIGHT_DepthOfField_Setup();

        RELIGHT_DOF_AUTOFOCUS_Aperture = RelightConfigData_LevelPreset["Main"]["DepthOfFieldAperture"];
    end

    --VolumetricQuality (Main ini, Options > Relight): 0 off, 1 low, 2 medium, 3 high, 4 ultra (original 256 planes).
    RELIGHT_HackyCameraVolumetrics_Settings.Quality = RelightConfigGlobal["VolumetricQuality"] or 0;
    RELIGHT_AUTO_VolumetricsActive = RELIGHT_AUTO_Enabled("EnableVolumetricLighting") and (RELIGHT_HackyCameraVolumetrics_Settings.Quality > 0);

    if RELIGHT_AUTO_VolumetricsActive then
        RELIGHT_HackyCameraVolumetrics_Initalize();
    end

    TLSE_SetPropertyOnAllCameras(RELIGHT_SceneObject, "Exposure", RelightConfigData_LevelPreset["Main"]["ExposureOffset"]);
end

--(DO NOT CHANGE FUNCTION NAME OR ADD PARAMETERS) Called every frame after the start of the level.
RELIGHT_SceneUpdate = function()
    if RELIGHT_AUTO_Enabled("EnableDepthOfField") then
        RELIGHT_DepthOfField_Update();
    end

    if RELIGHT_AUTO_VolumetricsActive then
        RELIGHT_HackyCameraVolumetrics_Update();
    end

    if RELIGHT_AUTO_LensFlareActive then
        RELIGHT_LensFlareEffect_Update();
    end
end
