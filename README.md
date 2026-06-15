# Jellyfin Torch

A Jellyfin media server deployment managed via skill files.

## Structure

- `skills/` - Skill files for plugins, scripts, and config overrides
  - `plugins/` - Plugin definitions and installation scripts
  - `scripts/` - Automation scripts (backup, metadata, etc.)
  - `configs/` - Custom configuration templates
- `config/` - Server configuration (gitignored)
- `data/` - Runtime data (gitignored)
- `logs/` - Server logs (gitignored)
- `backups/` - Backup archives (gitignored)

## Getting Started

1. Copy config templates from `skills/configs/` to `config/` and customize.
2. Run the Jellyfin server (Docker or native).
3. Access the web UI at `http://localhost:8096`.

## License

MIT
