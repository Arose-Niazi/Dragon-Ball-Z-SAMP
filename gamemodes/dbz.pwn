/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                    Scripted By : SaNOke_Uchiha aka AroseKhanNiazi                                    //
//                                                             Base Version By : Sasino97                                               //
//                                             Translation by : SaNOke_Uchiha (Thanks to Google Translator)                             //
//                                                            Special Thanks To : Sasino97                                              //
//                                                       For Allowing me to edit and release it.                                        //
//                                                      Thanks to 'toribio' for the flying script.                                      //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
*/

//-=-=-=-=-=INCLUDES=-=-=-=-=-

#include <a_samp>           
#include <YSI\y_ini>          
#include <progress>         
#include <Saiyans>
#include <videl>
#include <zcmd>
#include <TimeStampToDate>
#include <sscanf2>
#include <foreach>
#include <DragonBall>

//-=-=-=-=-=DEFINES=-=-=-=-=-
#define website "YourWeb.host"
#define Support_email "youreamil@web.host"

//-=-=-=-=-=Colours=-=-=-=-=-

#define COLOR_RED         	  0xFF0000AA
#define COLOR_GREEN       	  0x33AA33AA
#define COLOR_YELLOW       	  0xFFFF00AA
#define COLOR_ORANGE      	  0xFF9900AA
#define COLOR_BLUE        	  0x0000BB00
#define COLOR_BLACK       	  0x000000FF
#define COLOR_WHITE       	  0xFFFFFFAA
#define COLOR_ADMIN       	  0x24FF0AB9
#define COLOR_ALPHA       	  0xABCDEF02
#define COLOR_PINK            0xFF66FFAA
#define COLOR_VIOLET      	  0x9955DEEE
#define COLOR_GREY        	  0xAFAFAFAA
#define COLOR_LIGHTBLUE   	  0x33CCFFAA
#define COLOR_KICK/BAN        0xFF00FFAA
#define COLOR_HOTPINK 		  0xFF69B4FF
#define COLOR_BROWN           0xA52A2AFF
#define COLOR_CYAN 			  0x00FFFFFF
#define COLOR_MAROON 		  0x800000FF

//----------Sounds---------//

#define SOUND_CEILING_VENT_LAND  1002
#define SOUND_BONNET_DENT  1009
#define SOUND_CRANE_MOVE_START  1020
#define SOUND_CRANE_MOVE_STOP  1021
#define SOUND_CRANE_EXIT  1022
#define SOUND_WHEEL_OF_FORTUNE_CLACKER  1027
#define SOUND_SHUTTER_DOOR_START  1035
#define SOUND_SHUTTER_DOOR_STOP  1036
#define SOUND_PARACHUTE_OPEN  1039
#define SOUND_AMMUNATION_BUY_WEAPON  1052
#define SOUND_AMMUNATION_BUY_WEAPON_DENIED  1053
#define SOUND_SHOP_BUY  1054
#define SOUND_SHOP_BUY_DENIED  1055
#define SOUND_RACE_321  1056
#define SOUND_RACE_GO  1057
#define SOUND_PART_MISSION_COMPLETE  1058
#define SOUND_GOGO_TRACK_START  1062 //music
#define SOUND_GOGO_TRACK_STOP  1063 //music
#define SOUND_DUAL_TRACK_START  1068 //music
#define SOUND_DUAL_TRACK_STOP  1069 //music
#define SOUND_BEE_TRACK_START  1076 //music
#define SOUND_BEE_TRACK_STOP  1077 //music
#define SOUND_ROULETTE_ADD_CASH  1083
#define SOUND_ROULETTE_REMOVE_CASH  1084
#define SOUND_ROULETTE_NO_CASH  1085
#define SOUND_BIKE_PACKER_CLUNK  1095
#define SOUND_AWARD_TRACK_START  1097 //music
#define SOUND_AWARD_TRACK_STOP  1098 //music
#define SOUND_MESH_GATE_OPEN_START  1100
#define SOUND_MESH_GATE_OPEN_STOP  1101
#define SOUND_PUNCH_PED  1130
#define SOUND_AMMUNATION_GUN_COLLISION  1131
#define SOUND_CAMERA_SHOT  1132
#define SOUND_BUY_CAR_MOD  1133
#define SOUND_BUY_CAR_RESPRAY  1134
#define SOUND_BASEBALL_BAT_HIT_PED  1135
#define SOUND_STAMP_PED  1136
#define SOUND_CHECKPOINT_AMBER  1137
#define SOUND_CHECKPOINT_GREEN  1138
#define SOUND_CHECKPOINT_RED  1139
#define SOUND_CAR_SMASH_CAR  1140
#define SOUND_CAR_SMASH_GATE  1141
#define SOUND_OTB_TRACK_START  1142
#define SOUND_OTB_TRACK_STOP  1143
#define SOUND_PED_HIT_WATER_SPLASH  1144
#define SOUND_RESTAURANT_TRAY_COLLISION  1145
#define SOUND_SWEETS_HORN  1147
#define SOUND_MAGNET_VEHICLE_COLLISION  1148
#define SOUND_PROPERTY_PURCHASED  1149
#define SOUND_PICKUP_STANDARD  1150
#define SOUND_GARAGE_DOOR_START  1153
#define SOUND_GARAGE_DOOR_STOP  1154
#define SOUND_PED_COLLAPSE  1163
#define SOUND_SHUTTER_DOOR_SLOW_START  1165
#define SOUND_SHUTTER_DOOR_SLOW_STOP  1166
#define SOUND_RESTAURANT_CJ_PUKE  1169
#define SOUND_DRIVING_AWARD_TRACK_START  1183 //music
#define SOUND_DRIVING_AWARD_TRACK_STOP  1184
#define SOUND_BIKE_AWARD_TRACK_START  1185 //music
#define SOUND_BIKE_AWARD_TRACK_STOP  1186
#define SOUND_PILOT_AWARD_TRACK_START  1187 //music
#define SOUND_PILOT_AWARD_TRACK_STOP  1188
#define SOUND_SLAP  1190

//Define short characters names

#define GOKU0 124
#define GOKU1 247
#define GOKU2 100
#define GOKU3 248
#define VEGETA0 96
#define VEGETA1 291
#define VEGETAS 72
#define VEGETA2 147
#define TRUNKS0 217
#define TRUNKS1 101
#define TRUNKSS 97
#define GOHAN0 176
#define GOHAN1 177
#define GOHAN2 154
#define VEGEKU0 46
#define VEGEKU1 223
#define GOGETA 45
#define GOGETA1 97
#define HERCULE 241
#define VIDEL 56
#define KRILLIN 121
#define YAMCHA 204
#define TIEN 81
#define Andriod16 181
#define Andriod17 128
#define Andriod18 56
#define Andriod19 5

//Define short names attacks

#define KI_BLAST 0 //basic attacks
#define KAMEHAMEHA 1 //yamcha's attack //Gohan's attack  //krillin's attack //trunk's attack //vegito's attack
#define SUPER_KAMEHAMEHA 3 //Gohan's attack //gogeta's attack
#define EXPLOSIVE_WAVE 5 //Gohan's attack //Goku's attack //vegeta's attack //trunk's attack //android 16's attack
#define BIG_BANG_ATTACK 6 //gogeta's attack //vegeta's attack
#define FINAL_FLASH 7 //vegeta's attack //vegito's attack
#define BURNING_ATTACK 9 //trunk's attack
#define WOLF_FANG_FIST 11 //yamcha's attack
#define TRI_BEAM 12 //tien's attack
#define DODON_RAY 13  //tien's attack
#define SPIRIT_BALL 14 //yamcha's attack
#define ROCKET_LAUNCHER 15 //Hercule's attack //VIDEL's attack //android 16's attack
#define PHOTON_FLASH 16 //android 17's attack
#define HYPER_CANON 17 //android 16's attack //android 19's attack
#define FINAL_KAMEHAMEHA 18 //vegito's attack
#define BIG_BANG_KAMEHAMEHA 19 //gogeta's attack
#define SUPER_MASENKO 20 //Gohan's attack
#define SPIRIT_BOMB 21 //Goku's attack
#define SOLAR_FLARE 22 // Goku's Attack  //krillin's attack //tien's attack
#define GALICK_GUN 23  //vegeta's attack

//Define battleground

#define BATTLEGROUND_Abandoned_Village 0
#define BATTLEGROUND_Tenkaichi_tournament 1
#define BATTLEGROUND_UNDERWATER 2
#define BATTLEGROUND_Skyscraper 3
#define BATTLEGROUND_BRIDGE 4
#define BATTLEGROUND_SPRINT_Training 5
#define BATTLEGROUND_Area69  6
#define BATTLEGROUND_CASINO 7
#define BATTLEGROUND_WAITINGROOM 8

//Define interiors

#define INTERIOR_OUTSIDE 0
#define INTERIOR_SALONE 3
#define INTERIOR_JAIL 6

//Define renaming keys

#define BUTTON_CLICK_FIRE 4
#define BUTTON_CLICK_UP 512
#define BUTTON_CLICK_RIGHT 128
#define BUTTON_TAB 1
#define BUTTON_C 2
#define BUTTON_SPRINT 8
#define BUTTON_ENTER 16
#define BUTTON_JUMP 32
#define BUTTON_ALT 1024
#define BUTTON_NO 131072
#define BUTTON_GUNOUT 262144
#define BUTTON_YES 65536

//Define Admin Levels

#define ADMIN 1
#define OWNER 2

//Define Dialogs

#define DIALOG_SHENRON 2
#define DIALOG_PERSONALIZE 3
#define DIALOG_attack        4
#define DIALOG_attack2       5
#define DIALOG_style         6
#define DIALOG_PIU_Ki        7
#define DIALOG_PIU_speed     8
#define DIALOG_PIU_HEALTH    9
#define DIALOG_Ki_SIZE       10
#define DIALOG_Ki_SIZE2      11
#define DIALOG_SAVE_MATCH    12
#define DIALOG_BETTING       13
#define DIALOG_BETTING2      14
#define DIALOG_KILL          15
#define DIALOG_SAVERE        16

//Undefines

#undef  MAX_PLAYERS
#undef  MAX_PLAYER_NAME

//Define Maximum

#define MAX_PLAYERS            100
#define MAX_PLAYER_NAME        20
#define MAX_SKINS              299
#define MAX_PLAYER_NAME        20

//other

#define NO_Ki_MESSAGE        "~r~Your ~b~ki energy level ~r~is low! Use ~b~MMB to charge!" //Message that is displayed if you do not have enough Ki
#define NO_DP_MESSAGE        "You don't have enough DPs to buy this object!" //Message that is displayed if you do not have enough Dragon Points
#define null                   -1
#define prisonX                263.0
#define prisonY 			   77.0
#define prisonZ 			   1001.0

//-=-=-=-=-=CALLBACK DECLARATIONS=-=-=-=-=-

forward Unfreeze(playerid);
forward OnPlayerFinishCombo(playerid);
//forward OnPlayerUpdateKi(playerid);
forward OnPlayerEnterAnyVehicle(playerid);
forward OnPlayerExitAnyVehicle(playerid);
forward chargeKi(playerid);
forward Pushing_Forward(playerid);
forward Pushing_Forward_short(playerid);
forward pushing_on(playerid);
forward pushing_on_short(playerid);
forward push_GUNOUT(playerid);
forward push_GUNOUT_short(playerid);

//-=-=-=-=-=NEW VARIABLES AND ARRAYS=-=-=-=-=-
//-=-=-=-=-=TEXTDRAWS=-=-=-=-=-//
new Text:CustomizePlayerTD[10];
new Text:SpawnLoactionTD[14];
new Text:playerconnect[5];
//With MAX_PLAYERS

new muted[MAX_PLAYERS];
new Combo[MAX_PLAYERS];
new Text:TdCombo[MAX_PLAYERS];
new Text3D:Name3DText[MAX_PLAYERS];
new TickCount[MAX_PLAYERS];
new Bar:BarraKi[MAX_PLAYERS];
new ComboTick[MAX_PLAYERS];
new ComboTimer[MAX_PLAYERS];
new KiTimer[MAX_PLAYERS];
new Text:written_Toolbar1[MAX_PLAYERS];
new Text:written_Toolbar2[MAX_PLAYERS];
new Text:written_Toolbar3[MAX_PLAYERS];
new FLY_ON[MAX_PLAYERS];

//With Float:

new Float:RandomSPRINT_Training[2][3] =
{
	{-68.4304,-17.8501,3.1171},//SPRINT Training
	{-53.8105,16.1618,3.1171}
};
new Float:RandomAbandoned_Village[2][3] =
{
	{-562.7196,-189.0080,78.4062},//Abandoned_Village
	{-529.9219,-189.8709,78.4062}
};
new Float:RandomSkyscraper[2][3] =
{
	{1529.3504,-1359.3781,329.4609},//Skyscraper
	{1557.7271,-1352.8771,329.4609}
};
new Float:RandomTenkaichi_tournament[2][3] =
{
	{397.3382,-2070.2937,13.8998},//Tenkaichi_tournament
	{372.9983,-2069.4833,13.9451}
};
new Float:RandomBRIDGE[2][3] =
{
	{-1251.3450,768.4552,34.5781},//BRIDGE
	{-1205.4771,801.5731,34.5781}
};
new Float:RandomUnderwater[2][3] =
{
	{-2665.1315,1908.1401,-37.8794},//Under the sea
	{-2708.8198,1904.1984,-37.2827}
};
new Float:RandomArea69[2][3] =
{
	{183.161331,1860.846679,20.661357},//Area 69
	{228.632171,1898.935668,17.648057}
};
new Float:RandomCasino[2][3] =
{
	{2272.188476,1623.508178,94.921875},//Roof Of Caligulas
	{2204.618164,1603.807128,68.726562}
};
new Float:RandomSpawns[16][3] =
{
	{-562.7196,-189.0080,78.4062},//Abandoned_Village
	{-529.9219,-189.8709,78.4062},
	{1529.3504,-1359.3781,329.4609},//Skyscraper
	{1557.7271,-1352.8771,329.4609},
	{397.3382,-2070.2937,13.8998},//Tenkaichi_tournament
	{372.9983,-2069.4833,13.9451},
	{-1251.3450,768.4552,34.5781},//BRIDGE
	{-1205.4771,801.5731,34.5781},
	{-2665.1315,1908.1401,-37.8794},//Under the sea
	{-2708.8198,1904.1984,-37.2827},
	{183.161331,1860.846679,20.661357},//Area 69
	{228.632171,1898.935668,17.648057},
	{2272.188476,1623.508178,94.921875},//Roof Of Caligulas
	{2204.618164,1603.807128,68.726562},
	{-68.4304,-17.8501,3.1171},//SPRINT Training
	{-53.8105,16.1618,3.1171}
};

//With strings

new rand;

stock HideAllServerTextDraws(playerid)
{
	for(new i=0; i < 13; i++) TextDrawHideForPlayer(playerid,SpawnLocationTD[i]);
	for(new i=0; i < 9; i++) TextDrawHideForPlayer(player,CustomizePlayerTD[i]);
}
//With enum

enum PlayerInfo
{
  Pass[129], //User's password
  Adminlevel, //User's admin level
  ball1,
  ball2,
  ball3,
  ball4,
  ball5,
  ball6,
  ball7,
  Score,
  DragonRadar,
  Kills, //User's kills
  Deaths, //User's deaths
  style[MAX_SKINS],
  attack[MAX_SKINS],
  HEALTHMax[MAX_SKINS],
  KiMax[MAX_SKINS],
  Float:KiSize[MAX_SKINS],
  dsword,
  dBazooka,
  dknife,
};

new pInfo[MAX_PLAYERS][PlayerInfo];
//-----------LOGIN SYSTEM----------//
#define dregister 			   2011 //Defining register dialog so it won't mixed up with the other dialogs
#define dlogin                 2012
#define fail_login_dialog      2013 //Defining login dialog so it won't mixed up with the other dialogs
#define AUTO_SAVE_MINUTES      4 // minutes for auto save

native WP_Hash(buffer[],len,const str[]);
new playerloggedin[MAX_PLAYERS];
new login_timer1[MAX_PLAYERS];
#define UserPath "DragonBall/Users/%s.ini" /*Will define user's account path*/
#define BANPATH "DragonBall/Bans/%s.ini" //will define ban path
#define IPPATH "DragonBall/IP/%s.ini" // will difine ip
forward connecthide(playerid);
new JailTimer[MAX_PLAYERS];
public connecthide(playerid)
{
 	TextDrawHideForPlayer(playerid,playerconnect[0]);
 	TextDrawHideForPlayer(playerid,playerconnect[1]);
 	TextDrawHideForPlayer(playerid,playerconnect[2]);
 	TextDrawHideForPlayer(playerid,playerconnect[3]);
 	TextDrawHideForPlayer(playerid,playerconnect[4]);
 	TogglePlayerSpectating(playerid, 0);
 	login_timer1[playerid] = SetTimerEx("login_timer", 100, 0, "d", playerid);
 	return 1;
}
forward login_timer(playerid);
public login_timer(playerid)
{
	new name[MAX_PLAYER_NAME]; //Making a new variable called 'name'. name[MAX_PLAYER_NAME] is created so we can use it to get player's name.
    GetPlayerName(playerid,name,sizeof(name)); //Get player's name

	//new pname = strtolower(name);

	if(fexist(Path(playerid)))
    {// then
        SendClientMessage(playerid, COLOR_WHITE, "Welcome to {0087FF}Dragon Ball Z Server {FFFFFF}- {FFBE00}Version 2.0.0");

        INI_ParseFile(Path(playerid),"loadaccount_%s", .bExtra = true, .extra = playerid); //Will load user's data using INI_Parsefile.
        ShowPlayerDialog(playerid,dlogin,DIALOG_STYLE_PASSWORD,"{02FBD6}Dragon Ball Z Login","{FFFFFF}This account is already {02FBD6}registered{FFFFFF} - Please {02FBD6}login{FFFFFF}.\nIf this is not your {E30544}account{FFFFFF}, then quit and change your nick\nin {E30544}SA-MP {FFFFFF}browser.","Login","Quit");
    }
    else //If the connected user is not registered,
    {//then we will 'force' him to register :)
        SendClientMessage(playerid, COLOR_WHITE, "Welcome to {0087FF}Dragon Ball Z Server {FFFFFF}- {FFBE00}Version 2.0.0");
        return 1;
    }
    return 1;
}
forward KickPublic(playerid);
public KickPublic(playerid) { Kick(playerid); }

stock KickWithMessage(playerid, message[])
{
    SendClientMessage(playerid, COLOR_GREY, message);
    SetTimerEx("KickPublic", 1000, 0, "d", playerid);     //Delay of 1 second before kicking the player so he recieves the message
}
stock Path(playerid) //Will create a new stock so we can easily use it later to load/save user's data in user's path
{
    new str[128],name[MAX_PLAYER_NAME];
    GetPlayerName(playerid,name,sizeof(name));

    for(new d,len = strlen(name); d != len; d++)
        name[d] = tolower(name[d]);

    format(str,sizeof(str),UserPath,name);
    return str;
}
forward loadaccount_Players_Data(playerid, name[], value[]);
public loadaccount_Players_Data(playerid, name[], value[])
{
    INI_String("Password", pInfo[playerid][Pass],129);
    INI_Int("Score",pInfo[playerid][Score]);//As explained above
    INI_Int("Kills",pInfo[playerid][Kills]);//As explained above
    INI_Int("Deaths",pInfo[playerid][Deaths]);//As explained above
    INI_Int("Banned",pInfo[playerid][Banned]);
	INI_Int("ball1",pInfo[playerid][ball1]);
	INI_Int("ball2",pInfo[playerid][ball2]);
	INI_Int("ball3",pInfo[playerid][ball3]);
	INI_Int("ball4",pInfo[playerid][ball4]);
	INI_Int("ball5",pInfo[playerid][ball5]);
	INI_Int("ball6",pInfo[playerid][ball6]);
	INI_Int("ball7",pInfo[playerid][ball7]);
	INI_Int("DragonRadar",pInfo[playerid][DragonRadar]);
	INI_Int("style[MAX_SKINS]",pInfo[playerid][style]);
	INI_Int("attack[MAX_SKINS]",pInfo[playerid][attack]);
	INI_Int("speed[MAX_SKINS]",pInfo[playerid][speed]);
	INI_Int("HEALTHMax[MAX_SKINS]",pInfo[playerid][HEALTHMax]);
	INI_Int("KiMax[MAX_SKINS]",pInfo[playerid][KiMax]);
 	INI_Float("KiSize[MAX_SKINS]",pInfo[playerid][KiSize]);
	INI_Int("dsword",pInfo[playerid][dsword]);
	INI_Int("dBazooka",pInfo[playerid][dBazooka]);
	INI_Int("dknife",pInfo[playerid][dknife]);
    return 1;
}

forward AUTO_SAVE(playerid);
public AUTO_SAVE(playerid)
{
        if(playerid == INVALID_PLAYER_ID || !IsPlayerConnected(playerid)) return SendClientMessage(playerid, -1,"");

        new name[MAX_PLAYER_NAME]; //Making a new variable called 'name'. name[MAX_PLAYER_NAME] is created so we can use it to get player's name.
        GetPlayerName(playerid,name,sizeof(name)); //Get player's name
    	//new pname = strtolower(name);
     	if(fexist(Path(playerid)))
        {// then
        new INI:file = INI_Open(Path(playerid)); //will open their file
        INI_SetTag(file,"Players_Data");//We will set a tag inside of user's account called "Players_Data"
        INI_WriteInt(file,"Score",GetPlayerScore(playerid));//We will save his score inside of his account
        INI_WriteInt(file,"Kills",pInfo[playerid][Kills]);//As explained above
        INI_WriteInt(file,"Deaths",pInfo[playerid][Deaths]);//As explained above
        INI_WriteInt(file,"Banned",pInfo[playerid][Banned]);
        INI_WriteInt(file,"Jailed",pInfo[playerid][Jailed]);
        INI_WriteInt(file,"ball1",pInfo[playerid][ball1]);
        INI_WriteInt(file,"ball2",pInfo[playerid][ball2]);
        INI_WriteInt(file,"ball3",pInfo[playerid][ball3]);
        INI_WriteInt(file,"ball4",pInfo[playerid][ball4]);
        INI_WriteInt(file,"ball5",pInfo[playerid][ball5]);
        INI_WriteInt(file,"ball6",pInfo[playerid][ball6]);
        INI_WriteInt(file,"ball7",pInfo[playerid][ball7]);
        INI_WriteInt(file,"DragonRadar",pInfo[playerid][DragonRadar]);
        INI_WriteInt(file,"style[MAX_SKINS]",pInfo[playerid][style]);
        INI_WriteInt(file,"attack[MAX_SKINS]",pInfo[playerid][attack]);
        INI_WriteInt(file,"speed[MAX_SKINS]",pInfo[playerid][speed]);
        INI_WriteInt(file,"HEALTHMax[MAX_SKINS]",pInfo[playerid][HEALTHMax]);
        INI_WriteFloat(file,"KiSize[MAX_SKINS]",pInfo[playerid][KiSize]);
        INI_WriteInt(file,"dsword",pInfo[playerid][KiSize]);
        INI_WriteInt(file,"dBazooka",pInfo[playerid][dBazooka]);
        INI_WriteInt(file,"dknife",pInfo[playerid][dknife]);
		INI_Close(file);//Now after we've done saving their data, we now need to close the file
		//SendClientMessage(playerid, COLOR_WHITE, "Your {00B9FF}Stats {FFFFFF}Have Been Automatically {FF0015}Saved.");
        new playername[MAX_PLAYER_NAME];
        GetPlayerName(playerid,playername,24);
        new str[120];
        format(str,sizeof(str),"<AUTO - SAVED> Stats for account: %s(%d) has been saved automatically.", playername, playerid);
        print(str);
  		}
        return 1;
}
//=========================================================================================================//
//========================================================================================================//
//Pickups

new Radar;
new Drago1;
new Drago2;
new Drago3;
new Drago4;
new Drago5;
new Drago6;
new Drago7;
new SAVEMATCH;
new Kill1;
new Kill2;
new Kill3;
new Kill4;
new Kill5;
new Kill6;
new Kill7;
new Kill8;

//-=-=-=-=-=Main=-=-=-=-=-

main()
{
  print("\n-----------------NOW RUNNING------------------\n");
  print("       Dragonball Z Deathmatch     ");
  print("\n----------------------------------------------\n");
}

//-=-=-=-=-=-=-=-=-=-=-=-=-=CALLBACKS-=-=-=-=-=-=-=-=-=-=-=-=-=

//-=-=-=-=-=OnGamemodeInit=-=-=-=-=-

