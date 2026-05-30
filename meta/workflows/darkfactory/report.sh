#!/bin/bash
set -u
echo '=== Dark Factory board-prep (GitHub) — summary ==='
echo "${SKY_OUTPUT_LABELS:-}"
echo "${SKY_OUTPUT_LINK:-}"
echo "${SKY_OUTPUT_FIELDS:-}"
echo ''
echo '=== Manual steps the GitHub API cannot do (one-time, in the Projects UI) ==='
echo '1. Auto-add: Project -> ... -> Workflows -> Auto-add to project -> set the repository filter to this repo -> Save and turn on. (Never carried by a template; no public API.)'
echo '2. Label -> Status column automation (mirror factory state onto the board):'
echo '     ready-for-sky -> Ready | in-progress -> Agent Running | needs-review -> Awaiting Review | needs-fix -> Revisions Requested | approved -> Done'
echo '   Wire via Project Workflows (UI). Full mapping + rationale in the darkfactory-onboarding skill.'
echo '3. If a custom field is missing above: create the project from the Skylence project template (org project #1), which carries Status + Priority/Size/Idea Stage/Bug Stage.'