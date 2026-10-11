# Feature Specification: Gesture-Based Avatar Choice

**Feature Branch**: `003-gesture-avatar-choice`

**Created**: 2026-10-11

**Status**: Owner-approved; implementation complete, camera check pending

**Input**: Owner direction: show both avatars after the player steps into view and let them choose Boy or Girl by raising a hand, following the `choose` scene in `film/index.html`. The choice should happen by gesture, not by clicking an avatar.

## User Scenarios & Testing

### User Story 1 - Choose an avatar with a hand gesture (Priority: P1)

After the camera finds the player, both avatars appear with a clear prompt. The player raises and holds the corresponding hand to choose an avatar, then continues into the lesson and dance.

**Why this priority**: This makes the experience hands-free like the concept film and supports the intended Just Dance-style interaction.

**Independent Test**: On localhost or HTTPS with a camera, enter the body-found phase, hold the left hand above its shoulder for 0.8 seconds, and confirm Boy is chosen and the flow continues. Repeat with the right hand and confirm Girl is chosen.

**Acceptance Scenarios**:

1. **Given** the player has passed the body-found check, **When** both avatar choices are shown and the player holds the left wrist above the left shoulder for 0.8 seconds, **Then** Boy becomes the selected avatar and the flow advances.
2. **Given** the player has passed the body-found check, **When** both avatar choices are shown and the player holds the right wrist above the right shoulder for 0.8 seconds, **Then** Girl becomes the selected avatar and the flow advances.
3. **Given** the player is choosing, **When** a raised hand drops below its shoulder before 0.8 seconds, **Then** no avatar is selected and the hold timer resets.
4. **Given** demo mode is active, **When** the round starts, **Then** Girl is selected automatically and the demo reaches the result screen.

## Edge Cases

- If no hand is held above its matching shoulder, remain on the choice screen and keep the prompt visible.
- If the raised wrist or shoulder is not visible, do not count that side's hold; reset its timer.
- If both hands are raised at the same time, do not choose arbitrarily; keep waiting for one unambiguous side.
- The initial Start action remains a click so the browser can request camera permission and unlock audio. Avatar selection itself has no click-to-select control.

## Requirements

### Functional Requirements

- **FR-001**: After the existing body-found check succeeds, the app MUST show both avatar choices and a hand-gesture instruction.
- **FR-002**: The app MUST play the existing `choose.mp3` narration through the shared voice player.
- **FR-003**: The app MUST select Boy when the mirrored screen-left wrist remains above its shoulder continuously for 0.8 seconds.
- **FR-004**: The app MUST select Girl when the mirrored screen-right wrist remains above its shoulder continuously for 0.8 seconds.
- **FR-005**: A hand hold MUST reset if the corresponding wrist or shoulder becomes unavailable or the wrist drops below shoulder height before the hold completes.
- **FR-006**: The avatar choice MUST be gesture-driven; the user MUST NOT need to click Girl or Boy to make the selection.
- **FR-007**: Once an avatar is selected, the app MUST continue to the next lesson state; when F8 is implemented, that state is the stance lesson before the first dance gesture.
- **FR-008**: Demo mode MUST select Girl automatically and preserve the complete demo round.
- **FR-009**: Existing camera permission behavior, body-found gate, gesture matcher, avatar rig, score, and cultural copy MUST remain unchanged.

## Key Entities

- **Avatar choice**: The transient selection of Boy or Girl for the current round.
- **Hand hold**: A continuous 0.8-second interval where one visible wrist is above its corresponding shoulder.

## Success Criteria

### Measurable Outcomes

- **SC-001**: Each avatar can be selected by the specified one-hand gesture in one uninterrupted 0.8-second hold.
- **SC-002**: A hold shorter than 0.8 seconds or a two-hand raise selects neither avatar.
- **SC-003**: The complete no-camera demo selects Girl automatically, reaches the result screen, and retains the existing score and treasure results.
- **SC-004**: The existing gesture self-test continues to return the expected unique match for every gesture.

## Assumptions

- The body-found check from F6 runs before this feature.
- The mapping follows the feature brief and mirrored on-screen directions: screen-left selects Boy; screen-right selects Girl.
- The voice clip `film/choose.mp3` and existing SVG avatars are reused.
- The opening Start action remains a click for camera permission and audio unlock; only avatar selection is hands-free.
- The stance lesson is a separate F8 feature and will be inserted between avatar choice and the first dance gesture when implemented.
