# Implementation Plan: Stance Lesson

Reuse the existing introduction overlay for a single stance lesson card. Add a stance phase that plays `stance.mp3` and advances once narration ends (with a fallback if playback fails). Route the real avatar-selection completion and demo intro completion through the lesson before resetting to gesture 0.

## Validation
Run the unique-gesture self-test and full demo round; verify it still ends at score 1000 with four catches. Check the stance narration transition and that real-camera selection routes into the lesson.
