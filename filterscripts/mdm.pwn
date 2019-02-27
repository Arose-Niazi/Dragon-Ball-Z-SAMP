/*
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.

	---------------------------------------------------------------------

	FilterScript: Minigun Death Match - This is an old filterscript of mine that was created from scratch.
	Ideas are based from Impulse99/Awesome Stuntages Map.
	Creator: DrPepper
	Date Start: 9/30/11

	---------------------------------------------------------------------
*/

// Includes
#include <a_samp>

// Defines
#define FILTERSCRIPT

// Colour Defines
#define COLOR_GREEN 		0xB1FB44FF
#define COLOR_RED 			0xFF444499
#define COLOR_YELLOW 		0xFFFF00AA
#define COLOR_WHITE 		0xFFFFFFAA
#define COLOR_SYSTEM 		0x00F6F6AA
#define COLOR_BLACK 		0x000000AA
#define COLOR_BLUE 			0x0066F6AA
#define COLOR_GREY 			0x7A7979AA
#define COLOR_ORANGE 		0xFF9900AA
#define COLOR_PINK 			0xF600F6AA
#define COLOR_PURPLE 		0x9F00F6AA
#define COLOR_LIGHTBLUE 	0x33CCFF19

// Variables
new szString[256]; // String for messages
new InMDM[MAX_PLAYERS]; // Determines if a player is in the Minigun DM or not.

new Float:MDMSpawns[][4] = { // Random Minigun DM Spawns (So that players aren't spawned in the same place.)
	{2205.4531,1613.0443,999.9776,4.9999},
	{2218.2949,1613.3134,999.9827,2.7241},
	{2193.5117,1625.7844,999.9706,177.5425},
	{2181.9653,1577.2335,999.9650,6.7742},
	{2228.2803,1594.2496,999.9643,95.4250},
	{2220.1484,1554.7620,1004.7244,353.9040}
};

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Minigun DM Filterscript");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else
#endif

public OnPlayerConnect(playerid)
{
    InMDM[playerid] = 0; // Makes the player set as not in the Minigun DM (Prevents other player's from being bugged.)
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	InMDM[playerid] = 0; // Makes the player set as not in the Minigun DM (Prevents other player's from being bugged.)
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(InMDM[playerid] == 1) { // Determines that the player is in the Minigun DM. When he is killed, and /mdm = 1, he will be teleported back to the DM.
		SetPlayerInterior(playerid, 1); // Interior = 1
		SetPlayerVirtualWorld(playerid, 10); // Virtual World = 10
		new rand = random(sizeof(MDMSpawns)); // MDM Spawn Variable
		SetPlayerPos(playerid, MDMSpawns[rand][0], MDMSpawns[rand][1], MDMSpawns[rand][2]); // Random Player Position for MDM
		SetPlayerFacingAngle(playerid, MDMSpawns[rand][3]); // Face Angle
		GivePlayerWeapon(playerid, 38, 9999); // Minigun
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mdm", cmdtext, true, 4) == 0) // /mdm command
	{
		new PlayerName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
	    if(InMDM[playerid] == 0) { // Player is currently not in /mdm
	        InMDM[playerid] = 1; // Since player is not in /mdm InMDM = 1 (When player dies, player automatically sent to /mdm)
								 // If player retypes /mdm and InMDM = 1, player will not be teleported to MDM
			SendClientMessage(playerid, COLOR_GREEN, "* You have joined /mdm you will automatically join after death.");
			SendClientMessage(playerid, COLOR_GREEN, "* To disable auto-join or leave /mdm you must type /mdm again.");
			format(szString, sizeof(szString), " %s (ID:%d) has joined the Minigun DM (/mdm).", PlayerName, playerid);
	  		SendClientMessageToAll(COLOR_YELLOW, szString);
	  		SetPlayerInterior(playerid, 1); // Interior = = 1
			SetPlayerVirtualWorld(playerid, 10); // Virtual World = 10
			new rand = random(sizeof(MDMSpawns)); // Variable
			SetPlayerPos(playerid, MDMSpawns[rand][0], MDMSpawns[rand][1], MDMSpawns[rand][2]); // Rnadom MDM Spawns
			SetPlayerFacingAngle(playerid, MDMSpawns[rand][3]); // Face Angle
			GivePlayerWeapon(playerid, 38, 9999); // Minigun
		}
		else {
		    InMDM[playerid] = 0; // Player doesn't want to be in /mdm anymore. InMDM is now set to 0
		    SendClientMessage(playerid, COLOR_GREEN, "* You have left /mdm to rejoin type /mdm again.");
		    SpawnPlayer(playerid);
		    SetPlayerHealth(playerid, 100);
	     	ResetPlayerWeapons(playerid);
		    SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
		}
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
