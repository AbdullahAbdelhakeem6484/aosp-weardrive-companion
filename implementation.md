# implementation.md

## Structured Approach

## Step 0: Safety Gate (always first)

```bash
cd ~/EmbeddedAndroid_Workspace/aosp-weardrive-companion
source scripts/env_aosp16.sh
bash scripts/guard_workspace.sh
```

Expected:
- guard passes
- project root and target lunch printed

## Step 1: Feature Workflow

For each feature:

1. Inspect files first
2. Make minimal edits
3. Run validation
4. Record short summary
5. Update changelog
6. Commit

## Step 2: Validation Commands

```bash
bash -n scripts/*.sh
```

Build/boot path when needed:

```bash
bash scripts/build_aosp16.sh
bash scripts/launch_cuttlefish.sh
bash scripts/capture_logs.sh
```

## Step 3: Commit Pattern

```bash
git add <feature-files>
git commit -m "feature-XX: <short-description>"
```

## Next Feature To Implement

`Feature 02: project validation script`
