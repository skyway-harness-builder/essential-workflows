---
short_description: Copies the source workflow to the new name, refusing to clobber.
long_description: Resolves the source file and plain-copies it to the destination. Exits with an error if the source is missing (listing the directory to help) or if the destination already exists - an existing workflow is never overwritten.
---

Pure bash. No content mutation yet; the rewrite step handles the name and trigger changes.
