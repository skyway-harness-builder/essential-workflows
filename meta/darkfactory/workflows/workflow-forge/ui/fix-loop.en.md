---
short_description: Loops opus rewrites of the candidate until skyway lint reports it clean.
long_description: "Opus loop with `context = \"fresh\"` — each fix pass starts from a clean session. The stop condition is the lint itself: `loop.until.bash` runs `skyway lint` on the candidate and exits 0 when clean; `loop.max = 3` caps the spend."
---
Each pass reads the lint diagnostics and rewrites the whole file in place to clear the reported `SKY-WF-*` / `SKY-CFG-*` codes, keeping the name `forge-candidate` and preserving the intended behavior — fix the format, not the intent.