public OnGameModeInit()
{
  SetWeather(17);//Weather
  SetGravity(0.001);//Gravity
  SetWorldTime(12);//Hours
  SetNameTagDrawDistance(20);//Distance from where you can see the name tag
  SetGameModeText("DBZ-DM");//Gamemode Name
  ShowPlayerMarkers(true);//It signals the players on the map
  DisableInteriorEnterExits();//disabling Interiors

  AddPlayerClassEx(0,GOKU0,-249.000000,6.000000,117.000000, 90.000000,0,0,0,0,0,0);//Goku
  AddPlayerClassEx(1,VEGETA0,-249.000000,6.000000,117.000000, 90.000000,0,0,0,0,0,0);//Vegeta
  AddPlayerClassEx(2,TRUNKS0,-249.000000,6.000000,117.000000, 90.000000,0,0,0,0,0,0);//Trunks
  AddPlayerClassEx(3,GOHAN0,-249.000000,6.000000,117.000000, 90.000000,0,0,0,0,0,0);//Gohan
  AddPlayerClassEx(4,SATAN,-249.000000,6.000000,117.000000, 90.000000,0,0,0,0,0,0);//Mr. Satan
  AddPlayerClassEx(5,VIDEL,-249.000000,6.000000,117.000000, 90.000000,0,0,0,0,0,0);//Videl
  AddPlayerClassEx(6,CRILIN,-249.000000,6.000000,117.000000, 90.000000,0,0,0,0,0,0);//Crilin
  AddPlayerClassEx(7,YAMCHA,-249.000000,6.000000,117.000000, 90.000000,0,0,0,0,0,0);//Yamcha
  AddPlayerClassEx(8,TENSHINSHAN,-249.000000,6.000000,117.000000, 90.000000,0,0,0,0,0,0);//Tenshinshan
  AddPlayerClassEx(9,GELO,-249.000000,6.000000,117.000000, 90.000000,0,0,0,0,0,0);//Dr. Gelo
  AddPlayerClassEx(10,Andriod16,-249.000000,6.000000,117.000000, 90.000000,0,0,0,0,0,0);//Andriod16
  AddPlayerClassEx(11,Andriod17,-249.000000,6.000000,117.000000, 90.000000,0,0,0,0,0,0);//Andriod17
  AddPlayerClassEx(12,Andriod18,-249.000000,6.000000,117.000000, 90.000000,0,0,0,0,0,0);//Andriod18
  AddPlayerClassEx(13,Andriod19,-249.000000,6.000000,117.000000, 90.000000,0,0,0,0,0,0);//Andriod19

  Drago1 = CreatePickup(1247,15,-537.200683,-102.969543,63.296875);//1 Star Dragon Ball
  Drago2 = CreatePickup(1247,15,-2670.812255,1933.930419,217.273895);//2 Star Dragon Ball
  Drago3 = CreatePickup(1247,15,1451.416748,-1076.615478,213.382812);//3 Star Dragon Ball
  Drago4 = CreatePickup(1247,15,-1363.999755,493.684875,29.944622);//4 Star Dragon Ball
  Drago5 = CreatePickup(1247,15,-61.429683,-37.518638,25.980148);//5 Star Dragon Ball
  Drago6 = CreatePickup(1247,15,281.206451,1816.537475,1.000000);//6 Star Dragon Ball
  Drago7 = CreatePickup(1247,15,2323.700439,1283.225341,97.661628);//7 Star Dragon Ball
  Radar = CreatePickup(1252,15,2002.766113,1532.768798,34.918472);//Bulma's Dragon Radar
  Kill1 = CreatePickup(1254,15,-534.850280,-177.978118,84.203895);//Kills
  Kill2 = CreatePickup(1254,15,382.104675,-2085.783691,7.835937);//
  Kill3 = CreatePickup(1254,15,-2717.638427,1916.555175,-37.692634);//
  Kill4 = CreatePickup(1254,15,1547.865112,-1366.486816,326.210937);//
  Kill5 = CreatePickup(1254,15,-1312.331298,723.875793,34.578125);//
  Kill6 = CreatePickup(1254,15,-67.796043,15.665332,5.960474);//
  Kill7 = CreatePickup(1254,15,206.900390,1921.105346,17.640625);//
  Kill8 = CreatePickup(1254,15,2266.202148,1619.752563,99.023284);//Fine Kills
  Radar = CreatePickup(1252,15,2002.766113,1532.768798,34.918472);//Bulma's Dragon Radar
  SAVEMATCH = CreatePickup(1277,23,823.166564,1.832440,1004.179687);//Main Menu

  CreateObject(971,364.854858,-2024.364990,10.449507,0.000000,0.000000,360.000000);//Cage
  CreateObject(971,373.453552,-2024.487670,10.337790,0.000000,0.000000,360.000000);//
  CreateObject(971,377.692169,-2028.686035,10.285641,0.000000,0.000000,270.000000);//
  CreateObject(971,377.483123,-2037.448486,10.227573,0.000000,0.000000,270.000000);//
  CreateObject(971,381.926849,-2041.893554,10.080951,0.000000,0.000000,360.000000);//
  CreateObject(971,390.607543,-2041.956298,10.244183,0.000000,0.000000,0.000000);////
  CreateObject(971,395.177520,-2041.678222,10.493602,0.000000,0.000000,0.000000);////
  CreateObject(971,360.316619,-2028.781860,10.429292,0.000000,0.000000,90.000000);///
  CreateObject(971,360.365295,-2037.818237,10.446266,0.000000,0.000000,90.000000);///
  CreateObject(971,355.863403,-2047.221557,10.516483,0.000000,0.000000,360.000000);//
  CreateObject(971,360.174713,-2042.649414,10.129162,0.000000,0.000000,90.000000);///
  CreateObject(971,349.348693,-2051.299560,10.362854,0.000000,0.000000,90.000000);///
  CreateObject(971,353.712524,-2047.049804,10.380116,0.000000,0.000000,0.000000);////
  CreateObject(971,349.571594,-2059.866210,10.328974,0.000000,0.000000,90.000000);///
  CreateObject(971,349.781982,-2068.938476,10.430992,0.000000,0.000000,90.000000);///
  CreateObject(971,349.954711,-2077.801269,10.366273,0.000000,0.000000,90.000000);///
  CreateObject(971,349.900543,-2084.890380,10.419968,0.000000,0.000000,90.000000);///
  CreateObject(971,354.100128,-2089.282958,10.113450,0.000000,0.000000,180.000000);//
  CreateObject(971,362.707977,-2089.087158,10.315588,0.000000,0.000000,180.000000);//
  CreateObject(971,371.566589,-2089.158447,10.271301,0.000000,0.000000,180.000000);//
  CreateObject(971,380.395904,-2089.262939,10.250101,0.000000,0.000000,180.000000);//
  CreateObject(971,389.139434,-2089.212158,10.158458,0.000000,0.000000,180.000000);//
  CreateObject(971,397.922973,-2089.104492,10.835937,0.000000,0.000000,180.000000);//
  CreateObject(971,405.629791,-2089.104492,10.231714,0.000000,0.000000,180.000000);//
  CreateObject(971,409.754943,-2084.612792,10.094079,0.000000,0.000000,270.000000);//
  CreateObject(971,409.797088,-2075.795410,10.563268,0.000000,0.000000,270.000000);//
  CreateObject(971,409.768371,-2067.102539,10.030206,0.000000,0.000000,270.000000);//
  CreateObject(971,410.017486,-2058.327880,10.298521,0.000000,0.000000,270.000000);//
  CreateObject(971,409.782165,-2051.658203,10.298521,0.000000,0.000000,270.000000);//
  CreateObject(971,409.782165,-2048.658203,10.298521,0.000000,0.000000,360.000000);//
  CreateObject(971,403.119995,-2047.381835,10.298521,0.000000,0.000000,360.000000);//
  CreateObject(971,398.632232,-2043.106811,10.117244,0.000000,0.000000,270.000000);//end Cage
  
    playerconnect[0] = TextDrawCreate(320, 100.000000, "~l~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~");
	TextDrawAlignment(playerconnect[0], 2);
	TextDrawBackgroundColor(playerconnect[0], 255);
	TextDrawFont(playerconnect[0], 1);
	TextDrawLetterSize(playerconnect[0], 0.500000, 1);
	TextDrawColor(playerconnect[0], -1);
	TextDrawSetOutline(playerconnect[0], 0);
	TextDrawSetProportional(playerconnect[0], 1);
	TextDrawSetShadow(playerconnect[0], 1);
	TextDrawUseBox(playerconnect[0], 1);
	TextDrawBoxColor(playerconnect[0], 110);
	TextDrawTextSize(playerconnect[0], 2.000000, 450.000000);
	TextDrawSetSelectable(playerconnect[0], 0);

	playerconnect[1] = TextDrawCreate(320.000000, 105.000000, "DragonBall Z");
	TextDrawAlignment(playerconnect[1], 2);
	TextDrawBackgroundColor(playerconnect[1], 255);
	TextDrawFont(playerconnect[1], 3);
	TextDrawLetterSize(playerconnect[1], 1, 2);
	TextDrawColor(playerconnect[1], 0xFF6207CE);
	TextDrawSetOutline(playerconnect[1], 1);
	TextDrawSetProportional(playerconnect[1], 1);

	playerconnect[2] = TextDrawCreate(320.000000, 145.000000, " ~N~ ~G~~H~Welcome~N~ ~N~ ~W~- Multi Accounting Is ~R~~H~Not~w~ Allowed~N~- ~R~~H~Hacking ~W~And ~R~~H~Cheating ~N~ ~W~Is ~R~NOT~W~ Allowed~N~- Respect Admins And Other Players~N~- Type ~Y~/help ~W~For Help And Game Information~N~- Type ~Y~/rules~W~ For Server Rules.~N~- ~P~~H~Enjoy! ~w~This Is An Awesome Dragon Ball Z Mode.");
	TextDrawAlignment(playerconnect[2], 2);
	TextDrawBackgroundColor(playerconnect[2], 255);
	TextDrawFont(playerconnect[2], 3);
	TextDrawLetterSize(playerconnect[2], 0.4, 1);
	TextDrawColor(playerconnect[2], -1);
	TextDrawSetOutline(playerconnect[2], 1);
	TextDrawSetProportional(playerconnect[2], 1);
	TextDrawSetSelectable(playerconnect[2], 0);

	playerconnect[3] = TextDrawCreate(320.000000, 260.000000, "~Y~Version 2.5.0");
	TextDrawAlignment(playerconnect[3], 2);
	TextDrawBackgroundColor(playerconnect[3], 255);
	TextDrawFont(playerconnect[3], 3);
	TextDrawLetterSize(playerconnect[3], 1, 2);
	TextDrawColor(playerconnect[3], -1);
	TextDrawSetOutline(playerconnect[3], 1);
	TextDrawSetProportional(playerconnect[3], 1);

	playerconnect[4] = TextDrawCreate(320.000000, 290.000000, "~B~~H~Comming Soon");
	TextDrawAlignment(playerconnect[4], 2);
	TextDrawBackgroundColor(playerconnect[4], 255);
	TextDrawFont(playerconnect[4], 3);
	TextDrawLetterSize(playerconnect[4], 1, 2);
	TextDrawColor(playerconnect[4], -1);
	TextDrawSetOutline(playerconnect[4], 1);
	TextDrawSetProportional(playerconnect[4], 1);
	
	SpawnLoactionTD[0] = TextDrawCreate(147.000000, 137.111145, "box");
	TextDrawLetterSize(SpawnLoactionTD[0], 0.000000, 27.799966);
	TextDrawTextSize(SpawnLoactionTD[0], 484.000000, 0.000000);
	TextDrawAlignment(SpawnLoactionTD[0], 1);
	TextDrawColor(SpawnLoactionTD[0], -1);
	TextDrawUseBox(SpawnLoactionTD[0], 1);
	TextDrawBoxColor(SpawnLoactionTD[0], 75);
	TextDrawSetShadow(SpawnLoactionTD[0], 0);
	TextDrawSetOutline(SpawnLoactionTD[0], 0);
	TextDrawBackgroundColor(SpawnLoactionTD[0], 16711935);
	TextDrawFont(SpawnLoactionTD[0], 1);
	TextDrawSetProportional(SpawnLoactionTD[0], 1);
	TextDrawSetShadow(SpawnLoactionTD[0], 0);

	SpawnLoactionTD[1] = TextDrawCreate(147.000000, 130.266601, "box");
	TextDrawLetterSize(SpawnLoactionTD[1], 0.000000, 1.499999);
	TextDrawTextSize(SpawnLoactionTD[1], 484.000000, 0.000000);
	TextDrawAlignment(SpawnLoactionTD[1], 1);
	TextDrawColor(SpawnLoactionTD[1], -1);
	TextDrawUseBox(SpawnLoactionTD[1], 1);
	TextDrawBoxColor(SpawnLoactionTD[1], 255);
	TextDrawSetShadow(SpawnLoactionTD[1], 0);
	TextDrawSetOutline(SpawnLoactionTD[1], 0);
	TextDrawBackgroundColor(SpawnLoactionTD[1], 255);
	TextDrawFont(SpawnLoactionTD[1], 1);
	TextDrawSetProportional(SpawnLoactionTD[1], 1);
	TextDrawSetShadow(SpawnLoactionTD[1], 0);

	SpawnLoactionTD[2] = TextDrawCreate(318.000000, 129.644378, "Choose_A_Location_To_Spawn");
	TextDrawLetterSize(SpawnLoactionTD[2], 0.400000, 1.600000);
	TextDrawAlignment(SpawnLoactionTD[2], 2);
	TextDrawColor(SpawnLoactionTD[2], -1);
	TextDrawSetShadow(SpawnLoactionTD[2], 0);
	TextDrawSetOutline(SpawnLoactionTD[2], 0);
	TextDrawBackgroundColor(SpawnLoactionTD[2], 255);
	TextDrawFont(SpawnLoactionTD[2], 1);
	TextDrawSetProportional(SpawnLoactionTD[2], 1);
	TextDrawSetShadow(SpawnLoactionTD[2], 0);

	SpawnLoactionTD[3] = TextDrawCreate(317.000000, 153.288848, "Abondoned_Village");
	TextDrawLetterSize(SpawnLoactionTD[3], 0.312498, 2.383996);
	TextDrawAlignment(SpawnLoactionTD[3], 2);
	TextDrawColor(SpawnLoactionTD[3], -1);
	TextDrawSetShadow(SpawnLoactionTD[3], 0);
	TextDrawSetOutline(SpawnLoactionTD[3], 0);
	TextDrawBackgroundColor(SpawnLoactionTD[3], -1);
	TextDrawFont(SpawnLoactionTD[3], 1);
	TextDrawSetProportional(SpawnLoactionTD[3], 1);
	TextDrawSetShadow(SpawnLoactionTD[3], 0);
	TextDrawSetSelectable(SpawnLoactionTD[3], true);

	SpawnLoactionTD[4] = TextDrawCreate(316.500000, 175.688873, "Tenkachi_Tournament");
	TextDrawLetterSize(SpawnLoactionTD[4], 0.312498, 2.383996);
	TextDrawAlignment(SpawnLoactionTD[4], 2);
	TextDrawColor(SpawnLoactionTD[4], -1);
	TextDrawSetShadow(SpawnLoactionTD[4], 0);
	TextDrawSetOutline(SpawnLoactionTD[4], 0);
	TextDrawBackgroundColor(SpawnLoactionTD[4], -1);
	TextDrawFont(SpawnLoactionTD[4], 1);
	TextDrawSetProportional(SpawnLoactionTD[4], 1);
	TextDrawSetShadow(SpawnLoactionTD[4], 0);
	TextDrawSetSelectable(SpawnLoactionTD[4], true);

	SpawnLoactionTD[5] = TextDrawCreate(288.000000, 349.288940, "box");
	TextDrawLetterSize(SpawnLoactionTD[5], 0.000000, 3.399996);
	TextDrawTextSize(SpawnLoactionTD[5], 341.500000, 0.000000);
	TextDrawAlignment(SpawnLoactionTD[5], 1);
	TextDrawColor(SpawnLoactionTD[5], -1);
	TextDrawUseBox(SpawnLoactionTD[5], 1);
	TextDrawBoxColor(SpawnLoactionTD[5], 255);
	TextDrawSetShadow(SpawnLoactionTD[5], 0);
	TextDrawSetOutline(SpawnLoactionTD[5], 0);
	TextDrawBackgroundColor(SpawnLoactionTD[5], 255);
	TextDrawFont(SpawnLoactionTD[5], 1);
	TextDrawSetProportional(SpawnLoactionTD[5], 1);
	TextDrawSetShadow(SpawnLoactionTD[5], 0);

	SpawnLoactionTD[6] = TextDrawCreate(294.000000, 358.000152, "CLOSE");
	TextDrawLetterSize(SpawnLoactionTD[6], 0.400000, 1.600000);
	TextDrawAlignment(SpawnLoactionTD[6], 1);
	TextDrawColor(SpawnLoactionTD[6], -1);
	TextDrawSetShadow(SpawnLoactionTD[6], 0);
	TextDrawSetOutline(SpawnLoactionTD[6], 0);
	TextDrawBackgroundColor(SpawnLoactionTD[6], 255);
	TextDrawFont(SpawnLoactionTD[6], 1);
	TextDrawSetProportional(SpawnLoactionTD[6], 1);
	TextDrawSetShadow(SpawnLoactionTD[6], 0);
	TextDrawSetSelectable(SpawnLoactionTD[6], true);

	SpawnLoactionTD[7] = TextDrawCreate(316.500000, 198.711120, "Underwater");
	TextDrawLetterSize(SpawnLoactionTD[7], 0.312498, 2.383996);
	TextDrawAlignment(SpawnLoactionTD[7], 2);
	TextDrawColor(SpawnLoactionTD[7], -1);
	TextDrawSetShadow(SpawnLoactionTD[7], 0);
	TextDrawSetOutline(SpawnLoactionTD[7], 0);
	TextDrawBackgroundColor(SpawnLoactionTD[7], -1);
	TextDrawFont(SpawnLoactionTD[7], 1);
	TextDrawSetProportional(SpawnLoactionTD[7], 1);
	TextDrawSetShadow(SpawnLoactionTD[7], 0);
	TextDrawSetSelectable(SpawnLoactionTD[7], true);

	SpawnLoactionTD[8] = TextDrawCreate(316.500000, 219.244476, "Skyscraper");
	TextDrawLetterSize(SpawnLoactionTD[8], 0.312498, 2.383996);
	TextDrawAlignment(SpawnLoactionTD[8], 2);
	TextDrawColor(SpawnLoactionTD[8], -1);
	TextDrawSetShadow(SpawnLoactionTD[8], 0);
	TextDrawSetOutline(SpawnLoactionTD[8], 0);
	TextDrawBackgroundColor(SpawnLoactionTD[8], -1);
	TextDrawFont(SpawnLoactionTD[8], 1);
	TextDrawSetProportional(SpawnLoactionTD[8], 1);
	TextDrawSetShadow(SpawnLoactionTD[8], 0);
	TextDrawSetSelectable(SpawnLoactionTD[8], true);

	SpawnLoactionTD[9] = TextDrawCreate(315.000000, 239.155609, "Bridge");
	TextDrawLetterSize(SpawnLoactionTD[9], 0.312498, 2.383996);
	TextDrawAlignment(SpawnLoactionTD[9], 2);
	TextDrawColor(SpawnLoactionTD[9], -1);
	TextDrawSetShadow(SpawnLoactionTD[9], 0);
	TextDrawSetOutline(SpawnLoactionTD[9], 0);
	TextDrawBackgroundColor(SpawnLoactionTD[9], -1);
	TextDrawFont(SpawnLoactionTD[9], 1);
	TextDrawSetProportional(SpawnLoactionTD[9], 1);
	TextDrawSetShadow(SpawnLoactionTD[9], 0);
	TextDrawSetSelectable(SpawnLoactionTD[9], true);

	SpawnLoactionTD[10] = TextDrawCreate(315.000000, 259.688934, "Traning_Zone");
	TextDrawLetterSize(SpawnLoactionTD[10], 0.312498, 2.383996);
	TextDrawAlignment(SpawnLoactionTD[10], 2);
	TextDrawColor(SpawnLoactionTD[10], -1);
	TextDrawSetShadow(SpawnLoactionTD[10], 0);
	TextDrawSetOutline(SpawnLoactionTD[10], 0);
	TextDrawBackgroundColor(SpawnLoactionTD[10], -1);
	TextDrawFont(SpawnLoactionTD[10], 1);
	TextDrawSetProportional(SpawnLoactionTD[10], 1);
	TextDrawSetShadow(SpawnLoactionTD[10], 0);
	TextDrawSetSelectable(SpawnLoactionTD[10], true);

	SpawnLoactionTD[11] = TextDrawCreate(315.000000, 278.355621, "Area_69");
	TextDrawLetterSize(SpawnLoactionTD[11], 0.312498, 2.383996);
	TextDrawAlignment(SpawnLoactionTD[11], 2);
	TextDrawColor(SpawnLoactionTD[11], -1);
	TextDrawSetShadow(SpawnLoactionTD[11], 0);
	TextDrawSetOutline(SpawnLoactionTD[11], 0);
	TextDrawBackgroundColor(SpawnLoactionTD[11], -1);
	TextDrawFont(SpawnLoactionTD[11], 1);
	TextDrawSetProportional(SpawnLoactionTD[11], 1);
	TextDrawSetShadow(SpawnLoactionTD[11], 0);
	TextDrawSetSelectable(SpawnLoactionTD[11], true);

	SpawnLoactionTD[12] = TextDrawCreate(315.000000, 294.533416, "Casino");
	TextDrawLetterSize(SpawnLoactionTD[12], 0.312498, 2.383996);
	TextDrawAlignment(SpawnLoactionTD[12], 2);
	TextDrawColor(SpawnLoactionTD[12], -1);
	TextDrawSetShadow(SpawnLoactionTD[12], 0);
	TextDrawSetOutline(SpawnLoactionTD[12], 0);
	TextDrawBackgroundColor(SpawnLoactionTD[12], -1);
	TextDrawFont(SpawnLoactionTD[12], 1);
	TextDrawSetProportional(SpawnLoactionTD[12], 1);
	TextDrawSetShadow(SpawnLoactionTD[12], 0);
	TextDrawSetSelectable(SpawnLoactionTD[12], true);

	SpawnLoactionTD[13] = TextDrawCreate(316.000000, 313.822326, "Customizing_Room");
	TextDrawLetterSize(SpawnLoactionTD[13], 0.312498, 2.383996);
	TextDrawAlignment(SpawnLoactionTD[13], 2);
	TextDrawColor(SpawnLoactionTD[13], -1);
	TextDrawSetShadow(SpawnLoactionTD[13], 0);
	TextDrawSetOutline(SpawnLoactionTD[13], 0);
	TextDrawBackgroundColor(SpawnLoactionTD[13], -1);
	TextDrawFont(SpawnLoactionTD[13], 1);
	TextDrawSetProportional(SpawnLoactionTD[13], 1);
	TextDrawSetShadow(SpawnLoactionTD[13], 0);
	TextDrawSetSelectable(SpawnLoactionTD[13], true);
	
		CustomizePlayerTD[0] = TextDrawCreate(147.000000, 137.111145, "box");
	TextDrawLetterSize(CustomizePlayerTD[0], 0.000000, 19.499996);
	TextDrawTextSize(CustomizePlayerTD[0], 485.000000, 0.000000);
	TextDrawAlignment(CustomizePlayerTD[0], 1);
	TextDrawColor(CustomizePlayerTD[0], -1);
	TextDrawUseBox(CustomizePlayerTD[0], 1);
	TextDrawBoxColor(CustomizePlayerTD[0], 75);
	TextDrawSetShadow(CustomizePlayerTD[0], 0);
	TextDrawSetOutline(CustomizePlayerTD[0], 0);
	TextDrawBackgroundColor(CustomizePlayerTD[0], 16711935);
	TextDrawFont(CustomizePlayerTD[0], 1);
	TextDrawSetProportional(CustomizePlayerTD[0], 1);
	TextDrawSetShadow(CustomizePlayerTD[0], 0);

	CustomizePlayerTD[1] = TextDrawCreate(147.000000, 130.266601, "box");
	TextDrawLetterSize(CustomizePlayerTD[1], 0.000000, 1.499999);
	TextDrawTextSize(CustomizePlayerTD[1], 484.000000, 0.000000);
	TextDrawAlignment(CustomizePlayerTD[1], 1);
	TextDrawColor(CustomizePlayerTD[1], -1);
	TextDrawUseBox(CustomizePlayerTD[1], 1);
	TextDrawBoxColor(CustomizePlayerTD[1], 255);
	TextDrawSetShadow(CustomizePlayerTD[1], 0);
	TextDrawSetOutline(CustomizePlayerTD[1], 0);
	TextDrawBackgroundColor(CustomizePlayerTD[1], 255);
	TextDrawFont(CustomizePlayerTD[1], 1);
	TextDrawSetProportional(CustomizePlayerTD[1], 1);
	TextDrawSetShadow(CustomizePlayerTD[1], 0);

	CustomizePlayerTD[2] = TextDrawCreate(318.000000, 129.644378, "Customize_Your_Player");
	TextDrawLetterSize(CustomizePlayerTD[2], 0.400000, 1.600000);
	TextDrawAlignment(CustomizePlayerTD[2], 2);
	TextDrawColor(CustomizePlayerTD[2], -1);
	TextDrawSetShadow(CustomizePlayerTD[2], 0);
	TextDrawSetOutline(CustomizePlayerTD[2], 0);
	TextDrawBackgroundColor(CustomizePlayerTD[2], 255);
	TextDrawFont(CustomizePlayerTD[2], 1);
	TextDrawSetProportional(CustomizePlayerTD[2], 1);
	TextDrawSetShadow(CustomizePlayerTD[2], 0);

	CustomizePlayerTD[3] = TextDrawCreate(317.000000, 153.288848, "Fighting_Style");
	TextDrawLetterSize(CustomizePlayerTD[3], 0.312498, 2.383996);
	TextDrawAlignment(CustomizePlayerTD[3], 2);
	TextDrawColor(CustomizePlayerTD[3], -1);
	TextDrawSetShadow(CustomizePlayerTD[3], 0);
	TextDrawSetOutline(CustomizePlayerTD[3], 0);
	TextDrawBackgroundColor(CustomizePlayerTD[3], -1);
	TextDrawFont(CustomizePlayerTD[3], 1);
	TextDrawSetProportional(CustomizePlayerTD[3], 1);
	TextDrawSetShadow(CustomizePlayerTD[3], 0);
	TextDrawSetSelectable(CustomizePlayerTD[3], true);

	CustomizePlayerTD[4] = TextDrawCreate(316.500000, 175.688873, "Special_Attack");
	TextDrawLetterSize(CustomizePlayerTD[4], 0.312498, 2.383996);
	TextDrawAlignment(CustomizePlayerTD[4], 2);
	TextDrawColor(CustomizePlayerTD[4], -1);
	TextDrawSetShadow(CustomizePlayerTD[4], 0);
	TextDrawSetOutline(CustomizePlayerTD[4], 0);
	TextDrawBackgroundColor(CustomizePlayerTD[4], -1);
	TextDrawFont(CustomizePlayerTD[4], 1);
	TextDrawSetProportional(CustomizePlayerTD[4], 1);
	TextDrawSetShadow(CustomizePlayerTD[4], 0);
	TextDrawSetSelectable(CustomizePlayerTD[4], true);

	CustomizePlayerTD[5] = TextDrawCreate(290.500000, 271.511077, "box");
	TextDrawLetterSize(CustomizePlayerTD[5], 0.000000, 3.399996);
	TextDrawTextSize(CustomizePlayerTD[5], 344.000000, 0.000000);
	TextDrawAlignment(CustomizePlayerTD[5], 1);
	TextDrawColor(CustomizePlayerTD[5], -1);
	TextDrawUseBox(CustomizePlayerTD[5], 1);
	TextDrawBoxColor(CustomizePlayerTD[5], 255);
	TextDrawSetShadow(CustomizePlayerTD[5], 0);
	TextDrawSetOutline(CustomizePlayerTD[5], 0);
	TextDrawBackgroundColor(CustomizePlayerTD[5], 255);
	TextDrawFont(CustomizePlayerTD[5], 1);
	TextDrawSetProportional(CustomizePlayerTD[5], 1);
	TextDrawSetShadow(CustomizePlayerTD[5], 0);

	CustomizePlayerTD[6] = TextDrawCreate(296.500000, 279.600067, "CLOSE");
	TextDrawLetterSize(CustomizePlayerTD[6], 0.400000, 1.600000);
	TextDrawAlignment(CustomizePlayerTD[6], 1);
	TextDrawColor(CustomizePlayerTD[6], -1);
	TextDrawSetShadow(CustomizePlayerTD[6], 0);
	TextDrawSetOutline(CustomizePlayerTD[6], 0);
	TextDrawBackgroundColor(CustomizePlayerTD[6], 255);
	TextDrawFont(CustomizePlayerTD[6], 1);
	TextDrawSetProportional(CustomizePlayerTD[6], 1);
	TextDrawSetShadow(CustomizePlayerTD[6], 0);
	TextDrawSetSelectable(CustomizePlayerTD[6], true);

	CustomizePlayerTD[7] = TextDrawCreate(316.500000, 198.711120, "Max_Health");
	TextDrawLetterSize(CustomizePlayerTD[7], 0.312498, 2.383996);
	TextDrawAlignment(CustomizePlayerTD[7], 2);
	TextDrawColor(CustomizePlayerTD[7], -1);
	TextDrawSetShadow(CustomizePlayerTD[7], 0);
	TextDrawSetOutline(CustomizePlayerTD[7], 0);
	TextDrawBackgroundColor(CustomizePlayerTD[7], -1);
	TextDrawFont(CustomizePlayerTD[7], 1);
	TextDrawSetProportional(CustomizePlayerTD[7], 1);
	TextDrawSetShadow(CustomizePlayerTD[7], 0);
	TextDrawSetSelectable(CustomizePlayerTD[7], true);

	CustomizePlayerTD[8] = TextDrawCreate(316.500000, 219.244476, "Max_Ki");
	TextDrawLetterSize(CustomizePlayerTD[8], 0.312498, 2.383996);
	TextDrawAlignment(CustomizePlayerTD[8], 2);
	TextDrawColor(CustomizePlayerTD[8], -1);
	TextDrawSetShadow(CustomizePlayerTD[8], 0);
	TextDrawSetOutline(CustomizePlayerTD[8], 0);
	TextDrawBackgroundColor(CustomizePlayerTD[8], -1);
	TextDrawFont(CustomizePlayerTD[8], 1);
	TextDrawSetProportional(CustomizePlayerTD[8], 1);
	TextDrawSetShadow(CustomizePlayerTD[8], 0);
	TextDrawSetSelectable(CustomizePlayerTD[8], true);

	CustomizePlayerTD[9] = TextDrawCreate(315.000000, 239.155609, "Ki_Effect");
	TextDrawLetterSize(CustomizePlayerTD[9], 0.312498, 2.383996);
	TextDrawAlignment(CustomizePlayerTD[9], 2);
	TextDrawColor(CustomizePlayerTD[9], -1);
	TextDrawSetShadow(CustomizePlayerTD[9], 0);
	TextDrawSetOutline(CustomizePlayerTD[9], 0);
	TextDrawBackgroundColor(CustomizePlayerTD[9], -1);
	TextDrawFont(CustomizePlayerTD[9], 1);
	TextDrawSetProportional(CustomizePlayerTD[9], 1);
	TextDrawSetShadow(CustomizePlayerTD[9], 0);
	TextDrawSetSelectable(CustomizePlayerTD[9], true);


  //CLEAR SIGNS FOR CHRISTMAS /* and */
  /*
  CreateObject(661,368.618499,-1994.246948,6.659312,0.000000,0.000000,0.00000000);//Winter Special Celebrations
  CreateObject(3785,370.700073,-1995.705688,12.782113,0.000000,0.000000,0.000000);//
  CreateObject(3785,367.190032,-1995.480712,13.676772,0.000000,0.000000,0.000000);//
  CreateObject(3785,369.532104,-1994.811157,15.755434,0.000000,0.000000,0.000000);//
  CreateObject(3785,370.090789,-1995.620605,19.191816,0.000000,0.000000,0.000000);//
  CreateObject(3785,366.341827,-1995.635009,19.376033,0.000000,0.000000,0.000000);//
  CreateObject(3785,367.877929,-1991.300903,14.011980,0.000000,0.000000,0.000000);//
  CreateObject(3785,367.571228,-1993.741943,20.903799,0.000000,0.000000,0.000000);//
  CreateObject(3785,370.950500,-1994.454589,12.136563,0.000000,0.000000,0.000000);//
  CreateObject(3785,369.979797,-1993.114868,13.362409,0.000000,0.000000,0.000000);//End of Winter Special Celebrations
  */
  return 1;
}

//-=-=-=-=-=OnGamemodeExit=-=-=-=-=-

public OnGameModeExit()
{
  return 1;
}

//-=-=-=-=-=OnPlayerSpawn=-=-=-=-=-

public OnPlayerSpawn(playerid)
{
    new Float:X, Float:Y, Float:Z;
    new team = GetPlayerTeam(playerid);
    TogglePlayerClock(playerid, true);
	//textdraw here
    TogglePlayerControllable(playerid,false);
	new name[MAX_PLAYER_NAME];
	//TimerUpdate[playerid] = SetTimerEx("OnPlayerUpdateKi", 500, 1, "i", playerid);
	GetPlayerName(playerid,name,sizeof(name));
	ShowProgressBarForPlayer(playerid, BarraKi[playerid]);

    if(team == 13 || team == 9) { SendClientMessage(playerid,COLOR_LIGHTBLUE,"This character can absorb energy, use /absorb."); }

    ResetPlayerMoney(playerid);//Reset Ki
    SetPlayerArmour(playerid,150);//First bar HEALTH
    SetPlayerHealth(playerid,150);//Second bar HEALTH a.k.a Armour
    SetPlayerColor(playerid,COLOR_WHITE);//color
    TogglePlayerClock(playerid,false);
    SendClientMessage(playerid,COLOR_BLUE,  "Welcome to Dragonball Z DM 4.0z (GM by Sasino)! Use /help.");
    PlaySound(playerid,SOUND_BIKE_AWARD_TRACK_START);
	if(IsPlayerAnAndroid(playerid))
	{
	  SendClientMessage(playerid,COLOR_LIGHTBLUE,"Andriod have less health, but they never get tired.");
      SetPlayerColor(playerid,COLOR_LIGHTBLUE);
      SetPlayerHealth(playerid,50);
      SetPlayerArmour(playerid,0);
      ResetPlayerMoney(playerid);
	}
	if(team == 4 || team == 5)
	{
	  SendClientMessage(playerid,COLOR_PINK,"Weak characters start with 150hp.");
      SetPlayerColor(playerid,COLOR_PINK);
      SetPlayerHealth(playerid,150);
      SetPlayerArmour(playerid,0);
      ResetPlayerMoney(playerid);
	}
    switch(team)
    {
	  case 0: { GameTextForPlayer(playerid,"~r~Goku",1000,4); SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU); Name3DText[playerid] = Create3DTextLabel("GOKU", COLOR_WHITE, X, Y, Z+0.2, 20, 0, 0); Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);}
	  case 1: { GameTextForPlayer(playerid,"~b~Vegeta",1000,4); SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU); Name3DText[playerid] = Create3DTextLabel("VEGETA", COLOR_WHITE, X, Y, Z+0.2, 20, 0, 0);Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);}
	  case 2: { GameTextForPlayer(playerid,"~y~Trunks",1000,4); SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU); Name3DText[playerid] = Create3DTextLabel("TRUNKS", COLOR_WHITE, X, Y, Z+0.2, 20, 0, 0);Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);}
	  case 3: { GameTextForPlayer(playerid,"~g~Gohan",1000,4); SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU); Name3DText[playerid] = Create3DTextLabel("GOHAN", COLOR_WHITE, X, Y, Z+0.2, 20, 0, 0);Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);}
	  case 4: { GameTextForPlayer(playerid,"~p~Hercule",1000,4); SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING); Name3DText[playerid] = Create3DTextLabel("HERCULE", COLOR_WHITE, X, Y, Z+0.2, 20, 0, 0);Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);}
	  case 5: { GameTextForPlayer(playerid,"~l~Videl",1000,4); SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING); Name3DText[playerid] = Create3DTextLabel("VIDEL", COLOR_WHITE, X, Y, Z+0.2, 20, 0, 0);Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);}
	  case 6: { GameTextForPlayer(playerid,"~r~Krillin",1000,4); SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU); Name3DText[playerid] = Create3DTextLabel("KRILLIN", COLOR_WHITE, X, Y, Z+0.2, 20, 0, 0);Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);}
      case 7: { GameTextForPlayer(playerid,"~b~Yamcha",1000,4); SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU); Name3DText[playerid] = Create3DTextLabel("YAMCHA", COLOR_WHITE, X, Y, Z+0.2, 20, 0, 0);Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);}
      case 8: { GameTextForPlayer(playerid,"~y~Tien",1000,4); SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU); Name3DText[playerid] = Create3DTextLabel("TIEN", COLOR_WHITE, X, Y, Z+0.2, 20, 0, 0);Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);}
      case 9: { GameTextForPlayer(playerid,"~g~Dr.Gero",1000,4); SetPlayerFightingStyle(playerid, FIGHT_STYLE_GRABKICK); Name3DText[playerid] = Create3DTextLabel("DR.GERO", COLOR_LIGHTBLUE, X, Y, Z+0.2, 20, 0, 0);Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);}
      case 10: { GameTextForPlayer(playerid,"~p~Andriod16",1000,4); SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD); Name3DText[playerid] = Create3DTextLabel("Andriod16", COLOR_LIGHTBLUE, X, Y, Z+0.2, 20, 0, 0);Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);}
      case 11: { GameTextForPlayer(playerid,"~l~Andriod17",1000,4); SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD); Name3DText[playerid] = Create3DTextLabel("Andriod17", COLOR_LIGHTBLUE, X, Y, Z+0.2, 20, 0, 0);Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);}
      case 12: { GameTextForPlayer(playerid,"~r~Andriod18",1000,4); SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD); Name3DText[playerid] = Create3DTextLabel("Andriod18", COLOR_LIGHTBLUE, X, Y, Z+0.2, 20, 0, 0);Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);}
      case 13: { GameTextForPlayer(playerid,"~b~Andriod19",1000,4); SetPlayerFightingStyle(playerid, FIGHT_STYLE_GRABKICK); Name3DText[playerid] = Create3DTextLabel("Andriod19", COLOR_LIGHTBLUE, X, Y, Z+0.2, 20, 0, 0);Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);}
	}

	new name3[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name3,sizeof(name3));

	new skin = GetPlayerSkin(playerid);
	new string2[256];
	new name2[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name2,sizeof(name2));
	format(string2, sizeof(string2), "tabless/%s.%d.ini", name2,skin);
	if(pInfo[playerid][style][skin] != 0) SetPlayerFightingStyle(playerid,pInfo[playerid][style][skin]);
	SetPlayerScore(playerid,pInfo[playerid][Score]);
    if(GetPlayerTeam(playerid) == 2 && pInfo[playerid][dsword] == 1)    GivePlayerWeapon(playerid,WEAPON_KATANA,1);
    if(GetPlayerTeam(playerid) == 5 && pInfo[playerid][dknife] == 1) GivePlayerWeapon(playerid,WEAPON_KNIFE,1);
    if(GetPlayerTeam(playerid) == 10 && pInfo[playerid][dBazooka] == 1) GivePlayerWeapon(playerid,WEAPON_HEATSEEKER,20);
    if(pInfo[playerid][HEALTHMax][skin] > 5)
	{
	  SetPlayerHealth(playerid, pInfo[playerid][HEALTHMax][skin]);
      SetPlayerArmour(playerid, pInfo[playerid][HEALTHMax][skin]);
	}
	if(pInfo[playerid][DragonRadar] == 1)
	{
      if(pInfo[playerid][ball1] == 0) SetPlayerMapIcon(playerid, 1, -537.200683,-102.969543,63.296875, 56, 0, MAPICON_GLOBAL);
      if(pInfo[playerid][ball2] == 0) SetPlayerMapIcon(playerid, 2, -2670.812255,1933.930419,217.273895, 56, 0, MAPICON_GLOBAL);
      if(pInfo[playerid][ball3] == 0) SetPlayerMapIcon(playerid, 3, 1451.416748,-1076.615478,213.382812, 56, 0, MAPICON_GLOBAL);
      if(pInfo[playerid][ball4] == 0) SetPlayerMapIcon(playerid, 4, -1363.999755,493.684875,29.944622, 56, 0, MAPICON_GLOBAL);
      if(pInfo[playerid][ball5] == 0) SetPlayerMapIcon(playerid, 5, -61.429683,-37.518638,25.980148, 56, 0, MAPICON_GLOBAL);
      if(pInfo[playerid][ball6] == 0) SetPlayerMapIcon(playerid, 6, 281.206451,1816.537475,1.007812, 56, 0, MAPICON_GLOBAL);
      if(pInfo[playerid][ball7] == 0) SetPlayerMapIcon(playerid, 7, 2323.700439,1283.225341,97.661628, 56, 0, MAPICON_GLOBAL);
	}
    return 1;
}

//-=-=-=-=-=OnPlayerDeath=-=-=-=-=-

