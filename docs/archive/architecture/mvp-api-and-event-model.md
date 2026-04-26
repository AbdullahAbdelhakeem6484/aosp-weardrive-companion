# WearDrive Companion MVP API and Event Model

This document defines the first implementation contract so we can start coding quickly without over-designing.

## 1. MVP Scope

The first MVP should support:
- service registration
- current state query
- alert delivery
- media context delivery
- one user action path
- one voice-note summary result path

## 2. Recommended AOSP Locations

Framework API:
- `frameworks/base/core/java/android/weardrive/`

System service:
- `frameworks/base/services/core/java/com/android/server/weardrive/`

System server registration:
- `frameworks/base/services/java/com/android/server/SystemServer.java`

Privileged app:
- `packages/apps/WearDriveCompanion/`

## 3. First Manager API

Recommended manager responsibilities:
- fetch current state
- register listener
- unregister listener
- acknowledge alert
- start voice note

Example starter shape:

```java
package android.weardrive;

public final class WearDriveManager {
    public WearDriveState getCurrentState() { return null; }
    public void registerListener(WearDriveListener listener) {}
    public void unregisterListener(WearDriveListener listener) {}
    public void acknowledgeAlert(String alertId) {}
    public void startVoiceNote() {}
}
```

Production advice:
- keep transport-specific concepts out of this API
- keep the first API small
- avoid premature public SDK exposure

## 4. First Data Model

Recommended MVP objects:
- `WearDriveState`
- `WearDriveEvent`
- `WearDriveMediaContext`
- `WearDriveAlert`
- `WearDriveSummary`

Example state shape:

```java
package android.weardrive;

public final class WearDriveState {
    public String tripState;
    public WearDriveAlert activeAlert;
    public WearDriveMediaContext mediaContext;
    public WearDriveSummary latestSummary;
}
```

## 5. First Event Types

Use explicit constants:

```java
package android.weardrive;

public final class WearDriveEventType {
    public static final int TRIP_STARTED = 1;
    public static final int TRIP_ENDED = 2;
    public static final int HIGH_PRIORITY_ALERT = 3;
    public static final int MEDIA_CONTEXT_UPDATED = 4;
    public static final int VOICE_NOTE_SUMMARY_READY = 5;

    private WearDriveEventType() {}
}
```

## 6. First Listener Interface

```java
package android.weardrive;

public interface WearDriveListener {
    void onStateChanged(WearDriveState state);
    void onEvent(WearDriveEvent event);
}
```

## 7. First Service Responsibilities

`WearDriveService` should own:
- current platform state
- listener registration
- event normalization
- permission enforcement
- dispatch to clients

It should not own:
- UI formatting
- hardcoded transport implementation details
- app-only debug presentation logic

## 8. Starter Service Skeleton

```java
package com.android.server.weardrive;

import android.content.Context;
import android.util.Slog;

public final class WearDriveService {
    private static final String TAG = "WearDriveService";
    private final Context mContext;

    public WearDriveService(Context context) {
        mContext = context;
    }

    public void onStart() {
        Slog.i(TAG, "WearDriveService starting");
    }
}
```

## 9. First Permission Model

Recommended initial approach:
- privileged or signature permission only
- no third-party app access in MVP

Example concept:
- `android.permission.ACCESS_WEARDRIVE_SERVICE`

Production advice:
- start tighter, relax later if needed
- permission design is part of product credibility

## 10. First Validation Scenario

The very first end-to-end scenario should be:

1. system boots
2. `WearDriveService` starts
3. app connects through `WearDriveManager`
4. one mock `HIGH_PRIORITY_ALERT` is injected
5. app displays alert state
6. user acknowledges alert
7. service logs state transition

If this works, the architecture is real enough to extend.
