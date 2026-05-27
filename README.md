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
| `pure-laravel-new-feature-planning-to-prd-execution-to-pr` | Brownfield-aware Laravel feature pipeline: classify → package research → Blueprint PRD → manual approval → worktree execution → PR. Triggered by labelling an issue `sky-feature`. |

## Skills

Some workflows declare `skills = [...]` on a node; `sky` injects the named `.claude/skills/<name>/SKILL.md` into that node's system prompt. Install a skill the same way as a workflow:

```sh
sky examples install laravel-package-selection
```

| Name | Description |
|------|-------------|
| `laravel-package-selection` | Pick the most compatible Laravel package for a capability by walking vendor tiers (Laravel first-party → skylence-be org → Spatie → reputable vendors → lesser-known) with a compatibility/maintenance/license gate. Used by `pure-laravel-new-feature-planning-to-prd-execution-to-pr`. |

> The `pure-laravel-…` workflow also uses the `laravel-blueprint` skill, which ships with the Skylence [claude-code-marketplace](https://github.com/skylence-be/claude-code-marketplace) `laravel-development` plugin.

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
