#!/bin/bash

###############################################################################
# ProPilRybu
#
# Script:
#   record_rtsp.sh
#
# Description:
#   Universal RTSP recording engine.
#
# Usage:
#   record_rtsp.sh /etc/propilrybu/<camera>.conf
#
# Version:
#   1.3
#
# License:
#   MIT
###############################################################################

SCRIPT_NAME="record_rtsp.sh"
SCRIPT_VERSION="1.3"

set -euo pipefail

###############################################################################
# Logging Functions
###############################################################################

log() {
    local level="$1"
    local message="$2"

    echo "[$level] $message"
    logger -t "$SCRIPT_NAME" "[$level] $message"
}

die() {
    local code="$1"
    local message="$2"

    log "ERROR" "$message"
    exit "$code"
}

require_var() {
    local var="$1"

    if [[ -z "${!var:-}" ]]; then
        die 2 "Required configuration variable '$var' is missing."
    fi
}

###############################################################################
# Utility Functions
###############################################################################

show_version() {
    echo "$SCRIPT_NAME version $SCRIPT_VERSION"
}

show_help() {
    cat <<EOF
==============================================================================
ProPilRybu - Universal RTSP Recorder
==============================================================================

Version:
$SCRIPT_VERSION

Usage:
    $SCRIPT_NAME <configuration-file>

Options:
    -h, --help       Show this help message
    -v, --version    Show recorder version

Example:
    $SCRIPT_NAME /etc/propilrybu/bahus.conf

Description:
    Universal recording engine for RTSP cameras using FFmpeg.

EOF
}

###############################################################################
# Signal Handling
###############################################################################

cleanup() {
    log "INFO" "Stop signal received. Shutting down recorder."
    exit 0
}

trap cleanup SIGINT SIGTERM

###############################################################################
# Command Line Options
###############################################################################

case "${1:-}" in
    --help|-h)
        show_help
        exit 0
        ;;
    --version|-v)
        show_version
        exit 0
        ;;
esac

###############################################################################
# Argument Processing
###############################################################################

if [[ $# -ne 1 ]]; then
    die 1 "Usage: $(basename "$0") <configuration-file>"
fi

CONFIG_FILE="$1"

###############################################################################
# Configuration Loading
###############################################################################

if [[ ! -f "$CONFIG_FILE" ]]; then
    die 2 "Configuration file not found: $CONFIG_FILE"
fi

# shellcheck disable=SC1090
source "$CONFIG_FILE"

###############################################################################
# Configuration Validation
###############################################################################

require_var CAMERA_NAME
require_var RTSP_URL
require_var OUTPUT_DIR

###############################################################################
# Optional Parameters
###############################################################################

SEGMENT_TIME="${SEGMENT_TIME:-300}"
LOG_LEVEL="${LOG_LEVEL:-warning}"
FFMPEG_BIN="${FFMPEG_BIN:-/usr/bin/ffmpeg}"

###############################################################################
# FFmpeg Validation
###############################################################################

if [[ ! -x "$FFMPEG_BIN" ]]; then
    die 3 "FFmpeg binary not found: $FFMPEG_BIN"
fi

"$FFMPEG_BIN" -version >/dev/null 2>&1 \
    || die 3 "FFmpeg is not operational."

###############################################################################
# Output Directory Initialization
###############################################################################

if [[ ! -d "$OUTPUT_DIR" ]]; then
    mkdir -p "$OUTPUT_DIR"
    log "INFO" "Created output directory: $OUTPUT_DIR"
fi

touch "$OUTPUT_DIR/.write_test" \
    || die 4 "Cannot write to '$OUTPUT_DIR'."

rm -f "$OUTPUT_DIR/.write_test"

###############################################################################
# Start Recording
###############################################################################

log "INFO" "Starting recorder for camera: $CAMERA_NAME"
log "INFO" "Output directory: $OUTPUT_DIR"
log "INFO" "Segment time: ${SEGMENT_TIME}s"

exec "$FFMPEG_BIN" \
    -hide_banner \
    -loglevel "$LOG_LEVEL" \
    -rtsp_transport tcp \
    -fflags +genpts+discardcorrupt \
    -use_wallclock_as_timestamps 1 \
    -i "$RTSP_URL" \
    -c copy \
    -f segment \
    -segment_time "$SEGMENT_TIME" \
    -segment_atclocktime 1 \
    -reset_timestamps 1 \
    -strftime 1 \
    "$OUTPUT_DIR/video_%Y%m%d_%H%M%S.mkv"