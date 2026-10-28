--AUTO-RELIGHT GENERATED FILE (tools/autorelight/generate.py). Scene: adv_garciaDominguezHouse303 | class: interior/day
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

--Per-scene brightness from calibrate.py (scene_classes.csv white_factor): factor on the levels white point,
--below 1 = brighter (crushed scenes), above 1 = darker (clipped scenes).
RELIGHT_AUTO_ApplyCalibration = function(agent_sceneAgent)
    local number_factor = 1.0;
    if number_factor == 1.0 then
        return;
    end

    --Low-light presets keep the scene levels, which may be off: turn them on neutral (white 1) first.
    if AgentGetProperty(agent_sceneAgent, "FX Levels Enabled") ~= true then
        AgentSetProperty(agent_sceneAgent, "FX Levels Enabled", true);
        AgentSetProperty(agent_sceneAgent, "FX Levels White Point", 1.0);
    end

    local number_white = AgentGetProperty(agent_sceneAgent, "FX Levels White Point") or 1.0;
    AgentSetProperty(agent_sceneAgent, "FX Levels White Point", number_white * number_factor);
end

--Fog stays as the original scene has it.
RELIGHT_ApplyEnvironmentFogSettings = function(string_scene) end

--Light candidates found in the .scene file, with their rule category. Only agents that are real
--environment lights (have "EnvLight - Intensity") are changed, and every change is relative to the original value.
local RELIGHT_AUTO_Lights =
{
    { "light_AMB_ambientGroup", "fill" },
    { "light_ENV_DIR_MainSun", "sun" },
    { "light_ENV_AMB_MainFill", "fill" },
    { "light_ENV_PNT_InteriorFill_ambient", "fill" },
    { "light_group_interior", "other" },
    { "light_ENV_PNT_GlowingLamp02", "practical" },
    { "light_ENV_PNT_GlowingLamp03", "practical" },
    { "light_ENV_porch03", "fill" },
    { "light_group_exterior", "other" },
    { "light_ENV_ambientStreet01", "practical" },
    { "light_ENV_pointFoliage", "fill" },
    { "light_ENV_pointFoliage02", "fill" },
    { "light_ENV_S_interiorKitchenShadows", "fill" },
    { "light_ENV_PNT_Interior_BounceFill09", "fill" },
    { "light_ENV_ambient_night_kitchenWindow01", "fill" },
    { "light_ENV_PNT_Interior_Kitchen01", "fill" },
    { "light_ENV_PNT_Interior_Kitchen", "fill" },
    { "light_ENV_ambientStreet", "practical" },
    { "light_ENV_PNT_BounceFill05", "fill" },
    { "light_ENV_PNT_GlowingLamp10", "practical" },
    { "light_SKY_Ambient", "sun" },
    { "light_SKY_Point", "sun" },
    { "light_SKY_Point01", "sun" },
    { "light_SKY_Point02", "sun" },
    { "light_SKY_Point03", "sun" },
    { "light_SKY_Point04", "sun" },
    { "light_SKY_Point05", "sun" },
    { "light_ENV_SPT_Interior_moonLight01", "sun" },
    { "light_ENV_SPT_Interior_moonLight02", "sun" },
    { "light_ENV_PNT_Interior_BounceFill04", "fill" },
    { "light_ENV_PNT_Interior_BounceFill15", "fill" },
    { "light_ENV_SPT_Interior_moonLight03_dyn", "sun" },
    { "light_env_spt_moonLight2", "sun" },
    { "light_env_spt_moonLight3", "sun" },
    { "light_env_spt_moonLight4_dyn", "sun" },
    { "light_env_spt_moonLight5", "sun" },
    { "light_env_spt_moonLight6", "sun" },
    { "light_env_spt_moonLight7", "sun" },
    { "light_ENV_pointFoliage01", "fill" },
    { "light_ENV_pointFoliage03", "fill" },
    { "light_ENV_pointFoliage04", "fill" },
    { "light_ENV_pointFoliage05", "fill" },
    { "light_env_spt_moonLight4", "sun" },
    { "light_env_spt_moonLight8", "sun" },
    { "light_ENV_pointFoliage07", "fill" },
    { "light_ENV_pointFoliage08", "fill" },
    { "light_ENV_pointFoliage09", "fill" },
    { "light_ENV_pointFoliage10", "fill" },
    { "light_ENV_pointFoliage11", "fill" },
    { "light_ENV_pointFoliage12", "fill" },
    { "light_ENV_pointFoliage13", "fill" },
    { "light_SKY_hor", "sun" },
    { "light_ENV_pointFoliage14", "fill" },
    { "light_ENV_PNT_GlowingLamp11", "practical" },
    { "light_ENV_PNT_GlowingLamp12", "practical" },
    { "light_ENV_PNT_GlowingLamp04", "practical" },
    { "light_ENV_PNT_GlowingLamp13", "practical" },
    { "light_ENV_PNT_GlowingLamp05", "practical" },
    { "light_env_pnt_vanLight", "fill" },
    { "light_ENV_PNT_GlowingLamp14", "practical" },
    { "light_ENV_AMB_all", "fill" },
    { "light_ENV_foliageBake", "other" },
    { "light_ENV_foliageBake01", "other" },
    { "light_ENV_ambientStreet02", "practical" },
    { "light_ENV_pointFoliage15", "fill" },
    { "light_ENV_ambientStreet03", "practical" },
    { "light_ENV_ambientStreet04", "practical" },
    { "light_ENV_S_moonStrike01", "sun" },
    { "light_ENV_pointFoliage16", "fill" },
    { "light_ENV_S_moonStrike02", "sun" },
    { "light_ENV_S_moonStrike03", "sun" },
    { "light_ENV_PNT_Interior_BounceFill10", "fill" },
    { "light_ENV_PNT_Interior_BounceFill11", "fill" },
    { "light_ALT_AMB_props", "other" },
};

local RELIGHT_AUTO_LightSettings =
{
    fire = { dimmer = 1.25, warm = 1.08, softness = 0.3, specular = 1.2 },
    practical = { dimmer = 1.15, warm = 1.03, softness = 0.5, specular = 1.15 },
    sun = { dimmer = 1.0, warm = 1.0, softness = 0.2, specular = 1.0 },
    fill = { dimmer = 0.85, warm = 1.0, softness = 0.6, specular = 1.0 },
    other = { dimmer = 1.0, warm = 1.0, softness = 0.5, specular = 1.0 },
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

            local number_specular = AgentGetProperty(agent_light, "EnvLight - Intensity Specular");
            if (number_specular ~= nil) and (settings.specular ~= 1.0) then
                AgentSetProperty(agent_light, "EnvLight - Intensity Specular", number_specular * settings.specular);
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
    "Kate",
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
    FogColor = Color(0.04, 0.04, 0.04, 0.04),
    Quality = 2,
    Range = 6.0,
    SpacingPower = 1.6,
    ColorExponent = { 0.55, 0.55, 0.55 },
    QualitySamples = { 24, 48, 64 },
    Jitter = 0,
};

--|||||||||||||||||||||||||||||||||||||||||||||||| RELIGHT SCENE CONFIGURATION INI ||||||||||||||||||||||||||||||||||||||||||||||||
RELIGHT_ConfigFileName_LevelPreset = RELIGHT_LevelsFolderName .. "/RELIGHT_303_adv_garciaDominguezHouse303.ini";
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
        RELIGHT_AUTO_ApplyCalibration(RELIGHT_SceneObjectAgentName);
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
