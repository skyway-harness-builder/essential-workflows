---
short_description: Loops skyway lint on the updated file and fixes every error.
long_description: Each pass reads the file, runs skyway lint, and fixes all reported SKY-WF-* errors and warnings using the authoring skill's code table. Loops until lint exits clean, at most 6 passes.
---

Sonnet node with the `sky-workflow-authoring` skill. `loop.until.bash` gates the loop on `skyway lint "{{dir}}/{{name}}.sky"`.
