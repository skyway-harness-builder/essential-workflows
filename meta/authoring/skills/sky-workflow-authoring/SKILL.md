---
name: sky-workflow-authoring
description: Complete reference for authoring a valid Skylence .sky workflow — four-delimiter format, every meta and node option, all trigger types, the variable/template grammar, MUST/MUST NOT rules, and the full SKY-WF-* lint-code table. Use when writing or fixing a .sky file.
category: skylence
tags: [skylence, sky, workflow, authoring, lint, dag, reference]
---

# Authoring a .sky Workflow

A `.sky` file defines a DAG of execution nodes plus trigger metadata. The parser uses four Unicode delimiter blocks; every opener and closer must be alone on its line. This skill is self-contained — no marketplace plugin is required to author or lint a workflow. It mirrors the machine-readable language surface emitted by `skyway describe --format json`.

## Two Audiences (read this first)

A `.sky` file is written for two readers with **opposite** priorities. Get this right and everything else follows.

- **The workflow body — `∆` prompt blocks, config keys, node ids — is for the AI that runs the node.** Optimize purely for the model executing the task correctly. Be terse, telegraphic, machine-oriented. **Do not care whether a human can read it**, and do not pad or soften it for human eyes — the end user never reads the prompt body, by design. It only has to *work*. (Keep it English; see Language below.)
- **The `※※` comment blocks are for the human.** The exact opposite goal: a person should open the file and immediately understand what it does, why, and how the pieces connect. Optimize hard for human comprehension — clear prose and, when a picture helps, a diagram.

When the two pull in different directions, keep the prompt body machine-optimal and move every human-oriented explanation into a `※※` block.

**Prompt body (wrong, AI defaults to this):**
```
Steps:
1. Read the file at {{path}}.
2. Check each function for error handling gaps.
3. For each gap found, note the function name and what is missing.
4. Output a summary of your findings.
```
**Prompt body (correct):**
```
Read {{path}}. For each function missing error handling, note its name and what's missing. Output a summary.
```
Same instruction, one line, no ceremony. The model executes it identically.

**Per-node `※<id>※` annotations** use the typed opener so the block is associated with a specific node. Body: one terse prose sentence describing the node's purpose, followed by the edges it carries (only edges that exist; never list absent ones). No key/value lists, no "Step N" prefixes.

Wrong (lists absent edges, uses list format):
```
※resolve※
Entry node. No LLM. Normalizes the issue reference.
depends_on: none (DAG root).
trigger_rule: n/a.
chain_from: none.
when: none.
※※
```
Correct:
```
※resolve※
Bash root node. Normalizes the issue reference into $SKY_OUTPUT_RESOLVE so all downstream nodes read it the same way regardless of trigger path.
※※
```
Only mention depends_on, trigger_rule, chain_from, when, or loop when they are actually set on the node.

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
| `ui` | string | Path to a dashboard UI card file describing the **whole workflow** for the outer workflow card. Same resolution rules as the node-level `ui` key: `"ui/workflow"` (extensionless) → locale set: `ui/workflow.<lang>.md` (e.g. `ui/workflow.en.md`, `ui/workflow.nl.md`); `"ui/overview.md"` → single file (locale "default"). The markdown file may have YAML frontmatter with `short_description` (one-line), `long_description` (problem + backstory), and a `changelog` list (`version`, `date` (optional), `note`); the body is freeform markdown rendered into the workflow card. Pure UI — ignored by the DAG engine. No matching file → SKY-WF-103 (warning). |
| `trigger.*` | — | Exactly one trigger. See below. |

## MCP Servers & Transports

`mcp_servers` is a JSON object; each entry picks a transport via `type`: `stdio` (subprocess), `http` (streamable HTTP, the modern remote transport), or `sse` (deprecated, do not use).

```
mcp_servers = {"remote": {"type": "http", "url": "http://localhost:9000/mcp"}, "local": {"type": "stdio", "command": "npx", "args": ["-y", "pkg", "mcp"]}}
```

Each node is a fresh Claude session, so transport choice is mostly about **startup cost, not per-message latency**:

