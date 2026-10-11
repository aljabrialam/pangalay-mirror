# Data Model: Gesture-Based Avatar Choice

## Avatar selection state

- `kind`: `girl` or `boy`; current-round selection used by the existing avatar renderer.
- `phase`: transient app state representing the avatar-choice screen.
- `holdStart`: per-side start time for a qualifying raised-hand interval; cleared when that side is no longer valid.
- `selected`: whether a hand gesture has completed and the app may advance.

No selection data is persisted or sent off-device.
