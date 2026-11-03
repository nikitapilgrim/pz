#!/usr/bin/env bash
# docker compose run --rm pz-backup
# Saves the world over RCON (if the server is running) and writes backups/pz_YYYYmmdd_HHMMSS.tar.gz with the
# whole pz-data volume: configs, world, player accounts, generated passwords. Keeps the newest KEEP (default 7).
set -euo pipefail

DATA=/home/steam/zomboid_data
OUT=/backups
KEEP="${KEEP:-7}"
SECRETS="$DATA/.pz-secrets.env"

rcon_pw="${RCON_PASSWORD:-}"
if [ -z "$rcon_pw" ] && [ -f "$SECRETS" ]; then
  rcon_pw="$(grep -E '^RCON_PASSWORD=' "$SECRETS" | cut -d= -f2-)"
fi
if getent hosts pz-server > /dev/null && timeout 20 rcon -a "pz-server:${RCON_PORT:-27015}" -p "$rcon_pw" save > /dev/null 2>&1; then
  echo "[pz-backup] world saved over RCON"
  sleep 15
else
  echo "[pz-backup] server not running or not reachable over RCON: archiving the last save"
fi

mkdir -p "$OUT"
archive="$OUT/pz_$(date +%Y%m%d_%H%M%S).tar.gz"
tar -czf "$archive" -C "$DATA" --exclude=./backups --exclude=./Logs .
echo "[pz-backup] created backups/$(basename "$archive") ($(du -h "$archive" | cut -f1))"

ls -1t "$OUT"/pz_*.tar.gz 2> /dev/null | tail -n +"$((KEEP + 1))" | while read -r old; do
  rm -f -- "$old"
  echo "[pz-backup] removed old backups/$(basename "$old")"
done
