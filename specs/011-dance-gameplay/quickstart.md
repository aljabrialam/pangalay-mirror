# Quickstart: Integrated Dance Gameplay and Treasure Hits

## Prerequisites

- Serve the repository over localhost or open the production HTTPS app.
- Use `?demo=1` for the no-camera flow.
- Open the browser console for `window.__selftest()` and `window.__state()`.

## Scenarios

1. Open `/app/?demo=1` and start the demo.
   - Expected: intro and stance complete, then the lane appears at the first gesture.
2. Watch all lane markers move toward the timing marker.
   - Expected: four gold cues, three filler cues, and the closing cue appear in order.
3. Complete all four gold cues.
   - Expected: each matching treasure travels to a target, hold feedback fills, each catch pauses the lane during its story, and timing feedback appears.
4. Complete the closing cue.
   - Expected: results show four treasures and 1,000 points; the lane stops and hides.
5. Start another round and verify state reset.
   - Expected: lane starts at zero, rating is cleared, and the first treasure cue is used again.
6. Open `/app/timeline.html?demo=1` and repeat the smoke flow.
   - Expected: behavior matches the primary `/app/` route.
7. Run `window.__selftest()`.
   - Expected: `open: open`, `overhead: overhead`, `crossed: crossed`, `kalis: kalis`, `heart: heart`.

## Human device review

Use `docs/REVIEW-BEFORE-SUBMISSION.md` for real-camera framing, wrist-turn, event lighting, speaker, offline, and PNG-download checks. Demo-mode success does not replace these checks.

