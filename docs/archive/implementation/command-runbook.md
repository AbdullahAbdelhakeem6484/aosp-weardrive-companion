# WearDrive Companion Command Runbook

This runbook is the practical companion to the implementation guide.

Use it when you want exact commands to:
- build
- boot
- validate
- inspect logs
- test each feature incrementally

The intended workflow is:
1. implement one small feature
2. build only what is needed
3. boot and validate
4. collect proof
5. move to the next feature only if the current feature is stable

## 1. Core Paths

```bash
export WORKSPACE_ROOT="$HOME/EmbeddedAndroid_Workspace"
export PROJECT_ROOT="$WORKSPACE_ROOT/aosp-weardrive-companion"
export AOSP_ROOT="$WORKSPACE_ROOT/aosp_versions/aosp16"
export TARGET_PRODUCT="aosp_cf_x86_64_auto"
export TARGET_LUNCH="$TARGET_PRODUCT-bp2a-userdebug"
export CCACHE_DIR="$AOSP_ROOT/out/.ccache"
export CCACHE_TEMPDIR="$AOSP_ROOT/out/.ccache/tmp"
mkdir -p "$CCACHE_DIR" "$CCACHE_TEMPDIR"
```

## 2. First-Time Session Start

Open a shell and run:

```bash
cd "$PROJECT_ROOT"
source ./scripts/env_aosp16.sh
./scripts/guard_workspace.sh

cd "$AOSP_ROOT"
source build/envsetup.sh
lunch "$TARGET_LUNCH"
```

Validate lunch:

```bash
echo "$TARGET_PRODUCT"
echo "$TARGET_BUILD_VARIANT"
```

Expected:
- product should be `aosp_cf_x86_64_auto`
- variant should be `userdebug`

## 2.1 Fix the `~/.ccache/tmp` Read-Only Failure

If you hit an error like:

```text
ccache: error: failed to create temporary file for /home/.../.ccache/tmp/...
Read-only file system
```

use this fix before building:

```bash
export CCACHE_DIR="$AOSP_ROOT/out/.ccache"
export CCACHE_TEMPDIR="$AOSP_ROOT/out/.ccache/tmp"
mkdir -p "$CCACHE_DIR" "$CCACHE_TEMPDIR"
```

Then continue with:

```bash
cd "$AOSP_ROOT"
source build/envsetup.sh
lunch "$TARGET_LUNCH"
m -j"$(nproc)"
```

Fallback if you want to bypass ccache entirely for one build:

```bash
export CCACHE_EXEC=""
cd "$AOSP_ROOT"
source build/envsetup.sh
lunch "$TARGET_LUNCH"
m -j"$(nproc)"
```

Recommended approach:
- prefer moving `ccache` into `out/` because it stays writable and keeps incremental build benefits
- use `CCACHE_EXEC=""` only as a temporary escape hatch

## 3. Build Commands

### Full build

```bash
cd "$AOSP_ROOT"
source build/envsetup.sh
lunch "$TARGET_LUNCH"
m -j"$(nproc)"
```

### Faster iterative build

Use this after small framework or app changes:

```bash
cd "$AOSP_ROOT"
source build/envsetup.sh
lunch "$TARGET_LUNCH"
m -j"$(nproc)" framework services
```

### Build one app module later

Replace `WearDriveCompanion` with the actual module name once created:

```bash
cd "$AOSP_ROOT"
source build/envsetup.sh
lunch "$TARGET_LUNCH"
m -j"$(nproc)" WearDriveCompanion
```

Production advice:
- do one clean full build after a meaningful milestone
- during fast iteration, prefer smaller builds to shorten feedback loops
- keep a short note when a build starts failing after a specific patch

## 4. Launch Cuttlefish Auto

```bash
cd "$AOSP_ROOT"
source build/envsetup.sh
lunch "$TARGET_LUNCH"
launch_cvd
```


### Launch Cuttlefish (using built host tools)
```bash
# From the AOSP root, point to your built product
export ANDROID_PRODUCT_OUT=$PWD/out/target/product/vsoc_x86_64_only

# Start
out/host/linux-x86/bin/launch_cvd --daemon

# Check status
out/host/linux-x86/bin/run_cvd status || cvd status

# Stop
out/host/linux-x86/bin/stop_cvd || cvd stop
```

If you see overlay/runtime errors or "no device":
```bash
cvd stop || true
rm -rf /tmp/cf_avd_* ~/.local/share/cuttlefish*
out/host/linux-x86/bin/launch_cvd --daemon
```

