# essential-workflows

The curated first-party workflow library for [skyway](https://github.com/skyway-harness-builder) — essentials only.

**You already have these.** Every skyway binary ships with this library embedded (the `skyway-bundled-workflows` source), so all of it is browsable and installable offline, out of the box:

```sh
skyway library list
skyway library install scaffold-sky-workflow
```

This repo is also the live remote source (`skyway-essential-workflows`): the embedded copy is a snapshot taken at build time, and `skyway library update` pulls anything published here since your binary was built.

## Layout

```
essential-workflows/
  manifest.yaml                    ← registry of all entries
  workflows/
    authoring/                     ← 11 workflows
      scaffold-sky-workflow/workflow.sky
      update-sky-workflow/workflow.sky
      rename-sky-workflow/{workflow.sky, scripts/}
      clone-sky-workflow/{workflow.sky, scripts/}
      delete-sky-workflow/{workflow.sky, scripts/}
      archive-sky-workflow/{workflow.sky, scripts/}
      codemod-sky-var/{workflow.sky, scripts/}
      convert-script-to-sky-workflow/{workflow.sky, scripts/}
      upgrade-sky-format/{workflow.sky, scripts/}
      annotate-sky-library/{workflow.sky, scripts/}
      create-workflow-collection/{workflow.sky, scripts/}
    audit/                         ← 12 workflows
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
      check-sky-environment/{workflow.sky, scripts/}
    docs/                          ← 6 workflows
      catalog-sky-library/{workflow.sky, scripts/}
      diagram-sky-workflow/workflow.sky
      explain-sky-workflow/{workflow.sky, scripts/}
      changelog-sky-workflow/{workflow.sky, scripts/}
      annotate-sky-workflow/{workflow.sky, scripts/}
      bulk-annotate-workflows/workflow.sky
    utilities/                     ← 3 workflows
      send-email/workflow.sky
      post-slack/workflow.sky
      draft-release-notes/{workflow.sky, scripts/}
  .claude/
    skills/                        ← 3 skills
      sky-workflow-authoring/SKILL.md
      sky-workflow-lint/SKILL.md
      sky-run-triage/SKILL.md
  scripts/
    validate-manifest.sh           ← manifest lint (also runs in CI)
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
| `annotate-sky-library` | Scan a library directory for unannotated `workflow.sky` files and annotate each in sequence. `--var dir=<dir>` |
| `create-workflow-collection` | Scaffold a new community workflow collection from the skeleton template, configure it, and push the first commit. `--var vendor=<slug> [--var repo=<name>] [--var org=<org>]` |

```sh
skyway library install scaffold-sky-workflow
skyway library install sky-workflow-authoring   # skill scaffold + update depend on
skyway run scaffold-sky-workflow \
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
| `dry-run-sky-library` | Run `skyway run --dry-run` against every workflow, print PASS/FAIL/SKIP matrix. `--var dir=<path>` |
| `audit-sky-secrets` | Scan `.sky` files for undeclared secret-shaped `$ENV` refs. `--var dir=<path>` |
| `check-sky-trigger-conflicts` | Detect workflows bound to the same non-manual trigger. `--var dir=<path>` |
| `find-orphan-sky-events` | Flag dangling `sky_event` triggers and orphan emit nodes. `--var dir=<path>` |
| `find-unused-sky-workflows` | Cross-reference `.sky` files against run history; list deletion candidates. `--var dir=<path>` |
| `audit-sky-budget` | Estimate per-workflow spend and flag LLM workflows missing `max_budget_usd`. `--var dir=<path>` |
| `sky-library-health-report` | Compose lint + recency + budget into a graded HEALTH.md. `--var dir=<path>` |
| `import-sky-library` | Validate and import foreign `.sky` files behind a manual gate. `--var dir=<dir> --var source=<src>` |
| `triage-failed-sky-run` | Pinpoint the failing node, root cause, and propose a fix diff. `--var dir=<dir> --var name=<file> --var run=<run-id>` |
| `check-sky-environment` | Preflight doctor: probe claude CLI, gh auth, git remote, daemon health, and declared-but-unset secrets; OK/WARN/FAIL per check. `--var dir=<path>` |

## Documentation workflows

Generate and maintain documentation for your `.sky` library.

| Name | Description |
|------|-------------|
| `catalog-sky-library` | Regenerate a browsable `INDEX.md` for a `.sky` directory. `--var dir=<path>` |
| `diagram-sky-workflow` | Regenerate the ※※ ASCII DAG header for one `.sky`. `--var dir=<dir> --var name=<file>` |
| `explain-sky-workflow` | Emit a plain-English walkthrough of a workflow's trigger, DAG, and nodes. `--var dir=<dir> --var name=<file>` |
| `changelog-sky-workflow` | Diff a `.sky` and append a changelog entry to `CHANGELOG.md`. `--var dir=<dir> --var name=<file>` |
| `annotate-sky-workflow` | Insert inline ※※ rationale comments before each node, then lint. `--var dir=<dir> --var name=<file>` |
| `bulk-annotate-workflows` | Annotate all `workflow.sky` files in the given folders with inline rationale comments, then lint each clean. `--var dirs=<dirs>` |

## Utilities workflows

Deterministic utilities: invoke targets for orchestration, plus GitHub release automation.

| Name | Description |
|------|-------------|
| `send-email` | Send one transactional email via the skyway daemon mail endpoint. Invoke from orchestration or run manually. `--var to=<addr> --var subject=<subj> --var content=<body> [--var html=<html>]` |
| `post-slack` | Post a plain-text Slack message via an incoming webhook URL in a named env var. Invoke from orchestration or run manually. `--var webhook_env_name=SLACK_WEBHOOK_URL --var text=<message>` |
| `draft-release-notes` | On `release.published` (or manually), collect commits since the previous tag and draft grouped release notes plus the exact apply command — propose-only. `--var tag=<tag>` |

## Skills

A workflow declares `skills = [...]` on a node; `skyway` injects the named `.claude/skills/<name>/SKILL.md` into that node's system prompt. Install a skill the same way as a workflow — no marketplace plugin required:

```sh
skyway library install sky-workflow-authoring
```

| Name | Description |
|------|-------------|
| `sky-workflow-authoring` | Self-contained reference for authoring a valid `.sky` workflow: four-delimiter format, trigger routing, node types, variable references, MUST/MUST NOT rules, and lint error-code fixes. |
| `sky-workflow-lint` | Lint-code table and self-check for fixing SKY-WF-* errors when reading `skyway lint` output. |
| `sky-run-triage` | Diagnosing a failed skyway run: env-channel data flow, when-condition quoting, chain_from semantics, failure classes in check order, propose-don't-apply. |

## Adding a custom source

To add a private org repo alongside this one, set `library.sources` in `~/.skylence/harness-builder/config.yaml`:

```yaml
library:
  sources:
    - repo: skyway-harness-builder/essential-workflows   # keep the default
    - repo: myorg/private-workflows
      name: internal
```

## Contributing

This is a [GitHub template repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template). Fork it to build your own private library; open a PR here to contribute a workflow back to the community.

Assets follow a **group → component** layout: `workflows/<group>/<name>/` holds one workflow per directory (groups: `authoring`, `audit`, `docs`, `utilities`) and `.claude/skills/<name>/SKILL.md` holds the skills. Each workflow is its own directory with a `workflow.sky` and a `scripts/` subfolder for any bash files it references. The `manifest.yaml` is the authoritative registry; each entry's `store:` and `plugin:` name its group.

To add a new workflow:
1. Create `workflows/<group>/<name>/workflow.sky` (and `scripts/` if needed).
2. Add an entry to `manifest.yaml` with matching `store:`, `plugin:`, and a `scripts:` list.
3. Bump `version` and `updated_at` in `manifest.yaml`.

Merged workflows reach users two ways: immediately via `skyway library update` (this repo is the live source), and embedded in the next binary release (`make sync-meta` snapshots the library into the binary at build time).

### CI gate

Every `.sky` file is linted by [`skyway-harness-builder/lint-action`](https://github.com/skyway-harness-builder/lint-action) on each push and pull request. **PRs with a failing lint check cannot be merged.** Fix lint errors first — `skyway lint <file>` locally, or open a PR and let the action report the exact error codes.
