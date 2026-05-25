# skylence-be/workflows

Community workflow library for [Skylence](https://github.com/skylence-be/binary). Install any workflow directly from the CLI:

```sh
sky examples list
sky examples install hello-bash
```

This repo is the default remote source bundled with `sky`. Run `sky examples update` to pull the latest workflows.

## Workflows

| Name | Description |
|------|-------------|
| `hello-bash` | Pure bash starter. Prints hostname and date. No LLM tokens. |
| `hello-claude` | Single Claude step. Describes what the current directory contains. |
| `review` | Read-only code review of a branch against main. |
| `manual-gate` | Bash step gated by manual approval. Demonstrates the wait primitive. |
| `ci-autofix` | CI autofix. Triggers on failed check runs, applies a fix, pushes to the PR branch. |
| `multi-agent-investigation` | Multi-agent incident investigation with parallel analysts, shared run-doc, and lock. |

## Adding a custom source

To add a private org repo alongside this one, set `examples.sources` in `~/.sky/config.yaml`:

```yaml
examples:
  sources:
    - repo: skylence-be/workflows   # keep the default
    - repo: myorg/workflows-internal
      name: internal
```

## Contributing

This is a [GitHub template repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template). Fork it to build your own private library; open a PR here to contribute a workflow back to the community.

Every workflow lives in `workflows/`. Add an entry to `manifest.yaml` when adding a new file. Bump `version` and `updated_at` with each release.
