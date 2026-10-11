# Research: Introduction

- **Decision**: Reuse the existing `say()` shared voice player and the three `intro*.mp3` files. **Rationale**: This is the established audio pattern and avoids overlapping audio instances.
- **Decision**: Advance both on audio completion and with a guarded timeout fallback. **Rationale**: Broken or stalled audio must not block the round; a one-shot guard prevents duplicate transitions.
- **Decision**: Re-enter the body-found and introduction flow on Play again. **Rationale**: F7 requires the introduction once per round.
