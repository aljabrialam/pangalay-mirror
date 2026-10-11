# Tasks: Introduction

**Input**: Design documents from `/specs/004-introduction/`

**Prerequisites**: `spec.md`, `plan.md`

## Phase 1: User Story 1 - Hear a short introduction before playing (P1)

**Goal**: Present the three existing narrated intro cards and continue or skip into the next game step.

**Independent Test**: Complete or skip each card; confirm camera flow reaches avatar choice and demo reaches results.

- [X] T001 [US1] Add the three-card introduction UI and approved copy to `app/index.html`.
- [X] T002 [US1] Add ordered narration, one-shot advancement, and skip behavior using the shared voice player in `app/index.html`.
- [X] T003 [US1] Connect body-found, Play again, avatar-choice, and demo transitions to the introduction in `app/index.html`.
- [X] T004 [US1] Run gesture self-test, full demo round, and skip/audio sequence checks.

## Verification

Node VM check: unique gesture output is `open: open`, `overhead: overhead`, `crossed: crossed`, `kalis: kalis`, `heart: heart`. Full demo passes at score 1,000 with four catches and no simulated console errors after completing all intro cards. Real camera/audio and visual skip interactions remain an owner review.

## Dependencies & Execution Order

- T001 and T002 precede T003; T004 follows all implementation tasks.

## Notes

- Do not modify `film/` or add new narration or cultural content.
