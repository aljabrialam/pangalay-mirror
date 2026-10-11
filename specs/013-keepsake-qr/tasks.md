# Tasks: Keepsake QR Link

**Input**: Design documents from `/specs/013-keepsake-qr/`

## Phase 1: User Story 1 - Scan the keepsake to revisit the game (Priority: P1)

**Goal**: Automatically show a locally generated keepsake preview after the dance; let the player choose whether to download it, and include a scannable link to the live app.

**Independent Test**: Complete a round and confirm the keepsake preview appears without a click. Confirm no file is downloaded until the button is clicked, then scan the downloaded QR code.

- [X] T001 Generate a high-contrast local QR SVG for `https://pangalay-mirror.vercel.app/app/` at `app/keepsake-qr.svg`.
- [X] T002 Refactor keepsake generation in `app/index.html` to capture the frame at round end, compose and show the preview automatically, and add the QR with a “SCAN TO PLAY” prompt and text URL fallback.
- [X] T003 Make the download action export the already prepared preview only when clicked; preserve the no-camera and missing-QR fallbacks in `app/index.html`.
- [X] T004 Apply matching preview and download behavior to `app/timeline.html`.
- [X] T005 Run syntax and gesture self-checks plus the no-camera demo round; confirm the preview appears automatically, the QR asset loads, and the download control remains a separate player action. Phone scanning and saved-PNG verification remain in the event-device review checklist.

## Dependencies & Execution Order

- T001 must precede T002.
- T002 and T003 affect the same route and must remain sequential.
- T004 follows the primary route behavior so the review route can match it.
- T005 follows both route changes.
