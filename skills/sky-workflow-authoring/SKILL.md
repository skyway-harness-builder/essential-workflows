---
name: sky-workflow-authoring
description: Complete reference for authoring a valid Skylence .sky workflow — four-delimiter format, every meta and node option, all trigger types, the variable/template grammar, MUST/MUST NOT rules, and the full SKY-WF-* lint-code table. Use when writing or fixing a .sky file.
category: skylence
tags: [skylence, sky, workflow, authoring, lint, dag, reference]
---

# Authoring a .sky Workflow

A `.sky` file defines a DAG of execution nodes plus trigger metadata. The parser uses four Unicode delimiter blocks; every opener and closer must be alone on its line. This skill is self-contained — no marketplace plugin is required to author or lint a workflow. It mirrors the machine-readable language surface emitted by `sky describe --format json`.

## Delimiter Blocks

```
⊕meta⊕   ⊕⊕     workflow metadata; required, exactly one per file
§<id>§   §§     DAG node config; <id> is the node identifier
∆<id>∆   ∆∆     node prompt body; pairs with §<id>§ by matching id; Claude receives it verbatim
※※       ※※     doc / comment block; content is discarded by the parser
```

## Minimal Example

```
⊕meta⊕
name = "smoke-test"
description = "Manual smoke test"
output_style = "terse"
⊕⊕

§work§
bash = "echo 'hello'"
§§
```

## `⊕meta⊕` — Workflow Options

| Key | Type | Notes |
|-----|------|-------|
| `name` | string | **Required.** kebab-case; must match the filename. |
| `description` | string | **Required.** |
| `output_style` | string | `"terse"` appends a response-compression directive to every Claude prompt. Invalid value → SKY-WF-033. |
| `max_budget_usd` | number | Aggregate USD cap across all nodes in one run. |
| `claude.isolation` | string | `"strict"` (default) or `"loose"`. `loose` runs `--bare` (suppresses hooks); required by `permissions = "interactive"`. Invalid → SKY-WF-051. |
| `secrets` | []string | Env-var names reachable via `${env:NAME}` in `mcp_servers` and `http` nodes. |
| `mcp_servers` | object | Per-workflow MCP servers, merged with the managed mcp.json per run. Invalid shape → SKY-WF-049; name collision → SKY-WF-050. |
| `hooks.pre_tool_use` | object | `{ inject = "...", deny = ["Tool", "*"] }` — workflow-level tool gating. |
| `learnings` | object | `{ exclude = [...], only = [...], max_bytes = N }` — compound-knowledge injection (floor; overridable per node). Invalid → SKY-WF-062. |
| `run_doc` | bool | Generate a shared scratchpad skeleton at run start (used by spawn/council). |
| `trigger.*` | — | Exactly one trigger. See below. |

## Triggers

Set **exactly one**. With no trigger block, the workflow is **manual** — run via `sky run <name>` (pass inputs with `--var key=value`). `trigger.manual = true` is tolerated and means the same thing.

| Trigger | Keys |
|---------|------|
| Manual | (no trigger block) — `sky run <name> --var k=v` |
| GitHub | `trigger.github.events = ["issues", "pull_request", "issue_comment", "check_run.completed", …]`; `trigger.github.label = "..."`; `trigger.github.fork_policy = "deny"\|"allow"\|"trusted-only"`; `trigger.github.trusted_authors = [...]`; `trigger.github.check_run = { conclusion = "failure", name = "CI" }` (requires `check_run.completed` in events — SKY-WF-094; bad conclusion → SKY-WF-093) |
| Sky event | `trigger.sky_event.event = "deploy.completed"` — exact name emitted by another workflow's `emit` |
| Sentry / Linear / Jira | `trigger.<source>.events = [...]` — generic event-list triggers (empty list → SKY-WF-095) |

There is **no `cron` trigger** in this version — a `trigger.cron` key is silently ignored (the workflow falls back to manual). Don't use it.

## Node Common Keys (any node kind)

