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
| `scaffold-sky-workflow` | Author a new `.sky` workflow from a plain-English brief, then lint it until clean. Run manually with `--var name=<file> --var request=<what it should do>`. |

```sh
sky examples install scaffold-sky-workflow
sky examples install sky-workflow-authoring   # the skill it depends on
sky run scaffold-sky-workflow \
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
| `sky-workflow-authoring` | Self-contained reference for authoring a valid `.sky` workflow: four-delimiter format, trigger routing, node types, variable references, MUST/MUST NOT rules, and lint error-code fixes. Used by `scaffold-sky-workflow`. |

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
