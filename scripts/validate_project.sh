#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

pass_count=0
warn_count=0
fail_count=0

pass() {
    pass_count=$((pass_count + 1))
    printf '[PASS] %s\n' "$1"
}

warn() {
    warn_count=$((warn_count + 1))
    printf '[WARN] %s\n' "$1"
}

fail() {
    fail_count=$((fail_count + 1))
    printf '[FAIL] %s\n' "$1"
}

check_file_exists() {
    local f="$1"
    if [[ -f "$f" ]]; then
        pass "exists: ${f#${PROJECT_ROOT}/}"
    else
        fail "missing file: ${f#${PROJECT_ROOT}/}"
    fi
}

check_exec_script() {
    local f="$1"
    if [[ ! -f "$f" ]]; then
        fail "missing script: ${f#${PROJECT_ROOT}/}"
        return
    fi
    if [[ -x "$f" ]]; then
        pass "executable: ${f#${PROJECT_ROOT}/}"
    else
        fail "not executable: ${f#${PROJECT_ROOT}/}"
    fi
}

printf '=== Feature 02 Validation: Project Health ===\n'
printf 'Project root: %s\n' "$PROJECT_ROOT"

printf '\n--- Required root docs ---\n'
if [[ -f "${PROJECT_ROOT}/00_README.md" ]]; then
    pass "detected numbered root docs layout"
    check_file_exists "${PROJECT_ROOT}/00_README.md"
    check_file_exists "${PROJECT_ROOT}/01_tasks.md"
    check_file_exists "${PROJECT_ROOT}/02_analysis.md"
    check_file_exists "${PROJECT_ROOT}/03_implementation.md"
    check_file_exists "${PROJECT_ROOT}/04_concepts.md"
else
    warn "numbered root docs not found; validating legacy README/docs layout"
    check_file_exists "${PROJECT_ROOT}/README.md"
    check_file_exists "${PROJECT_ROOT}/docs/implementation/step-by-step-guide.md"
    check_file_exists "${PROJECT_ROOT}/docs/implementation/command-runbook.md"
    check_file_exists "${PROJECT_ROOT}/docs/architecture/mvp-api-and-event-model.md"
    check_file_exists "${PROJECT_ROOT}/docs/architecture/system-architecture.md"
fi
check_file_exists "${PROJECT_ROOT}/BASELINE.md"
check_file_exists "${PROJECT_ROOT}/CHANGELOG.md"

printf '\n--- Required script files ---\n'
check_file_exists "${PROJECT_ROOT}/scripts/env_aosp16.sh"
check_exec_script "${PROJECT_ROOT}/scripts/guard_workspace.sh"
check_exec_script "${PROJECT_ROOT}/scripts/build_aosp16.sh"
check_exec_script "${PROJECT_ROOT}/scripts/launch_cuttlefish.sh"
check_exec_script "${PROJECT_ROOT}/scripts/capture_logs.sh"
check_exec_script "${PROJECT_ROOT}/scripts/setup_workspace.sh"

printf '\n--- Environment and workspace guard ---\n'
if source "${PROJECT_ROOT}/scripts/env_aosp16.sh"; then
    pass "env_aosp16.sh sourced"
else
    fail "env_aosp16.sh failed"
fi

if bash "${PROJECT_ROOT}/scripts/guard_workspace.sh" >/dev/null 2>&1; then
    pass "guard_workspace.sh passed"
else
    fail "guard_workspace.sh failed"
fi

if [[ "${PROJECT_ROOT}" == "${AOSP_ROOT}"* ]]; then
    fail "AOSP_ROOT is inside PROJECT_ROOT"
else
    pass "AOSP_ROOT outside PROJECT_ROOT"
fi

printf '\n--- Script syntax ---\n'
if bash -n "${PROJECT_ROOT}/scripts/"*.sh; then
    pass "shell syntax check passed"
else
    fail "shell syntax check failed"
fi

printf '\n--- Cuttlefish / adb readiness ---\n'
if command -v adb >/dev/null 2>&1; then
    pass "adb available"
    if adb get-state >/dev/null 2>&1; then
        pass "adb device reachable"
        boot_value="$(adb shell getprop sys.boot_completed 2>/dev/null | tr -d '\r' || true)"
        if [[ "$boot_value" == "1" ]]; then
            pass "guest boot completed"
        else
            warn "guest connected but not fully booted (sys.boot_completed=${boot_value:-empty})"
        fi
    else
        warn "no adb device currently reachable (start Cuttlefish to validate runtime)"
    fi
else
    fail "adb not found in PATH"
fi

printf '\n=== Summary ===\n'
printf 'PASS: %d\n' "$pass_count"
printf 'WARN: %d\n' "$warn_count"
printf 'FAIL: %d\n' "$fail_count"

if [[ "$fail_count" -gt 0 ]]; then
    exit 1
fi

exit 0
