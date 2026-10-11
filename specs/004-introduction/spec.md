# Feature Specification: Introduction

**Feature Branch**: `004-introduction`

**Created**: 2026-10-11

**Status**: Approved under owner's instruction to proceed with the remaining features

**Input**: F7 from `CODEX-FEATURES.md`: three narrated cards introducing who the Tausug are, where they live, and what the player will learn. Include a skip control and reuse the approved scripts and voice clips.

## User Scenarios & Testing

### User Story 1 - Hear a short introduction before playing (Priority: P1)

After the body-found check, the visitor sees three concise cards in order. Each card plays its matching narration and advances when narration ends. The visitor can skip at any time and continue to avatar choice and the lesson.

**Why this priority**: It gives the dance context and cultural introduction before the interactive lesson.

**Independent Test**: Start with camera or demo mode, allow the three cards to complete, and confirm the avatar choice/game flow follows. Skip the introduction and confirm it advances immediately.

**Acceptance Scenarios**:

1. **Given** the body-found check has passed, **When** the introduction starts, **Then** the who, where, and today cards appear in order with `intro0`, `intro1`, and `intro2` narration.
2. **Given** an introduction card is playing, **When** its narration ends, **Then** the next card starts automatically.
3. **Given** any introduction card is visible, **When** Skip intro is activated, **Then** narration stops and the flow advances to avatar choice (or automatic Girl selection in demo mode).
4. **Given** demo mode is active, **When** the introduction completes or is skipped, **Then** the complete demo round reaches results.

## Edge Cases

- If an audio clip fails to load or play, advance to the next card rather than leaving the flow stuck.
- A delayed `ended` event or fallback timer must not advance twice.
- The three cards must fit within the existing 35-second F7 duration target.

## Requirements

### Functional Requirements

- **FR-001**: The app MUST present three cards in this order: who the Tausug are, where they live, and what the visitor will learn.
- **FR-002**: Each card MUST use its matching existing narration clip: `intro0.mp3`, `intro1.mp3`, then `intro2.mp3`.
- **FR-003**: Each card MUST advance when its narration ends.
- **FR-004**: A visible **Skip intro** control MUST be available throughout the introduction.
- **FR-005**: The introduction MUST take less than 35 seconds when not skipped.
- **FR-006**: Skipping or completing the introduction MUST continue into the avatar-choice flow; demo mode selects Girl automatically and continues the round.
- **FR-007**: The existing English narration copy and shared voice player MUST be reused; no new cultural claims or Tausug text may be introduced.
- **FR-008**: Camera startup, body-found checks, gesture matching, avatar selection, and the result score MUST remain functional.

## Success Criteria

- **SC-001**: All three cards appear in the specified order and use the matching clips.
- **SC-002**: Skip intro advances from each of the three cards without waiting for audio.
- **SC-003**: The no-camera demo reaches the result screen after completing or skipping the intro.
- **SC-004**: The introduction takes under 35 seconds without skipping.

## Assumptions

- Existing copy in `docs/VOICE-SCRIPTS.md` is authoritative.
- Existing `say()` and shared voice audio player are reused.
- F6 body check happens before the introduction; F10 avatar choice follows it.
