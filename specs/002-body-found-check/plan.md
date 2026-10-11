# Implementation Plan: Body Found Start Gate

**Branch**: `002-body-found-check` | **Date**: 2026-10-11 | **Spec**: [spec.md](spec.md)

**Input**: F6 from `CODEX-FEATURES.md`, requested as the next P0 step after camera startup.

## Summary

After the camera starts, wait for a stable upper-body pose before `reset()` begins the first gesture lesson. Use landmarks 11–16 visibility and image bounds, update the existing `#cap` guidance, and require one uninterrupted second of visibility. Keep `?demo=1` immediate and let keys 1–5 bypass the gate.

## Technical Context

**Language/Version**: Browser JavaScript (ES module)
**Primary Dependencies**: Existing MediaPipe Pose Landmarker
**Storage**: None; gate state lives in memory for the current start attempt
**Testing**: Existing gesture self-test and complete `?demo=1` round from `AGENTS.md` section 4a; simulate visibility dropouts; manually check camera framing on the target laptop
**Target Platform**: Modern desktop browser on localhost or HTTPS, one laptop webcam
**Project Type**: Static web application
**Performance Goals**: Begin the first gesture after 1,000 ms of uninterrupted visibility
**Constraints**: Change only `app/index.html`; preserve one-file app; no changes to `points()`, `angles()`, `detect()`, avatar rig, camera architecture, or cultural content
**Scale/Scope**: One pre-round gate for camera mode; demo and forced keys remain safety nets

## Constitution Check

- Cultural integrity: PASS; no cultural text or gesture meaning changes.
- Preserve existing experience: PASS; adds one small phase before the existing round.
- Browser-first: PASS; uses the existing local pose landmarks.
- Verify observable behavior: PASS after self-test and demo checks; camera framing still needs owner confirmation.
- Privacy: PASS; pose visibility is processed in memory and no frames are stored or uploaded.
- Owner review: REQUIRED before implementation, per `AGENTS.md`.

## Design

Add an ephemeral `bodyVisibleSince` timer. Once the camera round begins, `phase='body'` keeps the normal game flow paused while `loop()` checks the latest landmarks. Treat a landmark as visible when `visibility >= 0.5` and its normalized x/y coordinates are within `[0,1]`. If both shoulders (11, 12) are not visible, show “Step into view so I can see your arms.” If shoulders are visible but any elbow or wrist (13–16) is missing/out of frame, show “Take a step back.” When all six landmarks remain visible continuously for 1,000 ms, show “Body found ✓”, then call the existing `reset()` to begin the first teach step. Reset the timer on any visibility dropout. Demo start calls `reset()` directly. If a 1–5 key is pressed while waiting, call `reset()` to leave the gate and retain the existing forced pose behavior.

No data model or external contract is needed; all state is a timestamp and the existing phase variable. Do not move readiness checks into `frame()` or alter gesture detection.

## Project Structure

```text
app/index.html
specs/002-body-found-check/
├── spec.md
├── plan.md
└── tasks.md
```

**Structure Decision**: Continue the existing single-file app; this feature introduces no persistent data or new assets.

## Validation

1. `window.__selftest()` still returns only the matching rule for each of the five poses.
2. In `?demo=1`, Start skips the gate and the complete round reaches 1,000 points and four catches without console errors.
3. In camera mode, no person shows the in-view message; partial framing shows the step-back message; stable landmarks 11–16 start the first lesson after one second.
4. A visibility dropout resets the timer; keys 1–5 bypass the gate.

## Complexity Tracking

No constitution violations.
