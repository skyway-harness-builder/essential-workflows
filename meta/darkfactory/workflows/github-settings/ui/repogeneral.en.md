---
short_description: "Applies repo merge hygiene: squash-only, auto-merge, delete-branch-on-merge."
long_description: "Configures the repository's merge and feature settings: squash-only merges, auto-merge, delete-branch-on-merge, allow-update-branch, and enables issues, wiki, and projects. Free-tier, any visibility — the universal baseline every repo gets."
---
Runs only when preflight computed `do_repo == 'true'`. Every call is a settings upsert, so re-runs converge to the same state.
