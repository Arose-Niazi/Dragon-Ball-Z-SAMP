# CLAUDE.md

Guidance for Claude Code when working in this repository (the **open.mp / 0.3DL**
rebuild of the Dragon Ball Z gamemode).

## Project Overview

A ground-up rebuild of the classic *Dragon Ball Z Deathmatch* gamemode (SA-MP 0.3z,
originally by Sasino97) on the modern **open.mp** framework with **SA-MP 0.3DL**
custom models. The legacy 0.3z source is preserved under `legacy/` and tagged
`v0.3z` on `master`. This work lives on the `openmp` branch.

Modeled on the sibling project `../Mini-Missions` (same open.mp toolchain).

## Build Commands

**Compiler: QAWNO** (`qawno/pawncc.exe` on Windows, `qawno/pawncc` on Linux,
`qawno/mac/pawncc` on macOS). Do **NOT** use `pawno` — the legacy compiler lives
under `legacy/pawno/` only.

Compile the gamemode (Windows):
```bash
qawno/pawncc.exe "-;+" "-(+" "-\\" "-Z-" "-igamemodes" "-igamemodes/dbz" "-iqawno/include" -d3 -t4 "-ogamemodes/dbz" "gamemodes/dbz.pwn" WINDOWS_COMPILER=1
```
Linux/CI (drop the trailing `WINDOWS_COMPILER=1`, use `./qawno/pawncc`):
```bash
./qawno/pawncc "-;+" "-(+" "-\\" "-Z-" "-igamemodes" "-igamemodes/dbz" "-iqawno/include" -d3 -t4 "-ogamemodes/dbz" "gamemodes/dbz.pwn"
```
> Note the `-igamemodes` include path — it lets `#include "DBZ\..."` resolve from
> the `gamemodes/` directory. In VS Code, **Ctrl+Shift+B** runs the "Compile" task
> on the open file (already patched with `-i${fileDirname}`).

Run locally: `omp-server.exe` (Windows) / `./omp-server` (Linux) from the repo root
(reads `config.json`). Test config: `omp-server.exe --config config.test.json`.

**Always recompile and commit `gamemodes/dbz.amx`** after changing `dbz.pwn` or any
`gamemodes/DBZ/*.inc` — production runs the committed binary.

## Architecture

- **`gamemodes/dbz.pwn`** — entry point. Includes open.mp, Pawn.RakNet, foreach
  (`FOREACH_MULTISCRIPT`), Pawn.CMD, sscanf2, crashdetect, then the DBZ modules.
- **`gamemodes/DBZ/`** — module tree (mirrors Mini-Missions' `MM/`):
  - `stuff/` — `defines`, `colors`, `dialog_ids`, `server_vars`
  - `players/` — `data` (player enum + class roster); accounts/Ki added in M2/M3
  - `cmds/` — Pawn.CMD command handlers
  - `textdraws/` — HUD/connect textdraws
- Every subfolder `#include` uses the `#if defined WINDOWS_COMPILER` conditional
  (backslash paths on Windows, forward-slash otherwise).
- open.mp **components** (`components/`) auto-load — do NOT list them in config.
  Only true legacy plugins go in `config.json → pawn.legacy_plugins` (just
  `crashdetect` right now).

## Key Dependencies

open.mp (framework) · QAWNO (Pawn 3.10) · **Pawn.CMD** (commands, not zcmd) ·
sscanf2 · foreach · Pawn.RakNet · crashdetect · CustomModels component (0.3DL skins/objects).

## Migration — Milestones

1. ✅ **Scaffold** — compiling + booting open.mp server, Pawn.CMD, custom-model registration.
2. Accounts — SQLite persistence, register/login, admin/VIP.
3. Real Ki — drop the Ki-as-money hack → `gKi` var + `progress2` HUD bar.
4. Combat + **keypress shortcuts** (OnPlayerKeyStateChange).
5. Custom skins — CustomModels + artwork; ship Goku/Android16, stock fallbacks + web-sourced models.
6. Custom objects — 7 Dragon Balls + Radar.
7. Polish — translate Italian, security sweep, test/prod configs.

## Recorded Decisions (Milestone 0)

- **Location:** `openmp` branch of this repo; legacy 0.3z moved to `legacy/`.
- **Persistence:** open.mp **SQLite** (Databases component) — in-process, no server.
- **Owners/staff:** config-seeded flag / DB role. The legacy hardcoded owner names
  (`dumb_ass`, `Sasuke_Uchiha`, `Xeeshan`) and the `/iamownerheresetmelevel10`
  backdoor are **removed** — never reintroduce name-based auth.
- **`allow_037_clients`:** true — 0.3.7 clients connect but see stock-skin fallbacks.
- **Secrets:** never commit real secrets. `config.json` ships a placeholder rcon
  password (`CHANGE_ME_dbz_rcon_2026`) — rotate before any public deploy. Never copy
  Mini-Missions' committed secrets.
- **Dropped** the legacy 299-slot per-skin customization (only element[0] ever persisted).
- **Custom models:** Goku + Android 16 (`.dff/.txd` reused from Mini-Missions) ship
  today; the other 12 characters use stock GTA fallbacks until art is sourced.

## Conventions

- `.pdb` debug symbols are gitignored to slim the repo (components/plugins ship
  `.dll` + `.so` only).
- Vendored toolchains (`qawno/`, `components/`, `plugins/`, `legacy/`) are marked
  `linguist-vendored`.
