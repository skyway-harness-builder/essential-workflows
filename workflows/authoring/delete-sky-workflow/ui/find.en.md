---
short_description: Locates the workflow file to delete.
long_description: Resolves the target path from the dir and name vars and exits non-zero when the file does not exist, halting the run before the gate. Lists the directory contents on a miss to help pick the right name.
---

Pure bash. Resolves `{{dir}}/{{name}}.sky`.
