# Tasks: Integrated Dance Gameplay and Treasure Hits

**Input**: Design documents from `/specs/011-dance-gameplay/`

**Prerequisites**: [plan.md](plan.md), [spec.md](spec.md), [research.md](research.md), [data-model.md](data-model.md), [quickstart.md](quickstart.md)

**Owner gate**: Do not begin application-code tasks until the owner approves the spec and plan.

## Phase 1: Setup and Baseline

- [X] T001 Confirm the local model, runtime, music, narration, and treasure image assets referenced by `app/index.html` are present; do not add dependencies or modify `film/`.
- [X] T002 Record baseline gesture self-test and demo-round behavior for `app/index.html` in `docs/REVIEW-BEFORE-SUBMISSION.md` before integration.

## Phase 2: Foundational Constraints

- [X] T003 Preserve the main app's current camera, body gate, avatar selection, optional Hand Landmarker, gesture rules, demo controls, scoring, and shared voice player while implementing this feature in `app/index.html`.

## Phase 3: User Story 1 — Follow the dance lane in the main app (Priority: P1)

**Goal**: Make the Just Dance style lane and timing feedback part of the primary app route.

**Independent Test**: A demo round on `/app/?demo=1` displays all eight markers in reference order, pauses during each treasure narration, produces timing feedback, and ends with the current four catches and 1,000 points.

- [X] T004 [US1] Port the timeline lane markup and styles from `app/timeline.html` into `app/index.html`, keeping the 16:9 lane legible at the existing target stage size.
- [X] T005 [US1] Port the lane event sequence, game clock, scrolling calculations, and Perfect/Good/neutral feedback into `app/index.html`; start the clock at round reset, pause it during treasure story state, stop it at results, and reset it on replay.
- [X] T006 [US1] Keep `app/timeline.html` behavior aligned with the production page after the lane integration, including the main page's Hand Landmarker and wrist-turn fallback.
- [X] T007 [US1] Run the gesture self-test and full `?demo=1` round in `app/index.html` and `app/timeline.html`; confirm all eight lane events, story pauses, timing labels, four catches, 1,000 points, and no console errors.

## Phase 4: User Story 2 — Catch a flying cultural treasure (Priority: P1)

**Goal**: Give each gold gesture a visible flying treasure target that responds to the player's hold before opening the existing story.

**Independent Test**: In demo mode, each of the four gold cues animates its matching treasure into the pose target, shows hold feedback, awards one catch, pauses for narration, and contributes exactly 250 points; the closing pose ends without a fifth treasure.

- [X] T008 [US2] Add a treasure image and target-ring layer to `app/index.html` for the four gold gesture cues, using the existing `film/tr0.png` through `film/tr3.png` assets and no target for the closing pose.
- [X] T009 [US2] Derive each target position from the corresponding `STEPS` pose and existing SVG avatar rig transform in `app/index.html`; place the crossed-arms target at chest height without changing pose angles or gesture rules.
- [X] T010 [US2] Animate the matching treasure into its target in `app/index.html`, show target/treasure feedback as the existing hold bar fills, and clear or reset the visual on step changes and replay.
- [X] T011 [US2] Connect successful holds to the existing one-time catch, score, story card, shared voice, and lane-pause flow in `app/index.html`; keep the closing step treasure-free.
- [X] T012 [US2] Run the gesture self-test and full demo round in `app/index.html` and `app/timeline.html`; confirm each treasure appears once, target feedback follows holds, each story pauses the lane, the result is four catches/1,000 points, and no console errors.

## Phase 5: Polish and Deployment

- [X] T013 [US2] Update `docs/REVIEW-BEFORE-SUBMISSION.md` and `README.md` to describe the production lane and treasure interaction and retain event-device checks as unverified until performed.
- [ ] T014 [US1] Verify `/app/` and `/app/timeline.html` on the production Vercel deployment after publishing the approved changes; confirm both routes serve the aligned app and local model assets.
- [ ] T015 [US2] Review `git diff --check` and confirm the final changes contain no edits under `film/`, no visitor-image upload, and no new runtime dependency.

## Dependencies & Execution Order

- T001–T003 establish the baseline and constraints.
- User Story 1 tasks T004–T007 complete before User Story 2 because the treasure encounter pauses and reports timing through the lane clock.
- User Story 2 tasks T008–T012 follow in order because target placement, animation, and catch-state connection share the main app file.
- T013–T015 follow both user stories.

## Parallel Opportunities

- None among application tasks: both stories modify the same module script and shared game state. Documentation updates can start after the behavior is stable.

## Implementation Strategy

1. Obtain owner approval of this spec and plan.
2. Integrate and validate the lane in the main app.
3. Add and validate treasure flight and target feedback.
4. Align the review route, update docs, run all documented checks, and publish the approved build.
5. Leave actual camera, event-speaker, Wi-Fi-off, and browser PNG checks in the owner's review checklist.

