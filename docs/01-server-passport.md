---
Document: 01-server-passport.md
Title: Server Passport
Category: Documentation
Project: ProPilRybu
Version: 1.0
Status: Production
Owner: Domovir
Repository: https://github.com/Domovir/ProPilRybu
Created: 2026-07-31
Last Updated: 2026-07-31
Reviewed: —
Next Review: 2026-10-31
---

# Server Passport

# Purpose

This document describes the current production configuration of the ProPilRybu CCTV server.

It serves as the primary reference for system administration, maintenance, troubleshooting and future upgrades.

---

# System Overview

| Parameter        | Value                 |
| ---------------- | --------------------- |
| Project          | ProPilRybu            |
| Role             | CCTV Recording Server |
| Operating System | Ubuntu Server         |
| Status           | Production            |
| Availability     | 24×7                  |
| Recording Method | RTSP + FFmpeg         |
| Archive Format   | MKV                   |
| Video Codec      | H.265 (HEVC)          |
| Repository       | GitHub (Public)       |

---

# Server

## Hostname

```text
propilribu
```

## Main User

```text
ubuntu
```

---

# Storage

## Archive Location

```text
/home/ftpuser/Videos
```

## Storage Device

```text
/dev/sdb
```

## Filesystem

Ext4

---

## Current Capacity

| Parameter  |   Value |
| ---------- | ------: |
| Total Size | ~148 GB |
| Used       |  ~84 GB |
| Available  |  ~64 GB |
| Usage      |    ~58% |

---

# Cameras

## Bahus

| Parameter     | Value                        |
| ------------- | ---------------------------- |
| Recording     | RTSP                         |
| Output Format | MKV                          |
| Video Codec   | HEVC                         |
| Audio Codec   | PCM A-law                    |
| Archive Path  | `/home/ftpuser/Videos/Bahus` |

---

## LaVanda

| Parameter     | Value                          |
| ------------- | ------------------------------ |
| Recording     | RTSP                           |
| Output Format | MKV                            |
| Video Codec   | HEVC                           |
| Archive Path  | `/home/ftpuser/Videos/LaVanda` |

---

## Salon

| Parameter     | Value                        |
| ------------- | ---------------------------- |
| Recording     | RTSP                         |
| Output Format | MKV                          |
| Video Codec   | HEVC                         |
| Audio Codec   | AAC                          |
| Archive Path  | `/home/ftpuser/Videos/Salon` |

---

# Recording Services

Each camera runs as an independent service.

Advantages:

* Independent operation
* Automatic restart
* Isolation between cameras
* Simplified maintenance

---

# Archive Cleanup

Cleanup Script

```text
/usr/local/bin/cctv_cleanup.sh
```

Log File

```text
/var/log/cctv_cleanup.log
```

Current Configuration

```bash
START_LIMIT=90
TARGET_LIMIT=85
```

Cleanup strategy:

* Monitor disk usage.
* Start cleanup at 90%.
* Remove the oldest completed recordings.
* Stop cleanup when usage reaches 85%.
* Delete empty directories.
* Remove stale zero-byte MKV files older than 5 minutes.
* Send email notifications before and after cleanup.

---

# Monitoring

Current monitoring includes:

* Disk usage
* Cleanup logging
* Email notifications
* Automatic service restart (systemd)

---

# Documentation

Project documentation is stored in:

```text
docs/
```

---

# Repository

Project repository:

```text
https://github.com/Domovir/ProPilRybu
```

---

# Current Project Status

## Completed

* Ubuntu Server installed
* FFmpeg configured
* Three cameras recording
* Automatic archive cleanup
* Email notifications
* Archive storage expanded to approximately 150 GB
* Repository structure created
* Initial documentation started

---

## In Progress

* Complete technical documentation
* Architecture documentation
* Monitoring documentation

---

## Planned

* Telegram notifications
* Backup strategy
* Health dashboard
* Recovery documentation
* Additional monitoring

---

# System Baseline (2026-07-31)

This document represents the baseline configuration of the production CCTV server after expanding the archive storage from approximately 100 GB to approximately 150 GB.

This baseline serves as the reference point for future upgrades, maintenance and architectural decisions.

---

# Change History

| Version | Date       | Description                     |
| ------- | ---------- | ------------------------------- |
| 1.0     | 2026-07-31 | Initial server passport created |

