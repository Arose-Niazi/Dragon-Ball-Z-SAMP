# Custom DBZ Models (0.3DL)

This folder holds the `.dff` / `.txd` files that open.mp serves to 0.3DL clients as
custom character skins and objects. The pipeline is already wired up — adding a new
DBZ character model takes **three lines**.

## Shipped today
- `Goku.dff` / `Goku.txd` → custom skin slot **20000** (Goku)
- `16Fighter.dff` / `16Fighter.txd` → custom skin slot **20010** (Android 16)

Every other character uses its closest stock GTA:SA skin as a fallback until a model
is added, so the server always works (0.3.7 clients also see the stock fallbacks).

## How to add a new custom character model
1. Drop `Character.dff` + `Character.txd` into this folder.
2. In `gamemodes/dbz.pwn` → `OnGameModeInit`, register it (newid must be 20000-29999,
   baseid is a stock humanoid skin for animations/voice):
   ```pawn
   AddCharModel(4, 20020, "Vegeta.dff", "Vegeta.txd");
   ```
   Add `#define SKIN_CUSTOM_VEGETA 20020` in `gamemodes/DBZ/stuff/defines.inc`.
3. In `gamemodes/DBZ/players/characters.inc` → `SetPlayerSkinMapped`, map the base
   stock id to the custom slot:
   ```pawn
   case VEGETA0: return SetPlayerSkin(playerid, SKIN_CUSTOM_VEGETA);
   ```
4. Recompile and commit both the `.dff`/`.txd` and the updated `dbz.amx`.

`config.json` already has `artwork.enable = true` and `artwork.models_path = "models"`,
so open.mp serves these files automatically (or set `artwork.cdn` to a CDN URL to
offload delivery).

## Where to find DBZ `.dff` / `.txd` models
These are community GTA:SA model sources — download, verify, and convert to `.dff`/`.txd`
as needed before adding:
- LibertyCity — [Son Goku (Dragon Ball) for GTA SA](https://libertycity.net/files/gta-san-andreas/134789-son-goku-dragon-ball.html)
- Steam Community — [GTA Dragon Ball Skin Compilation (All Transformations)](https://steamcommunity.com/sharedfiles/filedetails/?id=2117398480)
- GameBanana — [Dragon Ball mods](https://gamebanana.com/mods/cats/9186)
- 0.3DL skin/object tutorial — [How to add a custom skin/object](https://sampforum.blast.hk/showthread.php?tid=656282)
- open.mp forum — [Adding vehicles & skins (DFF/TXD)](https://forum.open.mp/showthread.php?tid=3511&pid=14840)
