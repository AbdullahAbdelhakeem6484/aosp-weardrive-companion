# aosp-weardrive-companion

Clean working mode for fast, guided implementation.

## Open Order

1. [task.md](task.md)
2. [analysis.md](analysis.md)
3. [implementation.md](implementation.md)
4. [concepts.md](concepts.md)

## Important Files

- [scripts/env_aosp16.sh](scripts/env_aosp16.sh)
- [scripts/guard_workspace.sh](scripts/guard_workspace.sh)
- [scripts/build_aosp16.sh](scripts/build_aosp16.sh)
- [scripts/launch_cuttlefish.sh](scripts/launch_cuttlefish.sh)
- [scripts/capture_logs.sh](scripts/capture_logs.sh)
- [CHANGELOG.md](CHANGELOG.md)
- [BASELINE.md](BASELINE.md)

## First Commands

```bash
cd ~/EmbeddedAndroid_Workspace/aosp-weardrive-companion
source scripts/env_aosp16.sh
bash scripts/guard_workspace.sh
```

## Notes

- Day-to-day work is now centered on the 4 root docs.
- Previous long-form material is preserved under `docs/archive/`.
