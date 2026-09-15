# 05-services.md

| Property | Value |
|----------|-------|
| **Document** | 05-services.md |
| **Title** | Services |
| **Category** | System Services |
| **Project** | ProPilRybu |
| **Version** | 1.1 |
| **Status** | Production |
| **Owner** | Domovir |
| **Maintainer** | Domovir |
| **Repository** | GitHub |
| **License** | MIT |
| **Created** | 2026-07-31 |
| **Last Updated** | 2026-09-14 |
| **Reviewed** | 2026-09-14 |
| **Next Review** | 2026-12-14 |

---

# Services

## Purpose

This document describes the systemd services used by the ProPilRybu recording system.

It defines service roles, dependencies, restart behaviour, configuration, logging and operational procedures.

---

## Scope

This document covers:

- RTSP recording services;
- the universal RTSP recorder;
- systemd service configuration;
- service dependencies;
- service restart behaviour;
- service monitoring and diagnostics.

---

## Service Architecture

ProPilRybu uses independent systemd services for each camera.

Current production recording services:

| Service | Camera | Configuration |
|---------|--------|---------------|
| `bahus-rtsp.service` | Bahus | `/etc/propilrybu/bahus.conf` |
| `lavanda-rtsp.service` | LaVanda | `/etc/propilrybu/lavanda.conf` |
| `salon-rtsp.service` | Salon | `/etc/propilrybu/salon.conf` |

Each service starts the same universal recorder:

`/usr/local/bin/record_rtsp.sh`

with its corresponding camera configuration.

---

## Recording Services

### Bahus

Service:

`bahus-rtsp.service`

Configuration:

`/etc/propilrybu/bahus.conf`

Archive:

`/home/ftpuser/Videos/Bahus`

---

### LaVanda

Service:

`lavanda-rtsp.service`

Configuration:

`/etc/propilrybu/lavanda.conf`

Archive:

`/home/ftpuser/Videos/LaVanda`

---

### Salon

Service:

`salon-rtsp.service`

Configuration:

`/etc/propilrybu/salon.conf`

Archive:

`/home/ftpuser/Videos/Salon`

---

## Universal Recorder

All production camera services use:

`/usr/local/bin/record_rtsp.sh`

Current recorder version:

`1.4`

The recorder receives one camera-specific configuration file as its argument.

Example:

`/usr/local/bin/record_rtsp.sh /etc/propilrybu/bahus.conf`

The recorder starts FFmpeg and writes segmented MKV recordings to the configured archive directory.

---

## Service Configuration

Production recorder services use the following systemd principles:

| Parameter | Value |
|-----------|-------|
| Service type | `simple` |
| User | `ftpuser` |
| Group | `ftpuser` |
| Recorder | `/usr/local/bin/record_rtsp.sh` |
| Configuration | One camera-specific `.conf` file |
| Restart policy | `always` |
| Network dependency | `network-online.target` |
| Logging | systemd journal |

The services operate independently.

A failure of one camera service must not stop the recording services of the other cameras.

---

## Dependencies

Recorder services depend on network availability.

Required systemd relationship:

`After=network-online.target`

`Wants=network-online.target`

The RTSP connection itself is established by the universal recorder and FFmpeg.

---

## Restart Policy

Production recording services use automatic restart.

The purpose is to recover from unexpected recorder or network failures without manual intervention.

The service restart policy is:

`Restart=always`

A restart delay is configured to prevent immediate restart loops.

---

## Logging

Service output is available through the systemd journal.

Primary diagnostic command:

`journalctl -u <service>`

Examples:

`journalctl -u bahus-rtsp.service --no-pager`

`journalctl -u lavanda-rtsp.service --no-pager`

`journalctl -u salon-rtsp.service --no-pager`

Recent messages:

`journalctl -u <service> -n 100 --no-pager`

Live log monitoring:

`journalctl -u <service> -f`

---

## Service Management

### Check Status

`systemctl status <service> --no-pager`

