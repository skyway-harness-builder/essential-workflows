---
short_description: Captures the current skyway run history.
long_description: Runs `skyway logs` and prints the raw output for the report step to grep against. Tolerates an empty or unavailable log so the scan never crashes here; in that case every file will later report NEVER.
---
Writes the `skyway logs` output to a temp file, prints it as `$SKY_OUTPUT_RUNS`, and cleans the temp file up. Runs after `list` completes.
