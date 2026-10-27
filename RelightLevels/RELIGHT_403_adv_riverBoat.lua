--AUTO-RELIGHT GENERATED FILE (tools/autorelight/generate.py). Scene: adv_riverBoat | class: exterior/day
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
    { "light_MAT_amb", "other" },
    { "light_SKY_ambB", "sun" },
    { "light_SKY_horizonSpotB", "sun" },
    { "light_SKY_sunPointB", "sun" },
    { "light_SKY_sunBroadLightB", "sun" },
    { "light_SKY_lightningPoint01B", "sun" },
    { "light_SKY_lightningPoint02B", "sun" },
    { "light_NODE_topDeck", "other" },
    { "light_ENV_ambFill", "fill" },
    { "light_ENV_D_moonKey", "sun" },
    { "light_7_amb", "other" },
    { "light_7_point", "other" },
    { "light_ENV_engine", "other" },
    { "light_ENV_fixture01", "practical" },
    { "light_ENV_fixture02", "practical" },
    { "light_ENV_fixture07", "practical" },
    { "light_ENV_fixture08", "practical" },
    { "light_ENV_fixture09", "practical" },
    { "light_ENV_fixture11", "practical" },
    { "light_ENV_fixture12", "practical" },
    { "light_ENV_navStern02", "other" },
    { "light_AMB_0", "other" },
    { "light_ENV_fireBarrel01", "fire" },
    { "light_FX_muzzleFlash", "other" },
    { "light_ENV_ambWaterNX", "fill" },
    { "light_ENV_ambWater", "fill" },
    { "light_ENV_interior_cell", "other" },
    { "light_gobo_interior_cell", "other" },
    { "light_ENV_navStern04", "other" },
    { "light_ENV_lightBounce01", "fill" },
    { "light_ENV_lightBounce02", "fill" },
    { "light_ENV_lightBounce03", "fill" },
    { "light_ENV_lightBounce04", "fill" },
    { "light_ENV_lightBounce05", "fill" },
    { "light_ENV_lightBounce06", "fill" },
    { "light_ENV_lightBounce07", "fill" },
    { "light_NODE_lowerDeckPart1A", "other" },
    { "light_NODE_lowerDeckPart2A", "other" },
    { "light_NODE_lowerDeckPart2B", "other" },
    { "light_ENV_fixture03", "practical" },
    { "light_ENV_fixture04", "practical" },
    { "light_ENV_starboard02", "fill" },
    { "light_ENV_port01", "fill" },
    { "light_ENV_starboard03", "fill" },
    { "light_ENV_port03", "fill" },
    { "light_ENV_starboard04", "fill" },
    { "light_ENV_port04", "fill" },
    { "light_ENV_sneakFill01", "fill" },
    { "light_ENV_stairFills01", "fill" },
    { "light_ENV_navStern06", "other" },
    { "light_ENV_interior_windowFill01", "fill" },
    { "light_ENV_interior_windowFill02", "fill" },
    { "light_ENV_interior_windowFill03", "fill" },
    { "light_ENV_interior_windowFill04", "fill" },
    { "light_ENV_interior_roomFill01", "fill" },
    { "light_ENV_interior_roomFill02", "fill" },
    { "light_ENV_interior_roomFill03", "fill" },
    { "light_ENV_interior_roomFill04", "fill" },
    { "light_ENV_interior_roomFill05", "fill" },
    { "light_NODE_secondFloor", "other" },
    { "light_ENV_interior_roomFill06", "fill" },
    { "light_ENV_D_moonTwoKey", "sun" },
    { "light_ENV_gunFire01", "fire" },
    { "light_ENV_gunFire02", "fire" },
    { "light_ENV_gunFire03", "fire" },
    { "light_ENV_gunFire04", "fire" },
    { "light_ENV_gunFire05", "fire" },
    { "light_ENV_P_spotLight01", "fill" },
    { "light_ENV_AmbBattle", "fill" },
    { "light_ENV_stairLight01", "fill" },
    { "light_ENV_boilerSpec01", "other" },
    { "light_ENV_lightBounce11", "fill" },
    { "light_ENV_interior_outsideCells01", "other" },
    { "light_ENV_stairLight02", "fill" },
    { "light_ENV_lightBounce12", "fill" },
    { "light_ENV_fixture13", "practical" },
    { "light_ENV_fixture15", "practical" },
    { "light_ENV_fixture05", "practical" },
    { "light_ENV_fixture17", "practical" },
    { "light_ENV_fixture18", "practical" },
    { "light_ENV_fixture16", "practical" },
    { "light_ENV_fixture06", "practical" },
    { "light_ENV_lightBounce13", "fill" },
    { "light_ENV_lightBounce14", "fill" },
    { "light_ENV_lightBounce15", "fill" },
    { "light_ENV_moonHit01", "sun" },
    { "light_ENV_engine01", "other" },
    { "light_ENV_engine03", "other" },
    { "light_ENV_moonHit02", "sun" },
    { "light_ENV_lightBounce16", "fill" },
    { "light_ENV_engine04", "other" },
    { "light_ENV_navStern03", "other" },
    { "light_ENV_navStern07", "other" },
    { "light_ENV_navStern08", "other" },
    { "light_ENV_navStern09", "other" },
    { "light_ENV_stairwell01", "fill" },
    { "light_ENV_stairwell02", "fill" },
    { "light_ENV_fireBarrel02", "fire" },
    { "light_AMB_00", "other" },
    { "light_ENV_ambFill01", "fill" },
    { "light_ENV_D_moonThreeKey", "sun" },
    { "light_ENV_fireBarrel06", "fire" },
    { "light_ENV_lightBounce17", "fill" },
    { "light_ENV_lightBounce18", "fill" },
    { "light_ENV_stairwellLight01", "fill" },
    { "light_ENV_stairwellLight02", "fill" },
    { "light_ENV_interior_roomFill07", "fill" },
    { "light_ENV_interior_outsideCells02", "other" },
    { "light_ENV_interior_outsideCells03", "other" },
    { "light_ENV_stairwellLight03", "fill" },
    { "light_ENV_moonHitMiddle01", "sun" },
    { "light_ENV_ambFill02", "fill" },
    { "light_ENV_lightBounce10", "fill" },
    { "light_ENV_ambFill03", "fill" },
    { "light_ENV_interior_outsideCells04", "other" },
    { "light_ENV_interior_outsideCells05", "other" },
    { "light_ENV_fireBarrel03", "fire" },
    { "light_ENV_fireBarrel04", "fire" },
    { "light_ENV_stairwellLight04", "fill" },
    { "light_ENV_lightBounce19", "fill" },
    { "light_ENV_fireBarrel07", "fire" },
    { "light_ENV_interior_outsideCellsBounce01", "fill" },
    { "light_NODE_cells", "other" },
    { "light_ENV_P_moonSpot01", "sun" },
    { "light_ENV_D_moonFourKey", "sun" },
    { "light_ENV_P_moonSpot02", "sun" },
    { "light_ENV_interior_windowFill05", "fill" },
    { "light_CHR_ClemKey01", "sun" },
    { "light_ENV_interior_roomFill08", "fill" },
    { "light_ENV_interior_outsideCellsBounce02", "fill" },
    { "light_ENV_interior_roomFill09", "fill" },
    { "light_ENV_sneakFill02", "fill" },
    { "light_ENV_sneakFill03", "fill" },
    { "light_ENV_sneakFill04", "fill" },
    { "light_ENV_sneakFill05", "fill" },
    { "light_ENV_sneakFill06", "fill" },
    { "light_ENV_sneakFill07", "fill" },
    { "light_ENV_sneakFill08", "fill" },
    { "light_NODE_topDeckFight", "other" },
    { "light_ENV_P_explosion01", "fill" },
    { "light_ENV_fixture01med", "practical" },
    { "light_ENV_stairLightmed01", "fill" },
    { "light_ENV_interior_outsideCells06", "other" },
    { "light_ENV_interior_outsideCells07", "other" },
    { "light_ENV_fixtureMed13", "practical" },
    { "light_ENV_lightBounceMED04", "fill" },
    { "light_ENV_fixture10", "practical" },
    { "light_ENV_moonHitMED02", "sun" },
    { "light_ENV_fixtureMED16", "practical" },
    { "light_ENV_stairwellLight05", "fill" },
    { "light_ENV_stairwellLight06", "fill" },
    { "light_ENV_fireBarrel05", "fire" },
    { "light_ENV_stairwellLightMED02", "fill" },
    { "light_ENV_interior_outsideCells08", "other" },
    { "light_ENV_P_moonSpotMED02", "sun" },
    { "light_ENV_interior_outsideCellsMED04", "other" },
    { "light_ENV_stairwellLight07", "fill" },
    { "light_ENV_interior_roomFill10", "fill" },
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
    "Lilly",
    "Violet",
    "Louis",
    "Omar",
    "Aasim",
    "Dorian",
    "James",
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

--Relight Lens Flare (only used when the scene has a sun light: light_SKY_sunPointB)
local RELIGHT_AUTO_SunLight = "light_SKY_sunPointB";
local RELIGHT_AUTO_LensFlareActive = false;

--Relight Volumetrics
RELIGHT_HackyCameraVolumetrics_Settings =
{
    Samples = 256,
    SampleOffset = 0.05,
    SampleStartOffset = 1.0,
    FogColor = Color(0.05, 0.05, 0.05, 0.05)
};

--|||||||||||||||||||||||||||||||||||||||||||||||| RELIGHT SCENE CONFIGURATION INI ||||||||||||||||||||||||||||||||||||||||||||||||
RELIGHT_ConfigFileName_LevelPreset = RELIGHT_LevelsFolderName .. "/RELIGHT_403_adv_riverBoat.ini";
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
            EnableLensFlare = true,
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
