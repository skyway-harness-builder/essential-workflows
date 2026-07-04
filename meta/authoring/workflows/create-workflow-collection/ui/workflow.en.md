---
short_description: Scaffold a new community workflow collection from the GitHub skeleton template and push the first commit.
long_description: Creates a GitHub repo from the skyway-harness-builder/workflow-collection-skeleton template, configures it non-interactively with the provided vendor details (token replacements, directory rename, README cleanup), and pushes the first commit. Ends with the repo URL and the skyway library add command.
---

Runs in four steps: **preflight** (check `gh`, auth, and vars), **create** (`gh repo create --template`), **setup** (clone, replace tokens, rename `workflows/__vendor__/`, commit + push), **report** (print URL and next steps).

Inputs via `--var`:

| Variable | Meaning |
|----------|---------|
| `vendor` | Required kebab-case slug used in paths and manifest tags |
| `repo` | GitHub repo name to create (default `<vendor>-workflows`) |
| `org` | GitHub org or user owning the new repo (default: authenticated user) |
| `vendor-name` | Display label for the vendor (default: same as vendor) |
| `description` | One-line description for the GitHub repo and README |
