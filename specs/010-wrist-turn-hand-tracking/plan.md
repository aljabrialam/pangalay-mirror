# Implementation Plan: Wrist Turn with Hand Tracking

Bundle the Hand Landmarker model. Initialize it optionally from the existing local MediaPipe bundle and local wasm, then use normalized hand landmarks to estimate whether the palm faces the camera when an arm is extended. If initialization fails or no hand is available at the extended wrist, retain the current one-arm-out rule.

## Validation
Run the unique gesture self-test and complete demo flow. Confirm that an unavailable-hand-model path retains existing behavior. Owner tests the palm turn and fallback with a real camera.
