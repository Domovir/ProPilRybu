# ProPilRybu

> Reliable CCTV Server based on Ubuntu Server, FFmpeg and RTSP.

![Status](https://img.shields.io/badge/status-active-success)
![Platform](https://img.shields.io/badge/platform-Ubuntu-orange)
![Video](https://img.shields.io/badge/video-H.265-blue)
![Version](https://img.shields.io/badge/version-v1.0.0-blue)

---

# ProPilRybu

**ProPilRybu** is an open project focused on building a reliable 24/7 CCTV recording system using open technologies.

The project combines video recording, archive management, automation, monitoring and technical documentation into a single maintainable solution.

---

# Features

* 🎥 RTSP video recording
* ⚡ FFmpeg recording without transcoding (`-c copy`)
* 💾 H.265 (HEVC) support
* 📁 Local archive storage
* 🧹 Automatic archive cleanup
* 📧 Email notifications
* ⚙️ systemd service management
* 📚 Complete technical documentation
* 📝 Architecture Decision Records (ADR)

---

# Architecture

```text
 IP Cameras
      │
      ▼
    RTSP Streams
      │
      ▼
     FFmpeg
      │
      ▼
 MKV Video Archive
      │
      ▼
 Archive Storage
      │
      ▼
Automatic Cleanup
      │
      ▼
 Email Notifications
```

---

# Current System

| Component               | Status |
| ----------------------- | :----: |
| Ubuntu Server           |    ✅   |
| RTSP Recording          |    ✅   |
| FFmpeg                  |    ✅   |
| H.265 Recording         |    ✅   |
| Archive Storage         |    ✅   |
| Automatic Cleanup       |    ✅   |
| Email Notifications     |    ✅   |
| Technical Documentation |   🚧   |
| Monitoring              |   🚧   |
| Disaster Recovery       |   📋   |

---

# Repository Structure

```text
ProPilRybu/
│
├── docs/
├── scripts/
├── systemd/
├── configs/
├── reports/
├── images/
├── tools/
│
├── README.md
├── CHANGELOG.md
├── PROJECT_DIARY.md
├── TODO.md
└── LICENSE
```

---

# Documentation

The project documentation is located in the `docs/` directory.

Documentation includes:

* Server Passport
* System Architecture
* Camera Configuration
* Storage
* Services
* Scripts
* Monitoring
* Maintenance
* Disaster Recovery
* Architecture Decision Records (ADR)

---

# Project Goals

The primary goal of this project is to create a CCTV platform that is:

* reliable;
* fully documented;
* easy to maintain;
* easy to extend;
* suitable for continuous 24/7 operation.

---

# Roadmap

## v1.0 Foundation

* [x] Repository structure
* [x] RTSP recording
* [x] H.265 recording
* [x] Archive storage
* [x] Automatic cleanup
* [x] Email notifications
* [x] Initial documentation

## Planned

* [ ] Complete technical documentation
* [ ] Monitoring dashboard
* [ ] Telegram notifications
* [ ] Backup automation
* [ ] Recovery procedures
* [ ] Additional monitoring tools

---

# Version

Current release:

**v1.0.0 – Foundation**

---

# License

The project license will be added in a future release.

---

# Contributing

Suggestions, ideas and improvements are always welcome.

---

# Project Status

🟢 Active Development
