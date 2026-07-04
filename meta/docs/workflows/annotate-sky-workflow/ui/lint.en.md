---
short_description: Loops skyway lint on the annotated file and repairs what it names.
long_description: Each pass runs skyway lint and fixes only the problems lint reports - most likely a malformed comment block from the annotate step, such as an opener not alone on its line. Never deletes a node, trigger, edge, or prompt body to satisfy the linter. Loops until clean, max 6 passes.
---

Sonnet node; `loop.until.bash` gates the loop on `skyway lint "{{dir}}/{{name}}.sky"`.
