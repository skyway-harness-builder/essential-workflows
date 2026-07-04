---
short_description: Prints both orphan lists and exits 1 if any orphan edge exists.
long_description: Reports dead listeners (events nobody emits) and dead signals (emits nobody listens for), then cleans up the temp files. The non-zero exit makes the audit CI-friendly.
---
Runs after `match`.
