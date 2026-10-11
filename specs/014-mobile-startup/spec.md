# Feature Specification: Mobile Browser Startup Reliability

**Feature Branch**: `014-mobile-startup`

**Created**: 2026-10-11

**Status**: Approved for implementation — real-device validation pending

**Input**: User report: “it’s not working in mobile browser”; clarified symptom: “App gets stuck or crashes.”

## User Scenarios & Testing

### User Story 1 — Start a camera round on a phone (Priority: P1)

As a mobile player, I want the camera game to start reliably after I tap Start and grant camera access, so I can play without the page freezing or closing.

**Why this priority**: The reported failure prevents mobile players from entering the experience at all.

**Independent Test**: On a supported mobile browser over HTTPS, tap Start, grant camera access, and confirm the app reaches its body-framing flow while reporting startup progress.

**Acceptance Scenarios**:

1. **Given** a supported mobile browser and camera permission, **When** the player taps Start, **Then** the app shows clear progress and reaches the existing framing flow without crashing.
2. **Given** the optional detailed hand tracker cannot run or is skipped to preserve mobile resources, **When** the player completes the game, **Then** the existing one-arm wrist-turn fallback remains available and the rest of the round works.
3. **Given** camera access or pose setup fails, **When** startup returns an error, **Then** the app explains the likely recovery step, releases any camera stream it opened, and lets the player retry or use the no-camera demo.
4. **Given** the app is open on a phone in portrait orientation, **When** the player is ready to dance, **Then** a clear prompt asks them to rotate to landscape so the 16:9 game is usable.

## Edge Cases

- The browser is not in a secure context or does not support camera access.
- The player denies camera access, or the camera is already in use.
- Mobile graphics acceleration cannot initialize the pose tracker.
- Optional hand tracking is unavailable, runs out of resources, or is deliberately omitted on a phone.
- The player taps Start repeatedly while camera or model setup is in progress.

## Requirements

### Functional Requirements

- **FR-001**: The app MUST guide a mobile player from Start to the existing camera framing flow without freezing or crashing on a supported browser.
- **FR-002**: The app MUST show the current startup stage while requesting camera access and preparing body tracking.
- **FR-003**: Failure to initialize optional hand tracking MUST NOT prevent the core dance game from starting; the documented one-arm fallback MUST remain usable.
- **FR-004**: When the primary body-tracking setup is unavailable, the app MUST attempt its documented supported fallback before reporting startup failure.
- **FR-005**: Startup errors MUST provide a clear recovery action, preserve the no-camera demo, and permit retry.
- **FR-006**: Any camera stream opened during a failed startup MUST be stopped before the player retries.
- **FR-007**: The app MUST prevent duplicate concurrent startup attempts.
- **FR-008**: Desktop behavior, camera consent, in-browser-only image handling, existing gesture rules, avatar rig, audio, scoring, and gameplay timing MUST remain unchanged.
- **FR-009**: A phone in portrait orientation MUST show a visible rotate-to-landscape prompt; the prompt MUST clear automatically when the device is in landscape.

### Key Entities

- **Startup attempt**: A single player-initiated session containing camera permission, body tracker setup, optional hand tracker setup, visible progress, and a recoverable success or failure state.

## Success Criteria

### Measurable Outcomes

- **SC-001**: On the reviewed mobile browser, a player who grants camera access reaches the framing flow without a stuck or crashed page.
- **SC-002**: If startup cannot proceed, the player sees a specific next step and can retry or launch demo mode without reloading the page.
- **SC-003**: A failed startup leaves no active camera stream behind.
- **SC-004**: The no-camera demo still completes its full round and reaches the result screen.
- **SC-005**: A phone-sized portrait viewport clearly directs the player to landscape instead of presenting the game as a tiny 16:9 strip.

## Assumptions

- Mobile players access the deployed app over HTTPS and use a browser that supports `getUserMedia`.
- The exact device/browser has not yet been identified; real-device review is required before claiming mobile camera support.
- The existing one-arm wrist-turn fallback is an acceptable mobile trade-off if detailed hand tracking uses too many resources.
- The game remains designed for landscape 16:9 play; phone portrait orientation provides guidance to rotate rather than a second fully reflowed game layout.
