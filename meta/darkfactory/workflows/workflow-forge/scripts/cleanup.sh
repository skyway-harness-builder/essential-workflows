#!/bin/bash
set -u
F=".sky/workflows/forge-candidate.sky"
if [ -f "$F" ]; then rm "$F" && echo "cleaned $F"; else echo "no scratch candidate to clean"; fi
