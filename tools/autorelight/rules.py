"""Lighting rules for the auto relight generator.

Scene presets are curated subsets of the hand-made relights (102 Meat Locker for dark/interior looks,
205 Power Station for bright/exterior looks). Only post-process keys are copied; fog and ambient
stay as the original scene has them, because those are scene-specific. Each time class adds a light color grade
(FX Color Tint at low opacity, much lower than the 0.51 of 102) so night reads cool and dusk/fire read warm.

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

# Variants of the two curated presets for the extra time classes.
PRESET_DUSK = {**PRESET_205, "FX Levels White Point": "0.72", "FX Bloom Threshold": "-0.35", "FX Bloom Intensity": "0.22"}
PRESET_RAIN = {**PRESET_205, "FX Bloom Intensity": "0.10", "FX Tonemap Intensity": "7.5"}
PRESET_FIRE = {**PRESET_102, "FX Bloom Threshold": "-0.6", "FX Bloom Intensity": "0.08"}
PRESET_DARK = {**PRESET_102, "HBAO Intensity": "2.5"}
# Low-light exteriors keep the tonemap and levels of the original scene: both curated presets replace a
# vanilla tonemap (intensity 0, white point 1) and crushed 201 clearingCampfire and 304 richmondSquareDusk
# to black. Only ambient occlusion, a soft bloom and the vignette are added.
PRESET_LOWLIGHT = {
    "FX Bloom Threshold": "0.6",
    "FX Bloom Intensity": "0.12",
    "FX Vignette Falloff": "1.2",
    "FX Vignette Center": "0",
    "FX Vignette Corners": "0.95",
    "HBAO Intensity": "1.6",
    "HBAO Radius": "1",
    "HBAO Max Radius Percent": "0.15",
    "HBAO Hemisphere Bias": "0.05",
}
# None removes a BASE_SCENE key, so the scene keeps its own value.
LOWLIGHT_BASE_OFF = {"FX Tonemap Type": None, "FX Levels Enabled": None}
PRESET_FIRE_EXTERIOR = {**PRESET_LOWLIGHT, **LOWLIGHT_BASE_OFF, "FX Bloom Threshold": "0.45", "FX Bloom Intensity": "0.18"}
PRESET_DUSK_EXTERIOR = {**PRESET_LOWLIGHT, **LOWLIGHT_BASE_OFF}
PRESET_DARK_EXTERIOR = PRESET_205  # 404 cave looked right with it

# (space, time) -> scene preset, volumetric fog color, DOF aperture
PRESETS = {
    ("interior", "day"): (PRESET_102, "Color(0.04, 0.04, 0.04, 0.04)", 2.8),
    ("interior", "dusk"): (PRESET_102, "Color(0.045, 0.04, 0.035, 0.04)", 2.8),
    ("interior", "night"): (PRESET_102, "Color(0.03, 0.03, 0.035, 0.03)", 2.0),
    ("interior", "snow"): (PRESET_102, "Color(0.04, 0.045, 0.05, 0.04)", 2.8),
    ("interior", "fire"): (PRESET_FIRE, "Color(0.045, 0.035, 0.03, 0.04)", 2.0),
    ("interior", "rain"): (PRESET_102, "Color(0.035, 0.04, 0.045, 0.035)", 2.8),
    ("interior", "dark"): (PRESET_DARK, "Color(0.03, 0.03, 0.03, 0.03)", 2.0),
    ("exterior", "day"): (PRESET_205, "Color(0.05, 0.05, 0.05, 0.05)", 4.0),
    ("exterior", "dusk"): (PRESET_DUSK_EXTERIOR, "Color(0.06, 0.05, 0.04, 0.05)", 4.0),
    ("exterior", "night"): (PRESET_102, "Color(0.03, 0.035, 0.045, 0.03)", 2.8),
    ("exterior", "snow"): (PRESET_205, "Color(0.05, 0.05, 0.055, 0.05)", 4.0),
    ("exterior", "fire"): (PRESET_FIRE_EXTERIOR, "Color(0.045, 0.035, 0.03, 0.04)", 2.8),
    ("exterior", "rain"): (PRESET_RAIN, "Color(0.045, 0.05, 0.055, 0.05)", 4.0),
    ("exterior", "dark"): (PRESET_DARK_EXTERIOR, "Color(0.03, 0.03, 0.03, 0.03)", 2.0),
}

# time -> (FX Color Tint, FX Color Opacity, FX Levels Black Point). Applied only when color grading is on.
# Most scenes already have their own FX Color tint: the generated Lua blends that tint halfway to this one
# and keeps the higher opacity, so the original art direction stays.
GRADING = {
    "day": ("Color(1.0, 0.98, 0.95, 1)", 0.05, 0.005),
    "dusk": ("Color(1.0, 0.78, 0.55, 1)", 0.12, 0.01),
    "night": ("Color(0.62, 0.75, 1.0, 1)", 0.12, 0.01),
    "snow": ("Color(0.80, 0.90, 1.0, 1)", 0.08, 0.0),
    "fire": ("Color(1.0, 0.72, 0.45, 1)", 0.12, 0.0),
    "rain": ("Color(0.78, 0.85, 0.88, 1)", 0.10, 0.01),
    "dark": ("Color(0.75, 0.85, 0.80, 1)", 0.10, 0.0),
}
# Lens flare: exterior scenes with a sun light, in these time classes.
LENS_FLARE_TIMES = {"day", "dusk", "snow"}
SUN_LIGHT = re.compile(r"(?i)sun|directional|^light_d$|_env_d\b")

def sun_light(lights):
    for name in lights:
        if SUN_LIGHT.search(name) and light_category(name) == "sun":
            return name
    return None


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
