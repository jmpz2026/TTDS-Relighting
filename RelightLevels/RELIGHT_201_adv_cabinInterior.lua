--AUTO-RELIGHT GENERATED FILE (tools/autorelight/generate.py). Scene: adv_cabinInterior | class: interior/day
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
    { "lights_environment", "other" },
    { "lights_candles", "fire" },
    { "light_ENV_A_02", "fill" },
    { "light_ENV_A_03", "fill" },
    { "light_ENV_P_10", "fill" },
    { "light_group_roomBathroom", "other" },
    { "light_ENV_S_02", "fill" },
    { "light_ENV_S_03", "fill" },
    { "light_ENV_S_06", "fill" },
    { "light_ENV_P_07", "fill" },
    { "light_group_roomLiving", "other" },
    { "light_ENV_S_10", "fill" },
    { "light_ENV_A_01", "fill" },
    { "light_ENV_S_11", "fill" },
    { "light_ENV_P_12", "fill" },
    { "light_group_roomUpstairsDouble", "other" },
    { "light_ENV_S_13", "fill" },
    { "light_ENV_S_09", "fill" },
    { "light_ENV_S_16", "fill" },
    { "light_ENV_S_17", "fill" },
    { "light_ENV_P_15", "fill" },
    { "light_ENV_P_25", "fill" },
    { "light_ENV_P_29", "fill" },
    { "light_ENV_P_30", "fill" },
    { "light_ENV_S_18", "fill" },
    { "light_ENV_S_20", "fill" },
    { "light_ENV_S_21", "fill" },
    { "light_ENV_S_23", "fill" },
    { "light_group_roomFishing", "other" },
    { "light_ENV_S_24", "fill" },
    { "light_ENV_S_25", "fill" },
    { "light_ENV_P_34", "fill" },
    { "light_ENV_S_26", "fill" },
    { "light_ENV_S_27", "fill" },
    { "light_ENV_P_40", "fill" },
    { "light_ENV_S_28", "fill" },
    { "light_group_roomUpstairsSmall", "other" },
    { "light_ENV_P_51", "fill" },
    { "light_group_roomKitchen", "other" },
    { "light_ENV_P_52", "fill" },
    { "light_ENV_P_54", "fill" },
    { "light_ENV_P_55", "fill" },
    { "light_ENV_P_59", "fill" },
    { "light_ENV_S_30", "fill" },
    { "light_ENV_S_31", "fill" },
    { "light_ENV_S_32", "fill" },
    { "light_ENV_S_33", "fill" },
    { "light_ENV_P_61", "fill" },
    { "light_ENV_P_62", "fill" },
    { "light_ENV_P_13", "fill" },
    { "light_ENV_S_14", "fill" },
    { "light_ENV_P_63", "fill" },
    { "light_ENV_P_64", "fill" },
    { "light_ENV_P_14", "fill" },
    { "light_ENV_P_65", "fill" },
    { "light_ENV_P_66", "fill" },
    { "light_ENV_P_19", "fill" },
    { "light_ENV_P_67", "fill" },
    { "light_ENV_P_20", "fill" },
    { "light_ENV_P_68", "fill" },
    { "light_ENV_P_41", "fill" },
    { "light_ENV_P_69", "fill" },
    { "light_ENV_P_70", "fill" },
    { "light_ENV_P_71", "fill" },
    { "light_ENV_P_72", "fill" },
    { "light_ENV_P_73", "fill" },
    { "light_ENV_P_17", "fill" },
    { "light_ENV_P_74", "fill" },
    { "light_ENV_P_75", "fill" },
    { "light_ENV_P_76", "fill" },
    { "light_ENV_P_77", "fill" },
    { "light_ENV_P_31", "fill" },
    { "light_ENV_P_78", "fill" },
    { "light_ENV_P_80", "fill" },
    { "light_ENV_P_81", "fill" },
    { "light_ENV_P_82", "fill" },
    { "light_ENV_P_83", "fill" },
    { "light_ENV_P_84", "fill" },
    { "light_ENV_P_85", "fill" },
    { "light_ENV_P_87", "fill" },
    { "light_ENV_P_88", "fill" },
    { "light_ENV_S_29", "fill" },
    { "light_ENV_P_53", "fill" },
    { "light_ENV_S_34", "fill" },
    { "light_ENV_P_89", "fill" },
    { "light_ENV_S_22", "fill" },
    { "light_ENV_S_35", "fill" },
    { "light_ENV_S_15", "fill" },
    { "light_ENV_P_90", "fill" },
    { "light_ENV_S_36", "fill" },
    { "light_ENV_S_19", "fill" },
    { "light_ENV_S_37", "fill" },
    { "light_ambEnlighten", "other" },
    { "light_ENV_A_Mirror", "fill" },
    { "light_ENV_P_86", "fill" },
    { "light_ENV_P_91", "fill" },
    { "light_ENV_S_12", "fill" },
    { "light_ENV_P_21", "fill" },
    { "light_ENV_S_38", "fill" },
    { "light_ENV_P_22", "fill" },
    { "light_ENV_S_39", "fill" },
    { "light_ENV_S_40", "fill" },
    { "light_ENV_S_41", "fill" },
    { "light_ENV_S_42", "fill" },
    { "light_VFX_A_candle01", "fire" },
    { "light_ENV_S_56", "fill" },
    { "light_ENV_S_57", "fill" },
    { "light_ENV_S_43", "fill" },
    { "light_ENV_P_16", "fill" },
    { "light_ENV_S_44", "fill" },
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
    "Luke",
    "Nick",
    "Pete",
    "Carlos",
    "Sarah",
    "Rebecca",
    "Alvin",
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
RELIGHT_ConfigFileName_LevelPreset = RELIGHT_LevelsFolderName .. "/RELIGHT_201_adv_cabinInterior.ini";
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
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_livingRoom");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_livingRoom_depth");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_livingRoom_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_upstairsLanding");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_upstairsLanding_depth");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_upstairsLanding_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_bathroom_number2");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_bathroom_number2_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_bathroom_number1");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_bathroom_number1_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_livingRoomB");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_livingRoomB_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_sewingMachine");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_sewingMachine_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_study");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_study_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_bedroom");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_bedroom_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_livingRoomDoors");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_livingRoomMiddle");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_livingRoomMiddle_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_livingRoomDoors_parent");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_livingRoomStairs");
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_nav_livingRoomStairs_parent");
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
