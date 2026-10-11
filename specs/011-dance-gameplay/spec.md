# Feature Specification: Integrated Dance Gameplay and Treasure Hits

**Feature Branch**: `011-dance-gameplay`

**Created**: 2026-10-11

**Status**: Draft — owner review required before implementation

**Input**: Complete the two gameplay gaps found during the makeathon review: bring the Just Dance style move lane into the default app and add the flying treasure encounter described in `CODEX-FEATURES.md` F3.

## User Scenarios & Testing

### User Story 1 - Follow the dance lane in the main app (Priority: P1)

When a visitor reaches the dance, they see the upcoming gold gestures, filler moves, and closing pose scroll toward a fixed marker in time with the music. A timing response appears when they catch a gold move. This lane is part of the default `/app/` experience, not a separate review-only page.

**Why this priority**: The current main app teaches one gesture at a time without the Just Dance lane. The lane is central to the makeathon experience the owner wants to deliver.

**Independent Test**: Open `/app/?demo=1`, complete a round, and confirm the lane appears during the dance, includes the full move sequence, pauses during treasure stories, and shows timing feedback without changing the final score or catch count.

**Acceptance Scenarios**:

1. **Given** the stance lesson has ended, **When** the first dance gesture begins, **Then** a lane with four gold gestures, three filler moves, and the closing pose is visible with a fixed timing marker.
2. **Given** the music and dance clock are running, **When** a move approaches, **Then** its pictogram scrolls toward the fixed marker in the order and timing of the reference film.
3. **Given** a treasure story is playing after a catch, **When** narration is active, **Then** both the dance clock and lane position pause and resume after the story.
4. **Given** a gold gesture is caught, **When** its catch time is within the defined timing window, **Then** the app shows the matching Perfect or Good response; outside those windows it shows the existing neutral timing response.
5. **Given** a visitor opens the default `/app/` route, **When** they start a round, **Then** the lane is part of that experience without visiting `/app/timeline.html`.
6. **Given** the round ends or restarts, **When** the next round starts, **Then** lane time, marker positions, and previous rating state reset.

### User Story 2 - Catch a flying cultural treasure (Priority: P1)

During each of the four gold gestures, the visitor sees that gesture's treasure fly toward a visible target. The coach shows the pose that reaches the target. As the visitor holds the gesture, the target responds to their progress; a successful hold catches the treasure, awards points, pauses the dance, and plays its existing story narration.

**Why this priority**: The existing app awards a catch after a pose match, but the visitor does not see an object to hit. The treasure encounter is the core playful link between movement and cultural storytelling.

**Independent Test**: In demo mode, complete all four gold gestures and the closing pose. Confirm one matching treasure appears per gold gesture, moves to its target, visibly responds during the hold, is caught once, and opens the existing story card and narration. Confirm the result remains 1,000 points with four treasures.

**Acceptance Scenarios**:

1. **Given** a gold gesture is being taught, **When** its cue begins, **Then** the matching treasure image flies into the scene toward the target associated with that gesture and a gold target ring marks the catch point.
2. **Given** the treasure is waiting at its target, **When** the visitor's pose begins matching the gold gesture, **Then** the target/treasure visibly reflects the existing hold progress.
3. **Given** the visitor holds the correct gesture for the existing hold duration, **When** the catch completes, **Then** the treasure is collected exactly once, the game clock pauses, the score increases by 250, and the existing treasure card and voice story play.
4. **Given** the visitor does not match the gesture, **When** the cue remains active, **Then** the treasure remains available and no score or story is awarded.
5. **Given** the crossed-arms gesture is active, **When** its treasure target appears, **Then** the target is positioned at the chest as specified in the feature brief.
6. **Given** the closing pose is active, **When** the visitor completes it, **Then** the round ends as it does today and no fifth treasure is introduced.

## Edge Cases

- If a cue advances because narration fails or its existing fallback timer fires, the lane and target must advance once and must not leave the old treasure visible.
- If the visitor breaks a hold briefly, retain the existing short grace period and reduce hold progress as currently implemented; do not award a catch twice.
- If a treasure image fails to load, preserve gesture recognition, score, narration, and the text treasure card.
- If a story clip fails, resume the lane and proceed to the next cue using the existing audio fallback behavior.
- Demo mode and keys 1–5 must continue to complete the round without camera access.
- A closing pose must not display a treasure target or alter the four-treasure total.

## Requirements

### Functional Requirements

- **FR-001**: The primary `/app/` dance experience MUST display the move lane during play.
- **FR-002**: The lane MUST show four gold gestures, three filler moves, and one closing pose in the order and timing defined by the concept film and existing timeline review copy.
- **FR-003**: The lane MUST use a fixed timing marker while move pictograms scroll toward it.
- **FR-004**: The dance clock MUST begin with the first dance gesture, pause while a caught treasure story is playing, resume afterward, and stop when the round ends.
- **FR-005**: A gold catch MUST show the existing Perfect/Good timing feedback windows; a catch outside them MUST show a neutral timing response without preventing the catch.
- **FR-006**: Each of the four gold gestures MUST present its matching treasure image moving toward a visible pose target before the catch.
- **FR-007**: The target position MUST correspond to the player's expected hand position for the gesture; the crossed-arms target MUST be at chest height.
- **FR-008**: The target and treasure MUST provide visible feedback as the existing hold timer fills.
- **FR-009**: A completed gold hold MUST collect one treasure, award 250 points once, pause the dance clock, and use the existing treasure card, narration, and score flow.
- **FR-010**: The closing pose MUST end the round without creating an additional treasure.
- **FR-011**: Existing camera framing, avatar selection, hand-tracked wrist-turn detection and fallback, no-camera demo, keyboard controls, intro, stance lesson, score, result, keepsake, and attract/restart behavior MUST remain available.
- **FR-012**: Camera frames MUST remain on the visitor's device; no visitor image may be uploaded or saved by the app.
- **FR-013**: `/app/timeline.html` MUST remain a working review route with gameplay behavior consistent with the primary app.

### Success Criteria

- **SC-001**: In a complete demo round, visitors see all eight lane markers in the reference order and the lane pauses for each treasure story.
- **SC-002**: Each of the four gold cues presents the matching treasure and target; a successful hold produces exactly one catch and one 250-point award.
- **SC-003**: A complete demo round still ends with four treasures and 1,000 points, with no console errors.
- **SC-004**: The default `/app/` route shows the dance lane without requiring a second URL.
- **SC-005**: All existing camera, avatar selection, hand tracking, demo, keyboard, restart, and keepsake behavior remains reachable after integration.

## Assumptions

- The existing `app/timeline.html` implementation and film `NOTES`/`MIDS` timing are the approved reference for the lane and ratings.
- Existing treasure images, gesture targets, narration clips, scoring, and hold duration remain authoritative; no new cultural copy or Tausug spelling is introduced.
- Filler lane markers are instructional cues only and do not add score or extra gesture steps to the current four-treasure round.
- The lane and treasure feedback are visual additions; camera tracking, gesture thresholds, avatar rig, and cultural text are not retuned in this feature.
- The target deployment remains the static Vercel site. The event laptop/camera review remains a required human check after implementation.

