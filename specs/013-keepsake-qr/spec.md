# Feature Specification: Keepsake QR Link

**Feature Branch**: `013-keepsake-qr`

**Created**: 2026-10-11

**Status**: Implemented; event-device verification pending

**Input**: User request to include a QR code in the keepsake export and automatically capture/show the keepsake preview after the dance, with download only on an explicit click.

## User Scenarios & Testing

### User Story 1 - Scan the keepsake to revisit the game (Priority: P1)

At the end of a round, the player sees a keepsake preview automatically. They can choose to download the image, and anyone who receives it can scan its QR code to open the live Pangalay Mirror app.

**Why this priority**: The keepsake should help players and judges return to the playable project after the in-person experience.

**Independent Test**: Complete a round and confirm the preview appears without a click. Download it, scan its QR code with a phone, and confirm it opens the live app.

**Acceptance Scenarios**:

1. **Given** a dance round ends, **When** the result screen appears, **Then** a keepsake preview is generated and shown without requiring a download click.
2. **Given** the preview is visible, **When** the player does not click Download, **Then** no keepsake file is downloaded.
3. **Given** the player clicks Download, **When** the preview is available, **Then** the same 1080×1350 PNG is downloaded with a visible, scannable QR code linking to `https://pangalay-mirror.vercel.app/app/`.
4. **Given** a keepsake is opened on a phone, **When** the phone camera scans its QR code, **Then** the browser opens the live app without requiring any camera image upload.
5. **Given** the player completes a round in no-camera demo mode, **When** the result screen appears, **Then** a preview with the no-camera note and QR code is shown.

### Edge Cases

- If the QR asset cannot be loaded while generating the keepsake, the PNG download should still complete and retain the ordinary keepsake content.
- If no usable camera frame is available at round end, show the existing no-camera fallback in the preview.
- The QR code must have sufficient contrast and a clear margin so it remains scannable at the downloaded image size.
- The QR code must not contain or encode the player's score, camera still, or other personal data.
- The preview and its camera still remain in memory only for the current result; they are not uploaded or written to persistent storage.

## Requirements

### Functional Requirements

- **FR-001**: A downloaded keepsake MUST show a QR code that opens the live Pangalay Mirror app at `https://pangalay-mirror.vercel.app/app/`.
- **FR-002**: The QR code MUST be included in keepsakes generated from both the primary app and the timeline review route.
- **FR-003**: When a round ends, the app MUST capture an available camera frame and show a composed keepsake preview on the result screen without requiring a click.
- **FR-004**: The app MUST download the preview as a PNG only after the player activates the download control.
- **FR-005**: If no camera frame is available, the app MUST show a usable avatar-based preview with a clear no-camera note.
- **FR-006**: The keepsake MUST remain downloadable if the QR image is unavailable.
- **FR-007**: QR generation and keepsake composition MUST NOT upload or persist the player's camera still or encode personal round data in the QR code.
- **FR-008**: The keepsake MUST include a short prompt identifying the QR code as the way to try the game.

## Key Entities

- **Keepsake**: The locally composed PNG containing a player's round details, existing profile attribution, and a link back to the live game.
- **Game link**: The public live app URL represented by the QR code.

## Success Criteria

### Measurable Outcomes

- **SC-001**: The preview appears on the result screen without an extra click after every completed round.
- **SC-002**: A PNG is downloaded only after the player activates the download control.
- **SC-003**: A QR scan from the downloaded PNG opens the live app on a phone in at least 3 consecutive scans.
- **SC-004**: The QR code and its call-to-action are visible and readable at the keepsake's native 1080×1350 resolution.
- **SC-005**: A keepsake preview and download work whether a camera snapshot is available or the player is in demo mode.

## Assumptions

- The QR code links to the current production app URL, `https://pangalay-mirror.vercel.app/app/`.
- The QR link is static and contains no player-specific values.
- The preview image is generated locally in the browser at round end, retained in memory while the result is shown, and downloaded only after the player's explicit action.
- The camera is already active during play; its latest usable frame is captured at round end. No new camera permission is requested for the keepsake.
