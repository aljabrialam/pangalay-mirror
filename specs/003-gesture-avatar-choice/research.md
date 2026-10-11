# Research: Gesture-Based Avatar Choice

## Decisions

- **Decision**: Reuse MediaPipe Pose landmarks for shoulder and wrist positions.
  **Rationale**: These landmarks are already available in the live loop; no added model or download is needed.
  **Alternatives considered**: Hand Landmarker. Rejected for this feature because avatar choice needs only wrist height, while hand tracking is reserved for F14.

- **Decision**: Require one unambiguous raised side for 800 ms; reset the hold on visibility loss or a wrist dropping below shoulder height.
  **Rationale**: This matches F10's hold duration and avoids accidental selection from a brief pose.
  **Alternatives considered**: Immediate selection or selection based on either hand without ambiguity. Both are more prone to false activation.

- **Decision**: Keep the opening Start action, but make avatar selection gesture-only.
  **Rationale**: Start is needed as the browser user gesture for camera permission and audio; the owner explicitly wants avatar choice by movement rather than clicking.
  **Alternatives considered**: Clickable avatar buttons as fallback. Rejected for the selection interaction per owner direction.
