#!/bin/bash
set -e
if [ -z "$SKY_SOURCE" ]; then echo 'source var is empty' >&2; exit 1; fi
if [ ! -f "$SKY_SOURCE" ]; then echo "source not found: $SKY_SOURCE" >&2; exit 1; fi
echo "=== source: $SKY_SOURCE ==="
cat "$SKY_SOURCE"
