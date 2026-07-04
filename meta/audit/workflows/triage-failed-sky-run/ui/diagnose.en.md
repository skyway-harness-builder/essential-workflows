---
short_description: Names the failing node and the concrete root cause.
long_description: A sonnet node reads the captured logs and workflow source, identifies the failing node id, and states which line, config, bash, or prompt caused the failure and why. It notes its confidence and whether the conclusion rests on a log line or source inference. It edits nothing.
---
If the logs do not name a node, it says so and infers the most likely culprit from the source plus any error text. Uses the sky-workflow-authoring skill.
