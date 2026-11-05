---
short_description: Parses the node graph and redraws the header's ASCII diagram.
long_description: A haiku node reads the file, records every depends_on, chain_from, and when edge, and builds an ASCII DAG that reflects only the real edges. It then replaces just the diagram section of the top loose comment header, preserving the title, run command, and var docs - per-step comment blocks are never touched.
---

Edits in place with the Edit tool. Conventions: `->` for a dependency edge, `=chain=>` for `chain_from`, `(when ...)` next to guarded nodes.
