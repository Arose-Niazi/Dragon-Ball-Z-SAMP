# DEPLOY-PLAN.md — DBZ open.mp Production Deploy + Website

Master plan for taking the Dragon Ball Z (open.mp / 0.3DL) gamemode live on the
Hetzner server the same way `../Mini-Missions` is deployed, plus a DBZ-themed
companion website at **https://dbz-omp.arose-niazi.me** that reuses mm-website's
speed/caching architecture.

This file is the single source of truth for the deploy. Agents and future
sessions read it so nothing is missed.

---

## 0. Fixed parameters (decided)

| Thing | Value |
|---|---|
| Server (Hetzner) | `95.216.9.233` (SSH creds in `my-server-infra/.env`) |
| Infra repo (server path) | `/opt/docker/my-server-infra` |
| Game repo | `Arose-Niazi/Dragon-Ball-Z-SAMP`, branch **`openmp`** |
| GHCR image | `ghcr.io/arose-niazi/dragon-ball-z-samp:latest` |
| Image build | **GitHub Actions on `ubuntu-latest`** (automatic `GITHUB_TOKEN`, `packages: write`) — no PAT needed |
| Image visibility | **public** (safe: no secrets baked — see §1) |
| Game server dir (server) | `/opt/samp/dragon-ball-z` (git clone of `openmp`) |
| Game server runtime secrets | `/opt/samp/dragon-ball-z/runtime/{config.json,dbz_db.cfg}` (volume-mounted, never in repo) |
| **Game UDP port** | **7778** (7777 is Mini-Missions) |
| Container name (game) | `dragon-ball-z-server` |
| Webhook secret (game) | `Deploy@DragonBallZ` |
| Website repo | `Arose-Niazi/dbz-website` (new), local `D:\Projects\php\dbz-website` |
| Website domain | `dbz-omp.arose-niazi.me` (DNS already forwarded) |
| Website dir (server) | `/opt/websites/dbz-omp.arose-niazi.me/{repo,data,.env}` |
| Website infra dir | `my-server-infra/websites/dbz-omp.arose-niazi.me/` |
| Website container name | `dbz-omp-web` |
| Webhook secret (website) | `Deploy@DBZWeb` |
| Database | MySQL `dbz` on `mariadb:11` (existing MariaDB container), user `dbz` |

### Secrets policy (hard rules)
- The DBZ MySQL password **never** enters the repo or the committed `.amx`.
  It lives only in server-side `runtime/dbz_db.cfg` (game) and the website `.env`.
- `config.json` in the repo/image ships a **placeholder** rcon password. The real
  rcon lives only in server-side `runtime/config.json` (volume-mounted over it).
- Admin in-game is restricted to **`Arose_Niazi`** (already enforced:
  `gOwnerNames` + DB `is_owner`). Do not reintroduce name-based backdoors.
- Infra/SSH/NPM secrets stay in server `.env` files only. Never commit.

---

## 1. Why the public image is safe (secrets model)

The Dockerfile bakes: `omp-server`, `components/`, `plugins/*.so`, `log-core*.so`,
`models/`, `scriptfiles/`, **placeholder** `config.json`, `bans.json`. It does **not**
bake `gamemodes/*.amx` (volume-mounted).

Everything baked is either a public binary or public art. The only secret-bearing
files (`config.json` rcon, `dbz_db.cfg`) are **overridden at runtime** by
volume-mounting server-only copies. So the GHCR image contains no secrets and can be
public → the server pulls it with no login. This is cleaner than MM (which keeps its
image private because it bakes real config).

**Action for the image to be safe:** confirm repo `config.json` has only the
placeholder rcon (`CHANGE_ME_dbz_rcon_2026`) and no discord token. ✅ already true.

---

## 2. Runtime credential + config loading (already built)

- `gamemodes/DBZ/players/database.inc` → `LoadDBConfigFile()` reads
  `scriptfiles/dbz_db.cfg` (4 lines: host, user, password, db) and overrides the
  compiled placeholders. Gitignored. ✅ done (commit 42df907).
- Prod `runtime/dbz_db.cfg` on server:
  ```
  127.0.0.1
  dbz
  <REAL_DB_PASSWORD>
  dbz
  ```
  (game server uses host networking → DB is at `127.0.0.1:3306`).

---

## 3. Task breakdown (with owner + model tier)

> Model policy (per request "be smart about fable/opus/sonnet"):
> **Fable (orchestrator, me)** — plan, DBZ-repo deploy config, all production SSH
> ops, password-hash ground-truth verification, final QA.
> **Opus** — the website build (large, quality- and security-sensitive).
> **Sonnet** — mechanical infra-repo scaffolding from existing templates.

