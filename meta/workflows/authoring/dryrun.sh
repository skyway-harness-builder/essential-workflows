#!/bin/bash
cd "$SKY_DIR" && sky run "$SKY_NAME" --dry-run 2>&1 || true