| Want | Use | Why |
|------|-----|-----|
| A tool sky already ships (file read/edit, grep) | nothing: use the built-in `skylence_*` tools | served in-process over HTTP, zero spawn, no config |
| An external server hit by several or parallel nodes | a shared `http` daemon (`type:"http"`, `url`) | one running server, every node connects instantly, no contention |
| A one-off in a single node | `stdio` | fine, but each node spawns its own subprocess |

`http` and in-process servers pay no per-session startup. `stdio` spawns a fresh subprocess on **every node** (cold-start cost), and parallel nodes spawning the same stdio server contend. Never use `sse`.

> **stdio + `allowed_tools` waits before the first turn.** When a node both restricts tools (`allowed_tools`) and uses a `stdio` server, the runner holds the first prompt ~10s (`SKY_MCP_READY_DELAY_MS`) so the server finishes connecting first; otherwise the still-connecting tool is filtered from the model's view and reported "not available." `http` and in-process servers have no such wait. One more reason to prefer a shared `http` daemon for any server hit by multiple nodes.

## Outbound transport (email, Slack, webhooks)

When a workflow must send email, post to Slack, or call a webhook sink, do not hand-write curl in orchestration nodes. Use this order of preference:

1. **Invoke a library micro-workflow** — `invoke = { target = "send-email", vars = { to = "...", subject = "...", content = "..." } }` or `invoke = { target = "post-slack", vars = { webhook_env_name = "SLACK_WEBHOOK_URL", text = "..." } }`. Deterministic, versioned, lint-checked. No `retry` on sinks.
2. **HTTP node** — when the sink has a stable URL and auth fits the secrets allowlist: `http = { url = "...", method = "POST", headers = { Authorization = "Bearer ${env:TOKEN}" }, body = "...", timeout_s = 30 }`. Declare every `${env:NAME}` in `secrets = [...]`. No `retry` on sinks.
3. **Bash + curl** — bespoke sinks only. Build JSON with `jq -n` (never inline quoting). Always `curl --fail --max-time 30`. Read bearer tokens from the shell env (`"$SKY_MAIL_TOKEN"`, `"$EMAIL_API_TOKEN"`). No `retry` on sinks.

The `send-email` micro-workflow POSTs to `http://127.0.0.1:3090/api/mail/send` with `Authorization: Bearer "${EMAIL_API_TOKEN:-$SKY_MAIL_TOKEN}"`. The daemon injects `SKY_MAIL_TOKEN` into every run subprocess.

## Triggers

Set **exactly one**. With no trigger block, the workflow is **manual** — run via `skyway run <name>` (pass inputs with `--var key=value`). `trigger.manual = true` is tolerated and means the same thing.

| Trigger | Keys |
|---------|------|
| Manual | (no trigger block) — `skyway run <name> --var k=v` |
| GitHub | `trigger.github.events = ["issues", "pull_request", "issue_comment", "check_run.completed", …]`; `trigger.github.label = "..."`; `trigger.github.fork_policy = "deny"\|"allow"\|"trusted-only"`; `trigger.github.trusted_authors = [...]`; `trigger.github.check_run = { conclusion = "failure", name = "CI" }` (requires `check_run.completed` in events — SKY-WF-094; bad conclusion → SKY-WF-093) |
| Sky event | `trigger.sky_event.event = "deploy.completed"` — exact name emitted by another workflow's `emit` |
| Schedule | `trigger.schedule.cron = "0 3 * * *"` (required, standard 5-field `min hour dom mon dow`); `trigger.schedule.timezone = "Europe/Brussels"` (optional IANA name, defaults UTC). Missing cron → SKY-WF-096; bad expr → SKY-WF-097; bad timezone → SKY-WF-098. The daemon must be running for schedules to fire. |
| Sentry / Linear / Jira | `trigger.<source>.events = [...]` — generic event-list triggers (empty list → SKY-WF-095) |

