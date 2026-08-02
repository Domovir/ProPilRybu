# Shell Scripting Standard

| Property | Value |
|----------|-------|
| **Document** | 13-shell-scripting-standard.md |
| **Title** | Shell Scripting Standard |
| **Category** | Development Standard |
| **Project** | ProPilRybu |
| **Version** | 1.0 |
| **Status** | 🟢 Production |
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
> This document defines the official Bash scripting standard for the ProPilRybu project.
>
> All new shell scripts shall follow this standard.

---

# Shell Scripting Standard

## Purpose

Define a consistent coding style for all shell scripts within the ProPilRybu project.

The objectives are:

- consistency;
- readability;
- maintainability;
- reliability;
- production readiness.

---

# Supported Shell

All scripts shall use:

```bash
#!/bin/bash
```

Scripts shall be compatible with modern Bash versions available on Ubuntu LTS.

---

# Mandatory Script Options

Every script shall begin with:

```bash
set -euo pipefail
```

Meaning:

- `-e` Exit on error
- `-u` Treat undefined variables as errors
- `-o pipefail` Detect failures inside pipelines

---

# Script Header

Every script shall contain a descriptive header including:

- Project name
- Script name
- Purpose
- Version
- License

Example:

```text
==============================================================================
ProPilRybu
Universal RTSP Recorder
Version 1.0
MIT License
==============================================================================
```

---

# Script Layout

Scripts should follow the same structure:

```text
Project Header

Constants

Functions

Argument Processing

Configuration Loading

Validation

Initialization

Main Logic

Program Exit
```

---

# Constants

Use uppercase names.

Example:

```bash
SCRIPT_NAME="record_rtsp.sh"
SCRIPT_VERSION="1.0"
```

---

# Variables

Use meaningful variable names.

Good:

```bash
OUTPUT_DIR
SEGMENT_TIME
CONFIG_FILE
```

Avoid:

```bash
DIR
TMP
VAR1
```

---

# Functions

Functions shall perform one clearly defined task.

Recommended functions:

```text
log_info()

log_warn()

log_error()

die()

require_var()

check_binary()

check_directory()
```

---

# Logging

Use consistent logging.

Preferred:

```bash
logger -t "$SCRIPT_NAME" "Message"
```

Console output should match system log messages.

---

# Error Handling

Fatal errors shall use a common function.

Example:

```bash
die() {
    log_error "$1"
    exit "${2:-1}"
}
```

---

# Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | Invalid arguments |
| 2 | Configuration error |
| 3 | Dependency error |
| 4 | Directory error |
| 5 | Runtime error |

---

# Configuration Files

Scripts shall not contain:

- passwords;
- IP addresses;
- camera-specific settings.

Configuration shall be loaded from external files.

---

# Security

Scripts shall:

- quote variables;
- validate user input;
- avoid executing untrusted data;
- never store secrets inside source code.

---

# External Commands

Verify required binaries before use.

Example:

```bash
command -v ffmpeg >/dev/null 2>&1 || die "FFmpeg not found" 3
```

---

# Directory Handling

Always create required directories if they do not exist.

Example:

```bash
mkdir -p "$OUTPUT_DIR"
```

Verify write permissions before use.

---

# Comments

Comments should explain **why**, not **what**.

Good:

```bash
# Use TCP to improve stability over unreliable networks.
```

Avoid:

```bash
# Run ffmpeg.
```

---

# Formatting

- Four-space indentation.
- One blank line between logical sections.
- Consistent quoting using double quotes.
- Maximum reasonable line length (about 100–120 characters where practical).

---

# Versioning

Scripts shall contain an internal version.

Update the version whenever behavior changes.

---

# Testing

Every new script shall be:

- syntax checked;
- manually tested;
- documented;
- reviewed before production deployment.

---

# Related Documents

| Document | Description |
|----------|-------------|
| 00-document-template.md | Documentation Standard |
| 06-scripts.md | Script Documentation |
| 11-universal-recorder-design.md | Universal Recorder Design |
| 12-universal-recorder-test-plan.md | Recorder Test Plan |

---

# Change History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | 2026-08-02 | Initial shell scripting standard created |