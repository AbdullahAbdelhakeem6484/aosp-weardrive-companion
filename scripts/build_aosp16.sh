#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/env_aosp16.sh"

cd "$AOSP_ROOT"
source build/envsetup.sh
lunch "$TARGET_LUNCH"
m -j"$(nproc)"
