---
short_description: Manual approval of the rename and reference rewrite.
long_description: Pauses the run until a human approves the rename plus the skyway run reference rewrite shown by the find step. Rejecting stops the workflow with nothing changed; the gate times out after one hour.
---

Manual wait channel. The prompt names the exact change: `{{name}}` -> `{{new-name}}` in `{{dir}}`.
