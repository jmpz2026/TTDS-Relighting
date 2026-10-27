--AUTO-RELIGHT GENERATED FILE (tools/autorelight/generate.py). Scene: adv_johnsHouseExteriorLateNight | class: exterior/night
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
    local color_grade = Color(0.62, 0.75, 1.0, 1);
    local color_tint = Color(1, 1, 1, 1);
    local number_opacity = 0;

    if AgentGetProperty(agent_sceneAgent, "FX Color Enabled") == true then
        color_tint = AgentGetProperty(agent_sceneAgent, "FX Color Tint") or color_tint;
        number_opacity = AgentGetProperty(agent_sceneAgent, "FX Color Opacity") or 0;
    end

    AgentSetProperty(agent_sceneAgent, "FX Color Enabled", true);
    AgentSetProperty(agent_sceneAgent, "FX Color Tint", Color((color_tint.r + color_grade.r) / 2, (color_tint.g + color_grade.g) / 2, (color_tint.b + color_grade.b) / 2, 1));
    AgentSetProperty(agent_sceneAgent, "FX Color Opacity", math.max(number_opacity, 0.12));
    AgentSetProperty(agent_sceneAgent, "FX Levels Black Point", 0.01);
end

--Fog stays as the original scene has it.
RELIGHT_ApplyEnvironmentFogSettings = function(string_scene) end