public OnPlayerDeath(playerid,killerid,reason)
{
  new string[256];
  new playname[MAX_PLAYER_NAME];
  new killname[MAX_PLAYER_NAME];
  new Float:X,Float:Y,Float:Z;
  //KillTimer(TimerUpdate[playerid]);
  Delete3DTextLabel(Name3DText[playerid]);
  CreateExplosionEx(playerid,0,12,1);
  PlaySound(playerid,SOUND_AWARD_TRACK_STOP);
  GetPlayerPos(playerid,X,Y,Z);
  CreatePickup(1240,5,X,Y,Z);
  GetPlayerName(playerid,playname,sizeof(playname));
  GetPlayerName(killerid,killname,sizeof(killname));
  SetPlayerColor(playerid,COLOR_BLACK);
  HideProgressBarForPlayer(playerid, BarraKi[playerid]);
  for(new i=0;i<MAX_PLAYERS;i++)
  {
	new iname[MAX_PLAYER_NAME];
	GetPlayerName(i,iname,sizeof(iname));
	if(betPlayer[i] == playerid)
	{
	  format(string,sizeof(string),"You lost your bet on %s(%d).",playname,playerid);
	  SendClientMessage(i,COLOR_RED,string);
	  format(string,sizeof(string),"%s(%d) betted on you and he lost %d PdD!",iname,i,betMoney[i]);
	  SendClientMessage(playerid,COLOR_RED,string);
	  GameTextForPlayer(i,"~r~bet lost",2000,5);
	  PlaySound(playerid,SOUND_SLAP);
	  betPlayer[i] = null;
	  betMoney[i] = 0;
	}
    if(betPlayer[i] == killerid)
	{
	  format(string,sizeof(string),"You won your bet on %s(%d) and you won %d PdD!",killname,killerid,2*betMoney[i]);
	  SendClientMessage(i,COLOR_LIGHTBLUE,string);
	  format(string,sizeof(string),"%s(%d) betted on you and he won %d PdD! You'll recieve a BONUS of 20 PdD!",iname,i,2*betMoney[i]);
	  SendClientMessage(killerid,COLOR_LIGHTBLUE,string);
	  AddPlayerScore(i,2*betMoney[i]);
	  AddPlayerScore(killerid, 20);
	  GameTextForPlayer(i,"~g~bet Won",2000,5);
	  PlaySound(playerid,SOUND_CHECKPOINT_RED);
	  betPlayer[i] = null;
	  betMoney[i] = 0;
	}
  }
  ForceClassSelection(playerid);
  if(killerid != INVALID_PLAYER_ID)
  {
    format(string,sizeof(string),"~b~%s ~r~was defeated by ~b~%s.", playname, killname);
    GameTextForAll(string,2000,5);
    SendDeathMessage(killerid,playerid,reason);
    print(string);
    AddPlayerScore(killerid,10);
    pInfo[killerid][Kills]++;//Will give 1 kill to killer and it will be saved inside of his/her account
    pInfo[playerid][Deaths]++;//Will give 1 death each time they die and it will be saved inside of his/her account
    return 1;
  }
  else
  {
	new NOccess = 0;
    for(new i=0;i<MAX_PLAYERS;i++)
    {
      if(IsPlayerNearPlayer(100, playerid, i) && !IsPlayerNPC(i) && IsPlayerConnected(i) && i != playerid) //If anyone was not recognized by the server as killerid
      {
        GetPlayerName(i, killname,sizeof(killname));
        format(string,sizeof(string),"~b~%s ~r~was defeated by ~b~%s.",playname,killname);
        AddPlayerScore(i, 10);
        GameTextForAll(string, 2000, 5);
        SendDeathMessage(i, playerid, 16);
        print(string);
        NOccess = 1;
        break;
	  }
      else continue;
    }
    if(!NOccess)
    {
      format(string,sizeof(string),"~b~%s ~r~ K.O.", playname);
      GameTextForAll(string, 2000, 5);
      SendDeathMessage(killerid, playerid, 56);
      print(string);
    }
    videlStopFly(playerid);
    StopFly(playerid);
	FLY_ON[playerid] =0;
	HideAllServerTextDraws(playerid);
 	}
    return 1;
}

//-=-=-=-=-=OnPlayerConnect=-=-=-=-=-

public OnPlayerConnect(playerid)
{
	new string[256];
	new name[MAX_PLAYER_NAME];
	VoteKick[playerid] = 0;
	GetPlayerName(playerid,name,sizeof(name));
	format(string,sizeof(string),"%s(%d) Has Joined The Server.",name,playerid);
	SendClientMessageToAll(COLOR_GREEN,string);
	SetPlayerColor(playerid,COLOR_BLACK);
	muted[playerid] = 0;

    TextDrawShowForPlayer(playerid,playerconnect[0]);
    TextDrawShowForPlayer(playerid,playerconnect[1]);
    TextDrawShowForPlayer(playerid,playerconnect[2]);
    TextDrawShowForPlayer(playerid,playerconnect[3]);
    TextDrawShowForPlayer(playerid,playerconnect[4]);
    TogglePlayerSpectating(playerid, 1);
    SetTimerEx("connecthide", 4000, false, "i", playerid);
    
    TdCombo[playerid] = TextDrawCreate(350.00,371.00,"COMBO");
    TextDrawUseBox(TdCombo[playerid],0);
    TextDrawFont(TdCombo[playerid],3);
    TextDrawSetShadow(TdCombo[playerid],0);
    TextDrawSetOutline(TdCombo[playerid],2);
    TextDrawBackgroundColor(TdCombo[playerid],COLOR_BLACK);
    TextDrawColor(TdCombo[playerid], COLOR_WHITE);
    TextDrawAlignment(TdCombo[playerid],3);
    TextDrawLetterSize(TdCombo[playerid],0.6,1.6);
    betPlayer[playerid] = null;
    betMoney[playerid] = 0;
    BarraKi[playerid] = CreateProgressBar(549.0, 25.0, 55.5, 3.2, 0x0000FFFF, 100.0);

	written_Toolbar1[playerid] = TextDrawCreate(562.000000, 44.000000, "FLOAT");
	TextDrawBackgroundColor(written_Toolbar1[playerid], 255);
	TextDrawFont(written_Toolbar1[playerid], 1);
	TextDrawLetterSize(written_Toolbar1[playerid], 0.500000, 1.000000);
	TextDrawColor(written_Toolbar1[playerid], -16776961);
	TextDrawSetOutline(written_Toolbar1[playerid], 0);
	TextDrawSetProportional(written_Toolbar1[playerid], 1);
	TextDrawSetShadow(written_Toolbar1[playerid], 1);

	written_Toolbar2[playerid] = TextDrawCreate(562.000000, 66.000000, "FLOAT");
	TextDrawBackgroundColor(written_Toolbar2[playerid], 255);
	TextDrawFont(written_Toolbar2[playerid], 1);
	TextDrawLetterSize(written_Toolbar2[playerid], 0.500000, 1.000000);
	TextDrawColor(written_Toolbar2[playerid], -1);
	TextDrawSetOutline(written_Toolbar2[playerid], 0);
	TextDrawSetProportional(written_Toolbar2[playerid], 1);
	TextDrawSetShadow(written_Toolbar2[playerid], 1);

	written_Toolbar3[playerid] = TextDrawCreate(560.000000, 22.000000, "FLOAT");
	TextDrawBackgroundColor(written_Toolbar3[playerid], 255);
	TextDrawFont(written_Toolbar3[playerid], 1);
	TextDrawLetterSize(written_Toolbar3[playerid], 0.500000, 1.000000);
	TextDrawColor(written_Toolbar3[playerid], -1);
	TextDrawSetOutline(written_Toolbar3[playerid], 0);
	TextDrawSetProportional(written_Toolbar3[playerid], 1);
	TextDrawSetShadow(written_Toolbar3[playerid], 1);
	warns[playerid] =0;
	failattemps[playerid] =0;
	videlInitFly(playerid);
	InitFly(playerid);
	return 1;
}

//-=-=-=-=-=OnPlayerDisconnect=-=-=-=-=-

public OnPlayerDisconnect(playerid, reason)
{
		new name[MAX_PLAYER_NAME]; //Making a new variable called 'name'. name[MAX_PLAYER_NAME] is created so we can use it to get player's name.
        GetPlayerName(playerid,name,sizeof(name)); //Get player's name
    	//new pname = strtolower(name);
     	if(fexist(Path(playerid)))
        {// then
        new INI:file = INI_Open(Path(playerid)); //will open their file
        INI_SetTag(file,"Players_Data");//We will set a tag inside of user's account called "Players_Data"
        INI_WriteInt(file,"Score",GetPlayerScore(playerid));//We will save his score inside of his account
        INI_WriteInt(file,"Kills",pInfo[playerid][Kills]);//As explained above
        INI_WriteInt(file,"Deaths",pInfo[playerid][Deaths]);//As explained above
        INI_WriteInt(file,"Banned",pInfo[playerid][Banned]);
        INI_WriteInt(file,"ball1",pInfo[playerid][ball1]);
        INI_WriteInt(file,"ball2",pInfo[playerid][ball2]);
        INI_WriteInt(file,"ball3",pInfo[playerid][ball3]);
        INI_WriteInt(file,"ball4",pInfo[playerid][ball4]);
        INI_WriteInt(file,"ball5",pInfo[playerid][ball5]);
        INI_WriteInt(file,"ball6",pInfo[playerid][ball6]);
        INI_WriteInt(file,"ball7",pInfo[playerid][ball7]);
        INI_WriteInt(file,"DragonRadar",pInfo[playerid][DragonRadar]);
        INI_WriteInt(file,"style[MAX_SKINS]",pInfo[playerid][style]);
        INI_WriteInt(file,"attack[MAX_SKINS]",pInfo[playerid][attack]);
        INI_WriteInt(file,"speed[MAX_SKINS]",pInfo[playerid][speed]);
        INI_WriteInt(file,"HEALTHMax[MAX_SKINS]",pInfo[playerid][HEALTHMax]);
        INI_WriteInt(file,"KiSize[MAX_SKINS]",pInfo[playerid][KiSize]);
        INI_WriteInt(file,"dsword",pInfo[playerid][KiSize]);
        INI_WriteInt(file,"dBazooka",pInfo[playerid][dBazooka]);
        INI_WriteInt(file,"dknife",pInfo[playerid][dknife]);
		INI_Close(file);//Now after we've done saving their data, we now need to close the file
		//SendClientMessage(playerid, COLOR_WHITE, "Your {00B9FF}Stats {FFFFFF}Have Been Automatically {FF0015}Saved.");
        new playername[MAX_PLAYER_NAME];
        GetPlayerName(playerid,playername,24);
        new str[120];
        format(str,sizeof(str),"<AUTO - SAVED> Stats for account: %s(%d) has been saved automatically.", playername, playerid);
        print(str);
  		}
  		KillTimer(AUTO_SAVE(playerid));
  //playerloggedin[playerid]=0;
  new string[256];

  TextDrawRIGHTy(TdCombo[playerid]);
  Delete3DTextLabel(Name3DText[playerid]);
  RIGHTyProgressBar(BarraKi[playerid]);
  KillTimer(ComboTimer[playerid]);
  //KillTimer(TimerUpdate[playerid]);
  VoteKick[playerid] = 0;
  AdminLevel[playerid] = 0;
  betPlayer[playerid] = -1;
  betMoney[playerid] = 0;
  muted[playerid] = 0;
  Combo[playerid] = 0;
  pInfo[playerid][Jailed] = 0;
  warns[playerid] =0;
  switch(reason)
  {

	  case 0:
	  {
	    format(string,sizeof(string),"%s(%d) has crashed.",name,playerid);
        SendClientMessageToAll(COLOR_RED,string);
        print(string);
  	  }

	  case 1:
	  {
        format(string,sizeof(string),"%s(%d) has left the server.",name,playerid);
        SendClientMessageToAll(COLOR_RED,string);
        print(string);
      }

      case 2:
      {
        format(string,sizeof(string),"%s(%d) has been kicked.",name,playerid);
        SendClientMessageToAll(COLOR_RED,string);
        print(string);
      }

  }
  KillTimer(login_timer1[playerid]);
  InitFly(playerid);
  FLY_ON[playerid] =0;
  return 1;
}

//-=-=-=-=-=OnPlayerUpdate=-=-=-=-=-

public OnPlayerUpdate(playerid)
{
  W_OnPlayerUpdate(playerid);
  new weapon;
  weapon = GetPlayerWeapon(playerid);
  if(weapon != 0 && weapon != WEAPON_KNIFE && weapon != WEAPON_KATANA && weapon != WEAPON_HEATSEEKER)
  {
    new name[MAX_PLAYER_NAME];
    new string[256];
    SetPlayerPos(playerid,prisonX,prisonY,prisonZ);
    SetPlayerInterior(playerid,6);
    GetPlayerName(playerid,name,sizeof(name));
    format(string, sizeof(string),"-SSB- %s got banned for 'Cheat(forbidden weapon)'.", name);
    SendClientMessageToAll(COLOR_KICK/BAN,string);
    SendClientMessage(playerid,COLOR_KICK/BAN,"Rule n�1: You mustn't use cheats in this server. Penalty: Ban.");
    SendClientMessage(playerid,COLOR_KICK/BAN,"The anti-forbidden-weapon system detected a forbidden weapon in your hands.");
    GameTextForPlayer(playerid,"YOU ARE NOW BANNED. /Q TO EXIT THE GAME.",300000,5);
    BanEx(playerid,"CHEAT(WEAPONS)");
    return 1;
  }
  return 1;
}

//-=-=-=-=-=OnPlayerText=-=-=-=-=-

public OnPlayerText(playerid,text[])
{
  /*if(!FrasePulita(playerid,text))
  {
    if(GetPVarInt(playerid, "InNOlti") < 4)
    {
	  SetPVarInt(playerid,"InNOlti", GetPVarInt(playerid, "InNOlti") + 1);
	  SendClientMessage(playerid,COLOR_RED, "InNOlt Count: +1");
	}
	else
	{
      new name[MAX_PLAYER_NAME];
      new string[256];
      SetPlayerPos(playerid,prisonX,prisonY,prisonZ);
      SetPlayerInterior(playerid,6);
      GetPlayerName(playerid,name,sizeof(name));
  	  format(string, sizeof(string), "-SSB- %s got kicked for 'Bad Language'.", name);
	  SendClientMessageToAll(COLOR_KICK/BAN,string);
      SendClientMessage(playerid,COLOR_KICK/BAN,"Rule n�3: You mustn't speak rude language. Penalty: Kick.");
      SendClientMessage(playerid,COLOR_KICK/BAN,"The InNOlt Count system counted 3 forbidden words.");
      GameTextForPlayer(playerid,"YOU ARE NOW DISCONNECTED. /Q TO EXIT THE GAME.",300000,5);
      Kick(playerid);
	}
    return 0;
  }*/
  if(muted[playerid] == 1)
  {
    SendClientMessage(playerid,COLOR_RED,"You can't chat! An admin has muted you!");
    return 0;
  }
  return 1;
}

//-=-=-=-=-=OnPlayerRequestClass=-=-=-=-=-

public OnPlayerRequestClass(playerid,classid)
{
  SetPlayerPos(playerid,-249.000000,6.000000,117.000000);
  SetPlayerFacingAngle(playerid,0.000000);
  SetPlayerCameraPos(playerid,-249.000000,9.000000,117.000000);
  SetPlayerCameraLookAt(playerid,-249.000000,6.000000,117.000000);
  PlaySound(playerid,SOUND_AWARD_TRACK_START);
  new team = GetPlayerTeam(playerid);
  if(team == 0)       GameTextForPlayer(playerid,"~<~~r~Son Goku~>~",1000,4);
  else if(team == 1)  GameTextForPlayer(playerid,"~<~~b~Vegeta~>~",1000,4);
  else if(team == 2)  GameTextForPlayer(playerid,"~<~~y~Trunks~>~",1000,4);
  else if(team == 3)  GameTextForPlayer(playerid,"~<~~g~Son Gohan~>~",1000,4);
  else if(team == 4)  GameTextForPlayer(playerid,"~<~~p~Hercule~>~",1000,4);
  else if(team == 5)  GameTextForPlayer(playerid,"~<~~r~Videl~>~",1000,4);
  else if(team == 6)  GameTextForPlayer(playerid,"~<~~b~Krillin~>~",1000,4);
  else if(team == 7)  GameTextForPlayer(playerid,"~<~~y~Yamcha~>~",1000,4);
  else if(team == 8)  GameTextForPlayer(playerid,"~<~~g~Tien~>~",1000,4);
  else if(team == 9)  GameTextForPlayer(playerid,"~<~~p~Dr.Gero~>~",1000,4);
  else if(team == 10) GameTextForPlayer(playerid,"~<~~r~Andriod16~>~",1000,4);
  else if(team == 11) GameTextForPlayer(playerid,"~<~~b~Andriod17~>~",1000,4);
  else if(team == 12) GameTextForPlayer(playerid,"~<~~y~Andriod18~>~",1000,4);
  else if(team == 13) GameTextForPlayer(playerid,"~<~~g~Andriod19",1000,4);
  return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(_:clickedid != INVALID_TEXT_DRAW)
	{
		if(clickedid == SpawnLoactionTD[3])
		{
			rand = random(sizeof(RandomAbandoned_Village));
			SetPlayerPos(playerid,RandomAbandoned_Village[rand][0],RandomAbandoned_Village[rand][1],RandomAbandoned_Village[rand][2]);
			SetPlayerInterior(playerid,0);
			TogglePlayerControllable(playerid,true);
			format(string,sizeof(string),"INFO: {FF0000}%s {FFFF00}is spawned in {33AA33}Abandoned Village.",name);
			SendClientMessageToAll(COLOR_YELLOW,string);
			GameTextForPlayer(playerid,"~r~GET READY... FIGHT!",2000,5);
			TogglePlayerControllable(playerid,false);
			GameTextForPlayer(playerid,"Loading...",1000,5);
			print(string);	
		}
		else if(clickedid == SpawnLoactionTD[4])
	    {
			rand = random(sizeof(RandomTenkaichi_tournament));
			SetPlayerPos(playerid,RandomTenkaichi_tournament[rand][0],RandomTenkaichi_tournament[rand][1],RandomTenkaichi_tournament[rand][2]);
			SetPlayerInterior(playerid,0);
			TogglePlayerControllable(playerid,true);
			format(string,sizeof(string),"INFO: {FF0000}%s {FFFF00}is spawned in {33AA33}Tenkaichi Tournament.",name);
			SendClientMessageToAll(COLOR_YELLOW,string);
			PlayerPlaySound(playerid,SOUND_OTB_TRACK_START,370.051879,-2023.086547,7.671875);
			//CreatePlayerObject(playerid, 18864, 370.051879,-2023.086547,7.671875, 0, 0, 0); //NEVE NATALIZIA         FOR CHRISTMAS UNCOMMENT THIS LINE
			GameTextForPlayer(playerid,"~r~GET READY... FIGHT!",2000,5);
			TogglePlayerControllable(playerid,false);
			GameTextForPlayer(playerid,"Loading...",1000,5);
			print(string);
	    }
		else if(clickedid == SpawnLoactionTD[7])
		{
			rand = random(sizeof(RandomUnderwater));
			SetPlayerPos(playerid,RandomUnderwater[rand][0],RandomUnderwater[rand][1],RandomUnderwater[rand][2]);
			SetPlayerInterior(playerid,0);
			TogglePlayerControllable(playerid,true);
			format(string,sizeof(string),"INFO: {FF0000}%s {FFFF00}is spawned in {33AA33}Underwater.",name);
			SendClientMessageToAll(COLOR_YELLOW,string);
			GameTextForPlayer(playerid,"~r~GET READY... FIGHT!",2000,5);
			TogglePlayerControllable(playerid,false);
			GameTextForPlayer(playerid,"Loading...",1000,5);
			print(string);
		}
		else if(clickedid == SpawnLoactionTD[8])
		{
			rand = random(sizeof(RandomSkyscraper));
			SetPlayerPos(playerid,RandomSkyscraper[rand][0],RandomSkyscraper[rand][1],RandomSkyscraper[rand][2]);
			SetPlayerInterior(playerid,0);
			TogglePlayerControllable(playerid,true);
			format(string,sizeof(string),"INFO: {FF0000}%s {FFFF00}is spawned in {33AA33}Skyscraper.",name);
			SendClientMessageToAll(COLOR_YELLOW,string);
			GameTextForPlayer(playerid,"~r~GET READY... FIGHT!",2000,5);
			TogglePlayerControllable(playerid,false);
			GameTextForPlayer(playerid,"Loading...",1000,5);
			print(string);
		}
		else if(clickedid == SpawnLoactionTD[9])
		{
			rand = random(sizeof(RandomBRIDGE));
			SetPlayerPos(playerid,RandomBRIDGE[rand][0],RandomBRIDGE[rand][1],RandomBRIDGE[rand][2]);
			SetPlayerInterior(playerid,0);
			TogglePlayerControllable(playerid,true);
			GameTextForPlayer(playerid,"~r~GET READY... FIGHT!",2000,5);
			format(string,sizeof(string),"INFO: {FF0000}%s {FFFF00}is spawned in {33AA33}BRIDGE.",name);
			SendClientMessageToAll(COLOR_YELLOW,string);
			TogglePlayerControllable(playerid,false);
			GameTextForPlayer(playerid,"Loading...",1000,5);
			print(string);
	    }
		else if(clickedid == SpawnLoactionTD[10])
		{
			rand = random(sizeof(RandomSPRINT_Training));
			SetPlayerPos(playerid,RandomSPRINT_Training[rand][0],RandomSPRINT_Training[rand][1],RandomSPRINT_Training[rand][2]);
			SetPlayerInterior(playerid,0);
			TogglePlayerControllable(playerid,true);
			GameTextForPlayer(playerid,"~r~GET READY... FIGHT!",2000,5);
			format(string,sizeof(string),"INFO: {FF0000}%s {FFFF00}is spawned in {33AA33}Training Zone.",name);
			SendClientMessageToAll(COLOR_YELLOW,string);
			TogglePlayerControllable(playerid,false);
			GameTextForPlayer(playerid,"Loading...",1000,5);
			print(string);
		}
		else if(clickedid == SpawnLoactionTD[11])
		{
			rand = random(sizeof(RandomArea69));
			SetPlayerPos(playerid,RandomArea69[rand][0],RandomArea69[rand][1],RandomArea69[rand][2]);
			SetPlayerInterior(playerid,0);
			TogglePlayerControllable(playerid,true);
			GameTextForPlayer(playerid,"~r~GET READY... FIGHT!",2000,5);
			format(string,sizeof(string),"INFO: {FF0000}%s {FFFF00}is spawned in {33AA33}Area 69.",name);
			SendClientMessageToAll(COLOR_YELLOW,string);
			TogglePlayerControllable(playerid,false);
			GameTextForPlayer(playerid,"Loading...",1000,5);
			print(string);
		}
		else if(clickedid == SpawnLoactionTD[12])
		{
			rand = random(sizeof(RandomCasino));
			SetPlayerPos(playerid,RandomCasino[rand][0],RandomCasino[rand][1],RandomCasino[rand][2]);
			SetPlayerInterior(playerid,0);
			TogglePlayerControllable(playerid,true);
			format(string,sizeof(string),"INFO: {FF0000}%s {FFFF00}is spawned in {33AA33}Casino.",name);
			SendClientMessageToAll(COLOR_YELLOW,string);
			GameTextForPlayer(playerid,"~r~GET READY... FIGHT!",2000,5);
			TogglePlayerControllable(playerid,false);
			GameTextForPlayer(playerid,"Loading...",1000,5);
			print(string);
		}
		else if(clickedid == SpawnLoactionTD[12])
		{
			rand = random(sizeof(RandomCasino));
			SetPlayerPos(playerid,830.6016,5.9404,1004.1797);
			SetPlayerInterior(playerid,3);
			TogglePlayerControllable(playerid,true);
			format(string,sizeof(string),"INFO: {FF0000}%s {FFFF00}is spawned in {33AA33}Customizing Room.",name);
			SendClientMessageToAll(COLOR_YELLOW,string);
			GameTextForPlayer(playerid,"~r~GET READY... ~b~DON'T FIGHT AT ALL!",2000,5);
			ResetPlayerMoney(playerid);
			print(string);
			TogglePlayerControllable(playerid,false);
			GameTextForPlayer(playerid,"Loading...",1000,5);
		}
		else if(clickedid == SpawnLoactionTD[6])
		{
			rand = random(sizeof(RandomSpawns));
			SetPlayerPos(playerid,RandomSpawns[rand][0],RandomSpawns[rand][1],RandomSpawns[rand][2]);
			SetPlayerInterior(playerid,0);
			TogglePlayerControllable(playerid,true);
			format(string,sizeof(string),"INFO: {FF0000}%s {FFFF00}is spawned in a {33AA33}random {FFFF00}battleground.",name);
			SendClientMessageToAll(COLOR_YELLOW,string);
			GameTextForPlayer(playerid,"~r~GET READY... FIGHT!",2000,5);
			PlaySound(playerid,SOUND_BEE_TRACK_STOP);
			TogglePlayerControllable(playerid,false);
			GameTextForPlayer(playerid,"Loading...",1000,5);
		}
		else if(clickedid == CustomizePlayerTD[3])
		{
			//fighting style
		}
		else if(clickedid == CustomizePlayerTD[4])
		{
			//Special Attack
		}
		else if(clickedid == CustomizePlayerTD[7])
		{
			//Max Health
		}
		else if(clickedid == CustomizePlayerTD[8])
		{
			//Max Ki
		}
		else if(clickedid == CustomizePlayerTD[9])
		{
			//Ki Effect
		}
		SetTimerEx("Unfreeze",1000,0,"i",playerid);
		HideAllServerTextDraws(playerid);
		CancelSelectTextDraw(playerid);
	}
	
	return 1;
}

