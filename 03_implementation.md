# 03_implementation.md

Full implementation plan and execution commands.

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
- `feature/05-build-workflow-cleanup`
- `feature/06-cuttlefish-launch-validation`
- `feature/07-log-capture-validation`
- `feature/08-mvp-api-event-model`
- `feature/09-architecture-cleanup`
- `feature/10-demo-validation`
- `feature/11-github-readiness`
- `feature/12-course-summary-system`

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

## Feature 02

Build:
- `scripts/validate_project.sh`

Validate:
- run script and confirm pass/fail summary

## Feature 03

Build:
- `scripts/run_smoke_tests.sh`

Validate:
- run on clean shell and confirm all sections report

## Feature 04

Build:
- `scripts/verify_env.sh`

Validate:
- confirm tool and target checks

## Feature 05

Build:
- streamline script messages and shared helpers

Validate:
- `bash -n scripts/*.sh`
- dry-run flow of build/launch scripts

## Feature 06

Build:
- launch checks and post-launch verification steps

Validate:
- `adb devices`
- `adb shell getprop sys.boot_completed`

## Feature 07

Build:
- improve log capture naming and consistency

Validate:
- confirm logs written to expected output path

## Feature 08

Build:
- tighten MVP API/event contract docs for coding handoff

Validate:
- review completeness against first coding feature needs

## Feature 09

Build:
- concise architecture execution view

Validate:
- architecture matches API/event model and scripts

## Feature 10

Build:
- scenario-by-scenario validation checklist

Validate:
- execute checklist and capture evidence

## Feature 11

Build:
- GitHub review readiness checklist

Validate:
- self-review pass

## Feature 12

Build:
- summary template and feature-to-lesson map

Validate:
- generate at least one example lesson-ready summary

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
