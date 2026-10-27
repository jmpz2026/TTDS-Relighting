"""Lighting rules for the auto relight generator.

Scene presets are curated subsets of the hand-made relights (102 Meat Locker for dark/interior looks,
205 Power Station for bright/exterior looks). Only post-process keys are copied; fog, ambient and color tint
stay as the original scene has them, because those are scene-specific.

Light rules are relative: the generated Lua reads the original value in game and applies a factor,
so the original art direction of each scene is kept.
"""
import re

# Post-process shared by every preset (antialiasing, sharper shadows, ambient occlusion on).
BASE_SCENE = {
    "FX anti-aliasing": "true",
    "FX TAA Weight": "0.1",
    "FX Levels Enabled": "true",
    "FX Sharp Shadows Enabled": "true",
    "HBAO Enabled": "true",
    "FX Tonemap Enabled": "true",
    "FX Tonemap Type": "2",
    "FX Vignette Tint Enabled": "true",
    "FX Vignette Tint": "Color(0, 0, 0, 1)",
}

# From 102 Meat Locker: dark, contrasty interior.
PRESET_102 = {
    "FX Levels White Point": "0.875",
    "FX Bloom Threshold": "-0.83",
    "FX Bloom Intensity": "0.03",
    "FX Tonemap Intensity": "0",
    "FX Tonemap White Point": "31.25",
    "FX Tonemap Black Point": "0",
    "FX Tonemap Filmic Pivot": "0.05",
    "FX Tonemap Filmic Sign": "1",
    "FX Tonemap Filmic Shoulder Intensity": "1.19",
    "FX Tonemap Filmic Toe Intensity": "0.46",
    "FX Tonemap Far Filmic Pivot": "0.1",
    "FX Vignette Falloff": "1.4",
    "FX Vignette Center": "0",
    "FX Vignette Corners": "0.99",
    "HBAO Intensity": "2.22",
    "HBAO Radius": "0.43",
    "HBAO Max Radius Percent": "0.2",
    "HBAO Hemisphere Bias": "0.05",
    "LightEnv Shadow Light Bleed Reduction": "0.8",
}

# From 205 Power Station: brighter filmic exterior.
PRESET_205 = {
    "FX Levels White Point": "0.67",
    "FX Bloom Threshold": "-0.19",
    "FX Bloom Intensity": "0.18",
    "FX Tonemap Intensity": "9.28",
    "FX Tonemap White Point": "126.36",
    "FX Tonemap Black Point": "-0.21",
    "FX Tonemap Filmic Pivot": "0.02",
    "FX Tonemap Filmic Sign": "0.14",
    "FX Tonemap Filmic Shoulder Intensity": "1.11",
    "FX Tonemap Filmic Toe Intensity": "0.53",
    "FX Tonemap Far Filmic Pivot": "0.59",
    "FX Vignette Falloff": "0.85",
    "FX Vignette Center": "-0.13",
    "FX Vignette Corners": "1.03",
    "HBAO Intensity": "1.92",
    "HBAO Radius": "2",
    "HBAO Max Radius Percent": "0.11",
    "HBAO Hemisphere Bias": "0.04",
    "LightEnv Shadow Light Bleed Reduction": "0.84",
}

# (space, time) -> scene preset, volumetric fog color, DOF aperture
PRESETS = {
    ("interior", "day"): (PRESET_102, "Color(0.04, 0.04, 0.04, 0.04)", 2.8),
    ("interior", "night"): (PRESET_102, "Color(0.03, 0.03, 0.035, 0.03)", 2.0),
    ("interior", "snow"): (PRESET_102, "Color(0.04, 0.045, 0.05, 0.04)", 2.8),
    ("exterior", "day"): (PRESET_205, "Color(0.05, 0.05, 0.05, 0.05)", 4.0),
    ("exterior", "night"): (PRESET_102, "Color(0.03, 0.035, 0.045, 0.03)", 2.8),
    ("exterior", "snow"): (PRESET_205, "Color(0.05, 0.05, 0.055, 0.05)", 4.0),
}

# Light categories, first match wins. Lights in a "skip" category are never touched
# (character rigs and per-camera shadow casters are tuned by Telltale per shot).
# dimmer: factor on "EnvLight - Intensity Dimmer"; warm: factor on red, inverse on blue;
# softness: value for "EnvLight - Shadow Softness" (only on lights that already cast shadows).
LIGHT_RULES = [
    ("skip", re.compile(r"(?i)char|rig|shadowlight|lightrotation|_cam_?\d|bloodfx|fx_blood|dots")),
    ("fire", re.compile(r"(?i)fire|flame|candle|torch|campfire|burn|ember|lantern")),
    ("practical", re.compile(r"(?i)lamp|bulb|fixture|ceiling|sconce|neon|sign|exit|tv|screen|fridge|machine|atm|flashlight|street")),
    ("sun", re.compile(r"(?i)sun|moon|sky|_env_d|direct|key")),
    ("fill", re.compile(r"(?i)fill|ambient|bounce|_env_a|_env_p|_env_s")),
]
LIGHT_SETTINGS = {
    "fire": {"dimmer": 1.25, "warm": 1.08, "softness": 0.3},
    "practical": {"dimmer": 1.15, "warm": 1.03, "softness": 0.5},
    "sun": {"dimmer": 1.10, "warm": 1.0, "softness": 0.2},
    "fill": {"dimmer": 0.85, "warm": 1.0, "softness": 0.6},
    "other": {"dimmer": 1.0, "warm": 1.0, "softness": 0.5},
}
# Interiors: sunlight through windows already blows out floors (101 clementineHouseInterior), keep it as is.
INTERIOR_OVERRIDES = {"sun": {"dimmer": 1.0}}

# Characters across all seasons, used as DOF autofocus targets when present in the scene.
CHARACTERS = [
    "Lee", "Clementine", "Kenny", "Katjaa", "Duck", "Carley", "Doug", "Glenn", "Larry", "Lilly", "Ben", "Hershel",
    "Shawn", "Irene", "Mark", "Andy", "Danny", "Brenda", "Jolene", "Chuck", "Omid", "Christa", "Molly", "Vernon",
    "Luke", "Nick", "Pete", "Carlos", "Sarah", "Rebecca", "Alvin", "Walter", "Matthew", "Sarita", "Bonnie", "Mike",
    "Arvo", "Jane", "Carver", "Troy", "Reggie", "Kate", "Gabe", "David", "Javier", "Mariana", "Ava", "Eleanor",
    "Conrad", "Tripp", "Max", "Joan", "Badger", "Lingard", "AJ", "Violet", "Louis", "Tenn", "Marlon", "Brody",
    "Mitch", "Willy", "Omar", "Ruby", "Aasim", "Rosie", "Lilly", "Abel", "Dorian", "James", "Michonne", "Pete",
    "Norma", "Randall", "Sam", "Paige", "Oak", "Greg", "Baby", "Baby_kenny", "Baby_clementine",
]


def light_category(name):
    for category, pattern in LIGHT_RULES:
        if pattern.search(name):
            return category
    return "other"
