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

## Migration — Milestones (all complete ✅)

1. ✅ **Scaffold** — compiling + booting open.mp server, Pawn.CMD, custom-model registration.
2. ✅ **Accounts** — MySQL persistence, register/login (SHA256+salt), admin/VIP, moderation.
3. ✅ **Real Ki** — `gKi` var + `progress2` HUD bar; 14-char class selection + battlegrounds.
4. ✅ **Combat + keypress shortcuts** (OnPlayerKeyStateChange) — attacks/transform/fusion/fly/regen/kill/absorb/charge.
5. ✅ **Custom skins** — CustomModels + artwork; Goku/Android16 shipped, stock fallbacks, `SetPlayerSkinMapped` (see `models/README.md`).
6. ✅ **Dragon Balls** — 7 balls + radar (`balls_mask`) + `/wish`.
7. ✅ **Polish** — English throughout, security (config owners, fresh secrets), test/prod configs.

### Module map (`gamemodes/DBZ/`)
`stuff/{defines,colors,skins,dialog_ids,ranks,server_vars,db_config}` ·
`players/{data,perms,characters,ki,combat,spawn,movement,database,accounts,timers,dialogs}` ·
`world/{battlegrounds,dragonballs}` · `cmds/{admin,moderation,combat_cmds,cmds}`.

## Recorded Decisions (Milestone 0)

- **Location:** `openmp` branch of this repo; legacy 0.3z moved to `legacy/`.
- **Persistence:** **MySQL** (maddinat0r R41 plugin; async `mysql_pquery` + cache API).
  Credentials in `gamemodes/DBZ/stuff/db_config.inc` (`LOCAL_DB` toggle). Connection
  failure is non-fatal (guest mode) so the server boots without a DB. Requires
  `log-core` + `libmariadb` (bundled).
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
