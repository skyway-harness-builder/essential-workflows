---
short_description: Writes the plain-English walkthrough of the workflow.
long_description: A haiku node reads the resolved file and writes a structured walkthrough - summary, trigger, every --var input, the node DAG in dependency order, the meaning of each edge, and a copy-pasteable skyway run command. Translates the delimiter format into prose and never edits the file.
---

Runs only when resolve succeeded (`trigger_rule = "all_success"`). Uses the `sky-workflow-authoring` skill to read the four-delimiter format accurately.
