# 🐉 Dragon Ball Z — SA-MP Gamemode

> A Dragon Ball Z themed roleplay & combat deathmatch gamemode for **San Andreas Multiplayer (SA-MP) 0.3z** — fight with Ki, transform into Super Saiyans, collect the seven Dragon Balls, and summon Shenron.

<!-- Badges: replace the placeholders with live shields if you host this on GitHub -->
![Platform](https://img.shields.io/badge/platform-SA--MP%200.3z-blue)
![Language](https://img.shields.io/badge/language-Pawn-orange)
![Compiler](https://img.shields.io/badge/pawn--compiler-3.2.3664-lightgrey)
![Status](https://img.shields.io/badge/status-WIP-yellow)

---

## 📖 About

**Dragon Ball Z — SA-MP** is a Dragon Ball Z themed roleplay/combat gamemode built on top of **Grand Theft Auto: San Andreas multiplayer** using the **SA-MP 0.3z** modification. Players choose a DBZ character, spawn into themed battlegrounds, and fight one another using energy attacks, transformations, flight, and fusion.

The gamemode began as **"Dragon Ball Z Death Match"** by **Sasino97** (updated by him to SA-MP 0.3z). This repository is maintained and rewritten by **Arose Niazi**. The source header preserves the original request to keep the author's name intact.

> ⚠️ **Heads-up for contributors:** the codebase originates from an older base and is only partially translated (some comments and strings remain in Italian). See the [Roadmap](#-roadmap) and [Important Caveats](#-important-caveats--known-issues).

---

## ✨ Features

### 🥋 DBZ Combat & RP Mechanics
- **Ki energy system** — Ki is the core combat resource, shown on-screen as a blue **progress bar**. Nearly every action (attacks, transform, fusion, self-destruct, regeneration) spends Ki.
- **Charging Ki (aura)** — hold the charge key to build up a glowing aura and refill Ki over time (Androids cannot charge Ki).
- **20 named special attacks** via `/att` — Kamehameha, Super Kamehameha, Big Bang Attack, Final Flash, Masenko, Burning Attack, Final Kamehameha, Big Bang Kamehameha and more. Attacks have a **10-second cooldown** and are rendered as a chain of explosions travelling forward from the player.
- **Super Saiyan transformation ladder** via `/tra` — each character climbs their own tiers (e.g. Goku: base → SSJ → SSJ2 → SSJ3), each tier scaling max Ki, health regen, self-destruct cost, and fly speed. Player color and 3D name label change per tier.
- **Fusion** via `/fus` — Goku → **Super Gogeta**, Vegeta → **Vegeku** (fusion expires on death).
- **Flight** via `/fly` — fly with up/down height control and fast/slow speed (Videl uses a dedicated flight routine).
- **Health regeneration** (`/rig`), **self-destruct** (`/kill`), and **Ki absorption** (`/absorb`, exclusive to Dr. Gero and Android 19).
- **14 playable DBZ characters** — Goku, Vegeta, Trunks, Gohan, Mr. Satan, Videl, Krillin, Yamcha, Tien, Dr. Gero, and Androids 16/17/18/19 (Androids don't use Ki).
- **Themed battlegrounds** selected at spawn (Abandoned Village, Skyscraper, Tenkaichi Tournament, Bridge, Underwater, Area 51, Casino, Space Training, plus random spawns).
- **Dragon Points (DP)** = player Score, earned from kills and spent in the living-room "Personalize" menu on attacks, max Ki, max health, Ki-ball size, speed, and fighting style.

### 🔮 Dragon Balls & Wishes
- **7 Dragon Balls** scattered across the map as collectible pickups, saved per account.
- **Dragon Radar** pickup reveals the remaining uncollected balls on the map.
- **Summon Shenron** via `/wish` once all 7 balls are collected — grants one special weapon (Sword, Knife, or Rocket Launcher). Balls and radar reset after wishing.

### 🛡️ Admin & Moderation
- **10-tier admin ladder** (`1` Trial Admin → `10` Owner) with rank titles.
- Full moderation suite: **kick, warn (3-strike auto-kick), ban, timed ban, permanent ban, account-disable, unban, jail/unjail, teleport (`/get`, `/agoto`), and instakill (`/hog`)**.
- Ban persistence by both **player name** and **IP** with unix expiry timestamps and an unban log.
- Admin/VIP online listings (`/admins`, `/vips`) and a player complaint system (`/complain`).
- Anti-spam URL/advertising filter that auto-mutes offenders.

### 👑 VIP System
- **3 VIP tiers** — Bronze, Silver, and Gold — announced on login and listed via `/vips`.

### 🧩 Filterscripts (bundled, not loaded by default)
The `filterscripts/` folder ships 14 scripts. A few are DBZ/server-adjacent (a **Bonus Player** bounty event and a **DM Tournament**); the rest are well-known public SA-MP utilities (attachments, flymode, interior explorer, speedometer, profile cards, Sharingan anti-cheat, YSI world-builder tools, minigun DM, LV Derby). **None are enabled by default** — `server.cfg` has an empty `filterscripts` line.

### 🤖 NPC Modes (bundled, disabled by default)
Kye's standard driver-NPC scripts that play back `.rec` recordings for **AT400 planes** (LS↔LV↔SF routes), **trains**, and **taxis**. Disabled by the shipped config (`maxnpc 0`).

### 🌐 PHP Web Integration
A PAWN→HTTP→PHP live-stats bridge (Y_Less's YSI `y_php`). PAWN posts player position/health/weapons each tick over SA-MP's `HTTP()` native to PHP scripts (using shared memory) that render a live web stats page. Requires PHP with the `shmop` extension; MySQL is optional.

---

## 🧰 Requirements

- **SA-MP 0.3z dedicated server**
  - Windows: `samp-server.exe` (bundled in this repo).
  - Linux: `samp03svr` — **not bundled**; obtain it from the official SA-MP 0.3z Linux server package.
- **Pawn compiler 3.2.3664** — bundled under `pawno/` (`pawncc.exe`, `pawnc.dll`, `libpawnc.dll`, plus the `pawno.exe` GUI editor).
- **Server plugins** (loaded via `server.cfg`): `streamer`, `sscanf`, `Whirlpool`, `nativechecker`. Windows `.dll` and Linux `.so` binaries are bundled in `plugins/` (except `nativechecker`, which ships **Windows-only** — see caveats).
- **Include libraries** — all bundled under `pawno/include/`: `a_samp`, `YSI\y_ini`, `progress`, `Saiyans`, `videl`, `zcmd`, `TimeStampToDate`, `sscanf2`, `foreach` (and `streamer`).
- **(Optional) amx_assembly submodule** — declared in `.gitmodules` at `pawno/include/amx` (from `github.com/Y-Less/amx_assembly`). Not checked out by default; run `git submodule update --init --recursive` if a full YSI build needs it. The submodule URL uses SSH, so switch it to HTTPS if you clone without SSH keys.

---

## 🚀 Installation & Running

> **Note:** the compiled `gamemodes/dbz.amx` is **not committed** — you must compile the gamemode before the server can start.

1. **Clone the repository.**
   ```bash
   git clone https://github.com/Arose-Niazi/Dragon-Ball-Z-SAMP.git
   cd Dragon-Ball-Z-SAMP
   ```

2. **(Optional) Initialize the submodule** if you need the amx_assembly headers for a full YSI build:
   ```bash
   git submodule update --init --recursive
   ```

3. **Compile the gamemode.** The server loads `gamemodes/dbz.amx`, so compile `gamemodes/dbz.pwn`:
   - **GUI:** open `pawno/pawno.exe`, open `gamemodes/dbz.pwn`, and press **F5**.
   - **CLI:**
     ```bash
     pawno/pawncc.exe gamemodes/dbz.pwn -o gamemodes/dbz.amx -r -w 203
     ```
     Includes resolve automatically from `pawno/include/`. (`-r -w 203` are the default flags from `pawno/settings.ini`.)

4. **Review `server.cfg`.** Confirm the plugin line and, most importantly, **change the RCON password and other defaults** (see [Configuration](#-configuration)). By default:
   ```cfg
   gamemode0 dbz 1
   plugins streamer sscanf Whirlpool nativechecker
   ```

5. **Start the server.**
   - **Windows:** run `samp-server.exe`.
   - **Linux:** add `samp03svr` from the SA-MP 0.3z Linux package, then run it. (You will also need a `nativechecker.so` — see caveats.)

6. **Connect** with a SA-MP 0.3z client to your server's IP and port (default `7777`), then register/login when prompted.

---

## 🎮 Commands

Access levels below refer to the numeric admin ladder (`Adminlevel` 0–10) used by the moderation commands. Some commands are additionally gated to specific hardcoded owner names — treat those as maintainer-only.

### Combat & Gameplay

| Command | Description | Access |
| --- | --- | --- |
| `/att` (alias `/attack`) | Fire the character's special energy attack (Kamehameha, Big Bang Attack, Final Flash, etc.). Costs Ki, 10s cooldown; rendered as a forward chain of explosions. | Everyone |
| `/tra` (aliases `/trans`, `/transform`) | Transform to the next Super Saiyan / fusion tier; changes skin, color, and label. Free in the customization room. | Everyone (fighter characters) |
| `/fus` (alias `/fusion`) | Fuse: Goku → Super Gogeta, Vegeta → Vegeku. Expires on death. | Goku & Vegeta only |
| `/fly` | Toggle flight mode (Fire = up, RMB = down, Sprint = fast, Walk = slow). | Everyone |
| `/rig` | Regenerate health; costs Ki, heals a tier-scaled amount. | Everyone |
| `/kill` | Self-destruct: explode and die (Androids free). | Everyone |
| `/absorb` *(defined as `/absrob`)* | Drain 25 HP from a nearby player. | Dr. Gero & Android 19 only |
| `/wish` | Summon Shenron once all 7 Dragon Balls are collected and choose one wish (special weapon). Resets balls afterward. Blocked in jail. | Everyone (needs 7 balls) |
| `/power` | Show the current character's combat stats (attack name, max Ki, charge speed, regen, self-destruct cost, fly speed). | Everyone |
| `/colors`, `/colors2` | List color meanings for transformation tiers and attack power thresholds. | Everyone |
| `/help`, `/help2`, `/help3` | In-game help pages describing controls and features. | Everyone |
| `/me` | Roleplay/action message broadcast to all players. | Everyone |

### Account

| Command | Description | Access |
| --- | --- | --- |
| `/register` | Set a password and create an account (forced within 3 minutes of connecting). | Unregistered players |

### Admin & Moderation

| Command | Description | Access |
| --- | --- | --- |
| `/kick [id] [reason]` | Kick a player (cannot target admins/owners). | Adminlevel ≥ 2 |
| `/warn [id] [reason]` | Warn a player; 3rd warn auto-kicks. | Adminlevel ≥ 1 |
| `/ban [id] [reason]` | Ban a player (sets account `Banned` flag). | Adminlevel ≥ 5 |
| `/banm [id] [hours] [mins] [reason]` | Timed ban written to Bans/IP files. | Adminlevel ≥ 5 *(check is buggy — see caveats)* |
| `/disablep` (alias `/accountdisable`) `[id] [days] [reason]` | Disable an account for N days. | Adminlevel ≥ 6 |
| `/banperm` (alias `/permaban`) `[id] [reason]` | Permanent ban. | Adminlevel ≥ 7 |
| `/removeban` (alias `/unban`) `[name]` | Delete ban + IP files; log to `unban_log.txt`. | Adminlevel ≥ 5 |
| `/jail [id] [minutes] [reason]` | Jail a player for N minutes. | Adminlevel ≥ 5 |
| `/unjail [id]` | Release a jailed player. | Adminlevel ≥ 5 |
| `/jailed` | List jailed players. | Adminlevel ≥ 2 |
| `/hog [id]` | Instakill target ("hand of god"; cannot target admins/owners). | Adminlevel ≥ 3 |
| `/get [id]` | Teleport a target to you. | Adminlevel ≥ 2 |
| `/agoto [id]` | Teleport yourself to a target. | Adminlevel ≥ 2 |
| `/admins` | Show online admins and ranks. | Adminlevel ≥ 1 |
| `/complain [id] [text]` | Report a player to online admins (min 5 chars). | Everyone |
| `/vips` | Show online VIPs. | Everyone *(no level check)* |
| `/ah` (alias `/acmds`) | Admin help list (legacy — see caveats). | Admin |

### Owner-only (hardcoded names)

| Command | Description | Access |
| --- | --- | --- |
| `/setlevel [id] [0-10]` | Set a player's admin level. | RCON admin **and** an owner name at level 10 |
| `/setviplevel [id] [1-3]` | Set a player's VIP tier (Bronze/Silver/Gold). | Owner names only |
| `/iamownerheresetmelevel10` | Self-promote to admin level 10 (backdoor). | Owner names only |

> ⚠️ Several commands referenced in the in-game help (`/mute`, `/freeze`, `/slap`, `/report`, `/votekick`, etc.) are advertised but **not implemented** as active handlers. See caveats.

---

## ⚙️ Configuration

Server settings live in `server.cfg`. The shipped defaults are:

```cfg
lanmode 0
rcon_password sasuke
maxplayers 50
port 7777
hostname Dragon Ball Z test
gamemode0 dbz 1
filterscripts
announce 0
query 1
chatlogging 0
plugins streamer sscanf Whirlpool nativechecker
weburl www.sa-mp.com
onfoot_rate 40
incar_rate 40
weapon_rate 40
stream_distance 300.0
stream_rate 1000
maxnpc 0
logtimeformat [%H:%M:%S]
```

### 🔐 Important security & config caveats — change before deploying!

- **`rcon_password sasuke`** — this is a weak, publicly-known default. The server itself refuses to start cleanly with it (`server_log.txt`: *"Your password must be changed from the default password"*). **Set a strong RCON password before any non-local deployment.**
- **Hardcoded owner names** — `dumb_ass`, `Sasuke_Uchiha`, and `Xeeshan` are the real basis of admin authority in the source. `/iamownerheresetmelevel10`, `/setlevel`, `/setviplevel`, and various protections key off these literal names rather than the saved admin level. **Anyone using one of these nicknames effectively owns the server** — rename them to your own before going live.
- **Hardcoded website/support** — the source embeds a legacy website (`1v1-dm.webs.com`) and support email (`dm1vs1@outlook.com`). Update or remove these.
- **PHP web bridge** — `filterscripts/y_php.pwn` points `PHP_ADDRESS` at a third-party server (`dedi.y-less.com/YSI_transfer.php`) and `PHP/YSI/YSI_settings.php` contains a hardcoded Windows path and placeholder MySQL credentials. The PHP transport is explicitly annotated in-code as *not externally safe*. Reconfigure (or disable) before use.
- **`maxplayers` / `port`** — adjust to your server's needs.
- **`maxnpc 0`** — NPCs are disabled by default; raise this if you enable the bundled NPC modes.
- **`filterscripts`** line is empty — no filterscripts load by default. Add script names here to enable them (verify their plugin/include dependencies first).

---

## 📁 Project Structure

```
Dragon-Ball-Z-SAMP/
├── dbz.pwn                     # Root gamemode source (larger/newer copy — NOT the one compiled by default)
├── server.cfg                  # Server configuration
├── server-readme.txt           # SA-MP server notes
├── samp-license.txt            # SA-MP Client/Server EULA
├── Roadmap.txt                 # (YSI library roadmap text, bundled)
├── samp-server.exe             # SA-MP 0.3z Windows server runtime
├── samp-npc.exe / announce.exe # SA-MP core binaries
├── gamemodes/
│   └── dbz.pwn                 # Gamemode compiled/loaded by server.cfg (compile to dbz.amx)
├── filterscripts/              # 14 optional filterscripts (none loaded by default)
├── npcmodes/                   # NPC driver scripts + recordings/ (.rec) — disabled by config
├── plugins/                    # Prebuilt plugins (.dll + .so): streamer, sscanf, Whirlpool,
│                               #   nativechecker, fixes2, RNPC, irc, mysql
├── fixes/                      # C++ source for the fixes2 timer plugin
├── pawno/                      # Pawn compiler, editor, and include/ libraries
│   ├── pawncc.exe / pawno.exe
│   └── include/                # a_samp, YSI, progress, Saiyans, videl, zcmd, sscanf2, foreach, ...
├── PHP/                        # PHP live web-stats bridge (YSI_live, YSI_transfer, etc.)
└── scriptfiles/
    ├── Dragonball/Users/*.ini  # Per-player accounts (hashed password, stats, dragon balls)
    └── YSI/                    # YSI runtime data, language files, live-stats snapshot
```

> ℹ️ **Two divergent gamemode sources exist.** The root `dbz.pwn` (~306 KB) is the feature-rich "main" version (10-tier admin ladder + VIP). The `gamemodes/dbz.pwn` (~268 KB) is what `server.cfg` actually compiles and loads, and it is an older/simpler variant (2-level admin, no VIP/`setlevel`/`iamownerheresetmelevel10`). **Reconcile these before building** so you don't ship stale code. Features documented above reflect the richer root file except where noted.

---

## 🗺️ Roadmap

- Move the next major version to **SA-MP 0.3DL** to support **custom skins**, targeting **[open.mp](https://open.mp/)**.
- Finish translating remaining Italian comments and strings to English.
- Reconcile the two divergent gamemode sources into a single authoritative file.
- Address the known moderation gaps and hardcoded-name backdoors (see caveats).

---

## ⚠️ Important Caveats & Known Issues

Anyone deploying or extending this repo should be aware:

- **Two divergent gamemodes** — the compiled `gamemodes/dbz.pwn` differs from the root `dbz.pwn`; only the former is loaded by default.
- **Compiled `.amx` not committed** — a fresh checkout will not run until you compile the gamemode.
- **Linux build gap** — `nativechecker` ships **Windows-only** (`nativechecker.dll`, no `.so`), so the default plugin line fails on Linux until you supply a `nativechecker.so` or remove it from `server.cfg`. `samp03svr` is also not bundled.
- **Hardcoded owner names & RCON password** — the biggest security concerns (see [Configuration](#-configuration)).
- **`/banm`** has a non-blocking permission check (missing `return`), making it usable by anyone; **`/vips`** has no level check.
- **Disabled/legacy commands** — `/mute`, `/freeze`, `/unfreeze`, `/savestats` are commented out or not implemented; `/ah` help advertises commands that lack handlers.
- **Persistence bugs** — per-skin stats (`style`/`attack`/`speed`/`HEALTHMax`/`KiMax`/`KiSize`) are saved/loaded as single values rather than per-skin arrays (lost on relog), and `dsword` is saved incorrectly.
- **Ki = money** — Ki is stored as the player's in-game money; money changes drive combat/death logic.
- **Partial translation** — expect mixed English/Italian text in source and logs.

---

## 🙏 Credits

- **Sasino97** — original *Dragon Ball Z Death Match* gamemode (updated to SA-MP 0.3z).
- **Arose Niazi** — maintenance, rewrite, and continued development of this repository.
- **Alex "Y_Less" Cole** — the **YSI** framework (`y_ini`, `y_php`, `foreach`, `sscanf2`, and the `fixes2` timer plugin), all MPL 1.1.
- **Flavio Toribio** (maintained by **Southclaw**) — `progress.inc` progress-bar library used for the Ki bar.
- **ZeeX** — `zcmd` command processor.
- **Incognito** — the `streamer` plugin (Apache 2.0).
- **The SA-MP Development Team** — SA-MP 0.3z server, `a_samp`/`a_npc` includes, and core binaries.
- **Kye (Kalcor)** — the standard NPC driver modes bundled in `npcmodes/`.
- Additional plugin/library authors whose work is bundled: **Whirlpool** (password hashing), **sscanf**, **RNPC**, **irc**, **mysql**, **nativechecker**, and the third-party filterscript authors (h02, Basss, iPLEOMAX, Double-O-Seven, Plugy, DrPepper) whose original credit headers are retained.

---

## 📜 License

This repository does **not** currently include a project-wide open-source license file for the gamemode source. The only license text bundled is **`samp-license.txt`**, which is the standard **SA-MP Client/Server EULA** (© 2005–2014 SA-MP.com team) and covers the SA-MP server binaries — **not** the gamemode code.

Individual bundled libraries carry their own licenses (predominantly **MPL 1.1** for Y_Less/YSI code and **Apache 2.0** for the streamer plugin); refer to each include's header. If you intend to redistribute or build on this project, please add an explicit license and respect the original authors' terms — the gamemode header asks that the author's name be preserved.

See [`samp-license.txt`](./samp-license.txt) for the SA-MP EULA.
