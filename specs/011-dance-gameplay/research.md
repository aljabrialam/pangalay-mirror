# Research: Integrated Dance Gameplay and Treasure Hits

## Decisions

### Reuse the existing timeline review copy

- **Decision**: Use the lane structure, event sequence, fixed marker, game clock, and rating thresholds already implemented in `app/timeline.html` as the behavioral reference for the production page.
- **Rationale**: The feature was already built and reviewed in isolation; reusing it minimizes new timing and UI decisions.
- **Alternatives considered**: Rebuild the lane from scratch in the main page. Rejected because it would duplicate existing behavior and increase the chance of timing drift.

### Derive treasure targets from the existing pose rig

- **Decision**: Place each target at the hand position produced by that move's existing target pose and avatar rig, including the explicit crossed-arms chest target.
- **Rationale**: The user should see the treasure where the coach pose tells them to reach; the rig and target poses already define that movement.
- **Alternatives considered**: Use four unrelated fixed screen positions. Rejected because targets could appear disconnected from the mirrored avatar.

### Keep the catch and cultural story flow unchanged

- **Decision**: Add visual travel, target, and hold-progress feedback around the existing catch. Reuse existing treasure images, one shared voice player, card copy, score, and score total.
- **Rationale**: This completes the missing visual encounter without altering approved cultural content or gameplay outcomes.
- **Alternatives considered**: Add new narration or change catch scoring. Rejected because neither is needed to close the reviewed gap.

### Keep both public app routes aligned

- **Decision**: Keep `/app/timeline.html` available and behaviorally aligned with `/app/` after integration.
- **Rationale**: Both routes are already shared for review; different gameplay behavior would make testing and demonstration confusing.
- **Alternatives considered**: Remove the timeline route. Rejected for now because it is a useful direct review path and removal was not requested.

## Validation Notes

- No new external libraries, services, or technical unknowns are introduced.
- Physical camera quality, hand orientation, event lighting, offline reload, and speaker output require the owner's event device and cannot be established by this static review.

