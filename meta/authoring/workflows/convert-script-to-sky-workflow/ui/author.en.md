---
short_description: Maps the source to a new .sky workflow file.
long_description: A sonnet node using the sky-workflow-authoring skill translates the source into a workflow at the target path - shell bodies become bash nodes, cron lines become a schedule trigger, Makefile recipes become bash nodes, and env vars go into the secrets array. Writes the file but does not lint it.
---

Reads the source from `$SKY_OUTPUT_READ` (or re-reads `{{source}}`) and writes `{{dir}}/{{name}}.sky` with exactly one trigger.
