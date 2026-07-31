| Property | Value |
|----------|-------|
| **Document** | 03-camera-configuration.md |
| **Title** | Camera Configuration |
| **Category** | Configuration |
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

# Camera Configuration

---

## Purpose

This document describes all CCTV cameras connected to the ProPilRybu recording server.

It includes recording parameters, archive locations, integration methods and operational notes.

---

## Scope

This document covers:

- Camera inventory
- Recording configuration
- Video parameters
- Archive locations
- Integration with FFmpeg
- Operational recommendations

---

## Camera Overview

| Camera | Status | Recording | Archive |
|----------|---------|------------|----------|
| Bahus | 🟢 Active | RTSP → FFmpeg | `/home/ftpuser/Videos/Bahus` |
| LaVanda | 🟢 Active | RTSP → FFmpeg | `/home/ftpuser/Videos/LaVanda` |
| Salon | 🟢 Active | RTSP → FFmpeg | `/home/ftpuser/Videos/Salon` |

---

# Bahus

## Status

Active

## Recording

- Source: RTSP
- Recorder: FFmpeg
- Container: MKV
- Codec: HEVC (H.265)

### Video

| Parameter | Value |
|-----------|-------|
| Resolution | 3728×1056 |
| FPS | 12 |
| Codec | HEVC |
| Audio | PCM A-law |

### Archive

```text
/home/ftpuser/Videos/Bahus
```

Recording is organized into video files without transcoding.

---

# LaVanda

## Status

Active

## Recording

- Source: RTSP
- Recorder: FFmpeg
- Container: MKV
- Codec: HEVC (H.265)

### Video

| Parameter | Value |
|-----------|-------|
| Resolution | 2560×1440 |
| FPS | 25 |
| Codec | HEVC |
| Audio | None |

### Archive

```text
/home/ftpuser/Videos/LaVanda
```

The recording system writes completed MKV files directly into the archive directory.

No intermediate processing is performed.

---

# Salon

## Status

Active

## Recording

- Source: RTSP
- Recorder: FFmpeg
- Container: MKV
- Codec: HEVC (H.265)

### Video

| Parameter | Value |
|-----------|-------|
| Resolution | 1920×1080 |
| FPS | 15 |
| Codec | HEVC |
| Audio | AAC |

### Archive

```text
/home/ftpuser/Videos/Salon
```

Recording is continuous and managed by a dedicated systemd service.

---

## Recording Policy

Each camera:

- records independently;
- uses its own archive directory;
- is isolated from other recording services;
- can be restarted independently.

Failure of one camera does not interrupt recording from the others.

---

## Archive Layout

```text
/home/ftpuser/Videos/
│
├── Bahus/
├── LaVanda/
└── Salon/
```

---

## Video Format

Current recording format:

| Parameter | Value |
|-----------|-------|
| Container | MKV |
| Codec | HEVC (H.265) |
| Recording | Direct stream copy |
| Transcoding | Disabled |

The system stores the original camera stream without re-encoding.

---

## Camera Replacement Policy

When replacing a camera, the following requirements should be met:

- RTSP support
- H.265 (HEVC) support
- Stable network connectivity
- Continuous streaming capability
- Compatibility with FFmpeg

ONVIF support is recommended but not mandatory.

---

## Future Improvements

Planned enhancements:

- Camera health monitoring
- Automatic stream verification
- Snapshot generation
- Camera inventory identifiers
- Firmware tracking

---

## Related Documents

| Document | Description |
|----------|-------------|
| 01-server-passport.md | Server Passport |
| 02-system-architecture.md | System Architecture |
| 04-storage.md | Storage |
| 05-services.md | Services |
| 06-scripts.md | Scripts |

---

## Change History

| Version | Date | Description |
|----------|------------|-------------------------------|
| 1.0 | 2026-07-31 | Initial camera configuration document created |
