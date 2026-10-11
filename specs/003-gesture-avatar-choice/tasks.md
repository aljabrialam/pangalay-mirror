# Tasks: Gesture-Based Avatar Choice

**Input**: Design documents from `/specs/003-gesture-avatar-choice/`

**Prerequisites**: `plan.md`, `spec.md`

## Phase 1: User Story 1 - Choose an avatar with a hand gesture (P1)

**Goal**: Show both avatars after the body-found gate and select by a held one-hand gesture.

**Independent Test**: Left-hand hold selects Boy; right-hand hold selects Girl; interrupted or simultaneous holds select neither; demo automatically selects Girl and completes.

- [X] T001 [US1] Add the gesture-choice screen and phase state to `app/index.html`, removing click-to-select avatar controls while preserving Start with camera.
- [X] T002 [US1] Add per-side 0.8-second wrist-above-shoulder hold handling and reset behavior in `app/index.html`.
- [X] T003 [US1] Play `choose.mp3`, apply the selected avatar, and advance from the choice phase in `app/index.html`.
- [X] T004 [US1] Make demo mode choose Girl automatically and preserve the complete demo flow in `app/index.html`.
- [X] T005 [US1] Run `__selftest()` and the complete `?demo=1` round in the local harness.
- [ ] T006 [US1] Check both avatar gestures with a real camera on localhost or HTTPS.

## Dependencies & Execution Order

- T001 through T004 are a single-file implementation sequence and should be completed in order.
- T005 and T006 depend on all implementation tasks; T006 requires the owner's webcam review.

## Notes

- The owner approved the spec and plan before application code changes.
- F8 stance lesson remains a separate feature and will be inserted before the first dance gesture when implemented.