//-=-=-=-=-=OnDialogResponse=-=-=-=-=-

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
  new string[256];
  new name[MAX_PLAYER_NAME];
  switch(dialogid)
  {
    case DIALOG_KILL:
    {
	  if(!response) return 1;
  	  SetPlayerHealth(playerid,0);
      SendClientMessage(playerid,COLOR_LIGHTBLUE,"Sent to character selection.");
    }
   case DIALOG_SHENRON:
    {
	  switch(listitem)
	  {
		case 0:
		{
		  pInfo[playerid][dsword] = 1;
		  SendClientMessage(playerid,COLOR_GREEN,"You selected the sword for Trunks!");
		}
		case 1:
		{
		  pInfo[playerid][dknife] = 1;
		  SendClientMessage(playerid,COLOR_GREEN,"You selected the knife for Videl!");
		}
		case 2:
		{
		  pInfo[playerid][dBazooka] = 1;
		  SendClientMessage(playerid,COLOR_GREEN,"You selected the rocket launcher for Andriod16!");
		}

	  }
	  return 1;
    }
    case DIALOG_PERSONALIZE://CLICK "FIND" AND INSERT ", 1997" IMMEDIATELY TO THIS SECTION OF THE SCRIPT
    {
	  if(!response)
	  {
        ShowPlayerDialog(playerid, DIALOG_SAVERE, DIALOG_STYLE_MSGBOX, SECONDARY_DIALOG_TEXT, "Do you want to keep the current data?", "Save", "Delete");
		return 1;
	  }
	  switch(listitem)
	  {
		case 0:
		{
		  ShowPlayerDialog(playerid, DIALOG_style, DIALOG_STYLE_LIST, "Select a fighting style:", TEXT_DIALOG_style, "Apply", "Back");
        }
		case 1:
		{
		  ShowPlayerDialog(playerid, DIALOG_attack, DIALOG_STYLE_LIST, "Select your new attack:", TEXT_DIALOG_attack1,"Apply","Back");
        }
		case 2:
		{
		  ShowPlayerDialog(playerid, DIALOG_PIU_speed, DIALOG_STYLE_LIST, "Set your speed:", TEXT_DIALOG_speed,"Apply","Back");
        }
		case 3:
		{
		  if(IsPlayerAnAndroid(playerid))
		  {
			GameTextForPlayer(playerid,"~r~Andriods don't use ki!",1000,5);
			ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
			return 1;
		  }
		  ShowPlayerDialog(playerid, DIALOG_PIU_Ki, DIALOG_STYLE_LIST, "Set the maximum ki:",TEXT_DIALOG_Ki,"Apply","Back");
		}
		case 4:
		{
		  ShowPlayerDialog(playerid, DIALOG_PIU_HEALTH, DIALOG_STYLE_LIST, "Set the maximum health:",TEXT_DIALOG_HEALTH,"Apply","Back");
        }

      }
	  return 1;
    }
    case DIALOG_Ki_SIZE:
    {
      new skin = GetPlayerSkin(playerid);
      if(!response) return ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
	  if(GetPlayerScore(playerid) < 20) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
	  AddPlayerScore(playerid,-20);
	  GameTextForPlayer(playerid,"loading",500,5);
	  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 20 Points Dragon to receive the item \"Increase of 0.5 magnitude on Ki\"!");
	  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
	  if(pInfo[playerid][KiSize][skin] == 0.0) pInfo[playerid][KiSize][skin] = 1.5;
	  else pInfo[playerid][KiSize][skin] += 0.5;
	  return 1;
	}
    case DIALOG_Ki_SIZE2:
    {
      new skin = GetPlayerSkin(playerid);
      if(!response) return ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
	  if(GetPlayerScore(playerid) < 5) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
	  AddPlayerScore(playerid,-5);
	  GameTextForPlayer(playerid,"loading",500,5);
	  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 20 DP to receive the object \"Decrement of 0.5 of ki size\"!");
	  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
	  if(pInfo[playerid][KiSize][skin] == 0.5) pInfo[playerid][KiSize][skin] = 0.5;
	  else pInfo[playerid][KiSize][skin] -= 0.5;
	  return 1;
	}
    case DIALOG_style:
	{
	  new skin = GetPlayerSkin(playerid);
	  if(!response) return ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
	  switch(listitem)
	  {
		case 0:
		{
		  if(GetPlayerScore(playerid) < 20) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU);
		  pInfo[playerid][style][skin] = FIGHT_STYLE_KUNGFU;
		  AddPlayerScore(playerid,-20);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 20 Points Dragon to receive the item \"style of the Z warriors\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 1:
		{
		  if(GetPlayerScore(playerid) < 10) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING);
		  pInfo[playerid][style][skin] = FIGHT_STYLE_BOXING;
		  AddPlayerScore(playerid,-10);
		  GameTextForPlayer(playerid,"loading",500,5);
          SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 10 Points Dragon to receive the item \"style warrior weak\"!");
          ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 2:
		{
		  if(GetPlayerScore(playerid) < 25) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD);
		  pInfo[playerid][style][skin] = FIGHT_STYLE_KNEEHEAD;
		  AddPlayerScore(playerid,-25);
		  GameTextForPlayer(playerid,"loading",500,5);
          SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 25 Points Dragon to receive the item \"style androids strong\"!");
          ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 3:
		{
		  if(GetPlayerScore(playerid) < 15) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  SetPlayerFightingStyle(playerid, FIGHT_STYLE_GRABKICK);
		  pInfo[playerid][style][skin] = FIGHT_STYLE_GRABKICK;
		  AddPlayerScore(playerid,-15);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 15 points to get the object of the Dragon \"style androids weak\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}

	  }
      return 1;
	}
    case DIALOG_attack:
	{
	  new skin = GetPlayerSkin(playerid);
	  if(!response) return ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");

	  switch(listitem)
	  {
		case 0:
		{
		  if(GetPlayerScore(playerid) < 30) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = KAMEHAMEHA;
		  AddPlayerScore(playerid,-30);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 30 Points Dragon to receive the item \"Kamehameha\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 1:
		{
		  if(GetPlayerScore(playerid) < 40) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = KAMEHAMEHA_FURIA;
		  AddPlayerScore(playerid,-40);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 40 points to get the object of the Dragon \"Kamehameha furious\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
        }
		case 2:
		{
		  if(GetPlayerScore(playerid) < 50) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = SUPER_KAMEHAMEHA;
		  AddPlayerScore(playerid,-50);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 50 Points Dragon to receive the item \"SUPER Kamehameha\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 3:
		{
		  if(GetPlayerScore(playerid) < 60) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = KAMEHAMEHA_MAX;
		  AddPlayerScore(playerid,-60);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 60 points to get the object of the Dragon \"Kamehameha A Maximum Intensity\"!");
   		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 4:
		{
		  if(GetPlayerScore(playerid) < 30) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = CANNONE_ESPLOSIVO;
		  AddPlayerScore(playerid,-30);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 30 Points Dragon to receive the item \"cannon Blast\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 5:
		{
		  if(GetPlayerScore(playerid) < 40) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = BIG_BANG_ATTACK;
		  AddPlayerScore(playerid,-40);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 40 points to get the object of the Dragon \"attack Big Bang\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 6:
		{
		  if(GetPlayerScore(playerid) < 50) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = LAMPO_FINALE;
		  AddPlayerScore(playerid,-50);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 50 Points Dragon to receive the item \"lightning Final\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 7:
		{
		  if(GetPlayerScore(playerid) < 20) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = MASENKO;
		  AddPlayerScore(playerid,-20);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 20 Points Dragon to receive the item \"Masenko\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 8:
		{
		  if(GetPlayerScore(playerid) < 40) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = SUPER_MASENKO;
		  AddPlayerScore(playerid,-40);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 40 points to get the object of the Dragon \"SUPER Masenko\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 9:
		{
		  if(GetPlayerScore(playerid) < 30) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = attack_BRUCIANTE;
		  AddPlayerScore(playerid,-30);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 30 Points Dragon to receive the item \"Scorching attack\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 10: { ShowPlayerDialog(playerid, DIALOG_attack2, DIALOG_STYLE_LIST, "Choose the Special attack to use with /att.", TEXT_DIALOG_attack2,"Apply","Back"); }
	  }
      return 1;
	}
	case DIALOG_SAVE_MATCH:
	{
	  switch(listitem)
	  {
		case 0: return 1;
		case 1:
		{
		  AUTO_SAVE(playerid);
		  GameTextForPlayer(playerid,"Saved game data",2000,5);
		  return 1;
		}
		case 2:
		{
          AUTO_SAVE(playerid);
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		  return 1;
        }
		case 3:
		{
          ShowPlayerDialog(playerid, DIALOG_BETTING, DIALOG_STYLE_INPUT,"bet battle:", "Choose a player to bet","forward","Cancel");
		  return 1;
		}
		case 4:
		{
		return 0;
		}
		case 5:
		{
          cmd_help(playerid);
		  return 1;
		}
		case 6:
		{
		  AUTO_SAVE(playerid);
		  SetPlayerHealth(playerid,0);
		  ForceClassSelection(playerid);
		  return 1;
		}
	  }
	}
	case DIALOG_BETTING://write in 2011 to find this part of the script
	{
	  if(!response) return 1;
	  new namescomm[MAX_PLAYER_NAME];
	  GetPlayerName(betPlayer[playerid],namescomm,sizeof(namescomm));
	  format(string,sizeof(string),"You can bet once until %s(%d) does not win or lose.",namescomm,betPlayer[playerid]);
	  if(betPlayer[playerid] != null) return SendClientMessage(playerid,COLOR_RED,string);
	  if(!strval(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BETTING, DIALOG_STYLE_INPUT,"Please enter numbers only!", "Choose a player to bet","Forward","Cancel");
	  if(!IsPlayerConnected(strval(inputtext))) return ShowPlayerDialog(playerid, DIALOG_BETTING, DIALOG_STYLE_INPUT,"Please enter a valid ID!", "Choose a player to bet","Forward","Cancel");
	  if(IsPlayerNPC(strval(inputtext))) return ShowPlayerDialog(playerid, DIALOG_BETTING, DIALOG_STYLE_INPUT,"You can not bet on an BOT!", "Choose a player to bet","Forward","Cancel");
	  if(strval(inputtext) == playerid) return ShowPlayerDialog(playerid, DIALOG_BETTING, DIALOG_STYLE_INPUT,"You can not bet on yourself!", "Choose a player to bet","Forward","Cancel");
	  betPlayer[playerid] = strval(inputtext);
      ShowPlayerDialog(playerid, DIALOG_BETTING2, DIALOG_STYLE_INPUT,"bet battle:", "Choose the amount of points for Dragon bet","Forward","Cancel");
      return 1;
	}
	case DIALOG_BETTING2:
	{
	  if(!response)
	  {
        betPlayer[playerid] = null;
        SendClientMessage(playerid,COLOR_RED,"All your current BETTING were Canceled.");
	    return 1;
      }
	  new score = GetPlayerScore(playerid);
	  if(!strval(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BETTING2, DIALOG_STYLE_INPUT,"Please enter only numbers!", "Choose the amount of points for the Dragon bet","Forward","Cancel");
	  if(score < strval(inputtext)) return ShowPlayerDialog(playerid, DIALOG_BETTING2, DIALOG_STYLE_INPUT,"You do not have enough PdD!", "Choose the amount of points for the Dragon bet","Forward","Cancel");
	  if(strval(inputtext) > 50) return ShowPlayerDialog(playerid, DIALOG_BETTING2, DIALOG_STYLE_INPUT,"The maximum is 50 PdD!", "Choose the amount of points for the Dragon bet","Forward","Cancel");
	  if(strval(inputtext) < 0) return ShowPlayerDialog(playerid, DIALOG_BETTING2, DIALOG_STYLE_INPUT,"The minimum is 0 PdD!", "Choose the amount of points for the Dragon bet","Forward","Cancel");
	  betMoney[playerid] = strval(inputtext);
	  new scommettitore[MAX_PLAYER_NAME];
	  new scommesso[MAX_PLAYER_NAME];
	  new quota = betMoney[playerid];
	  new playerid2 = betPlayer[playerid];
	  GetPlayerName(playerid,scommettitore,sizeof(scommettitore));
	  GetPlayerName(playerid2,scommesso,sizeof(scommesso));
	  format(string,sizeof(string),"You bet %d Dragon Points On %s(%d).",quota,scommesso,playerid2);
	  SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	  format(string,sizeof(string),"%s(%d) Has Betted %d Dragon Points On You.",scommettitore,playerid,quota);
	  SendClientMessage(playerid2,COLOR_LIGHTBLUE,string);
	  AddPlayerScore(playerid,-quota);
	  return 1;
	}
	case DIALOG_PIU_Ki:
	{
	  new skin = GetPlayerSkin(playerid);
	  if(!response) return ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
	  switch(listitem)
	  {
		case 0:
		{
		  if(GetPlayerScore(playerid) < 10) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][KiMax][skin] = 100;
		  AddPlayerScore(playerid,-10);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 10 Points Dragon to receive the item \"100 Units Ki\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 1:
		{
		  if(GetPlayerScore(playerid) < 35) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][KiMax][skin] = 125;
		  AddPlayerScore(playerid,-35);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 35 points to get the object of the Dragon \"125 Units Ki\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 2:
		{
		  if(GetPlayerScore(playerid) < 60) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][KiMax][skin] = 150;
		  AddPlayerScore(playerid,-60);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 60 Dragon Points to recive this object \"150 Units Ki\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 3:
		{
		  if(GetPlayerScore(playerid) < 110) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][KiMax][skin] = 200;
		  AddPlayerScore(playerid,-110);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 110 Dragon Points to recive this object \"200 Units Ki\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 4:
		{
		  if(GetPlayerScore(playerid) < 135) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][KiMax][skin] = 225;
		  AddPlayerScore(playerid,-135);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 135 Dragon Points to recive this object \"225 Units Ki\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 5:
		{
		  if(GetPlayerScore(playerid) < 160) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][KiMax][skin] = 250;
		  AddPlayerScore(playerid,-160);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 160 Dragon Points to recive this object \"250 Units Ki\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 6:
		{
		  if(GetPlayerScore(playerid) < 210) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][KiMax][skin] = 300;
		  AddPlayerScore(playerid,-210);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 210 Dragon Points to recive this object \"300 Units Ki\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 7:
		{
		  if(GetPlayerScore(playerid) < 260) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][KiMax][skin] = 350;
		  AddPlayerScore(playerid,-260);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 260 Dragon Points to recive this object \"350 Units Ki\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 8:
		{
		  if(GetPlayerScore(playerid) < 310) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][KiMax][skin] = 400;
		  AddPlayerScore(playerid,-310);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 310 Dragon Points to recive this object \"400 Units Ki\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 9:
		{
		  if(GetPlayerScore(playerid) < 410) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][KiMax][skin] = 500;
		  AddPlayerScore(playerid,-410);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 410 Dragon Points to recive this object \"500 Units Ki\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
	  }
      return 1;
	}
	case DIALOG_PIU_HEALTH:
	{
	  new skin = GetPlayerSkin(playerid);
	  if(!response) return ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
	  switch(listitem)
	  {
		case 0:
		{
		  if(GetPlayerScore(playerid) < 10) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][HEALTHMax][skin] = 100;
		  AddPlayerScore(playerid,-10);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 10 Dragon Points to recive this object \"100 HP\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 1:
		{
		  if(GetPlayerScore(playerid) < 25) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][HEALTHMax][skin] = 150;
		  AddPlayerScore(playerid,-25);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 25 Dragon Points to recive this object \"150 HP\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 2:
		{
		  if(GetPlayerScore(playerid) < 50) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][HEALTHMax][skin] = 200;
		  AddPlayerScore(playerid,-50);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 50 Dragon Points to recive this object \"200 HP\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 3:
		{
		  if(GetPlayerScore(playerid) < 75) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][HEALTHMax][skin] = 250;
		  AddPlayerScore(playerid,-75);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 75 Dragon Points to recive this object \"250 HP\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 4:
		{
		  if(GetPlayerScore(playerid) < 100) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][HEALTHMax][skin] = 300;
		  AddPlayerScore(playerid,-100);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 100 Dragon Points to recive this object \"300 HP\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 5:
		{
		  if(GetPlayerScore(playerid) < 125) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][HEALTHMax][skin] = 350;
		  AddPlayerScore(playerid,-125);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 125 Dragon Points to recive this object \"350 HP\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 6:
		{
		  if(GetPlayerScore(playerid) < 150) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][HEALTHMax][skin] = 400;
		  AddPlayerScore(playerid,-150);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 150 Dragon Points to recive this object \"400 HP\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 7:
		{
		  if(GetPlayerScore(playerid) < 175) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][HEALTHMax][skin] = 450;
		  AddPlayerScore(playerid,-175);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 175 Dragon Points to recive this object \"450 HP\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 8:
		{
		  if(GetPlayerScore(playerid) < 200) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][HEALTHMax][skin] = 500;
		  AddPlayerScore(playerid,-200);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 200 Dragon Points to recive this object \"500 HP\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
	  }
      return 1;
	}
    case DIALOG_PIU_speed:
	{
	  new skin = GetPlayerSkin(playerid);
	  if(!response) return ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
	  switch(listitem)
	  {
		case 0:
		{
		  if(GetPlayerScore(playerid) < 25) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][speed][skin] = 10;
		  AddPlayerScore(playerid,-25);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 25 Dragon Points to recive this object \"Speed 10 MPI\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 1:
		{
		  if(GetPlayerScore(playerid) < 50) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][speed][skin] = 20;
		  AddPlayerScore(playerid,-50);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 50 Dragon Points to recive this object \"Speed 20 MPI\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 2:
		{
		  if(GetPlayerScore(playerid) < 75) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][speed][skin] = 30;
		  AddPlayerScore(playerid,-75);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 75 Dragon Points to recive this object \"Speed 30 MPI\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 3:
		{
		  if(GetPlayerScore(playerid) < 100) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][speed][skin] = 40;
		  AddPlayerScore(playerid,-100);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 100 Dragon Points to recive this object \"Speed 40 MPI\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 4:
		{
		  if(GetPlayerScore(playerid) < 125) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][speed][skin] = 50;
		  AddPlayerScore(playerid,-125);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 125 Dragon Points to recive this object \"Speed 50 MPI\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 5:
		{
		  if(GetPlayerScore(playerid) < 150) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][speed][skin] = 60;
		  AddPlayerScore(playerid,-150);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 150 Dragon Points to recive this object \"Speed 60 MPI\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 6:
		{
		  if(GetPlayerScore(playerid) < 175) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][speed][skin] = 70;
		  AddPlayerScore(playerid,-175);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 175 Dragon Points to recive this object \"Speed 70 MPI\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 7:
		{
		  if(GetPlayerScore(playerid) < 200) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][speed][skin] = 80;
		  AddPlayerScore(playerid,-200);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 200 Dragon Points to recive this object \"Speed 80 MPI\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
	  }
      return 1;
	}
    case DIALOG_attack2:
	{
	  new skin = GetPlayerSkin(playerid);
	  if(!response) return ShowPlayerDialog(playerid, DIALOG_attack, DIALOG_STYLE_LIST, "Choose the Special attack to use with /att.", TEXT_DIALOG_attack1,"Apply","Back");

	  switch(listitem)
	  {
		case 0:
		{
		  if(GetPlayerScore(playerid) < 40) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = DISTRUTTORE_LETALE;
		  AddPlayerScore(playerid,-40);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 40 Dragon Points to recive this object \"Deadly RIGHTyer\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 1:
		{
		  if(GetPlayerScore(playerid) < 45) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = ARTIGLIO_DEL_LUPO;
		  AddPlayerScore(playerid,-45);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 45 Dragon Points to recive this object \"Wolf Claw Blast\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 2:
		{
		  if(GetPlayerScore(playerid) < 45) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = TRIPLO_RAGGIO;
		  AddPlayerScore(playerid,-45);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 45 Dragon Points to recive this object \"Triple Beam\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 3:
		{
		  if(GetPlayerScore(playerid) < 30) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = RAGGIO_ENERGETICO;
		  AddPlayerScore(playerid,-30);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 30 Dragon Points to recive this object \"Energy Ray\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 4:
		{
		  if(GetPlayerScore(playerid) < 50) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = SFERE_ENERGETICHE;
		  AddPlayerScore(playerid,-50);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 50 Dragon Points to recive this object \"Energy balls\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 5:
		{
		  if(GetPlayerScore(playerid) < 50) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = LANCIARAZZI;
		  AddPlayerScore(playerid,-50);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 50 Dragon Points to recive this object \"Built Rocket Launcher\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 6:
		{
		  if(GetPlayerScore(playerid) < 10) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = IL_CAMPIONE;
		  AddPlayerScore(playerid,-10);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 10 Dragon Points to recive this object \"the Champion\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 7:
		{
		  if(GetPlayerScore(playerid) < 15) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = GRAN_BOMBA_Ki;
		  AddPlayerScore(playerid,-15);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 15 Dragon Points to recive this object \"Great Bomb On Ki\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 8:
		{
		  if(GetPlayerScore(playerid) < 80) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = KAMEHAMEHA_FINALE;
		  AddPlayerScore(playerid,-80);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 80 Dragon Points to recive this object \"Kamehameha Finale\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
		case 9:
		{
		  if(GetPlayerScore(playerid) < 100) return SendClientMessage(playerid,COLOR_RED,NO_PUNTI_MESSAGE);
		  pInfo[playerid][attack][skin] = KAMEHAMEHA_BIG_BANG;
		  AddPlayerScore(playerid,-100);
		  GameTextForPlayer(playerid,"loading",500,5);
		  SendClientMessage(playerid,COLOR_LIGHTBLUE,"You paid 100 Dragon Points to recive this object \"Kamehameha Big Bang\"!");
		  ShowPlayerDialog(playerid, DIALOG_PERSONALIZE, DIALOG_STYLE_LIST, SECONDARY_DIALOG_TEXT, TEXT_DIALOG_MENU,"Continue","Finish");
		}
	  }
      return 1;
	}
	case dregister: 
    {//then
        if(!response) return Kick(playerid); //If they clicked the second button "Quit", we will kick them.
        if(response) //if they clicked the first button "Register"
        {//then
            if(!strlen(inputtext)) //If they didn't enter any password
            {// then we will tell to them to enter the password to register

                ShowPlayerDialog(playerid,dregister,DIALOG_STYLE_INPUT,"{02FBD6}Register","{FFFFFF}This account is not {02FBD6}registered{FFFFFF} - Please choose your{02FBD6} password{FFFFFF}.\nIf you already have an {E30544}account{FFFFFF}, then quit and change your nick\nin {E30544}SA-MP {FFFFFF}browser. ","Register","Quit");
                return 1;
            }
            //If they have entered a correct password for his/her account...
            new hashpass[129]; //Now we will create a new variable to hash his/her password
            WP_Hash(hashpass,sizeof(hashpass),inputtext);//We will use whirlpool to hash their inputted text
            new INI:file = INI_Open(Path(playerid)); // we will open a new file for them to save their account inside of Scriptfiles/Users folder
            INI_SetTag(file,"Players_Data");//We will set a tag inside of user's account called "Players_Data"
            INI_WriteString(file,"Password",hashpass);//This will write a hashed password into user's account
            INI_WriteInt(file,"Score",0);//Write an integer inside of user's account called "Money". We will set their money to 0 after he registered
            INI_WriteInt(file,"Kills",0);//Write an integer inside of user's account called "Scores". We will set their score to 0 after he registered
            INI_WriteInt(file,"Deaths",0);//As explained above
            INI_WriteInt(file,"Banned",0);//As explained above
            INI_WriteInt(file,"ball1",0);
            INI_WriteInt(file,"ball2",0);
            INI_WriteInt(file,"ball3",0);
            INI_WriteInt(file,"ball4",0);
            INI_WriteInt(file,"ball5",0);
            INI_WriteInt(file,"ball6",0);
            INI_WriteInt(file,"ball7",0);
            INI_WriteInt(file,"DragonRadar",0);
            INI_WriteInt(file,"style[MAX_SKINS]",0);
            INI_WriteInt(file,"attack[MAX_SKINS]",0);
            INI_WriteInt(file,"speed[MAX_SKINS]",0);
            INI_WriteInt(file,"HEALTHMax[MAX_SKINS]",0);
            INI_WriteInt(file,"KiMax[MAX_SKINS]",0);
            INI_WriteFloat(file,"KiSize[MAX_SKINS]",0);
            INI_WriteInt(file,"dsword",0);
            INI_WriteInt(file,"dBazooka",0);
            INI_WriteInt(file,"dknife",0);
            INI_Close(file);//Now after we've done saving their data, we now need to close the file
			SendClientMessage(playerid, COLOR_WHITE, "You have successfully registered On {00B9FF} The - Dragon Ball Z{FFFFFF}. Type {FFBE00}/help {FFFFFF}For Game Info.");
			SetTimerEx("AUTO_SAVE", AUTO_SAVE_MINUTES*60*1000, true, "i", playerid);
			playerloggedin[playerid] =1;
            return 1;
        }
    }
  }
  
    if(dialogid == dlogin) //If dialog id is a login dialog
    {//then
        if(!response)
		{
			Kick(playerid); //If they clicked the second button "Quit", we will kick them.
		}
		if(response) //if they clicked the first button "Register"
        {//then
            new hashpass[129]; //Will create a new variable to hash his/her password
            WP_Hash(hashpass,sizeof(hashpass),inputtext); //Will hash inputted password
            if(!strcmp(hashpass,pInfo[playerid][Pass])) //If they have insert their correct password
            {//then
                INI_ParseFile(Path(playerid),"loadaccount_%s",.bExtra = true, .extra = playerid);//We will load his account's data from user's path
				SetPlayerScore(playerid,pInfo[playerid][Score]);//We will get their score inside of his user's account and we will set it here
                SetTimerEx("AUTO_SAVE", AUTO_SAVE_MINUTES*60*1000, true, "i", playerid);
				SendClientMessage(playerid,0xFFFFFFFF, "Logged in as an {00FFFF}Registered Player.");
			}
			else //If they've entered an incorrect password
            {//then
                if (failattemps[playerid] == 0)
				{
					ShowPlayerDialog(playerid,dlogin,DIALOG_STYLE_PASSWORD,"{02FBD6}Login","{FFFFFF}This account is already {02FBD6}registered{FFFFFF} - Please {02FBD6}login{FFFFFF}.\nIf this is not your {E30544}account{FFFFFF}, then quit and change your nick\nin {E30544}SA-MP {FFFFFF}browser.\n{E30544}Invalid password!","Login","Quit");
					SendClientMessage(playerid, COLOR_RED,"* You have entered wrong password. (1/3) - 2 attemps remaining.");
				}
				if (failattemps[playerid] == 1)
				{
					ShowPlayerDialog(playerid,dlogin,DIALOG_STYLE_PASSWORD,"{02FBD6}Login","{FFFFFF}This account is already {02FBD6}registered{FFFFFF} - Please {02FBD6}login{FFFFFF}.\nIf this is not your {E30544}account{FFFFFF}, then quit and change your nick\nin {E30544}SA-MP {FFFFFF}browser.\n{E30544}Invalid password!","Login","Quit");
					SendClientMessage(playerid, COLOR_RED,"* You have entered wrong password, (2/3) - 1 attemps remaining.");
				}
				if (failattemps[playerid] == 2)
				{
					GetPlayerName(playerid, pname, sizeof(pname));
					ShowPlayerDialog(playerid, fail_login_dialog, DIALOG_STYLE_MSGBOX, "{E30544}Notice", "{FFFFFF}you have reached max login attemps {E30544}(3/3){FFFFFF} - You have been {E30544}kicked{FFFFFF}.\nIf you forgot your {E30544}password{FFFFFF} then contact our staff by following method:\n1). {0087FF}"website" {FFFFFF}- Our website\n2).{0087FF} "support_email" {FFFFFF} - Our NOpport", "Close", "");
					failattemps[playerid]++;
					playerloggedin[playerid] =1;
					return 1;
				}
			}
		}
  return 0;
}

//-=-=-=-=-=OnPlayerInteriorChange=-=-=-=-=-

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
  new string[256];
  new name[MAX_PLAYER_NAME];
  if(newinteriorid != INTERIOR_SALONE && newinteriorid != INTERIOR_OUTSIDE && newinteriorid != INTERIOR_SALONE)
  {
    SetPlayerPos(playerid,prisonX,prisonY,prisonZ);
    SetPlayerInterior(playerid,6);
	GetPlayerName(playerid,name,sizeof(name));
    format(string, sizeof(string), "-SSB- %s has been banned from the server to 'Use of cheat(interior change)'.", name);
    SendClientMessageToAll(COLOR_KICK/BAN,string);
    SendClientMessage(playerid,COLOR_KICK/BAN,"Rule#1: You can not use cheats (Hacks) on this server. Penalty: Ban.");
    SendClientMessage(playerid,COLOR_KICK/BAN,"The anti-interior-change has discovered that you are not inside Prison.");
    GameTextForPlayer(playerid,"NOW YOU ARE BANNED. /Q TO EXIT THE GAME.",300000,5);
    BanEx(playerid,"CHEAT(INTERIOR CHANGE)");
  }
  return 1;
}

//-=-=-=-=-=OnPlayerPickUpPickup=-=-=-=-=-

public OnPlayerPickUpPickup(playerid, pickupid)
{
  if(pickupid == SAVEMATCH)
  {
	ShowCustomizingPlayerTD(playerid);
    SetPlayerPos(playerid,822.736999,4.064427,1004.179687);//You move to the FIRE to avoid the re-pickup.
    return 1;
  }
  if(pickupid == Drago1)
  {
    if(pInfo[playerid][ball1] == 1) return GameTextForPlayer(playerid,"You Have Already Founded This Dragon Ball",500,5);
	pInfo[playerid][ball1] = 1;
	SendClientMessage(playerid,COLOR_YELLOW,"You Have Founded 1 Star Dragon Ball Don't Tell Anyone!");
	SendClientMessage(playerid,COLOR_BLUE,"When You Have Founded All 7 Dragon Balls Then /wish to make an wish Come true.");
	RemovePlayerMapIcon(playerid, 1);
	return 1;
  }
  if(pickupid == Drago2)
  {
    if(pInfo[playerid][ball2] == 1) return GameTextForPlayer(playerid,"You Have Already Founded This Dragon Ball",500,5);
	pInfo[playerid][ball2] = 1;
	SendClientMessage(playerid,COLOR_YELLOW,"You Have Founded 2 Star Dragon Ball Don't Tell Anyone!");
	SendClientMessage(playerid,COLOR_BLUE,"When You Have Founded All 7 Dragon Balls Then /wish to make an wish Come true.");
	RemovePlayerMapIcon(playerid, 2);
	return 1;
  }
  if(pickupid == Drago3)
  {
    if(pInfo[playerid][ball3] == 1) return GameTextForPlayer(playerid,"You Have Already Founded This Dragon Ball",500,5);
	pInfo[playerid][ball3] = 1;
	SendClientMessage(playerid,COLOR_YELLOW,"You Have Founded 3 Star Dragon Ball Don't Tell Anyone!");
	SendClientMessage(playerid,COLOR_BLUE,"When You Have Founded All 7 Dragon Balls Then /wish to make an wish Come true.");
	RemovePlayerMapIcon(playerid, 3);
	return 1;
  }
  if(pickupid == Drago4)
  {
    if(pInfo[playerid][ball4] == 1) return GameTextForPlayer(playerid,"You Have Already Founded This Dragon Ball",500,5);
	pInfo[playerid][ball4] = 1;
	SendClientMessage(playerid,COLOR_YELLOW,"You Have Founded 4 Star Dragon Ball Don't Tell Anyone!");
	SendClientMessage(playerid,COLOR_BLUE,"When You Have Founded All 7 Dragon Balls Then /wish to make an wish Come true.");
	RemovePlayerMapIcon(playerid, 4);
	return 1;
  }
  if(pickupid == Drago5)
  {
    if(pInfo[playerid][ball5] == 1) return GameTextForPlayer(playerid,"You Have Already Founded This Dragon Ball",500,5);
	pInfo[playerid][ball5] = 1;
	SendClientMessage(playerid,COLOR_YELLOW,"You Have Founded 5 Star Dragon Ball Don't Tell Anyone!");
	SendClientMessage(playerid,COLOR_BLUE,"When You Have Founded All 7 Dragon Balls Then /wish to make an wish Come true.");
	RemovePlayerMapIcon(playerid, 5);
	return 1;
  }
  if(pickupid == Drago6)
  {
    if(pInfo[playerid][ball6] == 1) return GameTextForPlayer(playerid,"You Have Already Founded This Dragon Ball",500,5);
	pInfo[playerid][ball6] = 1;
	SendClientMessage(playerid,COLOR_YELLOW,"You Have Founded 6 Star Dragon Ball Don't Tell Anyone!");
	SendClientMessage(playerid,COLOR_BLUE,"When You Have Founded All 7 Dragon Balls Then /wish to make an wish Come true.");
	RemovePlayerMapIcon(playerid, 6);
	return 1;
  }
  if(pickupid == Drago7)
  {
    if(pInfo[playerid][ball7] == 1) return GameTextForPlayer(playerid,"You Have Already Founded This Dragon Ball",500,5);
	pInfo[playerid][ball7] = 1;
	SendClientMessage(playerid,COLOR_YELLOW,"You Have Founded 7 Star Dragon Ball Don't Tell Anyone!");
	SendClientMessage(playerid,COLOR_BLUE,  "When You Have Founded All 7 Dragon Balls Then /wish to make an wish Come true.");
	RemovePlayerMapIcon(playerid, 7);
	return 1;
  }
  if(pickupid == Radar)
  {
    SendClientMessage(playerid,COLOR_YELLOW,"You Have Founded The Dragon Radar Now You Can See the Dragon Balls On Map");
    SendClientMessage(playerid,COLOR_BLUE,  "Dragon! Once you find all seven of you wish to choose one of the available!");
    if(pInfo[playerid][ball1] == 0) SetPlayerMapIcon(playerid, 1, -537.200683,-102.969543,63.296875, 56, 0, MAPICON_GLOBAL);
    if(pInfo[playerid][ball2] == 0) SetPlayerMapIcon(playerid, 2, -2670.812255,1933.930419,217.273895, 56, 0, MAPICON_GLOBAL);
    if(pInfo[playerid][ball3] == 0) SetPlayerMapIcon(playerid, 3, 1451.416748,-1076.615478,213.382812, 56, 0, MAPICON_GLOBAL);
    if(pInfo[playerid][ball4] == 0) SetPlayerMapIcon(playerid, 4, -1363.999755,493.684875,29.944622, 56, 0, MAPICON_GLOBAL);
    if(pInfo[playerid][ball5] == 0) SetPlayerMapIcon(playerid, 5, -61.429683,-37.518638,25.980148, 56, 0, MAPICON_GLOBAL);
    if(pInfo[playerid][ball6] == 0) SetPlayerMapIcon(playerid, 6, 281.206451,1816.537475,1.007812, 56, 0, MAPICON_GLOBAL);
    if(pInfo[playerid][ball7] == 0) SetPlayerMapIcon(playerid, 7, 2323.700439,1283.225341,97.661628, 56, 0, MAPICON_GLOBAL);
	pInfo[playerid][DragonRadar] = 1;
	return 1;
  }
  if(pickupid == Kill1 || pickupid == Kill2 || pickupid == Kill3 || pickupid == Kill4 || pickupid == Kill5 || pickupid == Kill6 || pickupid == Kill7 || pickupid == Kill8)
  {
	ShowPlayerDialog(playerid, DIALOG_KILL, DIALOG_STYLE_MSGBOX, "NOicide", "Do you want to kill yourself for change battleground and character?", "Yes", "No");
	return 1;
  }
  return 1;
}

//-=-=-=-=-=OnPlayerKeyStateChange=-=-=-=-=-

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
  if(GetPlayerInterior(playerid) == 3) return 1;
  if(newkeys == BUTTON_ALT)
  {
    if(!IsPlayerAnAndroid(playerid))
    {
      new Ki = GetPlayerMoney(playerid);
      if(Ki < 5) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      CreateExplosionEx(playerid,10,12,0.1);
      GivePlayerMoney(playerid,-5);
	}
	CreateExplosionEx(playerid,10,12,0.1);
  }

  if(newkeys == BUTTON_CLICK_UP)
  {
	KiTimer[playerid] = SetTimerEx("chargeKi", 250, true, "i", playerid);
	new skin = GetPlayerSkin(playerid);

	if(pInfo[playerid][KiSize][skin] == 0.0)
	{

		if(skin == SATAN || skin == VIDEL || skin == CRILIN || skin == YAMCHA || skin == TENSHINSHAN
	     || skin == GELO || skin == Andriod16 || skin == Andriod17 || skin == Andriod18 || skin == Andriod19)
    	{
 	  		SetPlayerAttachedObject(playerid, 0, 19197, 1, 0.000000, 0.000000, 0.000000, 170.000000, 90.000000, 90.000000, 1.0, 1.0, 1.0);
      		SetPlayerAttachedObject(playerid, 1, 19197, 1, 0.000000, 0.000000, 0.000000, 0.000000,   0.000000,   0.000000, 1.0, 1.0, 1.0);
      		SetPlayerAttachedObject(playerid, 2, 19197, 1, 0.000000, 0.000000, 0.000000, 170.000000, 0.000000,   0.000000, 1.0, 1.0, 1.0);

    	}

		else if(skin == GOKU0 || skin == VEGETA0 || skin == GOHAN0 || skin == TRUNKS0)
    	{
    		SetPlayerAttachedObject(playerid, 0, 18691, 1, 0.000000, 0.000000, 0.000000, 170.000000, 90.000000, 90.000000, 2.0, 2.0, 2.0);
      		SetPlayerAttachedObject(playerid, 1, 18691, 1, 0.000000, 0.000000, 0.000000, 0.000000,   0.000000,   0.000000, 2.0, 2.0, 2.0);
      		SetPlayerAttachedObject(playerid, 2, 18691, 1, 0.000000, 0.000000, 0.000000, 170.000000, 0.000000,   0.000000, 2.0, 2.0, 2.0);
    	}

		else if(skin == GOKU1 || skin == VEGETA1 || skin == GOHAN1 || skin == TRUNKS1)
		{
 	  		SetPlayerAttachedObject(playerid, 0, 19197, 1, 0.000000, 0.000000, 0.000000, 170.000000, 90.000000, 90.000000, 2.0, 2.0, 2.0);
      		SetPlayerAttachedObject(playerid, 1, 19197, 1, 0.000000, 0.000000, 0.000000, 0.000000,   0.000000,   0.000000, 2.0, 2.0, 2.0);
      		SetPlayerAttachedObject(playerid, 2, 19197, 1, 0.000000, 0.000000, 0.000000, 170.000000, 0.000000,   0.000000, 2.0, 2.0, 2.0);
    	}
		else if(skin == GOKU2 || skin == VEGETA2 || skin == GOHAN2)
    	{
 	  		SetPlayerAttachedObject(playerid, 0, 19197, 1, 0.000000, 0.000000, 0.000000, 170.000000, 90.000000, 90.000000, 2.5, 2.5, 2.5);
      		SetPlayerAttachedObject(playerid, 1, 19197, 1, 0.000000, 0.000000, 0.000000, 0.000000,   0.000000,   0.000000, 2.5, 2.5, 2.5);
      		SetPlayerAttachedObject(playerid, 2, 19197, 1, 0.000000, 0.000000, 0.000000, 170.000000, 0.000000,   0.000000, 2.5, 2.5, 2.5);
    	}
		else if(skin == VEGETAS || skin == TRUNKSS)
    	{
 	  		SetPlayerAttachedObject(playerid, 0, 19197, 1, 0.000000, 0.000000, 0.000000, 170.000000, 90.000000, 90.000000, 3.0, 3.0, 3.0);
      		SetPlayerAttachedObject(playerid, 1, 19197, 1, 0.000000, 0.000000, 0.000000, 0.000000,   0.000000,   0.000000, 3.0, 3.0, 3.0);
      		SetPlayerAttachedObject(playerid, 2, 19197, 1, 0.000000, 0.000000, 0.000000, 170.000000, 0.000000,   0.000000, 3.0, 3.0, 3.0);
    	}
		else if(skin == VEGETAS || skin == TRUNKSS)
    	{
 	  		SetPlayerAttachedObject(playerid, 0, 19197, 1, 0.000000, 0.000000, 0.000000, 170.000000, 90.000000, 90.000000, 3.5, 3.5, 3.5);
      		SetPlayerAttachedObject(playerid, 1, 19197, 1, 0.000000, 0.000000, 0.000000, 0.000000,   0.000000,   0.000000, 3.5, 3.5, 3.5);
      		SetPlayerAttachedObject(playerid, 2, 19197, 1, 0.000000, 0.000000, 0.000000, 170.000000, 0.000000,   0.000000, 3.5, 3.5, 3.5);
    	}
		else if(skin == GOKU3 || skin == VEGEKU0)
    	{
 	  		SetPlayerAttachedObject(playerid, 0, 19197, 1, 0.000000, 0.000000, 0.000000, 170.000000, 90.000000, 90.000000, 4.0, 4.0, 4.0);
      		SetPlayerAttachedObject(playerid, 1, 19197, 1, 0.000000, 0.000000, 0.000000, 0.000000,   0.000000,   0.000000, 4.0, 4.0, 4.0);
      		SetPlayerAttachedObject(playerid, 2, 19197, 1, 0.000000, 0.000000, 0.000000, 170.000000, 0.000000,   0.000000, 4.0, 4.0, 4.0);
    	}
		else if(skin == VEGEKU1 || skin == GOGETA)
    	{
 	  		SetPlayerAttachedObject(playerid, 0, 19197, 1, 0.000000, 0.000000, 0.000000, 170.000000, 90.000000, 90.000000, 4.5, 4.5, 4.5);
      		SetPlayerAttachedObject(playerid, 1, 19197, 1, 0.000000, 0.000000, 0.000000, 0.000000,   0.000000,   0.000000, 4.5, 4.5, 4.5);
      		SetPlayerAttachedObject(playerid, 2, 19197, 1, 0.000000, 0.000000, 0.000000, 170.000000, 0.000000,   0.000000, 4.5, 4.5, 4.5);
  		}
	}
	else
	{
		new Float: Size = pInfo[playerid][KiSize][skin];
        SetPlayerAttachedObject(playerid, 0, 19197, 1, 0.000000, 0.000000, 0.000000, 170.000000, 90.000000, 90.000000, Size, Size, Size);
        SetPlayerAttachedObject(playerid, 1, 19197, 1, 0.000000, 0.000000, 0.000000, 0.000000,   0.000000,   0.000000, Size, Size, Size);
        SetPlayerAttachedObject(playerid, 2, 19197, 1, 0.000000, 0.000000, 0.000000, 170.000000, 0.000000,   0.000000, Size, Size, Size);
	}
  }
  if(oldkeys == BUTTON_CLICK_UP)
  {
	KillTimer(KiTimer[playerid]);
	RemovePlayerAttachedObject(playerid, 0);
	RemovePlayerAttachedObject(playerid, 1);
	RemovePlayerAttachedObject(playerid, 2);
  }
/*  if(newkeys == BUTTON_JUMP)
  {
    pushing_onTimer[playerid] = SetTimerEx("pushing_on", 100, true, "i", playerid);
  }
  if(oldkeys == BUTTON_JUMP)
  {
	KillTimer(pushing_onTimer[playerid]);
  }

  if(newkeys == BUTTON_C)
  {
    push_GUNOUTTimer[playerid] = SetTimerEx("push_GUNOUT", 100, true, "i", playerid);
  }
  if(oldkeys == BUTTON_C)
  {
	KillTimer(push_GUNOUTTimer[playerid]);
  }

  if(newkeys == BUTTON_SPRINT)
  {
	Pushing_ForwardTimer[playerid] = SetTimerEx("Pushing_Forward", 100, true, "i", playerid);
  }
  if(oldkeys == BUTTON_SPRINT)
  {
	KillTimer(Pushing_ForwardTimer[playerid]);
  }

  // Tasti multipli          -------------------------------------

  if(newkeys == BUTTON_JUMP + BUTTON_CLICK_FIRE)
  {
    pushing_onTimer2[playerid] = SetTimerEx("pushing_on_short", 150, true, "i", playerid);
  }
  if(oldkeys == BUTTON_JUMP + BUTTON_CLICK_FIRE)
  {
	KillTimer(pushing_onTimer2[playerid]);
  }

//////////////
 if(newkeys == BUTTON_C + BUTTON_CLICK_FIRE)
  {
    push_GUNOUTTimer2[playerid] = SetTimerEx("push_GUNOUT_short", 150, true, "i", playerid);
  }
  if(oldkeys == BUTTON_C + BUTTON_CLICK_FIRE)
  {
	KillTimer(push_GUNOUTTimer2[playerid]);
  }

//////////////
 if(newkeys == BUTTON_SPRINT + BUTTON_CLICK_FIRE)
  {
    Pushing_ForwardTimer2[playerid] = SetTimerEx("Pushing_Forward_short", 150, true, "i", playerid);
  }
  if(oldkeys == BUTTON_SPRINT + BUTTON_CLICK_FIRE)
  {
	KillTimer(Pushing_ForwardTimer2[playerid]);
  }

  //                        -------------------------------------

  if(newkeys == BUTTON_ENTER)
  {
	new Float:ang;
	GetPlayerFacingAngle(playerid, ang);
    SetPlayerFacingAngle(playerid,ang -45);
    ClearAnimations(playerid);
  }*/

  if(newkeys == BUTTON_TAB)
  {
	GameTextForPlayer(playerid,"Score are Dragon Points.",5000,5);
  }
  if(newkeys == KEY_SECONDARY_ATTACK)
  {
	    new skin = GetPlayerSkin(playerid);
	    if(skin == VIDEL)
		{
			if(FLY_ON[playerid] == 0)
	 		{
			 	videlStartFly(playerid);
			 	FLY_ON[playerid] =1;
	 		}
	 		else
	 		{
			 	videlStopFly(playerid);
			 	FLY_ON[playerid] =0;
	 		}
	 	}
	 	else
	 	{
	 		if(FLY_ON[playerid] == 0)
	 		{
			 	StartFly(playerid);
			 	FLY_ON[playerid] =1;
	 		}
	 		else
	 		{
			 	StopFly(playerid);
			 	FLY_ON[playerid] =0;
	 		}
		}
  }
  if(newkeys & BUTTON_CLICK_FIRE || newkeys & BUTTON_CLICK_RIGHT && newkeys & BUTTON_ENTER) //Combo
  {
    for(new i=0;i<MAX_PLAYERS;i++)
    {
	  if(IsPlayerNearPlayer(1.0, playerid, i) && i != playerid)
	  {
        if(GetTickCount() - ComboTick[playerid] < 550) return 1;
        ComboTick[playerid] = GetTickCount();
	    KillTimer(ComboTimer[playerid]);
	    Combo[playerid] += 1;
	    new string[256];
        format(string,sizeof(string),"%d COMBO", Combo[playerid]);
        TextDrawSetString(TdCombo[playerid],string);
        TextDrawHideForPlayer(playerid,TdCombo[playerid]);
        TextDrawShowForPlayer(playerid,TdCombo[playerid]);
        ComboTimer[playerid] = SetTimerEx("OnPlayerFinishCombo",3000,false,"i",playerid);
	  }

    }

  }
  return 1;
}

//-=-=-=-=-=OnPlayerFinishCombo=-=-=-=-=-

public OnPlayerFinishCombo(playerid)
{
  Combo[playerid] = 0;
  TextDrawHideForPlayer(playerid,TdCombo[playerid]);
  return 1;
}

//-=-=-=-=-=push_GUNOUT=-=-=-=-=-

public push_GUNOUT(playerid)
{
	  new skin = GetPlayerSkin(playerid);
      new Float:X, Float:Y, Float:Z;
      new Ki = GetPlayerMoney(playerid);
      GetPlayerPos(playerid,X,Y,Z);
      if(pInfo[playerid][speed][skin] == 10) { if(!IsPlayerAnAndroid(playerid)) { if(Ki < 2) { return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5); } GivePlayerMoney(playerid,-2); } SetPlayerPos(playerid,X,Y,Z-10); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-10); return 1; }
      if(pInfo[playerid][speed][skin] == 20) { if(!IsPlayerAnAndroid(playerid)) { if(Ki < 2) { return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5); } GivePlayerMoney(playerid,-2); } SetPlayerPos(playerid,X,Y,Z-20); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-20); return 1; }
      if(pInfo[playerid][speed][skin] == 30) { if(!IsPlayerAnAndroid(playerid)) { if(Ki < 2) { return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5); } GivePlayerMoney(playerid,-2); } SetPlayerPos(playerid,X,Y,Z-30); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-30); return 1; }
      if(pInfo[playerid][speed][skin] == 40) { if(!IsPlayerAnAndroid(playerid)) { if(Ki < 2) { return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5); } GivePlayerMoney(playerid,-2); } SetPlayerPos(playerid,X,Y,Z-40); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-40); return 1; }
      if(pInfo[playerid][speed][skin] == 50) { if(!IsPlayerAnAndroid(playerid)) { if(Ki < 2) { return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5); } GivePlayerMoney(playerid,-2); } SetPlayerPos(playerid,X,Y,Z-50); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-50); return 1; }
      if(pInfo[playerid][speed][skin] == 60) { if(!IsPlayerAnAndroid(playerid)) { if(Ki < 2) { return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5); } GivePlayerMoney(playerid,-2); } SetPlayerPos(playerid,X,Y,Z-60); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-60); return 1; }
      if(pInfo[playerid][speed][skin] == 70) { if(!IsPlayerAnAndroid(playerid)) { if(Ki < 2) { return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5); } GivePlayerMoney(playerid,-2); } SetPlayerPos(playerid,X,Y,Z-70); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-70); return 1; }
      if(pInfo[playerid][speed][skin] == 80) { if(!IsPlayerAnAndroid(playerid)) { if(Ki < 2) { return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5); } GivePlayerMoney(playerid,-2); } SetPlayerPos(playerid,X,Y,Z-80); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-80); return 1; }

      if(!IsPlayerAnAndroid(playerid))
      {
	    if(Ki < 2)
	    {
		  ClearAnimations(playerid);
		  return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
	    }
        GivePlayerMoney(playerid,-2);
  		if(skin == GOKU0) { SetPlayerPos(playerid,X,Y,Z-5); CreateExplosion(X,Y,Z+5,11,1); }
  		if(skin == GOKU1) { SetPlayerPos(playerid,X,Y,Z-6); CreateExplosion(X,Y,Z+5,11,1); }
  		if(skin == GOKU2) { SetPlayerPos(playerid,X,Y,Z-8); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-8); }
  		if(skin == GOKU3) { SetPlayerPos(playerid,X,Y,Z-10); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-10); }
  		if(skin == VEGETA0) { SetPlayerPos(playerid,X,Y,Z-5); CreateExplosion(X,Y,Z+5,11,1); }
  		if(skin == VEGETA1) { SetPlayerPos(playerid,X,Y,Z-6); CreateExplosion(X,Y,Z+5,11,1); }
  		if(skin == VEGETAS) { SetPlayerPos(playerid,X,Y,Z-7); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-7); }
  		if(skin == VEGETA2) { SetPlayerPos(playerid,X,Y,Z-8); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-8); }
  		if(skin == GOHAN0) { SetPlayerPos(playerid,X,Y,Z-5); CreateExplosion(X,Y,Z+5,11,1); }
  		if(skin == GOHAN1) { SetPlayerPos(playerid,X,Y,Z-8); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-8); }
  		if(skin == GOHAN2) { SetPlayerPos(playerid,X,Y,Z-10); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-10); }
  		if(skin == TRUNKS0) { SetPlayerPos(playerid,X,Y,Z-5); CreateExplosion(X,Y,Z+5,11,1); }
  		if(skin == TRUNKS1) { SetPlayerPos(playerid,X,Y,Z-6); CreateExplosion(X,Y,Z+5,11,1); }
  		if(skin == TRUNKSS) { SetPlayerPos(playerid,X,Y,Z-7); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-7); }
  		if(skin == SATAN) { SetPlayerPos(playerid,X,Y,Z-3); CreateExplosion(X,Y,Z+5,11,1); }
  		if(skin == VIDEL) { SetPlayerPos(playerid,X,Y,Z-4); CreateExplosion(X,Y,Z+5,11,1); }
  		if(skin == CRILIN) { SetPlayerPos(playerid,X,Y,Z-5); CreateExplosion(X,Y,Z+5,11,1); }
  		if(skin == YAMCHA) { SetPlayerPos(playerid,X,Y,Z-5); CreateExplosion(X,Y,Z+5,11,1); }
  		if(skin == TENSHINSHAN) { SetPlayerPos(playerid,X,Y,Z-5); CreateExplosion(X,Y,Z+5,11,1); }
  		if(skin == VEGEKU0) { SetPlayerPos(playerid,X,Y,Z-10); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-10); }
  		if(skin == VEGEKU1) { SetPlayerPos(playerid,X,Y,Z-15); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-15); }
  		if(skin == GOGETA) { SetPlayerPos(playerid,X,Y,Z-15); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z-15); }
        return 1;
	  }
      SetPlayerPos(playerid,X,Y,Z-6);
      PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z);
      return 1;
}

