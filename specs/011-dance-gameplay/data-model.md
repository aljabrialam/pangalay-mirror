# Data Model: Integrated Dance Gameplay and Treasure Hits

This feature uses in-memory presentation state only. It creates no persistent data.

## Lane Event

- **Fields**: move identity, event time in seconds, gold/filler/closing kind, display pictogram, current screen position.
- **Validation**: exactly four gold events, three filler events, and one closing event appear in the reference order.
- **Lifecycle**: initialized at round reset; positioned from the lane clock; hidden when the round ends; reinitialized on replay.

## Treasure Cue

- **Fields**: matching gold step, existing image, existing target pose, target screen position, flight/hold visual state.
- **Validation**: one cue for each of the four gold steps; no cue for filler events or the closing pose.
- **Lifecycle**: appears during the matching cue; travels toward its pose target; reflects hold progress; transitions once to caught/story state; clears before the next step.

## Dance Clock

- **Fields**: elapsed dance time, active/paused/finished state.
- **Validation**: begins at the first dance step, pauses during treasure narration, resumes after narration, and stops on results.
- **Lifecycle**: resets to zero at each new round.

