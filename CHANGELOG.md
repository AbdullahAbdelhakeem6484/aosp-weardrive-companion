# Changelog

## Unreleased

### Added
- project planning workspace outside the AOSP tree
- architecture, implementation, demo, manager, course, and release guides
- command runbook with build, boot, and validation commands
- GitHub publishing guide
- baseline tracking files
- workspace guard script and formal safety/isolation policy
- feature summary workflow directory at `docs/summaries/`
- project validation script: `scripts/validate_project.sh`

### Changed
- repository name updated to `aosp-weardrive-companion`
- README turned into a start page with navigation and implementation order
- workspace scripts updated to the new project path
- scripts now share centralized environment config and ccache isolation under `out/.ccache`
- root execution docs: `task.md`, `analysis.md`, `implementation.md`, `concepts.md`
- archive index at `docs/archive/README.md`
- ordered root docs: `00_README.md`, `01_tasks.md`, `02_analysis.md`, `03_implementation.md`, `04_concepts.md`
- lightweight `README.md` that points to ordered docs

### Simplified
- daily navigation now focuses on root docs and essential scripts
- previous detailed docs moved under `docs/archive/` for reference
- feature plan now includes branch-per-feature then final merge to `main`

### Runtime
- default target is `aosp_cf_x86_64_auto-bp2a-userdebug`
