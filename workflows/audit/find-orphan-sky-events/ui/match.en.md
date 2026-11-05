---
short_description: Diffs the listener and emitter lists to find orphans on either side.
long_description: Uses comm/grep on the scratch lists from collect to find listeners without an emitter and emitters without a listener. Hands both orphan lists to the report step.
---
Runs after `collect`.
