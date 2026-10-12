# Review Before Makeathon Submission

Production app: https://pangalay-mirror.vercel.app/app/
Separate 3D experience: https://pangalay-mirror.vercel.app/app-3d/
Dance timeline review copy: https://pangalay-mirror.vercel.app/app/timeline.html
No-camera demos: add `?demo=1` to either app URL.

## Blender 3D route (`015-blender-3d-experience`)

- The independent `/app-3d/` page loads local Blender-exported girl/boy GLB avatars with the pinned local Three.js renderer. The 2D `/app/` route and `/app/timeline.html` are unchanged.
- Local landscape browser review completed: both route self-tests return `open: open`, `overhead: overhead`, `crossed: crossed`, `kalis: kalis`, and `heart: heart`.
- Local `/app-3d/?demo=1` completed the no-camera round with all four treasures, 1,000 points, five stars, and an automatically generated keepsake preview containing the 3D avatar and existing maker/QR content.
- The combined avatar GLBs are 622,036 bytes. They are well below the 8 MB initial model budget.
- Responsive browser checks showed portrait guidance at 390×844 and landscape layout at 844×390. This is a viewport check, not a physical-phone camera test.
- Temporarily removing one local GLB produced a clear 3D startup error and an accessible link to `/app/`; the asset was restored afterward.
- The camera was not granted during this review. A physical-phone camera round, device-specific performance, and camera-denial recovery still require owner review.

## Experience polish baseline (`012-experience-polish`)

- The primary app already has an eight-event scrolling lane and flying treasure cues, but the lane cues have minimal visual state changes.
- The intro already explains who the Tausug are and where the Sulu Archipelago is in English; it does not yet show the concept film's map.
- The result screen automatically prepares a local keepsake preview with the available camera still, avatar, score, caught treasures, Magsukul, maker profile, and QR link. The PNG is saved only after the player clicks Download.
- `assets/me.jpg` is present. The camera `<video>` remains attached to the active stream during the result state in code; the actual camera and resulting download still require device verification.
- Baseline simulated checks on both app routes: `__selftest()` returns open/overhead/crossed/kalis/heart as expected; demo reaches four catches and 1,000 points, shows eight lane events, and pauses during treasure stories.

## Browser review on the event laptop

- [ ] Open the production app over HTTPS and allow camera access.
- [ ] Check the waist-up framing gate, then confirm the three intro cards play and Skip intro works on each card.
- [ ] Confirm left-hand hold selects Boy, right-hand hold selects Girl, then listen to the stance lesson before the first move.
- [ ] On the production app, follow the lane through four gold cues, three filler cues, and the closing cue. Confirm each gold treasure flies to its target, hold progress is visible, stories pause the lane, and timing feedback appears.
- [ ] Confirm lane cues glow as they approach, the fixed marker pulses, catches get a short celebration, and reduced-motion mode keeps cues readable without pulsing.
- [ ] Confirm the “Where” intro card shows the simplified Philippines map with Sulu Archipelago and Jolo labeled alongside Mindanao and Borneo.
- [ ] Complete all four catches and the closing pose; confirm the result shows 1,000 points and four treasures.
- [ ] Finish a camera round and confirm the keepsake preview appears automatically with the mirrored end-of-round still, selected avatar, score, treasures, Magsukul script, maker profile, and QR code.
- [ ] Confirm no file downloads until the player clicks **Download keepsake PNG**; scan the QR on the downloaded keepsake and confirm it opens the live app.
- [ ] Use `?demo=1` and confirm the preview appears with a clear no-camera note and QR code. Confirm the app sends no image upload request.
- [ ] Open `/app/timeline.html` and confirm it matches the production lane and treasure behavior.
- [ ] Test the wrist turn with the palm turned toward the camera, then check the one-arm fallback if hand tracking is unavailable.
- [ ] Disable Wi-Fi and reload to confirm local pose and hand models work; check sound on the actual speakers.
- [ ] Leave the result up for 60 seconds, then check attract mode and raise a hand to start the next round.
- [ ] Keep keyboard keys 1–5 and `?demo=1` available as stage fallbacks.

## Mobile startup review

- [ ] On the actual phone and browser, open the production app over HTTPS, allow camera access, and confirm startup advances from permission to pose tracking and then body framing without a hang or crash.
- [ ] Confirm portrait mode shows “Turn your phone sideways” and the prompt disappears after rotating to landscape.
- [ ] Deny camera access once; confirm the app explains how to allow it again, offers retry and the no-camera demo, and releases any opened camera stream.
- [ ] On a phone, confirm the dance, narration, catches, and result screen remain responsive using the one-arm wrist-turn fallback.
- [ ] Repeat with the aligned `/app/timeline.html` route.

The local 390×844 and 844×390 viewport review verifies portrait guidance and landscape sizing only. It does not replace a physical mobile camera, GPU/CPU fallback, or memory-pressure review.

Automated/local checks pass for syntax, unique gesture matching on `/app/`, `/app/timeline.html`, and `/app-3d/`, full no-camera rounds on all three routes (score 1,000; four catches), intro skip progression, and synthetic palm orientation. Real camera, saved PNG and QR scanning, event lighting, camera-denial recovery, and Wi-Fi-off startup still need this device review.
