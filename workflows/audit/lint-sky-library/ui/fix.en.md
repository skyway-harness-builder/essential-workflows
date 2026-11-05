---
short_description: Claude edits each failing file in place until it lints clean.
long_description: Runs only when the scan failed (trigger_rule one_failure). A sonnet node reads each failing file, applies the standard fix for every SKY-WF-* code, and re-lints after each edit. Files that already passed are never touched.
---
Uses the sky-workflow-authoring skill and its error-code table. Makes the minimal change that clears lint while preserving each file's trigger, DAG, and safety guards.
