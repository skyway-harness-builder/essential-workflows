---
short_description: Sets branch protection on the default branch (advanced tier).
long_description: "Protects the default branch: at least one PR review, dismiss stale reviews, linear history, no force pushes, and required conversation resolution. Free on public repos; a paid plan is required for private ones, so this node only fires when preflight computed `repo_advanced == 'true'`."
---
`enforce_admins` is deliberately left off so onboarding cannot lock the admin out — the report tells you to enable it manually once you are confident.
