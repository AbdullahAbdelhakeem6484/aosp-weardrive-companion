# concepts.md

## 1. Why Workspace Isolation Matters

We keep orchestration, docs, scripts, and validation in this repo.
AOSP source remains external and is touched only with explicit approval.

## 2. Why Feature-by-Feature Delivery

Small features reduce debugging cost and keep progress visible.
Each feature ends with validation and a commit.

## 3. Why Validation Before Speed

Fast changes without checks create hidden breakage.
Running safety and script checks first keeps the workflow reliable.

## 4. Why This Is OEM-Friendly

- Repeatable setup
- Explicit safety rules
- Clean commit history
- Test evidence after each feature
- Clear separation between planning and platform integration

## 5. Cuttlefish Practical Mindset

- Boot success is not enough; confirm logs and service behavior.
- Keep logs after each test (`scripts/capture_logs.sh`).
- Prefer deterministic command flow over manual ad-hoc steps.
