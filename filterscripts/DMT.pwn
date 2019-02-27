#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>

#define SCM SendClientMessage
#define COLOR_PURPLE 0x880088FF
#define COLOR_RED 0xFF0000FF
#define COLOR_ROYALBLUE 0x4169E1FF
#define COLOR_SKYBLUE 0x87CEEBFF
#define COLOR_GREEN 0x008000FF
    
new dm_tournament1 =0;

new Text:Textdraw23;
new Text:Textdraw24;
new Text:Textdraw25;
new Text:Textdraw26;
new Text:Textdraw27;
new Text:Textdraw28;
new Text:Textdraw29;
new Text:Textdraw30;
new Text:Textdraw31;
new Text:Textdraw32;

new gLeader = -1, gHighScore = 0, gScore[MAX_PLAYERS];
enum ginfo
{
        grname[75],
        leader,
        active
};

enum pginfo
{
        gid,
        order,
        invited,
        attemptjoin
};


public OnFilterScriptInit ()
{

SetTimer("dm_tournament", 600000, false);
Textdraw28 = TextDrawCreate(263.000000, 293.000000, "~g~DM Tournament");
TextDrawBackgroundColor(Textdraw28, 255);
TextDrawFont(Textdraw28, 3);
TextDrawLetterSize(Textdraw28, 0.539999, 1.600000);
TextDrawColor(Textdraw28, -1);
TextDrawSetOutline(Textdraw28, 1);
TextDrawSetProportional(Textdraw28, 1);
TextDrawSetSelectable(Textdraw28, 0);

Textdraw23 = TextDrawCreate(339.000000, 288.000000, "~l~~n~~n~~n~~n~~n~~n~~n~~n~");
TextDrawAlignment(Textdraw23, 2);
TextDrawBackgroundColor(Textdraw23, 255);
TextDrawFont(Textdraw23, 1);
TextDrawLetterSize(Textdraw23, 0.500000, 1.000000);
TextDrawColor(Textdraw23, -1);
TextDrawSetOutline(Textdraw23, 0);
TextDrawSetProportional(Textdraw23, 1);
TextDrawSetShadow(Textdraw23, 1);
TextDrawUseBox(Textdraw23, 1);
TextDrawBoxColor(Textdraw23, 110);
TextDrawTextSize(Textdraw23, 0.000000, 361.000000);
TextDrawSetSelectable(Textdraw23, 0);

Textdraw24 = TextDrawCreate(263.000000, 293.000000, "~g~DM Tournament");
TextDrawBackgroundColor(Textdraw24, 255);
TextDrawFont(Textdraw24, 3);
TextDrawLetterSize(Textdraw24, 0.539999, 1.600000);
TextDrawColor(Textdraw24, -1);
TextDrawSetOutline(Textdraw24, 1);
TextDrawSetProportional(Textdraw24, 1);
TextDrawSetSelectable(Textdraw24, 0);


Textdraw25 = TextDrawCreate(172.000000, 321.000000, "~r~Dm ~w~tournament is in progress. This tournament will ~y~close ~w~in ~r~10 minutes.~n~~y~Type /tournament for more info");
TextDrawBackgroundColor(Textdraw25, 255);
TextDrawFont(Textdraw25, 1);
TextDrawLetterSize(Textdraw25, 0.270000, 1.000000);
TextDrawColor(Textdraw25, -1);
TextDrawSetOutline(Textdraw25, 1);
TextDrawSetProportional(Textdraw25, 1);
TextDrawSetSelectable(Textdraw25, 0);

Textdraw26 = TextDrawCreate(250.000000, 345.000000, "~y~This box will close in: 10 seconds");
TextDrawBackgroundColor(Textdraw26, 255);
TextDrawFont(Textdraw26, 2);
TextDrawLetterSize(Textdraw26, 0.230000, 1.000000);
TextDrawColor(Textdraw26, -1);
TextDrawSetOutline(Textdraw26, 1);
TextDrawSetProportional(Textdraw26, 1);
TextDrawSetSelectable(Textdraw26, 0);

Textdraw27 = TextDrawCreate(339.000000, 288.000000, "~l~~n~~n~~n~~n~~n~~n~~n~~n~");
TextDrawAlignment(Textdraw27, 2);
TextDrawBackgroundColor(Textdraw27, 255);
TextDrawFont(Textdraw27, 1);
TextDrawLetterSize(Textdraw27, 0.500000, 1.000000);
TextDrawColor(Textdraw27, -1);
TextDrawSetOutline(Textdraw27, 0);
TextDrawSetProportional(Textdraw27, 1);
TextDrawSetShadow(Textdraw27, 1);
TextDrawUseBox(Textdraw27, 1);
TextDrawBoxColor(Textdraw27, 110);
TextDrawTextSize(Textdraw27, 0.000000, 361.000000);
TextDrawSetSelectable(Textdraw27, 0);

Textdraw28 = TextDrawCreate(263.000000, 293.000000, "~g~DM Tournament");
TextDrawBackgroundColor(Textdraw28, 255);
TextDrawFont(Textdraw28, 3);
TextDrawLetterSize(Textdraw28, 0.539999, 1.600000);
TextDrawColor(Textdraw28, -1);
TextDrawSetOutline(Textdraw28, 1);
TextDrawSetProportional(Textdraw28, 1);
TextDrawSetSelectable(Textdraw28, 0);


Textdraw29 = TextDrawCreate(181.000000, 314.000000, "~r~Dm ~w~tournament is ended, ~y~results ~w~are below:");
TextDrawBackgroundColor(Textdraw29, 255);
TextDrawFont(Textdraw29, 1);
TextDrawLetterSize(Textdraw29, 0.240000, 1.000000);
TextDrawColor(Textdraw29, -1);
TextDrawSetOutline(Textdraw29, 1);
TextDrawSetProportional(Textdraw29, 1);
TextDrawSetSelectable(Textdraw29, 0);

Textdraw30 = TextDrawCreate(250.000000, 345.000000, "~y~This box will close in: 10 seconds");
TextDrawBackgroundColor(Textdraw30, 255);
TextDrawFont(Textdraw30, 2);
TextDrawLetterSize(Textdraw30, 0.230000, 1.000000);
TextDrawColor(Textdraw30, -1);
TextDrawSetOutline(Textdraw30, 1);
TextDrawSetProportional(Textdraw30, 1);
TextDrawSetSelectable(Textdraw30, 0);

Textdraw31 = TextDrawCreate(182.000000, 328.000000, "~w~Player ~y~Sasuke_Uchiha. (0) ~w~has ~p~Won ~w~Dm Tournament With ~p~~h~99 ~w~~r~Kills");
TextDrawBackgroundColor(Textdraw31, 255);
TextDrawFont(Textdraw31, 1);
TextDrawLetterSize(Textdraw31, 0.290000, 1.000000);
TextDrawColor(Textdraw31, -1);
TextDrawSetOutline(Textdraw31, 1);
TextDrawSetProportional(Textdraw31, 1);
TextDrawSetSelectable(Textdraw31, 0);


Textdraw32 = TextDrawCreate(556.000000, 400.000000, "~w~Dm Tournament:~n~~g~0:00");
TextDrawAlignment(Textdraw32, 2);
TextDrawBackgroundColor(Textdraw32, 255);
TextDrawFont(Textdraw32, 1);
TextDrawLetterSize(Textdraw32, 0.270000, 0.899999);
TextDrawColor(Textdraw32, -1);
TextDrawSetOutline(Textdraw32, 1);
TextDrawSetProportional(Textdraw32, 1);
TextDrawSetSelectable(Textdraw32, 0);

return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    if(dm_tournament1 == 1)
	{
    ++gScore[killerid];
    if (gScore[killerid] > gHighScore)
    {
    gHighScore = gScore[killerid];
    gLeader = killerid;
    }
	}
	
	return 1;
}

