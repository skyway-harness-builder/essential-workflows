#!/bin/bash
set -u
F="$SKY_DIR/$SKY_NAME.sky"
if [ ! -f "$F" ]; then echo "[upgrade] not found: $F" >&2; exit 1; fi
skyway lint "$F"
RC=$?
if [ "$RC" -eq 0 ]; then echo "[upgrade] $SKY_NAME.sky already clean — nothing to upgrade"; else echo "[upgrade] $SKY_NAME.sky has lint issues — fixing"; fi
exit "$RC"
