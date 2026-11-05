---
short_description: Regenerate a .sky file's ASCII DAG header from its actual node graph, then lint clean.
long_description: Keeps the human-readable flow diagram in a workflow's header honest - parses the real depends_on, chain_from, and when edges and redraws the ASCII DAG in the top comment block to match, editing in place. The regenerated diagram is best-effort; eyeball it against the node configs before relying on it.
---

Runs in two steps: **draw** (haiku parses the node graph and rewrites only the header diagram) then **lint** (haiku loop repairs any delimiter damage until `skyway lint` exits 0, max 6 passes).

Inputs via `--var`:

| Variable | Meaning |
|----------|---------|
| `dir` | Directory holding the target `.sky` file (e.g. `.sky/workflows`) |
| `name` | Target workflow filename without the `.sky` extension |
