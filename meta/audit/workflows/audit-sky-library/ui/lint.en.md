---
short_description: Runs skyway lint on each discovered file and tallies pass/fail.
long_description: Executes `skyway lint` per file from the scan step, prints OK or FAIL with the reported error codes, and exits non-zero if any file fails — making the run CI-gate friendly.
---
Runs after `scan` completes. Output is grouped by file so failures are easy to locate.
