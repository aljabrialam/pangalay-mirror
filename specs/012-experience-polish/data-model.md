# Data Model: Experience Polish

No persistent data is introduced. The following are transient display/composition values.

## Lane Cue State

- `event`: existing cue time, glyph/name, and gold/filler/closing kind.
- `visualState`: upcoming, approaching, at-marker, caught, or paused.
- `reducedMotion`: whether the browser requests reduced animation.
- **Rules**: state derives from the existing lane clock and current game phase; it does not affect gesture acceptance or scoring.

## Intro Map

- `regionLabels`: Philippines, Mindanao, Borneo, Sulu Archipelago, and Jolo.
- `description`: “Simplified map” and existing English “Who/Where” copy.
- **Rules**: illustrative only; no geographic lookup, external tile request, or invented cultural copy.

## Keepsake Composition

- `playerFrame`: optional fresh camera still available only during the explicit download action.
- `avatar`: selected girl/boy game avatar rendered from the existing SVG rig.
- `result`: score and caught treasures already held in game state.
- `makerProfile`: supplied portrait, name, role line, short description, and LinkedIn address.
- **Rules**: canvas and frame remain in memory for the duration of the click handler; no upload or storage. When `playerFrame` is unavailable, provide an avatar-based download and a visible “camera snapshot unavailable” note.
