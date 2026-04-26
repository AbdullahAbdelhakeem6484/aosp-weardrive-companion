#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/env_aosp16.sh"

OUT_DIR="${PROJECT_ROOT}/demos/logs"
mkdir -p "$OUT_DIR"
adb logcat -d > "$OUT_DIR/logcat.txt"
printf 'Saved logs to %s\n' "$OUT_DIR/logcat.txt"
