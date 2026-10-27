"""Classify every extracted scene as interior/exterior and day/night/snow.

Reads tools/autorelight/data/scenes/*.json and writes tools/autorelight/data/scene_classes.csv.
The columns override_space and override_time are kept across runs; when set they win over the heuristic.
"""
import csv
import json
import re
import sys
from pathlib import Path

DATA = Path(__file__).resolve().parent / "data"
CSV_PATH = DATA / "scene_classes.csv"
FIELDS = ["lua_file", "episode", "scene", "space", "time", "lights", "override_space", "override_time"]

INTERIOR_WORDS = ["interior", "office", "basement", "attic", "room", "locker", "inside", "kitchen", "bedroom",
                  "cabin", "barn", "store", "shed", "cellar", "train", "boxcar", "car", "bus", "sewer", "lodge",
                  "hall", "garage", "warehouse", "trailer", "tunnel", "cave", "stealth", "motorinn", "hideout",
                  "shop", "museum", "mobilehome", "hangar", "house", "medical", "safehouse", "apartment", "dorm",
                  "greenhouse", "memorialcenter"]
EXTERIOR_WORDS = ["exterior", "outside", "outskirts", "street", "woods", "forest", "field", "road", "farm",
                  "yard", "bridge", "river", "camp", "clearing", "highway", "porch", "roof", "dock", "courtyard",
                  "town", "square", "walls", "fence", "lake", "trainyard", "overlook", "hill", "tower", "truckstop",
                  "reststop", "gate", "underpass", "overpass", "deck", "wellington", "cages", "lawn", "shore"]
NIGHT_WORDS = ["night", "dark", "evening", "dusk"]
SNOW_WORDS = ["snow", "snowy", "winter", "frozen", "ice"]


def words(name):
    return re.sub(r"([a-z])([A-Z])", r"\1 \2", name).lower()


def guess(scene):
    tokens = set(re.split(r"[^a-z]+", words(scene)))
    flat = scene.lower()
    if any(w in flat for w in EXTERIOR_WORDS) and "interior" not in flat:
        space = "exterior"
    elif any(w in flat for w in INTERIOR_WORDS):
        space = "interior"
    else:
        space = "exterior"
    if tokens & set(SNOW_WORDS):
        time = "snow"
    elif tokens & set(NIGHT_WORDS):
        time = "night"
    else:
        time = "day"
    return space, time


def load_overrides():
    if not CSV_PATH.exists():
        return {}
    with CSV_PATH.open(newline="", encoding="utf-8") as f:
        return {row["lua_file"]: row for row in csv.DictReader(f)}


def main():
    old = load_overrides()
    rows = []
    for path in sorted((DATA / "scenes").glob("*.json")):
        rec = json.loads(path.read_text(encoding="utf-8"))
        space, time = guess(rec["scene"])
        prev = old.get(rec["lua_file"], {})
        rows.append({
            "lua_file": rec["lua_file"],
            "episode": rec["episode"],
            "scene": rec["scene"],
            "space": space,
            "time": time,
            "lights": len(rec["lights"]),
            "override_space": prev.get("override_space", ""),
            "override_time": prev.get("override_time", ""),
        })
    with CSV_PATH.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=FIELDS)
        writer.writeheader()
        writer.writerows(rows)
    print(f"classified {len(rows)} scenes into {CSV_PATH.name}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
