# Feature Specification: Body Found Start Gate

**Feature Branch**: `002-body-found-check`

**Created**: 2026-10-11

**Status**: Draft · awaiting owner review

**Input**: F6 in `CODEX-FEATURES.md`: keep the dance from starting until the player's upper body is in camera view.

## User Scenarios & Testing

### User Story 1 - Get into camera view (Priority: P0)

After the player starts Pangalay Mirror, the app gives simple guidance while checking the live camera. It begins the first taught dance move only after the player is framed and stays visible briefly.

**Why this priority**: The Just Dance-style experience depends on tracking a player reliably before teaching and scoring gestures.

**Independent Test**: Start the camera round, test with nobody visible, test with elbows or wrists outside the frame, then stand waist-up in view and keep shoulders, elbows, and wrists visible for one second. Confirm the first teaching step begins only after the check succeeds.

**Acceptance Scenarios**:

1. **Given** camera startup succeeded but no person is visible, **When** the app checks pose landmarks, **Then** `#cap` says “Step into view so I can see your arms.” and the dance has not started.
2. **Given** a person is partly outside the camera frame, **When** one or more elbows or wrists cannot be tracked, **Then** `#cap` says “Take a step back.” and the dance has not started.
3. **Given** both shoulders, elbows, and wrists are visible, **When** they remain visible continuously for one second, **Then** `#cap` briefly confirms “Body found” and the first gesture lesson begins.
4. **Given** the app is in `?demo=1`, **When** the player starts, **Then** it skips the body-found gate and begins the demo round.
5. **Given** the body-found gate is waiting, **When** the player presses a force-gesture key (1–5), **Then** it skips the gate and applies the existing key safety net.

## Requirements

### Functional Requirements

- **FR-001**: The camera round MUST wait for the body-found gate before teaching the first gesture.
- **FR-002**: The gate MUST use visibility values for pose landmarks 11–16 (both shoulders, elbows, and wrists).
- **FR-003**: If no body landmarks are sufficiently visible, the app MUST show “Step into view so I can see your arms.” in the existing `#cap` element.
- **FR-004**: If shoulders are tracked but elbows or wrists are not sufficiently visible in frame, the app MUST show “Take a step back.” in `#cap`.
- **FR-005**: The app MUST require the tracked body to remain visible continuously for one second before beginning the first gesture lesson.
- **FR-006**: Once the gate succeeds, the app MUST show a brief “Body found” confirmation and continue into the existing teach → try → catch flow.
- **FR-007**: Demo mode and keys 1–5 MUST be able to bypass the gate; keys retain their existing forced-gesture behavior.
- **FR-008**: The gate MUST NOT change gesture thresholds, avatar rig, cultural copy, or camera/media architecture.

## Edge Cases

- Visibility drops during the one-second hold; restart the continuous visibility timer.
- The player is visible but only one side of the upper body is tracked; keep waiting and show actionable guidance.
- A forced-gesture key is pressed during the wait; continue with the existing keyboard safety-net behavior.
- The demo has no camera landmarks; skip the gate rather than waiting.

## Success Criteria

### Measurable Outcomes

- **SC-001**: With nobody in frame, the first gesture lesson never starts and the in-view instruction is displayed.
- **SC-002**: When elbows or wrists are not visible, the step-back instruction is displayed and the lesson remains blocked.
- **SC-003**: With landmarks 11–16 visible for one uninterrupted second, the confirmation appears and the first lesson starts.
- **SC-004**: The `?demo=1` round and forced keys 1–5 continue to work without waiting for camera visibility.

## Assumptions

- The app continues to run from localhost or HTTPS, and camera startup has succeeded before this gate begins.
- “Sufficiently visible” follows MediaPipe visibility values and image bounds; the initial threshold will be proposed in the implementation plan for owner review and tuned only from real-camera feedback.
- F7 intro, F8 stance, F2 gesture tuning, F10 avatar selection, and the Just Dance lane remain separate feature slices.
