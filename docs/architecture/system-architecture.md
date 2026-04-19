# WearDrive Companion Architecture

## 1. Scope

WearDrive Companion is a cross-device AOSP reference architecture connecting a vehicle-context Android platform service to a wearable companion experience.

## 2. Component View

```mermaid
flowchart LR
    A[Vehicle Event Source\nMock AAOS data or scripted injector] --> B[VehicleContextService\nSystem Server]
    B --> C[WearDriveManager API\nFramework layer]
    C --> D[Privileged Companion App\nSystem app]
    D --> E[Transport Adapter\nMock BLE or local socket]
    E --> F[Wear UI Endpoint\nWatch-style surface or simulator]
    D --> G[Audio Note Module]
    G --> H[AI Adapter]
    H --> I[Stub / Cloud / Local LLM Service]
    B --> J[Media Sync State]
    J --> D
    B --> K[Event Clip Metadata]
    K --> D
```

## 3. AOSP Integration Boundaries

### Inside `aosp16`
- `frameworks/base/`:
  - AIDL definitions
  - manager class
  - service registration hooks
  - permissions and hidden API surface
- `frameworks/base/services/`:
  - `VehicleContextService`
  - policy handling
  - event store
- `packages/apps/`:
  - `WearDriveCompanion` privileged app
- product or device config:
  - package inclusion
  - permission XML
  - optional feature flags

### Outside `aosp16`
- architecture docs
- helper scripts
- standalone transport prototypes
- AI adapter experiments
- course content
- demo and recording plans

## 4. Main Runtime Flows

### Alert Sync Flow

```mermaid
sequenceDiagram
    participant Injector as Event Injector
    participant Service as VehicleContextService
    participant Manager as WearDriveManager
    participant App as Companion App
    participant Transport as Transport Adapter
    participant Wear as Wear Endpoint

    Injector->>Service: publishAlert(event)
    Service->>Service: normalize and store
    Service-->>App: callback / state update
    App->>Transport: send alert payload
    Transport->>Wear: deliver message
    Wear-->>App: ack / action
    App->>Service: perform action or dismiss
```

### Audio Summary Flow

```mermaid
sequenceDiagram
    participant User
    participant App as Companion App
    participant Audio as Audio Note Module
    participant AI as AI Adapter
    participant Provider as Stub or LLM Provider

    User->>App: record voice note
    App->>Audio: capture audio
    Audio->>AI: request transcription and summary
    AI->>Provider: summarize(audio or transcript)
    Provider-->>AI: response
    AI-->>App: structured summary
```

## 5. Feasibility Notes

### Feasible now
- service creation in AOSP 16
- system app with privileged permission model
- mock transport
- scripted event injection
- media and alert sync demo
- host-side AI service integration

### Simulated
- BLE pairing and radio behavior
- watch-specific UX constraints
- live dashcam or camera feeds

### Later with hardware
- real watch communication
- full Bluetooth validation
- real audio routing edge cases
- low-level power and radio performance testing
