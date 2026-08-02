# Universal RTSP Recorder Test Plan

| Property | Value |
|----------|-------|
| **Document** | 12-universal-recorder-test-plan.md |
| **Title** | Universal RTSP Recorder Test Plan |
| **Category** | Test Plan |
| **Project** | ProPilRybu |
| **Version** | 1.0 |
| **Status** | 🟡 Draft |
| **Owner** | Domovir |
| **Maintainer** | Domovir |
| **Repository** | https://github.com/Domovir/ProPilRybu |
| **License** | MIT |
| **Created** | 2026-08-02 |
| **Last Updated** | 2026-08-02 |
| **Reviewed** | — |
| **Next Review** | 2026-11-02 |

---

> **Official Project Notice**
>
> This document defines the testing strategy for the Universal RTSP Recorder.
>
> The objective is to validate functionality, reliability and production readiness before deployment.

---

# Universal RTSP Recorder Test Plan

## Purpose

This document describes the testing procedures required to validate the Universal RTSP Recorder before production deployment.

---

## Scope

The following components are covered:

- record_rtsp.sh
- Camera configuration files
- FFmpeg integration
- systemd integration
- Recording process
- File generation
- Error handling

---

# Test Environment

## Operating System

Ubuntu Server

## Recording Engine

FFmpeg

## Service Manager

systemd

## Test Cameras

- Bahus
- LaVanda
- Salon

---

# Test Objectives

Verify that the recorder:

- loads configuration correctly;
- validates required parameters;
- creates output directories;
- starts FFmpeg successfully;
- records video continuously;
- creates segmented files;
- exits correctly on errors.

---

# Functional Test Cases

| ID | Test | Expected Result |
|----|------|-----------------|
| TC-001 | Missing configuration file | Script exits with error |
| TC-002 | Invalid configuration | Script reports missing variables |
| TC-003 | Missing FFmpeg | Script exits with error |
| TC-004 | Invalid RTSP URL | FFmpeg reports connection failure |
| TC-005 | Valid configuration | Recording starts successfully |
| TC-006 | Output directory missing | Directory created automatically |
| TC-007 | Segment creation | MKV files created every 300 seconds |
| TC-008 | Graceful termination | FFmpeg exits cleanly |

---

# Integration Tests

Verify:

- systemd starts the recorder;
- automatic restart works correctly;
- logs appear in journalctl;
- output files are written correctly;
- recorder survives network interruptions.

---

# Performance Tests

Verify:

- CPU usage remains acceptable;
- memory usage remains stable;
- no file descriptor leaks;
- long-running recording remains stable.

---

# Reliability Tests

Perform:

- 24-hour recording test;
- service restart test;
- network interruption test;
- reboot recovery test.

---

# Acceptance Criteria

The recorder is considered production-ready when:

- all functional tests pass;
- all integration tests pass;
- no data corruption occurs;
- continuous recording remains stable;
- no unexpected crashes are observed.

---

# Deployment Readiness Checklist

- Design approved
- Source code reviewed
- Configuration verified
- Test environment validated
- Functional tests passed
- Integration tests passed
- Production approval granted

---

# Related Documents

| Document | Description |
|----------|-------------|
| 11-universal-recorder-design.md | Design Specification |
| 06-scripts.md | Script Documentation |
| 05-services.md | systemd Services |
| 07-monitoring.md | Monitoring |

---

# Change History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-08-02 | Initial test plan created |