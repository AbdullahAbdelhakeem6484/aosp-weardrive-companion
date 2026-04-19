#!/usr/bin/env bash
set -euo pipefail

WORKSPACE_ROOT="/home/abdullah-abdelhakeem/EmbeddedAndroid_Workspace"
PROJECT_ROOT="$WORKSPACE_ROOT/aosp-weardrive-companion"
AOSP_ROOT="$WORKSPACE_ROOT/aosp_versions/aosp16"

printf 'Project root: %s\n' "$PROJECT_ROOT"
printf 'AOSP root: %s\n' "$AOSP_ROOT"

for dir in \
    "$PROJECT_ROOT/docs" \
    "$PROJECT_ROOT/scripts" \
    "$PROJECT_ROOT/demos" \
    "$PROJECT_ROOT/prototypes" \
    "$PROJECT_ROOT/tests"; do
    mkdir -p "$dir"
done

printf 'Workspace scaffold is ready.\n'
