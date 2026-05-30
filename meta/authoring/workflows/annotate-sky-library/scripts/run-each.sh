#!/usr/bin/env bash
set -euo pipefail

INPUT="$SKY_OUTPUT_SCAN"

if [ "$INPUT" = "NONE" ]; then
  echo "all workflow.sky files already annotated — nothing to do"
  exit 0
fi

count=0
while IFS= read -r wf_dir; do
  [ -z "$wf_dir" ] && continue
  echo "annotating: $wf_dir/workflow.sky"
  sky run annotate-sky-workflow --var dir="$wf_dir" --var name=workflow
  count=$((count + 1))
done <<< "$INPUT"

echo "annotated $count workflow(s)"
