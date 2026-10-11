# Feature Specification: Dance Lane, Cultural Intro, and Keepsake Polish

**Feature Branch**: `012-experience-polish`

**Created**: 2026-10-11

**Status**: Draft — owner review required before implementation

**Input**: User request to make the dance lane more animated in a Just Dance style, add the concept film's Tausug and Sulu Archipelago context with a map to the intro, and make the downloaded keepsake include the player's camera snapshot and the maker's profile as well as the game avatar.

## User Scenarios & Testing

### User Story 1 — Follow a livelier dance lane (Priority: P1)

During the dance, the player sees an energetic, readable move lane that makes the next gesture and its timing clear. Cues approach the fixed marker with distinct gold and flow styling, animate on the beat and on successful timing, and keep the current dance sequence and scoring.

**Why this priority**: The dance is the central interactive moment. The current lane is functional but visually static and too understated to deliver the requested Just Dance feel.

**Independent Test**: Complete a `?demo=1` round and observe all eight cues scroll and animate in order, see clear hit feedback on gold catches, and confirm all four treasures and 1,000 points remain unchanged.

**Acceptance Scenarios**:

1. **Given** the dance starts, **When** each cue approaches the fixed marker, **Then** the lane makes the active and upcoming cue visually distinct and readable.
2. **Given** a cue is approaching, **When** it enters the final two seconds before the marker, **Then** the cue gains a brief glow/scale emphasis and the fixed marker pulses without obscuring the player's camera view or coach.
3. **Given** a gold move is caught, **When** timing feedback appears, **Then** the lane gives a short celebratory pulse/burst response while preserving the existing Perfect/Good/neutral labels and score rules.
4. **Given** narration pauses the dance, **When** the treasure story plays, **Then** lane movement and dance-clock progression pause and resume together.
5. **Given** the round restarts or ends, **When** the lane is reset or hidden, **Then** animation, cue emphasis, and prior feedback return to their initial state.

### User Story 2 — Learn who the Tausug are and where they live (Priority: P1)

Before play, the visitor sees the existing introduction expanded with the concept film's map and clear context about the Tausug and their home in the Sulu Archipelago, with Jolo identified. The geographic visual helps a visitor unfamiliar with the region understand where the story takes place.

**Why this priority**: Introducing the people and place is central to the culture-learning goal; text alone does not provide the geographic context shown in the concept film.

**Independent Test**: Start the normal camera flow, wait for or skip through the introduction, and confirm the intro identifies the Tausug as “people of the current,” describes the Sulu Archipelago between Mindanao and Borneo with Jolo marked, and remains legible on desktop and mobile-sized screens.

**Acceptance Scenarios**:

1. **Given** a visitor reaches the introduction, **When** the “Who” card appears, **Then** it retains the approved English context about the Tausug and “people of the current.”
2. **Given** the “Where” card appears, **When** its map is shown, **Then** the map places the Sulu Archipelago in relation to the Philippines, Mindanao, Borneo, and labels Jolo.
3. **Given** the visitor skips or completes the introduction, **When** the next step begins, **Then** avatar selection, stance lesson, and game flow still work.
4. **Given** a visitor uses a narrow screen, **When** they view the intro, **Then** map labels and existing English text remain visible and readable.

### User Story 3 — Download a personal keepsake (Priority: P1)

At the end of a camera-played round, the visitor downloads a keepsake that combines a still image from their webcam with the selected game avatar, score/treasures, and a compact maker profile for Aljabri Alam. The app creates the image locally only after the visitor asks to download it.

**Why this priority**: The keepsake should preserve the visitor's own moment in the game and credit the Tausug maker whose story they experienced.

**Independent Test**: Complete a camera round, download the keepsake, and inspect that it includes the webcam snapshot, avatar, score, and maker profile. Confirm the file is generated in-browser and no image is sent to a server or saved by the app.

**Acceptance Scenarios**:

1. **Given** a camera-played round reaches results, **When** the visitor clicks Download my snapshot, **Then** the downloaded image includes a current still of the visitor from the already-authorized camera stream as well as the selected game avatar.
2. **Given** the keepsake is generated, **When** it is opened, **Then** it includes the existing score, caught treasures, Magsukul message, and a profile for Aljabri Alam with the approved line “Tausug · Technical Lead, VISEO Asia,” a short project-purpose description, profile portrait, and LinkedIn address.
3. **Given** the visitor has not clicked the download action, **When** the game is running, **Then** no keepsake image is generated or stored.
4. **Given** the app is in no-camera demo mode or the camera frame cannot be read, **When** the visitor downloads the keepsake, **Then** the app still downloads the avatar-based keepsake and clearly indicates that no player camera snapshot was included.
5. **Given** image rendering or profile image loading fails, **When** the visitor downloads, **Then** the app gives a clear error or falls back without losing the current score and result screen.

