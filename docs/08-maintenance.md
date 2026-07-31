| Property | Value |
|----------|-------|
| **Document** | 08-maintenance.md |
| **Title** | Maintenance |
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

# Maintenance

---

## Purpose

This document describes the routine maintenance procedures required to ensure the reliable operation of the ProPilRybu CCTV recording server.

The objective is to maintain continuous recording, maximize system stability and minimize unexpected downtime.

---

## Scope

This document covers:

- Routine inspections
- Recording verification
- Storage maintenance
- Service maintenance
- Log inspection
- System updates
- Operational recommendations

---

# Maintenance Objectives

Routine maintenance should ensure:

- Continuous video recording
- Stable operation of all services
- Healthy storage utilization
- Timely detection of failures
- Long-term system reliability

---

# Daily Maintenance

Recommended daily checks:

| Task | Command |
|------|----------|
| Verify recording services | `systemctl status bahus-rtsp lavanda-rtsp salon-rtsp` |
| Check storage usage | `df -h /home/ftpuser/Videos` |
| Verify archive growth | `du -sh /home/ftpuser/Videos/*` |
| Review cleanup log | `tail -30 /var/log/cctv_cleanup.log` |

Expected result:

- all services active;
- storage within acceptable limits;
- archive continues growing;
- no unexpected errors.

---

# Weekly Maintenance

Recommended weekly tasks:

- Review system logs.
- Verify watchdog operation.
- Confirm cleanup script execution.
- Inspect archive continuity.
- Remove obsolete temporary files if required.

Useful commands:

```bash
journalctl -p warning -b
```

```bash
systemctl list-units --failed
```

---

# Monthly Maintenance

Recommended monthly tasks:

- Install operating system updates.
- Verify available storage capacity.
- Review archive growth trends.
- Inspect systemd service configuration.
- Confirm email notification functionality.

Update packages:

```bash
sudo apt update
sudo apt upgrade
```

---

# Storage Maintenance

Verify available storage:

```bash
df -h /home/ftpuser/Videos
```

Verify archive distribution:

```bash
du -sh /home/ftpuser/Videos/*
```

Current cleanup policy:

| Parameter | Value |
|-----------|-------|
| Cleanup Start | 90% |
| Cleanup Target | 85% |

No manual archive cleanup is normally required.

---

# Service Maintenance

Verify recording services:

```bash
systemctl status bahus-rtsp
systemctl status lavanda-rtsp
systemctl status salon-rtsp
```

Restart if necessary:

```bash
sudo systemctl restart bahus-rtsp
```

The same procedure applies to the remaining recording services.

---

# Log Maintenance

Important logs:

| Log | Purpose |
|-----|----------|
| `/var/log/cctv_cleanup.log` | Archive cleanup |
| `journalctl` | Service diagnostics |

Display recent cleanup activity:

```bash
tail -50 /var/log/cctv_cleanup.log
```

Display service logs:

```bash
journalctl -u bahus-rtsp
```

---

# Archive Verification

Periodically verify:

- new recordings are being created;
- recording timestamps are current;
- archive directories remain accessible;
- no zero-byte files accumulate.

---

# Software Maintenance

Recommended maintenance:

- Keep Ubuntu updated.
- Keep FFmpeg updated.
- Review Python package dependencies if modified.
- Maintain documentation alongside system changes.

---

# Operational Best Practices

The following practices are recommended:

- avoid unnecessary service restarts;
- monitor available disk space;
- preserve documentation accuracy;
- test changes before production deployment;
- document every significant system modification.

---

# Maintenance Schedule

| Frequency | Activity |
|-----------|----------|
| Daily | Service status, storage, logs |
| Weekly | Watchdog, journals, archive verification |
| Monthly | System updates, capacity review |
| After Changes | Functional verification and documentation update |

---

# Future Improvements

Potential future enhancements include:

- automated maintenance reports;
- health dashboard;
- scheduled integrity checks;
- SMART storage monitoring;
- maintenance reminders.

---

## Related Documents

| Document | Description |
|----------|-------------|
| 04-storage.md | Storage |
| 05-services.md | Services |
| 06-scripts.md | Scripts |
| 07-monitoring.md | Monitoring |
| 09-disaster-recovery.md | Disaster Recovery |

---

## Change History

| Version | Date | Description |
|----------|------------|-------------------------------|
| 1.0 | 2026-07-31 | Initial maintenance documentation created |
