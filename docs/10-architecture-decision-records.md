| Property | Value |
|----------|-------|
| **Document** | 10-architecture-decision-records.md |
| **Title** | Architecture Decision Records |
| **Category** | Architecture |
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

# Architecture Decision Records

---

## Purpose

This document records the key architectural decisions made during the design and implementation of the ProPilRybu CCTV recording server.

Each Architecture Decision Record (ADR) documents what decision was made, why it was made and the expected long-term impact on the system.

---

## Scope

This document covers:

- Infrastructure decisions
- Software selection
- Storage architecture
- Recording strategy
- Automation design
- Documentation standards

---

# ADR-001 — Ubuntu Server

## Status

Accepted

## Decision

Ubuntu Server was selected as the operating system for the CCTV recording server.

## Rationale

- Stable long-term platform.
- Excellent systemd integration.
- Native FFmpeg support.
- Reliable package management.
- Suitable for headless operation.

## Consequences

- Low maintenance overhead.
- Long-term support.
- Wide community support.

---

# ADR-002 — systemd Services

## Status

Accepted

## Decision

Each recording process runs as an independent systemd service.

## Rationale

- Automatic startup.
- Automatic restart.
- Independent fault isolation.
- Native logging.

## Consequences

Failure of one recording service does not interrupt the others.

---

# ADR-003 — FFmpeg Recording Engine

## Status

Accepted

## Decision

FFmpeg is used as the recording engine.

## Rationale

- Mature software.
- Excellent RTSP support.
- Stable long-term operation.
- Wide codec compatibility.

---

# ADR-004 — MKV Recording Format

## Status

Accepted

## Decision

Video recordings are stored in the Matroska (MKV) container.

## Rationale

- High resilience to interrupted recordings.
- Native FFmpeg support.
- Supports HEVC and multiple audio codecs.
- No transcoding required.

## Consequences

Recordings remain reliable even if recording stops unexpectedly.

---

# ADR-005 — Stream Copy Recording

## Status

Accepted

## Decision

Video streams are stored without transcoding.

## Rationale

- Minimal CPU usage.
- Original image quality preserved.
- Reduced system load.
- Higher recording reliability.

---

# ADR-006 — Dedicated Storage Volume

## Status

Accepted

## Decision

Video archives are stored on a dedicated filesystem.

Mount point:

```text
/home/ftpuser/Videos
```

## Rationale

- Separation from the operating system.
- Easier storage expansion.
- Simplified maintenance.

---

# ADR-007 — Online Storage Expansion

## Status

Accepted

## Decision

The storage subsystem supports online filesystem expansion.

Example implementation:

```bash
sudo resize2fs /dev/sdb
```

## Rationale

Storage can be expanded without interrupting recording services.

---

# ADR-008 — Automatic Archive Cleanup

## Status

Accepted

## Decision

Archive cleanup is fully automated.

Current policy:

| Parameter | Value |
|-----------|-------|
| Cleanup Start | 90% |
| Cleanup Target | 85% |

## Rationale

- Prevent storage exhaustion.
- Preserve uninterrupted recording.
- Eliminate manual cleanup.

---

# ADR-009 — Watchdog Monitoring

## Status

Accepted

## Decision

A watchdog service periodically verifies recording operation.

Implementation:

- rtsp-watchdog.service
- rtsp-watchdog.timer

## Rationale

- Automatic failure detection.
- Improved service availability.
- Reduced downtime.

---

# ADR-010 — Documentation Standard

## Status

Accepted

## Decision

A unified documentation standard is adopted for the entire project.

## Rationale

- Consistent document structure.
- Easier maintenance.
- Better readability.
- Long-term maintainability.

The standard is defined in:

```text
docs/00-document-template.md
```

---

# ADR-011 — Repository Structure

## Status

Accepted

## Decision

The repository follows a standardized directory structure separating documentation, project management, images and automation resources.

## Rationale

- Improved navigation.
- Clear project organization.
- Easier future expansion.

---

# Decision Summary

| ADR | Decision | Status |
|------|----------|--------|
| ADR-001 | Ubuntu Server | Accepted |
| ADR-002 | systemd Services | Accepted |
| ADR-003 | FFmpeg Recording Engine | Accepted |
| ADR-004 | MKV Container | Accepted |
| ADR-005 | Stream Copy Recording | Accepted |
| ADR-006 | Dedicated Storage | Accepted |
| ADR-007 | Online Storage Expansion | Accepted |
| ADR-008 | Automatic Cleanup | Accepted |
| ADR-009 | Watchdog Monitoring | Accepted |
| ADR-010 | Documentation Standard | Accepted |
| ADR-011 | Repository Structure | Accepted |

---

# Future Decisions

Future architectural decisions should be documented by adding new ADR entries.

Each new decision should include:

- Status
- Decision
- Rationale
- Consequences

Existing ADR entries should never be modified except to clarify factual information.

---

## Related Documents

| Document | Description |
|----------|-------------|
| 00-document-template.md | Documentation Template |
| 01-server-passport.md | Server Passport |
| 02-system-architecture.md | System Architecture |
| 04-storage.md | Storage |
| 05-services.md | Services |
| 06-scripts.md | Scripts |
| 07-monitoring.md | Monitoring |
| 08-maintenance.md | Maintenance |
| 09-disaster-recovery.md | Disaster Recovery |

---

## Change History

| Version | Date | Description |
|----------|------------|-------------------------------|
| 1.0 | 2026-07-31 | Initial Architecture Decision Records created |