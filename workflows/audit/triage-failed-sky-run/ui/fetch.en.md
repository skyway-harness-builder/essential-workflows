---
short_description: Captures the failed run's logs and the workflow source.
long_description: Confirms the .sky file exists, calls `skyway logs <run>` best-effort (logs may be partial or unavailable), and prints logs plus source for the diagnose step. Exits nonzero if the run id is missing.
---
Everything it captures becomes `$SKY_OUTPUT_FETCH` for the diagnosis.
