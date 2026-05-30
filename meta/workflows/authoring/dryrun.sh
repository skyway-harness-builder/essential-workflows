#!/bin/bash
cd "$SKY_DIR" || exit 0
sky run "$SKY_NAME" --dry-run 2>&1 || true
