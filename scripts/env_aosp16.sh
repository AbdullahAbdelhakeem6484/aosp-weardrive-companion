#!/usr/bin/env bash

export WORKSPACE_ROOT="${HOME}/EmbeddedAndroid_Workspace"
export PROJECT_ROOT="${WORKSPACE_ROOT}/aosp-weardrive-companion"
export AOSP_ROOT="${WORKSPACE_ROOT}/aosp_versions/aosp16"

export TARGET_PRODUCT="aosp_cf_x86_64_auto"
export TARGET_LUNCH="${TARGET_PRODUCT}-bp2a-userdebug"

# Keep ccache state inside the writable build output area instead of ~/.ccache,
# which may be mounted read-only in some environments.
export CCACHE_DIR="${AOSP_ROOT}/out/.ccache"
export CCACHE_TEMPDIR="${AOSP_ROOT}/out/.ccache/tmp"

mkdir -p "${CCACHE_DIR}" "${CCACHE_TEMPDIR}"

# Basic safety checks to keep workspace and AOSP roots explicit.
if [[ ! -d "${PROJECT_ROOT}" ]]; then
    echo "ERROR: PROJECT_ROOT does not exist: ${PROJECT_ROOT}" >&2
    return 1 2>/dev/null || exit 1
fi

if [[ ! -d "${AOSP_ROOT}" ]]; then
    echo "ERROR: AOSP_ROOT does not exist: ${AOSP_ROOT}" >&2
    return 1 2>/dev/null || exit 1
fi

if [[ "${AOSP_ROOT}" == "${PROJECT_ROOT}"* ]]; then
    echo "ERROR: AOSP_ROOT must be outside PROJECT_ROOT." >&2
    return 1 2>/dev/null || exit 1
fi
