"""Generate one RelightLevels/*.lua file per extracted scene, from rules.py.

Never overwrites an existing file (the hand-made 102/205 relights stay untouched) unless the file
carries the AUTO_MARKER, which means this script wrote it. Never deletes, hides or moves agents.

Usage:
  python generate.py [--episode 101]   generate
  python generate.py --check           validate every generated file (luac -p, no agent deletes, 102/205 hashes)
"""
import argparse
import csv
import json
import subprocess
import sys
from pathlib import Path

import rules

HERE = Path(__file__).resolve().parent
REPO = HERE.parents[1]
LEVELS = REPO / "RelightLevels"
DATA = HERE / "data"
LUAC = Path.home() / "Tools" / "telltale" / "script-editor" / "telltale-script-editor-win32-x64" / "resources" / "luac.exe"
AUTO_MARKER = "--AUTO-RELIGHT GENERATED FILE"
HAND_MADE = ["RELIGHT_102_adv_dairyMeatLocker.lua", "RELIGHT_205_adv_snowyPowerStation.lua"]
FORBIDDEN = ["AgentDestroy", "AgentHide", "AgentSetWorldPos", "AgentDuplicate"]


def lua_string_list(items, indent="    "):
    return "\n".join(f'{indent}"{item}",' for item in items)


def lua_bool(value):
    return "true" if value else "false"


def scene_settings(preset):
    lines = [f'    AgentSetProperty(agent_sceneAgent, "{k}", {v});' for k, v in {**rules.BASE_SCENE, **preset}.items()]
    return "\n".join(lines)


def light_table(lights):
    rows = []
    for name in lights:
        category = rules.light_category(name)
        if category != "skip":
            rows.append(f'    {{ "{name}", "{category}" }},')
    return "\n".join(rows)


def light_settings_table(space):
    rows = []
    for category, s in rules.LIGHT_SETTINGS.items():
        if space == "interior":
            s = {**s, **rules.INTERIOR_OVERRIDES.get(category, {})}
        rows.append(f'    {category} = {{ dimmer = {s["dimmer"]}, warm = {s["warm"]}, softness = {s["softness"]} }},')
    return "\n".join(rows)


