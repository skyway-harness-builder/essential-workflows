---
short_description: Verifies the target .sky file exists.
long_description: Exits with an error when the target file is missing, so the downstream all_success gates skip cleanly and no tokens are spent. Also reports the node-config block count for context.
---

Pure bash. Checks `{{dir}}/{{name}}.sky`.
