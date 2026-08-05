# Universal RTSP Recorder Specification

| Property   | Value                                  |
| ---------- | -------------------------------------- |
| Document   | 14-universal-recorder-specification.md |
| Title      | Universal RTSP Recorder Specification  |
| Category   | Technical Specification                |
| Project    | ProPilRybu                             |
| Version    | 1.0                                    |
| Status     | Draft                                  |
| Owner      | Domovir                                |
| Maintainer | Domovir                                |
| License    | MIT                                    |

---

# Purpose

This document defines the functional specification of the Universal RTSP Recorder.

It describes the expected behaviour of the recorder independently from its implementation.

---

# Scope

The specification applies to:

* `record_rtsp.sh`
* configuration files
* FFmpeg execution
* logging
* exit codes
* systemd integration

---

# Command Line Interface

## Usage

```text
record_rtsp.sh <configuration-file>
```

## Supported Options

```text
--help
--version
```

---

# Configuration

The recorder shall load a single configuration file.

Required parameters:

* CAMERA_NAME
* RTSP_URL
* OUTPUT_DIR

Optional parameters:

* SEGMENT_TIME
* LOG_LEVEL
* FFMPEG_BIN

---

# Recorder Behaviour

The recorder shall:

* validate arguments;
* validate configuration;
* verify FFmpeg availability;
* verify output directory;
* verify write permissions;
* start FFmpeg;
* create segmented recordings;
* terminate gracefully.

---

# Logging

The recorder shall write messages to:

* standard output;
* systemd journal.

Every log entry shall contain:

* severity;
* message.

---

# Exit Codes

| Code | Meaning                 |
| ---- | ----------------------- |
| 0    | Successful termination  |
| 1    | Invalid arguments       |
| 2    | Configuration error     |
| 3    | FFmpeg error            |
| 4    | Output directory error  |
| 5    | RTSP connection failure |
| 10   | Interrupted by signal   |

---

# Signals

The recorder shall handle:

* SIGINT
* SIGTERM

The recorder shall terminate gracefully.

---

# Recording

Default format:

* MKV

Default segmentation:

* 300 seconds

Recording shall use stream copy whenever possible.

---

# Compatibility

Supported operating systems:

* Ubuntu Server 24.04 LTS or newer

Required software:

* Bash
* FFmpeg
* systemd

---

# Future Extensions

Possible future enhancements include:

* automatic reconnect;
* watchdog support;
* health monitoring;
* notification subsystem;
* metrics export.

---

# Related Documents

* 11-universal-recorder-design.md
* 12-universal-recorder-test-plan.md
* 13-shell-scripting-standard.md
* 05-services.md
* 06-scripts.md
