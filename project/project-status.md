# Project Status

| Property | Value |
|----------|-------|
| **Project** | ProPilRybu |
| **Current Version** | 1.0 |
| **Status** | 🟢 Documentation Complete |
| **Current Milestone** | CP-005 |
| **Last Updated** | 2026-07-31 |

---

# Current State

The first official version of the ProPilRybu technical documentation has been completed.

The repository now contains a complete documentation set covering the CCTV server architecture, storage, services, automation, monitoring, maintenance and disaster recovery.

The project is ready to begin the next development phase (v1.1).

---

# Completed Milestones

| ID | Status | Description |
|----|--------|-------------|
| CP-001 | ✅ | Repository structure created |
| CP-002 | ✅ | Documentation foundation created |
| CP-003 | ✅ | Documentation standard approved |
| CP-004 | ✅ | Technical documentation initiated |
| CP-005 | ✅ | Documentation v1.0 completed |

---

# Current Tasks

- Review documentation after operational changes.
- Maintain Architecture Decision Records (ADR).
- Keep documentation synchronized with the production server.
- Plan features for version 1.1.

---

# Upcoming Milestones

## CP-006

Infrastructure Improvements

Possible objectives:

- Operational Runbook
- Architecture diagrams
- Aggregated camera service
- Monitoring improvements
- Documentation refinement

---

# Current CCTV Configuration

| Component | Value |
|----------|-------|
| Operating System | Ubuntu Server |
| Recording Engine | FFmpeg |
| Recording Format | MKV |
| Cameras | Bahus, LaVanda, Salon |
| Storage | `/home/ftpuser/Videos` |
| Filesystem | ext4 |
| Storage Device | `/dev/sdb` |
| Capacity | 150 GB |
| Cleanup Policy | START_LIMIT=90%, TARGET_LIMIT=85% |

---

# Repository Structure

```text
docs/
images/
project/
scripts/
README.md
LICENSE.txt
```

---

# Notes

The documentation template (`docs/00-document-template.md`) is the official documentation standard for the project.

All future documentation shall follow this standard.

---

# Next Session

Planned work:

- Begin development of version 1.1.
- Improve operational tooling.
- Expand project documentation where required.

---

# Change History

| Version | Date | Description |
|----------|------------|-------------------------------|
| 1.0 | 2026-07-31 | Initial project status created |
| 1.1 | 2026-07-31 | Updated after completion of Documentation v1.0 (CP-005) |