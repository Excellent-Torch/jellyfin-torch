#!/usr/bin/env bash
# Render config files from templates using values in .env
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
ENV_FILE="$PROJECT_DIR/.env"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "ERROR: $ENV_FILE not found. Copy .env.example to .env and fill in your secrets." >&2
  exit 1
fi

# Export variables from .env so envsubst can use them
set -a
# shellcheck source=/dev/null
source "$ENV_FILE"
set +a

echo "Rendering config files from templates..."

mkdir -p "$PROJECT_DIR/config/zurg"
envsubst < "$PROJECT_DIR/skills/configs/zurg.config.yml.template" > "$PROJECT_DIR/config/zurg/config.yml"
echo "  -> config/zurg/config.yml"

mkdir -p "$PROJECT_DIR/config/decypharr"
envsubst < "$PROJECT_DIR/skills/configs/decypharr.config.json.template" > "$PROJECT_DIR/config/decypharr/config.json"
echo "  -> config/decypharr/config.json"

echo "Done."
