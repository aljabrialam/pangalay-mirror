# Quickstart: Experience Polish

## Prerequisites

- Serve the repository over HTTPS or `localhost` for camera access.
- Use a camera-enabled browser for the player snapshot scenario; `?demo=1` remains available without a camera.

## Run

```bash
python3 -m http.server 8000
```

Open `http://localhost:8000/app/`. Use `http://localhost:8000/app/?demo=1` to validate the camera-free game flow.

## Validation Scenarios

1. Run `window.__selftest()` and confirm each of the five gestures matches only its own rule.
2. Complete the demo round; confirm all lane cues animate in sequence, stories pause the lane, four treasures are caught, and the result is 1,000 points.
3. In the normal camera flow, inspect the “Who” and “Where” introduction, map labels, and gesture-based avatar selection.
4. In a camera round, download the keepsake and confirm it includes the current webcam still, avatar, score/treasures, Magsukul, and maker profile. Verify the file is downloaded locally and there is no upload request.
5. In demo mode, download the keepsake and confirm the avatar/profile version includes a clear note that no player camera snapshot is present.
6. Check reduced-motion mode and a narrow viewport; lane timing, intro content, and download must remain usable.

## Expected Outcomes

- No score, gesture, story, or event-order changes.
- The intro makes the Tausug and Sulu/Jolo context visible with a simplified map.
- The downloaded keepsake includes the player's camera still when available and never uploads or retains it.
