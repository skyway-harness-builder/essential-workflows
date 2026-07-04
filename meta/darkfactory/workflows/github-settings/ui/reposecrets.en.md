---
short_description: Enables secret scanning and push protection on the repo (advanced tier).
long_description: Turns on GitHub secret scanning plus push protection for the target repository. Free on public repos; private repos need GitHub Advanced Security. Fails gracefully (warns, never crashes) when the plan or visibility does not allow it.
---
Runs only when preflight computed `repo_advanced == 'true'`.
