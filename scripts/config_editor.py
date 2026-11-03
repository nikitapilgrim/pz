#!/usr/bin/env python3
"""Drop-in replacement for /home/steam/config_editor.py of sknnr/zomboid-dedicated-server.

Bind-mounted read-only by docker-compose.yml. Same CLI as the image's script, with fixes for B42:
  * the JVM gets -Xms from MIN_MEMORY (default: MAX_MEMORY, the image's behaviour). With ZGC an
    -Xms equal to -Xmx commits the whole heap up front as shared memory; a smaller -Xms lets the heap
    grow on demand and be returned to the OS when the server is idle.
  * extra JVM options from JVM_EXTRA_ARGS (space separated), e.g. -XX:SoftMaxHeapSize=1600m.
  * appending a key no longer glues it to a last line without a trailing newline (B42 writes the ini
    without one, which produced `ChatMessageSlowModeTime=3AntiCheatProtectionType21=false`).
  * keys listed in CONFIG_EDITOR_SKIP_KEYS (comma separated) are not written. Default skips
    AntiCheatProtectionType21, which B42 no longer has (it uses AntiCheatSafety, AntiCheatSpeed, ...).
"""

import argparse
import json
import os

DEFAULT_SKIP_KEYS = "AntiCheatProtectionType21"


def update_config_file(file_path: str, key: str, new_value: str) -> None:
    skip = {k.strip() for k in os.environ.get("CONFIG_EDITOR_SKIP_KEYS", DEFAULT_SKIP_KEYS).split(",") if k.strip()}
    if key in skip:
        print(f"config_editor: skipping {key} (not a Build 42 option)")
        return

    with open(file_path, "r", encoding="utf-8", errors="surrogateescape") as file:
        lines = file.readlines()

    updated_lines = []
    key_found = False
    for line in lines:
        if line.startswith(f"{key}="):
            updated_lines.append(f"{key}={new_value}\n")
            key_found = True
        else:
            updated_lines.append(line)

    if not key_found:
        if updated_lines and not updated_lines[-1].endswith("\n"):
            updated_lines[-1] += "\n"
        updated_lines.append(f"{key}={new_value}\n")

    with open(file_path, "w", encoding="utf-8", errors="surrogateescape") as file:
        file.writelines(updated_lines)


def update_jvm_config(file_path: str, max_memory: str) -> None:
    with open(file_path, "r") as config_file:
        config = json.load(config_file)

    min_memory = os.environ.get("MIN_MEMORY") or max_memory
    extra_args = os.environ.get("JVM_EXTRA_ARGS", "").split()
    # Set by scripts/container-wrapper.sh only when ZombieBuddy.jar is present (ZOMBIEBUDDY_SERVER=true).
    javaagent = os.environ.get("ZB_JAVAAGENT", "").strip()

    def option_name(arg: str) -> str:
        # "-XX:SoftMaxHeapSize=1g" -> "-XX:SoftMaxHeapSize", "-XX:+UseZGC" -> "-XX:UseZGC"
        name = arg.split("=", 1)[0]
        return name.replace("-XX:+", "-XX:").replace("-XX:-", "-XX:")

    replaced = {option_name(a) for a in extra_args}
    config["vmArgs"] = [
        a for a in config["vmArgs"]
        if not a.startswith(("-Xmx", "-Xms", "-javaagent:")) and option_name(a) not in replaced
    ]
    config["vmArgs"] += [f"-Xmx{max_memory}", f"-Xms{min_memory}"] + extra_args
    if javaagent:
        # Mod authors' instructions: the agent line goes at the top of vmArgs.
        config["vmArgs"].insert(0, javaagent)

    with open(file_path, "w") as config_file:
        json.dump(config, config_file, indent=4)
    print(f"config_editor: JVM {javaagent} -Xmx{max_memory} -Xms{min_memory} {' '.join(extra_args)}".replace("  ", " ").strip())


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Update configuration files")
    parser.add_argument("--config", type=str, required=True, help="The path to the configuration file")
    parser.add_argument("--key", type=str, nargs="?", help="The key to update")
    parser.add_argument("--value", type=str, nargs="?", help="The new value for the key")
    parser.add_argument("--memory", type=str, nargs="?", help="The new value for the max memory setting")
    parser.add_argument("--action", type=str, choices=["update-jvm", "update-config"], default="update-config")
    args = parser.parse_args()

    if args.action == "update-config":
        update_config_file(args.config, args.key, args.value)
    elif args.action == "update-jvm":
        update_jvm_config(args.config, args.memory)
