# Changelog

## Unreleased

### Added
- project planning workspace outside the AOSP tree
- architecture, implementation, demo, manager, course, and release guides
- command runbook with build, boot, and validation commands
- GitHub publishing guide
- baseline tracking files
- project validation script: `scripts/validate_project.sh`
- workspace guard script and formal safety/isolation policy
- feature summary workflow directory at `docs/summaries/`

### Changed
- repository name updated to `aosp-weardrive-companion`
- README turned into a start page with navigation and implementation order
- workspace scripts updated to the new project path
- scripts now share centralized environment config and ccache isolation under `out/.ccache`

### Runtime
- default target is `aosp_cf_x86_64_auto-bp2a-userdebug`
