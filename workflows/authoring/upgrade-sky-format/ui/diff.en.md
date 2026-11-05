---
short_description: Shows the git diff of what the upgrade changed.
long_description: Always runs (trigger_rule all_done), whether the fix node fired or was skipped, so every run ends with an exact record of the changes. The diff is empty when the file was already clean.
---

Pure bash: `git diff` scoped to the target file.