public OnPlayerSpawn(playerid)
{

    if(dm_tournament1 == 1)
    {
    TextDrawShowForPlayer(playerid, Textdraw32);
    }
   	return 1;
}

CMD:tournament(playerid, params[])
{
        #pragma unused params
       	if(dm_tournament1 == 1)
	    {
	    SendClientMessage(playerid, COLOR_PURPLE,"DM torunament is in progress. Try to kill most opponents to get some special rewards!");
	    }
	    else
	    {
	    SCM(playerid, COLOR_RED,"A DM torunament will start shortly. Visit later!");
	    }
        return 1;
}
CMD:test(playerid, params[])
{
    #pragma unused params
    SCM(playerid, COLOR_ROYALBLUE,"test");
    SetTimer("dm_tournament", 1000, false);
    return 1;
}
forward dm_tournament();
//new amount1 =5;

new htt;
new htt2;
new TM1;
new started =0;
public dm_tournament()
{
if(started == 0)
{
SendClientMessageToAll(COLOR_SKYBLUE, "Dm tournament is in progress it will close in 10 minutes.");
TextDrawShowForAll(Textdraw23);
TextDrawShowForAll(Textdraw24);
TextDrawShowForAll(Textdraw25);
TextDrawShowForAll(Textdraw26);
TextDrawShowForAll(Textdraw32);
dm_tournament1 =1;
SetTimer("dm_tournament_end", 600000, false);
TM1 = SetTimer("TM", 1000, true);
htt = SetTimer("hide_tournament_textdraws", 1000, false);
started =1;
}
//SetTimerEx("hide_tournament_textdraws", interval, false, "ii", amount1 - 1, interval);
}

