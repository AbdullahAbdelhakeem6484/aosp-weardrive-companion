# WearDrive Companion Step-by-Step Implementation Guide

This guide is the working document for implementation.

The rule for this project is simple:
- do one small step
- test it immediately
- document the result
- only then move to the next step

That approach is better for AOSP work, better for demos, and much closer to how an enterprise project should be built.

## Working Principles

### 1. Build in thin vertical slices

Do not build all framework pieces first and all app pieces later.

Instead:
- add a minimal service path
- connect a minimal app path
- test the complete flow
- then extend it

Why this is better for production:
- problems surface earlier
- integration risk is lower
- demo value appears quickly
- architecture mistakes are caught before they spread

### 2. Every step must have a test

Each step should include:
- what to implement
- how to validate it
- what result proves success
- what should be documented

Why this matters for enterprise quality:
- it creates traceability
- it reduces regression risk
- it makes the project easier to hand off, teach, or market later

### 3. Separate MVP from product vision

The MVP proves architecture.
The later stages prove product depth.

Do not overload the first milestone with:
- real BLE complexity
- full camera/video pipelines
- complex AI orchestration
- too many UI screens

### 4. Keep future productization in mind

At each step ask:
- is the boundary clean?
- is the permission model sane?
- can this be tested?
- can this be demoed?
- can this later be secured and hardened?

## Implementation Stages

## Stage 0: Freeze the MVP

### Goal
Define a small, credible MVP that proves platform engineering depth.

### Implement
- finalize the system name and core story
- freeze the first event types
- define the first user actions
- decide what is real now, simulated now, and hardware-later

### Recommended MVP
- custom AOSP system service
- framework manager API
- privileged companion app
- mock transport adapter
- one alert flow
- one media state flow
- one audio note plus AI summary flow

### Test Before Moving On
- confirm the MVP fits in 2 weeks of focused work
- confirm each feature can be shown in a public demo
- confirm no feature depends on real hardware for the first milestone

### Exit Criteria
- you can describe the MVP in 3 minutes
- you can list the first AOSP files to touch
- the MVP and stretch scope are clearly separate

### Enterprise Advice
- freeze interface boundaries early
- keep the problem statement business-relevant, not just technically interesting
- define one compelling use case that can later map to fleet, mobility, or premium companion-device solutions

## Stage 1: Prepare the Runtime and Project Structure

### Goal
Make the environment repeatable before changing platform code.

### Implement
- use `aosp_cf_x86_64_auto-trunk_staging-userdebug`
- keep planning and scripts in `aosp-weardrive-companion`
- verify build and launch scripts
- create a consistent logging and screenshot capture workflow

### Test Before Moving On
- run the build helper successfully
- boot Cuttlefish Auto successfully
- confirm `adb devices` shows the instance
- capture one clean `logcat` dump into the workspace

### Exit Criteria
- one known-good target
- one known-good launch flow
- one known-good log capture flow

### Enterprise Advice
- standardize the runtime target for the entire MVP
- avoid fragmented environments across multiple products early
- create repeatable shell scripts so later teammates or students can reproduce the setup

## Stage 2: Define the API and Event Model

### Goal
Design the smallest useful service contract before coding inside `aosp16`.

### Implement
- define the service responsibilities
- define `WearDriveManager`
- define first parcelables or data models
- define first listener or callback path
- define permission model

### Recommended first event types
- `TRIP_STARTED`
- `TRIP_ENDED`
- `HIGH_PRIORITY_ALERT`
- `MEDIA_CONTEXT_UPDATED`
- `VOICE_NOTE_SUMMARY_READY`

### Recommended first actions
- acknowledge alert
- dismiss alert
- request current state
- start voice note
- request media handoff

### Test Before Moving On
- review the API and make sure each method has one clear owner
- confirm no app-only concern leaked into the framework contract
- confirm all event types are demoable without real hardware

### Exit Criteria
- documented first API draft
- documented event schema
- documented permission model

### Enterprise Advice
- keep versioning in mind even if the API is hidden
- do not expose transport details through the manager API
- keep data models stable and extensible
- use explicit enums or constants instead of vague free-form strings where possible

## Stage 3: Add the System Service Skeleton in AOSP

### Goal
Create the first platform-owned implementation path.

### Implement
- add service package under `frameworks/base/services`
- add manager and API classes under `frameworks/base/core`
- register the service in `SystemServer`
- add a minimal binder interface
- add permission enforcement

### Test Before Moving On
- build AOSP successfully
- boot Cuttlefish Auto successfully
- verify service startup log appears
- verify `service list` or equivalent confirms the service is registered

### Exit Criteria
- service exists in system server
- service boots without crash
- service is discoverable from the system

### Enterprise Advice
- enforce privilege boundaries from day one
- use clear logs with consistent tags
- keep the service state machine small at first
- avoid mixing demo logic inside the core service implementation

## Stage 4: Add a Minimal End-to-End Event Path

### Goal
Prove that the service can publish state that a client can consume.

### Implement
- add one hardcoded or mock event source
- add one client query or callback
- return one meaningful data object to the client

### Test Before Moving On
- inject one event
- verify the service logs receipt and normalization
- verify the client receives the state
- verify the app does not need reboot-only behavior to see updates

### Exit Criteria
- one event flows from source to service to client
- logs clearly show the path

