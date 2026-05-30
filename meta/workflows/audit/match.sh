#!/bin/bash
set -u
LISTENS="$(cat /tmp/sky-orphan-listens.path)"
EMITS="$(cat /tmp/sky-orphan-emits.path)"
DEAD_LISTENERS="$(mktemp /tmp/sky-orphan-dead-listeners.XXXXXX)"
DEAD_SIGNALS="$(mktemp /tmp/sky-orphan-dead-signals.XXXXXX)"
printf '%s\n' "$DEAD_LISTENERS" > /tmp/sky-orphan-dead-listeners.path
printf '%s\n' "$DEAD_SIGNALS" > /tmp/sky-orphan-dead-signals.path
L_NAMES="$(mktemp /tmp/sky-orphan-lnames.XXXXXX)"
E_NAMES="$(mktemp /tmp/sky-orphan-enames.XXXXXX)"
cut -f1 "$LISTENS" | sort -u > "$L_NAMES"
cut -f1 "$EMITS" | sort -u > "$E_NAMES"
comm -23 "$L_NAMES" "$E_NAMES" | while IFS= read -r ev; do [ -n "$ev" ] && grep -F "$(printf '%s\t' "$ev")" "$LISTENS"; done > "$DEAD_LISTENERS"
comm -23 "$E_NAMES" "$L_NAMES" | while IFS= read -r ev; do [ -n "$ev" ] && grep -F "$(printf '%s\t' "$ev")" "$EMITS"; done > "$DEAD_SIGNALS"
rm "$L_NAMES"
rm "$E_NAMES"
printf 'matched: %s dead listener(s), %s dead signal(s)\n' "$(wc -l < "$DEAD_LISTENERS" | tr -d ' ')" "$(wc -l < "$DEAD_SIGNALS" | tr -d ' ')"
