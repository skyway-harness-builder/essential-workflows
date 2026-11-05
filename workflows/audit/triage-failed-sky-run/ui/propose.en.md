---
short_description: Emits a reviewable fix diff plus the command to apply it.
long_description: "Resumes the diagnose session (chain_from) and produces exactly two things: a unified `diff -u` patch for the .sky file that fixes the root cause, and the one-line `skyway run update-sky-workflow` command that applies it. Output only — it edits, writes, and runs nothing."
---
When the failure is environmental rather than a source defect, it says so plainly and skips the diff.
