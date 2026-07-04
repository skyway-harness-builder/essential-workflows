---
short_description: Detects workflows bound to the same non-manual trigger that would all fire on one event.
long_description: Two workflows listening on the same sky_event, cron schedule, or github event+action+label fire together silently, causing duplicate runs and double spend. This audit groups trigger signatures across a directory and reports any collision. Pure bash, exits non-zero on conflict.
---
A single `check` node extracts one trigger signature per file (`sky_event:<name>`, `cron:<sched>`, or `github:<ev>:<action>:<label>`), groups them, and prints any signature shared by more than one workflow. Manual triggers are ignored — they cannot collide.

| Variable | Meaning |
|----------|---------|
| `dir` | Directory of `.sky` files to check (e.g. `.sky/workflows`) |
