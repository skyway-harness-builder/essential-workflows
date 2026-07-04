---
short_description: Re-lints every imported file and cleans up the staging list.
long_description: Runs `skyway lint` on each newly-copied file to confirm it is still clean in its new home, then removes the /tmp staging list. Exits nonzero if any imported file is broken, failing the run.
---
Final safety check: an import only counts as successful when every landed file lints clean in the target directory.
