---
short_description: Resolves source and destination paths from the archive/restore mode.
long_description: Computes where the workflow file currently lives and where it should move to, based on the mode variable. Fails fast if the source is missing or the destination already exists, so the gate always shows a valid, non-clobbering move.
---

Pure bash. Reads `$SKY_MODE` (`archive` or `restore`), prints both paths, and exits non-zero when the move would be invalid.
