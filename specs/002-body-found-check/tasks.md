# Tasks: Body Found Start Gate

**Input**: Design documents from `/specs/002-body-found-check/`

**Prerequisites**: [plan.md](plan.md), [spec.md](spec.md)

## Phase 1: User Story 1 — Get into camera view (P0)

**Goal**: Give the visitor clear framing guidance and start the dance only after their upper body is stable in view.

**Independent Test**: Camera mode waits with no person, gives step-back guidance for partial framing, then starts after landmarks 11–16 remain visible for one second. Demo mode and keys 1–5 bypass the gate.

- [X] T001 [US1] Add a one-second continuous visibility check for landmarks 11–16, using the plan's visibility and image-bound rules, in `app/index.html`.
- [X] T002 [US1] Add the body-wait phase and `#cap` guidance after camera startup; begin the existing first gesture lesson only after the check passes in `app/index.html`.
- [X] T003 [US1] Preserve `?demo=1` immediate startup and make keys 1–5 bypass the gate while retaining forced gesture behavior in `app/index.html`.
- [X] T004 [US1] Run the gesture self-test, simulate the complete `?demo=1` round, and simulate absent/partial body, one-second visibility, dropout reset, and key bypass.
- [ ] T005 [US1] Open `/app/?demo=1` in a browser and confirm the result screen and console are clean.
- [ ] T006 [US1] Verify the camera gate’s framing messages and one-second body-found transition on the target laptop before proceeding to F7.

## Dependencies

- T001 and T002 implement the camera gate in the same module; T003 preserves bypass paths; T004 follows implementation; T005 and T006 require browser/owner verification.

## Parallel Opportunities

- None; implementation tasks affect `app/index.html` and share the game phase state. Browser checks follow implementation.

## Implementation Strategy

Deliver the P0 F6 entry-flow gate only. Do not change gesture thresholds, avatar rig, pose angle mapping, cultural copy, or later Just Dance lane features in this slice.
