---
short_description: Classifies each workflow as SEEN-IN-LOGS or NEVER and prints deletion suggestions.
long_description: Cross-references the file list against the captured run history, case-insensitively. Every NEVER file gets a ready-to-paste `skyway run delete-sky-workflow` command. Always exits 0 — this step reports, it never deletes.
---
Reads `$SKY_OUTPUT_LIST` and `$SKY_OUTPUT_RUNS`, marks each file, and prints one suggested delete command per never-run workflow. Treat the output as a starting point for human review.
