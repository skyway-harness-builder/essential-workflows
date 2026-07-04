---
name: sky-workflow-lint
description: Lint code table and self-check for fixing SKY-WF-* errors in .sky workflows. Use when reading skyway lint output and applying fixes.
category: skylence
tags: [skylence, sky, workflow, lint, errors]
---

# SKY-WF-* Lint Codes

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
| 103 | `ui` resolves to no markdown files (warning): create the missing file(s) or remove the key |
| 104–107 | foreach: items missing/empty/not strings (or literal array over 100) / body not prompt·command·bash·script (or combined with loop) / max_concurrency out of 0–32 / chain_from on or targeting a foreach node |

## Common Fixes

| Symptom | Fix |
|---------|-----|
| SKY-WF-030/031 | Quote the RHS of `when`: `when = "$x.output == 'value'"` |
| SKY-WF-042 | Add `chain_from` target to `depends_on` |
| SKY-WF-055 | Add every `${env:NAME}` reference to the `secrets` array |
| SKY-WF-063 | Add `safety = "requires_permission"` to destructive bash nodes |
| SKY-WF-103 | Create the missing markdown file at the declared path, or remove the `ui` key |
| SKY-WF-104 | Set `foreach.items` to a non-empty string array or a `$node.output`/`{{var}}` string reference |
| SKY-WF-105 | Give the foreach node exactly one prompt/command/bash/script body; drop any `loop` block |
| SKY-WF-107 | Remove `chain_from` — foreach items run in separate sessions; aggregate via `$SKY_OUTPUT_<ID>` instead |

## Self-Check Before Done

1. `name` matches the filename; exactly one trigger (or none = manual).
2. Every `∆id∆` has a matching `§id§`; exactly one execution kind per node.
3. Every `chain_from` is in `depends_on` and targets a prompt/command node; every `when` RHS is quoted.
4. No `{{var}}` in bash/script/loop bodies; all `$SKY_*` shell-quoted; every `${env:NAME}` declared in `secrets`.
5. If `ui` is set in `⊕meta⊕` or on any node, the referenced markdown file(s) exist relative to the `.sky` file.
6. `skyway lint` passes clean.
