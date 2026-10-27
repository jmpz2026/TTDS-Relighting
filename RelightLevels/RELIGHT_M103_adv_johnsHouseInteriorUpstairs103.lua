--AUTO-RELIGHT GENERATED FILE (tools/autorelight/generate.py). Scene: adv_johnsHouseInteriorUpstairs103 | class: interior/day
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
    { "light_michonne_letterSubtract", "other" },
    { "light_adir", "other" },
    { "light_awindow", "other" },
    { "light_adoor", "other" },
    { "light_astairs", "other" },
    { "light_a04", "other" },
    { "light_astairsl", "other" },
    { "light_astairsr", "other" },
    { "light_aamb_hallway", "other" },
    { "light_hallway_spot02", "other" },
    { "light_hallway_spot01", "other" },
    { "light_hallway_spot03", "other" },
    { "light_hallway_spot04", "other" },
    { "light_hallway_spot05", "other" },
    { "light_hallway_spot06", "other" },
    { "light_hallway_spot07", "other" },
    { "light_hallway_spot08", "other" },
    { "light_hallway_spot09", "other" },
    { "light_hallway_spot10", "other" },
    { "light_hallway_spot11", "other" },
    { "light_hallway_spot12", "other" },
    { "light_hallway_spot13", "other" },
    { "light_hallway_lantern", "fire" },
    { "light_awindow_wall", "other" },
    { "light_awindow_wall01", "other" },
    { "light_awindow_wall02", "other" },
    { "light_acandle", "fire" },
    { "light_awindow_wall03", "other" },
    { "light_awindow_wall04", "other" },
    { "light_awindow_wall05", "other" },
    { "light_acandle01", "fire" },
    { "light_acandle02", "fire" },
    { "light_awindow_shadow02", "other" },
    { "light_awindow_shadow05", "other" },
    { "light_acandle03", "fire" },
    { "light_adoor_under", "other" },
    { "light_awindow01", "other" },
    { "light_awindow02", "other" },
    { "light_acandle04", "fire" },
    { "light_acandle05", "fire" },
    { "light_apaigeroom", "other" },
    { "light_apaigeroom01", "other" },
    { "light_apaigeroom02", "other" },
    { "light_awindow03", "other" },
    { "light_apaigeroom03", "other" },
    { "light_apaigeroom04", "other" },
    { "light_apaigeroom05", "other" },
    { "light_ablueroom2", "other" },
    { "light_ablueroom", "other" },
    { "light_ablueroom3", "other" },
    { "light_ablueroom4", "other" },
    { "light_ablueroom5", "other" },
    { "light_awindow04", "other" },
    { "light_adownstairs", "other" },
    { "light_awindow05", "other" },
    { "light_acandle06", "fire" },
    { "light_hallway_small02", "other" },
    { "light_hallway_small03", "other" },
    { "light_hallway_small04", "other" },
    { "light_hallway_small06", "other" },
    { "light_hallway_small07", "other" },
    { "light_hallway_small09", "other" },
    { "light_hallway_small10", "other" },
    { "light_hallway_small05", "other" },
    { "light_hallway_small08", "other" },
    { "light_hallway_small11", "other" },
    { "light_hallway_small12", "other" },
    { "light_hallway_door", "other" },
    { "light_adownstairs01", "other" },
    { "light_adownstairs02", "other" },
    { "light_adownstairs03", "other" },
    { "light_adownstairs04", "other" },
    { "light_ablueroom6", "other" },
    { "light_hallway_spot14", "other" },
    { "light_hallway_spot15", "other" },
    { "light_hallway_spot16", "other" },
    { "light_hallway_spot17", "other" },
    { "light_hallway_spot18", "other" },
    { "light_hallway_spot19", "other" },
    { "light_hallway_spot20", "other" },
    { "light_hallway_spot21", "other" },
    { "light_hallway_spot22", "other" },
    { "light_hallway_spot23", "other" },
    { "light_hallway_spot24", "other" },
    { "light_hallway_spot25", "other" },
    { "light_hallway_spot26", "other" },
    { "light_hallway_door01", "other" },
    { "light_hallway_lantern01", "fire" },
    { "light_aaamb", "other" },
    { "light_awindow_wall06", "other" },
    { "light_awindow_wall07", "other" },
    { "light_aamb", "other" },
    { "light_awindow_shadow03", "other" },
    { "light_awindow_shadow07", "other" },
    { "light_ablueroom01", "other" },
    { "light_ablueroom02", "other" },
    { "light_acandle07", "fire" },
    { "light_acandle08", "fire" },
    { "light_acandle09", "fire" },
    { "light_acandle10", "fire" },
    { "light_abedroom", "other" },
    { "light_abedroom01", "other" },
    { "light_abedroom_point", "other" },
    { "light_ablueroom8", "other" },
    { "light_abedroom_point01", "other" },
    { "light_abedroom02", "other" },
    { "light_abedroom03", "other" },
    { "light_aamb_sky", "sun" },
    { "light_hallway_lantern02", "fire" },
    { "light_hallway_lantern03", "fire" },
    { "light_hallway_lantern04", "fire" },
    { "light_apaigeroom06", "other" },
    { "light_hallway_lantern05", "fire" },
    { "light_hallway_lantern06", "fire" },
    { "light_apaigeroom10", "other" },
    { "light_aamb_hallway01", "other" },
    { "light_awindow_shadow", "other" },
    { "light_abedroom04", "other" },
    { "light_adoor_under01", "other" },
    { "light_abedroom05", "other" },
    { "light_abedroom06", "other" },
    { "light_apaigeroom07", "other" },
    { "light_ablueroom9", "other" },
    { "light_ablueroom10", "other" },
    { "light_ablueroom7", "other" },
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
    "Michonne",
    "Norma",
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

--Relight Volumetrics
RELIGHT_HackyCameraVolumetrics_Settings =
{
    Samples = 256,
    SampleOffset = 0.05,
    SampleStartOffset = 1.0,
    FogColor = Color(0.04, 0.04, 0.04, 0.04)
};

--|||||||||||||||||||||||||||||||||||||||||||||||| RELIGHT SCENE CONFIGURATION INI ||||||||||||||||||||||||||||||||||||||||||||||||
RELIGHT_ConfigFileName_LevelPreset = RELIGHT_LevelsFolderName .. "/RELIGHT_M103_adv_johnsHouseInteriorUpstairs103.ini";
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
