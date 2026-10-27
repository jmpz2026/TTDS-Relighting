--AUTO-RELIGHT GENERATED FILE (tools/autorelight/generate.py). Scene: adv_johnsHouseInteriorMain | class: interior/day
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

--Fog stays as the original scene has it.
RELIGHT_ApplyEnvironmentFogSettings = function(string_scene) end

--Light candidates found in the .scene file, with their rule category. Only agents that are real
--environment lights (have "EnvLight - Intensity") are changed, and every change is relative to the original value.
local RELIGHT_AUTO_Lights =
{
    { "lightENV_skydome_amb", "sun" },
    { "lightENV_skydome_dirA", "sun" },
    { "lightENV_skydome_dirB", "sun" },
    { "lightENV_skydome_neg", "sun" },
    { "lightOBJ_pokerHighlight_01", "other" },
    { "light_agateee", "other" },
    { "light_alamp", "practical" },
    { "light_alamp01", "practical" },
    { "light_alamp02", "practical" },
    { "light_alamp03", "practical" },
    { "light_alamp04", "practical" },
    { "light_ahouse_spot", "other" },
    { "light_ahouse_stairs_spot", "other" },
    { "light_ahouse_stairs_spot01", "other" },
    { "light_aspot_house", "other" },
    { "light_alamp_kitchen", "practical" },
    { "light_acandle", "fire" },
    { "light_acandle02", "fire" },
    { "light_acandle03", "fire" },
    { "light_acandle05", "fire" },
    { "light_ahouse_desk_spot", "other" },
    { "light_aAmb_interior", "other" },
    { "light_ahouse_stairs_spot02", "other" },
    { "light_alamp06", "practical" },
    { "light_alamp08", "practical" },
    { "light_alamp09", "practical" },
    { "light_aaamb", "other" },
    { "light_aadir", "other" },
    { "light_acandle01", "fire" },
    { "light_acandle04", "fire" },
    { "light_acandle06", "fire" },
    { "light_acandle07", "fire" },
    { "light_kitchen", "other" },
    { "light_kitchen01", "other" },
    { "light_kitchen02", "other" },
    { "light_acandle08", "fire" },
    { "light_acandle09", "fire" },
    { "light_acandle10", "fire" },
    { "light_alamp_kitchen01", "practical" },
    { "light_agreen", "other" },
    { "light_agreen01", "other" },
    { "light_agreen02", "other" },
    { "light_agreen03", "other" },
    { "light_alamp05", "practical" },
    { "light_acandle11", "fire" },
    { "light_acandle12", "fire" },
    { "light_acandle13", "fire" },
    { "light_acandle14", "fire" },
    { "light_acandle15", "fire" },
    { "light_acandle16", "fire" },
    { "light_acandle17", "fire" },
    { "light_acandle18", "fire" },
    { "light_acandle19", "fire" },
    { "light_agreen04", "other" },
    { "light_bamb_apart", "other" },
    { "light_aamb_sky", "sun" },
    { "light_bgirlrsoom", "other" },
    { "light_bgirlrsoom01", "other" },
    { "light_bgirlrsoom02", "other" },
    { "light_bathroom", "other" },
    { "light_bbedroom", "other" },
    { "light_bbedroom01", "other" },
    { "light_bbedroom02", "other" },
    { "light_bbedroom03", "other" },
    { "light_bathroom01", "other" },
    { "light_bathroom02", "other" },
    { "light_bathroom03", "other" },
    { "light_broom", "other" },
    { "light_broom_outside", "other" },
    { "light_broom_outside02", "other" },
    { "light_broom_outside03", "other" },
    { "light_broom02", "other" },
    { "light_broom03", "other" },
    { "light_broom04", "other" },
    { "light_broom05", "other" },
    { "light_broom06", "other" },
    { "light_broom07", "other" },
    { "light_broom08", "other" },
    { "light_broom09", "other" },
    { "light_broom10", "other" },
    { "light_broom11", "other" },
    { "light_broom12", "other" },
    { "light_broom13", "other" },
    { "light_acandle22", "fire" },
    { "light_acandle23", "fire" },
    { "light_aamb_ui", "other" },
    { "light_broom14", "other" },
    { "light_broom15", "other" },
    { "light_broom01", "other" },
    { "light_bathroom04", "other" },
    { "light_bathroom05", "other" },
    { "light_hallway_spot01", "other" },
    { "light_hallway_small02", "other" },
    { "light_hallway_spot02", "other" },
    { "light_hallway_spot03", "other" },
    { "light_hallway_spot04", "other" },
    { "light_hallway_spot05", "other" },
    { "light_hallway_spot06", "other" },
    { "light_hallway_spot07", "other" },
    { "light_hallway_small03", "other" },
    { "light_hallway_small04", "other" },
    { "light_hallway_small05", "other" },
    { "light_hallway_small06", "other" },
    { "light_hallway_small07", "other" },
    { "light_hallway_spot08", "other" },
    { "light_hallway_spot09", "other" },
    { "light_hallway_spot10", "other" },
    { "light_hallway_spot11", "other" },
    { "light_hallway_spot12", "other" },
    { "light_hallway_small08", "other" },
    { "light_hallway_small09", "other" },
    { "light_hallway_small10", "other" },
    { "light_hallway_small11", "other" },
    { "light_alamp07", "practical" },
    { "light_aamb_house_outside", "other" },
    { "light_acandle26", "fire" },
    { "light_bgirlrsoom03", "other" },
    { "light_bbedroom04_CHR", "other" },
    { "light_broom_chr", "other" },
    { "light_hallway_spot8_chr", "other" },
    { "light_acandle05chr", "fire" },
    { "light_hallway_spot_vanessa", "other" },
    { "light_bathroom07", "other" },
    { "light_glass", "other" },
    { "light_bathroom06", "other" },
    { "light_broom16", "other" },
    { "light_broom_outside_chr", "other" },
    { "light_broom_outside_chr2", "other" },
    { "light_broom_outside_chr3", "other" },
    { "light_broom_outside_chr4", "other" },
    { "light_broom17", "other" },
    { "light_acandle27", "fire" },
    { "light_bbedroom04_shadow", "other" },
    { "light_acandle28", "fire" },
    { "light_broom18", "other" },
    { "light_bgirlrsoom04", "other" },
    { "light_bgirlrsoom05", "other" },
    { "light_bbedroom04", "other" },
    { "light_bbedroom05", "other" },
    { "light_hallway_amb", "other" },
    { "light_broom19", "other" },
    { "light_hallway_fill01", "fill" },
    { "light_hallway_fill02", "fill" },
    { "light_hallway_fill03", "fill" },
    { "light_hallway_fill04", "fill" },
    { "light_hallway_fill05", "fill" },
    { "light_hallway_fill06", "fill" },
    { "light_hallway_fill07", "fill" },
    { "light_hallway_fill08", "fill" },
    { "light_hallway_fill09", "fill" },
    { "light_hallway_fill10", "fill" },
    { "light_hallway_fill11", "fill" },
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
    "Pete",
    "James",
    "Michonne",
    "Randall",
    "Paige",
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

--Relight Volumetrics
RELIGHT_HackyCameraVolumetrics_Settings =
{
    Samples = 256,
    SampleOffset = 0.05,
    SampleStartOffset = 1.0,
    FogColor = Color(0.04, 0.04, 0.04, 0.04)
};

--|||||||||||||||||||||||||||||||||||||||||||||||| RELIGHT SCENE CONFIGURATION INI ||||||||||||||||||||||||||||||||||||||||||||||||
RELIGHT_ConfigFileName_LevelPreset = RELIGHT_LevelsFolderName .. "/RELIGHT_M102_adv_johnsHouseInteriorMain.ini";
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
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_apartment");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_apartment_rotation");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_apartment_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_apartment_dinner");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_apartment_dinner_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_apartment_kitchen");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_apartment_kitchen_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_apartment_mainRoom");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_apartment_mainRoom_parent");
        for _, string_name in ipairs(RELIGHT_DOF_AUTOFOCUS_ObjectEntries) do
            RELIGHT_DepthOfField_AddFocusTarget(string_name);
        end
        RELIGHT_DepthOfField_Setup();

        RELIGHT_DOF_AUTOFOCUS_Aperture = RelightConfigData_LevelPreset["Main"]["DepthOfFieldAperture"];
    end

    if RELIGHT_AUTO_Enabled("EnableVolumetricLighting") then
        RELIGHT_HackyCameraVolumetrics_Initalize();
    end

    TLSE_SetPropertyOnAllCameras(RELIGHT_SceneObject, "Exposure", RelightConfigData_LevelPreset["Main"]["ExposureOffset"]);
end

--(DO NOT CHANGE FUNCTION NAME OR ADD PARAMETERS) Called every frame after the start of the level.
RELIGHT_SceneUpdate = function()
    if RELIGHT_AUTO_Enabled("EnableDepthOfField") then
        RELIGHT_DepthOfField_Update();
    end

    if RELIGHT_AUTO_Enabled("EnableVolumetricLighting") then
        RELIGHT_HackyCameraVolumetrics_Update();
    end

    if RELIGHT_AUTO_LensFlareActive then
        RELIGHT_LensFlareEffect_Update();
    end
end
