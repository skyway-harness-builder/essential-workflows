#!/usr/bin/env bash
set -euo pipefail

if [ -z "${SKY_OUTPUT_SCAN:-}" ]; then
  echo "all workflows already annotated; nothing to do"
  exit 0
fi

while IFS= read -r wf_dir; do
  [ -z "$wf_dir" ] && continue
  echo "annotating: $wf_dir"
  sky run annotate-sky-workflow --vars "dir=$wf_dir,name=workflow"
done <<< "$SKY_OUTPUT_SCAN"
