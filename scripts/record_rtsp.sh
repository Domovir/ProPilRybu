# Universal RTSP Recorder Design

| Property | Value |
|----------|-------|
| **Document** | 11-universal-recorder-design.md |
| **Title** | Universal RTSP Recorder Design |
| **Category** | Design Specification |
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
> This document defines the design specification for the Universal RTSP Recorder subsystem of the ProPilRybu project.
>
> It describes the target architecture, implementation requirements and migration strategy.
>
> This document is a design specification and does not necessarily reflect the current production implementation.

---

# Universal RTSP Recorder Design

## Purpose

Define a universal recording subsystem capable of serving multiple IP cameras using a single recording engine and individual configuration files.

The objective is to eliminate duplicated scripts while improving maintainability, scalability and reliability.

---

## Objectives

The Universal RTSP Recorder shall:

- support multiple cameras;
- use a single recording script;
- load camera-specific parameters from configuration files;
- remain compatible with systemd;
- simplify maintenance;
- simplify deployment of new cameras;
- minimize duplicated code.

---

## Current Architecture

Current implementation:

```
Bahus
      \
       bahus_rtsp.sh
             \
              FFmpeg
             /
LaVanda
       \
        lavanda_rtsp.sh
              \
               FFmpeg
              /
Salon
      \
       salon_rtsp.sh
             \
              FFmpeg
```

Characteristics:

- three independent scripts;
- duplicated FFmpeg parameters;
- camera-specific values embedded in scripts;
- changes must be repeated in every script.

---

## Proposed Architecture

```
Bahus.conf
             \
LaVanda.conf ---> record_rtsp.sh ---> FFmpeg
             /
Salon.conf
```

Characteristics:

- one universal recorder;
- one configuration file per camera;
- no camera-specific values inside the script;
- simplified maintenance;
- scalable architecture.

---

## Directory Structure

```
/usr/local/bin/
    record_rtsp.sh

/etc/propilrybu/
    bahus.conf
    lavanda.conf
    salon.conf

/home/ftpuser/Videos/
    Bahus/
    LaVanda/
    Salon/
```

---

## Configuration Format

Example:

```ini
CAMERA_NAME="Bahus"

RTSP_URL="rtsp://..."

OUTPUT_DIR="/home/ftpuser/Videos/Bahus"

SEGMENT_TIME=300

LOG_LEVEL="warning"

FFMPEG_BIN="/usr/bin/ffmpeg"
```

Additional parameters may be introduced without modifying the recorder itself.

---

## Recorder Responsibilities

The recorder shall:

- validate configuration;
- verify required variables;
- create output directory if necessary;
- start FFmpeg;
- terminate gracefully;
- return meaningful exit codes.

The recorder shall not contain any camera-specific configuration.

---

## Logging Strategy

The recorder should:

- write startup messages;
- report configuration errors;
- report FFmpeg launch failures;
- integrate with systemd journal;
- use consistent log formatting.

---

## Error Handling

The recorder shall detect:

- missing configuration file;
- invalid configuration;
- missing FFmpeg binary;
- inaccessible output directory;
- invalid RTSP URL.

Errors should produce meaningful log messages.

---

## Integration with systemd

Each camera will have its own service.

Example:

```
bahus-rtsp.service
```

The service will execute:

```
record_rtsp.sh /etc/propilrybu/bahus.conf
```

Only configuration files differ between cameras.

---

## Migration Strategy

Migration shall be performed incrementally.

Stage 1

- complete design;
- implement recorder;
- prepare configuration files.

Stage 2

- laboratory testing.

Stage 3

- test using isolated systemd service.

Stage 4

- migrate Bahus.

Stage 5

- migrate LaVanda.

Stage 6

- migrate Salon.

Stage 7

- remove legacy scripts.

---

## Future Enhancements

Possible future improvements:

- automatic reconnect;
- configurable segment duration;
- notification support;
- watchdog integration;
- health monitoring;
- metrics export.

---

## Related Documents

| Document | Description |
|----------|-------------|
| 02-system-architecture.md | Overall system architecture |
| 03-camera-configuration.md | Camera configuration |
| 05-services.md | systemd services |
| 06-scripts.md | Script overview |
| 10-architecture-decision-records.md | Architecture decisions |

---

## Change History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-08-02 | Initial design specification created |