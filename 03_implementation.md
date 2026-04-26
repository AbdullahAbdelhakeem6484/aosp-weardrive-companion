# 03_implementation.md

Full implementation plan with branch-per-feature delivery.

## Core Workflow

For every feature:

1. Create feature branch from `main`
2. Implement one feature only
3. Validate
4. Update docs (`CHANGELOG.md` and summary)
5. Commit
6. Push branch
7. Continue with next feature
8. Merge all feature branches into `main` at the end

## Branch Naming

- `feature/02-project-validation-script`
- `feature/03-smoke-test-runner`
- `feature/04-env-verification`
- `feature/05-build-launch-cleanup`
- `feature/06-app-layer-mvp`
- `feature/07-framework-api-contract`
- `feature/08-system-service-contract`
- `feature/09-aidl-contract`
- `feature/10-hal-strategy`
- `feature/11-kernel-touchpoints`
- `feature/12-bootloader-strategy`
- `feature/13-demo-validation`
- `feature/14-github-enterprise-readiness`
- `feature/15-course-summary-system`

## Pre-Feature Safety Gate

```bash
cd ~/EmbeddedAndroid_Workspace/aosp-weardrive-companion
source scripts/env_aosp16.sh
bash scripts/guard_workspace.sh
bash -n scripts/*.sh
```

## Feature Loop Template

1. Feature name
2. Goal
3. Files to inspect
4. Files to change
5. Exact commands
6. Implementation
7. Validation/build/test command
8. Result
9. Concept explanation
10. Common mistakes / OEM notes
11. Summary file
12. `CHANGELOG.md` update
13. Commit

## Implementation Plan by Feature

## Foundation Features

### Feature 02
- Build: `scripts/validate_project.sh`
- Validate: pass/fail report output

### Feature 03
- Build: `scripts/run_smoke_tests.sh`
- Validate: all smoke sections run

### Feature 04
- Build: `scripts/verify_env.sh`
- Validate: tools + target checks pass

### Feature 05
- Build: normalize build/launch scripts
- Validate: `bash -n scripts/*.sh` and dry-run checks

## High-Value Stack Features

### Feature 06 (App)
- Build: app MVP contract + prototype stub in repo
- Validate: spec completeness and scenario mapping

### Feature 07 (Framework)
- Build: framework manager contract and model interfaces
- Validate: API surface review checklist

### Feature 08 (System Service)
- Build: service contract and lifecycle/state model
- Validate: ownership and callback flow review

### Feature 09 (AIDL)
- Build: AIDL contract drafts
- Validate: compatibility + minimality checks

### Feature 10 (HAL)
- Build: HAL strategy and mock adapter mapping
- Validate: signal mapping coverage

### Feature 11 (Kernel)
- Build: kernel touchpoint analysis and trigger criteria
- Validate: justification checklist

### Feature 12 (Bootloader)
- Build: bootloader/security startup strategy
- Validate: risk and necessity matrix

## Release and Teaching Features

### Feature 13
- Build: deterministic demo validation checklist
- Validate: scenario dry-run evidence

### Feature 14
- Build: enterprise/GitHub review checklist
- Validate: readiness pass

### Feature 15
- Build: feature summaries and course lesson mapping
- Validate: one complete sample lesson package

## Push and Merge Commands

Push current branch:

```bash
git push -u origin <feature-branch>
```

Merge to main at end:

```bash
git checkout main
git pull --ff-only origin main
git merge --no-ff <feature-branch>
git push origin main
```
