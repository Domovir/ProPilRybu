# Project Status

## Project Metadata

| Property | Value |
|---|---|
| Project | ProPilRybu |
| Current Version | 1.3 |
| Status | 🟢 Active Development |
| Current Milestone | CP-008 |
| Last Updated | 2026-08-09 |

---

## Current State

The documentation and architecture phases have been successfully completed.

The Universal RTSP Recorder Version 1.3 has successfully completed laboratory validation.

The recorder was validated using a dedicated test configuration and successfully:

- loaded the configuration file;
- validated required parameters;
- executed under the `ftpuser` account;
- connected to the Bahus RTSP stream;
- produced valid MKV recordings;
- recorded HEVC video and PCM A-law audio;
- produced 60-second segments;
- produced a valid MKV segment verified with FFprobe;
- handled SIGTERM correctly and terminated the test recording process cleanly.

The production system remains unchanged and continues to use the existing production recorder processes for Bahus, LaVanda and Salon.

The current work is focused on systemd integration and preparation for controlled production migration.

---

## Completed Milestones

| ID | Status | Description |
|---|---|---|
| CP-001 | ✅ | Repository structure created |
| CP-002 | ✅ | Documentation foundation created |
| CP-003 | ✅ | Documentation standard approved |
| CP-004 | ✅ | Architecture documentation completed |
| CP-005 | ✅ | Complete technical documentation finished |
| CP-006 | ✅ | Implementation Phase Started |
| CP-007 | ✅ | Universal RTSP Recorder Framework |
| CP-008 | ✅ | Universal RTSP Recorder 1.3 laboratory validation |

---

## Current Tasks

- Validate systemd integration
- Prepare production deployment
- Prepare controlled Bahus migration

---

## Upcoming Milestones

| ID | Milestone |
|---|---|
| CP-009 | Bahus production migration |
| CP-010 | LaVanda production migration |
| CP-011 | Salon production migration |
| CP-012 | Legacy recorder retirement |

---

## Current CCTV Configuration

| Component | Value |
|---|---|
| Operating System | Ubuntu Server |
| Recording Engine | FFmpeg |
| Cameras | Bahus, LaVanda, Salon |
| Storage | `/home/ftpuser/Videos` |
| Recording Format | MKV |
| Segment Duration | 300 seconds |
| Cleanup Policy | `START_LIMIT = 90%`, `TARGET_LIMIT = 85%` |

> Note: The 60-second segment duration was used only for laboratory validation with the dedicated `test.conf`. Production recording remains configured for 300-second segments.

---

## Repository Structure

```text
docs/
configs/
images/
project/
scripts/
README.md
LICENSE
.gitignore