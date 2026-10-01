#!/bin/sh
# start the watcher in the background, so that the startup hook can exit
nohup sh ./watch.sh >/dev/null 2>&1 &