**Schedule timezone & DST.** Schedule times resolve against an explicit IANA timezone — never the host's OS-local zone. Resolution order: `trigger.schedule.timezone` → the daemon's `SKY_SCHEDULE_TIMEZONE` config default → `UTC`. Because resolution uses IANA names, DST is handled by wall-clock: `0 3 * * *` fires at **03:00 local in both winter and summer** (the UTC offset shifts, the hour does not). At a spring-forward gap the run advances to the next valid time; at a fall-back overlap it fires once. Use a region name like `Europe/Brussels`, not a fixed offset or `Local` (rejected by SKY-WF-098). Note: `trigger.cron` (top-level) is **not** a trigger — the key is `trigger.schedule.cron`.

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
| `output_format` | string | JSON Schema for structured output → `--json-schema`. **Value must be a compact JSON string on one line**, not a TOML inline table. Correct: `output_format = {"type":"object","required":["x"],"properties":{"x":{"type":"string"}}}`. Wrong: `output_format = { type = "object", ... }` (TOML syntax, SKY-WF-001 parse error). Invalid schema → SKY-WF-060. |
| `emit` | object\|string | Sky event emitted on success: `"evt.name"` or `{ name = "evt", payload = { k = "v" } }`. |
| `safety` | string | `requires_permission` suppresses SKY-WF-063 on a destructive bash node. |
| `ui` | string | Path to a dashboard UI card file (relative to the `.sky` file). Two forms: `"ui/<step>"` (extensionless) → locale set: resolves `ui/<step>.<lang>.md` (e.g. `ui/review.en.md`, `ui/review.nl.md`); `"ui/<step>.md"` → single file (locale "default"). Each file may have YAML frontmatter (`short_description`, `long_description`); markdown body is rendered to HTML in the node card. Pure UI — ignored by the DAG engine. No matching file → SKY-WF-103 (warning). The same frontmatter keys (`short_description`, `long_description`) are shared with the workflow-level `ui` key in `⊕meta⊕` (which additionally supports a `changelog` list). |

## Node Kinds

Exactly one execution kind per node (more than one → SKY-WF-024; none → SKY-WF-022). `loop` and `foreach` are modifiers that wrap the body kind.

| Kind | Keys |
|------|------|
| prompt | a `∆<id>∆` block (the prompt text). `model` selects the Claude model. |
| command | `command = ".sky/commands/<name>.md"`; optional `∆` block appended. Missing file → SKY-WF-010. |
| bash | `bash = "single-line shell command"`. No `∆` block. For multi-line scripts use `bash_file = "./scripts/<name>.sh"` (place the file in a `scripts/` subdirectory alongside the `.sky` file). Triple-quoted strings (`bash = """..."""`) are not supported and cause SKY-WF-001. |
| script | `script = { runtime = "bun"\|"uv", timeout = 30000, deps = [...] }`; body from the `∆` block. Bad runtime/templated deps → SKY-WF-052; binary missing → SKY-WF-053. |
| http | `http = { url, method = "GET", headers = {...}, body, expect_status = 0, timeout_s = 30 }`. Missing url → SKY-WF-034. |
| eval | `eval = { source = "$node.output", contains \| matches \| equals }` — exactly one assertion (SKY-WF-035/036). |
| loop | `loop = { until = { bash \| eval }, max = 10, idle_timeout_ms = N }`. Body can't be http/eval/wait (SKY-WF-037); until needs exactly one of bash/eval (SKY-WF-038); `max` cap 100 (SKY-WF-046); idle_timeout_ms is bash-only (SKY-WF-058). |
| foreach | `foreach = { items = ["a","b"] \| "$node.output" \| "{{var}}", max_concurrency = 3 }`. Body must be exactly one of prompt/command/bash/bash_file/script (SKY-WF-105); `items` invalid/empty → SKY-WF-104; `max_concurrency` out of 0–32 → SKY-WF-106; `chain_from` into/out of the node → SKY-WF-107. Runs the body once per resolved item (default sequential; up to `max_concurrency` in parallel); child steps named `<node-id>.<index>`; aggregate output is a JSON array of per-item outputs in order. |
| wait | `wait = { prompt, channel = "manual"\|"webhook", timeout = "24h", approvers = [...] }`. Bad channel → SKY-WF-039; bad timeout → SKY-WF-040. |
| approval | structured gate extending wait: `{ prompt, channel, timeout, approvers, capture_response, on_reject = { prompt, prompt_node, max_attempts = 0..10 } }`. |
| cancel | `cancel = { reason = "..." }` — aborts the run; pair with `when`. |
| invoke | `invoke = { target = "other-workflow", vars = { k = "v" } }` — synchronous child run. Literal target only (SKY-WF-064); no self-invoke (066); not inside a loop (065); must exist (067). |
| acquire_lock / release_lock | `acquire_lock = { key = "name", ttl = "10m" }` (ttl default 10m, max 1h, ignored on release). Missing key → SKY-WF-068; bad ttl → SKY-WF-069. |
| spawn | `spawn = { workers = [{ id, prompt, model }], max_wait = "25m", on_idle = "any"\|"all", continue_prompt = "...", boundary = { read_only, own = [...], must_not_edit = [...] } }`. Empty workers → 078; empty id/prompt → 079/080; bad max_wait → 081; bad on_idle → 082; contradictory boundary → 083; `**` glob → 084. |
| council | `council = { members = [{ id, prompt }], synthesis = "...", max_wait = "25m", max_budget_usd = N }` — read-only advisors + synthesis. Empty members → 085; empty member → 086; empty synthesis → 087; bad max_wait → 088; negative budget → 089. |
| review | `review = { base = "main", target = "<pr#\|branch>", paths = [...] }` — built-in read-only code review. Empty path entry → SKY-WF-091. |

