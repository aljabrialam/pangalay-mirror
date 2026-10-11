# Implementation Plan: Offline Pose Model

Use the documented download URL to place the MediaPipe Lite Pose Landmarker model at the existing local path. Confirm the runtime checks and selects local wasm and model assets when present. Do not change app logic.

## Validation
Inspect model file, local vendor assets, and `initCamera()` local-first paths. Wi-Fi-off camera startup remains a physical browser/device check.
