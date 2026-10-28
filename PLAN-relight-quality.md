# Plan: Relight quality pass (lights/shadows, per-channel grading, per-scene calibration, skies/bokeh, texture spike)

## Context
Auto relight (branch `feat/auto-relight`, PR #3) generates 267 levels from fixed per-class values. Gaps found:
- Generator touches only `Intensity Dimmer`, red/blue warmth and `Shadow Softness` (generate.py:125). Hand-made 102 also sets
  `Shadow Quality`, `Shadow Type`, `Wrap`, `Enlighten Intensity`, `Intensity Specular` and scene `Specular * Multiplier`.
- Grading is one flat `FX Color Tint`. Engine has `FX Tonemap RGB *` (per-channel pivots/toe/shoulder/white) = real split toning.
- In-game tests: dusk/campfire exteriors crushed to black, interior sun blows floors. Cause: fixed values, no per-scene measure.
- `relight-mod/Relight_Assets_Custom` has 15 unused skies (`RELIGHT_Texture_SkyDay*`, `SkySunset*`, `SkyTwilight1`),
  cubemap `RELIGHT_Cubemap_spruit_sunrise`, `bokeh_anamorphic*.d3dtx`.
Goal: better lights, shadows, color, skies; fewer broken scenes, with no hand-tuning per scene.

## User decisions (2026-10-27)
- All four areas: fine lights/shadows, per-channel grading, per-scene auto-calibration, skies + bokeh.
- Textures: local spike only (AI upscale of a few .d3dtx in one scene), never in repo or PR (Telltale art).

## Steps (order = cheapest/safest first)

0. Volumetrics performance (user request, first)
   - Cause: `RELIGHT_Effect_HackyCameraVolumetrics.lua` spawns `Samples = 256` full-screen planes (scale 1000, cull off,
     alpha blend, receive shadows) every 0.05 m = 256 layers of overdraw + shadow lookup per pixel. ~14 FPS in test.
   - Fewer planes, same density: N planes with step S, plane alpha scaled by 256*0.05/(N*S) so total fog stays the same.
   - Non-linear spacing: dense near camera, sparse far (offset_i = start + range * (i/N)^1.6). Light shafts near camera keep detail.
   - Per-frame jitter: move the group by a random fraction of one step along camera forward each update; existing TAA
     (`FX TAA Weight`) blends it, removes banding from few planes.
   - Range per class from generate.py: interiors short (~6 m), exteriors ~16 m. Depth test already rejects planes behind walls.
   - Quality levels in Main ini `VolumetricQuality` (0 off, 1 low 24, 2 medium 48, 3 high 96, 4 ultra 256 = old look) +
     selector in `Menu_relight.lua`. Default medium.
   - Keep effect API backward compatible: 102/205 hand files set `Samples`/`SampleOffset`; quality level overrides only when set.
   - Measure FPS: PresentMon (install to C:/Users/Junior/Tools) during capture run, OFF vs each level, 2 scenes (1 interior, 1 exterior).
     Target: medium within ~10% of volumetrics OFF. Subagent compares look of medium vs ultra captures.

1. Lights and shadows (`rules.py` LIGHT_SETTINGS + generate.py light block)
   - New per-category fields, applied runtime-relative like today (read original, scale or set only if light already casts shadow):
     `shadow_quality` (sun 2, fire 2, practical 1), `shadow_type` soft for sun/fire only where already shadowed,
     `depth_bias` small factor on sun (acne), `wrap` (fill 0.3, key 0), `enlighten` factor (bounce GI; fill 1.2, night 0.8),
     `specular` factor (practical/fire 1.2).
   - Scene specular per class in PRESETS: rain/night wet look (`Specular Multiplier Enabled` + intensity/exponent from 102 values, lower).
   - Main ini key `EnableHighQualityShadows` (default true) + toggle in `Menu_relight.lua`; false = skip quality/type changes (FPS).
2. Per-channel grading (`rules.py` GRADING -> RGB curves)
   - Per time class: `FX Tonemap RGB Enabled` + Toe/Shoulder/Pivot vectors (shadows cool, highs warm for day/dusk; cool for night).
   - Only on presets that own the tonemap (102/205 derived). LOWLIGHT presets keep scene tonemap, keep flat tint.
   - Optional season look multiplier (S1 warm, S4 desaturated via lower Color Opacity tint) in a `SEASON_LOOK` table.
   - Keep `EnableColorGrading` switch; RGB off when grading off.
3. Per-scene auto-calibration (`capture.py` + new `calibrate.py`)
   - `calibrate.py` reads ON captures (Pillow, no PNG in main chat): mean luma, % pixels < 0.02, % > 0.98.
   - Writes new CSV columns `exposure`, `white_point` (factors) in `scene_classes.csv`; classify.py keeps them like overrides.
   - generate.py multiplies `FX Levels White Point` / tonemap white by them. Rules: crushed > 25% -> lift; clipped > 8% -> lower; clamp 0.8–1.25.
   - Loop: capture batch (budget 10 min, saves backed up), calibrate, regenerate, recapture flagged only. Max 2 loops.
4. Skies and bokeh (spike first, go/no-go)
   - Spike: in-game dump (Load Any Level + small Lua) of agents with sky/skydome/backdrop names and their texture props in 3 exteriors (day, dusk, night).
   - GO: `SKY_TEXTURES` per time class in rules.py; generated Lua swaps texture via existing TLSE helper, behind `EnableCustomSky` (default false until reviewed).
   - Bokeh: `bokeh_anamorphic` option in menu (DOF page) that sets the bokeh texture prop already used in `RELIGHT_Effect_DepthOfFieldAutofocus.lua`.
   - NO-GO: drop skies, note in bitácora.
5. Texture spike (local only)
   - Extract ~5 .d3dtx from one scene (ttarchext id 67), convert to DDS, upscale x2 locally, rebuild d3dtx, local archive in game only.
   - Measure: visual diff (subagent), VRAM/FPS, file size. Result in bitácora; nothing committed. `.gitignore` the work folder.

## Critical files
- `tools/autorelight/rules.py`, `generate.py`, `classify.py` (keep new CSV columns), `capture.py`; new `calibrate.py`
- `relight-mod/WDC_pc_Menu_data/Menu_relight.lua` (2 toggles), `RELIGHT_RelightingConfiguration.lua` (new Main ini keys, config version 101 -> 102)
- Reuse: `TLSE_AgentNameSetProperty`, runtime-relative light block in generate.py, `build_archives.py`, capture.py save backup logic
- Never touch `RELIGHT_102_*` / `RELIGHT_205_*`.

## Risks
- Higher shadow quality costs FPS: menu switch, default decided after capture FPS check.
- RGB tonemap can fight scene tint: start subtle, review captures.
- Calibration by captures depends on camera/animation timing (seen in pilot): use mean of 2 shots, clamp factors.
- Sky agent may differ per scene or be baked into geometry: spike decides.

## Verification
- `generate.py --check` 0 problems; `luac -p` on menu scripts.
- `capture.py` before/after, 2 scenes per class + the known bad ones (201 clearingCampfire, 304 richmondSquareDusk, 101 clementineHouseInterior); subagent review returns text; user sees flagged only.
- `calibrate.py` report: crushed/clipped counts drop vs current build.
- In-game: menu toggles persist; Load Any Level still works.

## Execution notes
- Write `PLAN-relight-quality.md` in repo (plan, decisions, bitácora, next step), add pointer line in repo `CLAUDE.md`.
- One commit per step (1–4); step 5 no commit. Push to fork, update PR #3 only when user says.
- In-game tests only when user says. Back up saves before each batch.

## Next step
Step 3: fresh ON captures of the 10 scenes with vanilla captures, calibrate.py --apply, regenerate, recapture flagged.

## Bitácora
- 2026-10-27: Plan approved (all four areas, local texture spike, volumetrics performance first). Started step 0.
- 2026-10-27: Step 0 code done. Effect: Quality 1-3 = 24/48/96 planes over Range, spacing power 1.6, per-plane alpha 1-(1-a)^density (same transmittance), golden-ratio jitter per frame; Quality 4/nil = original 256. Range interior 6 m, exterior 16 m (rules.VOLUMETRIC_RANGE). Main ini VolumetricQuality (default 0 = off, keeps the earlier OFF decision until FPS is measured), EnableVolumetricLighting global now true (hidden master). Menu row = quality selector. Config version 101 -> 102. 267 regenerated, check 0 problems. Not installed yet.
- 2026-10-28: Step 0 measured in game (2560x1440, FPS probe in Lua, game capped ~180). Interior/exterior avg FPS: no volumetrics 180/180, Low 163/178, Medium 113/133, High 70/86, Ultra 76/49. First build (color scaled linearly with alpha) gave too strong fog, beige haze and white halos (bloom), not caused by jitter. Fix: color scaled by (alpha ratio)^0.55 (ColorExponent), Jitter default 0. Subagent review: Medium and High close to Ultra, no halos/banding; Low OK interior, too strong/olive in exterior. Interior High costs more than Ultra (all 96 planes inside 6 m, Ultra planes mostly behind walls). Default stays Off. Pending: Low exterior tone-down, fewer planes for interior High.
- 2026-10-28: Volumetrics tuned per space (rules.VOLUMETRIC): interior High 64 planes (70 -> 97 FPS, now faster than Ultra 76), exterior Low exponent 0.42 (no olive cast, 178 FPS). Subagent: acceptable. Started step 1.
- 2026-10-28: Step 1 done, reduced. In-game diag: shadow casters already ship with Shadow Quality 2 and distance scale 10, so the quality/distance rules were a no-op (captures identical, FPS identical): removed with their menu toggle. Kept light specular (fire x1.2, practical x1.15). Wrap/Enlighten skipped (hand files use negative Enlighten values, meaning unclear). Next: step 2 (RGB grading).
- 2026-10-28: Step 2 dropped after in-game tests. FX Tonemap RGB with its defaults is neutral; per-channel white points shift the whole channel (only a second global tint, ~1% at safe values), black points unstable (+0.008 blue crushed 204 civilWarMemorialCenterMorning shadows 15 -> 5), toe/shoulder no visible effect. Flat FX Color tint stays.
- 2026-10-28: Step 3 code: calibrate.py (ON vs vanilla OFF capture: crushed/clipped increase -> white_factor 0.9 / 1.08, clamp 0.8-1.25; absolute rule without vanilla), white_factor CSV column kept by classify.py, generated RELIGHT_AUTO_ApplyCalibration (turns scene levels on neutral if off). Next: fresh ON captures, calibrate --apply, regenerate, recapture flagged.
