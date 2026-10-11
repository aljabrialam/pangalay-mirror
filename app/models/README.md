# MediaPipe models

The real app uses local models so camera features can run at the venue without Wi-Fi:

- `pose_landmarker_lite.task` — body pose and arm tracking
- `hand_landmarker.task` — palm orientation for the wrist-turn gesture

If the hand model cannot load, the app retains the one-arm-out gesture fallback. If the pose model is missing, the app uses its existing network fallback.
