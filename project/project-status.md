# Project Status

| Property | Value |
|----------|-------|
| **Project** | ProPilRybu |
| **Current Version** | 1.0 |
| **Status** | 🟢 Active Development |
| **Current Milestone** | CP-004 |
| **Last Updated** | 2026-07-31 |

---

# Current State

The project has completed the documentation foundation phase.

The documentation standard has been approved and the repository structure has been established.

Current work is focused on documenting the CCTV server architecture and infrastructure.

---

# Completed Milestones

| ID | Status | Description |
|----|--------|-------------|
| CP-001 | ✅ | Repository structure created |
| CP-002 | ✅ | Documentation foundation created |
| CP-003 | ✅ | Documentation standard approved |
| CP-004 | ✅ | Architecture documentation started |

---

# Current Tasks

- [ ] Complete `03-camera-configuration.md`
- [ ] Complete `04-storage.md`
- [ ] Complete `05-services.md`
- [ ] Create architecture diagrams
- [ ] Document all systemd services
- [ ] Document automation scripts

---

# Upcoming Milestones

## CP-005

Camera configuration

Storage subsystem

Architecture diagrams

---

## CP-006

Monitoring

Maintenance

Disaster Recovery

---

# Current CCTV Configuration

## Operating System

Ubuntu Server

## Recording

FFmpeg

## Cameras

- Bahus
- LaVanda
- Salon

## Storage

Mount point:

```text
/home/ftpuser/Videos
```

Disk:

```text
/ dev/sdb
```

Current size:

**150 GB**

Cleanup policy:

```text
START_LIMIT = 90%
TARGET_LIMIT = 85%
```

---

# Repository Structure

```text
docs/
images/
project/
scripts/
```

---

# Notes

The documentation template (`docs/00-document-template.md`) is officially adopted as Documentation Standard v1.0.

Future documentation should follow this standard.

---

# Next Session

Continue with:

```text
03-camera-configuration.md
```

---

# Change History

| Version | Date | Description |
|----------|------------|------------------------------|
| 1.0 | 2026-07-31 | Initial project status created |