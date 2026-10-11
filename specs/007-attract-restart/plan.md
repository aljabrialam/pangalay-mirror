# Implementation Plan: Attract Screen and Auto-Restart

After the results remain visible for 20 seconds, show the existing cover overlay in attract mode. Track wrist-above-matching-shoulder holds in the existing camera loop; after 0.8 seconds start the existing round flow without reacquiring camera. Preserve a visible click fallback.

## Validation
Check script syntax; simulate timer and pose hold. Confirm Play again still starts cleanly and a new real-camera visit passes through the body gate.
