---
short_description: Statically lints the skill's bundled scripts — parse-only, never executed.
long_description: Deterministic bash, no LLM. Runs `bash -n` on shell scripts and `node --check` on JavaScript where a toolchain exists in-container. Languages without one (e.g. Go) defer to CI on the pushed branch.
---
Non-fatal by design: a static-check failure is reported into the PR body rather than blocking; CI on the pushed branch is the real gate. Scripts are parsed, never run — part of the v1 safety scope.