### T12 — Build & push GHCR image  *(Fable)*
1. Add `.github/workflows/docker-build-push.yml` to the DBZ repo:
   - `on: push` (branch `openmp`, paths for Dockerfile/binaries/config) + `workflow_dispatch`.
   - `runs-on: ubuntu-latest`, `permissions: { packages: write, contents: read }`.
   - `docker/login-action` to `ghcr.io` with `${{ github.actor }}` / `${{ secrets.GITHUB_TOKEN }}`.
   - `docker/build-push-action` → `ghcr.io/arose-niazi/dragon-ball-z-samp:latest` + `:${{ github.sha }}`.
2. Clean up repo `config.json`: name/container references, `allow_037_clients: false`
   (0.3DL only — matches CLAUDE.md), keep placeholder rcon.
3. Trigger via `gh workflow run` (or push). Verify image appears in GHCR; make package **public**.
4. `docker-compose.prod.yml`: point at the GHCR image (not local build) for reference.

### T13 — Server-side provisioning via SSH  *(Fable)*
Use `sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no $SSH_USERNAME@$SERVER_IP`.
1. **DB:** create `dbz` database + `dbz` user, grant on `dbz.*`. Store password.
   Ensure `character-set-client-handshake=FALSE` compatibility (MariaDB 11 default
   charset is fine for the R41 client; verify connection).
2. **Dirs:** `/opt/samp/dragon-ball-z` ← `git clone -b openmp` the game repo.
   `mkdir -p /opt/samp/dragon-ball-z/{runtime,logs,saves}`.
3. **Runtime secrets:** write `runtime/dbz_db.cfg` (real pw) and `runtime/config.json`
   (real rcon, `network.port: 7778`, `allow_037_clients: false`).
4. **Firewall:** add `7778` to `firewall/apply-samp-rules.sh` `SAMP_PORTS`, run it
   (`ufw allow 7778/udp`).
5. **Compose:** `my-server-infra/samp/dragon-ball-z/docker-compose.yaml` (from T13-scaffold):
   image = GHCR, `network_mode: host`, volume-mount gamemodes/filterscripts (ro),
   logs, saves, and the two runtime files over `/samp/config.json` +
   `/samp/scriptfiles/dbz_db.cfg`. `docker compose up -d`.
6. **Deploy hook:** `deploy/deploy-dragon-ball-z.sh` (git reset --hard origin/openmp
   in `/opt/samp/dragon-ball-z` + `docker compose restart`) + `hooks.json` entry
   `deploy-dragon-ball-z` (secret `Deploy@DragonBallZ`) + GitHub webhook on the repo.
7. Verify: `docker logs dragon-ball-z-server` shows "Connected successfully" + schema
   ensured; UDP query from outside returns the server.

### T14 — Build DBZ website  *(Opus)*  → see §4 brief
New repo mirroring mm-website's speed layer, fully DBZ-themed, stats + UCP.

### T15 — Deploy website + SSL  *(Fable, after T14 + T13-scaffold)*
1. Push `dbz-website` repo. Clone to `/opt/websites/dbz-omp.arose-niazi.me/repo`.
2. Write server `.env` (DB creds, `SAMP_SERVER_IP=95.216.9.233`, `SAMP_SERVER_PORT=7778`).
3. `docker compose up -d` the website container (joins `proxy,internal,portainer`).
4. **NPM:** add proxy host `dbz-omp.arose-niazi.me` → `dbz-omp-web:80`, request
   Let's Encrypt cert, force SSL + HTTP/2. (NPM admin creds in server `.env`.)
5. Deploy hook `deploy-dbz-web.sh` + `hooks.json` entry + GitHub webhook.
6. Verify: HTTPS loads, live server status widget shows the game server, UCP login
   works against a real account.

### T16 — End-to-end verification + docs  *(Fable)*
- Game reachable at `95.216.9.233:7778`, custom skins download over WAN, accounts persist.
- Website fast (cache headers, prefetch), stats populate, UCP login OK.
- Update `CLAUDE.md` (deploy section) + this file with final values. Commit `.amx`.

---

## 4. Website build brief (T14 — for the Opus agent)

**Goal:** a NEW site at `D:\Projects\php\dbz-website` that copies mm-website's
*speed/caching/prefetch architecture verbatim* but is otherwise 100% DBZ — themed,
and wired to the DBZ MySQL schema. Include stats + UCP.

