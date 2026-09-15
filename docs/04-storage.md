# Storage

| Property | Value |
|----------|-------|
| **Document** | 04-storage.md |
| **Title** | Storage |
| **Category** | Infrastructure |
| **Project** | ProPilRybu |
| **Version** | 1.1 |
| **Status** | 🟢 Production |
| **Owner** | Domovir |
| **Maintainer** | Domovir |
| **Repository** | https://github.com/Domovir/ProPilRybu |
| **License** | MIT |
| **Created** | 2026-07-31 |
| **Last Updated** | 2026-09-15 |
| **Reviewed** | 2026-09-15 |
| **Next Review** | 2026-12-15 |

> **This document is part of the official technical documentation of the ProPilRybu project.**

---

# Storage

## Purpose

This document describes the storage subsystem used by the ProPilRybu CCTV recording server.

It defines the storage device, filesystem, archive layout, capacity management and maintenance procedures.

---

## Scope

This document covers:

- Storage architecture
- Archive volume
- Filesystem
- Archive layout
- Capacity management
- Automatic cleanup
- Storage expansion
- Maintenance

---

## Storage Overview

The ProPilRybu recording server stores CCTV archives on a dedicated storage volume separate from the operating system volume.

This separation allows the archive storage to be managed and expanded independently from the operating system.

---

## Storage Device

| Property | Value |
|----------|-------|
| Device | `/dev/sdb` |
| Mount Point | `/home/ftpuser/Videos` |
| Filesystem | ext4 |
| Current Capacity | Approximately 150 GB |
| Storage Type | Dedicated Block Volume |

The archive volume is mounted at:

    /home/ftpuser/Videos

---

## Storage Layout

    /home/ftpuser/Videos/
    ├── Bahus/
    ├── LaVanda/
    └── Salon/

Each production camera uses a separate archive directory.

---

## Archive Organization

The archive is organized by camera.

Production recordings are stored as MKV files.

Typical layout:

    /home/ftpuser/Videos/
    ├── Bahus/
    │   └── *.mkv
    │
    ├── LaVanda/
    │   └── *.mkv
    │
    └── Salon/
        └── *.mkv

The exact filename and timestamp structure is controlled by the universal recording engine.

---

# Recording Format

| Property | Value |
|----------|-------|
| Container | MKV |
| Video Codec | HEVC (H.265) |
| Recording Method | Direct stream copy |
| Transcoding | Disabled |
| Segment Duration | 300 seconds |

The original camera stream is stored without video re-encoding.

---

# Capacity Management

The archive volume is protected from becoming completely full by automatic cleanup.

Current cleanup thresholds:

| Parameter | Value |
|-----------|-------|
| Cleanup Start | 90% |
| Cleanup Target | 85% |

When disk usage reaches the configured start threshold, the cleanup process removes the oldest eligible recordings until the target level is reached.

Active recordings must not be deleted.

---

## Cleanup

The primary cleanup script is:

    /usr/local/bin/cctv_cleanup.sh

Cleanup log:

    /var/log/cctv_cleanup.log

The cleanup process is responsible for managing archive growth.

Current cleanup functions include:

- monitoring archive disk usage;
- removing old recordings when the threshold is reached;
- protecting active recordings;
- removing stale zero-byte MKV files;
- maintaining the archive within the configured capacity limits;
- logging cleanup operations.

---

# Storage Expansion

The archive storage is implemented as a separate block volume and supports capacity expansion.

The volume was expanded from approximately 100 GB to approximately 150 GB.

The filesystem was expanded online using:

    sudo resize2fs /dev/sdb

The resulting filesystem capacity is approximately 150 GB.

---

# Current Capacity State

The archive volume currently provides approximately:

| Parameter | Value |
|-----------|-------|
| Total | 148 GB |
| Used | 84 GB |
| Available | 64 GB |
| Usage | 57% |

Mount point:

    /home/ftpuser/Videos

The values above represent the latest confirmed storage state available for this documentation.

---

# Monitoring

Storage condition is monitored through:

- filesystem usage;
- cleanup script;
- cleanup log;
- email notifications;
- archive growth checks.

Primary monitoring log:

    /var/log/cctv_cleanup.log

Storage checks can be performed with:

    df -h /home/ftpuser/Videos

Filesystem information can be checked with:

    df -T /home/ftpuser/Videos

---

# Maintenance

Routine storage maintenance includes:

- checking available disk space;
- monitoring cleanup activity;
- checking archive growth by camera;
- verifying recording continuity;
- checking for stale or zero-byte files;
- verifying that the archive volume is mounted correctly.

Recommended archive size checks:

    sudo du -sh /home/ftpuser/Videos/Bahus
    sudo du -sh /home/ftpuser/Videos/LaVanda
    sudo du -sh /home/ftpuser/Videos/Salon

---

# Operational Rules

1. CCTV archives must be stored on the dedicated archive volume.
2. The archive mount point must remain `/home/ftpuser/Videos`.
3. Each production camera must use its own archive directory.
4. Cleanup must not delete active recordings.
5. Storage cleanup thresholds must remain controlled by the central cleanup script.
6. Manual deletion of active recording files should be avoided.
7. Storage expansion must preserve the existing archive data and filesystem.
8. Changes to storage configuration must be verified after deployment.

---

# Storage Failure Considerations

If the archive volume is unavailable, recording services may fail to write new video files.

After a storage failure or reboot, verify:

    df -h /home/ftpuser/Videos

and:

    mount | grep /home/ftpuser/Videos

Recording services should be checked after confirming that the archive volume is available.

---

# Future Improvements

Potential future enhancements:

- larger archive volume;
- archive retention statistics;
- automatic storage usage reports;
- archive integrity verification;
- improved storage health monitoring;
- optional backup integration.

---

# Related Documents

| Document | Description |
|----------|-------------|
| `00-document-template.md` | Documentation Template |
| `01-server-passport.md` | Server Passport |
| `02-system-architecture.md` | System Architecture |
| `03-camera-configuration.md` | Camera Configuration |
| `05-services.md` | Services |
| `06-scripts.md` | Scripts |
| `07-monitoring.md` | Monitoring |

---

# Change History

| Version | Date | Description |
|---------|------------|-------------|
| 1.0 | 2026-07-31 | Initial storage documentation created |
| 1.1 | 2026-09-15 | Updated storage configuration, capacity state and cleanup architecture |