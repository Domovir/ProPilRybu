| Property | Value |
|----------|-------|
| **Document** | 05-services.md |
| **Title** | Services |
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

# Services

---

## Purpose

This document describes the system services responsible for continuous CCTV recording, monitoring and automatic recovery.

All services are managed by **systemd**.

---

## Scope

This document covers:

- Recording services
- Watchdog services
- Service management
- Startup sequence
- Automatic recovery
- Operational procedures

---

# Service Overview

| Service | Purpose | Status |
|----------|----------|--------|
| bahus-rtsp.service | Bahus recording | Enabled |
| lavanda-rtsp.service | LaVanda recording | Enabled |
| salon-rtsp.service | Salon recording | Enabled |
| rtsp-watchdog.service | Camera monitoring | Timer Activated |
| rtsp-watchdog.timer | Watchdog scheduler | Enabled |

---

# Architecture

```text
                systemd
                   │
      ┌────────────┼────────────┐
      │            │            │
      ▼            ▼            ▼
 Bahus RTSP   LaVanda RTSP   Salon RTSP
      │            │            │
      └────────────┼────────────┘
                   │
             Video Archive
                   │
                   ▼
          /home/ftpuser/Videos
                   ▲
                   │
         RTSP Watchdog Timer
                   │
                   ▼
        rtsp-watchdog.service
```

---

# Recording Services

## bahus-rtsp.service

### Description

Continuous recording service for the Bahus camera.

### Configuration

| Property | Value |
|----------|-------|
| Type | simple |
| User | ftpuser |
| Group | ftpuser |
| Restart | always |
| Restart Delay | 10 seconds |
| Start After | network-online.target |

Executable:

```text
/usr/local/bin/bahus_rtsp.sh
```

---

## lavanda-rtsp.service

### Description

Continuous recording service for the LaVanda camera.

### Configuration

| Property | Value |
|----------|-------|
| Type | simple |
| User | ftpuser |
| Group | ftpuser |
| Restart | always |
| Restart Delay | 5 seconds |
| Start After | network-online.target |

Executable:

```text
/usr/local/bin/lavanda_rtsp.sh
```

---

## salon-rtsp.service

### Description

Continuous recording service for the Salon camera.

### Configuration

| Property | Value |
|----------|-------|
| Type | simple |
| User | ftpuser |
| Group | ftpuser |
| Restart | always |
| Restart Delay | 5 seconds |
| Start After | network-online.target |

Executable:

```text
/usr/local/bin/salon_rtsp.sh
```

---

# Watchdog Service

## rtsp-watchdog.service

The watchdog periodically verifies the health of the recording system.

Configuration:

| Property | Value |
|----------|-------|
| Type | oneshot |
| Executable | `/usr/local/bin/rtsp_watchdog.sh` |

The watchdog is executed by a systemd timer.

---

## rtsp-watchdog.timer

The timer automatically starts the watchdog every minute.

Configuration:

| Property | Value |
|----------|-------|
| OnBootSec | 1 minute |
| OnUnitActiveSec | 1 minute |
| AccuracySec | 10 seconds |

---

# Service Startup

Recording services start automatically after the network becomes available.

```text
network-online.target
          │
          ▼
bahus-rtsp.service
lavanda-rtsp.service
salon-rtsp.service
```

---

# Automatic Recovery

The recording services are configured for automatic recovery.

Recovery policy:

- Restart after unexpected termination.
- Automatic startup after reboot.
- Independent recovery of each camera.
- Failure of one service does not affect the others.

---

# Service Management

Display service status:

```bash
sudo systemctl status bahus-rtsp
sudo systemctl status lavanda-rtsp
sudo systemctl status salon-rtsp
```

Restart a service:

```bash
sudo systemctl restart bahus-rtsp
sudo systemctl restart lavanda-rtsp
sudo systemctl restart salon-rtsp
```

Stop a service:

```bash
sudo systemctl stop bahus-rtsp
```

Start a service:

```bash
sudo systemctl start bahus-rtsp
```

Enable at boot:

```bash
sudo systemctl enable bahus-rtsp
```

View logs:

```bash
journalctl -u bahus-rtsp
journalctl -u lavanda-rtsp
journalctl -u salon-rtsp
```

---

# Operational Notes

The recording services:

- run independently;
- use the `ftpuser` account;
- automatically restart after failures;
- require network availability before startup;
- write recordings directly to the archive volume.

---

# Current Implementation Notes

A file named:

```text
/etc/systemd/system/cameras.service
```

currently exists but does not contain an active service definition and is not used by the system.

---

# Future Improvements

Possible future enhancements include:

- aggregate service management;
- service dependency optimization;
- health monitoring integration;
- automatic alerting on repeated failures;
- startup performance metrics.

---

## Related Documents

| Document | Description |
|----------|-------------|
| 01-server-passport.md | Server Passport |
| 02-system-architecture.md | System Architecture |
| 03-camera-configuration.md | Camera Configuration |
| 04-storage.md | Storage |
| 06-scripts.md | Automation Scripts |
| 07-monitoring.md | Monitoring |

---

## Change History

| Version | Date | Description |
|----------|------------|-------------------------------|
| 1.0 | 2026-07-31 | Initial services documentation created |