//-=-=-=-=-=pushing_on=-=-=-=-=-

public pushing_on(playerid)
{
	  new skin = GetPlayerSkin(playerid);
      new Float:X, Float:Y, Float:Z;
      new Ki = GetPlayerMoney(playerid);
      GetPlayerPos(playerid,X,Y,Z);
      if(pInfo[playerid][speed][skin] == 10) { if(!IsPlayerAnAndroid(playerid)) { if(Ki < 2) { return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5); } GivePlayerMoney(playerid,-2); } SetPlayerPos(playerid,X,Y,Z+10); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+10); return 1; }
      if(pInfo[playerid][speed][skin] == 20) { if(!IsPlayerAnAndroid(playerid)) { if(Ki < 2) { return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5); } GivePlayerMoney(playerid,-2); } SetPlayerPos(playerid,X,Y,Z+20); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+20); return 1; }
      if(pInfo[playerid][speed][skin] == 30) { if(!IsPlayerAnAndroid(playerid)) { if(Ki < 2) { return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5); } GivePlayerMoney(playerid,-2); } SetPlayerPos(playerid,X,Y,Z+30); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+30); return 1; }
      if(pInfo[playerid][speed][skin] == 40) { if(!IsPlayerAnAndroid(playerid)) { if(Ki < 2) { return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5); } GivePlayerMoney(playerid,-2); } SetPlayerPos(playerid,X,Y,Z+40); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+40); return 1; }
      if(pInfo[playerid][speed][skin] == 50) { if(!IsPlayerAnAndroid(playerid)) { if(Ki < 2) { return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5); } GivePlayerMoney(playerid,-2); } SetPlayerPos(playerid,X,Y,Z+50); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+50); return 1; }
      if(pInfo[playerid][speed][skin] == 60) { if(!IsPlayerAnAndroid(playerid)) { if(Ki < 2) { return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5); } GivePlayerMoney(playerid,-2); } SetPlayerPos(playerid,X,Y,Z+60); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+60); return 1; }
      if(pInfo[playerid][speed][skin] == 70) { if(!IsPlayerAnAndroid(playerid)) { if(Ki < 2) { return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5); } GivePlayerMoney(playerid,-2); } SetPlayerPos(playerid,X,Y,Z+70); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+70); return 1; }
      if(pInfo[playerid][speed][skin] == 80) { if(!IsPlayerAnAndroid(playerid)) { if(Ki < 2) { return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5); } GivePlayerMoney(playerid,-2); } SetPlayerPos(playerid,X,Y,Z+80); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+80); return 1; }

      if(!IsPlayerAnAndroid(playerid))
      {
	    if(Ki < 2)
	    {
		  ClearAnimations(playerid);
		  return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
	    }
        GivePlayerMoney(playerid,-2);
  		if(skin == GOKU0) { SetPlayerPos(playerid,X,Y,Z+5); CreateExplosion(X,Y,Z-5,11,1); }
  		if(skin == GOKU1) { SetPlayerPos(playerid,X,Y,Z+6); CreateExplosion(X,Y,Z-5,11,1); }
  		if(skin == GOKU2) { SetPlayerPos(playerid,X,Y,Z+8); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+8); }
  		if(skin == GOKU3) { SetPlayerPos(playerid,X,Y,Z+10); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+10); }
  		if(skin == VEGETA0) { SetPlayerPos(playerid,X,Y,Z+5); CreateExplosion(X,Y,Z-5,11,1); }
  		if(skin == VEGETA1) { SetPlayerPos(playerid,X,Y,Z+6); CreateExplosion(X,Y,Z-5,11,1); }
  		if(skin == VEGETAS) { SetPlayerPos(playerid,X,Y,Z+7); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+7); }
  		if(skin == VEGETA2) { SetPlayerPos(playerid,X,Y,Z+8); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+8); }
  		if(skin == GOHAN0) { SetPlayerPos(playerid,X,Y,Z+5); CreateExplosion(X,Y,Z-5,11,1); }
  		if(skin == GOHAN1) { SetPlayerPos(playerid,X,Y,Z+8); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+8); }
  		if(skin == GOHAN2) { SetPlayerPos(playerid,X,Y,Z+10); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+10); }
  		if(skin == TRUNKS0) { SetPlayerPos(playerid,X,Y,Z+5); CreateExplosion(X,Y,Z-5,11,1); }
  		if(skin == TRUNKS1) { SetPlayerPos(playerid,X,Y,Z+6); CreateExplosion(X,Y,Z-5,11,1); }
  		if(skin == TRUNKSS) { SetPlayerPos(playerid,X,Y,Z+7); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+7); }
  		if(skin == SATAN) { SetPlayerPos(playerid,X,Y,Z+3); CreateExplosion(X,Y,Z-5,11,1); }
  		if(skin == VIDEL) { SetPlayerPos(playerid,X,Y,Z+4); CreateExplosion(X,Y,Z-5,11,1); }
  		if(skin == CRILIN) { SetPlayerPos(playerid,X,Y,Z+5); CreateExplosion(X,Y,Z-5,11,1); }
  		if(skin == YAMCHA) { SetPlayerPos(playerid,X,Y,Z+5); CreateExplosion(X,Y,Z-5,11,1); }
  		if(skin == TENSHINSHAN) { SetPlayerPos(playerid,X,Y,Z+5); CreateExplosion(X,Y,Z-5,11,1); }
  		if(skin == VEGEKU0) { SetPlayerPos(playerid,X,Y,Z+10); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+10); }
  		if(skin == VEGEKU1) { SetPlayerPos(playerid,X,Y,Z+15); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+15); }
  		if(skin == GOGETA) { SetPlayerPos(playerid,X,Y,Z+15); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z+15); }
        return 1;
	  }
      SetPlayerPos(playerid,X,Y,Z+6);
      PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z);
      return 1;
}

//-=-=-=-=-=OnPlayerHealthChange=-=-=-=-=-

public OnPlayerHealthChange(playerid, Float:newhealth, Float:oldhealth)
{
  new string[21];
  format(string, sizeof(string), "%d", floatround(newhealth));
  TextDrawSetString(written_Toolbar2[playerid], string);
  TextDrawHideForPlayer(playerid, written_Toolbar2[playerid]);
  TextDrawShowForPlayer(playerid, written_Toolbar2[playerid]);
  return 1;
}

//-=-=-=-=-=OnPlayerArmourChange=-=-=-=-=-

public OnPlayerArmourChange(playerid, Float:newarmour, Float:oldarmour)
{
  new string[21];
  format(string, sizeof(string), "%d", floatround(newarmour));
  TextDrawSetString(written_Toolbar1[playerid], string);
  TextDrawHideForPlayer(playerid, written_Toolbar1[playerid]);
  TextDrawShowForPlayer(playerid, written_Toolbar1[playerid]);
  return 1;
}

//-=-=-=-=-=OnPlayerMoneyChange=-=-=-=-=-

public OnPlayerMoneyChange(playerid, newmoney, oldmoney)
{
  new Float:HEALTH;
  new Ki = GetPlayerMoney(playerid);
  GetPlayerHealth(playerid,HEALTH);
  if(HEALTH < 5.0) SetPlayerHealth(playerid,0); //
  if(Ki < 0) ResetPlayerMoney(playerid); //
  HideProgressBarForPlayer(playerid,BarraKi[playerid]);
  SetProgressBarValue(BarraKi[playerid], Ki/5); //NOTE - Divided by 5 because the max is 500 not 100
  ShowProgressBarForPlayer(playerid,BarraKi[playerid]);

  new string[21];
  format(string, sizeof(string), "%d", newmoney);
  TextDrawSetString(written_Toolbar3[playerid], string);
  TextDrawHideForPlayer(playerid, written_Toolbar3[playerid]);
  TextDrawShowForPlayer(playerid, written_Toolbar3[playerid]);
  return 1;
}

//-=-=-=-=-=Pushing_Forward_short=-=-=-=-=-

public Pushing_Forward_short(playerid)
{
    new Float:X, Float:Y, Float:Z, Float:x2, Float:y2, Float:ang;
	GetPlayerPos(playerid, X, Y, Z);
  	GetPlayerFacingAngle(playerid, ang);
    x2 = X + floatsin(-ang, degrees);
    y2 = Y + floatcos(-ang, degrees);
    SetPlayerPos(playerid, x2, y2, Z);
    return 1;
}

//-=-=-=-=-=pushing_on_short=-=-=-=-=-

public pushing_on_short(playerid)
{
    new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
    SetPlayerPos(playerid, X, Y, Z+2);
    return 1;
}

//-=-=-=-=-=push_GUNOUT_short=-=-=-=-=-

public push_GUNOUT_short(playerid)
{
    new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
    SetPlayerPos(playerid, X, Y, Z-1);
    return 1;
}

//-=-=-=-=-=Pushing_Forward=-=-=-=-=-

public Pushing_Forward(playerid)
{
    new Float:X,Float:Y,Float:Z,Float:x2,Float:y2,Float:x3,Float:y3,Float:ang;
    new Ki = GetPlayerMoney(playerid);
	new skin = GetPlayerSkin(playerid);
	GetPlayerPos(playerid,X,Y,Z);
  	GetPlayerFacingAngle(playerid, ang);
        if(pInfo[playerid][speed][skin] == 10)
        {
		  if(!IsPlayerAnAndroid(playerid))
		  {
		    if(Ki < 1) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
		    GivePlayerMoney(playerid,-1);
		  }
          x2 = X + (10 * floatsin(-ang, degrees));
		  y2 = Y + (10 * floatcos(-ang, degrees));
		  SetPlayerPos(playerid,x2,y2,Z);
		  PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z);
		  return 1;
        }
        if(pInfo[playerid][speed][skin] == 20)
        {
		  if(!IsPlayerAnAndroid(playerid))
		  {
		    if(Ki < 2) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
		    GivePlayerMoney(playerid,-2);
		  }
          x2 = X + (20 * floatsin(-ang, degrees));
		  y2 = Y + (20 * floatcos(-ang, degrees));
		  SetPlayerPos(playerid,x2,y2,Z);
		  PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z);
		  return 1;
        }
        if(pInfo[playerid][speed][skin] == 30)
        {
		  if(!IsPlayerAnAndroid(playerid))
		  {
		    if(Ki < 3) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
		    GivePlayerMoney(playerid,-3);
		  }
          x2 = X + (30 * floatsin(-ang, degrees));
		  y2 = Y + (30 * floatcos(-ang, degrees));
		  SetPlayerPos(playerid,x2,y2,Z);
		  PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z);
		  return 1;
        }
        if(pInfo[playerid][speed][skin] == 40)
        {
		  if(!IsPlayerAnAndroid(playerid))
		  {
		    if(Ki < 4) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
		    GivePlayerMoney(playerid,-4);
		  }
          x2 = X + (40 * floatsin(-ang, degrees));
		  y2 = Y + (40 * floatcos(-ang, degrees));
		  SetPlayerPos(playerid,x2,y2,Z);
		  PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z);
		  return 1;
        }
        if(pInfo[playerid][speed][skin] == 50)
        {
		  if(!IsPlayerAnAndroid(playerid))
		  {
		    if(Ki < 5) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
		    GivePlayerMoney(playerid,-5);
		  }
          x2 = X + (50 * floatsin(-ang, degrees));
		  y2 = Y + (50 * floatcos(-ang, degrees));
		  SetPlayerPos(playerid,x2,y2,Z);
		  PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z);
		  return 1;
        }
        if(pInfo[playerid][speed][skin] == 60)
        {
		  if(!IsPlayerAnAndroid(playerid))
		  {
		    if(Ki < 6) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
		    GivePlayerMoney(playerid,-6);
		  }
          x2 = X + (60 * floatsin(-ang, degrees));
		  y2 = Y + (60 * floatcos(-ang, degrees));
		  SetPlayerPos(playerid,x2,y2,Z);
		  PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z);
		  return 1;
        }
        if(pInfo[playerid][speed][skin] == 70)
        {
		  if(!IsPlayerAnAndroid(playerid))
		  {
		    if(Ki < 7) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
		    GivePlayerMoney(playerid,-7);
		  }
          x2 = X + (70 * floatsin(-ang, degrees));
		  y2 = Y + (70 * floatcos(-ang, degrees));
		  SetPlayerPos(playerid,x2,y2,Z);
		  PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z);
		  return 1;
        }
        if(pInfo[playerid][speed][skin] == 80)
        {
		  if(!IsPlayerAnAndroid(playerid))
		  {
		    if(Ki < 8) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
		    GivePlayerMoney(playerid,-8);
		  }
          x2 = X + (80 * floatsin(-ang, degrees));
		  y2 = Y + (80 * floatcos(-ang, degrees));
		  SetPlayerPos(playerid,x2,y2,Z);
		  PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z);
		  return 1;
        }
      if(!IsPlayerAnAndroid(playerid))
      {
  		x3 = X + (-10 * floatsin(-ang, degrees));
        y3 = Y + (-10 * floatcos(-ang, degrees));

        if(Ki < 1) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
        GivePlayerMoney(playerid,-1);

  		if(skin == GOKU0) { x2 = X + (5 * floatsin(-ang, degrees)); y2 = Y + (5 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); CreateExplosion(x3,y3,Z,11,1); }
  		else if(skin == GOKU1) { x2 = X + (6 * floatsin(-ang, degrees)); y2 = Y + (6 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); CreateExplosion(x3,y3,Z,11,1); }
  		else if(skin == GOKU2) { x2 = X + (8 * floatsin(-ang, degrees)); y2 = Y + (8 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z); }
  		else if(skin == GOKU3) { x2 = X + (10 * floatsin(-ang, degrees)); y2 = Y + (10 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z); }
  		else if(skin == VEGETA0) { x2 = X + (5 * floatsin(-ang, degrees)); y2 = Y + (5 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); CreateExplosion(x2,y3,Z,11,1); }
  		else if(skin == VEGETA1) { x2 = X + (6 * floatsin(-ang, degrees)); y2 = Y + (6 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); CreateExplosion(x3,y3,Z,11,1); }
  		else if(skin == VEGETAS) { x2 = X + (7 * floatsin(-ang, degrees)); y2 = Y + (7 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z); }
  		else if(skin == VEGETA2) { x2 = X + (8 * floatsin(-ang, degrees)); y2 = Y + (8 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z); }
  		else if(skin == GOHAN0) { x2 = X + (5 * floatsin(-ang, degrees)); y2 = Y + (5 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); CreateExplosion(x3,y3,Z,11,1); }
  		else if(skin == GOHAN1) {  x2 = X + (8 * floatsin(-ang, degrees)); y2 = Y + (8 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z); }
  		else if(skin == GOHAN2) { x2 = X + (10 * floatsin(-ang, degrees)); y2 = Y + (10 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z); }
  		else if(skin == TRUNKS0) { x2 = X + (5 * floatsin(-ang, degrees)); y2 = Y + (5 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); CreateExplosion(x3,y3,Z,11,1); }
  		else if(skin == TRUNKS1) { x2 = X + (6 * floatsin(-ang, degrees)); y2 = Y + (6 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); CreateExplosion(x3,y3,Z,11,1); }
  		else if(skin == TRUNKSS) { x2 = X + (7 * floatsin(-ang, degrees)); y2 = Y + (7 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z); }
  		else if(skin == SATAN) { x2 = X + (3 * floatsin(-ang, degrees)); y2 = Y + (3 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); CreateExplosion(x3,y3,Z,11,1); }
  		else if(skin == VIDEL) { x2 = X + (4 * floatsin(-ang, degrees)); y2 = Y + (4 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); CreateExplosion(x3,y3,Z,11,1); }
  		else if(skin == CRILIN) { x2 = X + (5 * floatsin(-ang, degrees)); y2 = Y + (5 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); CreateExplosion(x3,y3,Z,11,1); }
  		else if(skin == YAMCHA) { x2 = X + (5 * floatsin(-ang, degrees)); y2 = Y + (5 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); CreateExplosion(x3,y3,Z,11,1); }
  		else if(skin == TENSHINSHAN) { x2 = X + (5 * floatsin(-ang, degrees)); y2 = Y + (5 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); CreateExplosion(x3,y3,Z,11,1); }
  		else if(skin == VEGEKU0) { x2 = X + (10 * floatsin(-ang, degrees)); y2 = Y + (10 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z); }
  		else if(skin == VEGEKU1) { x2 = X + (15 * floatsin(-ang, degrees)); y2 = Y + (15 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z); }
  		else if(skin == GOGETA) { x2 = X + (15 * floatsin(-ang, degrees)); y2 = Y + (15 * floatcos(-ang, degrees)); SetPlayerPos(playerid,x2,y2,Z); PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,x2,y2,Z); }
        return 1;
	  }
	  GetPlayerPos(playerid,X,Y,Z);
	  GetPlayerFacingAngle(playerid, ang);
	  x2 = X + (6 * floatsin(-ang, degrees));
	  y2 = Y + (6 * floatcos(-ang, degrees));
	  PlayerPlaySound(playerid,SOUND_CAMERA_SHOT,X,Y,Z);
      SetPlayerPos(playerid,x2,y2,Z);
      return 1;
}

//-=-=-=-=-=chargeKi=-=-=-=-=-

public chargeKi(playerid)
{
	new skin = GetPlayerSkin(playerid);
    new Ki = GetPlayerMoney(playerid);
    new Float:X, Float:Y, Float:Z;
    new KiGiocatore = pInfo[playerid][KiMax][skin];
    GetPlayerPos(playerid,X,Y,Z);
    switch(skin)
    {
	  case GOKU0:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,5);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 100)
		{
		  SetPlayerMoney(playerid,100);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,5);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case GOKU1:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,6);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 105)
		{
		  SetPlayerMoney(playerid,105);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,6);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case GOKU2:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,7);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 110)
		{
		  SetPlayerMoney(playerid,110);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,7);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case GOKU3:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,8);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 120)
		{
		  SetPlayerMoney(playerid,120);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,8);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case VEGETA0:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,5);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 100)
		{
		  SetPlayerMoney(playerid,100);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Alreadyo.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,5);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case VEGETA1:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,5);
          CreateExplosion(X,Y,Z+6,11,1);
          return 1;
        }
        if(Ki >= 105)
		{
		  SetPlayerMoney(playerid,105);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,6);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case VEGETAS:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,6);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 105)
		{
		  SetPlayerMoney(playerid,105);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,6);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case VEGETA2:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,7);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 110)
		{
		  SetPlayerMoney(playerid,110);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,7);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case TRUNKS0:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,5);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 100)
		{
		  SetPlayerMoney(playerid,100);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,5);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case TRUNKS1:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,6);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 105)
		{
		  SetPlayerMoney(playerid,105);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,6);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case TRUNKSS:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,5);
          CreateExplosion(X,Y,Z+6,11,1);
          return 1;
        }
        if(Ki >= 105)
		{
		  SetPlayerMoney(playerid,105);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,6);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case GOHAN0:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,5);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 100)
		{
		  SetPlayerMoney(playerid,100);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,5);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case GOHAN1:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,5);
          CreateExplosion(X,Y,Z+6,11,1);
          return 1;
        }
        if(Ki >= 105)
		{
		  SetPlayerMoney(playerid,105);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,6);
        CreateExplosion(X,Y,Z+5,11,1);
  	  }
	  case GOHAN2:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,7);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 115)
		{
		  SetPlayerMoney(playerid,115);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,7);
        CreateExplosion(X,Y,Z+5,11,1);
  	  }
	  case VEGEKU0:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,8);
          CreateExplosion(X,Y,Z+8,11,1);
          return 1;
        }
        if(Ki >= 125)
		{
		  SetPlayerMoney(playerid,125);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,8);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case VEGEKU1:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,10);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 150)
		{
		  SetPlayerMoney(playerid,150);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,10);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case GOGETA:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,10);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 150)
		{
		  SetPlayerMoney(playerid,150);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,10);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case SATAN:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,3);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 75)
		{
		  SetPlayerMoney(playerid,75);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,3);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case VIDEL:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,4);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 90)
		{
		  SetPlayerMoney(playerid,90);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,4);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case CRILIN:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,5);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 100)
		{
		  SetPlayerMoney(playerid,100);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,5);
        CreateExplosion(X,Y,Z+5,11,1);
 	  }
	  case YAMCHA:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,5);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 100)
		{
		  SetPlayerMoney(playerid,100);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,5);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
 	  case TENSHINSHAN:
	  {
	    if(KiGiocatore > 50)
		{
		  if(Ki >= KiGiocatore)
		  {
		    SetPlayerMoney(playerid,KiGiocatore);
		    return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
          }
          ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
          GivePlayerMoney(playerid,5);
          CreateExplosion(X,Y,Z+5,11,1);
          return 1;
        }
        if(Ki >= 100)
		{
		  SetPlayerMoney(playerid,100);
	      return GameTextForPlayer(playerid,"~r~Your Ki Indicator is Full Already.",1000,5);
		}
        ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",4.1,0,1,1,1,1);
        GivePlayerMoney(playerid,5);
        CreateExplosion(X,Y,Z+5,11,1);
	  }
	  case GELO:
	  {
        GameTextForPlayer(playerid,"~r~I Androids have no Ki!",1000,5);
	  }
	  case Andriod16:
	  {
        GameTextForPlayer(playerid,"~r~I Androids have no Ki!",1000,5);
	  }
  	  case Andriod17:
  	  {
        GameTextForPlayer(playerid,"~r~I Androids have no Ki!",1000,5);
	  }
	  case Andriod18:
	  {
	    GameTextForPlayer(playerid,"~r~I Androids have no Ki!",1000,5);
	  }
	  case Andriod19:
	  {
	    GameTextForPlayer(playerid,"~r~I Androids have no Ki!",1000,5);
	  }
    }
    return 1;
}

//-=-=-=-=-=Unfreeze=-=-=-=-=-

public Unfreeze(playerid)
{
  TogglePlayerControllable(playerid,true);
}

//=-=-=-=-=-==-=-=-=-=-==-=-=-=-=-=FUNCTIONS=-=-=-=-=-==-=-=-=-=-==-=-=-=-=-=

//-=-=-=-=-=AddPlayerScore=-=-=-=-=-

stock AddPlayerScore(playerid, score)
{
  new current = GetPlayerScore(playerid);
  SetPlayerScore(playerid,current+score);
  return 1;
}

//-=-=-=-=-=SetPlayerMoney=-=-=-=-=-

stock SetPlayerMoney(playerid, money)
{
  ResetPlayerMoney(playerid);
  GivePlayerMoney(playerid,money);
  return 1;
}

//-=-=-=-=-=GivePlayerHealth=-=-=-=-=-

stock GivePlayerHealth(playerid, Float:health)
{
  SetPlayerHealth(playerid,GetPlayerHealth(playerid)+health);
  return 1;
}

//-=-=-=-=-=GivePlayerArmour=-=-=-=-=-

stock GivePlayerArmour(playerid, Float:armour)
{
  SetPlayerArmour(playerid,GetPlayerHealth(playerid)+armour);
  return 1;
}

//-=-=-=-=-=Kill=-=-=-=-=-

