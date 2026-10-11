# Implementation Plan: Keepsake QR Link

**Branch**: `013-keepsake-qr` | **Date**: 2026-10-11 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `specs/013-keepsake-qr/spec.md`

## Summary

At round end, capture an available camera still in memory, compose the keepsake canvas with a local static QR SVG, and show the resulting preview on the result screen. Download only when the player clicks. Use the same behavior in both app routes. If the camera or QR image is unavailable, preserve an informative preview and the PNG download.

## Technical Context

**Language/Version**: Existing browser JavaScript module

**Primary Dependencies**: Existing HTML Canvas and browser image loading; a generated local SVG asset, with no runtime dependency

**Storage**: None; still and preview canvas remain in memory for the current result, and the PNG is downloaded only on demand

**Testing**: Inspect generated QR asset and downloaded keepsake; run the two project-mandated browser checks in `AGENTS.md` section 4a after implementation

**Target Platform**: Desktop and mobile browsers serving the static app

**Project Type**: Static web application

**Performance Goals**: QR asset does not add a third-party runtime request; preview is prepared while the result screen is shown and the later download uses the prepared canvas

**Constraints**: Preserve the single-module app, local-only camera handling, existing image layout, offline-friendly deployment, and fallback download if QR load fails

**Scale/Scope**: One fixed public URL, both existing keepsake export routes, no tracking or personalized QR data

## Constitution Check

- Extend the existing app and preserve its static structure: **PASS**.
- Keep camera stills local and avoid adding a backend or upload: **PASS**.
- Use a local asset and retain a download fallback: **PASS**.
- Limit scope to automatic keepsake preview, explicit PNG download, and QR prompt: **PASS**.
- Owner approved implementation and clarified the preview interaction on 2026-10-11: **PASS**.

## Project Structure

```text
app/
├── index.html                  Primary keepsake canvas export
├── timeline.html               Review-route keepsake canvas export
└── keepsake-qr.svg             Local QR for the fixed live app URL
specs/013-keepsake-qr/
├── spec.md
├── plan.md
├── tasks.md
└── checklists/requirements.md
```

**Structure Decision**: Keep behavior in the two existing HTML routes, with one local SVG asset shared by both. Do not add a framework, package, service, or build step.

## Implementation Notes

- Generate the QR SVG for `https://pangalay-mirror.vercel.app/app/` and include a quiet zone and high-contrast modules.
- Capture the mirrored camera frame synchronously when the round ends; retain it only in memory for this result.
- Compose the keepsake automatically and show it as a scaled image preview on the result screen.
- Add the QR SVG into the free right-hand area of the keepsake profile card with a concise “SCAN TO PLAY” label.
- Keep the QR optional: image decode errors must not prevent preview display or PNG download.
- Make the download button export the already prepared preview; do not trigger a new capture.
- Keep the visible destination legible as a text fallback near the code.
- Verify the SVG can be drawn into the canvas without tainting it and confirm the preview appears before the explicit download action.
- Phone scanning and confirmation of the saved PNG remain event-device checks in `docs/REVIEW-BEFORE-SUBMISSION.md`; the local in-app browser did not expose a file-download event during validation.

## Complexity Tracking

No constitution violations.
