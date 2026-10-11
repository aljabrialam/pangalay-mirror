# Implementation Plan: Integrated Dance Gameplay and Treasure Hits

**Branch**: `011-dance-gameplay` | **Date**: 2026-10-11 | **Spec**: [spec.md](spec.md)

**Input**: Owner request to complete the reviewed gaps: make the timeline the default play experience and implement the flying treasure catch from F3.

## Summary

Bring the lane, game clock, filler cues, and Perfect/Good feedback from `app/timeline.html` into the default `app/index.html`. Preserve the main app's current camera, gesture, hand tracking, cultural content, and game flow. Add a visible treasure object and target ring for each of the four scored poses, animate each object toward the expected hand position, show hold progress on the target, and then use the existing catch/story/result flow. Keep the timeline route behavior aligned with the primary app. Publish the reviewed implementation to the existing Vercel deployment after verification.

## Technical Context

**Language/Version**: Browser JavaScript, ES modules, current supported desktop browsers

**Primary Dependencies**: Existing bundled MediaPipe Tasks Vision; no new package or runtime dependency

**Storage**: None; no server storage or visitor-image upload

**Testing**: Existing `window.__selftest()` and complete `?demo=1` round, syntax checks, asset checks, and browser review of both app routes

**Target Platform**: HTTPS static website on desktop Chrome/Safari; camera use requires user permission

**Project Type**: Static browser application

**Performance Goals**: Keep pose rendering and lane animation responsive at the existing animation-frame cadence; do not add a second pose inference pass

**Constraints**: Preserve one module script per HTML page, bundled local models/WASM, single shared voice player, no edits to `film/`, no gesture-threshold or avatar-rig changes, no tracking of more than one person, and no camera uploads

**Scale/Scope**: One visitor, five dance steps (four treasure catches and one close), eight lane markers, two static HTML app routes

## Constitution Check

- Cultural integrity: **PASS** — reuses approved gestures, existing wording, images, and voice clips; adds no Tausug text or claims.
- Preserve and extend: **PASS** — integrates the existing review lane and treasure assets into the existing app; no rewrite or build framework.
- Browser-first: **PASS** — static client-side app, local assets, no backend.
- Verify observable behavior: **PASS WITH REVIEW GATE** — run the documented self-test and demo round; keep physical camera and event-device checks explicit.
- Privacy and limitations: **PASS** — no image upload or persistence; camera flow remains permission-gated.

## Design Decisions

1. Treat the primary app as the production source of truth. Port the timeline behavior into it while preserving the main app's optional Hand Landmarker and fallback.
2. Keep the timeline event order and cue times from the concept film and current review copy. Use the existing lane clock, pause it while a treasure story is active, and reset it for each round.
3. Position each target from the existing target pose and SVG avatar rig so the ring follows the expected hand location. Do not change pose angles or gesture rules.
4. Reuse `film/tr0.png`–`film/tr3.png` and existing `hit()`/story behavior. Animate only the visual approach and hold feedback; keep the current 650 ms hold, score, and four-catch total.
5. Keep `/app/timeline.html` as a directly reviewable route with behavior matching `/app/`, rather than allowing it to become a stale alternate version.
6. Keep the existing Perfect/Good windows and neutral “Keep moving” feedback. Timing feedback does not determine whether a valid pose is caught.

## Project Structure

```text
app/
├── index.html       # Production entry point; lane and treasure interaction integrated here
├── timeline.html    # Review route kept behaviorally aligned with the production entry point
├── models/          # Existing locally bundled pose and hand models
└── vendor/          # Existing local MediaPipe JS/WASM runtime
film/                # Existing music, voice clips, and treasure imagery; read-only
docs/
└── REVIEW-BEFORE-SUBMISSION.md  # Add checks for the integrated lane and treasure targets
specs/011-dance-gameplay/        # Feature design and validation artifacts
```

**Structure Decision**: Continue the existing static single-file app design. No API, persistence, additional build tool, or new project directory is needed.

## Implementation Sequence

1. Integrate the existing timeline markup, styles, timing, and feedback into the main app while retaining Hand Landmarker detection from the current main file.
2. Add the treasure flight/target/hold visuals for the four gold steps and connect them to the existing score and narration flow.
3. Keep the direct timeline review route in sync with the completed production page.
4. Run local checks and inspect both HTTPS routes in demo mode. Then push the approved change and confirm the production deployment contains it.
5. Leave real-camera, real-speaker, Wi-Fi-off, and keepsake browser checks in the human review list; do not report those as verified without the event device.

## Risks and Mitigations

- **Lane and voice timing drift**: use one lane clock started by the first dance step and pause/resume it at the existing treasure-story state transition.
- **Treasure target misses the rendered hand**: derive the target from the same target pose and avatar rig transform; verify all four targets in a browser at the game's 16:9 stage size.
- **Timeline copy loses palm-turn support**: use `app/index.html` as the source when aligning `app/timeline.html`, preserving the optional hand detector and its fallback.
- **Offline model regression**: leave local model and WASM paths unchanged and verify requests target local files when available.

## Complexity Tracking

No constitution violations or new runtime components are proposed.