stock Kill(playerid)
{
  SetPlayerHealth(playerid,1);
  return 1;
}

//=-=-=-=-=-=-=SendMessageToAdmins=-=-=-=-=-=-=-

stock SendMessageToAdmins(color,const string[])
{
	for(new i = 0; i <= MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			if (AdminLevel[i] != GIOCATORE)
			{
				SendClientMessage(i, color, string);
			}
		}
	}
	return 1;
}

//=-=-=-=-=-=-=FrasePulita=-=-=-=-=-=-=-

stock FrasePulita(playerid,text[])        
{
		new string[256];
		new name[MAX_PLAYER_NAME];
		GetPlayerName(playerid,name,sizeof(name));
		/*for(new i=0;i<sizeof(Banned_Words);i++)
		{
			if (strfind(text,Banned_Words[i],true) != null)
			{
				if(playerid != INVALID_PLAYER_ID)
				{
	              PlaySound(playerid, SOUND_ROULETTE_NO_CASH);
                  SendClientMessage(playerid,COLOR_RED,"ANTI-INNOLTI: Sei stato mutato per aver usato una parola scorretta.");
 	  		  	  format(string,sizeof(string),"-SSB- %s � stato mutato dal server per 'Uso di linguaggio inappropriato'.",name);
 			      SendClientMessageToAll(COLOR_RED,string);
    	  		  SendClientMessage(playerid,COLOR_RED,"Regola n�3: Non si possono offendere gli altri giocatori con inNOlti. Pena: Mute.");
    	  		  muted[playerid] = true;
  				  return 0;
				}
			  return 0;
			}

		}*/
   		if (strfind(text,":77",true) != null || strfind(text,"w.",true) != null || strfind(text,"http://",true) != null || strfind(text,".it",true) != null || strfind(text,".com",true) != null || strfind(text,".bet",true) != null)
		{
			if(playerid != INVALID_PLAYER_ID)
			{
				SendClientMessage(playerid,COLOR_RED,"ANTI-SPAM:You've been Fined for trying to spam.");
				PlaySound(playerid, SOUND_ROULETTE_NO_CASH);
 			    format(string,sizeof(string),"-SSB- %s has been changed by the server to 'Unsolicited advertising'.",name);
		  		SendClientMessageToAll(COLOR_RED,string);
    	  		SendClientMessage(playerid,COLOR_RED,"Rule # 4: You can not do unsolicited advertising within the server. Penalty: Mute.");
    	  		muted[playerid] = true;
			}
			return 0;
		}
 	return 1;
}


//=-=-=-=-=-=-=ShowAttackName=-=-=-=-=-=-=-

stock ShowAttackName(playerid, attackname[])
{
  for(new i=0;i<MAX_PLAYERS;i++)
  {
	if(IsPlayerNearPlayer(75,playerid,i)) GameTextForPlayer(i,attackname,2000,1);
  }
  return 1;
}

//=-=-=-=-=-=-=IsPlayerAnAndroid=-=-=-=-=-=-=-

stock IsPlayerAnAndroid(playerid)
{
  new team = GetPlayerTeam(playerid);
  if(team == 9 || team == 10 || team == 11 || team == 12 || team == 13) return 1;
  return 0;
}

stock ApplyAnimationEx(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time)
{
  ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, true);
  return 1;
}

//=-=-=-=-=-=-=PlaySound=-=-=-=-=-=-=-

stock PlaySound(playerid, sound)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	PlayerPlaySound(playerid, sound, X, Y, Z);
	return sound;
}

//=-=-=-=-=-=-= INCLUDES =-=-=-=-=-=-=-

stock strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
	  index++;
	}

	new offset = index;
	new reNOlt[MAX_PLAYER_NAME];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(reNOlt) - 1)))
	{
	  reNOlt[index - offset] = string[index];
	  index++;
	}
	reNOlt[index - offset] = EOS;
	return reNOlt;
}

stock IsPointNearPoint(Float:radi, Float:oldposx, Float:oldposy, Float:oldposz, Float:x, Float:y, Float:z)
{
	new Float:tempposx, Float:tempposy, Float:tempposz;
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))	return 1;
	return 0;
}

stock IsPlayerNearPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:px,Float:py,Float:pz;
	GetPlayerPos(playerid,px,py,pz);
	if(IsPointNearPoint(radi,px,py,pz, x, y, z))	return 1;
	return 0;
}

stock IsPlayerNearPlayer(Float:radi,playerid1, playerid2)
{
	new Float:px,Float:py,Float:pz;
	new Float:kx,Float:ky,Float:kz;
	GetPlayerPos(playerid1, px, py, pz);
	GetPlayerPos(playerid2, kx, ky, kz);
	if(IsPointNearPoint(radi,px, py, pz, kx, ky, kz)) 	return 1;
	return 0;
}

stock IsPlayerNearVehicle(Float:radi,playerid, vehicleid)
{
	new Float:px,Float:py,Float:pz;
	new Float:kx,Float:ky,Float:kz;
	GetPlayerPos(playerid, px, py, pz);
	GetVehiclePos(vehicleid, kx, ky, kz);
	if(IsPointNearPoint(radi,px, py, pz, kx, ky, kz)) 	return 1;
	return 0;
}

stock IsPlayerNearObject(Float:radi,playerid, objectid)
{
	new Float:px,Float:py,Float:pz;
	new Float:kx,Float:ky,Float:kz;
	GetPlayerPos(playerid, px, py, pz);
	GetObjectPos(objectid, kx, ky, kz);
	if(IsPointNearPoint(radi,px, py, pz, kx, ky, kz)) 	return 1;
	return 0;
}

stock CreateExplosionEx(playerid, Float:Distance, type, Float:Radius)
{
  new Float:X,Float:Y,Float:Z,Float:x2,Float:y2,Float:ang;
  GetPlayerPos(playerid,X,Y,Z);
  GetPlayerFacingAngle(playerid, ang);
  x2 = X + (Distance * floatsin(-ang, degrees));
  y2 = Y + (Distance * floatcos(-ang, degrees));
  CreateExplosion(x2,y2,Z,type,Radius);
  return 1;
}



new Float:iPlayerHealth[MAX_PLAYERS];
new Float:iNewPlayerHealth[MAX_PLAYERS];
new Float:iPlayerArmour[MAX_PLAYERS];
new Float:iNewPlayerArmour[MAX_PLAYERS];
new iPlayerMoney[MAX_PLAYERS];
new iNewPlayerMoney[MAX_PLAYERS];
forward OnPlayerHealthChange(playerid, Float:newhealth, Float:oldhealth);
forward OnPlayerArmourChange(playerid, Float:newarmour, Float:oldarmour);
forward OnPlayerMoneyChange(playerid, newmoney, oldmoney);
forward OnPlayerAmmoChange(playerid, newammo, oldammo);
forward OnPlayerVirtualWorldChange(playerid, newvirtualworld, oldvirtualworld);
forward OnPlayerScoreChange(playerid, newscore, oldscore);
forward OnPlayerTeamChange(playerid, newteam, oldteam);
forward OnPlayerSkinChange(playerid, newskin, oldskin);
forward OnPlayerWantedLevelChange(playerid, newwantedlevel, oldwantedlevel);
forward OnPlayerWeaponChange(playerid, newweapon, oldweapon);

