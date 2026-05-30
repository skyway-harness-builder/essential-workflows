#!/bin/bash
set -u
git -C "$SKY_DIR" diff -- "$SKY_NAME.sky" 2>/dev/null || true
