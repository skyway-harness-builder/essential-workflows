---
short_description: Resolves the source file and previews every reference the rename will touch.
long_description: Locates the workflow, refuses when the target name already exists, and prints every skyway run reference to the old name that the apply step will rewrite. The gate shows this preview so the human approves an exact, known change.
---

Pure bash. Stops the run when the source is missing (listing the directory) or the destination name is taken.
