# Feature Specification: Offline Pose Model

**Feature Branch**: `008-offline-model`
**Status**: Completed under owner's instruction to proceed with remaining makeathon features
**Input**: F12 from `CODEX-FEATURES.md`.

## User Story
At the venue, the camera app can initialize its pose detector with Wi-Fi disabled using the locally bundled MediaPipe library, WebAssembly files, and pose model.

## Requirements
- Keep the MediaPipe library and wasm under `app/vendor/`.
- Bundle the Lite Pose Landmarker model under `app/models/`.
- Prefer local assets; retain existing network fallback.
- Fonts use CSS system fallbacks and are not bundled.
