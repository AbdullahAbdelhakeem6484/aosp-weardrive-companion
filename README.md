# AOSP WearDrive Companion

This repository is the main non-AOSP workspace for planning, implementation guidance, demos, documentation, and standalone prototypes for an AOSP-based vehicle-to-wear companion platform.

Primary AOSP source:
- `/home/abdullah-abdelhakeem/EmbeddedAndroid_Workspace/aosp_versions/aosp16`

Project workspace:
- `/home/abdullah-abdelhakeem/EmbeddedAndroid_Workspace/aosp-weardrive-companion`

This repo stays outside the AOSP tree on purpose. Keep docs, scripts, architecture, demos, course material, and standalone prototypes here. Move code into `aosp16` only when it must be integrated into the Android platform build.

## Repository Description

Recommended GitHub description:

`AOSP 16 platform project for a vehicle-to-wear companion experience with custom framework service, privileged app, transport simulation, media flows, and AI summary hooks.`

Shorter alternative:

`AOSP 16 vehicle-to-wear companion platform with framework service, privileged app, transport simulation, and AI-ready architecture.`

Repository URL:

[`github.com/AbdullahAbdelhakeem6484/aosp-weardrive-companion`](https://github.com/AbdullahAbdelhakeem6484/aosp-weardrive-companion)

## Start Here

If you want the fastest path to begin work, follow this order:

1. Read [Step-by-Step Guide](docs/implementation/step-by-step-guide.md)
2. Read [Command Runbook](docs/implementation/command-runbook.md)
3. Read [MVP API and Event Model](docs/architecture/mvp-api-and-event-model.md)
4. Read [System Architecture](docs/architecture/system-architecture.md)
5. Start implementation inside `aosp16`

This order is intentional:
- the implementation guide explains the delivery method
- the command runbook tells you exactly what to run
- the MVP API file defines what we build first
- the architecture file gives the bigger picture after the MVP is clear

## Navigation Panel

Use this section as the main navigation map for the repo.

### 1. Start and Execution
- [Step-by-Step Guide](docs/implementation/step-by-step-guide.md)
- [Command Runbook](docs/implementation/command-runbook.md)
- [Safety and Isolation Policy](docs/policies/safety-and-isolation.md)

### 2. Architecture and Design
- [MVP API and Event Model](docs/architecture/mvp-api-and-event-model.md)
- [System Architecture](docs/architecture/system-architecture.md)
- [Project Brief](docs/project-brief.md)

### 3. Manager and Communication Material
- [One-Week Discussion Plan](docs/manager/one-week-discussion-plan.md)
- [Demo Scenarios](docs/demo/demo-scenarios.md)

### 4. Course and Publication Material
- [Udemy Course Outline](docs/course/udemy-course-outline.md)
- [GitHub Publishing Guide](docs/release/github-publishing-guide.md)

### 5. Scripts
- [env_aosp16.sh](scripts/env_aosp16.sh)
- [guard_workspace.sh](scripts/guard_workspace.sh)
- [validate_project.sh](scripts/validate_project.sh)
- [setup_workspace.sh](scripts/setup_workspace.sh)
- [build_aosp16.sh](scripts/build_aosp16.sh)
- [launch_cuttlefish.sh](scripts/launch_cuttlefish.sh)
- [capture_logs.sh](scripts/capture_logs.sh)

### 6. Progress Tracking
- [Progress Notes](docs/progress/README.md)
- [Baseline](BASELINE.md)
- [Changelog](CHANGELOG.md)

## Default Runtime Target

We use **Cuttlefish Auto**, not phone.

Default lunch target:
- `aosp_cf_x86_64_auto-bp2a-userdebug`

Why this is the correct default:
- better fit for your AAOS background
- better story for vehicle-context features
- better long-term alignment for enterprise and demo positioning

## Workspace Rules

Keep these in this repo:
- docs
- scripts
- architecture
- demos
- course materials
- standalone prototypes

Only place code in `aosp16` when it belongs to the platform build, for example:
- `packages/apps/*`
- `frameworks/base/*`
- `frameworks/base/services/*`
- `system/*`
- product, device, or build config files
- sepolicy when required

## First Implementation Order

This is the exact order I recommend for real work:

### Step 1
Finalize the MVP API and event model.

File:
- [MVP API and Event Model](docs/architecture/mvp-api-and-event-model.md)

Output:
- agreed event types
- agreed manager methods
- agreed service responsibilities

### Step 2
Create the first AOSP system service skeleton.

Target paths in `aosp16`:
- `frameworks/base/core/java/android/weardrive/`
- `frameworks/base/services/core/java/com/android/server/weardrive/`
- `frameworks/base/services/java/com/android/server/SystemServer.java`

Output:
- service registration
- buildable framework path
- visible startup logs

### Step 3
Build and boot immediately after the service skeleton.

Guide:
- [Command Runbook](docs/implementation/command-runbook.md)

Output:
- successful build
- successful Cuttlefish Auto boot
- service visible in logs or service list

### Step 4
Create the privileged companion app skeleton.

Target path in `aosp16`:
- `packages/apps/WearDriveCompanion/`

Output:
- app launches
- app can query service state

### Step 5
Add one end-to-end feature and validate it before adding anything else.

Recommended first feature:
- `HIGH_PRIORITY_ALERT`

Output:
- inject alert
- service normalizes it
- app displays it
- user acknowledges it

## Baseline Files in This Repo

This repo includes baseline project files so it feels closer to a serious public engineering workspace:
- `BASELINE.md`
- `CHANGELOG.md`
- `.gitignore`
- `docs/progress/README.md`

## What To Open During Daily Work

Keep these open side by side:
- [README.md](README.md)
- [Command Runbook](docs/implementation/command-runbook.md)
- [MVP API and Event Model](docs/architecture/mvp-api-and-event-model.md)
- the AOSP files you are actively editing

That gives you:
- current task order
- exact commands
- current API contract
- implementation context

## Suggested Top-Level Layout

- `docs/` planning, architecture, manager briefs, execution guides, and course material
- `scripts/` build, launch, log capture, and workspace helpers
- `demos/` screenshots, walkthrough notes, and recording plans
- `prototypes/` standalone proof-of-concept code not yet integrated into AOSP
- `tests/` validation checklists and later smoke tests

## Recommended Next Step

The next implementation step is:
- start with [MVP API and Event Model](docs/architecture/mvp-api-and-event-model.md)

After that, we create the first AOSP patch set together.