### Cuttlefish Features
- Full Android emulator with Google Play Services
- Hardware acceleration support
- Network connectivity
- Camera and sensor simulation

Validate device visibility:

```bash
adb devices
adb shell getprop ro.build.product
adb shell getprop ro.build.type
```

Expected:
- one device should appear
- product should align with the Cuttlefish Auto target

## 5. Basic Validation Commands

### Check boot completion

```bash
adb shell getprop sys.boot_completed
adb shell getprop dev.bootcomplete
```

Expected:
- both should become `1`

### Capture logs

```bash
mkdir -p "$PROJECT_ROOT/demos/logs"
adb logcat -d > "$PROJECT_ROOT/demos/logs/logcat.txt"
```

### Clear logs before a focused test

```bash
adb logcat -c
```

### Watch live logs for the feature under test

```bash
adb logcat | rg "WearDrive|VehicleContext|SystemServer|Bluetooth|MediaSession"
```

## 6. Stage-by-Stage Commands and Validation

## Stage A: Environment Ready

### Commands

```bash
cd "$PROJECT_ROOT"
source ./scripts/env_aosp16.sh
./scripts/build_aosp16.sh
./scripts/launch_cuttlefish.sh
./scripts/capture_logs.sh
```

### Validate

```bash
adb devices
adb shell getprop sys.boot_completed
```

### Proof to save
- screenshot of running Cuttlefish Auto
- saved `logcat.txt`

## Stage B: Service Registration

This stage starts after adding the first system service skeleton in AOSP.

### Build

```bash
cd "$AOSP_ROOT"
source build/envsetup.sh
lunch "$TARGET_LUNCH"
m -j"$(nproc)" framework services
```

### Boot and inspect service

```bash
adb wait-for-device
adb shell service list | rg -i "weardrive|vehicle"
adb logcat -d | rg "WearDrive|VehicleContext"
```

### Validate
- service name appears in `service list`
- startup logs appear
- no boot loop or system_server crash

### Enterprise advice
- if `system_server` crashes, stop immediately and fix that before adding app code
- never stack multiple unvalidated framework changes together

## Stage C: Framework API and Binder Path

After the manager class and binder path are added:

### Build

```bash
cd "$AOSP_ROOT"
source build/envsetup.sh
lunch "$TARGET_LUNCH"
m -j"$(nproc)" framework services
```

### Validate

```bash
adb logcat -c
adb reboot
adb wait-for-device
adb logcat -d | rg "WearDrive|Binder|SystemServer"
```

Optional validation once a shell command or dumpsys hook exists:

```bash
adb shell dumpsys activity service com.android.systemui 2>/dev/null
adb shell dumpsys | rg -i "weardrive"
```

### Proof to save
- service registration output
- binder startup log

## Stage D: Companion App Skeleton

Once the system app exists:

### Build

```bash
cd "$AOSP_ROOT"
source build/envsetup.sh
lunch "$TARGET_LUNCH"
m -j"$(nproc)" WearDriveCompanion
```

If the app is product-included, rebuild image or relevant target as needed:

```bash
cd "$AOSP_ROOT"
source build/envsetup.sh
lunch "$TARGET_LUNCH"
m -j"$(nproc)"
```

### Launch app

Use the real package and activity once defined:

```bash
adb shell cmd package list packages | rg "weardrive"
adb shell am start -n com.android.weardrive/.MainActivity
```

### Validate
- app launches
- app shows service status
- app handles service unavailable state gracefully

## Stage E: First End-to-End Event

After adding one mock event path:

### Suggested validation strategy
- inject a single event from service-side test hook
- query it from app
- verify logs and visible UI

### Commands

These depend on the hook we add. Recommended patterns:

```bash
adb shell cmd weardrive inject-alert HIGH_PRIORITY_ALERT
adb shell cmd weardrive get-state
adb logcat -d | rg "HIGH_PRIORITY_ALERT|WearDrive"
```

If `cmd weardrive` is not added, use an app debug button first.

### Validate
- one event arrives
- one visible state changes in UI
- logs show input, normalization, and dispatch

## Stage F: Mock Transport

### Commands

Once transport state hooks exist:

```bash
adb shell cmd weardrive transport connect
adb shell cmd weardrive transport status
adb shell cmd weardrive transport disconnect
adb logcat -d | rg "Transport|Pairing|Reconnect|Latency"
```

