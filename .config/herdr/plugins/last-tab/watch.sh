#!/bin/sh
# poll the focused tab and record every change. herdr 0.9 emits tab.focused
# only for API focus changes, not for keyboard or mouse tab switches.
# only one watcher runs: a new watcher replaces the pid file and the old one exits.
state="$HERDR_PLUGIN_STATE_DIR"
herdr="${HERDR_BIN_PATH:-herdr}"
echo $$ > "$state/watch.pid"

fails=0
while [ "$(cat "$state/watch.pid" 2>/dev/null)" = "$$" ]; do
    tab=$("$herdr" api snapshot 2>/dev/null | grep -o '"focused_tab_id":"[^"]*"' | head -n 1 | cut -d'"' -f4)
    if [ -n "$tab" ]; then
        fails=0
        sh ./record.sh "$tab"
    else
        # the server is gone: stop after about 30 seconds
        fails=$((fails + 1))
        [ "$fails" -ge 100 ] && break
    fi
    sleep 0.3
done
