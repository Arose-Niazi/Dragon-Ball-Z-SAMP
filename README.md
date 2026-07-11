# 🐉 Dragon Ball Z — open.mp / 0.3DL

> The next-generation rebuild of the classic **Dragon Ball Z Deathmatch** gamemode —
> rebuilt from the ground up on the modern **[open.mp](https://open.mp/)** framework
> with **SA-MP 0.3DL** custom models, real Ki mechanics, and keypress-driven combat.

![Platform](https://img.shields.io/badge/platform-open.mp%20%7C%200.3DL-brightgreen)
![Language](https://img.shields.io/badge/language-Pawn-orange)
![Compiler](https://img.shields.io/badge/compiler-QAWNO%203.10-blue)
![Status](https://img.shields.io/badge/status-Milestone%201%20%E2%9C%94-yellow)

> 🧬 This is the **`openmp` branch** — the active rewrite. The original SA-MP **0.3z**
> gamemode is preserved under [`legacy/`](./legacy) and released as
> [**v0.3z**](https://github.com/Arose-Niazi/Dragon-Ball-Z-SAMP/releases/tag/v0.3z).

---

## 📖 About

A Dragon Ball Z themed combat/RP gamemode for **Grand Theft Auto: San Andreas**
multiplayer, running on **open.mp** with the **0.3DL** downloadable-content client so
players get real DBZ character skins and props. Fight with Ki energy, climb the Super
Saiyan transformation ladder, fly, fuse, collect the seven Dragon Balls, and summon
Shenron.

Originally *Dragon Ball Z Deathmatch* by **Sasino97**; rebuilt and maintained by
**Arose Niazi**.

---

## ✨ What's new vs. the 0.3z legacy

| Area | Legacy 0.3z | open.mp / 0.3DL rebuild |
|------|-------------|-------------------------|
| Server | SA-MP 0.3z (`samp-server`) | **open.mp** (`omp-server`) + components |
| Compiler | pawno (Pawn 3.2) | **QAWNO** (Pawn 3.10) |
| Commands | zcmd, all typed | **Pawn.CMD** + **keypress shortcuts** (no typing to fight) |
| Ki | stored as player *money* (hack) | real `Ki` variable + `progress2` HUD bar |
| Skins | stock GTA skins only | **0.3DL custom models** (Goku, Android 16, …) |
| Dragon Balls / Radar | stock pickups | custom objects (planned) |
| Persistence | `y_ini` flat files | **MySQL** (async, R41 plugin) |
| Security | hardcoded owner names + backdoor | config-driven roles, no backdoors |

---

## 🎮 Planned action shortcuts (Milestone 4)

No more typing commands mid-fight — DBZ actions map to keys:

| Key / combo | Action |
|-------------|--------|
| **Fire** | Fire energy attack / beam (Kamehameha, etc.) |
| **MMB (hold)** | Charge Ki (aura) |
| **Sub-mission** | Transform to next form |
| **Y** | Toggle flight |
| Fire / RMB (flying) | Ascend / descend |
| Sprint / Walk (flying) | Fast / slow flight |
| **Crouch** | Regen / meditate |
| **NO (hold ~2s)** | Self-destruct |
| **Y + Sprint** near a player | Fusion |
| Secondary attack | Absorb (Dr. Gero / Android 19) |

Commands (`/att`, `/fly`, `/transform`, …) remain as a fallback. Type `/keys` in-game.

---

## 🧰 Requirements

- **open.mp server** (`omp-server` / `omp-server.exe`) — bundled.
- **QAWNO** Pawn compiler — bundled under `qawno/`.
- **open.mp components** (`components/`) — bundled; auto-load.
- **Legacy plugin:** `crashdetect` — bundled under `plugins/`.
- A **SA-MP 0.3DL** client to see custom models (0.3.7 clients connect with stock-skin fallbacks).

Everything needed to build and run is committed to the repo (self-contained, like the
`Mini-Missions` reference project).

---

## 🚀 Build & Run

```bash
# 1. Clone and switch to the openmp branch
git clone -b openmp https://github.com/Arose-Niazi/Dragon-Ball-Z-SAMP.git
cd Dragon-Ball-Z-SAMP

# 2. Compile the gamemode with QAWNO (Windows)
qawno/pawncc.exe "-;+" "-(+" "-\\" "-Z-" "-igamemodes" "-igamemodes/dbz" "-iqawno/include" -d3 -t4 "-ogamemodes/dbz" "gamemodes/dbz.pwn" WINDOWS_COMPILER=1
#    (Linux/CI: use ./qawno/pawncc and drop WINDOWS_COMPILER=1)
#    In VS Code: press Ctrl+Shift+B.

# 3. Run
omp-server.exe                         # Windows
./omp-server                           # Linux
omp-server.exe --config config.test.json   # local test config (port 7778, LAN)
```

Then connect a SA-MP 0.3DL client to your server IP on port **7777**.

> ⚠️ **Before deploying:** change the placeholder RCON password in `config.json`
> (`CHANGE_ME_dbz_rcon_2026`). Never commit real secrets.

---

## 📁 Project structure

```
Dragon-Ball-Z-SAMP/  (openmp branch)
├── gamemodes/
│   ├── dbz.pwn              # gamemode entry point (compile → dbz.amx)
│   └── DBZ/                 # module tree
│       ├── stuff/           # defines, colors, dialog_ids, server_vars
│       ├── players/         # data (player enum + class roster)
│       ├── cmds/            # Pawn.CMD command handlers
│       └── textdraws/       # HUD / connect screen
├── components/              # open.mp components (auto-load)
├── plugins/                 # legacy plugins (crashdetect)
├── qawno/                   # QAWNO compiler + modern includes
├── models/                  # 0.3DL custom models (Goku, Android 16)
├── config.json             # open.mp server config
├── config.test.json        # local test config
├── compile.py              # batch filterscript compiler
├── Dockerfile / *.yml      # containerized deployment
└── legacy/                  # preserved SA-MP 0.3z gamemode (reference)
```

---

## 🗺️ Roadmap — all milestones complete ✅

1. ✅ **Scaffold** — compiling + booting open.mp server (Pawn.CMD, custom-model registration).
2. ✅ **Accounts** — MySQL persistence, register/login (SHA256+salt), admin ladder + VIP, moderation (config-driven owners, no backdoors).
3. ✅ **Real Ki** — `gKi` stat + progress2 HUD bar (money hack removed); 14-character class selection + battlegrounds.
4. ✅ **Combat + keypress shortcuts** — attacks, transforms, fusion, fly, regen, self-destruct, absorb, charge.
5. ✅ **Custom skins** — CustomModels + artwork pipeline (Goku + Android 16 shipped; [drop-in for more](./models/README.md)).
6. ✅ **Dragon Balls** — 7 collectible balls + radar + `/wish` Shenron.
7. ✅ **Polish** — English throughout, security hardening, test/prod configs.

> Set your MySQL credentials in `gamemodes/DBZ/stuff/db_config.inc` and your owner
> nick(s) in `gamemodes/DBZ/stuff/server_vars.inc`. The server boots and runs even
> without a database (unsaved guest mode) so you can test immediately.

See [`CLAUDE.md`](./CLAUDE.md) for build conventions and recorded design decisions.

---

## 🙏 Credits

- **Sasino97** — original *Dragon Ball Z Deathmatch* gamemode.
- **Arose Niazi** — open.mp rebuild & maintenance.
- **The open.mp team** — server framework & components.
- **katursis** — Pawn.CMD & Pawn.RakNet · **Y_Less** — sscanf2 · **Zeex** — crashdetect · **Southclaw** — progress2 · **Incognito** — streamer.

## 📜 License

The bundled server binaries and includes carry their own licenses (see each). The
legacy SA-MP EULA is preserved at [`legacy/samp-license.txt`](./legacy/samp-license.txt).
