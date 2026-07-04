---
short_description: Summarizes applied versus skipped settings per scope and tier.
long_description: Deterministic bash, no LLM. The leaf node — it depends on all five apply nodes with `trigger_rule = all_done`, so it always runs and always produces a summary, including skip reasons such as "not an org owner".
---
Echoes what each node applied or skipped, the `general_skip_reason` when org scope was skipped, and manual follow-ups such as enabling org-wide 2FA (`two_factor_requirement_enabled` is read-only in the API and only reported).