stock W_OnPlayerUpdate(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		GetPlayerHealth(playerid, iNewPlayerHealth[playerid]);
		if(iNewPlayerHealth[playerid] != iPlayerHealth[playerid])
		{
		    OnPlayerHealthChange(playerid, iNewPlayerHealth[playerid], iPlayerHealth[playerid]);
		    iPlayerHealth[playerid] = iNewPlayerHealth[playerid];
		}
		GetPlayerArmour(playerid, iNewPlayerArmour[playerid]);
		if(iNewPlayerArmour[playerid] != iPlayerArmour[playerid])
		{
		    OnPlayerArmourChange(playerid, iNewPlayerArmour[playerid], iPlayerArmour[playerid]);
		    iPlayerArmour[playerid] = iNewPlayerArmour[playerid];
		}
		iNewPlayerMoney[playerid] = GetPlayerMoney(playerid);
		if(iNewPlayerMoney[playerid] != iPlayerMoney[playerid])
		{
		    OnPlayerMoneyChange(playerid, iNewPlayerMoney[playerid], iPlayerMoney[playerid]);
		    iPlayerMoney[playerid] = iNewPlayerMoney[playerid];
		}
	}
	return 1;
}
CMD:fly(playerid)
{
    new skin = GetPlayerSkin(playerid);
    if(skin == VIDEL)
	{
		if(FLY_ON[playerid] == 0)
 		{
		 	videlStartFly(playerid);
		 	FLY_ON[playerid] =1;
 		}
 		else
 		{
		 	videlStopFly(playerid);
		 	FLY_ON[playerid] =0;
 		}
 	}
 	else
 	{
 		if(FLY_ON[playerid] == 0)
 		{
		 	StartFly(playerid);
		 	FLY_ON[playerid] =1;
 		}
 		else
 		{
		 	StopFly(playerid);
		 	FLY_ON[playerid] =0;
 		}
	}
 	return 1;
}
CMD:wish(playerid)
{
    if(GetPlayerInterior(playerid) == 6) return SendClientMessage(playerid, COLOR_RED,"You can't use commands in admin jail!");
    if(GetPlayerInterior(playerid) == 6) return SendClientMessage(playerid,COLOR_RED,"Shenron Needs A huge Place To Be Awakened We can't hold that much cost of breaking Buildings!");
    if(pInfo[playerid][ball1] == 1 && pInfo[playerid][ball2] == 1 &&
    pInfo[playerid][ball3] == 1 && pInfo[playerid][ball4] == 1 &&
    pInfo[playerid][ball5] == 1 && pInfo[playerid][ball6] == 1 &&
    pInfo[playerid][ball7] == 1)
    {
	  SendClientMessage(playerid,COLOR_RED,"YOU FOUND ALL THE 7 DRAGON BALLS!!!");
	  SendPlayerMessageToAll(playerid,"I Founded the all the 7 DragonBalls!");
	  ShowPlayerDialog(playerid, DIALOG_SHENRON, DIALOG_STYLE_LIST, "Shenron: I'll grant only one wish!", "Sword for Trunks\nKnife for Videl\nRocket Launcher for Andriod16", "Select", "");
	  pInfo[playerid][ball1] = 0;
	  pInfo[playerid][ball2] = 0;
	  pInfo[playerid][ball3] = 0;
	  pInfo[playerid][ball4] = 0;
	  pInfo[playerid][ball5] = 0;
	  pInfo[playerid][ball6] = 0;
	  pInfo[playerid][ball7] = 0;
	  pInfo[playerid][DragonRadar] = 0;
	  return 1;
    }
	return SendClientMessage(playerid,COLOR_RED,"You didn't found the 7 dragonballs yet!");
}
CMD:help(playerid)
{
    SendClientMessage(playerid,COLOR_WHITE,   "____________________________________________________HELP____________________________________________________");
    SendClientMessage(playerid,COLOR_YELLOW,  "    Welcome to Dragonball Z Death Match 4.0z by Sasino97.");
    SendClientMessage(playerid,COLOR_BLUE,    "COLORS: Use /colors to see a list of player colors. /colors2 to see a list of attack colors.");
    SendClientMessage(playerid,COLOR_YELLOW,  "TRANSFORMATION: Some players can transform to SUPER Saiyan! Use /tra to transform!");
    SendClientMessage(playerid,COLOR_BLUE,    "FUSION: Goku and Vegeta can use /fus to transform respectively to Gogeta and Vegeku!");
    SendClientMessage(playerid,COLOR_YELLOW,  "ATTACK: All the characters can use /att to create a special attack!");
    SendClientMessage(playerid,COLOR_BLUE,    "ABSORBING KI: Dr.Gelo and Andriod19 can use /absorb to absorb the ki of the closest player!");
    SendClientMessage(playerid,COLOR_YELLOW,  "RIGENERATION: All the characters can use /rig to Regenerate a bit of their health.");
    SendClientMessage(playerid,COLOR_RED,     "Type /help2 to go to the next page.");
    SendClientMessage(playerid,COLOR_WHITE,   "____________________________________________________________________________________________________________");
    PlaySound(playerid, SOUND_CAMERA_SHOT);
    return 1;
}
CMD:help2(playerid)
{
    SendClientMessage(playerid,COLOR_WHITE,  "________________________________________________HELP_2________________________________________________");
    SendClientMessage(playerid,COLOR_BLUE,   "LITTLE KI STROKES: All characters can shoot little ki strokes by pressing the Walk Key(Default ALT).");
    SendClientMessage(playerid,COLOR_YELLOW, "CHARGING KI: All characters(except Andriods) can charge their ki by pressing NObmission Key(Default MMB).");
    SendClientMessage(playerid,COLOR_BLUE,   "RISING UP: All characters can rise up to the sky by pressing the Jump Key(Default JUMP).");
    SendClientMessage(playerid,COLOR_YELLOW, "GETTING GUNOUT: All characters can go GUNOUT by pressing the Crouch Key(Default C).");
    SendClientMessage(playerid,COLOR_BLUE,   "CHECKING POWER: Use /power to check the BASIC power stats of your character.");
    SendClientMessage(playerid,COLOR_YELLOW, "FAST MOVING: All characters can move faster by pressing the Sprint Key(Default SPRINT BAR).");
    SendClientMessage(playerid,COLOR_YELLOW, "SLOW MOVING: To move slow, keep pressed click + one of the motion cmds (SPRINTBAR, JUMP, C).");
    SendClientMessage(playerid,COLOR_BLUE,   "SELF DESTRUCT: All characters can self destruct by the command /kill.");
    SendClientMessage(playerid,COLOR_RED,     "Type /help3 to go to the next page.");
    SendClientMessage(playerid,COLOR_WHITE,  "______________________________________________________________________________________________________");
    PlaySound(playerid, SOUND_CAMERA_SHOT);
    return 1;
}
CMD:help3(playerid)
{
    SendClientMessage(playerid,COLOR_WHITE, "_________________________________________________HELP_3_________________________________________________");
    SendClientMessage(playerid,COLOR_YELLOW,"ROTATION: The Secondary Attack Key(Default ENTER) will rotate the character of 45�.");
    SendClientMessage(playerid,COLOR_BLUE,  "CUSTOMIZATION: To customize your character go to the living room and pick up the save disk pickup.");
    SendClientMessage(playerid,COLOR_YELLOW,"To use this function you must have some DP(Dragon Points). You earn DP by beating other players.");
    SendClientMessage(playerid,COLOR_BLUE,  "GAMBLING: You can bet on a player by going in the living room and picking up the save disk pickup.");
    SendClientMessage(playerid,COLOR_YELLOW,"REPORT: You can report rulebreakers to admins by using /report [playerid][reason].");
    SendClientMessage(playerid,COLOR_BLUE,  "NO MODERATORS?: If you want to check for admins use /admins. If they aren't in the server use");
    SendClientMessage(playerid,COLOR_YELLOW,"/votekick, all players will recive a message to vote for him. 3 votes = kick.");
    SendClientMessage(playerid,COLOR_WHITE, "________________________________________________________________________________________________________");
    PlaySound(playerid, SOUND_CAMERA_SHOT);
    return 1;
}
CMD:colors(playerid)
{
    SendClientMessage(playerid,COLOR_BLACK,    "_________________PLAYER_COLORS_______________");
    SendClientMessage(playerid,COLOR_LIGHTBLUE,"Lightblue: Cyborg.");
    SendClientMessage(playerid,COLOR_PINK,     "Pink: Weak Warrior.");
    SendClientMessage(playerid,COLOR_WHITE,    "White: Normal Warrior.");
    SendClientMessage(playerid,COLOR_YELLOW,   "Yellow: Transformed 1 Time.");
    SendClientMessage(playerid,COLOR_ORANGE,   "Orange: Transformed 2 Times.");
    SendClientMessage(playerid,COLOR_RED,      "Red: Transformed 3 Times.");
    SendClientMessage(playerid,COLOR_GREEN,    "Green: Fusion.");
    SendClientMessage(playerid,COLOR_BLUE,     "Blue: Fusion and SUPER Saiyan.");
    SendClientMessage(playerid,COLOR_WHITE,    "Type /colors2 to go to the next page.");
    SendClientMessage(playerid,COLOR_BLACK,    "_____________________________________________");
    PlaySound(playerid, SOUND_CAMERA_SHOT);
    return 1;
}
CMD:colors2(playerid)
{
    SendClientMessage(playerid,COLOR_BLACK,    "__________ATTACK_COLORS__________");
    SendClientMessage(playerid,COLOR_WHITE,    "White: Power of 10.000.");
    SendClientMessage(playerid,COLOR_YELLOW,   "Yellow: Power of 20.000.");
    SendClientMessage(playerid,COLOR_PINK,     "Pink: Power of 50.000.");
    SendClientMessage(playerid,COLOR_RED,      "Red: Power of 100.000.");
    SendClientMessage(playerid,COLOR_GREEN,    "Green: Power of 500.000.");
    SendClientMessage(playerid,COLOR_BLUE,     "Blue: Power of 1.000.000.");
    SendClientMessage(playerid,COLOR_BLACK,    "_________________________________");
    PlaySound(playerid, SOUND_CAMERA_SHOT);
    return 1;
}
CMD:power(playerid)
{
    new skin = GetPlayerSkin(playerid);
    PlaySound(playerid, SOUND_PROPERTY_PURCHASED);
    SendClientMessage(playerid, COLOR_RED, "This is the BASIC power of the character.");
	if(skin == GOKU0)
	{
      SendClientMessage(playerid,COLOR_WHITE, "_____________________GOKU______________________");
      SendClientMessage(playerid,COLOR_WHITE, "Attack: Kamehameha.");
      SendClientMessage(playerid,COLOR_WHITE, "Maximum amount of ki: 100.");
      SendClientMessage(playerid,COLOR_WHITE, "Ki charging speed: 5 ki units per press.");
      SendClientMessage(playerid,COLOR_WHITE, "Rigenerating speed: 2 HP per press.");
      SendClientMessage(playerid,COLOR_WHITE, "Amount of ki needed for self-destruct: 50 units.");
      SendClientMessage(playerid,COLOR_WHITE, "Flying speed: 5 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "_______________________________________________");
      return 1;
    }
	if(skin == GOKU1)
	{
      SendClientMessage(playerid,COLOR_WHITE, "_____________________GOKU_SUPER_SAIYAN_____________________");
      SendClientMessage(playerid,COLOR_YELLOW, "Attack: Furious Kamehameha.");
      SendClientMessage(playerid,COLOR_YELLOW, "Maximum amount of ki: 105.");
      SendClientMessage(playerid,COLOR_YELLOW, "Ki charging speed: 6 ki units per press.");
      SendClientMessage(playerid,COLOR_YELLOW, "Rigenerating speed: 4 HP per press.");
      SendClientMessage(playerid,COLOR_YELLOW, "Amount of ki needed for self-destruct: 60 units.");
      SendClientMessage(playerid,COLOR_YELLOW, "Flying speed: 6 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "___________________________________________________________");
      return 1;
    }
	if(skin == GOKU2)
	{
      SendClientMessage(playerid,COLOR_WHITE, "_____________________GOKU_SUPER_SAIYAN_2_____________________");
      SendClientMessage(playerid,COLOR_ORANGE, "Attack: SUPER Kamehameha.");
      SendClientMessage(playerid,COLOR_ORANGE, "Maximum amount of ki: 110.");
      SendClientMessage(playerid,COLOR_ORANGE, "Ki charging speed: 7 ki units per press.");
      SendClientMessage(playerid,COLOR_ORANGE, "Rigenerating speed: 6 HP per press.");
      SendClientMessage(playerid,COLOR_ORANGE, "Amount of ki needed for self-destruct: 80 units.");
      SendClientMessage(playerid,COLOR_ORANGE, "Flying speed: 8 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "_____________________________________________________________");
      return 1;
    }
	if(skin == GOKU3)
	{
      SendClientMessage(playerid,COLOR_WHITE, "_____________________GOKU_SUPER_SAIYAN_3_____________________");
      SendClientMessage(playerid,COLOR_RED, "Attack: Maximum Intensity Kamehameha.");
      SendClientMessage(playerid,COLOR_RED, "Maximum amount of ki: 120.");
      SendClientMessage(playerid,COLOR_RED, "Ki charging speed: 8 ki units per press.");
      SendClientMessage(playerid,COLOR_RED, "Rigenerating speed: 8 HP per press.");
      SendClientMessage(playerid,COLOR_RED, "Amount of ki needed for self-destruct: 90 units.");
      SendClientMessage(playerid,COLOR_RED, "Flying speed: 10 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "_____________________________________________________________");
      return 1;
    }
	if(skin == VEGETA0)
	{
      SendClientMessage(playerid,COLOR_WHITE, "_____________________VEGETA______________________");
      SendClientMessage(playerid,COLOR_WHITE, "Attack: Explosive Cannon.");
      SendClientMessage(playerid,COLOR_WHITE, "Maximum amount of ki: 100.");
      SendClientMessage(playerid,COLOR_WHITE, "Ki charging speed: 5 ki units per press.");
      SendClientMessage(playerid,COLOR_WHITE, "Rigenerating speed: 2 HP per press.");
      SendClientMessage(playerid,COLOR_WHITE, "Amount of ki needed for self-destruct: 50 units.");
      SendClientMessage(playerid,COLOR_WHITE, "Flying speed: 5 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "_________________________________________________");
      return 1;
    }
	if(skin == VEGETA1)
	{
      SendClientMessage(playerid,COLOR_WHITE, "_____________________VEGETA_SUPER_SAIYAN_____________________");
      SendClientMessage(playerid,COLOR_YELLOW, "Attack: Big Bang Attack.");
      SendClientMessage(playerid,COLOR_YELLOW, "Maximum amount of ki: 105.");
      SendClientMessage(playerid,COLOR_YELLOW, "Ki charging speed: 6 ki units per press.");
      SendClientMessage(playerid,COLOR_YELLOW, "Rigenerating speed: 4 HP per press.");
      SendClientMessage(playerid,COLOR_YELLOW, "Amount of ki needed for self-destruct: 60 units.");
      SendClientMessage(playerid,COLOR_YELLOW, "Flying speed: 6 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "_____________________________________________________________");
      return 1;
    }
	if(skin == VEGETAS)
	{
      SendClientMessage(playerid,COLOR_WHITE, "_____________________SUPER_VEGETA_____________________");
      SendClientMessage(playerid,COLOR_ORANGE, "Attack: Final Flash.");
      SendClientMessage(playerid,COLOR_ORANGE, "Maximum amount of ki: 105.");
      SendClientMessage(playerid,COLOR_ORANGE, "Ki charging speed: 6 ki units per press.");
      SendClientMessage(playerid,COLOR_ORANGE, "Rigenerating speed: 4 HP per press.");
      SendClientMessage(playerid,COLOR_ORANGE, "Amount of ki needed for self-destruct: 60 units.");
      SendClientMessage(playerid,COLOR_ORANGE, "Flying speed: 7 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "______________________________________________________");
      return 1;
    }
	if(skin == VEGETA2)
	{
      SendClientMessage(playerid,COLOR_WHITE, "_____________________VEGETA_SUPER_SAIYAN_2_____________________");
      SendClientMessage(playerid,COLOR_RED, "Attack: Final Flash.");
      SendClientMessage(playerid,COLOR_RED, "Maximum amount of ki: 110.");
      SendClientMessage(playerid,COLOR_RED, "Ki charging speed: 7 ki units per press.");
      SendClientMessage(playerid,COLOR_RED, "Rigenerating speed: 6 HP per press.");
      SendClientMessage(playerid,COLOR_RED, "Amount of ki needed for self-destruct: 80 units.");
      SendClientMessage(playerid,COLOR_RED, "Flying speed: 8 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "_______________________________________________________________");
      return 1;
    }
	if(skin == TRUNKS0)
	{
      SendClientMessage(playerid,COLOR_WHITE, "_____________________TRUNKS______________________");
      SendClientMessage(playerid,COLOR_WHITE, "Attack: Masenko.");
      SendClientMessage(playerid,COLOR_WHITE, "Maximum amount of ki: 100.");
      SendClientMessage(playerid,COLOR_WHITE, "Ki charging speed: 5 ki units per press.");
      SendClientMessage(playerid,COLOR_WHITE, "Rigenerating speed: 2 HP per press.");
      SendClientMessage(playerid,COLOR_WHITE, "Amount of ki needed for self-destruct: 50 units.");
      SendClientMessage(playerid,COLOR_WHITE, "Flying speed: 5 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "_________________________________________________");
      return 1;
    }
	if(skin == TRUNKS1)
	{
      SendClientMessage(playerid,COLOR_WHITE, "_____________________TRUNKS_SUPER_SAIYAN_____________________");
      SendClientMessage(playerid,COLOR_YELLOW, "Attack: Burning Attack.");
      SendClientMessage(playerid,COLOR_YELLOW, "Maximum amount of ki: 105.");
      SendClientMessage(playerid,COLOR_YELLOW, "Ki charging speed: 6 ki units per press.");
      SendClientMessage(playerid,COLOR_YELLOW, "Rigenerating speed: 4 HP per press.");
      SendClientMessage(playerid,COLOR_YELLOW, "Amount of ki needed for self-destruct: 60 units.");
      SendClientMessage(playerid,COLOR_YELLOW, "Flying speed: 6 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "_____________________________________________________________");
      return 1;
    }
	if(skin == TRUNKSS)
	{
      SendClientMessage(playerid,COLOR_WHITE, "_____________________SUPER_TRUNKS_____________________");
      SendClientMessage(playerid,COLOR_ORANGE, "Attack: Finish Buster.");
      SendClientMessage(playerid,COLOR_ORANGE, "Maximum amount of ki: 105.");
      SendClientMessage(playerid,COLOR_ORANGE, "Ki charging speed: 6 ki units per press.");
      SendClientMessage(playerid,COLOR_ORANGE, "Rigenerating speed: 4 HP per press.");
      SendClientMessage(playerid,COLOR_ORANGE, "Amount of ki needed for self-destruct: 60 units.");
      SendClientMessage(playerid,COLOR_ORANGE, "Flying speed: 7 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "______________________________________________________");
      return 1;
    }
	if(skin == GOHAN0)
	{
      SendClientMessage(playerid,COLOR_WHITE, "_____________________GOHAN______________________");
      SendClientMessage(playerid,COLOR_WHITE, "Attack: SUPER Masenko.");
      SendClientMessage(playerid,COLOR_WHITE, "Maximum amount of ki: 100.");
      SendClientMessage(playerid,COLOR_WHITE, "Ki charging speed: 5 ki units per press.");
      SendClientMessage(playerid,COLOR_WHITE, "Rigenerating speed: 2 HP per press.");
      SendClientMessage(playerid,COLOR_WHITE, "Amount of ki needed for self-destruct: 50 units.");
      SendClientMessage(playerid,COLOR_WHITE, "Flying speed: 5 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "________________________________________________");
      return 1;
    }
	if(skin == GOHAN1)
	{
      SendClientMessage(playerid,COLOR_WHITE, "_____________________GOHAN_SUPER_SAIYAN_____________________");
      SendClientMessage(playerid,COLOR_YELLOW, "Attack: SUPER Kamehameha.");
      SendClientMessage(playerid,COLOR_YELLOW, "Maximum amount of ki: 105.");
      SendClientMessage(playerid,COLOR_YELLOW, "Ki charging speed: 6 ki units per press.");
      SendClientMessage(playerid,COLOR_YELLOW, "Rigenerating speed: 4 HP per press.");
      SendClientMessage(playerid,COLOR_YELLOW, "Amount of ki needed for self-destruct: 60 units.");
      SendClientMessage(playerid,COLOR_YELLOW, "Flying speed: 8 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "____________________________________________________________");
      return 1;
    }
	if(skin == GOHAN2)
	{
      SendClientMessage(playerid,COLOR_WHITE, "_____________________GOHAN_SUPER_SAIYAN_2_____________________");
      SendClientMessage(playerid,COLOR_ORANGE, "Attack: Maximum Intensity Kamehameha.");
      SendClientMessage(playerid,COLOR_ORANGE, "Maximum amount of ki: 115.");
      SendClientMessage(playerid,COLOR_ORANGE, "Ki charging speed: 7 ki units per press.");
      SendClientMessage(playerid,COLOR_ORANGE, "Rigenerating speed: 6 HP per press.");
      SendClientMessage(playerid,COLOR_ORANGE, "Amount of ki needed for self-destruct: 80 units.");
      SendClientMessage(playerid,COLOR_ORANGE, "Flying speed: 10 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "______________________________________________________________");
      return 1;
    }
	if(skin == CRILIN)
	{
      SendClientMessage(playerid,COLOR_WHITE, "_____________________KRILLIN______________________");
      SendClientMessage(playerid,COLOR_WHITE, "Attack: Kamehameha.");
      SendClientMessage(playerid,COLOR_WHITE, "Maximum amount of ki: 100.");
      SendClientMessage(playerid,COLOR_WHITE, "Ki charging speed: 5 ki units per press.");
      SendClientMessage(playerid,COLOR_WHITE, "Rigenerating speed: 2 HP per press.");
      SendClientMessage(playerid,COLOR_WHITE, "Amount of ki needed for self-destruct: 50 units.");
      SendClientMessage(playerid,COLOR_WHITE, "Flying speed: 5 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "__________________________________________________");
      return 1;
    }
	if(skin == YAMCHA)
	{
      SendClientMessage(playerid,COLOR_WHITE, "______________________YAMCHA______________________");
      SendClientMessage(playerid,COLOR_WHITE, "Attack: Wolf Fang Fist.");
      SendClientMessage(playerid,COLOR_WHITE, "Maximum amount of ki: 100.");
      SendClientMessage(playerid,COLOR_WHITE, "Ki charging speed: 5 ki units per press.");
      SendClientMessage(playerid,COLOR_WHITE, "Rigenerating speed: 2 HP per press.");
      SendClientMessage(playerid,COLOR_WHITE, "Amount of ki needed for self-destruct: 50 units.");
      SendClientMessage(playerid,COLOR_WHITE, "Flying speed: 5 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "__________________________________________________");
      return 1;
    }
	if(skin == TENSHINSHAN)
	{
      SendClientMessage(playerid,COLOR_WHITE, "___________________________TIEN__________________________");
      SendClientMessage(playerid,COLOR_WHITE, "Attack: Triple Ray.");
      SendClientMessage(playerid,COLOR_WHITE, "Maximum amount of ki: 100.");
      SendClientMessage(playerid,COLOR_WHITE, "Ki charging speed: 5 ki units per press.");
      SendClientMessage(playerid,COLOR_WHITE, "Rigenerating speed: 2 HP per press.");
      SendClientMessage(playerid,COLOR_WHITE, "Amount of ki needed for self-destruct: 50 units.");
      SendClientMessage(playerid,COLOR_WHITE, "Flying speed: 5 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "_________________________________________________________");
      return 1;
    }
	if(skin == GELO)
	{
      SendClientMessage(playerid,COLOR_WHITE, "______________________DOTTOR_GERO______________________");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Attack: Energy Beam.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Maximum amount of ki: 0.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Ki charging speed: 0 ki units per press.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Rigenerating speed: 1 HP per press.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Amount of ki needed for self-destruct: 0 units.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Flying speed: 6 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "_______________________________________________________");
      return 1;
    }
	if(skin == Andriod19)
	{
      SendClientMessage(playerid,COLOR_WHITE, "______________________CYBORG_N�_19______________________");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Attack: Energy Beam.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Maximum amount of ki: 0.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Ki charging speed: 0 ki units per press.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Rigenerating speed: 1 HP per press.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Amount of ki needed for self-destruct: 0 units.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Flying speed: 6 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "________________________________________________________");
      return 1;
    }
	if(skin == Andriod18)
	{
      SendClientMessage(playerid,COLOR_WHITE, "______________________CYBORG_N�_18______________________");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Attack: Energy Beam.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Maximum amount of ki: 0.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Ki charging speed: 0 ki units per press.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Rigenerating speed: 1 HP per press.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Amount of ki needed for self-destruct: 0 units.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Flying speed: 6 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "________________________________________________________");
      return 1;
	}
	if(skin == Andriod17)
	{
      SendClientMessage(playerid,COLOR_WHITE, "______________________CYBORG_N�_17______________________");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Attack: Energy Sphere.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Maximum amount of ki: 0.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Ki charging speed: 0 ki units per press.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Rigenerating speed: 1 HP per press.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Amount of ki needed for self-destruct: 0 units.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Flying speed: 6 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "________________________________________________________");
      return 1;
    }
	if(skin == Andriod16)
	{
      SendClientMessage(playerid,COLOR_WHITE, "______________________CYBORG_N�_16______________________");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Attack: Incorporated Rocket Launcher.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Maximum amount of ki: 0.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Ki charging speed: 0 ki units per press.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Rigenerating speed: 1 HP per press.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Amount of ki needed for self-destruct: 0 units.");
      SendClientMessage(playerid,COLOR_LIGHTBLUE, "Flying speed: 6 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "________________________________________________________");
      return 1;
    }
	if(skin == SATAN)
	{
      SendClientMessage(playerid,COLOR_WHITE, "_________________________HERCULE________________________");
      SendClientMessage(playerid,COLOR_VIOLET, "Attack: The Champion.");
      SendClientMessage(playerid,COLOR_VIOLET, "Maximum amount of ki: 70.");
      SendClientMessage(playerid,COLOR_VIOLET, "Ki charging speed: 3 ki units per press.");
      SendClientMessage(playerid,COLOR_VIOLET, "Rigenerating speed: 1 HP per press.");
      SendClientMessage(playerid,COLOR_VIOLET, "Amount of ki needed for self-destruct: 20 units.");
      SendClientMessage(playerid,COLOR_VIOLET, "Flying speed: 3 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "________________________________________________________");
      return 1;
    }
	if(skin == VIDEL)
	{
      SendClientMessage(playerid,COLOR_WHITE, "______________________VIDEL______________________");
      SendClientMessage(playerid,COLOR_VIOLET, "Attack: Great Ki Bomb.");
      SendClientMessage(playerid,COLOR_VIOLET, "Maximum amount of ki: 90.");
      SendClientMessage(playerid,COLOR_VIOLET, "Ki charging speed: 4 ki units per press.");
      SendClientMessage(playerid,COLOR_VIOLET, "Rigenerating speed: 1 HP per press.");
      SendClientMessage(playerid,COLOR_VIOLET, "Amount of ki needed for self-destruct: 40 units.");
      SendClientMessage(playerid,COLOR_VIOLET, "Flying speed: 4 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "_________________________________________________");
      return 1;
    }
	if(skin == VEGEKU0)
	{
      SendClientMessage(playerid,COLOR_WHITE, "______________________VEGEKU______________________");
      SendClientMessage(playerid,COLOR_GREEN, "Attack: Final Flash.");
      SendClientMessage(playerid,COLOR_GREEN, "Maximum amount of ki: 125.");
      SendClientMessage(playerid,COLOR_GREEN, "Ki charging speed: 8 ki units per press.");
      SendClientMessage(playerid,COLOR_GREEN, "Rigenerating speed: 8 HP per press.");
      SendClientMessage(playerid,COLOR_GREEN, "Amount of ki needed for self-destruct: 90 units.");
      SendClientMessage(playerid,COLOR_GREEN, "Flying speed: 10 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "__________________________________________________");
      return 1;
    }
	if(skin == VEGEKU1)
	{
      SendClientMessage(playerid,COLOR_WHITE, "______________________SUPER_VEGEKU______________________");
      SendClientMessage(playerid,COLOR_BLUE, "Attack: Final Kamehameha.");
      SendClientMessage(playerid,COLOR_BLUE, "Maximum amount of ki: 150.");
      SendClientMessage(playerid,COLOR_BLUE, "Ki charging speed: 10 ki units per press.");
      SendClientMessage(playerid,COLOR_BLUE, "Rigenerating speed: 10 HP per press.");
      SendClientMessage(playerid,COLOR_BLUE, "Amount of ki needed for self-destruct: 100 units.");
      SendClientMessage(playerid,COLOR_BLUE, "Flying speed: 15 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "________________________________________________________");
      return 1;
    }
	if(skin == GOGETA)
	{
      SendClientMessage(playerid,COLOR_WHITE, "______________________SUPER_GOGETA______________________");
      SendClientMessage(playerid,COLOR_BLUE, "Attack: Big Bang Kamehameha.");
      SendClientMessage(playerid,COLOR_BLUE, "Maximum amount of ki: 150.");
      SendClientMessage(playerid,COLOR_BLUE, "Ki charging speed: 10 ki units per press.");
      SendClientMessage(playerid,COLOR_BLUE, "Rigenerating speed: 10 HP per press.");
      SendClientMessage(playerid,COLOR_BLUE, "Amount of ki needed for self-destruct: 100 units.");
      SendClientMessage(playerid,COLOR_BLUE, "Flying speed: 15 meters per press.");
      SendClientMessage(playerid,COLOR_WHITE, "________________________________________________________");
      return 1;
    }
    PlaySound(playerid, SOUND_AMMUNATION_BUY_WEAPON_DENIED);
    return SendClientMessage(playerid,COLOR_YELLOW,"ERROR: Invalid Skin!");
}
CMD:kill(playerid)
{
  new string[256];
  new skin = GetPlayerSkin(playerid);
  new name[MAX_PLAYER_NAME];
  new Float:X, Float:Y, Float:Z;
  new Ki = GetPlayerMoney(playerid);
  GetPlayerPos(playerid,X,Y,Z);
  GetPlayerName(playerid,name,sizeof(name));
  PlaySound(playerid, SOUND_RACE_GO);
    if(skin == GOKU0 || skin == VEGETA0 || skin == TRUNKS0 || skin == GOHAN0 || skin == CRILIN || skin == TENSHINSHAN || skin == YAMCHA)
    {
      if(Ki < 50) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
	  GivePlayerMoney(playerid,-50);
      CreateExplosion(X,Y,Z,7,50);
      CreateExplosion(X+10,Y,Z,7,50);
      CreateExplosion(X-10,Y,Z,7,50);
      CreateExplosion(X,Y+10,Z,7,50);
      CreateExplosion(X,Y-10,Z,7,50);
      CreateExplosion(X,Y,Z+10,7,50);
      CreateExplosion(X,Y,Z+20,7,50);
      CreateExplosion(X,Y,Z+30,7,50);
      Kill(playerid);
      format(string,sizeof(string),"Yaaaaaaaaa!");
      SendPlayerMessageToAll(playerid,string);
      return 1;
    }
    else if(skin == GOKU1 || skin == VEGETA1 || skin == TRUNKS1 || skin == GOHAN1 || skin == VEGETAS || skin == TRUNKSS)
    {
    if(Ki < 60) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      GivePlayerMoney(playerid,-60);
      CreateExplosion(X,Y+2,Z,7,60);
      CreateExplosion(X,Y,Z+10,7,50);
      CreateExplosion(X,Y,Z+20,7,50);
      CreateExplosion(X,Y,Z+30,7,50);
      Kill(playerid);
      format(string,sizeof(string),"Eeeeaaaaah!");
      SendPlayerMessageToAll(playerid,string);
      return 1;
    }
    else if(IsPlayerAnAndroid(playerid))
    {
      CreateExplosion(X,Y,Z,7,80);
      CreateExplosion(X,Y,Z+10,7,50);
      CreateExplosion(X,Y,Z+20,7,50);
      CreateExplosion(X,Y,Z+30,7,50);
      Kill(playerid);
      format(string,sizeof(string),"Self-Destruct in 0 seconds!");
      SendPlayerMessageToAll(playerid,string);
      return 1;
    }
    else if(skin == GOKU2 || skin == GOHAN2)
    {
	  if(Ki < 80) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      GivePlayerMoney(playerid,-80);
      CreateExplosion(X,Y,Z,7,80);
      CreateExplosion(X,Y,Z+10,7,50);
      CreateExplosion(X,Y,Z+20,7,50);
      CreateExplosion(X,Y,Z+30,7,50);
      Kill(playerid);
      format(string,sizeof(string),"Eaaaaah!");
      SendPlayerMessageToAll(playerid,string);
	  return 1;
    }
    else if(skin == VEGETA2)
    {
  	  if(Ki < 80) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      GivePlayerMoney(playerid,-80);
      CreateExplosion(X,Y,Z,7,80);
      CreateExplosion(X,Y,Z+10,7,50);
      CreateExplosion(X,Y,Z+20,7,50);
      CreateExplosion(X,Y,Z+30,7,50);
      Kill(playerid);
      format(string,sizeof(string),"Trunks, Bulma, Goku, Goodbye!");
      SendPlayerMessageToAll(playerid,string);
	  return 1;
    }

    else if(skin == GOKU3 || skin == VEGEKU0)
    {
      if(Ki < 90) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      GivePlayerMoney(playerid,-90);
      CreateExplosion(X,Y,Z,7,100);
      CreateExplosion(X,Y,Z+10,7,50);
      CreateExplosion(X,Y,Z+20,7,50);
      CreateExplosion(X,Y,Z+30,7,50);
      Kill(playerid);
      format(string,sizeof(string),"Goodbye!!!");
      SendPlayerMessageToAll(playerid,string);
      return 1;
    }
    else if(skin == SATAN)
    {
      if(Ki < 20) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
   	  GivePlayerMoney(playerid,-20);
      CreateExplosion(X,Y,Z,11,10);
      Kill(playerid);
      format(string,sizeof(string),"Say goodbye to the world's champion!");
      SendPlayerMessageToAll(playerid,string);
      return 1;
    }
    else if(skin == VIDEL)
    {
      if(Ki < 40) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      GivePlayerMoney(playerid,-40);
      CreateExplosion(X,Y,Z,11,30);
      Kill(playerid);
      format(string,sizeof(string),"Aaaaaa!");
      SendPlayerMessageToAll(playerid,string);
      return 1;
    }
    else if(skin == VEGEKU1 || skin == GOGETA)
    {
      if(Ki < 100) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      GivePlayerMoney(playerid,-100);
      CreateExplosion(X,Y,Z,11,120);
      CreateExplosion(X,Y,Z+10,7,60);
      CreateExplosion(X,Y,Z+20,7,80);
      CreateExplosion(X,Y,Z+30,7,100);
      format(string,sizeof(string),"I hope I'll NOrvive!!!");
      SendPlayerMessageToAll(playerid,string);
      return 1;
    }
    PlaySound(playerid, SOUND_AMMUNATION_BUY_WEAPON_DENIED);
    return SendClientMessage(playerid,COLOR_YELLOW,"ERROR: Invalid Skin!");
}
CMD:rig(playerid)
{
  new Float:health;
  new skin = GetPlayerSkin(playerid);
  new Float:X, Float:Y, Float:Z;
  new Ki = GetPlayerMoney(playerid);
  GetPlayerPos(playerid,X,Y,Z);
  GetPlayerHealth(playerid, health);
  if(health > pInfo[playerid][HEALTHMax][skin]) return SendClientMessage(playerid,COLOR_YELLOW,"Your health is full!");
    if(skin == GOKU0 || skin == VEGETA0 || skin == TRUNKS0 || skin == GOHAN0 || skin == CRILIN || skin == YAMCHA || skin == TENSHINSHAN)
    {
      if(Ki < 5) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      SetPlayerHealth(playerid,health+2);
      GivePlayerMoney(playerid,-5);
      ApplyAnimationEx(playerid,"FOOD","EAT_Pizza",4.1,0,1,1,1,1);
      ShowAttackName(playerid,"~w~Health Regenerate");
      return 1;
    }
    else if(skin == GOKU1 || skin == VEGETA1 || skin == TRUNKS1 || skin == GOHAN1 || skin == VEGETAS || skin == TRUNKSS)
    {
      if(Ki < 5) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      SetPlayerHealth(playerid,health+4);
      GivePlayerMoney(playerid,-5);
      ApplyAnimationEx(playerid,"FOOD","EAT_Pizza",4.1,0,1,1,1,1);
      ShowAttackName(playerid,"~w~SSJ Health Regenerate");
      return 1;
    }
    else if(skin == GOKU2 || skin == VEGETA2 || skin == GOHAN2)
    {
      if(Ki < 5) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      SetPlayerHealth(playerid,health+6);
      GivePlayerMoney(playerid,-5);
      ApplyAnimationEx(playerid,"FOOD","EAT_Pizza",4.1,0,1,1,1,1);
      ShowAttackName(playerid,"~w~SSJ2 Health Regenerate");
      return 1;
    }
    else if(skin == GOKU3 || skin == VEGEKU0)
    {
      if(Ki < 5) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      SetPlayerHealth(playerid,health+8);
      GivePlayerMoney(playerid,-5);
      ApplyAnimationEx(playerid,"FOOD","EAT_Pizza",4.1,0,1,1,1,1);
      ShowAttackName(playerid,"~w~SUPER Health Regenerate");
      return 1;
    }
    else if(skin == VEGEKU1 || skin == GOGETA)
    {
      if(Ki < 5) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      SetPlayerHealth(playerid,health+10);
      GivePlayerMoney(playerid,-5);
      ApplyAnimationEx(playerid,"FOOD","EAT_Pizza",4.1,0,1,1,1,1);
      ShowAttackName(playerid,"~w~Max Health Regenerate");
      return 1;
    }
    else if(skin == SATAN || skin == VIDEL)
    {
      if(Ki < 5) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      SetPlayerHealth(playerid,health+1);
      GivePlayerMoney(playerid,-5);
      ApplyAnimationEx(playerid,"FOOD","EAT_Pizza",4.1,0,1,1,1,1);
      ShowAttackName(playerid,"~w~Bread");
	  return 1;
    }
    else if(IsPlayerAnAndroid(playerid))
    {
      SetPlayerHealth(playerid,health+1);
      ShowAttackName(playerid,"~w~Incorporated Rigenerating System");
      return 1;
    }
    PlaySound(playerid, SOUND_AMMUNATION_BUY_WEAPON_DENIED);
    return SendClientMessage(playerid,COLOR_YELLOW,"ERROR: Invalid Skin!");
}
CMD:fusion(playerid)
{
    new team = GetPlayerTeam(playerid);
    new string[256];
    new name[MAX_PLAYER_NAME];
    new Ki = GetPlayerMoney(playerid);
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid,X,Y,Z);
    GetPlayerName(playerid,name,sizeof(name));
    if(team == 0)
	{
	  if(GetPlayerSkin(playerid) == GOGETA) return SendClientMessage(playerid,COLOR_YELLOW,"The fusion expires on your death.");
	  if(GetPlayerSkin(playerid) == VEGEKU0
	  || GetPlayerSkin(playerid) == VEGEKU1) return SendClientMessage(playerid,COLOR_YELLOW,"You can't use the fusion again/You Are Already Fused.");
	  if(Ki < 80) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
	  format(string,sizeof(string),"Fuuuuu....sion.....ha!");
	  SendPlayerMessageToAll(playerid,string);
	  CreateExplosion(X,Y,Z+5,11,3);
	  SetPlayerSkin(playerid,GOGETA);
	  SetPlayerColor(playerid,COLOR_BLUE);
	  GivePlayerMoney(playerid,-80);
	  ApplyAnimationEx(playerid,"DAM_JUMP","Jump_Roll",4.1,0,1,1,1,1);
	  GameTextForPlayer(playerid,"SUPER Gogeta",1000,5);
	  Delete3DTextLabel(Name3DText[playerid]);
      Name3DText[playerid] = Create3DTextLabel("SUPER GOGETA", COLOR_BLUE, X, Y, Z+0.2, 20, 0, 0);
      Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
      PlaySound(playerid, SOUND_RACE_GO);
      ShowAttackName(playerid,"~b~SUPER Gogeta");
	  return 1;
	}
    if(team == 1)
	{
	  if(GetPlayerSkin(playerid) == VEGEKU0
	  || GetPlayerSkin(playerid) == VEGEKU1) return SendClientMessage(playerid,COLOR_YELLOW,"The fusion expires on your death.");
	  if(GetPlayerSkin(playerid) == GOGETA) return SendClientMessage(playerid,COLOR_YELLOW,"You can't use the fusion again/You Are Already Fused.");
	  if(Ki < 40) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
	  format(string,sizeof(string),"Check this ear ring Goku!!");
	  SendPlayerMessageToAll(playerid,string);
	  CreateExplosion(X,Y,Z+5,11,3);
	  SetPlayerSkin(playerid,VEGEKU0);
	  SetPlayerColor(playerid,COLOR_GREEN);
	  GivePlayerMoney(playerid,-40);
	  ApplyAnimationEx(playerid,"DAM_JUMP","Jump_Roll",4.1,0,1,1,1,1);
	  GameTextForPlayer(playerid,"Vegeku",1000,5);
      Name3DText[playerid] = Create3DTextLabel("VEGEKU", COLOR_GREEN, X, Y, Z+0.2, 20, 0, 0);
	  Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
	  PlaySound(playerid, SOUND_RACE_GO);
	  ShowAttackName(playerid,"~g~Vegeku");
	  return 1;
	}
    return SendClientMessage(playerid,COLOR_RED,"Only Goku and Vegeta can fuse.");
}
CMD:fus(playerid) return cmd_fusion(playerid);
CMD:transform(playerid)
{
    new skinid = GetPlayerSkin(playerid);
    new string[256];
    new name[MAX_PLAYER_NAME];
    new Ki = GetPlayerMoney(playerid);
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid,X,Y,Z);
    GetPlayerName(playerid,name,sizeof(name));
    PlaySound(playerid, SOUND_RACE_GO);
  	if(skinid == GOKU0)
  	{
  	  if(Ki < 30 && GetPlayerInterior(playerid) != INTERIOR_SALONE) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
  	  Delete3DTextLabel(Name3DText[playerid]);
      format(string,sizeof(string),"I'm angry!!!");
  	  SetPlayerSkin(playerid,GOKU1);
  	  CreateExplosion(X,Y,Z+5,11,3);
      SetPlayerColor(playerid,COLOR_YELLOW);
  	  if(GetPlayerInterior(playerid) != 3)GivePlayerMoney(playerid,-30);
  	  SendPlayerMessageToAll(playerid,string);
      Name3DText[playerid] = Create3DTextLabel("GOKU SSJ", COLOR_WHITE, X, Y, Z+0.2, 20, 0, 0);
      Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
      ShowAttackName(playerid,"~y~Goku SUPER Saiyan");
  	  return 1;
  	}
  	else if(skinid == GOKU1)
  	{
	  if(Ki < 40 && GetPlayerInterior(playerid) != INTERIOR_SALONE) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
	  Delete3DTextLabel(Name3DText[playerid]);
      format(string,sizeof(string),"Get ready!!!");
	  SetPlayerSkin(playerid,GOKU2);
	  CreateExplosion(X,Y,Z+5,11,3);
	  SetPlayerColor(playerid,COLOR_ORANGE);
      if(GetPlayerInterior(playerid) != 3)GivePlayerMoney(playerid,-40);
      SendPlayerMessageToAll(playerid,string);
      Delete3DTextLabel(Name3DText[playerid]);
      Name3DText[playerid] = Create3DTextLabel("GOKU SSJ2", COLOR_ORANGE, X, Y, Z+0.2, 20, 0, 0);
      Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
      ShowAttackName(playerid,"~p~Goku SUPER Saiyan 2");
	  return 1;
    }
    else if(skinid == GOKU2)
  	{
	  if(Ki < 50 && GetPlayerInterior(playerid) != INTERIOR_SALONE) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
	  Delete3DTextLabel(Name3DText[playerid]);
      format(string,sizeof(string),"You have no chance against the third SUPER Saiyan level!!!");
	  SetPlayerSkin(playerid,GOKU3);
	  CreateExplosion(X,Y,Z+5,11,3);
      SetPlayerColor(playerid,COLOR_RED);
      if(GetPlayerInterior(playerid) != 3) GivePlayerMoney(playerid,-50);
      SendPlayerMessageToAll(playerid,string);
      Name3DText[playerid] = Create3DTextLabel("GOKU SSJ3", COLOR_RED, X, Y, Z+0.2, 20, 0, 0);
      Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
      ShowAttackName(playerid,"~r~Goku SUPER Saiyan 3");
	  return 1;
  	}
    else if(skinid == GOKU3)
  	{
      format(string,sizeof(string),"I finished my ki!!");
      Delete3DTextLabel(Name3DText[playerid]);
  	  SetPlayerSkin(playerid,GOKU0);
	  CreateExplosion(X,Y,Z+5,11,3);
      SetPlayerColor(playerid,COLOR_WHITE);
      if(GetPlayerInterior(playerid) != 3) ResetPlayerMoney(playerid);
      SendPlayerMessageToAll(playerid,string);
      Name3DText[playerid] = Create3DTextLabel("GOKU", COLOR_WHITE, X, Y, Z+0.2, 20, 0, 0);
      Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
      ShowAttackName(playerid,"~w~Goku");
      return 1;
  	}
    else if(skinid == VEGETA0)
  	{
	  if(Ki < 30 && GetPlayerInterior(playerid) != INTERIOR_SALONE) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
	  Delete3DTextLabel(Name3DText[playerid]);
	  format(string,sizeof(string),"I'm a SUPER Saiyan!!");
	  SetPlayerSkin(playerid,VEGETA1);
	  CreateExplosion(X,Y,Z+5,11,3);
      SetPlayerColor(playerid,COLOR_YELLOW);
      if(GetPlayerInterior(playerid) != 3) GivePlayerMoney(playerid,-30);
      SendPlayerMessageToAll(playerid,string);
      Name3DText[playerid] = Create3DTextLabel("VEGETA SSJ", COLOR_YELLOW, X, Y, Z+0.2, 20, 0, 0);
      Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
      ShowAttackName(playerid,"~y~Vegeta SUPER Saiyan");
	  return 1;
  	}
    else if(skinid == VEGETA1)
  	{
	  if(Ki < 35 && GetPlayerInterior(playerid) != INTERIOR_SALONE) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
	  Delete3DTextLabel(Name3DText[playerid]);
      format(string,sizeof(string),"I'm SUPER Vegeta!!");
	  SetPlayerSkin(playerid,VEGETAS);
	  CreateExplosion(X,Y,Z+5,11,3);
	  SetPlayerColor(playerid,COLOR_ORANGE);
	  if(GetPlayerInterior(playerid) != 3) GivePlayerMoney(playerid,-35);
	  SendPlayerMessageToAll(playerid,string);
      Name3DText[playerid] = Create3DTextLabel("SUPER VEGETA", COLOR_ORANGE, X, Y, Z+0.2, 20, 0, 0);
      Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
      ShowAttackName(playerid,"~p~SUPER Vegeta");
	  return 1;
  	}
    else if(skinid == VEGETAS)
  	{
	  if(Ki < 40 && GetPlayerInterior(playerid) != INTERIOR_SALONE) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
	  Delete3DTextLabel(Name3DText[playerid]);
      format(string,sizeof(string),"Right, here I come!!");
	  SetPlayerSkin(playerid,VEGETA2);
	  CreateExplosion(X,Y,Z+5,11,3);
	  SetPlayerColor(playerid,COLOR_RED);
	  if(GetPlayerInterior(playerid) != 3) GivePlayerMoney(playerid,-40);
	  SendPlayerMessageToAll(playerid,string);
      Name3DText[playerid] = Create3DTextLabel("VEGETA SSJ2", COLOR_RED, X, Y, Z+0.2, 20, 0, 0);
      Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
      ShowAttackName(playerid,"~r~Vegeta SUPER Saiyan 2");
	  return 1;
  	}
    else if(skinid == VEGETA2)
    {
      format(string,sizeof(string),"Oh no!!");
      Delete3DTextLabel(Name3DText[playerid]);
	  SetPlayerSkin(playerid,VEGETA0);
	  CreateExplosion(X,Y,Z+5,11,3);
	  SetPlayerColor(playerid,COLOR_WHITE);
	  if(GetPlayerInterior(playerid) != 3) ResetPlayerMoney(playerid);
	  SendPlayerMessageToAll(playerid,string);
      Name3DText[playerid] = Create3DTextLabel("VEGETA", COLOR_WHITE, X, Y, Z+0.2, 20, 0, 0);
      Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
      ShowAttackName(playerid,"~w~Vegeta");
	  return 1;
  	}
    else if(skinid == TRUNKS0)
  	{
	  if(Ki < 30 && GetPlayerInterior(playerid) != INTERIOR_SALONE) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
	  Delete3DTextLabel(Name3DText[playerid]);
	  format(string,sizeof(string),"Let's fight!!!");
	  SetPlayerSkin(playerid,TRUNKS1);
	  CreateExplosion(X,Y,Z+5,11,3);
	  SetPlayerColor(playerid,COLOR_YELLOW);
	  if(GetPlayerInterior(playerid) != 3) GivePlayerMoney(playerid,-30);
	  SendPlayerMessageToAll(playerid,string);
      Name3DText[playerid] = Create3DTextLabel("TRUNKS SSJ", COLOR_YELLOW, X, Y, Z+0.2, 20, 0, 0);
      Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
      ShowAttackName(playerid,"~y~Trunks SUPER Saiyan");
	  return 1;
  	}
    else if(skinid == TRUNKS1)
  	{
	  if(Ki < 20 && GetPlayerInterior(playerid) != INTERIOR_SALONE) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
	  Delete3DTextLabel(Name3DText[playerid]);
	  format(string,sizeof(string),"I crossed the line of SUPER Saiyan!!");
	  SetPlayerSkin(playerid,TRUNKSS);
	  CreateExplosion(X,Y,Z+5,11,3);
	  SetPlayerColor(playerid,COLOR_ORANGE);
      if(GetPlayerInterior(playerid) != 3) GivePlayerMoney(playerid,-20);
	  SendPlayerMessageToAll(playerid,string);
      Name3DText[playerid] = Create3DTextLabel("SUPER TRUNKS", COLOR_ORANGE, X, Y, Z+0.2, 20, 0, 0);
      Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
      ShowAttackName(playerid,"~p~SUPER Trunks");
	  return 1;
  	}
    else if(skinid == TRUNKSS)
  	{
	  format(string,sizeof(string),"What's happening?!");
	  Delete3DTextLabel(Name3DText[playerid]);
	  SetPlayerSkin(playerid,TRUNKS0);
	  CreateExplosion(X,Y,Z+5,11,3);
	  SetPlayerColor(playerid,COLOR_WHITE);
	  if(GetPlayerInterior(playerid) != 3) ResetPlayerMoney(playerid);
	  SendPlayerMessageToAll(playerid,string);
      Name3DText[playerid] = Create3DTextLabel("TRUNKS", COLOR_WHITE, X, Y, Z+0.2, 20, 0, 0);
      Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
      ShowAttackName(playerid,"~w~Trunks");
	  return 1;
  	}
    else if(skinid == GOHAN0)
  	{
	  if(Ki < 30 && GetPlayerInterior(playerid) != INTERIOR_SALONE) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
	  Delete3DTextLabel(Name3DText[playerid]);
      format(string,sizeof(string),"Prepare to my first transformation!");
	  SetPlayerSkin(playerid,GOHAN1);
	  CreateExplosion(X,Y,Z+5,11,3);
      SetPlayerColor(playerid,COLOR_YELLOW);
      if(GetPlayerInterior(playerid) != 3) GivePlayerMoney(playerid,-30);
      SendPlayerMessageToAll(playerid,string);
      Name3DText[playerid] = Create3DTextLabel("GOHAN SSJ", COLOR_YELLOW, X, Y, Z+0.2, 20, 0, 0);
      Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
      ShowAttackName(playerid,"~y~Gohan SUPER Saiyan");
	  return 1;
 	 }
     else if(skinid ==  GOHAN1)
 	 {
	  if(Ki < 20 && GetPlayerInterior(playerid) != INTERIOR_SALONE) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
	  Delete3DTextLabel(Name3DText[playerid]);
	  format(string,sizeof(string),"Let's fight!");
	  SetPlayerSkin(playerid,GOHAN2);
	  CreateExplosion(X,Y,Z+5,11,3);
	  SetPlayerColor(playerid,COLOR_ORANGE);
	  if(GetPlayerInterior(playerid) != 3) GivePlayerMoney(playerid,-20);
	  SendPlayerMessageToAll(playerid,string);
      Name3DText[playerid] = Create3DTextLabel("GOHAN SSJ2", COLOR_ORANGE, X, Y, Z+0.2, 20, 0, 0);
      Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
      ShowAttackName(playerid,"~p~Gohan SUPER Saiyan 2");
	  return 1;
 	 }
     else if(skinid ==  GOHAN2)
 	 {
	  format(string,sizeof(string),"I finished all my energies!");
	  Delete3DTextLabel(Name3DText[playerid]);
	  SetPlayerSkin(playerid,GOHAN0);
	  CreateExplosion(X,Y,Z+5,11,3);
	  SetPlayerColor(playerid,COLOR_WHITE);
	  if(GetPlayerInterior(playerid) != INTERIOR_SALONE) ResetPlayerMoney(playerid);
	  SendPlayerMessageToAll(playerid,string);
      Name3DText[playerid] = Create3DTextLabel("GOHAN", COLOR_WHITE, X, Y, Z+0.2, 20, 0, 0);
      Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
      ShowAttackName(playerid,"~w~Gohan");
	  return 1;
 	 }
     else if(skinid == VEGEKU0)
 	 {
	  if(Ki < 60 && GetPlayerInterior(playerid) != INTERIOR_SALONE) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
	  Delete3DTextLabel(Name3DText[playerid]);
	  format(string,sizeof(string),"Say welcome to SUPER Vegeku!");
	  SetPlayerSkin(playerid,VEGEKU1);
	  CreateExplosion(X,Y,Z+5,11,3);
	  SetPlayerColor(playerid,COLOR_BLUE);
	  if(GetPlayerInterior(playerid) != INTERIOR_SALONE) GivePlayerMoney(playerid,-60);
	  SendPlayerMessageToAll(playerid,string);
      Name3DText[playerid] = Create3DTextLabel("SUPER VEGEKU", COLOR_BLUE, X, Y, Z+0.2, 20, 0, 0);
      Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
      ShowAttackName(playerid,"~b~SUPER Vegeku");
	  return 1;
 	 }
     else if(skinid == VEGEKU1)
 	 {
	  format(string,sizeof(string),"The effect of the fusion is fading!");
	  Delete3DTextLabel(Name3DText[playerid]);
	  SetPlayerSkin(playerid,VEGEKU0);
	  CreateExplosion(X,Y,Z+5,11,3);
	  SetPlayerColor(playerid,COLOR_GREEN);
	  if(GetPlayerInterior(playerid) != INTERIOR_SALONE) ResetPlayerMoney(playerid);
	  SendPlayerMessageToAll(playerid,string);
      Name3DText[playerid] = Create3DTextLabel("VEGEKU", COLOR_GREEN, X, Y, Z+0.2, 20, 0, 0);
      Attach3DTextLabelToPlayer(Name3DText[playerid], playerid, X, Y, Z+0.4);
      ShowAttackName(playerid,"~g~Vegeku");
	  return 1;
	}

  return SendClientMessage(playerid,COLOR_YELLOW,"This character is not able to transform.");
}
CMD:trans(playerid) return cmd_transform(playerid);
CMD:absrob(playerid)
{
    new string[256];
    new name[MAX_PLAYER_NAME];
    new skin = GetPlayerSkin(playerid);
    new Float:X, Float:Y, Float:Z;
    new Float:health;
    GetPlayerPos(playerid,X,Y,Z);
    GetPlayerName(playerid,name,sizeof(name));
    for(new i=0;i<MAX_PLAYERS;i++)
    {
      if(skin == GELO || skin == Andriod19)
      {
	    if(IsPlayerNearPlayer(2,playerid,i) && i != playerid)
	    {
          format(string,sizeof(string),"Thankyou for your energy!");
          SendPlayerMessageToAll(playerid,string);
          GetPlayerHealth(playerid, health);
          SetPlayerHealth(playerid,health+25);
          GetPlayerHealth(i, health);
          SetPlayerHealth(i,health-25);
          PlaySound(playerid, SOUND_RACE_GO);
  	      return 1;
        }
        return GameTextForPlayer(playerid,"Nobody is near you!",1000,5);
      }
    }
   return SendClientMessage(playerid,COLOR_YELLOW,"Only Dr.Gero and Andriod19 can absorb ki!");
}
CMD:attack(playerid)
{
  new string[256];
  new name[MAX_PLAYER_NAME];
  new skin = GetPlayerSkin(playerid);
  new Float:X, Float:Y, Float:Z;
  new Ki = GetPlayerMoney(playerid);
  GetPlayerPos(playerid,X,Y,Z);
  GetPlayerName(playerid,name,sizeof(name));
  PlaySound(playerid, SOUND_RACE_GO);

  if(GetTickCount() - TickCount[playerid] < 10000) return GameTextForPlayer(playerid,"~r~You must wait 10 second between attacks.",2000,5);
  TickCount[playerid] = GetTickCount();
  if(pInfo[playerid][attack][skin] != NORMAL_ATTACK_SCRIPT)
  {
	if(pInfo[playerid][attack][skin] == KAMEHAMEHA)
	{
	  if(Ki < 25 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Kamehame...ha!!!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-25);
      ApplyAnimationEx(playerid,"BASEBALL","Bat_3",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,5);
      CreateExplosionEx(playerid,20,11,5);
      CreateExplosionEx(playerid,25,11,5);
      CreateExplosionEx(playerid,30,11,5);
      CreateExplosionEx(playerid,35,11,5);
      CreateExplosionEx(playerid,40,11,5);
      CreateExplosionEx(playerid,45,11,5);
      CreateExplosionEx(playerid,50,11,5);
      ShowAttackName(playerid,"~w~Kamehameha(+)");
	}
	if(pInfo[playerid][attack][skin] == KAMEHAMEHA_FURIA)
	{
      if(Ki < 30 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Kame..hame...haaaaaaa!!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-30);
      ApplyAnimationEx(playerid,"BASEBALL","Bat_3",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,15);
      CreateExplosionEx(playerid,20,11,15);
      CreateExplosionEx(playerid,25,11,15);
      CreateExplosionEx(playerid,30,11,15);
      CreateExplosionEx(playerid,35,11,15);
      CreateExplosionEx(playerid,40,11,15);
      CreateExplosionEx(playerid,45,11,15);
      CreateExplosionEx(playerid,50,11,15);
      CreateExplosionEx(playerid,55,11,15);
      ShowAttackName(playerid,"~y~Furious Kamehameha(+)");
	}
	if(pInfo[playerid][attack][skin] == SUPER_KAMEHAMEHA)
	{
      if(Ki < 35 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Questa � una Kamehame..haaa!!!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-35);
      ApplyAnimationEx(playerid,"BASEBALL","Bat_3",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,15);
      CreateExplosionEx(playerid,20,11,15);
      CreateExplosionEx(playerid,25,11,15);
      CreateExplosionEx(playerid,30,11,15);
      CreateExplosionEx(playerid,35,7,15);
      CreateExplosionEx(playerid,40,7,15);
      CreateExplosionEx(playerid,45,7,15);
      CreateExplosionEx(playerid,50,7,15);
      CreateExplosionEx(playerid,55,7,15);
      CreateExplosionEx(playerid,60,7,15);
      ShowAttackName(playerid,"~p~SUPER Kamehameha(+)");
	}
	if(pInfo[playerid][attack][skin] == KAMEHAMEHA_MAX)
	{
      if(Ki < 40 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Kame..........hame.....haaaaaa!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-40);
      ApplyAnimationEx(playerid,"BASEBALL","Bat_3",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,5);
      CreateExplosionEx(playerid,20,11,5);
      CreateExplosionEx(playerid,25,7,5);
      CreateExplosionEx(playerid,30,7,5);
      CreateExplosionEx(playerid,35,7,5);
      CreateExplosionEx(playerid,40,7,5);
      CreateExplosionEx(playerid,45,7,5);
      CreateExplosionEx(playerid,50,7,5);
      CreateExplosionEx(playerid,55,7,5);
      CreateExplosionEx(playerid,60,7,5);
      CreateExplosionEx(playerid,65,7,5);
      CreateExplosionEx(playerid,70,7,5);
      CreateExplosionEx(playerid,75,7,5);
      CreateExplosionEx(playerid,80,7,5);
      ShowAttackName(playerid,"~r~Maximum Intensity Kamehameha(+)");
	}
	if(pInfo[playerid][attack][skin] == CANNONE_ESPLOSIVO)
	{
      if(Ki < 25 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Explosive Cannon!!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-25);
      ApplyAnimationEx(playerid,"BASEBALL","Bat_3",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,10);
      CreateExplosionEx(playerid,20,11,10);
      CreateExplosionEx(playerid,25,11,10);
      CreateExplosionEx(playerid,30,11,10);
      CreateExplosionEx(playerid,35,11,10);
      CreateExplosionEx(playerid,40,11,10);
      CreateExplosionEx(playerid,45,11,10);
      CreateExplosionEx(playerid,50,11,10);
      ShowAttackName(playerid,"~w~Explosive Cannon(+)");
	}
	if(pInfo[playerid][attack][skin] == BIG_BANG_ATTACK)
	{
      if(Ki < 30 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Big Bang ...Attack!!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-30);
      ApplyAnimationEx(playerid,"POLICE","CopTraf_Stop",4.1,0,1,1,1,1);
  	  CreateExplosionEx(playerid,35,7,30);
  	  CreateExplosionEx(playerid,40,7,30);
  	  ShowAttackName(playerid,"~y~Big Bang Attack(+)");
	}
	if(pInfo[playerid][attack][skin] == LAMPO_FINALE)
	{
      if(Ki < 30 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"This is it! The Final Flash!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-30);
      ApplyAnimationEx(playerid,"PED","ARRESTgun",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,20);
      CreateExplosionEx(playerid,20,11,20);
      CreateExplosionEx(playerid,25,11,20);
      CreateExplosionEx(playerid,30,11,20);
      CreateExplosionEx(playerid,35,11,20);
      CreateExplosionEx(playerid,40,11,20);
      CreateExplosionEx(playerid,45,11,20);
      CreateExplosionEx(playerid,50,11,20);
      CreateExplosionEx(playerid,55,11,20);
      CreateExplosionEx(playerid,60,11,20);
      ShowAttackName(playerid,"~r~Final Flash(+)");
	}
	if(pInfo[playerid][attack][skin] == MASENKO)
	{
      if(Ki < 25 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Masenko!!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-25);
      ApplyAnimationEx(playerid,"MISC","plyr_shkhead",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,10);
      CreateExplosionEx(playerid,20,11,10);
      CreateExplosionEx(playerid,25,11,10);
      CreateExplosionEx(playerid,30,11,10);
      CreateExplosionEx(playerid,35,11,10);
      CreateExplosionEx(playerid,40,11,10);
      CreateExplosionEx(playerid,45,11,10);
      CreateExplosionEx(playerid,50,11,10);
      ShowAttackName(playerid,"~w~Masenko(+)");
	}
	if(pInfo[playerid][attack][skin] == attack_BRUCIANTE)
	{
      if(Ki < 25 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Burning attack!!!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-25);
      ApplyAnimationEx(playerid,"MISC","plyr_shkhead",4.1,0,1,1,1,1);
  	  CreateExplosionEx(playerid,30,1,40);
  	  CreateExplosionEx(playerid,35,1,40);
  	  ShowAttackName(playerid,"~y~Burning Attack(+)");
	}
	if(pInfo[playerid][attack][skin] == DISTRUTTORE_LETALE)
	{
      if(Ki < 30 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Take this! Finish buster!!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-30);
      ApplyAnimationEx(playerid,"GRENADE","WEAPON_throw",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,15,7,10);
      ShowAttackName(playerid,"~p~Finish Buster(+)");
	}
	if(pInfo[playerid][attack][skin] == ARTIGLIO_DEL_LUPO)
	{
      if(Ki < 25 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Wolf.. Fang...Fist!!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-25);
      ApplyAnimationEx(playerid,"PARK","Tai_Chi_Loop",4.0,1,0,0,0,0);
      CreateExplosionEx(playerid,15,7,20);
      ShowAttackName(playerid,"~w~Wolf Fang Fist(+)");
	}
	if(pInfo[playerid][attack][skin] == TRIPLO_RAGGIO)
	{
      if(Ki < 25 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"My new tecnic! Triray!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-25);
      ApplyAnimationEx(playerid,"MISC","plyr_shkhead",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,20,6,5);
      CreateExplosionEx(playerid,25,6,5);
      ShowAttackName(playerid,"~w~Triple Ray(+)");
	}
	if(pInfo[playerid][attack][skin] == RAGGIO_ENERGETICO)
	{
	  if(Ki < 25 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Die!!!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-25);
      ApplyAnimationEx(playerid,"MISC","KAT_Throw_O",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,5);
      CreateExplosionEx(playerid,20,11,5);
      CreateExplosionEx(playerid,25,11,5);
      CreateExplosionEx(playerid,30,11,5);
      CreateExplosionEx(playerid,35,11,5);
      CreateExplosionEx(playerid,40,11,5);
      CreateExplosionEx(playerid,45,11,5);
      CreateExplosionEx(playerid,50,11,5);
      CreateExplosionEx(playerid,55,11,5);
      CreateExplosionEx(playerid,60,11,5);
      ShowAttackName(playerid,"~y~Energy Beam(+)");
	}
	if(pInfo[playerid][attack][skin] == SFERE_ENERGETICHE)
	{
	  if(Ki < 35 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"This is the final blow!!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-35);
      ApplyAnimationEx(playerid,"SHOP","SHP_Gun_Fire",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,20,7,35);
  	  CreateExplosionEx(playerid,30,7,35);
  	  ShowAttackName(playerid,"~y~Energy Sphere(+)");
	}
	if(pInfo[playerid][attack][skin] == LANCIARAZZI)
	{
	  if(Ki < 30 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Gun opening in progress...");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-30);
      ApplyAnimationEx(playerid,"ROCKET","RocketFire",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,15,11,5);
      CreateExplosionEx(playerid,20,11,5);
      CreateExplosionEx(playerid,25,7,15);
      CreateExplosionEx(playerid,30,7,15);
      CreateExplosionEx(playerid,35,7,15);
      CreateExplosionEx(playerid,40,7,15);
      CreateExplosionEx(playerid,45,7,15);
      CreateExplosionEx(playerid,50,7,15);
      CreateExplosionEx(playerid,55,7,15);
      CreateExplosionEx(playerid,60,7,15);
      CreateExplosionEx(playerid,65,7,15);
      CreateExplosionEx(playerid,70,7,15);
      ShowAttackName(playerid,"~y~Incorporated Rocket Launcher(+)");
	}
	if(pInfo[playerid][attack][skin] == IL_CAMPIONE)
	{
      if(Ki < 15 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-15);
      ApplyAnimationEx(playerid,"POLICE","CopTraf_Stop",4.1,0,1,1,1,1);
      format(string,sizeof(string),"Ha ha ha haaa!");
      SendPlayerMessageToAll(playerid,string);
      CreateExplosionEx(playerid,10,11,2);
      ShowAttackName(playerid,"~w~The Champion(+)");
	}
	if(pInfo[playerid][attack][skin] == GRAN_BOMBA_Ki)
	{
      if(Ki < 20 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Take this!!!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-20);
      ApplyAnimationEx(playerid,"POLICE","CopTraf_Stop",4.1,0,1,1,1,1);
  	  CreateExplosionEx(playerid,20,11,10);
  	  ShowAttackName(playerid,"~w~Great Ki Bomb(+)");
	}
	if(pInfo[playerid][attack][skin] == KAMEHAMEHA_FINALE)
	{
      if(Ki < 90 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Say goodbye! Final Kamehameha!!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-90);
      ApplyAnimationEx(playerid,"BASEBALL","Bat_3",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,5);
      CreateExplosionEx(playerid,20,11,15);
      CreateExplosionEx(playerid,25,7,15);
      CreateExplosionEx(playerid,30,7,25);
      CreateExplosionEx(playerid,35,7,35);
      CreateExplosionEx(playerid,40,7,35);
      CreateExplosionEx(playerid,45,7,45);
      CreateExplosionEx(playerid,50,7,45);
      CreateExplosionEx(playerid,55,7,55);
      CreateExplosionEx(playerid,60,7,75);
      CreateExplosionEx(playerid,65,7,75);
      CreateExplosionEx(playerid,70,7,75);
      CreateExplosionEx(playerid,75,7,75);
      CreateExplosionEx(playerid,80,7,75);
      CreateExplosionEx(playerid,85,7,75);
      CreateExplosionEx(playerid,90,7,100);
      CreateExplosionEx(playerid,95,7,100);
      CreateExplosionEx(playerid,100,7,100);
      ShowAttackName(playerid,"~b~Final Kamehameha(+)");
	}
	if(pInfo[playerid][attack][skin] == KAMEHAMEHA_BIG_BANG)
	{
      if(Ki < 90 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Big Bang Kamehameha!!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-90);
      ApplyAnimationEx(playerid,"BASEBALL","Bat_3",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,12,1);
      CreateExplosionEx(playerid,7,12,1);
      CreateExplosionEx(playerid,10,12,1);
      CreateExplosionEx(playerid,12,12,1);
      CreateExplosionEx(playerid,15,12,1);
      CreateExplosionEx(playerid,17,12,1);
      CreateExplosionEx(playerid,20,12,1);
      CreateExplosionEx(playerid,22,12,1);
      CreateExplosionEx(playerid,25,12,1);
      CreateExplosionEx(playerid,27,12,1);
      CreateExplosionEx(playerid,30,12,1);
      CreateExplosionEx(playerid,32,12,1);
      CreateExplosionEx(playerid,35,12,1);
      CreateExplosionEx(playerid,37,12,1);
      CreateExplosionEx(playerid,40,12,2);
      CreateExplosionEx(playerid,42,12,2);
      CreateExplosionEx(playerid,45,12,2);
      CreateExplosionEx(playerid,47,12,2);
      CreateExplosionEx(playerid,50,7,100);
      CreateExplosionEx(playerid,52,7,100);
      CreateExplosionEx(playerid,55,7,100);
      CreateExplosionEx(playerid,57,7,100);
      CreateExplosionEx(playerid,60,7,100);
      CreateExplosionEx(playerid,62,7,100);
      CreateExplosionEx(playerid,65,7,100);
      CreateExplosionEx(playerid,67,7,100);
      CreateExplosionEx(playerid,70,7,100);
      ShowAttackName(playerid,"~b~Big Bang Kamehameha(+)");
	}
	if(pInfo[playerid][attack][skin] == SUPER_MASENKO)
	{
      if(Ki < 25 && !IsPlayerAnAndroid(playerid)) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Masenko!!");
      SendPlayerMessageToAll(playerid,string);
      if(!IsPlayerAnAndroid(playerid)) GivePlayerMoney(playerid,-25);
      ApplyAnimationEx(playerid,"MISC","plyr_shkhead",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,10);
      CreateExplosionEx(playerid,20,11,10);
      CreateExplosionEx(playerid,25,11,10);
      CreateExplosionEx(playerid,30,7,10);
      CreateExplosionEx(playerid,35,7,10);
      CreateExplosionEx(playerid,40,7,15);
      CreateExplosionEx(playerid,45,7,15);
      CreateExplosionEx(playerid,50,7,15);
      CreateExplosionEx(playerid,55,7,15);
      CreateExplosionEx(playerid,60,7,15);
      ShowAttackName(playerid,"~w~SUPER Masenko(+)");
	}
	return 1;
  }
  for(new i=0;i<MAX_PLAYERS;i++)
  {
    if(skin == GOKU0)
    {
	  if(Ki < 25) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Kamehame...ha!!!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-25);
      ApplyAnimationEx(playerid,"BASEBALL","Bat_3",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,5);
      CreateExplosionEx(playerid,20,11,5);
      CreateExplosionEx(playerid,25,11,5);
      CreateExplosionEx(playerid,30,11,5);
      CreateExplosionEx(playerid,35,11,5);
      CreateExplosionEx(playerid,40,11,5);
      CreateExplosionEx(playerid,45,11,5);
      CreateExplosionEx(playerid,50,11,5);
      ShowAttackName(playerid,"~w~Kamehameha");
  	  return 1;
    }
    else if(skin == VEGETA0)
    {
      if(Ki < 25) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Explosive Cannon!!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-25);
      ApplyAnimationEx(playerid,"BASEBALL","Bat_3",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,10);
      CreateExplosionEx(playerid,20,11,10);
      CreateExplosionEx(playerid,25,11,10);
      CreateExplosionEx(playerid,30,11,10);
      CreateExplosionEx(playerid,35,11,10);
      CreateExplosionEx(playerid,40,11,10);
      CreateExplosionEx(playerid,45,11,10);
      CreateExplosionEx(playerid,50,11,10);
      ShowAttackName(playerid,"~w~Explosive Cannon");
  	  return 1;
    }
    else if(skin == TRUNKS0)
    {
      if(Ki < 25) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Masenko!!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-25);
      ApplyAnimationEx(playerid,"MISC","plyr_shkhead",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,10);
      CreateExplosionEx(playerid,20,11,10);
      CreateExplosionEx(playerid,25,11,10);
      CreateExplosionEx(playerid,30,11,10);
      CreateExplosionEx(playerid,35,11,10);
      CreateExplosionEx(playerid,40,11,10);
      CreateExplosionEx(playerid,45,11,10);
      CreateExplosionEx(playerid,50,11,10);
      ShowAttackName(playerid,"~w~Masenko");
  	  return 1;
    }
    else if(skin == TRUNKS1)
    {
      if(Ki < 25) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Burning attack!!!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-25);
      ApplyAnimationEx(playerid,"MISC","plyr_shkhead",4.1,0,1,1,1,1);
  	  CreateExplosionEx(playerid,30,1,40);
  	  CreateExplosionEx(playerid,35,1,40);
  	  ShowAttackName(playerid,"~y~Burning Attack");
  	  return 1;
    }
    else if(skin == GOHAN0)
    {
      if(Ki < 25) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Masenko!!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-25);
      ApplyAnimationEx(playerid,"MISC","plyr_shkhead",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,10);
      CreateExplosionEx(playerid,20,11,10);
      CreateExplosionEx(playerid,25,11,10);
      CreateExplosionEx(playerid,30,7,10);
      CreateExplosionEx(playerid,35,7,10);
      CreateExplosionEx(playerid,40,7,15);
      CreateExplosionEx(playerid,45,7,15);
      CreateExplosionEx(playerid,50,7,15);
      CreateExplosionEx(playerid,55,7,15);
      CreateExplosionEx(playerid,60,7,15);
      ShowAttackName(playerid,"~w~SUPER Masenko");
  	  return 1;
    }
    else if(skin == GOKU1)
    {
      if(Ki < 30) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Kame..hame...haaaaaaa!!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-30);
      ApplyAnimationEx(playerid,"BASEBALL","Bat_3",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,15);
      CreateExplosionEx(playerid,20,11,15);
      CreateExplosionEx(playerid,25,11,15);
      CreateExplosionEx(playerid,30,11,15);
      CreateExplosionEx(playerid,35,11,15);
      CreateExplosionEx(playerid,40,11,15);
      CreateExplosionEx(playerid,45,11,15);
      CreateExplosionEx(playerid,50,11,15);
      CreateExplosionEx(playerid,55,11,15);
      ShowAttackName(playerid,"~y~Furious Kamehameha");
  	  return 1;
    }
    else if(skin == VEGETA1)
    {
      if(Ki < 30) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Big Bang Attack!!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-30);
      ApplyAnimationEx(playerid,"POLICE","CopTraf_Stop",4.1,0,1,1,1,1);
  	  CreateExplosionEx(playerid,35,7,30);
  	  CreateExplosionEx(playerid,40,7,30);
  	  ShowAttackName(playerid,"~y~Big Bang Attack");
  	  return 1;
    }
    else if(skin == VEGETA2)
    {
      if(Ki < 30) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"This is it! the Final Flash!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-30);
      ApplyAnimationEx(playerid,"PED","ARRESTgun",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,20);
      CreateExplosionEx(playerid,20,11,20);
      CreateExplosionEx(playerid,25,11,20);
      CreateExplosionEx(playerid,30,11,20);
      CreateExplosionEx(playerid,35,11,20);
      CreateExplosionEx(playerid,40,11,20);
      CreateExplosionEx(playerid,45,11,20);
      CreateExplosionEx(playerid,50,11,20);
      CreateExplosionEx(playerid,55,11,20);
      CreateExplosionEx(playerid,60,11,20);
      ShowAttackName(playerid,"~r~Final Flash");
	  return 1;
    }
    else if(skin == VEGETAS)
    {
      if(Ki < 30) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Take this! Final Flash!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-30);
      ApplyAnimationEx(playerid,"PED","ARRESTgun",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,20);
      CreateExplosionEx(playerid,20,11,20);
      CreateExplosionEx(playerid,25,11,20);
      CreateExplosionEx(playerid,30,11,20);
      CreateExplosionEx(playerid,35,11,20);
      CreateExplosionEx(playerid,40,11,20);
      CreateExplosionEx(playerid,45,11,20);
      CreateExplosionEx(playerid,50,11,20);
      CreateExplosionEx(playerid,55,11,20);
      CreateExplosionEx(playerid,60,11,20);
      ShowAttackName(playerid,"~p~Final Flash");
  	  return 1;
    }
    else if(skin == TRUNKSS)
    {
      if(Ki < 30) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Finish Buster!!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-30);
      ApplyAnimationEx(playerid,"GRENADE","WEAPON_throw",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,15,7,10);
      ShowAttackName(playerid,"~p~Finish Buster");
  	  return 1;
    }
    else if(skin == CRILIN)
    {
      if(Ki < 25) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Kamehaaaa!!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-25);
      ApplyAnimationEx(playerid,"BASEBALL","Bat_3",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,5);
      CreateExplosionEx(playerid,20,11,5);
      CreateExplosionEx(playerid,25,11,5);
      CreateExplosionEx(playerid,30,11,5);
      CreateExplosionEx(playerid,35,11,5);
      CreateExplosionEx(playerid,40,11,5);
      CreateExplosionEx(playerid,45,11,5);
      CreateExplosionEx(playerid,50,11,5);
      ShowAttackName(playerid,"~w~Kamehameha");
      return 1;
    }
    else if(skin == TENSHINSHAN)
    {
      if(Ki < 25) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"My new tecnic! Triray!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-25);
      ApplyAnimationEx(playerid,"MISC","plyr_shkhead",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,20,6,5);
      CreateExplosionEx(playerid,25,6,5);
      ShowAttackName(playerid,"~w~Triple Ray");
  	  return 1;
    }
    else if(skin == YAMCHA)
    {
      if(Ki < 25) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Wolf.. Fang.. Fist!!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-25);
      ApplyAnimationEx(playerid,"PARK","Tai_Chi_Loop",4.0,1,0,0,0,0);
      CreateExplosionEx(playerid,15,7,20);
      ShowAttackName(playerid,"~w~Wolf Fang Fist");
  	  return 1;
    }
    else if(skin == GOHAN1)
    {
      if(Ki < 35) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"This is the Kamehame..haaa!!!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-35);
      ApplyAnimationEx(playerid,"BASEBALL","Bat_3",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,15);
      CreateExplosionEx(playerid,20,11,15);
      CreateExplosionEx(playerid,25,11,15);
      CreateExplosionEx(playerid,30,11,15);
      CreateExplosionEx(playerid,35,7,15);
      CreateExplosionEx(playerid,40,7,15);
      CreateExplosionEx(playerid,45,7,15);
      CreateExplosionEx(playerid,50,7,15);
      CreateExplosionEx(playerid,55,7,15);
      CreateExplosionEx(playerid,60,7,15);
      ShowAttackName(playerid,"~p~SUPER Kamehameha");
  	  return 1;
	}
    else if(skin == GOHAN2)
    {
      if(Ki < 40) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Get Ready! Kame....hame.....haaaaaa!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-40);
      ApplyAnimationEx(playerid,"BASEBALL","Bat_3",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,5);
      CreateExplosionEx(playerid,20,11,5);
      CreateExplosionEx(playerid,25,7,5);
      CreateExplosionEx(playerid,30,7,5);
      CreateExplosionEx(playerid,35,7,5);
      CreateExplosionEx(playerid,40,7,5);
      CreateExplosionEx(playerid,45,7,5);
      CreateExplosionEx(playerid,50,7,5);
      CreateExplosionEx(playerid,55,7,5);
      CreateExplosionEx(playerid,60,7,5);
      CreateExplosionEx(playerid,65,7,5);
      CreateExplosionEx(playerid,70,7,5);
      CreateExplosionEx(playerid,75,7,5);
      CreateExplosionEx(playerid,80,7,5);
      ShowAttackName(playerid,"~r~Maximum Intensity Kamehameha");
   	  return 1;
    }
    else if(skin == GOKU2)
    {
      if(Ki < 35) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"This is the Kamehame..haaa!!!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-35);
      ApplyAnimationEx(playerid,"BASEBALL","Bat_3",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,15);
      CreateExplosionEx(playerid,20,11,15);
      CreateExplosionEx(playerid,25,11,15);
      CreateExplosionEx(playerid,30,11,15);
      CreateExplosionEx(playerid,35,7,15);
      CreateExplosionEx(playerid,40,7,15);
      CreateExplosionEx(playerid,45,7,15);
      CreateExplosionEx(playerid,50,7,15);
      CreateExplosionEx(playerid,55,7,15);
      CreateExplosionEx(playerid,60,7,15);
      ShowAttackName(playerid,"~p~SUPER Kamehameha");
  	  return 1;
    }
    else if(skin == GELO)
    {
      format(string,sizeof(string),"Take this insect!");
      SendPlayerMessageToAll(playerid,string);
      ApplyAnimationEx(playerid,"MISC","KAT_Throw_O",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,5);
      CreateExplosionEx(playerid,20,11,5);
      CreateExplosionEx(playerid,25,11,5);
      CreateExplosionEx(playerid,30,11,5);
      CreateExplosionEx(playerid,35,11,5);
      CreateExplosionEx(playerid,40,11,5);
      CreateExplosionEx(playerid,45,11,5);
      CreateExplosionEx(playerid,50,11,5);
      CreateExplosionEx(playerid,55,11,5);
      CreateExplosionEx(playerid,60,11,5);
      ShowAttackName(playerid,"~y~Energy Beam");
  	  return 1;
    }
    else if(skin == Andriod19)
    {
      ApplyAnimationEx(playerid,"MISC","KAT_Throw_O",4.1,0,1,1,1,1);
      format(string,sizeof(string),"Haha!!");
      SendPlayerMessageToAll(playerid,string);
      ApplyAnimationEx(playerid,"MISC","KAT_Throw_O",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,5);
      CreateExplosionEx(playerid,20,11,5);
      CreateExplosionEx(playerid,25,11,5);
      CreateExplosionEx(playerid,30,11,5);
      CreateExplosionEx(playerid,35,11,5);
      CreateExplosionEx(playerid,40,11,5);
      CreateExplosionEx(playerid,45,11,5);
      CreateExplosionEx(playerid,50,11,5);
      CreateExplosionEx(playerid,55,11,5);
      CreateExplosionEx(playerid,60,11,5);
      ShowAttackName(playerid,"~y~Energy Beam");
  	  return 1;
    }
    else if(skin == Andriod16)
    {
      format(string,sizeof(string),"Gun opening in progress...");
      SendPlayerMessageToAll(playerid,string);
      ApplyAnimationEx(playerid,"ROCKET","RocketFire",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,15,11,5);
      CreateExplosionEx(playerid,20,11,5);
      CreateExplosionEx(playerid,25,7,15);
      CreateExplosionEx(playerid,30,7,15);
      CreateExplosionEx(playerid,35,7,15);
      CreateExplosionEx(playerid,40,7,15);
      CreateExplosionEx(playerid,45,7,15);
      CreateExplosionEx(playerid,50,7,15);
      CreateExplosionEx(playerid,55,7,15);
      CreateExplosionEx(playerid,60,7,15);
      CreateExplosionEx(playerid,65,7,15);
      CreateExplosionEx(playerid,70,7,15);
      ShowAttackName(playerid,"~y~Incorporated Rocket Launcher");
   	  return 1;
    }
    else if(skin == Andriod17)
    {
      format(string,sizeof(string),"This is the final blow!!");
      SendPlayerMessageToAll(playerid,string);
      ApplyAnimationEx(playerid,"SHOP","SHP_Gun_Fire",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,30,7,20);
  	  CreateExplosionEx(playerid,40,7,20);
  	  ShowAttackName(playerid,"~y~Sfere Energetiche");
  	  return 1;
    }
    else if(skin == Andriod18)
    {
      format(string,sizeof(string),"Die!!!");
      SendPlayerMessageToAll(playerid,string);
      ApplyAnimationEx(playerid,"MISC","KAT_Throw_O",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,5);
      CreateExplosionEx(playerid,20,11,5);
      CreateExplosionEx(playerid,25,11,5);
      CreateExplosionEx(playerid,30,11,5);
      CreateExplosionEx(playerid,35,11,5);
      CreateExplosionEx(playerid,40,11,5);
      CreateExplosionEx(playerid,45,11,5);
      CreateExplosionEx(playerid,50,11,5);
      CreateExplosionEx(playerid,55,11,5);
      CreateExplosionEx(playerid,60,11,5);
      ShowAttackName(playerid,"~y~Energy Beam");
  	  return 1;
    }
    else if(skin == GOKU3)
    {
      if(Ki < 40) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Kame..........hame.....haaaaaa!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-40);
      ApplyAnimationEx(playerid,"BASEBALL","Bat_3",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,5);
      CreateExplosionEx(playerid,20,11,5);
      CreateExplosionEx(playerid,25,7,5);
      CreateExplosionEx(playerid,30,7,5);
      CreateExplosionEx(playerid,35,7,5);
      CreateExplosionEx(playerid,40,7,5);
      CreateExplosionEx(playerid,45,7,5);
      CreateExplosionEx(playerid,50,7,5);
      CreateExplosionEx(playerid,55,7,5);
      CreateExplosionEx(playerid,60,7,5);
      CreateExplosionEx(playerid,65,7,5);
      CreateExplosionEx(playerid,70,7,5);
      CreateExplosionEx(playerid,75,7,5);
      CreateExplosionEx(playerid,80,7,5);
      ShowAttackName(playerid,"~r~Maximum Intensity Kamehameha");
  	  return 1;
    }
    else if(skin == VEGEKU0)
    {
      if(Ki < 40) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Finaaal Flaaash!!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-40);
      ApplyAnimationEx(playerid,"PED","ARRESTgun",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,5);
      CreateExplosionEx(playerid,20,11,5);
      CreateExplosionEx(playerid,25,7,5);
      CreateExplosionEx(playerid,30,7,5);
      CreateExplosionEx(playerid,35,7,5);
      CreateExplosionEx(playerid,40,7,5);
      CreateExplosionEx(playerid,45,7,5);
      CreateExplosionEx(playerid,50,7,5);
      CreateExplosionEx(playerid,55,7,5);
      CreateExplosionEx(playerid,60,7,5);
      CreateExplosionEx(playerid,65,7,5);
      CreateExplosionEx(playerid,70,7,5);
      CreateExplosionEx(playerid,75,7,5);
      CreateExplosionEx(playerid,80,7,5);
      CreateExplosionEx(playerid,85,7,5);
      CreateExplosionEx(playerid,90,7,5);
      ShowAttackName(playerid,"~g~Final Flash");
  	  return 1;
    }
    else if(skin == SATAN)
    {
      if(Ki < 15) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      GivePlayerMoney(playerid,-15);
      ApplyAnimationEx(playerid,"POLICE","CopTraf_Stop",4.1,0,1,1,1,1);
      format(string,sizeof(string),"Ha ha ha haaa!");
      SendPlayerMessageToAll(playerid,string);
      CreateExplosionEx(playerid,10,11,2);
      ShowAttackName(playerid,"~w~The Champion");
      return 1;
    }
    else if(skin == VIDEL)
    {
      if(Ki < 20) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Take this!!!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-20);
      ApplyAnimationEx(playerid,"POLICE","CopTraf_Stop",4.1,0,1,1,1,1);
  	  CreateExplosionEx(playerid,20,11,10);
  	  ShowAttackName(playerid,"~w~Great Ki Bomb");
  	  return 1;
	}
    else if(skin == VEGEKU1)
    {
      if(Ki < 90) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Say goodbye!! Final Kamehameha!!!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-90);
      ApplyAnimationEx(playerid,"BASEBALL","Bat_3",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,11,5);
      CreateExplosionEx(playerid,10,11,5);
      CreateExplosionEx(playerid,15,11,5);
      CreateExplosionEx(playerid,20,11,15);
      CreateExplosionEx(playerid,25,7,15);
      CreateExplosionEx(playerid,30,7,25);
      CreateExplosionEx(playerid,35,7,35);
      CreateExplosionEx(playerid,40,7,35);
      CreateExplosionEx(playerid,45,7,45);
      CreateExplosionEx(playerid,50,7,45);
      CreateExplosionEx(playerid,55,7,55);
      CreateExplosionEx(playerid,60,7,75);
      CreateExplosionEx(playerid,65,7,75);
      CreateExplosionEx(playerid,70,7,75);
      CreateExplosionEx(playerid,75,7,75);
      CreateExplosionEx(playerid,80,7,75);
      CreateExplosionEx(playerid,85,7,75);
      CreateExplosionEx(playerid,90,7,100);
      CreateExplosionEx(playerid,95,7,100);
      CreateExplosionEx(playerid,100,7,100);
      ShowAttackName(playerid,"~b~Final Kamehameha");
  	  return 1;
    }
    else if(skin == GOGETA)
    {
      if(Ki < 90) return GameTextForPlayer(playerid,NO_Ki_MESSAGE,1000,5);
      format(string,sizeof(string),"Big Bang Kamehameha!!!");
      SendPlayerMessageToAll(playerid,string);
      GivePlayerMoney(playerid,-90);
      ApplyAnimationEx(playerid,"BASEBALL","Bat_3",4.1,0,1,1,1,1);
      CreateExplosionEx(playerid,5,12,1);
      CreateExplosionEx(playerid,7,12,1);
      CreateExplosionEx(playerid,10,12,1);
      CreateExplosionEx(playerid,12,12,1);
      CreateExplosionEx(playerid,15,12,1);
      CreateExplosionEx(playerid,17,12,1);
      CreateExplosionEx(playerid,20,12,1);
      CreateExplosionEx(playerid,22,12,1);
      CreateExplosionEx(playerid,25,12,1);
      CreateExplosionEx(playerid,27,12,1);
      CreateExplosionEx(playerid,30,12,1);
      CreateExplosionEx(playerid,32,12,1);
      CreateExplosionEx(playerid,35,12,1);
      CreateExplosionEx(playerid,37,12,1);
      CreateExplosionEx(playerid,40,12,2);
      CreateExplosionEx(playerid,42,12,2);
      CreateExplosionEx(playerid,45,12,2);
      CreateExplosionEx(playerid,47,12,2);
      CreateExplosionEx(playerid,50,7,100);
      CreateExplosionEx(playerid,52,7,100);
      CreateExplosionEx(playerid,55,7,100);
      CreateExplosionEx(playerid,57,7,100);
      CreateExplosionEx(playerid,60,7,100);
      CreateExplosionEx(playerid,62,7,100);
      CreateExplosionEx(playerid,65,7,100);
      CreateExplosionEx(playerid,67,7,100);
      CreateExplosionEx(playerid,70,7,100);
      ShowAttackName(playerid,"~b~Big Bang Kamehameha");
  	  return 1;
    }
  }
  PlaySound(playerid, SOUND_AMMUNATION_BUY_WEAPON_DENIED);
  return SendClientMessage(playerid,COLOR_YELLOW,"ERROR: Invalid Skin!");
}
CMD:att(playerid) return cmd_attack(playerid);
CMD:me(playerid,params[])
{
  new string[128]; //needs work 
  if(!strlen(params)) return SendClientMessage(playerid,COLOR_RED, "/me [text]");
  format(string, sizeof(string), "* %s %s", pNick(playerid), params);
  SendClientMessageToAll(GetPlayerColor(playerid), string);
  return 1;
}
//----------------//
stock strtolower(str[])
{
    for(new c = 0; str[c] != EOS; ++c) {
        str[c] = tolower(str[c]);
    }
    return 1;
}
//-----------------//

stock ShowSpawnLocationTD(playerid)
{
	for(new i=0; i < 13; i++) TextDrawShowForPlayer(playerid,SpawnLocationTD[i]);
}
stock ShowCustomizingPlayerTD(playerid)
{
	TogglePlayerControllable(playerid,false);
	for(new i=0; i < 9; i++) TextDrawShowForPlayerForPlayer(player,CustomizePlayerTD[i]);
}