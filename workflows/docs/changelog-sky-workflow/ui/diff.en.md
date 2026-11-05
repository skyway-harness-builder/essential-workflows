---
short_description: Diffs the working tree against HEAD for the target file.
long_description: Produces the unified git diff of the workflow's uncommitted changes. When there are none, it emits a stable no-change marker instead of failing so the run still produces a changelog entry.
---

Pure bash. The diff (or `NO_UNCOMMITTED_CHANGES`) lands in `$SKY_OUTPUT_DIFF` for the describe step.
