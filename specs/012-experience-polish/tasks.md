# Tasks: Dance Lane, Cultural Intro, and Keepsake Polish

**Input**: Design documents from `/specs/012-experience-polish/`

**Prerequisites**: `plan.md`, `spec.md`, `research.md`, `data-model.md`, `quickstart.md`

**Owner gate**: Do not begin application-code tasks until the owner approves the spec and plan.

## Phase 1: Baseline and shared constraints

- [X] T001 Record current `/app/` and `/app/timeline.html` behavior, profile assets, camera video availability at results, and self-test/demo outcomes in `docs/REVIEW-BEFORE-SUBMISSION.md`; do not edit `film/`.
- [X] T002 Preserve existing camera consent, gesture rules, rig, avatar choice, event timing, scoring, narration, story pauses, no-camera demo, and local-only image handling while implementing this feature in `app/index.html`.

## Phase 2: User Story 1 — Follow a livelier dance lane (Priority: P1)

**Goal**: Make the existing lane feel more like a dance game while preserving its event timing and feedback.

**Independent Test**: Run a full `?demo=1` round and confirm cue approach/current/hit/pause states animate clearly, the stories pause the lane, and the result remains four catches/1,000 points.

- [X] T003 [US1] Add smooth cue scrolling, a two-second approach glow/scale, fixed-marker pulse, and short catch feedback in `app/index.html` without changing `LANE_EVENTS` timing or score behavior.
- [X] T004 [US1] Add reduced-motion behavior and ensure lane motion does not cover the coach, camera view, or story card in `app/index.html`.
- [X] T005 [US1] Align `app/timeline.html` with the finished production lane.
- [X] T006 [US1] Run `window.__selftest()` and complete `?demo=1` on both app routes; confirm the eight existing cues, story pauses, four catches/1,000 points, and no console errors.

## Phase 3: User Story 2 — Learn who the Tausug are and where they live (Priority: P1)

**Goal**: Add the concept film's illustrated geographic context to the existing intro.

**Independent Test**: Reach or skip through the intro on a narrow and desktop viewport and verify the Tausug context, simplified map, Sulu Archipelago, and Jolo are visible before avatar choice and stance.

- [X] T007 [US2] Add a simplified inline map to the existing “Where” intro card in `app/index.html`, labeling the Sulu Archipelago, Jolo, Mindanao, and Borneo from the concept-film reference without editing `film/`.
- [X] T008 [US2] Adjust intro layout and responsive styles in `app/index.html` so the map, approved English context, and Skip control remain legible without overlap.
- [X] T009 [US2] Confirm intro completion/skip still reaches the gesture-based avatar choice and stance lesson in `app/index.html`.

## Phase 4: User Story 3 — Download a personal keepsake (Priority: P1)

**Goal**: Add the player's still and maker attribution to the existing result download.

**Independent Test**: In a camera session, download and inspect the keepsake for the player snapshot, avatar, score, caught treasures, Magsukul, and profile; in demo mode, confirm a usable fallback with an explicit no-camera-snapshot note.

- [X] T010 [US3] Compose a fresh mirrored still from the already-authorized video stream only inside the explicit download action in `app/index.html`; keep the image local and do not persist or upload it.
- [X] T011 [US3] Add the selected game avatar, score, caught treasures, supplied `assets/me.jpg`, approved profile line, short maker description, and LinkedIn address to the keepsake canvas in `app/index.html`.
- [X] T012 [US3] Add a graceful avatar-based download and visible no-camera-snapshot note when the video frame or profile image is unavailable in `app/index.html`.
- [ ] T013 [US3] Inspect the resulting PNG layout at its download size and verify profile details, snapshot, avatar, and game result remain readable.

## Phase 5: Polish, documentation, and final review

- [X] T014 [P] Update `README.md` and `docs/REVIEW-BEFORE-SUBMISSION.md` with lane polish, intro map, player snapshot, and profile behavior.
- [ ] T015 Run `git diff --check`; confirm there are no `film/` edits, no visitor-image upload/storage, and no new runtime dependency.
- [ ] T016 Publish the approved app change and verify the production `/app/` and `/app/timeline.html` routes and bundled local assets.

## Dependencies & Execution Order

- T001–T002 establish baseline and constraints after owner approval.
- User Story 1 precedes User Story 2 and User Story 3 because the app routes share one HTML source and should be synchronized before final review.
- User Story 2 and User Story 3 both modify `app/index.html`; implement them sequentially to avoid conflicting edits.
- T014–T016 follow implementation and required checks.

## Parallel Opportunities

- No application tasks are parallelizable: lane, intro, and keepsake behavior share the same single-file app. Documentation T014 can be prepared after app behavior is stable.

## Implementation Strategy

1. Obtain owner approval of the spec and plan.
2. Animate the lane and validate the existing demo/scoring flow.
3. Add and review the map intro.
4. Add the local player snapshot and maker-profile keepsake with demo fallback.
5. Align both app routes, run required checks, then publish and verify.
