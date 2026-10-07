#!/bin/sh
# nav.sh <direction> <key>: send the key to vim if vim runs in the focused pane,
# else focus the neighbor herdr pane. same test as is_vim in .config/tmux/tmux.conf
herdr="${HERDR_BIN_PATH:-herdr}"
direction="$1"
key="$2"
pane="$HERDR_PANE_ID"
[ -n "$pane" ] || pane=$("$herdr" pane current | grep -o '"pane_id":"[^"]*"' | head -n 1 | cut -d'"' -f4)
[ -n "$pane" ] || exit 1

if "$herdr" pane process-info --pane "$pane" \
    | grep -o '"argv0":"[^"]*"' | cut -d'"' -f4 \
    | grep -iqE '^(\S+/)?g?(view|l?n?vim?x?|fzf)(diff)?$'; then
    "$herdr" pane send-keys "$pane" "$key"
else
    # at the edge there is no neighbor, so ignore the error
    "$herdr" pane focus --pane "$pane" --direction "$direction" >/dev/null 2>&1 || true
fi