### Enterprise Advice
- prove one complete path before expanding event coverage
- keep the event pipeline deterministic
- prefer observability over cleverness at this stage

## Stage 5: Build the Privileged Companion App Skeleton

### Goal
Create a visible system app that consumes the platform API.

### Implement
- create `packages/apps/WearDriveCompanion`
- add a simple main screen
- add state display for service connection and latest event
- add a debug or developer panel

### Test Before Moving On
- verify the app is included in the build
- verify it launches successfully
- verify it can talk to the service
- verify it displays current state and errors clearly

### Exit Criteria
- app launches
- app can query the service
- app shows one useful screen and one debug screen

### Enterprise Advice
- keep debug features available but clearly separated
- build the UI around state clarity, not visual polish
- make failure states visible and actionable

## Stage 6: Add Mock Transport

### Goal
Model Bluetooth-like communication without making real BLE the blocker.

### Implement
- define `TransportAdapter`
- implement loopback or local socket transport
- model pairing state
- model connection state
- model message send and receive flow

### Test Before Moving On
- simulate connect and disconnect
- simulate send and receive success
- simulate retry or reconnect
- verify timestamps and logs for delivery path

### Exit Criteria
- transport abstraction exists
- one mock transport works
- reconnect behavior is visible and testable

### Enterprise Advice
- hide transport specifics behind an interface
- track connection state and error state explicitly
- collect simple metrics now: send count, failure count, reconnect count, latency

## Stage 7: Add Media Context Flow

### Goal
Make the use case feel real and product-oriented.

### Implement
- add media metadata event
- show title, playback state, and one action
- route the action back through the service

### Test Before Moving On
- inject media state
- verify the app updates
- trigger one media action
- verify service receives and logs it

### Exit Criteria
- one media state card
- one functioning action path

### Enterprise Advice
- keep media state independent from transport logic
- design for policy later, such as when not to surface media to the wearable side

## Stage 8: Add Audio Note and AI Summary

### Goal
Add a high-value, marketable differentiator without destabilizing the core stack.

### Implement
- add voice note trigger
- capture or simulate short audio input
- add a summary provider interface
- implement deterministic stub summarizer first
- optionally add host-side or cloud-backed summarizer second

### Test Before Moving On
- trigger voice note flow
- verify result returns even in fallback mode
- verify timeout or failure state is handled cleanly
- verify summary is rendered in the app

### Exit Criteria
- audio note flow works
- summary provider abstraction exists
- fallback mode is stable for demos

### Enterprise Advice
- never hardwire the app directly to one AI backend
- design for privacy and auditability
- make it easy to swap between stub, local, and cloud providers

## Stage 9: Add Demo Mode and Scenario Automation

### Goal
Make the system reliable for review, recording, and future marketing.

### Implement
- create 3 deterministic demo scenarios
- add one-click event injection scripts if possible
- prepare screenshot and log capture flow

### Test Before Moving On
- run the same scenario three times
- confirm it behaves consistently
- confirm logs and screenshots are easy to collect

### Exit Criteria
- repeatable demo flow
- repeatable proof artifacts

### Enterprise Advice
- deterministic demos build trust
- automate the boring parts early
- create assets that later support sales decks, hiring discussions, and training content

## Stage 10: Harden the Project Like a Product Candidate

### Goal
Raise the maturity from prototype to something that feels enterprise-ready.

### Implement
- clean package structure
- consistent naming
- explicit permissions
- error handling and user-visible states
- basic documentation for ops, architecture, and known limitations

### Test Before Moving On
- validate cold boot behavior
- validate service restart behavior
- validate app behavior when the service is unavailable
- validate summary provider fallback behavior

### Exit Criteria
- project behaves predictably in normal and failure paths
- docs are good enough for another engineer to onboard

### Enterprise Advice
- enterprise buyers care about reliability and clarity more than flashy features
- document known limitations honestly
- keep a clean architecture story: service, API, app, transport, AI provider

## Suggested Test Rhythm

Use this rhythm for every stage:

1. Implement one small slice.
2. Build only what is needed to validate that slice.
3. Boot and test immediately.
4. Capture logs and notes.
5. Record what worked, what failed, and what changed.

## Suggested Artifacts After Every Step

After each step, save:
- short summary of what changed
- test command used
- result
- screenshot if visible
- known issue if any

Recommended location:
- `docs/progress/`

## Recommended Productization Mindset

If you want to market this later, think in these layers:

### Technical credibility
- custom AOSP service
- privileged app
- structured IPC
- transport abstraction
- automated demos

### Business credibility
- use cases that fit automotive, fleet, mobility, or premium infotainment ecosystems
- security and permission awareness
- deterministic behavior
- roadmap from simulation to hardware

### Course and content credibility
- clean repo structure
- repeatable setup
- stage-based delivery
- honest tradeoff documentation

## Recommended First Three Working Sessions

### Session 1
- finalize MVP event types and actions
- write the first API draft
- confirm exact AOSP integration points

### Session 2
- create the system service skeleton
- register it in `SystemServer`
- boot and confirm service registration

### Session 3
- create the privileged app skeleton
- connect it to the service
- prove one event end to end

## What We Should Do Next

The next best step is:
- create `mvp-api-and-event-model.md`

That will let us start implementation with much less risk.
