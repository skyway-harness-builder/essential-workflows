---
short_description: "Applies org-wide defaults: read-only base permission, commit signoff, Dependabot for new repos."
long_description: "Sets org-level general defaults via the GitHub API: `default_repository_permission=read`, required web commit signoff, and Dependabot alerts plus security updates for new repositories. On the paid tier it also enables the org advanced-security and secret-scanning defaults for new repos."
---
Runs only when preflight computed `do_general == 'true'` (org scope requested and the caller is an org owner). Paid-only fields are gated inside the script and fail gracefully.
