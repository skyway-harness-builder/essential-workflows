---
short_description: Opus checks whether the candidate actually matches the operator's intent.
long_description: Claude (opus). Reads the candidate file and assesses trigger, node shape, on-paper behavior, and completeness against `{{intent}}` — flagging anything that lints clean but is intent-wrong, like a `when` that never fires. When in doubt it says no.
---
The structured `output_format` is advisory; the contract is the final machine sentinel line `SKY_FORGE delivers=<true|false>`, which the deterministic gate greps. Judgment is on paper only — the workflow has not been executed.
