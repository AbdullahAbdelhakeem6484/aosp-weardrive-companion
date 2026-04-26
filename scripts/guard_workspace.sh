#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/env_aosp16.sh"

CURRENT_DIR="$(pwd)"

if [[ "${CURRENT_DIR}" != "${PROJECT_ROOT}"* ]]; then
    echo "ERROR: Run this command from inside PROJECT_ROOT." >&2
    echo "Current: ${CURRENT_DIR}" >&2
    echo "Expected prefix: ${PROJECT_ROOT}" >&2
    exit 1
fi

if [[ "${AOSP_ROOT}" == "${PROJECT_ROOT}"* ]]; then
    echo "ERROR: AOSP_ROOT is inside PROJECT_ROOT, which violates isolation." >&2
    exit 1
fi

echo "Workspace guard passed."
echo "PROJECT_ROOT=${PROJECT_ROOT}"
echo "AOSP_ROOT=${AOSP_ROOT}"
echo "TARGET_LUNCH=${TARGET_LUNCH}"
