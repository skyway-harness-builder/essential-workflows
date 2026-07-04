# skylence-be/workflows

Community workflow library for [Skylence](https://github.com/skylence-be/binary). Install any workflow directly from the CLI:

```sh
sky library list
sky library install scaffold-sky-workflow
```

This repo is the default remote source bundled with `sky`. Run `sky library update` to pull the latest workflows.

## Layout

```
workflows/
  manifest.yaml                    ← registry of all entries
  meta/
    authoring/
      workflows/
        scaffold-sky-workflow/workflow.sky
        update-sky-workflow/workflow.sky
        rename-sky-workflow/{workflow.sky, scripts/}
        clone-sky-workflow/{workflow.sky, scripts/}
        delete-sky-workflow/{workflow.sky, scripts/}
        archive-sky-workflow/{workflow.sky, scripts/}
        codemod-sky-var/{workflow.sky, scripts/}
        convert-script-to-sky-workflow/{workflow.sky, scripts/}
        upgrade-sky-format/{workflow.sky, scripts/}
      skills/
        sky-workflow-authoring/SKILL.md
    audit/
      workflows/
        audit-sky-library/{workflow.sky, scripts/}
        lint-sky-library/{workflow.sky, scripts/}
        dry-run-sky-library/{workflow.sky, scripts/}
        audit-sky-secrets/{workflow.sky, scripts/}
        check-sky-trigger-conflicts/{workflow.sky, scripts/}
        find-orphan-sky-events/{workflow.sky, scripts/}
        find-unused-sky-workflows/{workflow.sky, scripts/}
        audit-sky-budget/{workflow.sky, scripts/}
        sky-library-health-report/{workflow.sky, scripts/}
        import-sky-library/{workflow.sky, scripts/}
        triage-failed-sky-run/{workflow.sky, scripts/}
    docs/
      workflows/
        catalog-sky-library/{workflow.sky, scripts/}
        diagram-sky-workflow/workflow.sky
        explain-sky-workflow/{workflow.sky, scripts/}
        changelog-sky-workflow/{workflow.sky, scripts/}
        annotate-sky-workflow/{workflow.sky, scripts/}
    darkfactory/
      workflows/
        board-prep/{workflow.sky, scripts/}
        github-settings/{workflow.sky, scripts/}
        skill-forge/{workflow.sky, scripts/}
        workflow-forge/{workflow.sky, scripts/}
      skills/
        darkfactory-onboarding/SKILL.md
      data/
        labels.yaml
```

Each workflow is a self-contained directory: `workflow.sky` plus a `scripts/` subfolder holding any bash files it references. The binary resolves `bash_file = "./scripts/x.sh"` relative to the workflow file's directory at runtime.

## Authoring workflows

Meta-workflows for managing your own `.sky` library — create, update, rename, and maintain workflows.

| Name | Description |
|------|-------------|
| `scaffold-sky-workflow` | Author a new `.sky` workflow from a plain-English brief, then lint it until clean. `--var dir=<dir> --var name=<file> --var request=<what it should do>` |
| `update-sky-workflow` | Apply a change to an existing `.sky` workflow, then lint it until clean. `--var dir=<dir> --var name=<file> --var request=<change>` |
| `rename-sky-workflow` | Atomically rename a `.sky`: git mv, fix meta name, rewrite refs, lint. `--var dir=<dir> --var name=<old> --var new-name=<new>` |
| `clone-sky-workflow` | Duplicate a `.sky` as a new manual-trigger template under a new name. `--var dir=<dir> --var name=<src> --var new-name=<dst>` |
| `delete-sky-workflow` | Find a `.sky` workflow by name and delete it behind a manual approval gate. `--var dir=<dir> --var name=<file>` |
| `archive-sky-workflow` | Move a workflow into `_archive/` with trigger neutralized (reversible). `--var dir=<dir> --var name=<file> --var mode=archive\|restore` |
| `codemod-sky-var` | Bulk-rename a `--var` key or node id across every `.sky` behind a gate. `--var dir=<dir> --var old=<k> --var new=<k>` |
| `convert-script-to-sky-workflow` | Read a shell script / Makefile target and author an equivalent `.sky`. `--var dir=<dir> --var name=<file> --var source=<file>` |
| `upgrade-sky-format` | Lint a `.sky` and apply minimal format fixes when it reports problems. `--var dir=<dir> --var name=<file>` |

```sh
sky library install scaffold-sky-workflow
sky library install sky-workflow-authoring   # skill scaffold + update depend on
sky run scaffold-sky-workflow \
  --var dir=".sky/workflows" \
  --var name="deploy-on-tag" \
  --var request="on a GitHub release, run the deploy script and post the result to Slack"
```

## Audit & health workflows

Lint, health-check, and maintain the integrity of a `.sky` library.

| Name | Description |
|------|-------------|
| `audit-sky-library` | Lint every `.sky` in a directory in one pass, exit non-zero on any failure. `--var dir=<path>` |
| `lint-sky-library` | Lint + Claude fix-loop until the whole library lints clean. `--var dir=<path>` |
| `dry-run-sky-library` | Run `sky run --dry-run` against every workflow, print PASS/FAIL/SKIP matrix. `--var dir=<path>` |
| `audit-sky-secrets` | Scan `.sky` files for undeclared secret-shaped `$ENV` refs. `--var dir=<path>` |
| `check-sky-trigger-conflicts` | Detect workflows bound to the same non-manual trigger. `--var dir=<path>` |
| `find-orphan-sky-events` | Flag dangling `sky_event` triggers and orphan emit nodes. `--var dir=<path>` |
| `find-unused-sky-workflows` | Cross-reference `.sky` files against run history; list deletion candidates. `--var dir=<path>` |
| `audit-sky-budget` | Estimate per-workflow spend and flag LLM workflows missing `max_budget_usd`. `--var dir=<path>` |
| `sky-library-health-report` | Compose lint + recency + budget into a graded HEALTH.md. `--var dir=<path>` |
| `import-sky-library` | Validate and import foreign `.sky` files behind a manual gate. `--var dir=<dir> --var source=<src>` |
| `triage-failed-sky-run` | Pinpoint the failing node, root cause, and propose a fix diff. `--var dir=<dir> --var name=<file> --var run=<run-id>` |

## Documentation workflows

Generate and maintain documentation for your `.sky` library.

| Name | Description |
|------|-------------|
| `catalog-sky-library` | Regenerate a browsable `INDEX.md` for a `.sky` directory. `--var dir=<path>` |
| `diagram-sky-workflow` | Regenerate the ※※ ASCII DAG header for one `.sky`. `--var dir=<dir> --var name=<file>` |
| `explain-sky-workflow` | Emit a plain-English walkthrough of a workflow's trigger, DAG, and nodes. `--var dir=<dir> --var name=<file>` |
| `changelog-sky-workflow` | Diff a `.sky` and append a changelog entry to `CHANGELOG.md`. `--var dir=<dir> --var name=<file>` |
| `annotate-sky-workflow` | Insert inline ※※ rationale comments before each node, then lint. `--var dir=<dir> --var name=<file>` |

## Dark Factory workflows

Eval-driven forges and onboarding workflows for the Dark Factory dev ladder.

| Name | Description |
|------|-------------|
| `skill-forge` | Drive a skill toward a measurable bar via generate→exercise→judge loop. `--var skill_name=<name>` |
| `workflow-forge` | Author + lint + dry-run + judge a `.sky` workflow from an intent brief. `--var intent="…"` |
| `board-prep` | Idempotently create the 9 lifecycle labels and link a GitHub Project (rung 0). `--var project=<project-number>` |
| `github-settings` | Apply best-practice GitHub settings via `gh`. `--var scope=both --var tier=free\|paid` |

## Skills

A workflow declares `skills = [...]` on a node; `sky` injects the named `.claude/skills/<name>/SKILL.md` into that node's system prompt. Install a skill the same way as a workflow — no marketplace plugin required:

```sh
sky library install sky-workflow-authoring
sky library install darkfactory-onboarding
```

| Name | Description |
|------|-------------|
| `sky-workflow-authoring` | Self-contained reference for authoring a valid `.sky` workflow: four-delimiter format, trigger routing, node types, variable references, MUST/MUST NOT rules, and lint error-code fixes. |
| `darkfactory-onboarding` | Onboard a repo into the Dark Factory — the 9-label lifecycle (`data/labels.yaml`), GitHub Project field schema, label→Status mapping, and what a project template carries vs what you wire by hand. |
| `sky-judge-gate` | Conduct for AI judge nodes in the judge→sentinel→deterministic-gate pattern: sentinel discipline, fail-closed rules, confidence self-enforcement, holdout freshness, untrusted-input handling. |
| `sky-run-triage` | Diagnosing a failed skyway run: env-channel data flow, when-condition quoting, chain_from semantics, failure classes in check order, propose-don't-apply. |

## Adding a custom source

To add a private org repo alongside this one, set `examples.sources` in `~/.sky/config.yaml`:

```yaml
library:
  sources:
    - repo: skylence-be/workflows   # keep the default
    - repo: myorg/workflows-internal
      name: internal
```

## Contributing

This is a [GitHub template repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template). Fork it to build your own private library; open a PR here to contribute a workflow back to the community.

Assets follow a **store → plugin → component** layout under `meta/`. Each plugin is a folder (`authoring`, `audit`, `docs`, `darkfactory`) holding `workflows/` and `skills/` subfolders. Each workflow is its own directory with a `workflow.sky` and a `scripts/` subfolder for any bash files it references. The `manifest.yaml` is the authoritative registry.

To add a new workflow:
1. Create `meta/<plugin>/workflows/<name>/workflow.sky` (and `scripts/` if needed).
2. Add an entry to `manifest.yaml` with `store: meta`, `plugin: <plugin>`, and a `scripts:` list.
3. Bump `version` and `updated_at` in `manifest.yaml`.

### CI gate

Every `.sky` file is linted by [`skylence-be/sky-lint-action`](https://github.com/skylence-be/sky-lint-action) on each push and pull request. **PRs with a failing lint check cannot be merged.** Fix lint errors first — `sky lint <file>` locally, or open a PR and let the action report the exact error codes.
