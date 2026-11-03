#!/usr/bin/env bash
# docker compose stop pz-server
# docker compose run --rm pz-restore pz_YYYYmmdd_HHMMSS.tar.gz     (a file from the backups/ folder)
# docker compose up -d
# Replaces the pz-data volume (configs, world, accounts, passwords) with the archive. The current data is
# archived first as backups/pre-restore_*.tar.gz.
set -euo pipefail

DATA=/home/steam/zomboid_data
OUT=/backups

name="${1:-}"
if [ -z "$name" ]; then
  echo "usage: docker compose run --rm pz-restore <archive from backups/>"
  ls -1t "$OUT"/*.tar.gz 2> /dev/null | head -n 10 | sed 's#^/backups/#  #'
  exit 2
fi
archive="$OUT/$(basename "$name")"
[ -f "$archive" ] || { echo "[pz-restore] not found: backups/$(basename "$name")"; exit 1; }

if getent hosts pz-server > /dev/null; then
  echo "[pz-restore] the server is running - stop it first: docker compose stop pz-server"
  exit 1
fi

safety="$OUT/pre-restore_$(date +%Y%m%d_%H%M%S).tar.gz"
tar -czf "$safety" -C "$DATA" --exclude=./backups --exclude=./Logs .
echo "[pz-restore] current data archived to backups/$(basename "$safety")"

find "$DATA" -mindepth 1 -maxdepth 1 ! -name backups -exec rm -rf {} +
tar -xzf "$archive" -C "$DATA"
chown -R 10000:10000 "$DATA"
echo "[pz-restore] restored backups/$(basename "$archive") - start the server: docker compose up -d"
