# 01_tasks.md

All project tasks with real product-value features across the stack.

## Execution Rules

- One feature per branch.
- One feature per commit.
- Validate after each feature.
- Update `CHANGELOG.md` after each feature.
- If a feature requires AOSP tree edits, request explicit approval first.

## Track A: Foundation and Operations

## Feature 01: Safety Rules and Workspace Isolation

- Ensure environment isolation (`PROJECT_ROOT`, `AOSP_ROOT`).
- Enforce workspace guard.
- Define safety policy.

Status:
- Completed.

## Feature 02: Project Validation Script

- Create one script to validate repo health and required files.
- Ensure script executability and env variable integrity.

Deliverable:
- `scripts/validate_project.sh`

## Feature 03: Smoke Test Runner

- Add fast smoke test orchestration for daily confidence.

Deliverable:
- `scripts/run_smoke_tests.sh`

## Feature 04: AOSP16 Environment Verification

- Verify tools, lunch target, and ccache location.

Deliverable:
- `scripts/verify_env.sh`

## Feature 05: Build and Launch Workflow Cleanup

- Normalize build/launch/log scripts.
- Keep deterministic messages and outcomes.

Deliverables:
- updated scripts
- usage notes in `03_implementation.md`

## Track B: Core Product Features (High Value)

## Feature 06: App Layer MVP (Companion App Spec + Stub)

- Define privileged app module contract.
- Create repo-side stub/prototype structure for UI state cards and debug controls.

Deliverable:
- `prototypes/app_mvp/` spec and starter skeleton

## Feature 07: Framework API Contract (Manager + Models)

- Define strict API contract for `WearDriveManager`.
- Define event/state models and error surface.

Deliverable:
- `prototypes/framework_api_contract/` docs and interfaces

## Feature 08: System Service Contract

- Define service responsibilities and lifecycle.
- Define listener registration and state ownership.

Deliverable:
- `prototypes/system_service_contract/` contract and pseudocode

## Feature 09: AIDL Contract Definition

- Define AIDL interfaces for manager-service interaction.
- Version and compatibility notes.

Deliverable:
- `prototypes/aidl_contract/` interface drafts

## Feature 10: HAL Integration Strategy (VHAL/Binder HAL Plan)

- Define which signals come from HAL.
- Define mock HAL adapter behavior for emulator-first execution.

Deliverable:
- `prototypes/hal_strategy/` design and mock mapping

## Feature 11: Kernel Touchpoint Strategy

- Define only justified kernel touchpoints (if needed).
- Map likely kernel dependencies for Bluetooth/audio/timing.

Deliverable:
- `prototypes/kernel_touchpoints/` analysis and test criteria

## Feature 12: Bootloader and Security Startup Strategy

- Define boot-time implications and verified boot constraints.
- Define when bootloader changes are justified vs unnecessary.

Deliverable:
- `prototypes/bootloader_strategy/` design notes

## Track C: Validation, Demo, and Release

## Feature 13: End-to-End Demo Scenario Validation

- Define deterministic scenario steps and evidence artifacts.

Deliverable:
- validated scenario checklist and capture plan

## Feature 14: GitHub and Enterprise Review Readiness

- Ensure repo reviewability, security hygiene, and artifact clarity.

Deliverable:
- release readiness checklist

## Feature 15: Course-Ready Summaries and Lesson Mapping

- Generate concise feature summaries mapped to future course modules.

Deliverable:
- reusable summary template + lesson map
