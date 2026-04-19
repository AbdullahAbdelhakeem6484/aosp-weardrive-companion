#!/usr/bin/env bash
set -euo pipefail

AOSP_ROOT="/home/abdullah-abdelhakeem/EmbeddedAndroid_Workspace/aosp_versions/aosp16"
TARGET_PRODUCT="aosp_cf_x86_64_auto"

cd "$AOSP_ROOT"
source build/envsetup.sh
lunch "$TARGET_PRODUCT-trunk_staging-userdebug"
m -j"$(nproc)"
