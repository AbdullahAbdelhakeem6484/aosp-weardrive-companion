#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="/home/abdullah-abdelhakeem/EmbeddedAndroid_Workspace/aosp-weardrive-companion/demos/logs"
mkdir -p "$OUT_DIR"
adb logcat -d > "$OUT_DIR/logcat.txt"
printf 'Saved logs to %s\n' "$OUT_DIR/logcat.txt"
