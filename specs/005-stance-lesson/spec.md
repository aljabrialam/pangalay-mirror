# Feature Specification: Stance Lesson

**Feature Branch**: `005-stance-lesson`
**Status**: Approved under owner's instruction to proceed with remaining makeathon features
**Input**: F8 from `CODEX-FEATURES.md`.

## User Story
After the introduction and avatar selection, the player sees one stance card and hears the existing `stance.mp3` narration before the first dance gesture.

## Acceptance Scenarios
1. Completing or skipping the introduction leads to avatar choice (or automatic Girl selection in demo).
2. Completing avatar choice leads to the stance card with the approved exact copy and `stance.mp3`.
3. When narration ends, the first gesture begins. Demo mode still completes the full round.

## Requirements
- Reuse the existing shared voice player and existing clip.
- Display: “First, the stance. Keep your knees soft, your eyes lowered, and your fingers curled back.”
- Do not add body detection or new cultural claims.
- Preserve the gesture rules, score, and concept film.
