#!/bin/sh
# record.sh <tab_id>: keep the current and the previous focused tab ids
state="$HERDR_PLUGIN_STATE_DIR"
tab="$1"
[ -n "$tab" ] || exit 0

current=$(cat "$state/current" 2>/dev/null)
[ "$tab" = "$current" ] && exit 0

[ -n "$current" ] && printf '%s\n' "$current" > "$state/previous"
printf '%s\n' "$tab" > "$state/current"
