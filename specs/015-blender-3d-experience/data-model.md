# Data Model: Separate Blender 3D Experience

This feature adds no persisted or server-side data. The following are in-memory runtime entities and local assets.

## Avatar Asset

- `kind`: `girl` or `boy`, matching the existing selection.
- `source`: editable Blender project under `app-3d/models/`.
- `runtimeModel`: exported GLB loaded into the route's 3D scene.
- `armature`: named shoulder/elbow/wrist bones for each side, plus the avatar's base/root transform.
- `animations`: coach demonstration actions, if exported; player response is driven by live pose state.
- Validation: both GLBs must load in the target browser; expected bones must exist; total initial model payload must be no more than 8 MB.

## Pose State

- `leftArm` and `rightArm`: existing shoulder, elbow, and wrist angles derived from pose landmarks.
- `timestamp`: frame timestamp used by the existing video-mode tracker.
- Validation: translate degrees to the agreed armature local rotation convention; mirrored player left/right must match the current app's behavior.

## Keepsake Frame

- `cameraStill`: existing mirrored, in-memory camera frame when available.
- `avatarImage`: captured image of the selected 3D avatar from the local rendering canvas.
- `roundSummary`: score, treasures, maker profile, QR, and thank-you assets reused from the current app.
- Validation: composed locally and only downloaded after the player clicks Download; no frame is uploaded.
