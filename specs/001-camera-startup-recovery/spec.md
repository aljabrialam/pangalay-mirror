# Feature Specification: P0 Camera Mirror Startup

**Feature Branch**: `001-camera-startup-recovery`

**Created**: 2026-10-11

**Status**: Draft · awaiting owner review

**Input**: Owner request to add a camera permission request, aligned with F1 (P0) in `CODEX-FEATURES.md` and the report “camera is not workin”.

## User Scenarios & Testing

### User Story 1 - Start the camera mirror (Priority: P0)

A player starts the experience, grants camera access, and sees a live reflection that follows their upper-body movement so they can begin the dance.

**Why this priority**: Camera tracking is the central interaction in Pangalay Mirror.

**Independent Test**: On localhost or HTTPS with a working webcam, start a round, grant camera access, and confirm that a live pose is reflected in the avatar.

**Acceptance Scenarios**:

1. **Given** the app is open on localhost or HTTPS and the player has not yet granted camera access, **When** the player selects Start, **Then** the browser requests camera permission immediately, before loading the pose model.
2. **Given** camera permission is granted and pose tracking loads, **When** the player stands in view, **Then** the app shows live pose feedback and the mirrored avatar follows the player's arm movement.
3. **Given** the player declines camera access or camera setup fails, **When** startup cannot continue, **Then** the existing error message remains visible and the player can use the documented no-camera demo route.

### Edge Cases

- The browser blocks camera permission, the device has no camera, or the browser is outside a secure context; preserve the existing error message and no-camera demo route.
- Camera permission succeeds but MediaPipe or its model cannot load; leave the cover visible and do not start the round.
- The app is opened with the documented no-camera demo query parameter; this path must not request camera access.

## Requirements

### Functional Requirements

- **FR-001**: The app MUST request camera access only after the player chooses to start.
- **FR-002**: The app MUST initiate the browser's camera permission prompt immediately from the Start action, before loading the pose tracker or model.
- **FR-003**: When camera and pose tracking initialize successfully, the app MUST show the player a live mirrored pose reflection.
- **FR-004**: If camera setup fails, the app MUST preserve the existing error message and keep the round from starting.
- **FR-005**: Demo mode MUST NOT request camera access.
- **FR-006**: The camera session MUST remain client-side; the app MUST NOT record or upload video or frames.

### Key Entities

- **Camera session**: A temporary, player-started webcam stream used locally while the experience is active.
- **Pose tracker**: The in-browser component that estimates body landmarks from the camera stream.
- **Demo round**: The no-camera presentation path that demonstrates the four treasure catches and result screen.

## Success Criteria

### Measurable Outcomes

- **SC-001**: On localhost or HTTPS with camera permission and a working tracker, the player sees live pose feedback within 10 seconds of selecting Start.
- **SC-002**: When camera setup fails, the existing error message appears and the round does not start.
- **SC-003**: The `?demo=1` path still completes with four treasures and 1,000 points without requesting camera access.

## Assumptions

- The browser supports `getUserMedia` and the app is served from localhost or HTTPS.
- The first implementation remains within the existing static, single-file app and preserves its no-camera demo, keyboard controls, and required checks in `AGENTS.md` section 4a.
- Product scope follows `CODEX-FEATURES.md`: P0 F1 camera mirror startup only. F2 threshold tuning, F6 body-found gating, and P1/P2 features are separate tasks. The camera's current real-device behavior remains unverified.
