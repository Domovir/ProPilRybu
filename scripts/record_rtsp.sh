#!/bin/bash
#
# ==============================================================================
# ProPilRybu - Universal RTSP Recorder
# ==============================================================================
#
# Description:
#   Universal recording engine for RTSP cameras.
#
# Configuration:
#   record_rtsp.sh <config-file>
#
# Example:
#   record_rtsp.sh /etc/propilrybu/bahus.conf
#
# Version:
#   1.1
#
# ==============================================================================

set -euo pipefail

# ------------------------------------------------------------------------------
# Logging functions
# ------------------------------------------------------------------------------

log() {
    local level="$1"
    local message="$2"

    echo "[$level] $message"
    logger -t "record_rtsp" "[$level] $message"
}

die() {
    local code="$1"
    local message="$2"

    log "ERROR" "$message"
    exit "$code"
}

# ------------------------------------------------------------------------------
# Check command line arguments
# ------------------------------------------------------------------------------

if [[ $# -ne 1 ]]; then
    die 1 "Usage: $(basename "$0") <config-file>"
fi

CONFIG_FILE="$1"

# ------------------------------------------------------------------------------
# Check configuration file
# ------------------------------------------------------------------------------

if [[ ! -f "$CONFIG_FILE" ]]; then
    die 2 "Configuration file not found: $CONFIG_FILE"
fi

# ------------------------------------------------------------------------------
# Load configuration
# ------------------------------------------------------------------------------

source "$CONFIG_FILE"

# ------------------------------------------------------------------------------
# Validate required configuration
# ------------------------------------------------------------------------------

: "${CAMERA_NAME:?CAMERA_NAME is not defined}"
: "${RTSP_URL:?RTSP_URL is not defined}"
: "${OUTPUT_DIR:?OUTPUT_DIR is not defined}"

# Optional parameters

SEGMENT_TIME="${SEGMENT_TIME:-300}"
LOG_LEVEL="${LOG_LEVEL:-warning}"
FFMPEG_BIN="${FFMPEG_BIN:-/usr/bin/ffmpeg}"

# ------------------------------------------------------------------------------
# Check FFmpeg
# ------------------------------------------------------------------------------

if [[ ! -x "$FFMPEG_BIN" ]]; then
    die 3 "FFmpeg binary not found: $FFMPEG_BIN"
fi

# ------------------------------------------------------------------------------
# Create output directory
# ------------------------------------------------------------------------------

if [[ ! -d "$OUTPUT_DIR" ]]; then
    mkdir -p "$OUTPUT_DIR"
    log "INFO" "Created output directory: $OUTPUT_DIR"
fi

# ------------------------------------------------------------------------------
# Start recording
# ------------------------------------------------------------------------------

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