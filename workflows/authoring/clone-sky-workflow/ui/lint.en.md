---
short_description: Loops skyway lint on the clone and fixes every reported issue.
long_description: Each pass re-reads the clone, runs skyway lint, and fixes all reported errors - typically leftovers from the trigger strip such as an orphaned secrets or when reference. Loops until lint exits clean, at most 6 passes.
---

Sonnet node with the `sky-workflow-authoring` skill. `loop.until.bash` runs `skyway lint` on the clone; the clone stays a manual workflow - no trigger is added back.
