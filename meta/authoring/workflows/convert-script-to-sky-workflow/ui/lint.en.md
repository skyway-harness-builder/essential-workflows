---
short_description: Loops skyway lint on the generated workflow and fixes every error.
long_description: Each pass runs skyway lint on the freshly authored file, reads the reported SKY-WF-* codes, and edits the file to fix them. Loops until lint exits 0, at most 6 passes.
---

Sonnet node with the `sky-workflow-authoring` skill. `loop.until.bash` gates the loop on `skyway lint "{{dir}}/{{name}}.sky"`.
