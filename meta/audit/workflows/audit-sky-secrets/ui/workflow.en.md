---
short_description: Finds secret-shaped env-var references in .sky files that are not declared in secrets[].
long_description: Scans every .sky in a directory for credential-looking environment variables used in bash/http lines but missing from that workflow's secrets array. Pure bash, no LLM tokens. A heuristic reviewer, not a parser — treat findings as "review these".
---
A single `scan` node checks each file: a name is secret-shaped if it contains an underscore (e.g. `DATABASE_URL`) or matches `token|secret|password|passwd|apikey|credential` (case-insensitive); `$SKY_*` template vars are exempt. Exits non-zero if any undeclared reference is found.

| Variable | Meaning |
|----------|---------|
| `dir` | Directory of `.sky` files to scan (e.g. `.sky/workflows`) |
