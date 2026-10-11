# Research: Mobile Browser Startup Reliability

## Decisions

### Reduce optional tracking work on phones

- **Decision**: Skip the optional Hand Landmarker on phones and keep the documented one-arm wrist-turn gesture fallback.
- **Rationale**: The Pose Landmarker is required to play, while Hand Landmarker is an optional refinement. Avoiding its model and graphics resources reduces startup work on devices with limited memory.
- **Alternative considered**: Load both models on all devices and rely on optional initialization failure handling. Rejected because browsers may terminate the page under memory pressure without a catchable JavaScript error.

### Retry pose setup on CPU if GPU setup fails

- **Decision**: Try the existing GPU path first, then make one CPU-delegate attempt if initialization rejects.
- **Rationale**: Keeps existing performance where supported while providing a path for mobile browsers where GPU/WebGL setup fails.
- **Alternative considered**: Force CPU on every phone. Rejected because slower inference may make the live dance experience less responsive on devices with working GPU support.

### Keep camera startup recoverable

- **Decision**: Show stage updates, guard duplicate starts, and stop any opened stream if later startup work fails.
- **Rationale**: The previous single generic status did not distinguish camera permission from tracker loading; it also left a stream alive if model setup rejected.

## Validation Limit

The owner has not identified the phone/browser yet. Local viewport and demo checks cannot establish real camera permission behavior, mobile GPU fallback, memory pressure, or performance. These remain in the device review checklist.
