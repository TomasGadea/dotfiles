#!/bin/sh
# focus the previous tab, as tmux last-window
state="$HERDR_PLUGIN_STATE_DIR"

# start the watcher again if it stopped
pid=$(cat "$state/watch.pid" 2>/dev/null)
{ [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; } || sh ./start.sh

# the tab focused now is the truth; record it in case the watcher missed it
sh ./record.sh "$HERDR_TAB_ID"

previous=$(cat "$state/previous" 2>/dev/null)
current=$(cat "$state/current" 2>/dev/null)
[ -n "$previous" ] || exit 0

"${HERDR_BIN_PATH:-herdr}" tab focus "$previous" || exit 1
printf '%s\n' "$current" > "$state/previous"
printf '%s\n' "$previous" > "$state/current"
