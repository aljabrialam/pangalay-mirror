# Feature Specification: Wrist Turn with Hand Tracking

**Feature Branch**: `010-wrist-turn-hand-tracking`
**Status**: Implemented with fallback; physical-camera verification pending
**Input**: F14 from `CODEX-FEATURES.md`.

## User Story
When the player reaches one arm out, turning the palm toward the camera satisfies the wrist-turn gesture using MediaPipe Hand Landmarker. If the hand model cannot load or no hand is detected near the extended wrist, the existing one-arm-out rule remains available.

## Requirements
- Use Hand Landmarker alongside the pose model, with two-hand support.
- Prefer a local model and retain the existing fallback gesture.
- Do not change other gesture targets, the score, or cultural copy.
- Demo and forced-key paths continue to work.
