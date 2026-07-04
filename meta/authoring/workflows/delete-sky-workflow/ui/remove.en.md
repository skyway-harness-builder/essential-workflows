---
short_description: Deletes the workflow file after approval.
long_description: Runs only after the confirm gate is approved and removes the file with rm. The last step of the run - there is no undo beyond your version control.
---

Pure bash: `rm {{dir}}/{{name}}.sky`.
