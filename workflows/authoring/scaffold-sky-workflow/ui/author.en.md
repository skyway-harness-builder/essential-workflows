---
short_description: Authors the new workflow file from the plain-English brief.
long_description: Uses the sky-workflow-authoring skill to translate a plain-English request into a valid .sky workflow file at the requested path. Writes the file but does not lint it — the lint node handles that in the next step.
---

Reads `{{request}}` and writes `{{dir}}/{{name}}/workflow.sky` using the full `.sky` format:
four delimiter blocks, exactly one trigger, a sensible node DAG, and machine-oriented
prompt bodies paired with human-readable `※※` comment blocks.
