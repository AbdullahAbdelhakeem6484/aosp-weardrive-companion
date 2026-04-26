# 00_README.md

This is the main operator guide for day-to-day work.

## Why You Did Not See Changes on GitHub

Recent work was committed on:
- `safe-mvp-implementation-plan`

Not on:
- `main`

So GitHub `main` will not show those commits until we merge and push `main`.

## Daily Open Order

1. [01_tasks.md](01_tasks.md)
2. [02_analysis.md](02_analysis.md)
3. [03_implementation.md](03_implementation.md)
4. [04_concepts.md](04_concepts.md)

## Project Value Focus

This project now explicitly covers valuable stack features:
- app layer
- framework API
- system service
- AIDL contract
- HAL strategy
- kernel touchpoint strategy
- bootloader/security strategy

## Important Operational Files

- [scripts/env_aosp16.sh](scripts/env_aosp16.sh)
- [scripts/guard_workspace.sh](scripts/guard_workspace.sh)
- [scripts/build_aosp16.sh](scripts/build_aosp16.sh)
- [scripts/launch_cuttlefish.sh](scripts/launch_cuttlefish.sh)
- [scripts/capture_logs.sh](scripts/capture_logs.sh)
- [CHANGELOG.md](CHANGELOG.md)
- [BASELINE.md](BASELINE.md)

## Mandatory Start Commands

```bash
cd ~/EmbeddedAndroid_Workspace/aosp-weardrive-companion
source scripts/env_aosp16.sh
bash scripts/guard_workspace.sh
```

## Branch Strategy (Feature by Feature)

We will use this flow:

1. Branch from `main`: `feature/NN-<name>`
2. Implement one feature only
3. Validate
4. Commit
5. Push feature branch
6. Repeat for next feature
7. Merge all feature branches into `main` at the end
8. Push `main`

## Legacy Material

Previous detailed documents are preserved in:
- `docs/archive/`
