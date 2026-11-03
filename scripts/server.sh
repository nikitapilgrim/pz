#!/usr/bin/env bash
# pz-server start (runs as the server user 10000): passwords from the data volume unless set in .env,
# the ZombieBuddy Java agent, then the image's own entrypoint (SteamCMD update, configs, server).
set -u

SECRETS=/home/steam/zomboid_data/.pz-secrets.env
for key in SERVER_PASSWORD ADMIN_PASSWORD RCON_PASSWORD; do
  if [ -z "${!key:-}" ] && [ -f "$SECRETS" ]; then
    export "$key=$(grep -E "^${key}=" "$SECRETS" | tail -n 1 | cut -d= -f2-)"
  fi
done

# Viewpoint version switch. mods.env is written for Viewpoint 0.1.6.1: QOL's legacy sub-mod (the main ProjectViewpointQOL
# switches itself off on anything but 0.1.7) and Isometric No More (merged into Viewpoint 0.1.7, its author asks to drop
# it there). Once the downloaded Viewpoint reports another version, load the main QOL and drop Isometric No More.
# The game updates Workshop items while it starts, so this takes effect from the restart after Viewpoint updates.
# VIEWPOINT_COMPAT (in .env): auto (default), legacy (keep mods.env as is) or current (switch now).
vp_info="$(find "${ZOMBOID_PATH:-/home/steam/zomboid}" -type f -name mod.info -path '*108600/3809306528/mods/Viewpoint/*' 2>/dev/null | sort | tail -n 1)"
vp_version="$( [ -n "$vp_info" ] && grep -E '^modversion=' "$vp_info" | head -n 1 | cut -d= -f2 | tr -d '\r ')"
vp_compat="${VIEWPOINT_COMPAT:-auto}"
if [ "$vp_compat" = "auto" ]; then
  case "$vp_version" in ""|0.1.6|0.1.6.*) vp_compat=legacy ;; *) vp_compat=current ;; esac
fi
if [ "$vp_compat" = "current" ]; then
  MOD_NAMES="$(printf '%s' "${MOD_NAMES:-}" | tr ';' '\n' | sed 's/^ProjectViewpointQOLLegacy0\.1\.6$/ProjectViewpointQOL/' | grep -vx 'isometricnomore' | paste -sd ';' -)"
  export MOD_NAMES
fi
echo "[pz-server] Viewpoint ${vp_version:-not downloaded yet}: ${vp_compat} add-on set"

# MODS_DISABLED (in .env, e.g. "DynamicTraits;MoodleFramework"): take mods out of the load list for a test without
# editing mods.env. The Workshop items stay downloaded.
if [ -n "${MODS_DISABLED:-}" ]; then
  MOD_NAMES="$(printf '%s' "${MOD_NAMES:-}" | tr ';' '\n' | grep -vxF -f <(printf '%s' "$MODS_DISABLED" | tr ';' '\n') | paste -sd ';' -)"
  export MOD_NAMES
  echo "[pz-server] disabled for this run: ${MODS_DISABLED}"
fi

# ZombieBuddy agent for server-side Java mods (Viewpoint 3D RVs require it on dedicated servers; True Ballistics uses
# it for its server part). Passed to config_editor.py, which adds it to the vmArgs of
# ProjectZomboid64.json after SteamCMD's validate restored the stock file. Not via JAVA_TOOL_OPTIONS: the PZ launcher
# starts a helper JVM without the game classes and the agent would crash it.
# policy=allow-all: a server cannot show the approval dialog, so every Java mod in the list is loaded.
if [ "${ZOMBIEBUDDY_SERVER:-false}" = "true" ]; then
  zb_jar="$(find "${ZOMBOID_PATH}" -type f -name ZombieBuddy.jar -path '*3619862853*/libs/*' 2>/dev/null | sort | tail -n 1)"
  if [ -n "${zb_jar}" ]; then
    cp -f "${zb_jar}" "${ZOMBOID_PATH}/ZombieBuddy.jar"
    export ZB_JAVAAGENT="-javaagent:${ZOMBOID_PATH}/ZombieBuddy.jar=policy=allow-all"
    echo "[pz-server] ZombieBuddy agent enabled"
  else
    echo "[pz-server] ZombieBuddy.jar not downloaded yet: starting without the agent (restart once mods are in)"
  fi
fi

# Chat reminder of the one-time client setup (body and animal mods only load when the game starts). A background loop
# that sends the admin command servermsg over RCON; it outlives the exec below and dies with the container.
reminder_min="${SETUP_REMINDER_MINUTES:-60}"
case "$reminder_min" in ''|*[!0-9]*) reminder_min=0 ;; esac
if [ "$reminder_min" -gt 0 ] && [ "${PZ_DRY_RUN:-false}" != "true" ] && command -v rcon > /dev/null; then
  reminder_text="Напоминание: если одежда просвечивает телом или животные смятые, выйдите в главное меню -> Моды, включите Spongie's Character Customisation, Tomb's Player Body, Textures [NUDE], Customisation, Compatability, Goth Textures [NUDE], The Only Cure+ - TombBody fit и Knox Wildlife и перезапустите игру."
  (
    sleep 600
    while true; do
      timeout 20 rcon -a "$(hostname -i | cut -d' ' -f1):${RCON_PORT:-27015}" -p "${RCON_PASSWORD:-}" "servermsg \"${reminder_text}\"" > /dev/null 2>&1 \
        || echo "[pz-server] setup reminder: RCON not reachable"
      sleep $((reminder_min * 60))
    done
  ) &
  echo "[pz-server] setup reminder in the chat every ${reminder_min} min"
fi

if [ "${PZ_DRY_RUN:-false}" = "true" ]; then
  for key in SERVER_PASSWORD ADMIN_PASSWORD RCON_PASSWORD; do
    printf '[pz-server] %s is %s\n' "$key" "$([ -n "${!key:-}" ] && echo set || echo EMPTY)"
  done
  echo "[pz-server] mods to load: ${MOD_NAMES:-}"
  echo "[pz-server] dry run: not starting the server"
  exit 0
fi

exec /home/steam/entrypoint.sh "$@"
