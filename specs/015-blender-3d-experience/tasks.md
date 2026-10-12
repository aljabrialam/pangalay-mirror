# Tasks: Separate Blender 3D Experience

**Input**: Design documents from `/specs/015-blender-3d-experience/`

**Prerequisites**: Owner approves `spec.md` and `plan.md`; Blender is available for asset authoring.

## Phase 1: Setup

**Purpose**: Prepare an independent, static app route and pinned local renderer dependency.

- [X] T001 Create `app-3d/index.html` as an isolated copy of `app/index.html`; ensure no changes are made to `app/index.html` or `app/timeline.html`.
- [X] T002 Add the pinned Three.js runtime, GLTFLoader, and license notice under `app-3d/vendor/` without introducing a framework or build step.

## Phase 2: Foundational Assets

**Purpose**: Create browser-ready 3D characters before wiring webcam movement.

- [X] T003 Create a lightweight girl avatar Blender source and exported GLB with named shoulder, elbow, and wrist bones under `app-3d/models/`.
- [X] T004 Create a matching boy avatar Blender source and exported GLB under `app-3d/models/`; keep both initial GLBs at or below 8 MB combined.

## Phase 3: User Story 1 — Play the 3D dance experience (Priority: P1)

**Goal**: A visitor completes the existing dance journey on `/app-3d/` with player and coach rendered in 3D.

**Independent Test**: In `?demo=1`, start the 3D route, observe the coach/avatar sequence, complete all four catches and the closing pose, and reach the keepsake preview.

- [X] T005 [US1] Add the Three.js scene, lighting, camera, responsive render loop, and GLB loading to `app-3d/index.html`.
- [X] T006 [US1] Drive the player avatar's named armature bones from existing mirrored shoulder/elbow/wrist pose angles in `app-3d/index.html`.
- [X] T007 [US1] Drive the coach avatar using the existing move targets and preserve the move lane, timing, gesture rules, stories, scoring, and audio in `app-3d/index.html`.
- [X] T008 [US1] Preserve the no-camera demo and add recoverable WebGL/model failures with a link to `/app/` in `app-3d/index.html`.

## Phase 4: User Story 2 — Keep avatar choice through the round (Priority: P2)

**Goal**: Existing gesture selection chooses the corresponding 3D player avatar and the choice remains visible in the result.

**Independent Test**: Run both avatar choices in demo mode and check the selected model through gameplay and keepsake.

- [X] T009 [US2] Connect the existing gesture-driven avatar choice to the girl/boy GLB models without adding click-based choice controls in `app-3d/index.html`.
- [X] T010 [US2] Capture the selected 3D avatar from the rendering canvas and include it in the local keepsake preview in `app-3d/index.html`.

## Phase 5: Polish and Cross-Cutting Verification

**Purpose**: Verify privacy, static route isolation, device usability, and the required existing app behavior.

- [X] T011 [P] Verify `__selftest()` and the complete no-camera round on `/app-3d/`; document the results in `docs/REVIEW-BEFORE-SUBMISSION.md`.
- [X] T012 [P] Verify both existing app routes and confirm their tracked files are unchanged; run their required gesture self-test and demo checks.
- [ ] T013 Verify camera-denial recovery on a mobile browser; landscape and portrait guidance, model-load failure fallback, and local-only keepsake behavior are verified in the local browser.
- [ ] T014 Review `/app-3d/` on a physical phone; record device/browser, rendering responsiveness, and a full camera round in `docs/REVIEW-BEFORE-SUBMISSION.md`. Desktop render and full demo review are complete.

## Dependencies

- T001 and T002 establish the isolated route and renderer.
- T003 and T004 provide models required by T005.
- T005 precedes T006–T010.
- T011–T014 follow implementation; physical device validation is last.
- User story order: US1 → US2.

## Implementation Strategy

Build the route and renderer first, validate GLB loading, then connect the existing round behavior. Deliver the complete demo route before camera tracking and keepsake integration. Do not change the existing production route while implementing or testing the new one.

## Phase 6: Convergence

- [ ] T015 Run the 3D route on a physical phone: verify camera-denial recovery, full camera mirroring and round responsiveness in landscape; record device/browser and outcome in `docs/REVIEW-BEFORE-SUBMISSION.md` per FR-007, SC-003, and SC-004 (partial).
