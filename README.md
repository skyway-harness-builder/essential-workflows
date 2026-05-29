# skylence-be/workflows

Community workflow library for [Skylence](https://github.com/skylence-be/binary). Install any workflow directly from the CLI:

```sh
sky examples list
sky examples install hello-bash
```

This repo is the default remote source bundled with `sky`. Run `sky examples update` to pull the latest workflows.

## Workflows

These are meta-workflows for managing your own `.sky` library — create, update, and delete workflows.

| Name | Description |
|------|-------------|
| `scaffold-sky-workflow` | Author a new `.sky` workflow from a plain-English brief, then lint it until clean. `--var dir=<dir> --var name=<file> --var request=<what it should do>` |
| `update-sky-workflow` | Apply a change to an existing `.sky` workflow, then lint it until clean. `--var dir=<dir> --var name=<file> --var request=<change>` |
| `delete-sky-workflow` | Find a `.sky` workflow by name and delete it behind a manual approval gate. `--var dir=<dir> --var name=<file>` |

State **where** the workflow lives with `--var dir=` before running. The brief in `--var request=` may be in any language; the generated workflow is always written in English (only `※※` comments may be localized).

```sh
sky examples install scaffold-sky-workflow
sky examples install update-sky-workflow
sky examples install delete-sky-workflow
sky examples install sky-workflow-authoring   # the skill scaffold + update depend on
sky run scaffold-sky-workflow \
  --var dir=".sky/workflows" \
  --var name="deploy-on-tag" \
  --var request="on a GitHub release, run the deploy script and post the result to Slack"
```

## Skills

A workflow declares `skills = [...]` on a node; `sky` injects the named `.claude/skills/<name>/SKILL.md` into that node's system prompt. Install a skill the same way as a workflow — no marketplace plugin required:

```sh
sky examples install sky-workflow-authoring
```

| Name | Description |
|------|-------------|
| `sky-workflow-authoring` | Self-contained reference for authoring a valid `.sky` workflow: four-delimiter format, trigger routing, node types, variable references, MUST/MUST NOT rules, and lint error-code fixes. Used by `scaffold-sky-workflow` and `update-sky-workflow`. |

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

Assets are grouped by **domain folder**, each holding `workflows/` and `skills/` subfolders. The first domain is `meta/` (managing your own `.sky` library); add more as needed (e.g. `git/`, `release/`). The on-disk layout is organizational only — `sky examples install` routes each asset by its `kind`, not its path. To add one: drop the file under the right domain folder, add a `manifest.yaml` entry (nested `path:` + a domain tag), and bump `version` + `updated_at`.
