#define FILTERSCRIPT
//
#include <a_samp>
#define MAX_INI_ENTRY_TEXT 160
#include <YSI\y_ini>
#include <dini>
#include <sscanf>
#include <streamer>
#include <irc>
#include <YSI\y_master>
#include <gl_common>
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

#define COLOR_ORANGE 0xFFA500FF

new randomid;
new randmoney;
new Text:Textdraw222;
new Text:Textdraw111;
enum PlayerData
{
	Registered,
	LoggedIn,
	Level,
	Helper,
	Tag,
	dRank,
	Muted,
	Caps,
	Jailed,
	JailTime,
	Frozen,
	FreezeTime,
	Kills,
	Deaths,
	hours,
	mins,
	secs,
	TotalTime,
	ConnectTime,
 	MuteWarnings,
	Warnings,
	Spawned,
	TimesSpawned,
	God,
	GodCar,
	DoorsLocked,
	SpamCount,
	SpamTime,
	PingCount,
	PingTime,
	blip,
	blipS,
	pColour,
	pCar,
	SpecID,
	SpecType,
	OnDuty,
	bool:AllowedIn,
	FailLogin
};
new pInfo[MAX_PLAYERS][PlayerData];

#define COLOR_SKYBLUE 0x87CEEBFF

forward BonusPlayer();
public BonusPlayer()
{
	if(randomid == INVALID_PLAYER_ID || !IsPlayerConnected(randomid))
	{
    new onlineids[MAX_PLAYERS]; // to store all online playerids
    new playersonline; // to store the amount of current online players
    new pname1[50]; // to store the chosen player's name
    for(new i=0; i<MAX_PLAYERS; i++) // loop through max amount of players (hopefully redefined from default!)
    {
        if(IsPlayerConnected(i)) // check to see if current id in the loop is connected
        {
            onlineids[playersonline] = i; // store the current id into the onlineids variable
            playersonline++; // increase the playersonline by 1
        }
        else
        {
        //print("id is not connected.");
        //SetTimer("BonusPlayer", 60*1000, 0);
        }
    }
    randmoney = random(50000 - 1000) + 1000;
    //GivePlayerMoney(playerid,randmoney);
    randomid = onlineids[random(playersonline)];
    GetPlayerName(randomid, pname1, sizeof(pname1));
    new str[200], str1[200];
    format(str1, sizeof(str1),"~p~~h~%s (%d) ~w~Has Been Selected As ~g~Bonus Player. ~w~~n~Kill Him To Get ~g~~g~$%d", pname1, randomid, randmoney);
    format(str, sizeof(str),"{FF8C00}BONUS: {00B9FF}%s (%d) {FFFFFF}Has Been Selected As Bonus Player. Kill Him To Get {73FF00}$%d", pname1, randomid, randmoney);
    TextDrawSetString(Textdraw111, str1);
    TextDrawShowForAll(Textdraw111);
	SendClientMessageToAll(-1, str);
	}
	else
	{
	new pname[50];
    GetPlayerName(randomid, pname, sizeof(pname));
    new str[200], str1[200];
    format(str1, sizeof(str1),"~p~~h~%s (%d) ~w~Has ~r~Not~w~ Been ~r~Killed~w~ Yet.", pname, randomid);
    format(str, sizeof(str),"{FF8C00}BONUS: {00B9FF}%s (%d) {FFFFFF}Has Not Been Killed Yet.", pname, randomid);
    SendClientMessageToAll(-1, str);
    TextDrawSetString(Textdraw111, str1);
    TextDrawShowForAll(Textdraw111);
	}
}
public OnFilterScriptInit ()
{
Textdraw111 = TextDrawCreate(330.000000, 412.000000, "~w~Welcome To ZTC - 1v1 Training Server. ~w~We Are Running On~y~ Version 4.2.0. /cmds1 /help~n~~w~Visit Our ~p~Website: www.1v1-ztc.tk - ~b~~h~Donate To Get VIP");
TextDrawAlignment(Textdraw111, 2);
TextDrawBackgroundColor(Textdraw111, 255);
TextDrawFont(Textdraw111, 1);
TextDrawLetterSize(Textdraw111, 0.250000, 0.799998);
TextDrawColor(Textdraw111, -1);
TextDrawSetOutline(Textdraw111, 0);
TextDrawSetProportional(Textdraw111, 1);
TextDrawSetShadow(Textdraw111, 0);
TextDrawSetSelectable(Textdraw111, 0);
TextDrawSetOutline(Textdraw111,1);

Textdraw222 = TextDrawCreate(330.000000, 394.000000, "~y~Welcome to 1v1 server. ~p~ Enjoy your stay");
TextDrawAlignment(Textdraw222, 2);
TextDrawBackgroundColor(Textdraw222, 255);
TextDrawFont(Textdraw222, 1);
TextDrawLetterSize(Textdraw222, 0.250000, 0.799998);
TextDrawColor(Textdraw222, -1);
TextDrawSetOutline(Textdraw222, 0);
TextDrawSetProportional(Textdraw222, 1);
TextDrawSetShadow(Textdraw222, 0);
TextDrawSetSelectable(Textdraw222, 0);
TextDrawSetOutline(Textdraw222,1);

SetTimer("BonusPlayer", 4*60*1000, 1);

return 1;
}
public OnPlayerDisconnect (playerid, reason)
{
     	if(randomid == playerid)
	    {
	    randomid = -1;
	    //SetTimer("BonusPlayer", 60*1000, 0);
	    randmoney =0;

	    SendClientMessage(playerid, COLOR_SKYBLUE, "* {00B9FF}BONUS: {FF0000} Player {FFFFFF}Has Been Disconnected.");
	    }
        print("BONUS PLAYER DISCONNECT CALLED");
		return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
			if(killerid == INVALID_PLAYER_ID)
			{
			pInfo[playerid][Deaths]++;
			if(randomid == playerid)
			{
			new str1[200];
			randomid = -1;
			//SetTimer("BonusPlayer", 60*1000, 0);
			new str2[200];
			new pname[MAX_PLAYER_NAME];
			GetPlayerName(playerid, pname, sizeof(pname));
			format(str2, sizeof(str2),"~g~Bonus Player ~p~~h~%s (%d) ~w~Has ~r~died ~w~in an ~y~Accident.", pname, playerid);
			TextDrawSetString(Textdraw111, str2);
			TextDrawShowForAll(Textdraw111);
			format(str1, sizeof(str1),"* Bonus: {00B9FF}%s (%d) {FFFFFF}Has Been Died In An Accident.", pname, playerid);
			SendClientMessageToAll(COLOR_ORANGE, str1);
			randmoney =0;
			}
			}
		    else
		    {
		   	if(randomid == playerid)
			{
			new str1[200];
			randomid = -1;
			//SetTimer("BonusPlayer", 60*1000, 0);
			new pname[MAX_PLAYER_NAME], kname[MAX_PLAYER_NAME];
			GetPlayerName(playerid, pname, sizeof(pname));
			GetPlayerName(killerid, kname, sizeof(pname));
		    new str2[200];

		    format(str2, sizeof(str2),"~p~~h~%s (%d) ~w~Has Killed The ~g~Bonus~w~ Player ~p~~h~%s (%d) ~w~And Won ~g~~h~$%d.",kname, killerid, pname, playerid, randmoney);
		    TextDrawSetString(Textdraw111, str2);
		    TextDrawShowForAll(Textdraw111);

			GivePlayerMoney(killerid,randmoney);
			format(str1, sizeof(str1),"* {00B9FF}%s (%d) {FFFFFF}Has Killed The Bonus Player {00B9FF}%s (%d) {FFFFFF}And Won {73FF00}$%d.",kname, killerid, pname, playerid, randmoney);
			SendClientMessageToAll(COLOR_ORANGE, str1);
			randmoney =0;
			}
			}
			return 1;
}
		
