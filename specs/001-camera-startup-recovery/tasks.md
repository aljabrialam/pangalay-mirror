# Tasks: P0 Camera Mirror Startup

**Input**: Design documents from `/specs/001-camera-startup-recovery/`

**Prerequisites**: [plan.md](plan.md), [spec.md](spec.md)

## Phase 1: User Story 1 — Start the camera mirror (P0)

**Goal**: Start webcam access immediately from the Start action and preserve the existing live pose-to-avatar flow.

**Independent test**: On localhost/HTTPS, press Start and confirm the browser requests camera access before MediaPipe model loading; allow access and confirm a live mirrored avatar. Also run both checks in `AGENTS.md` section 4a.

- [X] T001 [US1] Move `getUserMedia` to the beginning of camera startup and pass the resulting stream into the existing tracker/video setup in `app/index.html`.
- [X] T002 [US1] Preserve camera setup error reporting and the existing no-camera demo route in `app/index.html`.
- [X] T003 [US1] Rename the debug overlay id to avoid the bundled MediaPipe runtime's global `dbg()` symbol in `app/index.html`.
- [X] T004 [US1] Run the gesture self-test and validate the `?demo=1` round reaches 1,000 points and four catches in `app/index.html`.
- [ ] T005 [US1] Open `/app/?demo=1` in a browser and confirm the result screen and console are clean.
- [X] T006 [US1] Have the owner verify the real camera permission prompt and mirrored tracking on the target laptop before proceeding to F2.

## Dependencies

- T001–T003 are coordinated edits in `app/index.html`; T004 follows implementation; T005 and T006 require browser/owner verification.

## Parallel Opportunities

- None; implementation tasks affect the same file. Browser and owner checks follow implementation.

## Implementation Strategy

Implement and review only the P0 F1 camera startup slice. Do not tune `points()`, `angles()`, `detect()` or the avatar rig in this task. Do not submit or deploy.
