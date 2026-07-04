---
short_description: Moves the workflow to _archive/ (or back), stripping trigger lines on archive.
long_description: In archive mode it creates the _archive/ directory, deletes every trigger line from the file, and moves it with git mv (falling back to mv). In restore mode it moves the file back; the trigger stays neutralized so the workflow returns as manual-only.
---

Pure bash. The trigger strip (`grep -v '^trigger.'`) is what guarantees an archived file can never auto-fire, even if the loader scans `_archive/`.
