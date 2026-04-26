# Baseline

This file tracks the baseline state of the `aosp-weardrive-companion` repository.

## Current Baseline

### Repository identity
- repository name set to `aosp-weardrive-companion`
- AOSP source stays external in `aosp16`
- Cuttlefish Auto is the default target

### Working mode
- daily workflow is centered on root docs:
  - `00_README.md`
  - `01_tasks.md`
  - `02_analysis.md`
  - `03_implementation.md`
  - `04_concepts.md`
- previous long-form materials are preserved in `docs/archive/`

### Documentation baseline
- README start page and navigation panel
- project brief
- architecture docs
- implementation guide
- command runbook
- GitHub publishing guide

### Script baseline
- workspace helper
- AOSP build helper
- Cuttlefish launch helper
- log capture helper

### Delivery baseline
- implementation starts from MVP API and event model
- validation is required after every step
- repo is structured for future public demos and course material
