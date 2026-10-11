# Implementation Plan: Introduction

**Branch**: `004-introduction` | **Date**: 2026-10-11 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `/specs/004-introduction/spec.md`

## Summary

Add a three-card intro phase after the body-found gate. Reuse the existing voice player and `intro0`–`intro2` clips, add a skip control, and continue into the existing gesture-based avatar choice. Demo mode follows the same intro and then selects Girl automatically.

## Technical Context

**Language/Version**: Browser JavaScript in `app/index.html`

**Primary Dependencies**: Existing DOM, `say()` shared audio player, and narration clips in `film/`

**Storage**: None

**Testing**: `__selftest()`, full `?demo=1` round, skip from every card, and audio sequence check

**Target Platform**: Desktop browser, localhost/HTTPS

**Project Type**: Single-file static browser app

**Performance Goals**: Complete the three clips in under 35 seconds; UI remains responsive during playback

**Constraints**: Change only `app/index.html` plus this feature's artifacts. Reuse exact copy in `docs/VOICE-SCRIPTS.md`; preserve one voice player and no backend.

**Scale/Scope**: Three cards, three existing audio assets, one skip button

## Constitution Check

- Cultural integrity: Pass; use existing approved English scripts only.
- Preserve and extend: Pass; add a flow state to the existing app, no film edits.
- Browser-first: Pass; no build step or server dependency.
- Verify behavior: Pass when self-test and complete demo are run.
- Privacy: Pass; no new data collection or recording.

## Design

- Add an intro card overlay with one title and description at a time, plus a visible Skip intro button.
- Add ordered copy for who, where, and today from `docs/VOICE-SCRIPTS.md`.
- On body-found success, begin the intro instead of avatar choice.
- Advance on shared player completion, with a one-shot timeout fallback for failed or stalled audio.
- On skip or completion, start avatar choice for camera play; in demo mode choose Girl and start the game.
- Make Play again enter the normal start-of-round flow so the intro plays once per round.

## Project Structure

```text
app/index.html
specs/004-introduction/{spec.md,plan.md,tasks.md,research.md,quickstart.md}
```

**Structure Decision**: Keep the app in its existing HTML file and reference the existing `/film/` audio.

## Complexity Tracking

No constitution violations.
