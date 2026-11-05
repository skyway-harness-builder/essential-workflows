---
short_description: Applies the requested change to the workflow file.
long_description: A sonnet node with the sky-workflow-authoring skill reads the existing file, applies only the change described in the request, and preserves everything else - delimiter blocks, the single trigger, node ids, and references stay consistent. Refreshes the ASCII flow diagram when the change alters the DAG shape.
---

Reads `{{dir}}/{{name}}.sky`, applies `{{request}}`, writes the updated file. Linting happens in the next step.
