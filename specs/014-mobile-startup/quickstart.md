# Quickstart: Mobile Startup Review

## Local browser checks

1. Serve the repository from its root over `localhost` and open `/app/?demo=1`.
2. Confirm the no-camera demo reaches the result with four treasures and 1,000 points.
3. Check a 390×844 viewport: the rotate-to-landscape prompt should appear.
4. Check an 844×390 viewport: the prompt should disappear and the 16:9 game stage should fit the landscape height.
5. Repeat the demo and viewport checks at `/app/timeline.html?demo=1`.

## Physical phone checks

Open `https://pangalay-mirror.vercel.app/app/` on the target phone, grant camera access, and follow the pending checklist in `docs/REVIEW-BEFORE-SUBMISSION.md`. Record the phone model, browser/version, and whether startup used GPU or CPU fallback if observable. Do not treat desktop viewport emulation as camera verification.
