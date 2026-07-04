---
short_description: Executes the rename - git mv, meta name fix, reference rewrite.
long_description: Moves the file with git mv, updates its meta name field to the new name, and text-replaces every skyway run reference to the old name across the directory using sed. All three edits happen in one step so the library never sees a half-renamed state.
---

Pure bash. The reference rewrite is a plain text replace of `skyway run <old>` -> `skyway run <new>`.
