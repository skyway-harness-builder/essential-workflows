---
short_description: Manual approval before the file is deleted.
long_description: Pauses the run until a human confirms the irreversible deletion. Rejecting stops the workflow with the file kept; nobody answering within an hour times the gate out.
---

Manual wait channel, prompt names the exact file: `{{dir}}/{{name}}.sky`.
