---
short_description: Inserts a rationale comment block before each node config.
long_description: A sonnet node with the sky-workflow-authoring skill adds a terse ※id※ block immediately before every §id§ opener, explaining the node's purpose and the meaning of each of its edges. Everything else - nodes, triggers, prompt bodies, the meta block - is preserved exactly.
---

Edits in place with the Edit tool (never bash/sed on delimiter lines). Skips a node only when an identical `※<id>※` rationale already precedes it.
