| Property | Value |
|----------|-------|
| **Document** | 02-system-architecture.md |
| **Title** | System Architecture |
| **Category** | Architecture |
| **Project** | ProPilRybu |
| **Version** | 1.0 |
| **Status** | 🟢 Production |
| **Owner** | Domovir |
| **Maintainer** | Domovir |
| **Repository** | https://github.com/Domovir/ProPilRybu |
| **License** | MIT |
| **Created** | 2026-07-31 |
| **Last Updated** | 2026-07-31 |
| **Reviewed** | — |
| **Next Review** | 2026-10-31 |

> **This document is part of the official technical documentation of the ProPilRybu project.**

# System Architecture

---

## Purpose

This document describes the overall architecture of the ProPilRybu CCTV recording system.

It explains how system components interact, how video data flows through the platform, and the architectural principles used to ensure reliability, maintainability, and continuous operation.

---

## Scope

This document covers:

- Overall system architecture
- Video recording workflow
- Storage architecture
- Background services
- Monitoring
- Archive management
- Design principles

---

## Architecture Overview

The ProPilRybu platform is designed as a modular CCTV recording system based on Ubuntu Server and open-source technologies.

Each subsystem has a single responsibility and communicates through well-defined interfaces.

Main architectural goals:

- Continuous 24×7 operation
- Fault isolation
- Simple maintenance
- Automatic recovery
- Minimal dependencies
- High reliability

---

## High-Level Architecture

```text
                +----------------------+
                |      IP Cameras      |
                +----------+-----------+
                           |
                           | RTSP
                           v
                +----------------------+
                |        FFmpeg        |
                | Recording Services   |
                +----------+-----------+
                           |
                           | MKV files
                           v
                +----------------------+
                | Video Archive        |
                | /home/ftpuser/Videos |
                +----------+-----------+
                           |
         +-----------------+-----------------+
         |                                   |
         v                                   v
+---------------------+           +----------------------+
| Cleanup Script      |           | Monitoring           |
| cctv_cleanup.sh     |           | Logs / Email         |
+----------+----------+           +----------+-----------+
           |                                 |
           +-----------------+---------------+
                             |
                             v
                  System Administration
```

---

## System Components

### Cameras

The system currently records video from three independent cameras.

- Bahus
- LaVanda
- Salon

Each camera records independently.

A failure of one camera does not interrupt recording from the others.

---

### Recording Layer

Recording is performed using FFmpeg.

Characteristics:

- Direct RTSP recording
- No video transcoding
- HEVC (H.265) preserved
- MKV container
- Independent recording processes
- Automatic restart through systemd

---

### Storage Layer

Video files are stored on a dedicated storage volume.

Archive location:

```text
/home/ftpuser/Videos
```

Current layout:

```text
Videos/
├── Bahus/
├── LaVanda/
└── Salon/
```

Each camera stores recordings in its own directory.

---

### Archive Management

Archive cleanup is performed automatically.

Current policy:

- Start cleanup at 90% disk usage.
- Stop cleanup at 85%.
- Delete the oldest completed recordings first.
- Never remove active recordings.
- Remove empty directories.
- Remove stale zero-byte MKV files.

---

### Monitoring

Current monitoring includes:

- Disk usage
- Cleanup logs
- Email notifications
- Service status

Future improvements:

- Telegram notifications
- Dashboard
- Health monitoring
- Metrics collection

---

## Design Principles

The architecture follows these principles:

### Reliability

Recording must continue even if one subsystem fails.

---

### Simplicity

The system avoids unnecessary complexity.

---

### Isolation

Each recording service operates independently.

---

### Automation

Routine maintenance is fully automated whenever possible.

---

### Recoverability

All critical services restart automatically after failures.

---

### Documentation

Every significant architectural decision must be documented.

---

## Data Flow

```text
RTSP Camera
      │
      ▼
FFmpeg Recorder
      │
      ▼
MKV File
      │
      ▼
Archive Storage
      │
      ▼
Disk Usage Monitoring
      │
      ▼
Automatic Cleanup
      │
      ▼
Email Notification
```

---

## Technology Stack

| Layer | Technology |
|--------|------------|
| Operating System | Ubuntu Server |
| Recording | FFmpeg |
| Streaming | RTSP |
| Video Codec | H.265 (HEVC) |
| Container | MKV |
| Service Manager | systemd |
| Automation | Bash |
| Notifications | Python |
| Version Control | Git |
| Repository | GitHub |

---

## Future Architecture

Planned improvements:

- Telegram notifications
- Central monitoring dashboard
- Backup automation
- Health checks
- Metrics collection
- Additional cameras
- Configuration management

---

## Related Documents

| Document | Description |
|----------|-------------|
| 01-server-passport.md | Server Passport |
| 03-camera-configuration.md | Camera Configuration |
| 04-storage.md | Storage |
| 05-services.md | Services |
| 06-scripts.md | Scripts |
| 07-monitoring.md | Monitoring |
| 08-maintenance.md | Maintenance |
| 09-disaster-recovery.md | Disaster Recovery |
| 10-architecture-decision-records.md | Architecture Decision Records |

---

## Change History

| Version | Date | Description |
|----------|------------|-------------------------------|
| 1.0 | 2026-07-31 | Initial architecture document created |