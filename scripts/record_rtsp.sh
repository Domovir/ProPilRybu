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
# Project:
#   ProPilRybu
#
# License:
#   MIT
#
# Version:
#   1.0
#
# ==============================================================================

set -euo pipefail

# ------------------------------------------------------------------------------
# Check command line arguments
# ------------------------------------------------------------------------------

if [[ $# -ne 1 ]]; then
    echo "Usage: $(basename "$0") <config-file>"
    exit 1
fi

CONFIG_FILE="$1"

# ------------------------------------------------------------------------------
# Check configuration file
# ------------------------------------------------------------------------------

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "ERROR: Configuration file not found:"
    echo "  $CONFIG_FILE"
    exit 2
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
    echo "ERROR: FFmpeg not found:"
    echo "  $FFMPEG_BIN"
    exit 3
fi

# ------------------------------------------------------------------------------
# Create output directory
# ------------------------------------------------------------------------------

mkdir -p "$OUTPUT_DIR"

# ------------------------------------------------------------------------------
# Start recording
# ------------------------------------------------------------------------------

echo "Starting recorder:"
echo "  Camera : $CAMERA_NAME"
echo "  Output : $OUTPUT_DIR"

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