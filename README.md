# Jellyfin Torch

A Jellyfin media server deployment managed via Docker Compose. It combines
Jellyfin, the *Arr stack, and a Real-Debrid-based mount (zurg + rclone).

## Structure

- `docker-compose.yml` - Container orchestration
- `.env` - Secrets and tunables (gitignored, create from `.env.example`)
- `skills/configs/` - Config templates that use environment variables
- `scripts/` - Helper scripts
  - `render-configs.sh` - Render `config/zurg/config.yml` and
    `config/decypharr/config.json` from templates using `.env`
- `config/` - Runtime service configuration (gitignored)
- `data/` - Runtime data (gitignored)
- `backups/` - Backup archives (gitignored)
- `config/nginx/` - Example nginx reverse-proxy locations
- `config/caddy/` - Example Caddy reverse-proxy configuration

## Prerequisites

- Docker and Docker Compose
- A Real-Debrid account and API token
- `/mnt/zurg` mount point available on the host (created automatically by the
  `rclone` container)
- A reverse proxy (nginx or Caddy) if you want external HTTPS access

## Getting Started

1. **Clone or enter the repository.**

2. **Create your environment file:**

   ```bash
   cp .env.example .env
   # Edit .env and set REAL_DEBRID_API_TOKEN to your token
   ```

3. **Render the config files from templates:**

   ```bash
   ./scripts/render-configs.sh
   ```

4. **Start the stack:**

   ```bash
   docker compose up -d
   ```

5. **Access the services** locally at:

   - Jellyfin: `http://127.0.0.1:8096`
   - Sonarr: `http://127.0.0.1:8989/sonarr`
   - Radarr: `http://127.0.0.1:7878/radarr`
   - Prowlarr: `http://127.0.0.1:9696/prowlarr`
   - Overseerr: `http://127.0.0.1:5055/overseerr`
   - Decypharr: `http://127.0.0.1:8282/decypharr`

6. **Configure the reverse proxy.** Use either:
   - `config/nginx/media-stack-locations.conf` for nginx
   - `config/caddy/Caddyfile` for Caddy

## Important Security Notes

- `config/`, `data/`, and `.env` are gitignored. **Never commit secrets.**
- If you previously had API tokens committed in plain text, rotate them in the
  Real-Debrid dashboard and any *Arr applications.

## Useful Commands

```bash
# Render configs after editing .env or templates
./scripts/render-configs.sh

# View logs
docker compose logs -f

# Restart a single service
docker compose restart jellyfin

# Pull latest images and recreate
docker compose pull
docker compose up -d
```

## License

MIT
