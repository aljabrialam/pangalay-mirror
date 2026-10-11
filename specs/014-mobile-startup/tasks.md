# Tasks: Mobile Browser Startup Reliability

**Input**: Design documents from `/specs/014-mobile-startup/`

## Phase 1: User Story 1 — Start a camera round on a phone (Priority: P1)

**Goal**: Let a mobile player start the camera game or receive a clear, recoverable error without leaving the camera active.

**Independent Test**: On both app routes, run the project self-test and full demo. On an owner-provided phone/browser, start a camera session and verify it reaches framing, or exercise a failure and verify cleanup, retry, and demo entry.

- [X] T001 [US1] Add staged startup status, mobile hand-tracker resource fallback, GPU-to-CPU pose fallback, startup protection, and failed-start camera cleanup in `app/index.html`.
- [X] T002 [US1] Apply matching startup behavior and recovery messaging in `app/timeline.html`.
- [X] T003 [US1] Add the portrait rotate-to-landscape prompt and dynamic viewport sizing to `app/index.html` and `app/timeline.html`.
- [X] T004 [US1] Run syntax checks, gesture self-test, complete demo rounds on both routes, and phone-sized portrait/landscape viewport checks; document the results in `docs/REVIEW-BEFORE-SUBMISSION.md`.
- [ ] T005 [US1] On the owner's actual phone and browser, verify camera permission, model startup, pose framing, retry/demo recovery after denial, resource fallback behavior, and a complete round on both routes; update `docs/REVIEW-BEFORE-SUBMISSION.md` with the device and results.

## Dependencies & Execution Order

- T001 precedes T002 so the primary route defines the expected behavior.
- T003 follows both startup changes so the responsive prompt stays aligned.
- T004 follows all code changes.
- T005 requires the owner's physical phone and browser; simulated viewport checks do not satisfy it.
