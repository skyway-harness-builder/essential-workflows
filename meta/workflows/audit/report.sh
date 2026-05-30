#!/bin/bash
set -u
DEAD_LISTENERS="$(cat /tmp/sky-orphan-dead-listeners.path)"
DEAD_SIGNALS="$(cat /tmp/sky-orphan-dead-signals.path)"
LISTENS="$(cat /tmp/sky-orphan-listens.path)"
EMITS="$(cat /tmp/sky-orphan-emits.path)"
rc=0
printf '=== orphan sky_event report ===\n'
printf '\n-- DEAD LISTENERS (trigger.sky_event with no emitter) --\n'
if [ -s "$DEAD_LISTENERS" ]; then
  while IFS="$(printf '\t')" read -r ev file; do printf '  %s  <-  %s (listens, never emitted)\n' "$ev" "$file"; done < "$DEAD_LISTENERS"
  rc=1
else
  printf '  none\n'
fi
printf '\n-- DEAD SIGNALS (emit with no listener) --\n'
if [ -s "$DEAD_SIGNALS" ]; then
  while IFS="$(printf '\t')" read -r ev file; do printf '  %s  ->  %s (emitted, never listened)\n' "$ev" "$file"; done < "$DEAD_SIGNALS"
  rc=1
else
  printf '  none\n'
fi
rm "$DEAD_LISTENERS"
rm "$DEAD_SIGNALS"
rm "$LISTENS"
rm "$EMITS"
rm /tmp/sky-orphan-listens.path
rm /tmp/sky-orphan-emits.path
rm /tmp/sky-orphan-dead-listeners.path
rm /tmp/sky-orphan-dead-signals.path
if [ "$rc" -ne 0 ]; then printf '\nFAIL: orphan event edges found.\n' >&2; else printf '\nOK: no orphan event edges.\n'; fi
exit "$rc"
