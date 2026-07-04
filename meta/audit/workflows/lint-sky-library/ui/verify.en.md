---
short_description: Loops until every file in the directory lints clean.
long_description: "Final gate: re-lints every .sky file in the directory, retrying up to 6 times. The loop condition only passes when `skyway lint` exits 0 on all files; if the fix node did not clear everything, this step fails the run and names the files still failing."
---
Runs `skyway lint` across `$SKY_DIR/*.sky` with `loop.max = 6` attempts.
