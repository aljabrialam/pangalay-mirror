# Research: Dance Lane, Cultural Intro, and Keepsake Polish

## Decisions

### Lane animation

- **Decision**: Animate the existing DOM/SVG lane in its current requestAnimationFrame loop; use CSS transitions/keyframes for emphasis and catch feedback.
- **Rationale**: The lane already has a single game clock and event list. This adds visual energy without a new rendering stack or pose inference.
- **Alternatives considered**: A new animation library or a separate timeline engine; both add dependencies and risk clock drift.

### Intro map

- **Decision**: Use a simplified inline SVG based on the concept film's existing map composition and labels.
- **Rationale**: It works offline, scales to mobile, and keeps the map bundled with the static app. “Simplified map” communicates that it is illustrative.
- **Alternatives considered**: External map tiles or an online map service; rejected because they require network access and introduce unnecessary provider/precision expectations.

### Player snapshot

- **Decision**: Draw a fresh frame from the active video element to the keepsake canvas only in response to the visitor's download click, mirror it to match the camera preview, and download the canvas directly.
- **Rationale**: The app already has the authorized live stream and an in-browser canvas download flow. No additional permission or server is required.
- **Alternatives considered**: Uploading to a server or persisting an image; rejected by the project's privacy constraints. Asking for a new photo file; rejected because the request is specifically for a game snapshot.

### Maker attribution

- **Decision**: Use `assets/me.jpg`, the owner-preferred profile line, the short maker description from the concept-film biography, and the existing LinkedIn address.
- **Rationale**: These are already provided project assets and approved owner details.
- **Alternatives considered**: New biography copy or a generated portrait; unnecessary and less faithful to existing source material.

## Implementation Notes

- No external sources or packages are needed. The concept film and project handoff are the source of truth.
- No app behavior should edit files under `film/`.