| Key | Type | Notes |
|-----|------|-------|
| `depends_on` | []string | Node IDs this node waits for. Output available as `$SKY_OUTPUT_<ID>`. Unknown ref → SKY-WF-021. |
| `when` | string | Condition; node skipped if false. See grammar below. |
| `model` | string | `sonnet` (default if omitted), `opus`, `haiku`. Not required — runtime defaults to sonnet. |
| `effort` | string | Claude effort level, e.g. `"max"` (extended thinking). |
| `isolation` | string | `worktree` or `worktree-run` — run in a dedicated git worktree (per-node; torn down after the node). |
| `keep_branch` | bool | Retain the worktree branch after cleanup. |
| `max_budget_usd` | number | Per-node USD spend cap. |
| `max_turns` | integer | Max Claude reasoning turns (≥ 1). |
| `trigger_rule` | string | `all_done` (default), `all_success`, `one_success`, `one_failure`. Invalid → SKY-WF-032. |
| `chain_from` | string | Node ID whose Claude session to resume. Must be in `depends_on` (SKY-WF-042); target must be a prompt/command node (SKY-WF-043); only valid on prompt/command nodes (SKY-WF-041). |
| `context` | string | `fresh` (reset inherited session) or `shared` (adopt first dep's session). |
| `skills` | []string | Skill names; each `.claude/skills/<name>/SKILL.md` is injected via `--append-system-prompt`. |
| `system_prompt` | string | Per-node system-prompt override. |
| `fallback_model` | string | Model used when the primary is overloaded. |
| `mcp_config` | string | Path to a per-node mcp.json override. |
| `allowed_tools` / `denied_tools` | []string | Tool allowlist / blocklist. |
| `permissions` | string | `interactive` enables `--permission-prompt-tool` (requires `claude.isolation = "loose"` — SKY-WF-059). |
| `thinking` | object | `{ mode = "adaptive"\|"enabled"\|"disabled", budget_tokens = N }`. |
| `sandbox` | object | `{ filesystem = { allow = ["rel/path"] } }` → `--add-dir`. Absolute/escaping path → SKY-WF-054. |
| `links` | []string | Codebase names whose paths are injected via `--add-dir`. Empty/with separator → SKY-WF-092. |
| `learnings` | object | Per-node override of the workflow learnings config. |
| `hooks` | object | Per-node hooks: `map[event][]{ matcher, response, timeout }`. |
| `retry` | object | `{ max_attempts = 1..5, delay_ms = N, on_error = "transient"\|"all" }`. |
| `output_format` | object | JSON Schema for structured output → `--json-schema`. Invalid schema → SKY-WF-060. |
| `emit` | object\|string | Sky event emitted on success: `"evt.name"` or `{ name = "evt", payload = { k = "v" } }`. |
| `safety` | string | `requires_permission` suppresses SKY-WF-063 on a destructive bash node. |

## Node Kinds

Exactly one execution kind per node (more than one → SKY-WF-024; none → SKY-WF-022). `loop` is a modifier that wraps the body kind.

| Kind | Keys |
|------|------|
| prompt | a `∆<id>∆` block (the prompt text). `model` selects the Claude model. |
| command | `command = ".sky/commands/<name>.md"`; optional `∆` block appended. Missing file → SKY-WF-010. |
| bash | `bash = "shell command"`. No `∆` block. |
| script | `script = { runtime = "bun"\|"uv", timeout = 30000, deps = [...] }`; body from the `∆` block. Bad runtime/templated deps → SKY-WF-052; binary missing → SKY-WF-053. |
| http | `http = { url, method = "GET", headers = {...}, body, expect_status = 0, timeout_s = 30 }`. Missing url → SKY-WF-034. |
| eval | `eval = { source = "$node.output", contains \| matches \| equals }` — exactly one assertion (SKY-WF-035/036). |
| loop | `loop = { until = { bash \| eval }, max = 10, idle_timeout_ms = N }`. Body can't be http/eval/wait (SKY-WF-037); until needs exactly one of bash/eval (SKY-WF-038); `max` cap 100 (SKY-WF-046); idle_timeout_ms is bash-only (SKY-WF-058). |
| wait | `wait = { prompt, channel = "manual"\|"webhook", timeout = "24h", approvers = [...] }`. Bad channel → SKY-WF-039; bad timeout → SKY-WF-040. |
| approval | structured gate extending wait: `{ prompt, channel, timeout, approvers, capture_response, on_reject = { prompt, prompt_node, max_attempts = 0..10 } }`. |
| cancel | `cancel = { reason = "..." }` — aborts the run; pair with `when`. |
| invoke | `invoke = { target = "other-workflow", vars = { k = "v" } }` — synchronous child run. Literal target only (SKY-WF-064); no self-invoke (066); not inside a loop (065); must exist (067). |
| acquire_lock / release_lock | `acquire_lock = { key = "name", ttl = "10m" }` (ttl default 10m, max 1h, ignored on release). Missing key → SKY-WF-068; bad ttl → SKY-WF-069. |
| spawn | `spawn = { workers = [{ id, prompt, model }], max_wait = "25m", on_idle = "any"\|"all", continue_prompt = "...", boundary = { read_only, own = [...], must_not_edit = [...] } }`. Empty workers → 078; empty id/prompt → 079/080; bad max_wait → 081; bad on_idle → 082; contradictory boundary → 083; `**` glob → 084. |
| council | `council = { members = [{ id, prompt }], synthesis = "...", max_wait = "25m", max_budget_usd = N }` — read-only advisors + synthesis. Empty members → 085; empty member → 086; empty synthesis → 087; bad max_wait → 088; negative budget → 089. |
| review | `review = { base = "main", target = "<pr#|branch>", paths = [...] }` — built-in read-only code review. Empty path entry → SKY-WF-091. |

## DAG Shape & Data Flow

`depends_on` defines edges; nodes with no path between them run in parallel. A diagram explains a non-trivial DAG far better than a node list:

```
          trigger  (manual | github | sky_event)
                       │
                       ▼
                  ┌─────────┐
                  │ classify │  haiku → JSON
                  └─────────┘
                 ╱     │      ╲      depends_on = ["classify"]   ← fan-out, run in parallel
                ▼      ▼       ▼     (each reads $SKY_OUTPUT_CLASSIFY)
            ┌──────┐┌──────┐┌──────┐
            │  a   ││  b   ││  c   │
            └──────┘└──────┘└──────┘
                 ╲     │      ╱      depends_on = ["a","b","c"]  ← join
                  ▼    ▼     ▼       trigger_rule = "one_success"
                  ┌───────────┐
                  │ synthesize │
                  └───────────┘
                       │  chain_from = "synthesize"  ← resumes the same Claude session
                       ▼
                  ┌─────────┐
                  │   fix   │ ⟲  loop.until.bash = "make test"   ← repeats body until exit 0 (loop.max)
                  └─────────┘
                       │  emit = { name = "fixed" }  → fires any workflow with trigger.sky_event.event = "fixed"
                       ▼
                     done
```

- **Edge** = `depends_on`. Upstream output reaches a node as `$SKY_OUTPUT_<ID>`.
- **Parallel** = sibling nodes sharing a dependency; `trigger_rule` decides when the join fires (`all_done` default, `one_success`, …).
- **Session reuse** = `chain_from` (solid intent, not a new edge — must also be in `depends_on`).
- **Loop** = `⟲`, a modifier on the body kind.
- **Fan-out to workers** inside one node = `spawn` / `council` (not separate DAG nodes).

**Sketch the DAG.** When a workflow branches, fans out, loops, or gates, draw its shape as an ASCII diagram in the top `※※` comment block. Readers grok flow from a picture far faster than from a node list, and `※※` content is discarded by the parser — diagrams cost nothing at runtime.

## Templates & Variables

`{{var}}` expansion runs in **prompt, http, and eval** node fields — **not** in `bash`, `script`, or `loop.until.bash` (use `$SKY_*` env vars there).

| Surface | Reference |
|---------|-----------|
| `∆` prompt / http / eval | `{{issue.title}}`, `{{repo.full_name}}`, `{{name}}` and other `--var` keys; `$SKY_OUTPUT_<ID>` |
| `bash` / `loop.until.bash` / `script` | `"$SKY_ISSUE_NUMBER"`, `"$SKY_OUTPUT_<ID>"`, `"$SKY_<UPPER_KEY>"`; in script: `process.env.SKY_OUTPUT_<ID>` |
| `mcp_servers` / `http` url·body·headers | `${env:NAME}` (must be in `secrets`) |
| `when` | `$node.output.field OP 'literal'` |

- `$SKY_OUTPUT_<ID>` uppercases the node id and replaces `-` with `_` (node `code-review` → `$SKY_OUTPUT_CODE_REVIEW`).
- Webhook payload keys flatten: `issue.number` → `$SKY_ISSUE_NUMBER`.
- `--var foo=bar` → `{{foo}}` in prompts, `$SKY_FOO` in bash.
- Filters (prompt/http/eval): `{{var|json}}` (quoted JSON value — required inside http.body JSON strings, else SKY-WF-047), `{{var|urlencode}}`.

## `when` Grammar

- `lhs == 'literal'` / `lhs != 'literal'` — RHS **must be single-quoted**; a bareword silently never fires.
- Boolean literal: `true` | `false` | `1` | `0` (empty string = false).
- Source: `evaluateCondition` in the runner. Parse failure → SKY-WF-031; bad `$node.output` ref → SKY-WF-030.

## Language

Write the workflow file entirely in **English** — `name`, every config key, all node ids, and every `∆` prompt body. A user's brief may arrive in any language; translate the intent, not the syntax. Only the `※※` comment blocks may be written in the user's spoken language.

## MUST

- **Lint before done:** `sky lint <dir>/<file>.sky` must pass. Errors are blocking.
- **`name` matches the filename** (kebab-case).
- **Exactly one trigger** (or none = manual).
- **Quote the RHS of every `when`:** `when = "$x.output == 'value'"`.
- **`chain_from` must appear in `depends_on`** (SKY-WF-042) and target a prompt/command node (SKY-WF-043).
- **Shell-quote every `$SKY_*` in bash:** `"$SKY_ISSUE_NUMBER"`, never bare.
- **Declare every `${env:NAME}`** (used in `mcp_servers`/`http`) in `secrets` (SKY-WF-055).

## MUST NOT

- Use `{{var}}` in `bash`, `script`, or `loop.until.bash` — use `$SKY_*` env vars.
- Use `${env:NAME}` in `prompt`/`bash`/`eval`/`script` — it resolves only for `mcp_servers`/`http` (SKY-WF-057). In bash, read `"$GITHUB_TOKEN"` directly.
- Use `trigger.cron` — unsupported; silently ignored.
- Commit secrets/tokens/`.env`.
- Change an `output_format` schema without updating the `∆` prompt that produces it.
- Run a destructive bash command without `safety = "requires_permission"` (SKY-WF-063).
- Add an `emit` that re-triggers a workflow already in the ancestor chain — the chain depth cap is **5** and over-cap dispatch is silently suppressed.

## Lint Codes (SKY-WF-*)

| Code | Meaning |
|------|---------|
| 001–007 | parse / validation / name-not-found / read / cycle / no-steps / section-format |
| 010–012 | command file: not found / parse error / no prompt body |
| 020–024 | DAG: dup id / unknown depends_on / no exec kind / self-dependency / >1 exec kind |
| 030–033 | bad `$node.output` ref / `when` parse / invalid `trigger_rule` / invalid `output_style` |
| 034–036 | http url required / eval source required / eval needs exactly one assertion |
| 037–038 | loop body can't be http·eval·wait / loop.until needs exactly one bash·eval |
| 039–040 | wait.channel invalid / wait.timeout invalid duration |
| 041–043 | chain_from: not prompt/command node / not in depends_on / target not prompt/command |
| 044–046 | exceeds max node count / JSON Schema validation / loop.max over cap |
| 047–048 | bare `{{var}}` in http.body JSON / bash sink receives prompt-node output |
| 049–051 | mcp_servers bad shape / name collision / claude.isolation invalid |
| 052–054 | script.runtime bad or templated deps / runtime binary missing / sandbox path escapes repo |
| 055–057 | `${env:NAME}` undeclared / empty name / unsupported location |
| 058–060 | loop.idle_timeout_ms misuse / permissions:interactive needs loose / output_format not valid JSON Schema |
| 061–063 | bare ultraplan/ultrareview keyword / learnings config invalid / destructive bash without safety |
| 064–069 | invoke: dynamic target / inside loop / self-invoke / not found · acquire_lock: key required / bad ttl |
| 078–084 | spawn: workers empty / empty id / empty prompt / bad max_wait / bad on_idle / contradictory boundary / `**` glob |
| 085–089 | council: members empty / empty member / synthesis empty / bad max_wait / negative budget |
| 091–095 | review path empty / links entry bad / check_run conclusion invalid / check_run without event / sentry·linear no events |

## Self-Check Before Finishing

1. Exactly one trigger (or none); `name` matches the filename.
2. Every `∆id∆` has a matching `§id§`; exactly one execution kind per node.
3. Every `chain_from` is in `depends_on` and targets a prompt/command node; every `when` RHS is quoted.
4. No `{{var}}` in bash/script/loop bodies; all `$SKY_*` shell-quoted; every `${env:NAME}` declared in `secrets`.
5. `sky lint` passes clean.
