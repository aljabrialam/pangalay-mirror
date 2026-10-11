# Quickstart: Gesture-Based Avatar Choice

## Prerequisites

- Serve the repository over localhost or HTTPS.
- Allow camera access and use a webcam with shoulders and wrists visible.

## Manual validation

1. Open `/app/` and press **Start with camera**.
2. Stand in frame until the existing **Body found** check passes.
3. Raise and hold the screen-left hand above its shoulder for at least 0.8 seconds; confirm Boy is selected and the lesson advances.
4. Restart and repeat with the screen-right hand; confirm Girl is selected.
5. Raise a hand briefly, then lower it before 0.8 seconds; confirm the app stays on the choice screen.
6. Start with `?demo=1`; confirm Girl is chosen automatically and the round reaches results.
7. Run the existing `__selftest()` and confirm all expected gesture matches remain unique.
