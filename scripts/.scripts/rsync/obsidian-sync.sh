#!/usr/bin/env bash
set -euo pipefail

LOCK="${HOME:-}/.cache/obsidian-sync.lock"
LOG="${HOME:-}/.cache/obsidian-sync.log"

echo "$(date --iso-8601=seconds) START" >> "$LOG"

# open lock descriptor
exec 9>"$LOCK"

# try to acquire lock non-blocking
if ! flock -n 9 ; then
    echo "$(date --iso-8601=seconds) SKIP: Another sync is running." >> "$LOG"
    exit 0
fi

/usr/bin/rclone bisync \
  "$HOME/Documents/ObsidianVault" \
  "gdrive:ObsidianVault" \
  --resilient \
  --recover \
  --conflict-resolve newer \
  --log-file "$LOG" \
  --log-level INFO \
  --create-empty-src-dirs \
  --exclude-from "$HOME/Documents/ObsidianVault/.rclone-ignore"

echo "$(date --iso-8601=seconds) END (exit $?)" >> "$LOG"

# release lock and close descriptor
flock -u 9
exec 9>&-
