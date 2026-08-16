| Property         | Value                                 |
| ---------------- | ------------------------------------- |
| **Document**     | 02-system-architecture.md             |
| **Title**        | System Architecture                   |
| **Category**     | Architecture                          |
| **Project**      | ProPilRybu                            |
| **Version**      | 1.1                                   |
| **Status**       | 🟢 Production                         |
| **Owner**        | Domovir                               |
| **Maintainer**   | Domovir                               |
| **Repository**   | https://github.com/Domovir/ProPilRybu |
| **License**      | MIT                                   |
| **Created**      | 2026-07-31                            |
| **Last Updated** | 2026-08-13                            |
| **Reviewed**     | 2026-08-13                            |
| **Next Review**  | 2026-11-13                            |

---

> **This document is part of the official technical documentation of the ProPilRybu project.**

# System Architecture

## Purpose

Describe the current architecture of the ProPilRybu CCTV recording system.

## Scope

This document covers the main system components, recording flow, storage and service architecture.

---

## Architecture Overview

ProPilRybu is an Ubuntu Server based CCTV recording system.

The current architecture uses a single universal RTSP recording engine with separate configuration files for each camera.

---

## Main Components

### Cameras

The system currently records three cameras:

* Bahus
* LaVanda
* Salon

Each camera is recorded by an independent systemd service.

### Recording Engine

The common recording engine is:

```text
/usr/local/bin/record_rtsp.sh
```

Camera-specific settings are stored in:

```text
/etc/propilrybu/
├── bahus.conf
├── lavanda.conf
└── salon.conf
```

The engine uses FFmpeg to receive RTSP streams and store recordings without video transcoding.

### Service Layer

Each camera has its own systemd service:

```text
bahus-rtsp.service
lavanda-rtsp.service
salon-rtsp.service
```

Each service starts the same recording engine with its corresponding configuration file.

This provides independent operation and automatic restart.

---

## Recording Flow

```text
IP Camera
    │
    │ RTSP
    ▼
systemd camera service
    │
    ▼
record_rtsp.sh
    │
    ▼
FFmpeg
    │
    ▼
MKV recording
    │
    ▼
/home/ftpuser/Videos/<Camera>/
```

---

## Storage Architecture

Recordings are stored under:

```text
/home/ftpuser/Videos/
├── Bahus/
├── LaVanda/
└── Salon/
```

Each camera uses a separate archive directory.

Recordings are created as MKV segments with a configured segment duration.

---

## Configuration

Camera configuration is separated from the recording engine.

Example structure:

```text
CAMERA_NAME
RTSP_URL
OUTPUT_DIR
SEGMENT_TIME
USE_WALLCLOCK
```

`USE_WALLCLOCK` controls whether FFmpeg uses wall-clock timestamps for the input stream.

Current configuration:

| Camera  | USE_WALLCLOCK |
| ------- | ------------- |
| Bahus   | 0             |
| LaVanda | 1             |
| Salon   | 1             |

---

## Service Architecture

```text
bahus-rtsp.service
        │
        └── record_rtsp.sh → bahus.conf

lavanda-rtsp.service
        │
        └── record_rtsp.sh → lavanda.conf

salon-rtsp.service
        │
        └── record_rtsp.sh → salon.conf
```

Services run under the `ftpuser` account and are configured for automatic restart.

---

## Archive Management

Archive maintenance is handled separately from the recording engine.

The recording subsystem is responsible for creating video files.

Cleanup and storage management are performed by dedicated maintenance scripts.

This separation prevents archive management logic from being coupled to the recording process.

---

## Design Principles

* One universal recording engine.
* Separate configuration for each camera.
* Independent systemd services.
* Direct RTSP recording.
* No video transcoding.
* Separate camera archives.
* Automatic service restart.
* Separation of recording and archive maintenance.

---

## Related Documents

| Document                              | Description                   |
| ------------------------------------- | ----------------------------- |
| `00-document-template.md`             | Documentation Template        |
| `01-server-passport.md`               | Server Passport               |
| `03-camera-configuration.md`          | Camera Configuration          |
| `04-storage.md`                       | Storage                       |
| `05-services.md`                      | Services                      |
| `06-scripts.md`                       | Scripts                       |
| `07-monitoring.md`                    | Monitoring                    |
| `08-maintenance.md`                   | Maintenance                   |
| `09-disaster-recovery.md`             | Disaster Recovery             |
| `10-architecture-decision-records.md` | Architecture Decision Records |
| `project-status.md`                   | Project Status                |

---

## Change History

| Version | Date       | Description                                                   |
| ------- | ---------- | ------------------------------------------------------------- |
| 1.0     | 2026-07-31 | Initial architecture document created.                        |
| 1.1     | 2026-08-13 | Architecture updated for the universal RTSP recording engine. |
