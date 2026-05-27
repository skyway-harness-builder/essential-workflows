---
name: sky-workflow-authoring
description: Author a valid Skylence .sky workflow — four-delimiter format, trigger routing, node types (claude/bash/script/http/loop/emit), variable references, and the lint error-code fixes. Use when writing or fixing a .sky file.
category: skylence
tags: [skylence, sky, workflow, authoring, lint, dag]
---

# Authoring a .sky Workflow

A `.sky` file defines a DAG of execution nodes plus trigger metadata. The parser uses four Unicode delimiter blocks; every opener and closer must be alone on its line. This skill is self-contained — you do not need any marketplace plugin to author or lint a workflow.

## Delimiter Blocks

```
⊕meta⊕   ⊕⊕     workflow identity + trigger routing
§<id>§   §§     DAG node config (model, depends_on, when, …)
∆<id>∆   ∆∆     Claude prompt body for node <id>
※※       ※※     doc / comment block (parser discards)
```

## Minimal Example

```
⊕meta⊕
name = "smoke-test"
description = "Manual smoke test"
trigger.manual = true
output_style = "terse"
⊕⊕

§work§
bash = "echo 'hello'"
§§
```

## `⊕meta⊕` Block

Required: `name` (kebab-case, **must match the filename**) and `description`.

Exactly one trigger:
- `trigger.manual = true` — CLI only, via `sky run <name>` (pass inputs with `--var key=value`)
- `trigger.github.events = ["issues.labeled"]` (+ optional `trigger.github.label = "..."`); other events: `pull_request`, `push`, `issue_comment`, `check_run.completed` (+ `trigger.github.check_run.conclusion`)
- `trigger.sky_event.event = "deploy.completed"` — subscribe to another workflow's `emit`
- `trigger.cron = "0 */6 * * *"`

Optional meta: `output_style = "terse"`, `max_budget_usd = 2.00`, `secrets = ["GITHUB_TOKEN"]`, `permissions = "interactive"`, `mcp_servers = { … }`.

## `§<id>§` Node Config

| Key | Values | Notes |
|-----|--------|-------|
| `model` | `sonnet`, `opus`, `haiku` | Required for a Claude prompt node (needs a `∆` block) |
| `effort` | `max` | Extended thinking |
| `depends_on` | `["a","b"]` | Upstream nodes; output as `$SKY_OUTPUT_<ID>` |
| `when` | `"$classify.output.type == 'bug'"` | RHS **must be quoted** |
| `trigger_rule` | `all_done`(default) / `all_success` / `one_success` / `one_failure` | |
| `isolation` | `worktree` | Run in a dedicated git worktree (torn down after the node) |
| `chain_from` | `"author"` | Resume that dep's Claude session; **must also be in `depends_on`** |
| `skills` | `["sky-workflow-authoring"]` | Inject `.claude/skills/<name>/SKILL.md` into the system prompt |
| `output_format` | JSON Schema object | Passed as `--json-schema` |
| `max_turns` | integer ≥ 1 | |
| `bash` | shell string | Replaces the Claude prompt; no `∆` block |
| `script` | `{"runtime":"bun"\|"uv","deps":[…]}` | Deterministic transform; no Claude |
| `http` | `{"url":"…","method":"POST","body":"…"}` | HTTP call |
| `loop.until.bash` | shell command | Re-run this node until the command exits 0 (`loop.max`, default 10) |
| `wait.channel` | `manual` / `webhook` | Pause for approval (`wait.prompt`, `wait.timeout`) |
| `cancel` | `{"reason":"…"}` | Abort the run; pair with `when` |
| `emit` | `{"name":"evt","payload":{…}}` | Trigger a workflow with matching `trigger.sky_event` |

## `∆<id>∆` Prompt Body

Plain markdown sent to the Claude CLI for the node. `{{var}}` template expansion works **only here** (and in HTTP bodies), not in `bash`/`script`/`loop.until.bash`.

## Variable Reference

