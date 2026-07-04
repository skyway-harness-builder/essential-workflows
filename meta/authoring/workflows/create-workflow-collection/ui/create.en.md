---
short_description: Creates the GitHub repo from the skeleton template.
long_description: Runs gh repo create with the workflow-collection-skeleton template, public visibility, and the given description. Fails when the repo already exists - an existing collection is never overwritten.
---

Pure bash: `gh repo create <org>/<repo> --template workflow-collection-skeleton --public`.