TEMPLATE = """{marker} (tools/autorelight/generate.py). Scene: {scene} | class: {space}/{time}
--Edit tools/autorelight/rules.py or data/scene_classes.csv and regenerate instead of editing this file.
--To hand-tune this scene, delete the first line of this file so the generator stops overwriting it.

--|||||||||||||||||||||||||||||||||||||||||||||||| SCENE CHANGES ||||||||||||||||||||||||||||||||||||||||||||||||
--Auto relight never deletes, duplicates or moves agents (that broke progression in 102 Motor Inn).
RELIGHT_DeleteAgentsInScene = function(string_scene) end
RELIGHT_DuplicateAgentsInScene = function(string_scene) end
RELIGHT_TransformAgentsInScene = function(string_scene) end

RELIGHT_ApplySceneSettings = function(agent_sceneAgent)
{scene_settings}
end

--Color grade for the scene class: a light tint plus a slightly lower black point.
RELIGHT_AUTO_ApplyColorGrading = function(agent_sceneAgent)
    AgentSetProperty(agent_sceneAgent, "FX Color Enabled", true);
    AgentSetProperty(agent_sceneAgent, "FX Color Tint", {grade_tint});
    AgentSetProperty(agent_sceneAgent, "FX Color Opacity", {grade_opacity});
    AgentSetProperty(agent_sceneAgent, "FX Levels Black Point", {grade_black});
end

--Fog stays as the original scene has it.
RELIGHT_ApplyEnvironmentFogSettings = function(string_scene) end

--Light candidates found in the .scene file, with their rule category. Only agents that are real
--environment lights (have "EnvLight - Intensity") are changed, and every change is relative to the original value.
local RELIGHT_AUTO_Lights =
{{
{lights}
}};

local RELIGHT_AUTO_LightSettings =
{{
{light_settings}
}};

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
RELIGHT_DOF_AUTOFOCUS_Aperture = {aperture};
RELIGHT_DOF_AUTOFOCUS_GameplayCameraNames =
{{
  "Null"
}};
RELIGHT_DOF_AUTOFOCUS_ObjectEntries =
{{
{characters}
}};
RELIGHT_DOF_AUTOFOCUS_Settings =
{{
    TargetValidation_IsOnScreen = true,
    TargetValidation_IsVisible = true,
    TargetValidation_IsWithinDistance = true,
    TargetValidation_IsFacingCamera = true,
    TargetValidation_RejectionAngle = -0.1,
    TargetValidation_RejectionDistance = 18.5,
}};
RELIGHT_DOF_AUTOFOCUS_BokehSettings =
{{
    BokehBrightnessDeltaThreshold = 0.05,
    BokehBrightnessThreshold = 0.05,
    BokehBlurThreshold = 0.05,
    BokehMaxSizeClamp = 0.05,
    BokehFalloff = 0.75,
    MaxBokehBufferAmount = 1.0,
}};

--Relight Lens Flare (only used when the scene has a sun light: {sun_light})
local RELIGHT_AUTO_SunLight = {sun_lua};
local RELIGHT_AUTO_LensFlareActive = false;

--Relight Camera Particles
RELIGHT_CameraParticles_PropFile = "{particles_prop}";

--Relight Volumetrics
RELIGHT_HackyCameraVolumetrics_Settings =
{{
    Samples = 256,
    SampleOffset = 0.05,
    SampleStartOffset = 1.0,
    FogColor = {fog_color}
}};

--|||||||||||||||||||||||||||||||||||||||||||||||| RELIGHT SCENE CONFIGURATION INI ||||||||||||||||||||||||||||||||||||||||||||||||
RELIGHT_ConfigFileName_LevelPreset = RELIGHT_LevelsFolderName .. "/{ini_name}";
RelightConfigData_LevelPreset = nil;
local RELIGHT_ForceRebuildINI = false;

local RELIGHT_GenerateNewINI_LevelPreset = function(number_configurationVersion)
    local data =
    {{
        Version =
        {{
            ConfigurationVersion = number_configurationVersion,
        }},
        Main =
        {{
            EnableRelighting = true,
            EnableDepthOfField = true,
            EnableVolumetricLighting = true,
            EnableColorGrading = true,
            EnableFilmGrain = true,
            EnableLensFlare = {lens_flare},
            EnableCameraParticles = {particles},
            ExposureOffset = 0.0,
            DepthOfFieldAperture = {aperture},
        }},
    }};

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

    if RELIGHT_AUTO_Enabled("EnableFilmGrain") then
        AgentSetProperty(RELIGHT_SceneObjectAgentName, "FX Noise Scale", {grain});
    end

    if RELIGHT_AUTO_Enabled("EnableLensFlare") and (RELIGHT_AUTO_SunLight ~= nil) and (AgentFindInScene(RELIGHT_AUTO_SunLight, RELIGHT_SceneObject) ~= nil) then
        LensFlareEffect_FlareInstances = {{}};
        LensFlareEffect_SourcesCount = 1;
        LensFlareEffect_Sources = {{ Source1 = {{ LightAgentName = RELIGHT_AUTO_SunLight, LightOcclusionAngle = -0.25, LightIntensityModifier = 1.0 }} }};
        RELIGHT_LensFlareEffect_Initalize();
        RELIGHT_AUTO_LensFlareActive = true;
    end

    if RELIGHT_AUTO_Enabled("EnableCameraParticles") then
        RELIGHT_CameraParticles_Initalize();
    end

    if RELIGHT_AUTO_Enabled("EnableDepthOfField") then
{dof_cameras}
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

    if RELIGHT_AUTO_Enabled("EnableCameraParticles") then
        RELIGHT_CameraParticles_Update();
    end
end
"""


