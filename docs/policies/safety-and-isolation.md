# Safety and Workspace Isolation Policy

This project follows strict safety rules to protect the AOSP source tree and keep work reproducible.

## Scope

Applies to all work under:
- `~/EmbeddedAndroid_Workspace/aosp-weardrive-companion`

AOSP source remains external:
- `~/EmbeddedAndroid_Workspace/aosp_versions/aosp16`

## Safety Rules

1. Do not modify `aosp16` unless explicitly approved for a specific feature.
2. Keep planning, scripts, docs, demos, and summaries in this repository.
3. Use explicit environment variables from `scripts/env_aosp16.sh`.
4. Never run destructive commands like `rm -rf`, `git reset --hard`, or `git clean -fdx`.
5. Validate every feature immediately after implementation.
6. Create a short feature summary under `docs/summaries/` after each feature.
7. Update `CHANGELOG.md` for every feature.
8. Commit each completed feature separately.

## Safety Command

Before implementation, run:

```bash
cd ~/EmbeddedAndroid_Workspace/aosp-weardrive-companion
source scripts/env_aosp16.sh
./scripts/guard_workspace.sh
```

Expected result:
- workspace guard passes
- project and AOSP paths are printed
- target lunch is printed

## OEM and Enterprise Rationale

- Prevents accidental source tree changes outside approved scope.
- Keeps implementation traceable for audits and reviews.
- Supports reproducible training and course material.
