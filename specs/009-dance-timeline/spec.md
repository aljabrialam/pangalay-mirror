# Feature Specification: Dance Timeline

**Feature Branch**: `009-dance-timeline`
**Status**: Implemented on isolated review copy
**Input**: F13 from `CODEX-FEATURES.md`.

## User Story
During play, the player sees upcoming gold gestures and filler moves scroll toward a fixed marker, with a Perfect/Good timing label when a gold gesture is caught.

## Requirements
- Implement only in `app/timeline.html`; leave the main `app/index.html` flow separate.
- Include four gold gestures, three filler moves, and the closing gesture in the reference order.
- Start lane time at the first dance gesture and pause while a caught treasure story is playing.
- Retain the existing coach, demo flow, controls, score, and culture copy.
