---
short_description: Loops skyway lint and repairs any delimiter damage from the redraw.
long_description: Each pass reads the file fresh, runs skyway lint, and applies the minimal fix for what lint names - typically a comment opener or closer no longer alone on its line, or a stray delimiter glyph inside the diagram text. Keeps the regenerated diagram intact; loops until clean, max 6 passes.
---

Haiku node; `loop.until.bash` gates the loop on `skyway lint "{{dir}}/{{name}}.sky"`.
