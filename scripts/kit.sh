#!/usr/bin/env bash
# docker compose run --rm pz-kit <username> [kit]
# Gives a starting kit to a connected player with admin commands sent over RCON (server-side only; players need
# nothing extra). Kits are plain text files in config/kits/<kit>.txt (format: scripts/kits.py); "pick" groups get
# one random option each.
# Default kit: insurgent. The username is the player's login name (shown by: ... pz-kit --players).
# New characters get their profession's kit automatically (scripts/pz_kits.lua); this is the manual fallback.
set -euo pipefail

SECRETS=/home/steam/zomboid_data/.pz-secrets.env
KITS=/pz/kits

pw="${RCON_PASSWORD:-}"
if [ -z "$pw" ] && [ -f "$SECRETS" ]; then
  pw="$(grep -E '^RCON_PASSWORD=' "$SECRETS" | cut -d= -f2-)"
fi
rc() { timeout 15 rcon -a "pz-server:${RCON_PORT:-27015}" -p "$pw" "$1"; }

if ! getent hosts pz-server > /dev/null; then
  echo "[pz-kit] the server is not running"
  exit 1
fi

if [ "${1:-}" = "--players" ] || [ -z "${1:-}" ]; then
  echo "[pz-kit] usage: docker compose run --rm pz-kit <username> [kit]    kits: $(cd "$KITS" && ls -1 *.txt 2> /dev/null | sed 's/\.txt$//' | tr '\n' ' ')"
  rc players || true
  exit 0
fi

user="$1"
kit="${2:-insurgent}"
file="$KITS/$kit.txt"
[ -f "$file" ] || { echo "[pz-kit] no kit '$kit' (config/kits/$kit.txt)"; exit 1; }

echo "[pz-kit] giving kit '$kit' to $user"
failed=0
while read -r item count _; do
  reply="$(rc "additem \"$user\" \"$item\" ${count:-1}" 2>&1 || true)"
  echo "  ${item} x${count:-1}: ${reply}"
  case "$reply" in *"doesn't exist"*|*"does not exist"*|*"not found"*|*rror*) failed=$((failed + 1)) ;; esac
done < <(python3 /pz/scripts/kits.py resolve "$file")

if [ "$failed" -gt 0 ]; then
  echo "[pz-kit] $failed item(s) failed: fix their IDs in config/kits/$kit.txt"
fi