forward dm_tournament_end();
public dm_tournament_end()
{
SetTimer("dm_tournament", 600000, false);
dm_tournament1 =0;
TextDrawHideForAll(Textdraw32);
//SCM(gLeader, COLOR_RED,"Test");
TextDrawShowForAll(Textdraw27);
TextDrawShowForAll(Textdraw28);
TextDrawShowForAll(Textdraw29);
started =0;
TextDrawShowForAll(Textdraw30);
//TextDrawShowForAll(Textdraw31);
htt2 = SetTimer("hide_tournament_textdraws2", 1000, false);
new str2[200], name1[MAX_PLAYER_NAME];
GetPlayerName(gLeader, name1, sizeof(name1));
// gHighScore
if(gLeader == INVALID_PLAYER_ID || !IsPlayerConnected(gLeader))
{
format(str2, sizeof(str2),"~r~None ~w~Won Dm Tournament.");
}
else
{
format(str2, sizeof(str2),"~w~Player ~y~%s (%d) ~w~has ~p~Won ~w~Dm Tournament With ~p~~h~%d ~w~~r~Kills", name1, gLeader, gHighScore);
SCM(gLeader, COLOR_GREEN, "You Won Dm Tournament! +50 Score and Won $100000");
	//new Float:score
SetPlayerScore(gLeader, GetPlayerScore(gLeader)+ 50);
GivePlayerMoney(gLeader, 100000);
GameTextForPlayer(gLeader,"~g~~h~Won Dm Tournament!", 3000, 3);
}
TextDrawSetString(Textdraw31, str2);
TextDrawShowForAll(Textdraw31);
gHighScore =0;
gLeader =-1;
KillTimer(TM1);
}

new tournament =10;
new tournament2 =10;
forward hide_tournament_textdraws(playerid);
forward hide_tournament_textdraws2(playerid);
public hide_tournament_textdraws(playerid)
{

if(tournament == 1)
{
TextDrawHideForAll(Textdraw23);
TextDrawHideForAll(Textdraw24);
TextDrawHideForAll(Textdraw25);
TextDrawHideForAll(Textdraw26);
tournament =10;
KillTimer(htt);
new str2[200];
format(str2, sizeof(str2),"~y~This box will close in: 10 seconds");
TextDrawSetString(Textdraw26, str2);
//TextDrawShowForAll(Textdraw26);
}
else
{
tournament--;
new str2[200];
format(str2, sizeof(str2),"~y~This box will close in: %d seconds", tournament);
TextDrawSetString(Textdraw26, str2);
TextDrawShowForAll(Textdraw26);
htt = SetTimer("hide_tournament_textdraws", 1000, false);
}

}



public hide_tournament_textdraws2(playerid)
{

if(tournament2 == 1)
{
TextDrawHideForAll(Textdraw27);
TextDrawHideForAll(Textdraw28);
TextDrawHideForAll(Textdraw29);
TextDrawHideForAll(Textdraw30);
TextDrawHideForAll(Textdraw31);
tournament2 =10;
KillTimer(htt2);
new str2[200];
format(str2, sizeof(str2),"~y~This box will close in: 10 seconds");
TextDrawSetString(Textdraw30, str2);
//TextDrawShowForAll(Textdraw26);
}
else
{
tournament2--;
new str2[200];
format(str2, sizeof(str2),"~y~This box will close in: %d seconds", tournament);
TextDrawSetString(Textdraw30, str2);
TextDrawShowForAll(Textdraw30);
htt2 = SetTimer("hide_tournament_textdraws2", 1000, false);
}

}
new DMTime = 00;
new DMMinute = 00;

forward TM(playerid);
public TM(playerid)
{
    DMMinute++;
    new string[48];
    if(DMMinute < 10)
    {
    format(string, sizeof(string), "~w~Dm Tournament:~n~~g~~h~%d:0%d", DMTime, DMMinute);
    }
    else
    {
    format(string, sizeof(string), "~w~Dm Tournament:~n~~g~~h~%d:%d", DMTime, DMMinute);
    }
    if(DMMinute == 59)//if servetime variable is at 23 it puts it the variable to 0
    {
        DMMinute = 00;
        DMTime++;
    }
    if(DMTime == 10)//if servetime variable is at 23 it puts it the variable to 0
    {
        DMTime = 0;
        format(string, sizeof(string), "~w~Dm Tournament:~n~~r~Over!");
    }
    TextDrawSetString(Textdraw32,string);

    return 1;
}

