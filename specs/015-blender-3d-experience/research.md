# Research: Separate Blender 3D Experience

**Date**: 2026-10-12

## Decision: Use Blender-authored GLB assets

- Blender's glTF 2.0 exporter supports armatures/skinning and animation actions. Keep the editable `.blend` sources with the exported GLB files.
- Rationale: GLB provides a compact, self-contained browser asset and the Blender source remains editable for future art changes.
- Alternatives considered: Rendered video or sprite animation would not let the player avatar respond live to webcam pose; directly generated mesh files would not meet the user's Blender-authored asset request.
- Source: [Blender glTF 2.0 export manual](https://docs.blender.org/manual/en/latest/addons/scene_gltf2.html)

## Decision: Render the independent route with Three.js

- Three.js `GLTFLoader` loads glTF/GLB and returns a scene with any animation clips in the asset.
- Rationale: It supplies the browser 3D scene renderer, model loader, and rig animation support needed without moving the project to a framework or build tool.
- Alternatives considered: A custom WebGL renderer would require writing model loading, skinning, and animation infrastructure; a full game engine export would introduce a larger runtime/build pipeline.
- Source: [Three.js GLTFLoader documentation](https://threejs.org/docs/pages/GLTFLoader.html)

## Decision: Keep runtime dependencies local and reuse existing assets by reference

- Pin and vendor only the Three.js runtime modules used by the new route, preserving the required upstream license notice. Load MediaPipe, WASM, pose/hand models, and approved audio/art from existing `app/` and `film/` paths.
- Rationale: Static deployment stays self-contained for the new renderer and avoids a runtime dependency on a CDN, while the original app source remains unmodified.
- Alternatives considered: Importing Three.js from a CDN is simpler but may fail under event Wi-Fi; copying the large MediaPipe distribution into `app-3d/` duplicates files and risks version drift.

## Open Environment Dependency

- `command -v blender` returned no executable in this workspace. The project can be planned, but producing and inspecting the native `.blend` assets requires Blender to be installed or a Blender-equipped workstation.
- This plan records the dependency for owner review; no application or system software has been installed.
