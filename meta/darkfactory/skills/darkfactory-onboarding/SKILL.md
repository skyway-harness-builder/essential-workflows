---
name: darkfactory-onboarding
description: Onboard a repo + its GitHub Project into the Dark Factory — the rung-0 board convention. The 9-label lifecycle (data/labels.yaml), the GitHub Project field schema from the Skylence project template (Status Icebox→Done + Priority/Size/Idea Stage/Bug Stage), the label→Status mapping, and exactly what a project template carries vs what you must wire by hand. Pairs with the board-prep workflow.
category: darkfactory
tags: [darkfactory, onboarding, github, projects, board, labels, lifecycle]
---

# Dark Factory onboarding (rung 0) — the board convention

"Rung 0" is the one-time setup that prepares a repo for the factory loop, before triage /
build / verify run. This skill is the **GitHub** board convention; Jira and GitLab differ (see
the bottom). It pairs with the `board-prep` workflow, which automates the parts that have an API.

The factory state lives in **two places** that must agree:

| Layer | Scope | Who reads it | Source of truth |
|---|---|---|---|
| **Labels** | repository | the ladder rungs (triage/build/verify key off them programmatically) | `data/labels.yaml` |
| **Status column** | the GitHub Project | humans (the Kanban) | the Skylence project template |

## 1. The 9-label lifecycle (repo-scoped)

An issue carries **exactly one** lifecycle label at a time; the factory advances it, a human can
override at any gate. From `data/labels.yaml`:

```
triaging ──► accepted ──► ready-for-sky ──► in-progress ──► needs-review
                │                                                 │
                └──► rejected                          ┌──────────┴──────────┐
                                                       ▼                     ▼
                                                   approved              needs-fix ──► ready-for-sky (re-queue)

escalated  — orthogonal: any state can route to a human (low confidence / high stakes).
```

| Label | color | meaning |
|---|---|---|
| `triaging` | fbca04 | being classified; not yet a work item |
| `accepted` | 0e8a16 | cleared triage; the factory will attempt it |
| `rejected` | ffffff | terminal — out of scope / dupe / wontfix |
| `ready-for-sky` | 1d76db | queued for an implementation run |
| `in-progress` | 0052cc | sky is implementing right now |
| `needs-review` | e4882a | PR open, awaiting human spot-check / validator |
| `approved` | 2ea44f | validator + human passed; ready to merge |
| `needs-fix` | d93f0b | bounced back; re-queues to `ready-for-sky` |
| `escalated` | b60205 | routed to a human |

`board-prep` creates all nine on the repo (`gh label create --force`, idempotent). **No project
template can ever create these** — labels are repo-scoped, not project-scoped.

## 2. The GitHub Project field schema (project-scoped)

From the **Skylence project template** (org project #1). A project template **does** carry this
structure, so create your board *from that template* rather than hand-building it:

- **Status** (single-select, the human columns): `Icebox · Backlog · Ready · Agent Running · Awaiting Review · Revisions Requested · Done`
- **Priority**: Urgent · High · Medium · Low
- **Size**: Small · Medium · Large
- **Idea Stage**: Captured · Exploring · Scoped · Promotable · Parked
- **Bug Stage**: Reported · Confirmed · Prioritized · Resolved

`board-prep`'s `fields` node **verifies** these exist on the linked project (read-only); it never
edits the schema — that is the template's job.

## 3. The label → Status mapping

The board column mirrors the factory label so the human Kanban reflects machine state:

| Label | Status column |
|---|---|
| `triaging` / `accepted` | Backlog |
| `ready-for-sky` | Ready |
| `in-progress` | Agent Running |
| `needs-review` | Awaiting Review |
| `needs-fix` | Revisions Requested |
| `approved` (merged) / `rejected` | Done |
| `escalated` | (stays where it is; the `escalated` label is the human signal) |

`Icebox` is for parked/not-yet-triaged ideas (pairs with `Idea Stage`); it has no label-machine
equivalent.

## 4. What the template carries vs what you wire (researched, docs-verified)

A Projects v2 **template / project-copy DOES carry**: views, custom fields **including** the
Status single-select and its options, configured workflows (except auto-add), insights.

It does **NOT** carry — and there is no API for these, so they are the per-repo wiring job:

1. **Repo labels** → `board-prep` creates them.
2. **Linking the project to the repo** → `board-prep` runs `gh project link`.
3. **Auto-add workflow** (feed the repo's items onto the board) — *explicitly excluded* from
   copy/template, **no public API**. Wire it once in the UI: Project → ⋯ → Workflows →
   *Auto-add to project* → set the repository filter → **Save and turn on**.
4. **Label → Status automation** (section 3) — wire via the Project's built-in Workflows (UI).

## 5. Onboarding sequence

```
1. Create the board from the Skylence project template (org project #1):
   gh project copy 1 --source-owner skylence-be --target-owner <owner> --title "<repo> — Dark Factory"
2. Run board-prep (creates labels, links the project, verifies fields):
   skyway run board-prep --var project=<new-project-number> --var repo=<owner/name>
3. Do the two manual UI steps board-prep prints: enable Auto-add (filtered to the repo) and
   wire the label→Status automation.
```

After this, the ladder rungs (triage → build → verify) have the labels they key off and the
human board reflects every move.

## Jira / GitLab (not this skill)

- **Jira** — no cross-site "public project to template from" (shared-config / custom templates are
  same-site only); board column→status mapping has **no public write API** (UI-only). Onboarding is
  programmatic config-as-code, not template-clone.
- **GitLab** — unlike GitHub, an export/import or custom group/instance template **does** carry
  labels + boards + lists (boards are label-driven, so the automation is implicit); but not via a
  fork, and webhooks don't export. Onboarding = template seeds + adapter recreates webhooks /
  reconciles labels.
