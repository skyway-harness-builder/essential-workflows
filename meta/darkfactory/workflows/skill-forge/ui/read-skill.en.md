---
short_description: Dumps the skill's SKILL.md and bundled scripts into one greppable block.
long_description: Deterministic bash, no LLM, read-only. Resolves the repo checkout and the target skill directory, then concatenates SKILL.md, a file inventory, and every bundled script into a stable block delimited by `=== skill-source ===`.
---
This block is the channel through which the skill's guidance reaches the model in later steps — `skills = [...]` would not work because skill names there are not `{{var}}`-templated. Reads `$SKY_SKILL_NAME` from the env channel.
