| Property | Value |
|----------|-------|
| **Document** | 09-disaster-recovery.md |
| **Title** | Disaster Recovery |
| **Category** | Operations |
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

# Disaster Recovery

---

## Purpose

This document defines the recovery procedures for the ProPilRybu CCTV recording server following hardware failures, software failures or operational incidents.

The objective is to restore recording services safely and as quickly as possible.

---

## Scope

This document covers:

- Recording service failures
- Camera connection failures
- Storage failures
- Disk capacity issues
- Server reboot
- Power outages
- System verification after recovery

---

# Recovery Principles

The recovery process follows these principles:

- Protect existing recordings.
- Restore recording services first.
- Verify archive integrity.
- Confirm continuous recording.
- Document significant incidents.

---

# Incident Classification

| Severity | Description |
|----------|-------------|
| Low | Single service interruption |
| Medium | Camera unavailable |
| High | Storage unavailable |
| Critical | Complete server failure |

---

# Scenario 1 — Recording Service Stopped

## Symptoms

- No new recordings.
- Service reported as inactive.

## Diagnosis

```bash
systemctl status bahus-rtsp
systemctl status lavanda-rtsp
systemctl status salon-rtsp
```

View service logs:

```bash
journalctl -u bahus-rtsp -n 50
```

## Recovery

Restart the affected service:

```bash
sudo systemctl restart bahus-rtsp
```

Repeat for the appropriate recording service.

Verify:

```bash
systemctl status bahus-rtsp
```

Confirm that new video files are being created.

---

# Scenario 2 — Camera Not Reachable

## Symptoms

- FFmpeg reconnect attempts.
- Missing recordings.

## Diagnosis

Check network connectivity.

Verify camera availability.

Inspect watchdog logs.

## Recovery

- Restore network connectivity.
- Restart the recording service if necessary.
- Confirm that recording resumes.

---

# Scenario 3 — Storage Nearly Full

## Symptoms

```text
Disk usage above cleanup threshold.
```

## Diagnosis

```bash
df -h /home/ftpuser/Videos
```

Review cleanup activity:

```bash
tail -50 /var/log/cctv_cleanup.log
```

## Recovery

Verify that:

- cleanup script is running;
- old recordings are being removed;
- free space increases.

Manual cleanup should only be performed if the automated process has failed.

---

# Scenario 4 — Cleanup Script Failure

## Symptoms

- Disk usage continues increasing.
- Cleanup log shows errors.

## Diagnosis

```bash
tail -100 /var/log/cctv_cleanup.log
```

Verify script permissions.

Check available storage.

## Recovery

Correct the detected issue.

Run the cleanup script manually:

```bash
sudo /usr/local/bin/cctv_cleanup.sh
```

Confirm successful completion.

---

# Scenario 5 — Server Reboot

After a planned or unplanned reboot:

Verify recording services:

```bash
systemctl status bahus-rtsp
systemctl status lavanda-rtsp
systemctl status salon-rtsp
```

Verify watchdog:

```bash
systemctl status rtsp-watchdog.timer
```

Confirm that new recordings are being created.

---

# Scenario 6 — Power Failure

Following restoration of power:

1. Verify system startup.
2. Confirm storage is mounted.
3. Verify recording services.
4. Verify watchdog timer.
5. Confirm archive growth.

---

# Scenario 7 — Storage Expansion

Storage expansion should follow this sequence:

1. Extend the block storage.
2. Verify the operating system detects the new capacity.
3. Expand the filesystem.

Example:

```bash
sudo resize2fs /dev/sdb
```

Verify:

```bash
df -h
```

Recording services should remain operational throughout the procedure whenever possible.

---

# Post-Recovery Verification

After every recovery operation verify:

- all recording services are active;
- watchdog timer is operational;
- storage is mounted;
- new recordings are created;
- cleanup logs contain no errors;
- disk usage is within normal limits.

---

# Recovery Checklist

| Item | Status |
|------|--------|
| Recording services running | □ |
| Cameras accessible | □ |
| Storage mounted | □ |
| Archive growing | □ |
| Watchdog active | □ |
| Cleanup operational | □ |
| Email notifications functioning | □ |

---

# Operational Recommendations

During recovery:

- avoid unnecessary reboots;
- restart only affected services;
- preserve existing recordings;
- verify operation before closing the incident;
- record significant recovery actions.

---

# Future Improvements

Potential future enhancements include:

- automatic recovery reports;
- redundant storage;
- configuration backup;
- remote recovery tools;
- health dashboard integration.

---

## Related Documents

| Document | Description |
|----------|-------------|
| 04-storage.md | Storage |
| 05-services.md | Services |
| 06-scripts.md | Scripts |
| 07-monitoring.md | Monitoring |
| 08-maintenance.md | Maintenance |
| 10-architecture-decision-records.md | Architecture Decision Records |

---

## Change History

| Version | Date | Description |
|----------|------------|-------------------------------|
| 1.0 | 2026-07-31 | Initial disaster recovery documentation created |