Example:

`systemctl status bahus-rtsp.service --no-pager`

---

### Start

`sudo systemctl start <service>`

---

### Stop

`sudo systemctl stop <service>`

---

### Restart

`sudo systemctl restart <service>`

---

### Enable at Boot

`sudo systemctl enable <service>`

---

### Disable at Boot

`sudo systemctl disable <service>`

---

### Reload systemd Configuration

After modifying a service file:

`sudo systemctl daemon-reload`

A daemon reload is required before restarting the modified service.

---

## Service Verification

After deployment or modification, verify each production service.

Check:

- service is active;
- recorder process is running;
- correct configuration file is used;
- archive files are being created;
- journal contains no fatal errors;
- automatic restart works as expected.

Basic verification:

`systemctl is-active bahus-rtsp.service`

`systemctl is-active lavanda-rtsp.service`

`systemctl is-active salon-rtsp.service`

---

## Recording Verification

Service status alone does not confirm that video is being written correctly.

Verify the corresponding archive directory:

`/home/ftpuser/Videos/Bahus`

`/home/ftpuser/Videos/LaVanda`

`/home/ftpuser/Videos/Salon`

Verify that new MKV files are created and that completed recordings have valid durations.

---

## Failure Isolation

Each camera has an independent systemd service.

Architecture:

`Bahus → bahus-rtsp.service`

`LaVanda → lavanda-rtsp.service`

`Salon → salon-rtsp.service`

A failure of one RTSP source or recorder process does not directly stop the other camera services.

This isolation is a core reliability principle of ProPilRybu.

---

## Service and Archive Relationship

The service layer writes recordings to the storage layer.

Data flow:

`RTSP Camera`

→ `record_rtsp.sh`

→ `FFmpeg`

→ `MKV`

→ `/home/ftpuser/Videos/<Camera>`

Archive capacity is managed independently by the storage cleanup mechanism.

---

## Operational Rules

The following rules apply to production services:

1. Each camera must have its own systemd service.
2. Each service must reference exactly one camera configuration.
3. Production services must use the universal recorder.
4. Camera credentials must not be embedded directly in systemd unit files.
5. Services must run with the dedicated `ftpuser` account.
6. Services must restart automatically after unexpected termination.
7. Service changes must be followed by `daemon-reload`.
8. Service status and recording output must be verified after changes.
9. Service logs must be checked when diagnosing recording problems.
10. Changes to production services must be documented.

---

## Troubleshooting

### Service is inactive

Check:

`systemctl status <service> --no-pager`

Then inspect:

`journalctl -u <service> -n 100 --no-pager`

---

### Service repeatedly restarts

Check the journal for:

- RTSP connection errors;
- FFmpeg errors;
- configuration errors;
- permission errors;
- unavailable network resources.

Also check:

`systemctl status <service> --no-pager`

---

### Service is active but no files are created

Check:

- archive directory;
- filesystem availability;
- directory permissions;
- recorder journal;
- FFmpeg messages;
- RTSP source availability.

---

### After modifying a service file

Run:

`sudo systemctl daemon-reload`

Then:

`sudo systemctl restart <service>`

Finally verify:

`systemctl status <service> --no-pager`

and confirm that new recordings are being created.

---

## Related Documents

| Document | Description |
|----------|-------------|
| `01-server-passport.md` | Server Passport |
| `02-system-architecture.md` | System Architecture |
| `03-camera-configuration.md` | Camera Configuration |
| `04-storage.md` | Storage |
| `06-scripts.md` | Automation Scripts |
| `07-monitoring.md` | Monitoring |
| `12-universal-recorder-test-plan.md` | Universal Recorder Test Plan |
| `14-universal-recorder-specification.md` | Universal Recorder Specification |
| `15-systemd-service-specification.md` | Systemd Service Specification |

---

## Change History

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-07-31 | Initial services documentation created |
| 1.1 | 2026-09-14 | Updated production service architecture and universal recorder integration |