## Edge Cases

- If the browser camera stream has stopped or is not ready at download time, do not block the keepsake; clearly indicate that the player photo was unavailable.
- If the camera snapshot is mirrored for the on-screen preview, use the same mirrored orientation in the keepsake so it matches the player's experience.
- If a device has a small viewport, keep the map and introduction text from overlapping or clipping.
- If reduced-motion preference is enabled, reduce lane pulses and celebration motion while preserving cue timing and feedback.
- If the visitor downloads repeatedly, generate a fresh still on each explicit click; do not retain previous images in app storage.
- Do not change move order, cue times, gesture rules, score totals, cultural wording, narration, or source media as part of this feature.

## Requirements

### Functional Requirements

- **FR-001**: The dance lane MUST smoothly scroll cues, emphasize a cue during its final two seconds before the marker, pulse the fixed marker, and give caught and paused cues visually distinct states while preserving the eight-event sequence and existing timing.
- **FR-002**: Lane animations MUST remain readable and must not obscure the coach, player camera view, or treasure story card.
- **FR-003**: The lane MUST preserve the current Perfect/Good/neutral feedback, catch scoring, and story pause/resume behavior.
- **FR-004**: The introduction MUST present clear “Who” and “Where” context from the concept film, including the Tausug, “people of the current,” the Sulu Archipelago, and Jolo.
- **FR-005**: The introduction MUST include a map that identifies the Sulu Archipelago and Jolo in relation to Mindanao and Borneo, and remains legible at mobile and desktop viewport sizes.
- **FR-006**: The intro MUST remain skippable and MUST lead into the existing gesture-based avatar choice and stance lesson.
- **FR-007**: On an explicit keepsake download action, the app MUST include a still from the current authorized webcam stream when available, alongside the selected game avatar.
- **FR-008**: The keepsake MUST retain the score, caught treasures, Magsukul message, and game identity, and include the maker profile using the provided profile portrait and approved profile line, a brief description, and LinkedIn address.
- **FR-009**: Keepsake rendering MUST remain client-side; the webcam still MUST NOT be uploaded or persisted by the app.
- **FR-010**: If no camera frame is available, the app MUST still provide the keepsake and identify that it contains no player camera snapshot.
- **FR-011**: The app MUST preserve the no-camera demo, camera consent flow, avatar selection, four catches/1,000-point result, existing audio, and result/restart behavior.
- **FR-012**: The implementation MUST extend the current static app, keep `film/` unchanged, and add no backend, framework, or build step.

### Key Entities

- **Lane cue**: A timed gold, flow, or closing event with a position and animation state.
- **Intro place card**: Approved English cultural context paired with a geographic map and labels.
- **Keepsake**: A locally rendered downloadable image containing the player snapshot when available, selected avatar, result details, and maker attribution.
- **Maker profile**: Aljabri Alam's portrait, approved role line, short project description, and LinkedIn address.

## Success Criteria

### Measurable Outcomes

- **SC-001**: A full demo round displays all eight lane cues with smooth scrolling, a two-second approach emphasis, marker pulse, and short catch feedback while still ending at exactly four catches and 1,000 points.
- **SC-002**: The intro communicates both who the Tausug are and where the Sulu Archipelago is, with Jolo visibly identified, in a desktop and mobile-sized viewport.
- **SC-003**: A camera-played round downloads a single image containing a recognizable player snapshot, the selected avatar, result details, and maker profile.
- **SC-004**: A no-camera demo still downloads a complete avatar-based keepsake and explicitly indicates that the visitor snapshot is absent.
- **SC-005**: No webcam image is transmitted or retained by the app; snapshot creation occurs only after the visitor's download action.

## Assumptions

- “Your snapshot” means a still frame from the already-authorized webcam, captured locally when the visitor clicks Download my snapshot; it does not mean an uploaded or server-stored image.
- The existing `assets/me.jpg`, concept-film maker description, and owner profile details are approved source material for maker attribution.
- Proposed short keepsake description: “Tausug technologist sharing his people’s dance and culture through software.”
- The existing English intro wording and the concept film's map are authoritative. No new Tausug translation or script is added.
- A simplified original inline map is appropriate; it should communicate relative geographic context, not claim survey-grade precision.
- The keepsake remains downloadable when the app is in demo mode, with an explicit note when it has no visitor camera still.
- A restrained, reduced-motion-aware lane treatment is preferred over changing the soundtrack, dance timing, gesture rules, or score system.

## Out of Scope

- Editing the concept film or generating/uploading a QR code.
- Uploading, storing, or sharing visitor images.
- Adding new cultural claims, Tausug translations, gesture rules, dance choreography, or game scoring.
- Replacing the project's profile portrait or music assets.
