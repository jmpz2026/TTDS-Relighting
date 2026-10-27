--AUTO-RELIGHT GENERATED FILE (tools/autorelight/generate.py). Scene: adv_johnsHouseInteriorMainFire103 | class: interior/day
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
    { "light_fx_smokeSlip", "other" },
    { "light_fx_smokeSlip02", "other" },
    { "light_fx_muzzleFlashOLD", "other" },
    { "light_fx_muzzleFlash1old", "other" },
    { "light_fx_muzzleFlash2OLD", "other" },
    { "lightENV_skydome_amb", "sun" },
    { "lightENV_skydome_dirA", "sun" },
    { "lightENV_skydome_neg", "sun" },
    { "lightENV_skydome_sun", "sun" },
    { "lightENV_skydome_dirB", "sun" },
    { "light_fx_smokeLayer", "other" },
    { "light_fx_smokeLayer01", "other" },
    { "light_fx_smokeLayer02", "other" },
    { "light_fx_smokeLayer03", "other" },
    { "light_fx_smokeLayer04", "other" },
    { "light_fx_smokeLayer05", "other" },
    { "light_sky_amb", "sun" },
    { "light_0spot_wall01", "other" },
    { "light_0spot_wall02", "other" },
    { "light_aspot_gate", "other" },
    { "light_aspot_gate2", "other" },
    { "light_aspot_gate3", "other" },
    { "light_aspot_gate4", "other" },
    { "light_aspot_gate5", "other" },
    { "light_aspot_gate6", "other" },
    { "light_aspot_door", "other" },
    { "light_0spot_wall03", "other" },
    { "light_0spot_wall06", "other" },
    { "light_0spot_wall07", "other" },
    { "light_0spot_wall04", "other" },
    { "light_aspot_fountain", "other" },
    { "light_0spot_wall10", "other" },
    { "light_0spot_wall11", "other" },
    { "light_aspot_gate03", "other" },
    { "light_aspot_gate10", "other" },
    { "light_aspot_gate11", "other" },
    { "light_aspot_gate12", "other" },
    { "light_agateee", "other" },
    { "light_aAmb", "other" },
    { "light_fx_ceilingSmoke", "practical" },
    { "light_fx_flare", "other" },
    { "light_fx_flareFace", "other" },
    { "light_fx_flareSmoke", "other" },
    { "light_fx_molotovFlashOLD", "other" },
    { "light_fx_muzzleFlash01", "other" },
    { "light_fx_muzzleFlash02", "other" },
    { "light_fx_muzzleGabby", "other" },
    { "light_fx_muzzleMichonne", "other" },
    { "light_fx_muzzleNorma", "other" },
    { "light_fx_muzzleSam", "other" },
    { "light_fx_muzzleSiddiqOLD", "other" },
    { "light_fx_puddle", "other" },
    { "light_fx_puddle01", "other" },
    { "light_fx_puddle02", "other" },
    { "light_ui_prompts", "other" },
    { "light_adir", "other" },
    { "light_0spot_wall08", "other" },
    { "light_alamp", "practical" },
    { "light_alamp01", "practical" },
    { "light_alamp02", "practical" },
    { "light_alamp03", "practical" },
    { "light_alamp04", "practical" },
    { "light_ahouse_spot", "other" },
    { "light_ahouse_stairs_spot", "other" },
    { "light_ahouse_stairs_spot01", "other" },
    { "light_aspot_house", "other" },
    { "light_alamp05", "practical" },
    { "light_acandle", "fire" },
    { "light_acandle01", "fire" },
    { "light_acandle02", "fire" },
    { "light_acandle03", "fire" },
    { "light_acandle05", "fire" },
    { "light_ahouse_desk_spot", "other" },
    { "light_aspot_fountain01", "other" },
    { "light_aAmb_interior", "other" },
    { "light_ahouse_stairs_spot02", "other" },
    { "light_afireroom1", "fire" },
    { "light_afireroom2", "fire" },
    { "light_afireroom3", "fire" },
    { "light_bfire1", "fire" },
    { "light_bfire2", "fire" },
    { "light_bfire1_spot", "fire" },
    { "light_bfire3", "fire" },
    { "light_bfire4", "fire" },
    { "light_bfire5", "fire" },
    { "light_bfire6", "fire" },
    { "light_bfire7", "fire" },
    { "light_bfire8", "fire" },
    { "light_bfire9", "fire" },
    { "light_bfire10", "fire" },
    { "light_dfire11", "fire" },
    { "light_cfire1", "fire" },
    { "light_cfire2", "fire" },
    { "light_cfire3", "fire" },
    { "light_efire1", "fire" },
    { "light_efire2", "fire" },
    { "light_efire3", "fire" },
    { "light_efire5", "fire" },
    { "light_efire6", "fire" },
    { "light_efire7", "fire" },
    { "light_cdoor", "other" },
    { "light_alamp06", "practical" },
    { "light_d", "other" },
    { "light_dfire12", "fire" },
    { "light_cfire4", "fire" },
    { "light_dfire13", "fire" },
    { "light_d2", "other" },
    { "light_efire4", "fire" },
    { "light_UI_amb", "other" },
    { "light_alamp07", "practical" },
    { "light_bfire11", "fire" },
    { "light_abfire", "fire" },
    { "light_efire8", "fire" },
    { "light_alamp08", "practical" },
    { "light_alamp09", "practical" },
    { "light_adoor_spot", "other" },
    { "light_ahouse_stairs_spot04", "other" },
    { "light_ahouse_stairs_spot05", "other" },
    { "light_upstairs", "other" },
    { "light_amb_door", "other" },
    { "light_fx_muzzlePete", "other" },
    { "light_fx_muzzleSiddiq", "other" },
    { "light_fx_muzzleFlash1", "other" },
    { "light_fx_muzzleFlash2", "other" },
    { "light_fx_muzzleFlash", "other" },
    { "light_fx_molotovFlash", "other" },
    { "light_vfx_amb", "other" },
    { "light_acandle04", "fire" },
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
    "Norma",
    "Paige",
    "Oak",
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
RELIGHT_ConfigFileName_LevelPreset = RELIGHT_LevelsFolderName .. "/RELIGHT_M103_adv_johnsHouseInteriorMainFire103.ini";
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
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_choredMovementSamsRoom");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_choredMovementSamsRoom_parent");
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
