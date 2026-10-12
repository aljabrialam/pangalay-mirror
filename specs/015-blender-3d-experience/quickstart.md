# Quickstart: Separate Blender 3D Experience

## Local review

1. From the repository root, run `python3 -m http.server 8000`.
2. Open `http://localhost:8000/app-3d/` for camera mode, or `http://localhost:8000/app-3d/?demo=1` for the no-camera demo.
3. On the existing 2D route, open the browser console and confirm `__selftest()` returns exactly `open: open`, `overhead: overhead`, `crossed: crossed`, `kalis: kalis`, and `heart: heart`.
4. On the 3D route, confirm the avatars load, start the demo, complete the round, and inspect the result and keepsake preview.
5. For camera mode, tap Start, grant camera access, and confirm the player avatar mirrors upper-body movement while the coach and lane continue.
6. Repeat on a supported phone in landscape. Confirm the app responds throughout a full round and the camera frame remains local.
7. Open `/app/` and `/app/timeline.html` and verify they are byte-for-byte unchanged by the implementation.

## Expected result

- The route `/app-3d/` renders Blender-exported 3D player and coach avatars.
- Demo completes four catches and reaches results and keepsake without asking for camera permission.
- Camera mode requests access only after the player taps Start.
- WebGL/model failure shows a clear recovery message and a link to `/app/`.
- The existing production route remains exactly as it was.

## Prerequisite

Blender was not found on PATH in the current workspace. Before creating the `.blend` sources, make Blender available through an installed desktop app or a Blender-equipped workstation.
