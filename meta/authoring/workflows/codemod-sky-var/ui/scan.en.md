---
short_description: Greps all three token forms across the directory and previews every hit.
long_description: Computes the uppercase env-var forms of old and new, then searches every .sky file for the template, bash-env, and node-id forms of the token. Prints a numbered preview of each hit plus the set of affected files; fails when the directory or token is missing or nothing matches.
---

Pure bash. Zero hits is a hard stop (exit 1) - nothing to codemod means nothing to approve.
