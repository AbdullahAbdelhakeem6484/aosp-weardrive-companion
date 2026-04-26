# Feature Summary: Project Validation Script

## What we built

Created `scripts/validate_project.sh` to run a deterministic project health check:
- required root files
- required scripts and executable flags
- environment and workspace guard checks
- shell syntax checks
- adb/Cuttlefish readiness checks

## Why it matters

It gives us one trusted preflight command before every feature.
This reduces mistakes and makes progress auditable.

## Files changed

- `scripts/validate_project.sh`
- `CHANGELOG.md`

## Commands run

```bash
cd ~/EmbeddedAndroid_Workspace/aosp-weardrive-companion
source scripts/env_aosp16.sh
bash scripts/guard_workspace.sh
bash scripts/validate_project.sh
```

## Test/build result

- validation script executed successfully
- Cuttlefish/adb readiness check reported status

## Concepts learned

- preflight validation
- deterministic quality gates
- separating hard failures from warnings

## OEM / Enterprise notes

- one-command validation improves team consistency
- validation output can be reused in CI later

## Next feature

`Feature 03: smoke test runner`