### Validate
- state changes are visible
- reconnect path is logged
- failure path does not crash the service or app

## Stage G: Media Context

### Commands

Once the media debug hook exists:

```bash
adb shell cmd weardrive media set --title "Demo Track" --artist "WearDrive"
adb shell cmd weardrive media play
adb shell cmd weardrive media pause
adb logcat -d | rg "Media|WearDrive"
```

### Validate
- UI updates quickly
- media action round-trip works
- no transport-specific assumptions leak into media code

## Stage H: Audio Note and AI Summary

### Commands

Suggested command hooks:

```bash
adb shell cmd weardrive voice-note start
adb shell cmd weardrive voice-note stop
adb shell cmd weardrive summary status
adb logcat -d | rg "VoiceNote|Summary|LLM|WearDrive"
```

### Validate
- note flow completes
- summary is returned even with stub provider
- timeout or fallback path is clear

## 7. Full-Stack Coverage Roadmap

You asked to cover the stack from app to kernel and bootloader. That is the right long-term ambition, but the work should be layered carefully.

## Layer 1: App

Where:
- `packages/apps/WearDriveCompanion/`

Goal:
- visible UI, debug panel, feature validation

Validate with:

```bash
adb shell am start -n com.android.weardrive/.MainActivity
adb logcat -d | rg "WearDrive"
```

## Layer 2: Framework API

Where:
- `frameworks/base/core/java/android/weardrive/`

Goal:
- stable manager API and data model

Validate with:
- successful build
- app can call the manager without crash

## Layer 3: System Service

Where:
- `frameworks/base/services/core/java/com/android/server/weardrive/`
- `frameworks/base/services/java/com/android/server/SystemServer.java`

Goal:
- platform-owned state, policy, dispatch

Validate with:

```bash
adb shell service list | rg -i "weardrive"
adb logcat -d | rg "SystemServer|WearDrive"
```

## Layer 4: SELinux and Permissions

Where:
- platform permission XML
- sepolicy paths as needed

Goal:
- production-minded privilege enforcement

Validate with:

```bash
adb logcat -b all -d | rg "avc:|denied"
adb shell dumpsys package com.android.weardrive
```

## Layer 5: Native or System Integration

Where:
- `system/`
- native helpers only if really needed

Goal:
- only if Java framework layers are not sufficient

Validate with:
- focused logs
- no extra complexity unless justified

## Layer 6: Kernel

Where:
- kernel source for the target, only if a real low-level requirement exists

Good reasons to touch kernel:
- custom driver integration
- special input pipeline
- unique power or Bluetooth behavior
- hardware event propagation not achievable above the kernel

Do not touch kernel early for:
- business logic
- transport simulation
- service policy
- demo-only features

Validate with:

```bash
adb shell uname -a
adb shell dmesg | tail -n 100
adb shell dmesg | rg -i "bluetooth|input|audio|error"
```

Enterprise advice:
- kernel work should solve a real system limitation, not just make the project look deeper

## Layer 7: Bootloader

Where:
- bootloader source or boot config flow, usually later and usually hardware-specific

Good reasons to touch bootloader:
- verified boot experiments
- secure feature gating
- early hardware configuration
- chain-of-trust demos

Not recommended for early MVP:
- anything that does not change the user-visible value of the project

Validate with:
- boot success
- boot logs
- no regression in launch flow

Important:
- bootloader work is usually better positioned as an advanced or enterprise-hardening phase, not an MVP requirement

## 8. Feature Validation Template

Use this after every feature:

```text
Feature:
Files changed:
Build command:
Launch command:
Validation command:
Observed result:
Screenshot/log saved at:
Rollback risk:
Next step:
```

Recommended storage:
- `docs/progress/`

## 9. Daily Working Loop

Use this exact loop:

```bash
cd "$AOSP_ROOT"
source build/envsetup.sh
lunch "$TARGET_LUNCH"
```

Then:

1. change one feature
2. build only the needed targets
3. boot or restart as needed
4. run validation commands
5. capture logs
6. write one short progress note

## 10. Production-Minded Advice

- Add debug hooks intentionally, not as permanent architecture.
- Prefer `cmd weardrive ...` or controlled debug surfaces over hardcoded demo shortcuts.
- Add metrics early: event count, dispatch latency, reconnect count, summary latency.
- Make failure visible in UI and logs.
- Keep app, transport, service, and AI provider loosely coupled.
- Push kernel and bootloader work later unless they solve a real product need.
