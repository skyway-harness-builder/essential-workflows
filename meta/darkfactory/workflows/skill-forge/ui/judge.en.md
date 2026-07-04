---
short_description: Scores each eval case pass/fail and pinpoints where every failure lives.
long_description: Claude (opus). Judges the baseline transcripts against each case's pass criteria, classifies every failure as prose-ambiguity, missing-script, or script-bug, proposes a concrete fix, and computes the pass rate. Delivers is true only at pass_rate >= 0.8 with no script bugs.
---
The structured `output_format` is advisory only; the contract is the final machine sentinel line `SKY_FORGE delivers=<true|false> pass_rate=<n>`, which the deterministic gate step greps.
