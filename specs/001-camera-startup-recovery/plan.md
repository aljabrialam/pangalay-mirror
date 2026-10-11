# Implementation Plan: P0 Camera Mirror Startup

**Branch**: `001-camera-startup-recovery` | **Date**: 2026-10-11 | **Spec**: [spec.md](spec.md)

**Input**: P0 F1 from `CODEX-FEATURES.md`: webcam body tracking drives the avatar like a mirror.

## Summary

The app already requests camera access, but only after loading MediaPipe. Move `getUserMedia` to the beginning of the Start action so the browser permission prompt appears immediately, then initialize the existing pose tracker with that stream. Rename the debug overlay's `dbg` DOM id because MediaPipe's bundled runtime invokes a global function named `dbg`, and the browser exposes `id="dbg"` as a conflicting non-function global. Preserve the single-file app, existing rig, `points()`, `angles()`, `detect()`, demo mode, and keyboard safety net. This slice does not tune tracking thresholds or add the separate F6 body-found check.

## Technical Context

**Language/Version**: Browser JavaScript (ES module)
**Primary Dependencies**: Existing MediaPipe Tasks Vision bundle and browser `getUserMedia`
**Storage**: None
**Testing**: Existing gesture self-test and complete `?demo=1` round from `AGENTS.md` section 4a; manual camera permission/live mirror check by owner
**Target Platform**: Modern browsers on localhost or HTTPS; demo target is a laptop webcam
**Project Type**: Static web application
**Performance Goals**: Prompt for camera permission as part of Start, then show live preview and mirror tracking after setup
**Constraints**: Change only `app/index.html`; no framework/build step; preserve demo and keys 1–5; do not alter `points()`, `angles()`, `detect()` or rig without evidence from a real-camera test; avoid global names that collide with MediaPipe runtime symbols
**Scale/Scope**: P0 F1 camera startup path only

## Constitution Check

- Cultural integrity: PASS; no cultural content changes.
- Preserve existing experience: PASS; edits the current startup path only.
- Browser-first: PASS; static browser APIs and existing MediaPipe files.
- Verify observable behavior: PASS after the two AGENTS.md checks and owner camera review.
- Privacy: PASS; retain current in-browser flow, no recording or upload.
- Owner review: REQUIRED before implementation, per `AGENTS.md`.

## Design

At the beginning of the Start click handler, request a video-only stream using the existing camera constraints. After that request resolves, load the existing MediaPipe runtime/model, assign the stream to the video element, and continue the current round startup. Use `debugOverlay` as the debug element id so MediaPipe's global `dbg()` call cannot resolve to the overlay element. If setup fails, keep the cover visible and retain actionable error text and the existing no-camera demo route. Do not add privacy copy, a new screen, F6 body-found gating, gesture tuning, or unrelated feature work in this slice.

## Project Structure

```text
app/index.html
specs/001-camera-startup-recovery/
├── spec.md
├── plan.md
└── tasks.md
```

**Structure Decision**: Keep the established single-file app and existing feature directory. No external contracts are introduced.

## Validation

1. Run `window.__selftest()` and confirm each gesture matches only its own rule.
2. Open `/app/?demo=1`, start the round, and confirm 1,000 points, four treasures, and no console errors.
3. On localhost/HTTPS with a camera, select Start and confirm the browser permission prompt appears before model loading; after Allow, confirm the camera preview and mirrored avatar.
4. Owner verifies camera behavior on the actual laptop/camera before moving on to F2 tuning.

## Complexity Tracking

No constitution violations.
