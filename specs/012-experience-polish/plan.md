# Implementation Plan: Dance Lane, Cultural Intro, and Keepsake Polish

**Branch**: `codex/012-experience-polish` (planned; owner review required before code changes) | **Date**: 2026-10-11 | **Spec**: [spec.md](spec.md)

**Input**: Approved feature scope will be the spec after owner review.

## Summary

Polish the existing dance lane with clear, motion-aware cue states and celebratory catch feedback; add a labeled Sulu Archipelago map to the existing “Who/Where” introduction; and update the downloadable keepsake to combine a locally captured webcam still, the selected avatar and result, and Aljabri Alam's profile. Continue extending the static single-file app and keep all camera pixels on the device.

## Technical Context

**Language/Version**: Browser JavaScript ES modules and CSS in one HTML file

**Primary Dependencies**: Existing MediaPipe Tasks Vision bundle; no new runtime dependency

**Storage**: None; generate the keepsake on a canvas in memory and download on explicit visitor action

**Testing**: Existing `window.__selftest()` and full `?demo=1` round, syntax checks, final keepsake content/render review where a browser permits

**Target Platform**: Current mobile and desktop browsers served from HTTPS; camera access requires user permission

**Project Type**: Static browser application

**Performance Goals**: Keep lane animation responsive within the existing animation-frame loop; do not add pose inference work

**Constraints**: Preserve one module script per app page, camera consent, single shared voice player, existing move timing/scoring/detection/rig, no visitor image upload/storage, no edits to `film/`, no build step or framework

**Scale/Scope**: One player, eight existing lane cues, three intro cards, one locally downloaded image, two aligned app routes

## Constitution Check

- Cultural integrity: **PASS** — reuse the concept film's approved English context and map labels; add no new Tausug words or claims.
- Preserve and extend: **PASS** — enhance the existing intro/lane/canvas keepsake in `app/index.html`; keep `film/` unchanged.
- Browser-first: **PASS** — map and keepsake remain static/client-side; no backend, upload, or dependency.
- Verify observable behavior: **PASS WITH HUMAN REVIEW** — preserve the documented self-test and demo checks; real camera snapshot quality still needs a device review.
- Privacy and limitations: **PASS** — capture a fresh still only from the already-authorized camera after an explicit download click; do not persist or transmit it; provide a no-camera fallback.

## Design Decisions

1. Use the existing lane clock and event array as the animation source. Add small CSS/SVG treatments for cue approach, the fixed marker, current-cue emphasis, pause state, and catch feedback; retain existing event timing and timing labels.
2. Respect `prefers-reduced-motion` by reducing pulses/transforms while keeping lane position and state understandable.
3. Extend the existing “Where” intro card with a compact inline SVG map. Base its simplified regional shapes and labels on the concept film's map, mark the Sulu Archipelago and Jolo, and label Mindanao and Borneo; do not edit or load `film/index.html` as app code.
4. Use the live `<video>` element for a fresh still only inside the visitor's click on Download my snapshot. Mirror it to match the app preview, compose it with the selected avatar and results, and immediately download the canvas output. Do not keep a blob, upload, or save a separate photo.
5. Use the supplied `assets/me.jpg` and project-approved profile wording. Include Aljabri Alam, “Tausug · Technical Lead, VISEO Asia,” a short description derived from the concept film, and `linkedin.com/in/aljabri-alam`.
6. If the video is absent/not ready (including demo mode), keep the download usable with the avatar and profile and visibly note that the player snapshot is unavailable.
7. Keep `app/timeline.html` aligned with the production route after changes.

## Project Structure

```text
app/
├── index.html       # Lane motion, intro map, and local keepsake composition
├── timeline.html    # Aligned review route
├── models/          # Existing local pose/hand models; unchanged
└── vendor/          # Existing MediaPipe bundle; unchanged
assets/me.jpg        # Supplied maker portrait
film/                # Existing context, audio, images; read-only
docs/REVIEW-BEFORE-SUBMISSION.md  # Update user review steps
specs/012-experience-polish/      # Feature design and validation artifacts
```

**Structure Decision**: Keep the project static and extend its current one-file application. No new module, service, or persistent data store is needed.

## Implementation Sequence

1. After owner approval, refine the lane's animated cue states and celebration while preserving the current event clock.
2. Add the labeled map to the intro's “Where” card using locally rendered SVG and existing story content.
3. Recompose keepsake on explicit download from the webcam still (if ready), existing avatar, result details, and maker profile.
4. Copy the finished app entry point to the aligned review route and update README/review checklist.
5. Run the required self-test and complete demo round after app changes, review diff and privacy behavior, then deploy only after the owner reviews the result.

## Risks and Mitigations

- **Camera still unavailable at results**: treat unavailable video dimensions/readiness as a non-fatal fallback and label the download clearly.
- **Snapshot unexpectedly saved/transmitted**: create and download the canvas only inside the click handler; do not upload or persist it.
- **Busy result composition**: use a fixed portrait layout with clear visual hierarchy; fit snapshot, avatar, score, and profile without obscuring Magsukul.
- **Map looks authoritative beyond its accuracy**: label it “Simplified map,” preserve the concept film's labels, and avoid precision claims.
- **Animation distracts from movement**: limit motion to lane/cue states, preserve coach/camera visibility, and respect reduced-motion preference.

## Complexity Tracking

No constitution violations or additional runtime components are proposed.