**Reuse verbatim (structure only, re-theme visuals):**
- `.htaccess` cache-control + gzip block (change domain to `dbz-omp\.arose-niazi\.me`).
- `assets/script.js` prefetch + `fetchAPI` + `renderStatsTable` + sound system
  (keep CSS class names: `.menu-option`, `.data-table`, `.content-box`,
  `.stats-split`, `.filter-bar`, `.status.active/inactive`, `.highlight-user`).
- `assets/stats.js` (reads `window.statsConfig`).
- `assets/config/SampQueryAPI.php` (works on open.mp — UDP query, 2s timeout).
- `assets/config/connection.php` (env-var pattern; defaults → `dbz` db; `SAMP_SERVER_PORT` 7778).
- `assets/config/auth.php` (CSRF, sessions) + `header.php`/`footer.php` template pattern.
- api endpoint pattern (`Content-Type: application/json`, prepared statements, no-cache for live data).

**DBZ theming (replace):** `assets/style.css` (DBZ orange/blue, energy/aura motifs,
angular panels — keep class names), fonts, sounds, background images, logo, site name,
meta/OG. GTA-menu UX stays; visual identity becomes DBZ.

**DBZ schema (adapt queries — NOT mm's tables):**
- `accounts(id,name,password,salt,admin_level,vip_level,is_owner,score,kills,deaths,
  character_id,transform,ki,ki_max,health_max,balls_mask,dragon_radar,banned,jailed,
  warns,radar_parts,reg_date,last_login,last_ip)`
- `player_characters(account_id,character_id,level,xp,active_move,active_skin,kills,deaths)`
- `bans(id,name,reason,admin,expire,date)` · `ip_bans(...)`
- Character names come from the gamemode `gChar[]` table (Goku, Vegeta, Gohan, …) —
  map `character_id` → name (hard-code the roster in a PHP map; see
  `gamemodes/DBZ/players/characters.inc`).

**Pages (minimum):**
- `index.php` — DBZ menu (PLAY, STATS, CHARACTERS, RANKINGS, BAN LIST, UCP, INFO).
- `play.php` — live server status via `api/server_status.php` + join info (IP 95.216.9.233:7778).
- Rankings: Top Score, Top Kills, Top K/D, Top Level (max `player_characters.level`).
  Shell page + empty container + `api/*` (mm pattern — defer data to JSON).
- `player.php?name=` — public profile: rank (owner/admin/vip/player from
  `is_owner`/`admin_level`/`vip_level`), score/kills/deaths, per-character level list.
- `characters.php` — the 14-character roster with lore + unlock levels
  (from `gFormUnlockLvl`), static.
- `banned.php` — ban checker (`api/check_ban.php` against `bans`).
- Static: server info / features / commands (adapt from gamemode).

**API endpoints:** `server_status.php` (UDP), `leaderboard.php?type=score|kills|kd|level`,
`profile_stats.php?name=`, `check_ban.php?name=`.

**UCP (`ucp/`):** login + session (copy mm auth flow) BUT password verification MUST
match the gamemode. The gamemode uses **open.mp `SHA256_Hash(password, salt)`**
(alias of `SHA256_PassHash`), storing an uppercase hex digest with a per-account
`salt`. Implement a single isolated function:
```php
function dbz_pass_hash($password, $salt) {
    return strtoupper(hash('sha256', $password . $salt)); // VERIFY vs server ground-truth
}
```
> ✅ **VERIFIED** against the real open.mp binary (2026-07-19). Ground truth:
> `SHA256_PassHash("test1234","ABCDEFGH12345678")` =
> `F8D3F5C89900DA3148AE01A8AFAEAE10329BCD84049A9A74E395B65224FC7D74`, which equals
> `strtoupper(sha256("test1234"."ABCDEFGH12345678"))`. So the construction above is
> correct: `strtoupper(hash('sha256', $password . $salt))`, password-then-salt.
UCP pages v1: `welcome.php` (own profile + characters), `change-password.php`
(re-hash with same fn), `player-search.php`. Admin panels (ban/warn) optional v1 —
gate on `admin_level`/`is_owner`. Container-control panels (scp/dcp/lcp) optional.

**Deploy shape (mirror mm-ftw):** single PHP 8.3-fpm + nginx + supervisor container.
Provide `.env.example`, `.dockerignore` (exclude dev html, .env, *.md). The infra-side
Dockerfile/compose/nginx/php.ini/supervisord are scaffolded separately (T13-scaffold),
so the website repo itself just needs app code + `.htaccess` + `.env.example`.

**Quality bars:** all output `htmlspecialchars()`; all queries prepared statements;
no secrets committed (hard-coded DB fallback only for local dev, like mm). Responsive
(768px breakpoint). Sounds on interactive elements. Status colors `#00FF00`/`#FF0000`.

---

## 5. Infra scaffold brief (T13-scaffold — for the Sonnet agent)

Create these files under `D:\Projects\others\my-server-infra` (local clone; do NOT
SSH, do NOT commit — Fable reviews and commits). Copy the Mini-Missions / mm-ftw
templates exactly, changing only names/ports/paths.

1. `samp/dragon-ball-z/docker-compose.yaml` — copy `samp/mini-missions/docker-compose.yaml`;
   change image → `ghcr.io/arose-niazi/dragon-ball-z-samp:latest`, container →
   `dragon-ball-z-server`, paths → `/opt/samp/dragon-ball-z/...`, and ADD two
   read-only mounts:
   `- /opt/samp/dragon-ball-z/runtime/config.json:/samp/config.json:ro`
   `- /opt/samp/dragon-ball-z/runtime/dbz_db.cfg:/samp/scriptfiles/dbz_db.cfg:ro`
   (keep `network_mode: host`).
2. `deploy/deploy-dragon-ball-z.sh` — copy `deploy/deploy-mini-missions.sh`; dir →
   `/opt/samp/dragon-ball-z`, reset → `origin/openmp`, and UNCOMMENT the
   `docker compose restart` block pointing at
   `/opt/docker/my-server-infra/samp/dragon-ball-z`.
3. `websites/dbz-omp.arose-niazi.me/{Dockerfile,docker-compose.yml,nginx.conf,php.ini,supervisord.conf}`
   — copy `websites/mm-ftw.net/*` verbatim; change `container_name` → `dbz-omp-web`,
   volume paths → `/opt/websites/dbz-omp.arose-niazi.me/...`, `env_file` →
   `/opt/websites/dbz-omp.arose-niazi.me/.env`. nginx/php.ini/supervisord copy as-is.
4. `deploy/deploy-dbz-web.sh` — copy `deploy/deploy-mm-ftw.sh`; `APP_DIR` →
   `/opt/websites/dbz-omp.arose-niazi.me/repo`, `INFRA_DIR` →
   `.../websites/dbz-omp.arose-niazi.me`, reset → `origin/main`.
5. Prepare (as a patch snippet in `deploy-runner/DBZ-HOOKS.md`, NOT edited into
   hooks.json yet — Fable merges) two `hooks.json` entries: `deploy-dragon-ball-z`
   (secret `Deploy@DragonBallZ`) and `deploy-dbz-web` (secret `Deploy@DBZWeb`),
   modeled on the existing `deploy-mini-missions` / `deploy-mm-ftw` blocks.
6. Add `7778` to `firewall/apply-samp-rules.sh` `SAMP_PORTS` (uncomment/extend).

---

## 6. Status — ALL COMPLETE ✅ (2026-07-19)

- [x] T11 Admin lockdown + runtime DB creds (commit 42df907)
- [x] T12 GHCR image — built by GitHub Actions, server pulls `:latest`
- [x] T13 Server provisioning — `dbz` DB+user, compose (host net, 7778),
      UFW 7778 udp+tcp, deploy-runner hook + GitHub webhook. Game LIVE on
      `95.216.9.233:7778` (external query OK, MySQL connected).
- [x] T14 Website build — `Arose-Niazi/dbz-website` (mm-website speed layer, DBZ theme)
- [x] T15 Website deploy + SSL — https://dbz-omp.arose-niazi.me (LE cert 61, forced
      SSL + HTTP/2), live status working, models CDN serving, deploy webhook wired
- [x] T16 E2E verify — UCP login confirmed against real open.mp hash (302→welcome,
      wrong pw rejected); all pages 200; docs updated

### Live endpoints
- Game: `95.216.9.233:7778` (0.3DL only)
- Web:  https://dbz-omp.arose-niazi.me  (stats · rankings · profiles · UCP)

### Where the secrets live (server only, never in repo)
- Game rcon + real config: `/opt/samp/dragon-ball-z/runtime/config.json`
- Game DB creds: `/opt/samp/dragon-ball-z/runtime/dbz_db.cfg`
- Website DB creds: `/opt/websites/dbz-omp.arose-niazi.me/.env`

### Auto-deploy
- `git push` → `openmp`  → deploys the game (git reset + `docker compose restart`)
- `git push` → `dbz-website` `main` → deploys the site (git reset + OPcache reset)