def load_classes():
    with (DATA / "scene_classes.csv").open(newline="", encoding="utf-8") as f:
        return {row["lua_file"]: row for row in csv.DictReader(f)}


def render(record, cls):
    space = cls["override_space"] or cls["space"]
    time = cls["override_time"] or cls["time"]
    preset, fog_color, aperture = rules.PRESETS[(space, time)]
    agents = set(record["agents"])
    characters = [c for c in dict.fromkeys(rules.CHARACTERS) if c in agents]
    nav_cameras = [c for c in record["cameras"] if "nav" in c.lower()]
    dof_cameras = "\n".join(f'        RELIGHT_DepthOfField_AddGameplayCameraName("{c}");' for c in nav_cameras)
    stem = record["lua_file"][:-len(".lua")]
    grade_tint, grade_opacity, grade_black = rules.GRADING[time]
    sun = rules.sun_light(record["lights"]) if space == "exterior" and time in rules.LENS_FLARE_TIMES else None
    particles_prop = rules.particles_for(record["scene"], space, time)
    return TEMPLATE.format(
        grade_tint=grade_tint, grade_opacity=grade_opacity, grade_black=grade_black, grain=rules.FILM_GRAIN_SCALE,
        sun_light=sun or "none", sun_lua=f'"{sun}"' if sun else "nil", lens_flare=lua_bool(sun is not None),
        particles_prop=particles_prop or "", particles=lua_bool(particles_prop is not None),
        marker=AUTO_MARKER, scene=record["scene"], space=space, time=time,
        scene_settings=scene_settings(preset), lights=light_table(record["lights"] + [
            a for a in record["agents"] if "lightshape" in a.lower() and a not in record["lights"]]),
        light_settings=light_settings_table(space), aperture=aperture, characters=lua_string_list(characters),
        fog_color=fog_color, ini_name=f"{stem}.ini", dof_cameras=dof_cameras,
    )


def is_ours(path):
    return path.exists() and path.read_text(encoding="utf-8", errors="replace").startswith(AUTO_MARKER)


def generate(episode):
    classes = load_classes()
    written, skipped = 0, []
    for path in sorted((DATA / "scenes").glob("*.json")):
        record = json.loads(path.read_text(encoding="utf-8"))
        if episode and record["episode"] != episode:
            continue
        target = LEVELS / record["lua_file"]
        if target.exists() and not is_ours(target):
            skipped.append(record["lua_file"])
            continue
        target.write_text(render(record, classes[record["lua_file"]]), encoding="utf-8", newline="\n")
        written += 1
    print(f"written {written}, kept hand-made {len(skipped)}: {skipped}")


def check():
    problems = []
    generated = [p for p in sorted(LEVELS.glob("*.lua")) if is_ours(p)]
    for path in generated:
        text = path.read_text(encoding="utf-8")
        result = subprocess.run([str(LUAC), "-p", str(path)], capture_output=True, text=True)
        if result.returncode != 0:
            problems.append(f"{path.name}: {result.stderr.strip()}")
        for word in FORBIDDEN:
            if word + "(" in text:
                problems.append(f"{path.name}: uses {word}")
    for name in HAND_MADE:
        if is_ours(LEVELS / name):
            problems.append(f"{name}: hand-made file was overwritten")
    diff = subprocess.run(["git", "-C", str(REPO), "diff", "--quiet", "--"] + [f"RelightLevels/{n}" for n in HAND_MADE])
    if diff.returncode != 0:
        problems.append("hand-made 102/205 files differ from git HEAD")
    print(f"checked {len(generated)} generated files, {len(problems)} problems")
    for line in problems:
        print("  " + line)
    return 1 if problems else 0


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--episode")
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    if args.check:
        return check()
    generate(args.episode)
    return 0


if __name__ == "__main__":
    sys.exit(main())