## DAG Shape & Data Flow

`depends_on` defines edges; nodes with no path between them run in parallel. A diagram explains a non-trivial DAG far better than a node list:

```
          trigger  (manual | github | sky_event)
                       │
                       ▼
                  ┌─────────┐
                  │ classify│  haiku → JSON
                  └─────────┘
                 ╱     │      ╲      depends_on = ["classify"]   ← fan-out, run in parallel
                ▼      ▼       ▼     (each reads $SKY_OUTPUT_CLASSIFY)
            ┌──────┐┌──────┐┌──────┐
            │  a   ││  b   ││  c   │
            └──────┘└──────┘└──────┘
                 ╲     │      ╱      depends_on = ["a","b","c"]  ← join
                  ▼    ▼     ▼       trigger_rule = "one_success"
                  ┌───────────┐
                  │ synthesize│
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

**Diagram the flow when a picture beats words.** When a workflow branches, fans out, loops, or gates — or any time a diagram conveys it faster than prose — put one in a `※※` comment block. Pick the **most pragmatic form for the case**, not a fixed one:

- **ASCII** (boxes/arrows, like the DAG above) — renders everywhere: terminals, plain diffs, any viewer. Default for structural DAG shape.
- **Mermaid** ` ```mermaid flowchart``` ` — renders on GitHub and most docs; best for larger branching graphs.
- **Mermaid `sequenceDiagram`** — when ordering and hand-offs between nodes/services matter more than the graph shape.
- **Swimlanes** (ASCII columns or Mermaid) — when responsibilities split across actors (e.g. workflow vs. GitHub vs. a human approver).

Choose whatever a human grasps fastest, and optimize the diagram for that human — this lives in a `※※` block, the human-facing half of the file. `※※` content is discarded by the parser, so any diagram costs nothing at runtime.

## Templates & Variables

`{{var}}` expansion runs in **prompt, http, and eval** node fields — **not** in `bash`, `script`, or `loop.until.bash` (use `$SKY_*` env vars there). A `foreach` node's body follows the same rule: `{{item}}`/`{{item_index}}`/`{{item_total}}` reach only the prompt/template channel; a bash/script body must read `$SKY_ITEM`/`$SKY_ITEM_INDEX`/`$SKY_ITEM_TOTAL` instead.

| Surface | Reference |
|---------|-----------|
| `∆` prompt / http / eval | `{{issue.title}}`, `{{repo.full_name}}`, `{{name}}` and other `--var` keys; `$SKY_OUTPUT_<ID>` |
| `bash` / `loop.until.bash` / `script` | `"$SKY_ISSUE_NUMBER"`, `"$SKY_OUTPUT_<ID>"`, `"$SKY_<UPPER_KEY>"`; in script: `process.env.SKY_OUTPUT_<ID>` |
| `foreach` prompt/command body | `{{item}}`, `{{item_index}}` (0-based), `{{item_total}}` |
| `foreach` bash/script body | `"$SKY_ITEM"`, `"$SKY_ITEM_INDEX"`, `"$SKY_ITEM_TOTAL"` |
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

- **Lint before done:** `skyway lint <dir>/<file>.sky` must pass. Errors are blocking.
- **`name` matches the filename** (kebab-case).
- **Exactly one trigger** (or none = manual).
- **Quote the RHS of every `when`:** `when = "$x.output == 'value'"`.
- **`chain_from` must appear in `depends_on`** (SKY-WF-042) and target a prompt/command node (SKY-WF-043).
- **Shell-quote every `$SKY_*` in bash:** `"$SKY_ISSUE_NUMBER"`, never bare.
- **Declare every `${env:NAME}`** (used in `mcp_servers`/`http`) in `secrets` (SKY-WF-055).

## MUST NOT

- Use `{{var}}` in `bash`, `script`, or `loop.until.bash` — use `$SKY_*` env vars.
- Use `{{item}}`/`{{item_index}}`/`{{item_total}}` in a `foreach` node's bash/script body — use `$SKY_ITEM`/`$SKY_ITEM_INDEX`/`$SKY_ITEM_TOTAL` instead; the two channels never cross.
- Put a non-scalar (object/array) entry in a `foreach.items` literal array — only string entries are supported; a resolved item is always a scalar (numbers/bools arrive as their JSON text).
- Use `${env:NAME}` in `prompt`/`bash`/`eval`/`script` — it resolves only for `mcp_servers`/`http` (SKY-WF-057). In bash, read `"$GITHUB_TOKEN"` directly.
- Put a schedule under `trigger.cron` — the key is `trigger.schedule.cron`; a bare `trigger.cron` is not a recognized trigger.
- Use `trigger.github_status`: that key does not exist. For CI check-run failures use `trigger.github.events = ["check_run.completed"]` paired with `trigger.github.check_run = { conclusion = "failure", name = "CI Name" }`.
- Write `output_format` as a TOML inline table (`output_format = { type = "object", ... }`): the value must be a compact JSON string: `output_format = {"type":"object","properties":{...}}`.
- Write multi-line bash inline: use `bash_file = "./scripts/<name>.sh"` instead; triple-quoted strings cause a parse error.
- Commit secrets/tokens/`.env`.
- Change an `output_format` schema without updating the `∆` prompt that produces it.
- Run a destructive bash command without `safety = "requires_permission"` (SKY-WF-063).
- Add an `emit` that re-triggers a workflow already in the ancestor chain — the chain depth cap is **5** and over-cap dispatch is silently suppressed.
- Put Claude Code magic keywords — `ultrathink`, `ultraplan`, `ultrareview`, `ultracode` — in a `∆` prompt body. They are meant for interactive Claude Code, not workflow authoring. `ultraplan`/`ultrareview` are flagged by SKY-WF-061; `ultrathink` is *not* linted but still fires under `skyway run` (sky drives Claude via `--input-format stream-json`, not `-p`) — it injects a "reason thoroughly" nudge you did not intend and cannot control per-node. Express intent explicitly instead: write what you want the node to do, and set reasoning via `effort = "..."` or `thinking = { ... }` on the node, never via a keyword in the prose.

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
| 096–098 | schedule: cron field required / cron expression invalid (5-field) / timezone not a valid IANA location |
| 099–101 | bash_file mutually exclusive with bash / file not found / shellcheck warning (non-blocking) |
| 102 | `※<id>※` doc block names a nonexistent node id (warning, non-blocking) |
| 103 | `ui` resolves to no markdown files (warning) — applies to both the workflow-level `ui` in `⊕meta⊕` and per-node `ui` keys |
| 104–107 | foreach: `items` missing/empty/wrong shape / body not exactly one of prompt·command·bash·bash_file·script (or combined with an incompatible modifier) / `max_concurrency` out of range (0–32) / `chain_from` targets or is set on a foreach node |

## Self-Check Before Finishing

1. Exactly one trigger (or none); `name` matches the filename.
2. Every `∆id∆` has a matching `§id§`; exactly one execution kind per node.
3. Every `chain_from` is in `depends_on` and targets a prompt/command node; every `when` RHS is quoted.
4. No `{{var}}` in bash/script/loop bodies; all `$SKY_*` shell-quoted; every `${env:NAME}` declared in `secrets`.
5. If `ui` is set in `⊕meta⊕` or on any node, the referenced markdown file(s) exist relative to the `.sky` file (SKY-WF-103 warns when they do not). Workflow-level `ui` in `⊕meta⊕` additionally supports a `changelog` list (`version`, `date`, `note`) in its frontmatter.
6. `skyway lint` passes clean.
