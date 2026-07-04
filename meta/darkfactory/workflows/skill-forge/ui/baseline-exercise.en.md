---
short_description: Exercises the skill as written against every synthesized eval case.
long_description: Claude (sonnet). For each eval case it produces the response a skill-loaded model would give, using only the injected SKILL.md text and bundled scripts — no outside knowledge — so the judge can score the skill as written, including its gaps.
---
Captures one transcript per case, recording the response and which skill sections or scripts were used. It never scores itself and never edits files.
