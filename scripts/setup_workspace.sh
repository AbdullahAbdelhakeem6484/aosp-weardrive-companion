#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/env_aosp16.sh"

printf 'Project root: %s\n' "$PROJECT_ROOT"
printf 'AOSP root: %s\n' "$AOSP_ROOT"
printf 'Lunch target: %s\n' "$TARGET_LUNCH"
printf 'CCACHE_DIR: %s\n' "$CCACHE_DIR"

for dir in \
    "$PROJECT_ROOT/docs" \
    "$PROJECT_ROOT/scripts" \
    "$PROJECT_ROOT/demos" \
    "$PROJECT_ROOT/prototypes" \
    "$PROJECT_ROOT/tests"; do
    mkdir -p "$dir"
done

printf 'Workspace scaffold is ready.\n'
