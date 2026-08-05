# Systemd Service Specification

| Property   | Value                               |
| ---------- | ----------------------------------- |
| Document   | 15-systemd-service-specification.md |
| Title      | Systemd Service Specification       |
| Category   | Technical Specification             |
| Project    | ProPilRybu                          |
| Version    | 1.0                                 |
| Status     | Draft                               |
| Owner      | Domovir                             |
| Maintainer | Domovir                             |
| License    | MIT                                 |

---

# Purpose

This document defines the standard for all systemd services used within the ProPilRybu project.

It ensures consistent service configuration, logging, startup behaviour and maintenance.

---

# Scope

This specification applies to:

* bahus-rtsp.service
* lavanda-rtsp.service
* salon-rtsp.service
* future RTSP recorder services

---

# Service Naming

Service names shall follow the pattern:

```text
<camera>-rtsp.service
```

Examples:

```text
bahus-rtsp.service
lavanda-rtsp.service
salon-rtsp.service
```

---

# Service Type

All recorder services shall use:

```ini
Type=simple
```

---

# Service User

Recorder services shall run as:

```ini
User=ftpuser
Group=ftpuser
```

unless a different service account is explicitly required.

---

# Executable

Services shall execute the universal recorder:

```text
/usr/local/bin/record_rtsp.sh
```

using a camera-specific configuration file.

Example:

```text
/usr/local/bin/record_rtsp.sh /etc/propilrybu/bahus.conf
```

---

# Restart Policy

Recommended configuration:

```ini
Restart=always
RestartSec=10
```

This provides automatic recovery after unexpected failures.

---

# Dependencies

Minimum recommended configuration:

```ini
After=network-online.target
Wants=network-online.target
```

---

# Logging

Recorder output shall be written to:

* systemd journal;
* standard output.

Log messages shall include:

* severity;
* recorder name;
* descriptive message.

---

# Working Directory

No working directory is required.

Recorder behaviour shall not depend on the current directory.

---

# Exit Behaviour

Services shall terminate gracefully on:

* SIGTERM
* SIGINT

Unexpected failures shall be handled by the Restart policy.

---

# Configuration Files

Each service shall reference exactly one configuration file.

Examples:

```text
/etc/propilrybu/bahus.conf
/etc/propilrybu/lavanda.conf
/etc/propilrybu/salon.conf
```

---

# Installation

Service files shall be stored in:

```text
/etc/systemd/system/
```

After installation:

```bash
sudo systemctl daemon-reload
sudo systemctl enable <service>
sudo systemctl start <service>
```

---

# Verification

Recommended verification commands:

```bash
systemctl status <service>

journalctl -u <service>

systemctl restart <service>

systemctl stop <service>
```

---

# Security Considerations

Service files should:

* avoid hard-coded credentials;
* use dedicated configuration files;
* execute only trusted binaries;
* minimize required privileges.

---

# Future Enhancements

Possible future improvements include:

* Watchdog support;
* StartLimit configuration;
* Health monitoring;
* Automatic failure notifications.

---

# Related Documents

* 05-services.md
* 11-universal-recorder-design.md
* 12-universal-recorder-test-plan.md
* 14-universal-recorder-specification.md
