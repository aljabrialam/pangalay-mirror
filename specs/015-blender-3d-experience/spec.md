# Feature Specification: Separate Blender 3D Experience

**Feature Branch**: `015-blender-3d-experience`

**Created**: 2026-10-12

**Status**: Approved — owner approved the spec and plan before implementation (2026-10-12)

**Input**: User request: make a separate Blender-based 3D version at `pangalay-mirror.vercel.app/app-3d` and leave the current app unchanged.

## User Scenarios & Testing

### User Story 1 — Play the 3D dance experience (Priority: P1)

As a visitor, I want to open a separate 3D version of Pangalay Mirror, start the camera or no-camera demo, and experience the existing dance round with a 3D player and coach avatar.

**Why this priority**: The 3D route must be a complete, independently playable experience to demonstrate the Blender work without changing the current production route.

**Independent Test**: Open `/app-3d/` directly on desktop and a supported phone. In demo mode, complete the round and reach results; with camera permission, confirm the player avatar follows pose landmarks and the coach demonstrates the move sequence.

**Acceptance Scenarios**:

1. **Given** a visitor opens `/app-3d/`, **When** the page loads, **Then** it presents the new 3D experience without redirecting to or replacing `/app/`.
2. **Given** the visitor chooses Start with camera, **When** they grant camera access, **Then** the 3D player avatar mirrors the detected upper-body movement and the coach avatar remains visible.
3. **Given** the visitor opens `/app-3d/?demo=1`, **When** they start the demo, **Then** the 3D route completes the existing four treasure catches, scoring, narrated stories, closing pose, results, and keepsake preview without requesting camera access.
4. **Given** a visitor denies camera access or their browser cannot create a 3D scene, **When** startup fails, **Then** the 3D route explains the recovery path and links to the existing 2D app as an alternative.

### User Story 2 — Choose and follow a 3D avatar (Priority: P2)

As a player, I want to choose the existing girl or boy avatar using the current gesture selection and see the selected 3D avatar persist through the round and keepsake preview.

**Why this priority**: Avatar choice is already part of the dance experience and should carry through the new rendering style.

**Independent Test**: In demo mode, choose each avatar with the existing selection flow; verify the selected character appears as the player throughout gameplay and in the keepsake preview.

**Acceptance Scenarios**:

1. **Given** the player reaches avatar selection, **When** they hold the existing selection gesture, **Then** the matching 3D avatar is selected without requiring a new click-based selection flow.
2. **Given** an avatar has been selected, **When** the player reaches results and keepsake, **Then** the selected 3D avatar is shown consistently.

## Edge Cases

- WebGL or 3D rendering is unavailable, fails to initialize, or loses its drawing context.
- A model or animation asset fails to load or is too large/slow for the device.
- The player denies camera access, the camera is in use, or MediaPipe initialization fails.
- A phone is in portrait orientation or has limited graphics memory.
- A 3D renderer failure must not prevent the existing `/app/` route from loading or working.
- Camera frames remain local; a renderer or model failure must not create an image upload path.

## Requirements

### Functional Requirements

- **FR-001**: The project MUST provide the 3D experience at `/app-3d/` as a separate static route.
- **FR-002**: Work for this feature MUST NOT change the behavior, source files, assets, or URL of `/app/` or `/app/timeline.html`.
- **FR-003**: The 3D route MUST include Blender-authored, rigged player and coach avatars in the existing visual style, exported in a format usable by the browser.
- **FR-004**: The player avatar MUST respond to the existing webcam pose tracking and mirror the player’s supported upper-body movements.
- **FR-005**: The route MUST preserve the current camera-consent flow, privacy behavior, gesture selection, four treasure catches, narration, score, result, keepsake preview, and `?demo=1` path.
- **FR-006**: The selected girl or boy avatar MUST remain consistent from selection through gameplay and the keepsake preview.
- **FR-007**: If camera or 3D setup fails, the route MUST show a recoverable explanation and provide a link to the working 2D app.
- **FR-008**: The route MUST work as a static deployment without a backend or new build step.
- **FR-009**: The 3D experience MUST be usable on desktop and supported mobile browsers in landscape orientation, with a readable unsupported-device fallback.
- **FR-010**: All camera processing MUST remain in-browser; the route MUST NOT record or upload camera frames.
- **FR-011**: Cultural text, move meanings, and treasure stories MUST be reused from the existing app and film; the 3D version MUST NOT add unreviewed cultural attire, dance claims, Tausug words, or script.

### Key Entities

- **3D Avatar**: A girl or boy character with a named rig, visual materials, and player/coach role.
- **Pose State**: The existing upper-body landmarks and joint angles used to animate the player avatar.
- **Round State**: Existing avatar selection, move timeline, treasure catches, score, narration, and result state reused by the 3D route.
- **Keepsake Preview**: The local end-of-round snapshot showing the player’s captured frame, selected avatar, score, treasures, profile, and QR code.

## Success Criteria

### Measurable Outcomes

- **SC-001**: `/app-3d/` loads directly and the existing `/app/` URL and files remain unchanged by the feature.
- **SC-002**: The no-camera demo completes all four treasure catches and reaches the result and keepsake preview on a WebGL-capable browser.
- **SC-003**: In camera mode on a reviewed desktop and phone, the player avatar follows detected arm movement without blocking the move timeline or narration.
- **SC-004**: On the reviewed mobile device, the 3D route remains responsive through one full round in landscape orientation; unsupported rendering displays a clear 2D-app link.
- **SC-005**: The keepsake preview includes the selected 3D avatar and existing local snapshot content, and no image is uploaded.
- **SC-006**: The new route and its assets require no server-side service or build command to deploy.

## Assumptions

- “Make it 3D” means Blender-authored 3D player and coach characters in the existing experience, while existing layout, copy, audio, timing, gesture rules, and cultural content are reused.
- The first version uses a lightweight stylized look derived from the current avatars, not photorealistic characters.
- The existing app’s supported arm movements are sufficient for the 3D avatar; full-body depth reconstruction is out of scope.
- The 3D experience will be deployed by adding a static `app-3d/` directory to the existing Vercel project.
- Blender 5.2.2 LTS is installed for creating or revising the native `.blend` sources.
