---
short_description: Lints the moved file at its new location.
long_description: Runs skyway lint against the workflow at its post-move path to confirm the move introduced no syntax errors. Exits non-zero on any lint failure so a broken archive or restore surfaces immediately.
---

Runs `skyway lint` on the moved file. Cheap final check — moving a file should never change its content.