| In | Use |
|----|-----|
| `∆` prompt | `{{issue.title}}`, `{{repo.full_name}}`, `{{name}}` (and `--var` keys), `$SKY_OUTPUT_<ID>` |
| `bash` / `loop.until.bash` | `"$SKY_ISSUE_NUMBER"`, `"$SKY_REPO_FULL_NAME"`, `"$SKY_OUTPUT_<ID>"`, `"$SKY_<UPPER_KEY>"` |
| `script` | `process.env.SKY_OUTPUT_<ID>` |
| `mcp_servers` / `http` | `${env:GITHUB_TOKEN}` (must be declared in `secrets`) |
| `when` | `$classify.output.field` (single-quote the RHS) |

`$SKY_OUTPUT_<ID>` uppercases the node id and replaces `-` with `_` (node `code-review` → `$SKY_OUTPUT_CODE_REVIEW`). Webhook keys flatten: `issue.number` → `$SKY_ISSUE_NUMBER`. `--var foo=bar` → `{{foo}}` in prompts, `$SKY_FOO` in bash.

## Node Type Quick Pick

| Want to | Use |
|---------|-----|
| Ask Claude to reason | `model = "sonnet"` + `∆` block |
| Run a shell command | `bash = "…"` |
| Transform JSON deterministically | `script = {"runtime":"bun"}` |
| Call an HTTP API | `http = {…}` |
| Repeat until a check passes | `loop.until.bash = "…"` |
| Gate on a human | `wait.channel = "manual"` |
| Abort conditionally | `cancel` + `when` |
| Trigger another workflow | `emit` |

## MUST

- **Lint before done:** `sky lint .sky/workflows/<file>.sky` must pass. Errors are blocking.
- **Quote the RHS of every `when`:** `when = "$x.output == 'value'"` — a bareword silently never fires.
- **`chain_from` must appear in `depends_on`** or the validator rejects the workflow (SKY-WF-040).
- **Shell-quote every `$SKY_*` in bash:** `"$SKY_ISSUE_NUMBER"`, never bare — values may contain spaces/metacharacters.
- **Declare every `${env:NAME}`** used in `mcp_servers`/`http` in the `secrets` array (SKY-WF-055).
- **`name` must match the filename** (kebab-case).

## MUST NOT

- Use `{{var}}` in `bash`, `script`, or `loop.until.bash` — template expansion is prompt-only. Use `$SKY_*` env vars.
- Use `${env:NAME}` in `prompt`/`bash`/`eval` — it resolves only for `mcp_servers`/HTTP. In bash read `"$GITHUB_TOKEN"` directly.
- Commit secrets/tokens/`.env` — `secrets` names the vars; values stay gitignored.
- Change an `output_format` schema without updating the `∆` prompt that produces it (SKY-WF-060 / shape drift).
- Add an `emit` that re-triggers a workflow already in the ancestor chain — the chain cap is 5 and the emit is silently skipped.

## Lint Error Codes → Fix

| Code | Symptom | Fix |
|------|---------|-----|
| SKY-WF-040 | `chain_from` not in `depends_on` | Add the chain target to `depends_on` |
| SKY-WF-047 | Bare `{{var}}` in `http.body` JSON | Use `{{var\|json}}` |
| SKY-WF-048 | Bash sink receives `$SKY_OUTPUT_<prompt-node>` | Treat prompt output as untrusted; don't `eval`/`source` it |
| SKY-WF-055 | Undeclared `${env:NAME}` | Add `NAME` to `secrets` |
| SKY-WF-060 | `output_format` schema mismatch | Align the schema and the prompt |

## Self-Check Before Finishing

1. Exactly one trigger in `⊕meta⊕`; `name` matches the filename.
2. Every `∆id∆` has a matching `§id§`; every Claude node has a `model`.
3. Every `chain_from` is also in `depends_on`; every `when` RHS is quoted.
4. No `{{var}}` in bash/script/loop bodies; all `$SKY_*` shell-quoted.
5. `sky lint` passes clean.