--Light candidates found in the .scene file, with their rule category. Only agents that are real
--environment lights (have "EnvLight - Intensity") are changed, and every change is relative to the original value.
local RELIGHT_AUTO_Lights =
{
    { "lightENV_grassJohnsHouseExteriorLateNight", "other" },
    { "lightENV_treeBranches_amb", "other" },
    { "lightENV_treeBranches_key", "sun" },
    { "lightENV_treeRim", "other" },
    { "lightENV_brushJohnsHouseExteriorLateNight", "other" },
    { "lightENV_groundCoverJohnsHouseExteriorLateNight", "other" },
    { "lightENV_Exterior_Directional_01", "sun" },
    { "lightENV_Exterior_Ambient_01", "fill" },
    { "light_fx_flareOld", "other" },
    { "light_fx_flareSmokeold", "other" },
    { "light_fx_flareFaceOld", "other" },
    { "light_fx_muzzleFlashold", "other" },
    { "lightENV_skydome_amb", "sun" },
    { "lightENV_skydome_dirA", "sun" },
    { "lightENV_skydome_dirB", "sun" },
    { "lightENV_skydome_neg", "sun" },
    { "lightENV_Paige_dramaticHighlight_01", "other" },
    { "lightENV_JohnsHouse_InteriorGlow_01", "other" },
    { "lightENV_JohnsHouse_Gate_Glow_01", "other" },
    { "lightENV_windowsInterior", "other" },
    { "lightENV_JohnsHouse_InteriorGlow_02", "other" },
    { "lightENV_JohnsHouse_InteriorGlow_03", "other" },
    { "lightENV_FrontDoors_Illuminate_01", "other" },
    { "lightENV_FrontGates_Illuminate_01", "other" },
    { "lightENV_Grave_Highlight_01", "other" },
    { "lightENV_Grave_Highlight_02", "other" },
    { "lightENV_FrontGates_Illuminate_02", "other" },
    { "light_action", "other" },
    { "light_D", "other" },
    { "light_spot_door", "other" },
    { "light_a", "other" },
    { "light_amb", "other" },
    { "light_a01", "other" },
    { "light_a02", "other" },
    { "light_a03", "other" },
    { "light_a04", "other" },
    { "light_a06", "other" },
    { "light_a07", "other" },
    { "light_a08", "other" },
    { "light_a09", "other" },
    { "light_a10", "other" },
    { "light_a11", "other" },
    { "light_a12", "other" },
    { "light_a13", "other" },
    { "light_a14", "other" },
    { "light_a15", "other" },
    { "light_a16", "other" },
    { "light_a17", "other" },
    { "light_a18", "other" },
    { "light_a19", "other" },
    { "light_a21", "other" },
    { "light_a22", "other" },
    { "light_a23", "other" },
    { "light_a24", "other" },
    { "light_a25", "other" },
    { "light_a26", "other" },
    { "light_a27", "other" },
    { "light_a28", "other" },
    { "light_a29", "other" },
    { "light_a30", "other" },
    { "light_a31", "other" },
    { "light_a32", "other" },
    { "light_a33", "other" },
    { "light_a34", "other" },
    { "light_a35", "other" },
    { "light_a36", "other" },
    { "light_a37", "other" },
    { "light_a38", "other" },
    { "light_a39", "other" },
    { "light_a40", "other" },
    { "light_a41", "other" },
    { "light_a42", "other" },
    { "light_a43", "other" },
    { "light_a44", "other" },
    { "light_a45", "other" },
    { "light_a46", "other" },
    { "light_a47", "other" },
    { "light_a48", "other" },
    { "light_a49", "other" },
    { "light_a50", "other" },
    { "light_a51", "other" },
    { "light_ag52", "other" },
    { "light_ag53", "other" },
    { "light_ag54", "other" },
    { "light_ag55", "other" },
    { "light_ag58", "other" },
    { "light_ag57", "other" },
    { "light_ag59", "other" },
    { "light_ag60", "other" },
    { "light_ag61", "other" },
    { "light_ag62", "other" },
    { "light_ag64", "other" },
    { "light_ag65", "other" },
    { "light_ag66", "other" },
    { "light_ag67", "other" },
    { "light_ag68", "other" },
    { "light_ag69", "other" },
    { "light_ag71", "other" },
    { "light_ag73", "other" },
    { "light_ag76", "other" },
    { "light_ag77garage", "other" },
    { "light_ag78", "other" },
    { "light_ag79", "other" },
    { "light_ag80", "other" },
    { "light_a82", "other" },
    { "light_a83", "other" },
    { "light_a84", "other" },
    { "light_a85", "other" },
    { "light_a86", "other" },
    { "light_a87", "other" },
    { "light_a88", "other" },
    { "light_ag89", "other" },
    { "light_a90", "other" },
    { "light_a91", "other" },
    { "light_a92", "other" },
    { "light_a93", "other" },
    { "light_a94", "other" },
    { "light_ag95garage", "other" },
    { "light_a96", "other" },
    { "light_a97", "other" },
    { "light_a98", "other" },
    { "light_a100", "other" },
    { "light_a101", "other" },
    { "light_a102", "other" },
    { "light_a103", "other" },
    { "light_a104", "other" },
    { "light_a105", "other" },
    { "light_a106", "other" },
    { "light_a20", "other" },
    { "light_spot_fountain", "other" },
    { "light_spot_gate", "other" },
    { "light_spot_wall", "other" },
    { "light_spot_wall01", "other" },
    { "light_spot_wall02", "other" },
    { "light_spot_wall03", "other" },
    { "light_spot_wall04", "other" },
    { "light_spot_wall05", "other" },
    { "light_spot_wall07", "other" },
    { "light_spot_wall10", "other" },
    { "light_spot_wall11", "other" },
    { "light_a05", "other" },
    { "light_a81", "other" },
    { "light_amb_UI", "other" },
    { "light_fx_flare", "other" },
    { "light_fx_flareFace", "other" },
    { "light_fx_flareSmoke", "other" },
    { "light_fx_muzzleFlash", "other" },
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
    FogColor = Color(0.03, 0.035, 0.045, 0.03)
};

--|||||||||||||||||||||||||||||||||||||||||||||||| RELIGHT SCENE CONFIGURATION INI ||||||||||||||||||||||||||||||||||||||||||||||||
RELIGHT_ConfigFileName_LevelPreset = RELIGHT_LevelsFolderName .. "/RELIGHT_M102_adv_johnsHouseExteriorLateNight.ini";
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
        RELIGHT_DepthOfField_AddGameplayCameraName("cam_navCam_station_intruder");
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
