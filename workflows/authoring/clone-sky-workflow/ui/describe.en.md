---
short_description: Prints a best-effort summary of the finished clone.
long_description: Runs skyway describe on the new workflow for a quick human-readable overview, tolerating the subcommand being unavailable, then prints done. Purely informational close to the run.
---

Pure bash. Failure of `skyway describe` does not fail the workflow.
