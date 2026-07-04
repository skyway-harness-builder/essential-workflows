---
name: sky-run-triage
description: Diagnosing a failed skyway run — how run state actually flows (env channel, {{var}} vs $SKY_ scope, when-condition quoting, chain_from semantics), the common failure classes, and the propose-don't-apply rule. Load on any node that reads run logs to name a failing node and root cause.
category: audit
tags: [audit, triage, debug, runs, logs]
---

# Triaging a failed skyway run

You are diagnosing, not repairing: read the run evidence, name the failing node by its §id§, state the root cause concretely (which line, config key, bash statement, or prompt clause failed and why), and state your confidence with the evidence it rests on. Never edit files, never re-run the workflow, never apply the fix — remediation is a unified diff plus a one-line `skyway run update-sky-workflow` command that a human reviews.

## How state actually flows between nodes

Most run failures trace to one of the data-flow rules being violated, so check them first. Bash nodes never template: `{{var}}` expands only in prompt bodies and node config values, while bash reads workflow vars from the env channel as `$SKY_<VAR>` and upstream node output as `$SKY_OUTPUT_<NODEID>` (node id uppercased, dashes to underscores). A `when` condition compares against node output with a quoted right-hand side (`$gate.output.approve == 'true'`); an unquoted bareword, a node that emitted extra prose around its JSON, or output that failed to parse all make the condition silently evaluate against a fallback value and route the run down the wrong branch — a skipped-node symptom with no error line. `chain_from` resumes a prior node's Claude session and requires that node to have actually completed; `depends_on` alone starts a fresh session with no memory. Loop bodies are restricted node kinds and each loop iteration is a fresh invocation with no session carry-over, so a loop that "forgets" its previous pass is behaving as designed, not failing.

## Failure classes, in the order to check them

Environmental first: daemon down, missing run id, expired credentials, absent CLI dependency (gh, jq, bun), network flake — the log line usually appears before any node output and the correct verdict is "environmental, no source defect, re-run" with no diff. Contract second: a bash node emitting non-JSON where a downstream `when` or jq expects JSON, a missing machine sentinel where a gate greps one, an output_format schema mismatch, an undeclared secret-shaped env ref. Source third: wrong node id in depends_on or chain_from, a `when` referencing a node that can be skipped, a template var never passed via `--var`, a bash_file path not resolving relative to the workflow directory. Budget and bounds last: max_budget_usd exhausted mid-run, loop.max reached without the until condition ever becoming true, max_turns truncating a node before it printed its final line — truncation commonly decapitates the sentinel, which then presents as a gate failure one node downstream of the real cause.

## Reading the logs

`skyway logs <run>` is best-effort and may be partial; when it does not name the failing node, infer from the last node that produced output plus the first error text, and say explicitly that the attribution is inferred. Distinguish the node that surfaced the error from the node that caused it: a gate reporting a missing sentinel means the upstream judge failed its output contract, and the fix belongs on the judge. Keep the whole diagnosis terse and machine-oriented, and when proposing the diff change only what the root cause requires.
