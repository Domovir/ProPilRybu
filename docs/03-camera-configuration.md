# Camera Configuration

| Property | Value |
|----------|-------|
| **Document** | 03-camera-configuration.md |
| **Title** | Camera Configuration |
| **Category** | Configuration |
| **Project** | ProPilRybu |
| **Version** | 1.1 |
| **Status** | 🟢 Production |
| **Owner** | Domovir |
| **Maintainer** | Domovir |
| **Repository** | https://github.com/Domovir/ProPilRybu |
| **License** | MIT |
| **Created** | 2026-07-31 |
| **Last Updated** | 2026-09-14 |
| **Reviewed** | 2026-09-14 |
| **Next Review** | 2026-12-14 |

> **This document is part of the official technical documentation of the ProPilRybu project.**

---

# Camera Configuration

## Purpose

This document describes the current CCTV camera configuration used by ProPilRybu.

It defines camera sources, recording parameters, configuration files and archive locations.

---

## Scope

This document covers:

- Camera inventory
- RTSP sources
- Recording parameters
- Universal recording engine
- Camera configuration files
- Archive locations
- Operational configuration

---

## Camera Overview

| Camera | Status | Source | Recorder | Archive |
|--------|--------|--------|----------|---------|
| Bahus | 🟢 Active | RTSP | `record_rtsp.sh` | `/home/ftpuser/Videos/Bahus` |
| LaVanda | 🟢 Active | RTSP | `record_rtsp.sh` | `/home/ftpuser/Videos/LaVanda` |
| Salon | 🟢 Active | RTSP | `record_rtsp.sh` | `/home/ftpuser/Videos/Salon` |

---

# Universal Recording Engine

## Recorder

    /usr/local/bin/record_rtsp.sh

Current version:

    record_rtsp.sh 1.4

The same recording engine is used by all production camera services.

---

## Configuration Directory

Camera-specific configuration files are stored in:

    /etc/propilrybu/

Current production configurations:

    /etc/propilrybu/bahus.conf
    /etc/propilrybu/lavanda.conf
    /etc/propilrybu/salon.conf

Test configuration:

    /etc/propilrybu/test.conf

Credentials are stored only in the corresponding configuration files and are not documented here.

---

# Camera Parameters

## Bahus

### Configuration

    /etc/propilrybu/bahus.conf

### Recording

| Parameter | Value |
|-----------|-------|
| Camera | Bahus |
| Source | RTSP |
| Container | MKV |
| Codec | HEVC (H.265) |
| Segment time | 300 seconds |
| Wallclock timestamps | Disabled |
| Transcoding | Disabled |
| Output | `/home/ftpuser/Videos/Bahus` |

### RTSP

The RTSP source is configured in:

    /etc/propilrybu/bahus.conf

Credentials are not stored in documentation.

---

# LaVanda

## Configuration

    /etc/propilrybu/lavanda.conf

### Recording

| Parameter | Value |
|-----------|-------|
| Camera | LaVanda |
| Source | RTSP |
| Container | MKV |
| Codec | HEVC (H.265) |
| Segment time | 300 seconds |
| Wallclock timestamps | Enabled |
| Transcoding | Disabled |
| Output | `/home/ftpuser/Videos/LaVanda` |

### RTSP

The RTSP source is configured in:

    /etc/propilrybu/lavanda.conf

Credentials are not stored in documentation.

---

# Salon

## Configuration

    /etc/propilrybu/salon.conf

### Recording

| Parameter | Value |
|-----------|-------|
| Camera | Salon |
| Source | RTSP |
| Container | MKV |
| Codec | HEVC (H.265) |
| Segment time | 300 seconds |
| Wallclock timestamps | Enabled |
| Transcoding | Disabled |
| Output | `/home/ftpuser/Videos/Salon` |

### RTSP

The RTSP source is configured in:

    /etc/propilrybu/salon.conf

Credentials are not stored in documentation.

---

# Configuration Parameters

The universal recorder supports the following camera configuration parameters:

| Parameter | Description |
|-----------|-------------|
| `CAMERA_NAME` | Camera identifier |
| `RTSP_URL` | RTSP source URL |
| `OUTPUT_DIR` | Archive directory |
| `SEGMENT_TIME` | Segment duration in seconds |
| `LOG_LEVEL` | FFmpeg logging level |
| `FFMPEG_BIN` | FFmpeg executable |
| `USE_WALLCLOCK` | Wallclock timestamp mode |

---

## Current Wallclock Configuration

| Camera | `USE_WALLCLOCK` |
|--------|-----------------|
| Bahus | `0` |
| LaVanda | `1` |
| Salon | `1` |

Wallclock mode is enabled for LaVanda and Salon.

---

# Recording Format

All production cameras currently use:

    Container: MKV
    Codec: HEVC (H.265)
    Recording: Direct stream copy
    Transcoding: Disabled
    Segment time: 300 seconds

The original camera stream is stored without video re-encoding.

---

# Archive Layout

    /home/ftpuser/Videos/
    ├── Bahus/
    ├── LaVanda/
    └── Salon/

Each camera uses an independent archive directory.

---

# Service Integration

Each production camera is managed by a separate systemd service.

    bahus-rtsp.service
            │
            └── record_rtsp.sh
                    └── bahus.conf

    lavanda-rtsp.service
            │
            └── record_rtsp.sh
                    └── lavanda.conf

    salon-rtsp.service
            │
            └── record_rtsp.sh
                    └── salon.conf

Each service can be started, stopped and restarted independently.

Failure of one camera service does not directly stop the other camera services.

---

# Operational Rules

1. Camera credentials must not be stored in documentation.
2. Camera-specific parameters must be changed in `/etc/propilrybu/*.conf`.
3. Production camera services must use the universal recording engine.
4. Each camera service must use its corresponding configuration file.
5. Archive directories must remain separate for each camera.
6. Configuration changes must be tested before production deployment.

---

# Test Configuration

A separate test configuration is available:

    /etc/propilrybu/test.conf

Output directory:

    /home/ftpuser/Videos/Test

The test configuration must not be used by production camera services.

---

# Camera Replacement Requirements

A replacement camera should provide:

- RTSP support
- HEVC (H.265) support where required
- Stable continuous streaming
- Network connectivity suitable for continuous recording
- Compatibility with FFmpeg

ONVIF support is recommended but not mandatory.

---

# Related Documents

| Document | Description |
|----------|-------------|
| `00-document-template.md` | Documentation Template |
| `01-server-passport.md` | Server Passport |
| `02-system-architecture.md` | System Architecture |
| `04-storage.md` | Storage |
| `05-services.md` | Services |
| `06-scripts.md` | Scripts |
| `07-monitoring.md` | Monitoring |

---

# Change History

| Version | Date | Description |
|---------|------------|-------------|
| 1.0 | 2026-07-31 | Initial camera configuration document created |
| 1.1 | 2026-09-14 | Updated for universal recording engine and current production configuration |