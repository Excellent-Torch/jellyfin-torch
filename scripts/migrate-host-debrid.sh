#!/usr/bin/env bash
# Helper to migrate from host-level zurg/rclone to the Docker-managed stack.
# Run this on the host when you are ready to switch.
set -euo pipefail

echo "Stopping host-level zurg and rclone..."

# Find and kill host rclone/zurg processes
RCLONE_PID=$(pgrep -f 'rclone mount zurg:' || true)
ZURG_PID=$(pgrep -x 'zurg' || true)

if [[ -n "$RCLONE_PID" ]]; then
  echo "  Unmounting /mnt/zurg (rclone PID $RCLONE_PID)..."
  sudo umount /mnt/zurg || true
  sudo kill "$RCLONE_PID" || true
fi

if [[ -n "$ZURG_PID" ]]; then
  echo "  Stopping zurg (PID $ZURG_PID)..."
  sudo kill "$ZURG_PID" || true
fi

echo "Starting Docker-managed debrid stack..."
cd "$(dirname "$0")/.."
docker compose up -d zurg rclone

echo "Done. Verify with: docker compose ps"
