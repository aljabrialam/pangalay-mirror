<!--
Sync Impact Report
Version: initial draft → 1.0.0
Added principles: Cultural integrity; Preserve and extend the existing experience; Small browser-first prototype; Verify behavior; Privacy and clear limitations.
Added sections: Project constraints; Spec-driven development workflow.
Removed sections: None.
Follow-up TODOs: None.
-->
# Pangalay Mirror Constitution

## Core Principles

### I. Cultural integrity
Represent Tausug people, pangalay, language, and cultural objects with care. Preserve the project’s approved English wording. Do not invent Tausug words or script, do not use Baybayin, and keep unverified transliterations clearly marked for review by a Tausug reader. Do not present the prototype as authoritative dance instruction.

### II. Preserve and extend the existing experience
Use the concept film, assets, scripts, and existing prototype as the source of truth. Extend existing work in small, reviewable changes. Never edit `film/`; it is the deployed concept film and source of the project’s media. Do not rebuild the app or introduce a framework or build step unless the owner explicitly requests it.

### III. Keep the prototype browser-first
The real experience is a static browser app with no backend. Keep the app in its established single-file structure and use its existing local assets and MediaPipe bundle. Do not add a server dependency, account system, or video upload to make the core experience work.

### IV. Verify observable behavior
Every application change must continue to pass both checks in `AGENTS.md` section 4a: the gesture self-test and the complete demo round. Verify behavior through the existing controls and report any check that could not be run. Do not claim real-camera support until it has been exercised with a camera.

### V. Protect participants and explain limitations
Request camera access only when the player chooses to start. Process camera frames in the browser and do not record or upload them. Provide a usable no-camera demo path. Keep known tracking limitations visible and use the project’s documented fallback gesture when body pose cannot detect wrist rotation.

## Project Constraints

- Use `app/index.html` as the app entry point and preserve its single module script.
- Keep camera access, gesture detection, rendering, audio, and scoring client-side.
- Use one shared voice player; begin audio only after a player action and duck music under narration.
- Do not combine changes to gesture detection rules and the avatar rig in one task. If tracking needs tuning, change `detect()` thresholds only.
- Do not alter cultural content, gesture meanings, or source media without an explicit, reviewable reason.

## Spec-Driven Development Workflow

Use GitHub Spec Kit artifacts for each non-trivial feature or behavior change:

1. `$speckit-specify` writes user-facing requirements and acceptance scenarios before implementation.
2. `$speckit-clarify` resolves meaningful ambiguity; `$speckit-plan` records the smallest implementation consistent with the existing app.
3. `$speckit-tasks` creates ordered, verifiable tasks. Use `$speckit-analyze` when the change crosses requirements, plan, and tasks.
4. Review the spec and plan with the owner before implementing. Implement only the approved scope.
5. Run both checks in `AGENTS.md` section 4a and `$speckit-converge` before reporting completion. Update upstream artifacts if implementation exposes a specification gap.

For a trivial one-line correction, the owner may explicitly waive the artifact chain. Do not add process steps that do not improve reviewability.

## Governance

This constitution records the project guardrails already stated in `AGENTS.md`; it does not override the owner’s direct instructions. Amend it only when the owner changes an established project rule. Use semantic versioning: MAJOR for incompatible rule changes, MINOR for new or materially expanded principles, PATCH for clarifications. Review feature specs, plans, code, and verification results against these principles before considering work complete.

**Version**: 1.0.0 | **Ratified**: 2026-10-11 | **Last Amended**: 2026-10-11
