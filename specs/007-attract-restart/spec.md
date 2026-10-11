# Feature Specification: Attract Screen and Auto-Restart

**Feature Branch**: `007-attract-restart`
**Status**: Approved under owner's instruction to proceed with remaining makeathon features
**Input**: F11 from `CODEX-FEATURES.md`.

## User Story
For an unattended installation, the result screen returns to an attract screen after 20 seconds. A visitor holds either wrist above its shoulder for 0.8 seconds to start another round while the camera remains active.

## Requirements
- Keep camera and shared audio context alive between rounds.
- Show title and “Raise your hand to begin”.
- Require one wrist above its matching shoulder continuously for 0.8 seconds.
- A visible button remains available as a fallback.
- Restart through existing body-found, intro, avatar, and stance flow.
