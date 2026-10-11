# Implementation Plan: Gesture-Based Avatar Choice

**Branch**: `003-gesture-avatar-choice` | **Date**: 2026-10-11 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `/specs/003-gesture-avatar-choice/spec.md`

## Summary

Add a post-body-found choice phase in the existing app. Show both current SVG avatars, narrate the choice with `choose.mp3`, and select an avatar after one corresponding visible wrist stays above its shoulder for 0.8 seconds. Selection advances to the next lesson state. Demo mode selects Girl without waiting.

## Technical Context

**Language/Version**: Browser JavaScript in the existing HTML module

**Primary Dependencies**: Existing MediaPipe Pose Landmarker, SVG avatar renderer, and shared audio player

**Storage**: None; selection is transient for a round

**Testing**: Existing `window.__selftest()` and full `?demo=1` round, plus a real-camera gesture check on localhost or HTTPS

**Target Platform**: Desktop browser with webcam; static site on localhost or HTTPS

**Project Type**: Single-file browser application

**Performance Goals**: Respond after 0.8 seconds of uninterrupted raised-hand input without blocking the animation loop

**Constraints**: Change only `app/index.html`; retain click-to-start for permission/audio unlock, but do not use click controls to select an avatar. Do not edit `film/`, gesture rules, avatar rig, camera flow, or cultural copy.

**Scale/Scope**: One selection phase, two avatar choices, one current player

## Constitution Check

- Cultural integrity: Pass. Reuse approved narration and labels without adding cultural claims.
- Preserve and extend: Pass. Add one phase to the existing single-file app and reuse its avatars/audio.
- Browser-first: Pass. No framework, backend, or data persistence.
- Verify behavior: Pass when the documented self-test, demo, and camera checks are run.
- Privacy: Pass. Use existing in-browser landmarks only; no recording or upload.

## Design

### Flow

`body` gate → `choose` phase → selected avatar → next lesson state. F8 will later place the stance lesson at that transition. Demo mode bypasses the hand hold and picks Girl.

### Input rule

Use the existing pose landmarks for shoulders (11, 12) and wrists (15, 16). Count one side only while that wrist is visibly above its corresponding shoulder. Require one side to remain valid continuously for 800 ms. Reset its hold on a visibility loss or wrist drop. If both sides satisfy the rule together, wait for an unambiguous single raised hand.

### UI and narration

Reuse the two avatar drawings and the shared voice player. Show both choices with the film's mapping: screen-left/left hand selects Boy; screen-right/right hand selects Girl. Play `choose.mp3` on entry. Do not make the avatar labels clickable.

## Project Structure

```text
app/index.html                 # Existing screen markup, phase state, loop, and event flow
specs/003-gesture-avatar-choice/
  spec.md
  plan.md
  tasks.md
  research.md
  data-model.md
  quickstart.md
```

**Structure Decision**: Preserve the current one-file app and keep this feature's state and UI in `app/index.html`.

## Complexity Tracking

No constitution violations.
