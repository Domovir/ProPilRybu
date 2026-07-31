| Property | Value |
|----------|-------|
| **Document** | 07-monitoring.md |
| **Title** | Monitoring |
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

# Monitoring

---

## Purpose

This document describes the monitoring subsystem used by the ProPilRybu CCTV recording server.

It explains how system health is monitored, how failures are detected and how administrators can verify the operational status of the recording environment.

---

## Scope

This document covers:

- Recording service monitoring
- Watchdog operation
- Log monitoring
- Disk usage monitoring
- Email notifications
- Health verification
- Operational checks

---

# Monitoring Overview

The monitoring subsystem continuously supervises:

- recording services;
- storage capacity;
- archive integrity;
- cleanup operations;
- watchdog execution.

Monitoring is designed to minimize manual intervention while ensuring continuous operation.

---

# Monitoring Components

| Component | Purpose |
|----------|----------|
| systemd | Service supervision |
| rtsp-watchdog.service | Recording verification |
| rtsp-watchdog.timer | Periodic watchdog execution |
| cctv_cleanup.sh | Disk capacity monitoring |
| send_cctv_mail.py | Email notifications |
| journalctl | Service logs |
| cctv_cleanup.log | Cleanup activity log |

---

# Recording Service Monitoring

The following recording services are continuously monitored:

- bahus-rtsp.service
- lavanda-rtsp.service
- salon-rtsp.service

Current status can be verified using:

```bash
systemctl status bahus-rtsp
systemctl status lavanda-rtsp
systemctl status salon-rtsp
```

---

# Watchdog

The RTSP watchdog periodically checks the recording environment.

Execution interval:

- every 1 minute

Managed by:

```text
rtsp-watchdog.timer
```

The watchdog helps ensure that interrupted recording services are detected and recovered.

---

# Log Monitoring

## Cleanup Log

Location:

```text
/var/log/cctv_cleanup.log
```

View recent activity:

```bash
tail -50 /var/log/cctv_cleanup.log
```

Follow log updates:

```bash
tail -f /var/log/cctv_cleanup.log
```

Typical log entries include:

- storage checks;
- cleanup start;
- deleted recordings;
- cleanup completion;
- disk usage.

---

## systemd Journal

View logs for a recording service:

```bash
journalctl -u bahus-rtsp
```

Recent log entries:

```bash
journalctl -u bahus-rtsp -n 50
```

Live monitoring:

```bash
journalctl -u bahus-rtsp -f
```

Repeat the same commands for:

- lavanda-rtsp
- salon-rtsp

---

# Disk Usage Monitoring

Current storage utilization can be checked using:

```bash
df -h /home/ftpuser/Videos
```

Archive size by camera:

```bash
sudo du -sh /home/ftpuser/Videos/*
```

Automatic cleanup thresholds:

| Parameter | Value |
|-----------|-------|
| Cleanup Start | 90% |
| Cleanup Target | 85% |

---

# Email Notifications

The monitoring subsystem sends email notifications for significant events.

Typical notifications include:

- cleanup started;
- cleanup completed;
- operational alerts.

Notification delivery is handled by:

```text
send_cctv_mail.py
```

---

# Routine Health Checks

The following checks are recommended during routine maintenance:

| Check | Command |
|--------|----------|
| Disk usage | `df -h /home/ftpuser/Videos` |
| Archive growth | `du -sh /home/ftpuser/Videos/*` |
| Recording services | `systemctl status ...` |
| Cleanup log | `tail -50 /var/log/cctv_cleanup.log` |
| System journal | `journalctl -xe` |

---

# Failure Detection

Possible failures include:

- recording service stopped;
- unavailable RTSP stream;
- storage nearly full;
- missing archive files;
- failed cleanup operation.

These conditions should be investigated immediately.

---

# Operational Recommendations

Administrators should periodically verify:

- recording service status;
- available storage space;
- archive growth trends;
- cleanup activity;
- watchdog execution.

Routine monitoring helps prevent unexpected service interruptions.

---

# Future Improvements

Potential future enhancements include:

- Telegram notifications;
- Web dashboard;
- Prometheus metrics;
- Grafana visualization;
- SMART disk monitoring;
- automatic camera availability reports.

---

## Related Documents

| Document | Description |
|----------|-------------|
| 04-storage.md | Storage |
| 05-services.md | Services |
| 06-scripts.md | Scripts |
| 08-maintenance.md | Maintenance |
| 09-disaster-recovery.md | Disaster Recovery |

---

## Change History

| Version | Date | Description |
|----------|------------|-------------------------------|
| 1.0 | 2026-07-31 | Initial monitoring documentation created |
