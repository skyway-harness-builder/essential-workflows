---
short_description: Verifies the target file exists and gathers describe context.
long_description: Asserts the workflow file exists, exiting with a clear message when it does not so the explain step never runs on a missing file. Also runs skyway describe best-effort to give the explain step extra context. Read-only - no mutation.
---

Pure bash. Checks `"$SKY_DIR/$SKY_NAME.sky"`; output feeds `$SKY_OUTPUT_RESOLVE`.
