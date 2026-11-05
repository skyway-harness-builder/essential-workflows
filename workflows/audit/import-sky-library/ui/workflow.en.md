---
short_description: Validates a folder of foreign .sky files and imports the lint-clean ones into a target directory, behind a manual approval gate.
long_description: Use this to absorb legacy or third-party .sky files safely. Each candidate is linted first; files that fail lint are rejected with their error codes, files that already exist in the target are skipped, and nothing is copied until you approve the manifest. Pure bash, no tokens consumed.
---
Five steps: `enumerate` lists the source files, `validate` lints each candidate and stages the passes, `gate` pauses for manual approval showing the PASS/FAIL/SKIP sets, `finalize` copies the approved files (never overwriting), and `verify` re-lints every imported file in its new home.

| Variable | Meaning |
|----------|---------|
| `source` | Directory holding the foreign/legacy `.sky` files to import. |
| `dir` | Target `.sky` workflows directory to import into. |
