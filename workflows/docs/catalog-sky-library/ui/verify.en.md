---
short_description: Asserts every workflow made it into the index.
long_description: Bash coverage check - INDEX.md must exist, be non-empty, and list every .sky file in the directory. Exits non-zero when the index is stale or incomplete, so a bad regeneration never goes unnoticed.
---

Pure bash. Compares the directory's `.sky` list against the rows in `INDEX.md`.
