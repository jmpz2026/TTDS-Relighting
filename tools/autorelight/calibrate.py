"""Per-scene brightness calibration from in-game captures (step 3 of PLAN-relight-quality.md).

Reads the relight ON capture of each scene (capture.py names: <episode>_<scene>_ON[_<tag>].png), measures mean luma,
the share of crushed pixels (luma < 8) and of clipped pixels (luma > 250), and proposes a white_factor for
data/scene_classes.csv: below 1 brightens (levels white point lowered), above 1 darkens. Factors multiply the
current value and are clamped to 0.8-1.25. Frames that look like a loading screen (almost all black) are skipped.
When the vanilla capture (<episode>_<scene>_OFF.png) exists, the ON frame is judged against it, so scenes that are
dark by design (night, caves, fire) only change when the relight crushes or clips clearly more than the original.

Usage: python calibrate.py [--tag TAG] [--apply]
"""
import argparse
import csv
import sys
from pathlib import Path

from PIL import Image

HERE = Path(__file__).resolve().parent
CSV_PATH = HERE / "data" / "scene_classes.csv"
CAPTURES = Path.home() / "Tools" / "telltale" / "captures"

CRUSHED_LIMIT, CLIPPED_LIMIT = 0.35, 0.08   # without a vanilla capture
CRUSHED_EXTRA, CLIPPED_EXTRA = 0.15, 0.05  # with one: allowed increase over vanilla
LIFT, LOWER = 0.9, 1.08
CLAMP = (0.8, 1.25)


def measure(path):
    pixels = list(Image.open(path).convert("L").resize((320, 180)).get_flattened_data())
    n = len(pixels)
    return sum(pixels) / n, sum(p < 8 for p in pixels) / n, sum(p > 250 for p in pixels) / n


def propose(mean, crushed, clipped, vanilla=None):
    if mean < 3:
        return None, "suspect (black or loading frame)"
    if vanilla is not None:
        v_mean, v_crushed, v_clipped = vanilla
        if v_mean < 3:
            return None, "suspect vanilla frame"
        if clipped > v_clipped + CLIPPED_EXTRA:
            return LOWER, f"clipped {clipped:.0%} (vanilla {v_clipped:.0%})"
        if crushed > v_crushed + CRUSHED_EXTRA:
            return LIFT, f"crushed {crushed:.0%} (vanilla {v_crushed:.0%})"
        return 1.0, f"ok (crushed {crushed:.0%}, vanilla {v_crushed:.0%})"
    if clipped > CLIPPED_LIMIT:
        return LOWER, f"clipped {clipped:.0%}"
    if crushed > CRUSHED_LIMIT and mean < 40:
        return LIFT, f"crushed {crushed:.0%}"
    return 1.0, "ok"


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--tag", default="")
    parser.add_argument("--apply", action="store_true")
    args = parser.parse_args()
    suffix = f"_{args.tag}" if args.tag else ""

    with CSV_PATH.open(newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        fields, rows = reader.fieldnames, list(reader)

    changed = 0
    for row in rows:
        path = CAPTURES / f"{row['episode']}_{row['scene']}_ON{suffix}.png"
        if not path.exists():
            continue
        vanilla_path = CAPTURES / f"{row['episode']}_{row['scene']}_OFF.png"
        vanilla = measure(vanilla_path) if vanilla_path.exists() else None
        mean, crushed, clipped = measure(path)
        step, reason = propose(mean, crushed, clipped, vanilla)
        current = float(row.get("white_factor") or 1.0)
        if step is None or step == 1.0:
            print(f"{row['episode']} {row['scene']}: mean {mean:.0f}, {reason}")
            continue
        new = round(min(max(current * step, CLAMP[0]), CLAMP[1]), 3)
        print(f"{row['episode']} {row['scene']}: mean {mean:.0f}, {reason}, white_factor {current} -> {new}")
        if args.apply and new != current:
            row["white_factor"] = str(new)
            changed += 1

    if args.apply:
        with CSV_PATH.open("w", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(f, fieldnames=fields)
            writer.writeheader()
            writer.writerows(rows)
        print(f"updated {changed} scenes in {CSV_PATH.name}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
