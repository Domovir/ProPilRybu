| Property | Value |
|----------|-------|
| **Document** | 04-storage.md |
| **Title** | Storage |
| **Category** | Infrastructure |
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

# Storage

---

## Purpose

This document describes the storage subsystem used by the ProPilRybu CCTV recording server.

It includes storage architecture, archive organization, capacity management, automatic cleanup policies and operational recommendations.

---

## Scope

This document covers:

- Storage architecture
- Video archive layout
- Filesystem
- Disk capacity
- Archive cleanup
- Storage maintenance
- Future scalability

---

## Storage Overview

The ProPilRybu recording server stores all video archives on a dedicated storage volume mounted separately from the operating system.

This design improves reliability, simplifies maintenance and allows storage expansion without affecting system operation.

---

## Storage Device

| Property | Value |
|----------|-------|
| Device | `/dev/sdb` |
| Mount Point | `/home/ftpuser/Videos` |
| Filesystem | ext4 |
| Current Capacity | Approximately 150 GB |
| Storage Type | Dedicated Block Volume |

---

## Current Storage Layout

```text
/home/ftpuser/Videos/
│
├── Bahus/
├── LaVanda/
└── Salon/
```

Each camera stores its recordings in an independent directory.

This separation simplifies maintenance and archive management.

---

## Archive Organization

The archive is organized by camera.

Each recording is stored as an individual MKV file.

Typical structure:

```text
Videos/
├── Bahus/
│   ├── video_YYYYMMDD_HHMMSS.mkv
│   └── ...
│
├── LaVanda/
│   ├── video_YYYYMMDD_HHMMSS.mkv
│   └── ...
│
└── Salon/
    ├── video_YYYYMMDD_HHMMSS.mkv
    └── ...
```

---

## Recording Format

| Property | Value |
|----------|-------|
| Container | MKV |
| Video Codec | HEVC (H.265) |
| Recording Method | Direct stream copy |
| Transcoding | Disabled |

The original camera stream is stored without re-encoding to preserve quality and minimize CPU usage.

---

## Capacity Management

The storage subsystem continuously monitors available disk space.

Automatic cleanup prevents the archive volume from becoming full.

Current cleanup policy:

| Parameter | Value |
|-----------|-------|
| Cleanup Start | 90% |
| Cleanup Target | 85% |

When disk usage reaches the configured threshold:

- the oldest completed recordings are removed;
- active recordings are never deleted;
- empty directories are removed automatically;
- stale zero-byte MKV files are removed.

---

## Storage Expansion

The storage architecture supports online capacity expansion.

Current expansion history:

| Date | Action |
|------|--------|
| 2026-07 | Block volume expanded from approximately 100 GB to approximately 150 GB |

Filesystem expansion was completed online using:

```bash
sudo resize2fs /dev/sdb
```

No interruption to video recording occurred during the expansion.

---

## Monitoring

Storage health is monitored through:

- disk usage;
- cleanup log;
- automatic cleanup script;
- email notifications.

Current log file:

```text
/var/log/cctv_cleanup.log
```

---

## Maintenance

Routine storage maintenance includes:

- verifying available disk space;
- monitoring cleanup logs;
- checking archive growth;
- removing empty directories;
- validating recording continuity.

---

## Design Principles

The storage subsystem follows these principles:

- dedicated storage volume;
- simple directory hierarchy;
- independent camera archives;
- automatic capacity management;
- online scalability;
- minimal administrative intervention.

---

## Future Improvements

Potential future enhancements:

- larger storage volume;
- archive retention statistics;
- storage usage reports;
- automatic archive integrity verification;
- optional backup integration.

---

## Related Documents

| Document | Description |
|----------|-------------|
| 01-server-passport.md | Server Passport |
| 02-system-architecture.md | System Architecture |
| 03-camera-configuration.md | Camera Configuration |
| 05-services.md | Services |
| 06-scripts.md | Automation Scripts |
| 07-monitoring.md | Monitoring |

---

## Change History

| Version | Date | Description |
|----------|------------|-------------------------------|
| 1.0 | 2026-07-31 | Initial storage documentation created |
