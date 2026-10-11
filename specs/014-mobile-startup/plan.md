# Implementation Plan: Mobile Browser Startup Reliability

**Branch**: `014-mobile-startup` | **Date**: 2026-10-11 | **Spec**: [spec.md](spec.md)

**Input**: User report that the app gets stuck or crashes during mobile startup.

## Summary

Make mobile camera startup recoverable and less resource-intensive. Keep the existing camera game and static HTML architecture. Show staged progress, avoid loading optional hand tracking on mobile when needed, try the supported body-tracker fallback if graphics initialization fails, stop camera tracks after failed setup, and give the player actionable error/retry/demo choices. The phone-sized review also showed that portrait view reduces the 16:9 game to a narrow strip, so show a rotate-to-landscape prompt on phones. Apply the same behavior to `/app/` and `/app/timeline.html`.

## Technical Context

**Language/Version**: Existing browser JavaScript module

**Primary Dependencies**: Existing MediaPipe Tasks Vision bundle, browser media APIs, and local model/WASM assets

**Storage**: None

**Testing**: Required project gesture self-test and full no-camera demo round; mobile real-camera startup requires an owner device review

**Target Platform**: Current desktop and mobile browsers over HTTPS; local development over localhost

**Project Type**: Static web application

**Performance Goals**: Startup either reaches the framing flow or gives a recoverable error; no duplicate initialization or orphaned camera stream

**Constraints**: Preserve one HTML file and one module script per route; no framework/build step/backend; preserve consent, privacy, gameplay, and existing fallback gestures

**Scale/Scope**: Two existing app routes, one mobile startup flow, no service or data changes

## Constitution Check

- Extend existing single-file routes and keep the static app: **PASS**.
- Request the camera only after the player presses Start; do not record or upload frames: **PASS**.
- Preserve demo mode and gameplay checks: **PASS**.
- Do not change cultural copy, gesture matching rules, avatar rig, or source media: **PASS**.
- Owner review before implementation: **PASS** (approved in chat on 2026-10-11).

## Implementation Notes

- Keep the first user action responsible for camera permission and audio unlock.
- Report distinct startup stages in the existing start screen rather than leaving one generic loading message.
- Treat Hand Landmarker as optional on phones and keep the already-supported one-arm wrist-turn fallback.
- If GPU pose setup fails, retry with the supported CPU delegate before showing an error.
- Attach and play the camera preview as soon as permission succeeds; if any later setup fails, stop all tracks and clear the video source.
- Disable Start while setup is in progress and re-enable it on a recoverable error.
- Give permission-denied, insecure-context, missing-camera, and model-initialization errors plain-language recovery steps.
- Mirror the behavior in `app/index.html` and `app/timeline.html` without changing gesture rules or timing.
- On phone portrait viewports, show a prominent orientation prompt; hide it automatically in landscape. Keep the core stage's existing 16:9 layout.

## Project Structure

```text
app/index.html                 Primary application
app/timeline.html              Aligned review route
specs/014-mobile-startup/      Feature documentation
```

**Structure Decision**: Make focused edits to the existing two HTML files and add only the Spec Kit artifacts. No additional runtime files are expected.

## Verification Plan

1. Run `window.__selftest()` on both routes and confirm the existing five expected gesture keys.
2. Complete the `?demo=1` round on both routes and confirm four catches, 1,000 points, and the result screen.
3. Review startup errors with denied permission and unavailable tracker paths where a browser context allows it.
4. On the owner's phone and named browser, grant camera permission and confirm startup reaches the framing flow without a hang/crash.
5. Inspect browser camera indicators or tracks after forced setup failure to confirm cleanup; do not claim physical-device support based on demo mode alone.
6. At a 390×844 phone viewport, confirm the portrait prompt is visible; at 844×390, confirm it is hidden and the stage uses the landscape viewport.

## Complexity Tracking

No constitution violations.
