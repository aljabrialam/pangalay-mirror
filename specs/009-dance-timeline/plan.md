# Implementation Plan: Dance Timeline

Copy the current app to `app/timeline.html`, then add a compact bottom lane with a fixed marker and event pictograms positioned from a 32-second look-ahead window. Drive the lane from a game clock that starts with the first gesture and pauses during treasure holds. Keep the production entry point untouched.

## Validation
Run the existing gesture self-test and full demo round on both the main app and timeline copy. Inspect the lane, scroll timing, and ratings in browser before promoting it to the main app.
