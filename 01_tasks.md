# 01_tasks.md

All planned tasks for this project, ordered for safe MVP delivery.

## Execution Rules

- One feature per branch.
- One feature per commit.
- Validate after each feature.
- Update `CHANGELOG.md` after each feature.

## Feature Task List

## Feature 01: Safety Rules and Workspace Isolation

- Ensure environment isolation (`PROJECT_ROOT`, `AOSP_ROOT`).
- Enforce workspace guard.
- Define safety policy.

Status:
- Completed.

## Feature 02: Project Validation Script

- Create one script to validate:
  - required files exist
  - scripts are executable
  - env variables resolve
  - archive and root docs consistency
- Output clear pass/fail report.

Deliverable:
- `scripts/validate_project.sh`

## Feature 03: Smoke Test Runner

- Create smoke runner for fast health checks:
  - guard check
  - shell syntax checks
  - adb visibility check (if device running)
  - log path check

Deliverable:
- `scripts/run_smoke_tests.sh`

## Feature 04: AOSP16 Environment Verification

- Add script/report to verify:
  - target lunch
  - ccache directory
  - required tool presence (`adb`, `launch_cvd`, `git`)

Deliverable:
- `scripts/verify_env.sh`

## Feature 05: Build Workflow Cleanup

- Normalize build commands and output messaging.
- Keep scripts idempotent and readable.
- Remove duplicate logic from scripts.

Deliverables:
- updated build-related scripts
- short build usage section in `03_implementation.md`

## Feature 06: Cuttlefish Launch Workflow Validation

- Add controlled launch checks:
  - boot completion props
  - adb connected
  - optional status output

Deliverable:
- launch validation section/script hook

## Feature 07: Log Capture Workflow Validation

- Improve log capture consistency:
  - include timestamped outputs
  - optional kernel/launcher log references
  - predictable output paths

Deliverable:
- improved `scripts/capture_logs.sh`

## Feature 08: MVP API/Event Model Cleanup

- Convert high-level API draft to implementation-ready contract:
  - strict event naming
  - payload expectations
  - minimal API surface

Deliverable:
- refreshed MVP spec (in root docs or archive update with reference)

## Feature 09: System Architecture Cleanup

- Tighten boundaries:
  - service ownership
  - app ownership
  - transport ownership
- Add data flow focused view.

Deliverable:
- concise architecture summary for implementation handoff

## Feature 10: Demo Scenario Validation

- Define runnable demo checks:
  - scenario inputs
  - expected outputs
  - required logs

Deliverable:
- validated demo checklist

## Feature 11: GitHub Publishing Readiness

- Ensure repo is clean for reviewers:
  - required docs
  - no secrets
  - branch and PR guidance

Deliverable:
- release readiness checklist

## Feature 12: Course-Ready Summary Generation

- Create consistent per-feature learning summaries:
  - what changed
  - why it matters
  - commands
  - lessons

Deliverable:
- reusable summary template and completed summaries
