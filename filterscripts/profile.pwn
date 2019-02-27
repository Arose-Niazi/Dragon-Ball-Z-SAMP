
/*
 This Source Code Form is subject to the terms of the Mozilla Public
 License, v. 2.0. If a copy of the MPL was not distributed with this file,
 You can obtain one at http://mozilla.org/MPL/2.0/
*/

/*============================================================================*/
// INCLUDES

#include <a_samp>               //Thanks to the SA-MP Team.
#include <ZCMD>                 //Thanks to Zeex.
#include <sscanf2>              //Thanks to Y_Less.
#include <DOF2>                 //Thanks to Double-O-Seven.

/*============================================================================*/
// DEFINITIONS

#define PROFILE                 "{00A6FF}[PROFILE]{737373} "

#define USER_DIRECTORY          "/Profiles/%s.ini"

#define LOOP(%0,%1) 			for(new %0 = 0; %0 < %1; %0++)
#define LOOP_s(%0,%1) 			for(new %0 = 0; %0 < sizeof(%1); %0++)
#define ExceedsIndex(%0,%1)     (%0 < 0 || %0 >= sizeof %1)

#define BG_key                  "Backgroundid"
#define AV_key                  "Avatarid"
#define INFO_key                "Info"
#define REGDATE_key             "Registration"
#define LASTACTIVE_key          "Lastactive"
#define REP_key                 "Reputation"
#define VIP_key                 "Viplevel"
#define LVL_key                 "Adminlevel"
#define VIPTEXT_key             "Vipstatustext"
#define LVLTEXT_key             "Levelstatustext"
#define TRUSTED_key             "Trusted"
#define FEATURED_key            "Featured"
#define PRO_key             	"Professional"

#define EDITMODE_BACKGROUND     1
#define EDITMODE_AVATAR         2

/*============================================================================*/
// VARIABLES

new
    DAY, MONTH, YEAR,
	PROFILE_STRING				[256],
	PROFILE_ERROR				[128],
	
	bool:Profile_ENABLED        [MAX_PLAYERS],
	Profile_EditMode        	[MAX_PLAYERS],
	
	bool:Profile_New        	[MAX_PLAYERS],
	Profile_Name            	[MAX_PLAYERS][MAX_PLAYER_NAME],
	Profile_Background			[MAX_PLAYERS],
	Profile_Avatar				[MAX_PLAYERS],
	Profile_Reputation			[MAX_PLAYERS],
	Profile_Viplevel			[MAX_PLAYERS],
	Profile_Adminlevel			[MAX_PLAYERS],
	Profile_Info				[MAX_PLAYERS][256],
	Profile_Registerdate		[MAX_PLAYERS][20],
	Profile_Lastactive			[MAX_PLAYERS][20],
	Profile_Viptext				[MAX_PLAYERS][20],
	Profile_Admintext			[MAX_PLAYERS][20],
	bool:Profile_Trusted    	[MAX_PLAYERS],
	bool:Profile_Featured   	[MAX_PLAYERS],
	bool:Profile_Pro    		[MAX_PLAYERS],
	Profile_Currentuser     	[MAX_PLAYERS][MAX_PLAYER_NAME],
	Profile_CmdTimer            [MAX_PLAYERS],
	Profile_Cooldown            [MAX_PLAYERS],

    Text:CopyrightP,
	Text:ProfileBase			[3],
	Text:Status					[2],
	Text:Elements				[9],
	Text:RepBars				[5],
	Text:VipBars				[5],
	Text:LevelBars				[5],
	Text:Awards					[3][2],
	Text:EditArrows             [4],
	Text:DynProfile				[MAX_PLAYERS][7],

	Avatar_Icons[][] =
	{
		"none",				"LD_TATT:9homby", 	"LD_TATT:9gun2",
		"LD_TATT:9gun",		"LD_TATT:9crown",	"LD_TATT:9bullt",
	    "LD_TATT:8westsd",	"LD_TATT:8santos",	"LD_TATT:8sa3",
		"LD_TATT:8sa2",		"LD_TATT:8sa",		"LD_TATT:8poker",
	    "LD_TATT:8gun",		"LD_TATT:7mary",	"LD_TATT:7cross3",
		"LD_TATT:7cross2",	"LD_TATT:7cross",	"LD_TATT:6crown",
	    "LD_TATT:6aztec",	"LD_TATT:6africa",  "ld_shtr:ufo",
		"LD_TATT:5gun",		"LD_TATT:5cross3",	"LD_TATT:5cross2",
	    "LD_TATT:5cross",	"LD_TATT:4weed",	"LD_TATT:4spider",
		"LD_TATT:4rip",		"LD_TATT:12myfac",	"LD_TATT:12maybr",
	    "LD_TATT:12dager",	"LD_TATT:12cross",	"LD_TATT:12bndit",
		"LD_TATT:12angel",	"LD_TATT:11jail",	"LD_TATT:11grove",
	    "LD_TATT:11grov3",	"LD_TATT:11grov2",	"LD_TATT:11ggift",
		"LD_TATT:11dice2",	"LD_TATT:11dice",	"LD_TATT:10weed",
		"LD_TATT:10og",		"LD_TATT:10ls5",	"LD_TATT:10ls4",
		"LD_TATT:10ls3",	"LD_TATT:10ls2",	"LD_TATT:10ls",
		"ld_bum:bum1",      "ld_bum:bum2",      "ld_grav:bee1",
		"ld_otb:hrs8",      "ld_shtr:kami",     "ld_shtr:ship"
	},
	Text:Avatars[sizeof Avatar_Icons],
	
	Background_Images[][] =
	{
	    "none",				"LOADSUK:loadsc9",	"LOADSUK:loadsc8",
		"LOADSUK:loadsc7",	"LOADSUK:loadsc6",	"LOADSUK:loadsc5",
		"LOADSUK:loadsc4",	"LOADSUK:loadsc3",	"LOADSUK:loadsc2",
		"LOADSUK:loadsc14",	"LOADSUK:loadsc13",	"LOADSUK:loadsc12",
		"LOADSUK:loadsc11",	"LOADSUK:loadsc10",	"LOADSUK:loadsc1",
		"loadsc12:loadsc12","loadsc13:loadsc13","loadsc9:loadsc9",
		"splash1:splash1",  "splash2:splash2"
		
	},
	Text:Backgrounds[sizeof Background_Images]
;

/*============================================================================*/
// FILTERSCRIPT FUNCTIONS

stock Text:TextDrawCreateSafe(Float:X, Float:Y, textstring[])
{
	if(!strlen(textstring)) strcat(textstring, "_", 2);
	return TextDrawCreate(X, Y, textstring);
}

stock CreateTextdraws()
{
    ProfileBase[0] =
	TextDrawCreate				(320.000000, 279.000000, "-");
	TextDrawAlignment			(ProfileBase[0], 2);
	TextDrawBackgroundColor		(ProfileBase[0], 255);
	TextDrawFont				(ProfileBase[0], 2);
	TextDrawLetterSize			(ProfileBase[0], 32.689998, 10.000000);
	TextDrawColor				(ProfileBase[0], 120);
	TextDrawSetOutline			(ProfileBase[0], 0);
	TextDrawSetProportional		(ProfileBase[0], 1);
	TextDrawSetShadow			(ProfileBase[0], 0);

	ProfileBase[1] =
	TextDrawCreate				(320.000000, 92.000000, "-");
	TextDrawAlignment			(ProfileBase[1], 2);
	TextDrawBackgroundColor		(ProfileBase[1], 255);
	TextDrawFont				(ProfileBase[1], 2);
	TextDrawLetterSize			(ProfileBase[1], 32.689998, 10.000000);
	TextDrawColor				(ProfileBase[1], 120);
	TextDrawSetOutline			(ProfileBase[1], 0);
	TextDrawSetProportional		(ProfileBase[1], 1);
	TextDrawSetShadow			(ProfileBase[1], 0);

    ProfileBase[2] =
	TextDrawCreateSafe			(485.000000, 140.000000, "_");
	TextDrawBackgroundColor		(ProfileBase[2], 255);
	TextDrawFont				(ProfileBase[2], 1);
	TextDrawLetterSize			(ProfileBase[2], 0.500000, 21.200000);
	TextDrawColor				(ProfileBase[2], -1);
	TextDrawSetOutline			(ProfileBase[2], 0);
	TextDrawSetProportional		(ProfileBase[2], 1);
	TextDrawSetShadow			(ProfileBase[2], 1);
	TextDrawUseBox				(ProfileBase[2], 1);
	TextDrawBoxColor			(ProfileBase[2], 255);
	TextDrawTextSize			(ProfileBase[2], 160.000000, 0.000000);

   	new Profile_Int = 0;
	for ( new BTD = 1; BTD < sizeof Background_Images; BTD++ )
	{
		Backgrounds[BTD] =
		TextDrawCreateSafe		(163.000, 140.500, Background_Images[BTD]);
	    TextDrawFont			(Backgrounds[BTD], 4);
	    TextDrawTextSize		(Backgrounds[BTD], 319.000, 190.000);
	    TextDrawColor			(Backgrounds[BTD], -140);

	    Profile_Int++;
	}
	printf("[Profile System] Created %i Background(s)", Profile_Int);

	Awards[0][0] =
	TextDrawCreate				(350.000000, 218.000000, "-");
	TextDrawBackgroundColor		(Awards[0][0], 255);
	TextDrawFont				(Awards[0][0], 3);
	TextDrawLetterSize			(Awards[0][0], 3.169997, 8.799997);
	TextDrawColor				(Awards[0][0], -176);
	TextDrawSetOutline			(Awards[0][0], 0);
	TextDrawSetProportional		(Awards[0][0], 1);
	TextDrawSetShadow			(Awards[0][0], 0);

	Awards[0][1] =
	TextDrawCreate				(358.000000, 261.000000, "TRUSTED~n~MEMBER");
	TextDrawBackgroundColor		(Awards[0][1], 255);
	TextDrawFont				(Awards[0][1], 1);
	TextDrawLetterSize			(Awards[0][1], 0.219999, 0.799998);
	TextDrawColor				(Awards[0][1], 16747775);
	TextDrawSetOutline			(Awards[0][1], 0);
	TextDrawSetProportional		(Awards[0][1], 1);
	TextDrawSetShadow			(Awards[0][1], 0);

	Awards[1][0] =
	TextDrawCreate				(394.000000, 218.000000, "-");
	TextDrawBackgroundColor		(Awards[1][0], 255);
	TextDrawFont				(Awards[1][0], 3);
	TextDrawLetterSize			(Awards[1][0], 3.169997, 8.799997);
	TextDrawColor				(Awards[1][0], -176);
	TextDrawSetOutline			(Awards[1][0], 0);
	TextDrawSetProportional		(Awards[1][0], 1);
	TextDrawSetShadow			(Awards[1][0], 0);

	Awards[1][1] =
	TextDrawCreate				(416.000000, 261.000000, "FEATURED~n~MEMBER");
	TextDrawAlignment			(Awards[1][1], 2);
	TextDrawBackgroundColor		(Awards[1][1], 255);
	TextDrawFont				(Awards[1][1], 1);
	TextDrawLetterSize			(Awards[1][1], 0.200000, 0.799998);
	TextDrawColor				(Awards[1][1], -3669761);
	TextDrawSetOutline			(Awards[1][1], 0);
	TextDrawSetProportional		(Awards[1][1], 1);
	TextDrawSetShadow			(Awards[1][1], 0);

	Awards[2][0] =
	TextDrawCreate				(438.000000, 218.000000, "-");
	TextDrawBackgroundColor		(Awards[2][0], 255);
	TextDrawFont				(Awards[2][0], 3);
	TextDrawLetterSize			(Awards[2][0], 3.169997, 8.799997);
	TextDrawColor				(Awards[2][0], -176);
	TextDrawSetOutline			(Awards[2][0], 0);
	TextDrawSetProportional		(Awards[2][0], 1);
	TextDrawSetShadow			(Awards[2][0], 0);

	Awards[2][1] =
	TextDrawCreate				(461.000000, 261.000000, "PRO");
	TextDrawAlignment			(Awards[2][1], 2);
	TextDrawBackgroundColor		(Awards[2][1], -16776961);
	TextDrawFont				(Awards[2][1], 2);
	TextDrawLetterSize			(Awards[2][1], 0.340000, 1.499999);
	TextDrawColor				(Awards[2][1], 255);
	TextDrawSetOutline			(Awards[2][1], 1);
	TextDrawSetProportional		(Awards[2][1], 1);

    printf("[Profile System] Created Award Icons.");

	Status[0] =
	TextDrawCreateSafe			(234.000000, 151.000000, "0");
	TextDrawAlignment			(Status[0], 2);
	TextDrawBackgroundColor		(Status[0], -1275068161);
	TextDrawFont				(Status[0], 2);
	TextDrawLetterSize			(Status[0], 2.679999, 10.599998);
	TextDrawColor				(Status[0], -16776961);
	TextDrawSetOutline			(Status[0], 1);
	TextDrawSetProportional		(Status[0], 1);

	Status[1] =
	TextDrawCreateSafe			(234.000000, 151.000000, "0");
	TextDrawAlignment			(Status[1], 2);
	TextDrawBackgroundColor		(Status[1], 0x00AA00FF);
	TextDrawFont				(Status[1], 2);
	TextDrawLetterSize			(Status[1], 2.679999, 10.599998);
	TextDrawColor				(Status[1], 0x00FF00FF);
	TextDrawSetOutline			(Status[1], 1);
	TextDrawSetProportional		(Status[1], 1);

	CopyrightP =
	TextDrawCreateSafe			(383.000000, 322.000000, "Profile system (c) iPLEOMAX");
	TextDrawBackgroundColor		(CopyrightP, 255);
	TextDrawFont				(CopyrightP, 1);
	TextDrawLetterSize			(CopyrightP, 0.209999, 0.899999);
	TextDrawColor				(CopyrightP, -226);
	TextDrawSetOutline			(CopyrightP, 0);
	TextDrawSetProportional		(CopyrightP, 1);
	TextDrawSetShadow			(CopyrightP, 0);

	Elements[0] =
	TextDrawCreateSafe			(185.000000, 147.000000, "PROFILE PICTURE");
	TextDrawBackgroundColor		(Elements[0], -1);
	TextDrawFont				(Elements[0], 1);
	TextDrawLetterSize			(Elements[0], 0.319999, 1.100000);
	TextDrawColor				(Elements[0], -1);
	TextDrawSetOutline			(Elements[0], 0);
	TextDrawSetProportional		(Elements[0], 1);
	TextDrawSetShadow			(Elements[0], 0);

	Elements[1] =
	TextDrawCreateSafe			(351.000000, 147.000000, "INFORMATION");
	TextDrawBackgroundColor		(Elements[1], -1);
	TextDrawFont				(Elements[1], 1);
	TextDrawLetterSize			(Elements[1], 0.319999, 1.100000);
	TextDrawColor				(Elements[1], -1);
	TextDrawSetOutline			(Elements[1], 0);
	TextDrawSetProportional		(Elements[1], 1);
	TextDrawSetShadow			(Elements[1], 0);

	Elements[2] =
	TextDrawCreateSafe			(297.000000, 198.000000, "Personal text:");
	TextDrawBackgroundColor		(Elements[2], 255);
	TextDrawFont				(Elements[2], 2);
	TextDrawLetterSize			(Elements[2], 0.200000, 1.000000);
	TextDrawColor				(Elements[2], -1);
	TextDrawSetOutline			(Elements[2], 0);
	TextDrawSetProportional		(Elements[2], 1);
	TextDrawSetShadow			(Elements[2], 0);

	Elements[3] =
	TextDrawCreateSafe			(297.000000, 285.000000, "Register date:");
	TextDrawBackgroundColor		(Elements[3], 255);
	TextDrawFont				(Elements[3], 2);
	TextDrawLetterSize			(Elements[3], 0.200000, 1.000000);
	TextDrawColor				(Elements[3], -1);
	TextDrawSetOutline			(Elements[3], 0);
	TextDrawSetProportional		(Elements[3], 1);
	TextDrawSetShadow			(Elements[3], 0);

	Elements[4] =
	TextDrawCreateSafe			(297.000000, 171.000000, "Username:");
	TextDrawBackgroundColor		(Elements[4], 255);
	TextDrawFont				(Elements[4], 2);
	TextDrawLetterSize			(Elements[4], 0.200000, 1.000000);
	TextDrawColor				(Elements[4], -1);
	TextDrawSetOutline			(Elements[4], 0);
	TextDrawSetProportional		(Elements[4], 1);
	TextDrawSetShadow			(Elements[4], 0);

    Elements[5] =
	TextDrawCreateSafe			(297.000000, 303.000000, "Last active:");
	TextDrawBackgroundColor		(Elements[5], 255);
	TextDrawFont				(Elements[5], 2);
	TextDrawLetterSize			(Elements[5], 0.200000, 1.000000);
	TextDrawColor				(Elements[5], -1);
	TextDrawSetOutline			(Elements[5], 0);
	TextDrawSetProportional		(Elements[5], 1);
	TextDrawSetShadow			(Elements[5], 0);

	Elements[6] =
	TextDrawCreateSafe			(291.000000, 77.000000, "l");
	TextDrawBackgroundColor		(Elements[6], -1);
	TextDrawFont				(Elements[6], 1);
	TextDrawLetterSize			(Elements[6], 0.140000, 32.600021);
	TextDrawColor				(Elements[6], -1);
	TextDrawSetOutline			(Elements[6], 0);
	TextDrawSetProportional		(Elements[6], 1);
	TextDrawSetShadow			(Elements[6], 0);

	Elements[7] =
	TextDrawCreateSafe			(484.000000, 143.000000, "BG~n~SHINE");
	TextDrawBackgroundColor		(Elements[7], 255);
	TextDrawFont				(Elements[7], 1);
	TextDrawLetterSize			(Elements[7], 0.000000, 1.000000);
	TextDrawColor				(Elements[7], -1);
	TextDrawSetOutline			(Elements[7], 0);
	TextDrawSetProportional		(Elements[7], 1);
	TextDrawSetShadow			(Elements[7], 1);
	TextDrawUseBox				(Elements[7], 1);
	TextDrawBoxColor			(Elements[7], -230);
	TextDrawTextSize			(Elements[7], 161.000000, -1.000000);

	Elements[8] =
	TextDrawCreate				(296.000000, 266.000000, "Awards:");
	TextDrawBackgroundColor		(Elements[8], 255);
	TextDrawFont				(Elements[8], 2);
	TextDrawLetterSize			(Elements[8], 0.219999, 1.000000);
	TextDrawColor				(Elements[8], -1);
	TextDrawSetOutline			(Elements[8], 0);
	TextDrawSetProportional		(Elements[8], 1);
	TextDrawSetShadow			(Elements[8], 0);

	printf("[Profile System] Created all the elements.");

	Profile_Int = 0;
	for ( new ATD = 1; ATD < sizeof Avatar_Icons; ATD++ )
	{
		Avatars[ATD] =
		TextDrawCreateSafe		(203.000, 182.500, Avatar_Icons[ATD]);
	    TextDrawFont			(Avatars[ATD], 4);
	    TextDrawTextSize		(Avatars[ATD], 50.000, 45.000);
	    TextDrawColor			(Avatars[ATD], -1);

	    Profile_Int++;
	}
	printf("[Profile System] Created %i Avatar(s)", Profile_Int);

    Profile_Int = 192;
    for ( new RTD = 0; RTD < sizeof RepBars; RTD++ )
    {
        RepBars[RTD] =
		TextDrawCreateSafe		(Profile_Int, 241.000000, "l");
		TextDrawBackgroundColor	(RepBars[RTD], 255);
		TextDrawFont			(RepBars[RTD], 1);
		TextDrawLetterSize		(RepBars[RTD], 1.820000, 1.900000);
		TextDrawColor			(RepBars[RTD], 0x00FF00FF);
		TextDrawSetOutline		(RepBars[RTD], 0);
		TextDrawSetProportional	(RepBars[RTD], 1);
		TextDrawSetShadow		(RepBars[RTD], 0);
		Profile_Int += 14;
    }

    Profile_Int = 192;
    for ( new VTD = 0; VTD < sizeof VipBars; VTD++ )
    {
        VipBars[VTD] =
		TextDrawCreateSafe		(Profile_Int, 269.000000, "l");
		TextDrawBackgroundColor	(VipBars[VTD], 255);
		TextDrawFont			(VipBars[VTD], 1);
		TextDrawLetterSize		(VipBars[VTD], 1.820000, 1.900000);
		TextDrawColor			(VipBars[VTD], 0x00FFFBFF);
		TextDrawSetOutline		(VipBars[VTD], 0);
		TextDrawSetProportional	(VipBars[VTD], 1);
		TextDrawSetShadow		(VipBars[VTD], 0);
		Profile_Int += 14;
    }

    Profile_Int = 192;
    for ( new LTD = 0; LTD < sizeof LevelBars; LTD++ )
    {
        LevelBars[LTD] =
		TextDrawCreateSafe		(Profile_Int, 296.000000, "l");
		TextDrawBackgroundColor	(LevelBars[LTD], 255);
		TextDrawFont			(LevelBars[LTD], 1);
		TextDrawLetterSize		(LevelBars[LTD], 1.820000, 1.900000);
		TextDrawColor			(LevelBars[LTD], -16711681);
		TextDrawSetOutline		(LevelBars[LTD], 0);
		TextDrawSetProportional	(LevelBars[LTD], 1);
		TextDrawSetShadow		(LevelBars[LTD], 0);
		Profile_Int += 14;
    }
    printf("[Profile System] Created Reputation/Vip/Level bars.", Profile_Int);

    EditArrows[0] =
	TextDrawCreate				(171.000000, 195.000000, "ld_beat:left");
	TextDrawBackgroundColor		(EditArrows[0], 255);
	TextDrawFont				(EditArrows[0], 4);
	TextDrawLetterSize			(EditArrows[0], 0.500000, 1.000000);
	TextDrawColor				(EditArrows[0], -1);
	TextDrawSetOutline			(EditArrows[0], 0);
	TextDrawSetProportional		(EditArrows[0], 1);
	TextDrawSetShadow			(EditArrows[0], 1);
	TextDrawUseBox				(EditArrows[0], 1);
	TextDrawBoxColor			(EditArrows[0], 255);
	TextDrawTextSize			(EditArrows[0], 18.000000, 22.000000);

	EditArrows[1] =
	TextDrawCreate				(283.000000, 195.000000, "ld_beat:left");
	TextDrawBackgroundColor		(EditArrows[1], 255);
	TextDrawFont				(EditArrows[1], 4);
	TextDrawLetterSize			(EditArrows[1], 0.500000, 1.000000);
	TextDrawColor				(EditArrows[1], -1);
	TextDrawSetOutline			(EditArrows[1], 0);
	TextDrawSetProportional		(EditArrows[1], 1);
	TextDrawSetShadow			(EditArrows[1], 1);
	TextDrawUseBox				(EditArrows[1], 1);
	TextDrawBoxColor			(EditArrows[1], 255);
	TextDrawTextSize			(EditArrows[1], -19.000000, 22.000000);

	EditArrows[2] =
	TextDrawCreate				(138.000000, 224.000000, "ld_beat:left");
	TextDrawBackgroundColor		(EditArrows[2], 255);
	TextDrawFont				(EditArrows[2], 4);
	TextDrawLetterSize			(EditArrows[2], 0.500000, 1.000000);
	TextDrawColor				(EditArrows[2], -1);
	TextDrawSetOutline			(EditArrows[2], 0);
	TextDrawSetProportional		(EditArrows[2], 1);
	TextDrawSetShadow			(EditArrows[2], 1);
	TextDrawUseBox				(EditArrows[2], 1);
	TextDrawBoxColor			(EditArrows[2], 255);
	TextDrawTextSize			(EditArrows[2], 18.000000, 22.000000);

	EditArrows[3] =
	TextDrawCreate				(508.000000, 224.000000, "ld_beat:left");
	TextDrawBackgroundColor		(EditArrows[3], 255);
	TextDrawFont				(EditArrows[3], 4);
	TextDrawLetterSize			(EditArrows[3], 0.500000, 1.000000);
	TextDrawColor				(EditArrows[3], -1);
	TextDrawSetOutline			(EditArrows[3], 0);
	TextDrawSetProportional		(EditArrows[3], 1);
	TextDrawSetShadow			(EditArrows[3], 1);
	TextDrawUseBox				(EditArrows[3], 1);
	TextDrawBoxColor			(EditArrows[3], 255);
	TextDrawTextSize			(EditArrows[3], -19.000000, 22.000000);
	
	return true;
}

stock DynamicTextdraws(playerid, name[], info[], reg[], act[], rep, vip[], lvl[])
{
    DynProfile[playerid][0] =
	TextDrawCreateSafe			(297.000000, 184.000000, name);
	TextDrawBackgroundColor		(DynProfile[playerid][0], 255);
	TextDrawFont				(DynProfile[playerid][0], 1);
	TextDrawLetterSize			(DynProfile[playerid][0], 0.290000, 1.000000);
	TextDrawColor				(DynProfile[playerid][0], -1);
	TextDrawSetOutline			(DynProfile[playerid][0], 0);
	TextDrawSetProportional		(DynProfile[playerid][0], 1);
	TextDrawSetShadow			(DynProfile[playerid][0], 0);

	DynProfile[playerid][1] =
	TextDrawCreateSafe			(297.000000, 210.000000, info);
	TextDrawBackgroundColor		(DynProfile[playerid][1], 255);
	TextDrawFont				(DynProfile[playerid][1], 1);
	TextDrawLetterSize			(DynProfile[playerid][1], 0.290000, 1.000000);
	TextDrawColor				(DynProfile[playerid][1], -1);
	TextDrawSetOutline			(DynProfile[playerid][1], 0);
	TextDrawSetProportional		(DynProfile[playerid][1], 1);
	TextDrawSetShadow			(DynProfile[playerid][1], 0);

	DynProfile[playerid][2] =
	TextDrawCreateSafe			(478.000000, 278.000000, reg);
	TextDrawAlignment			(DynProfile[playerid][2], 3);
	TextDrawBackgroundColor		(DynProfile[playerid][2], 255);
	TextDrawFont				(DynProfile[playerid][2], 3);
	TextDrawLetterSize			(DynProfile[playerid][2], 0.480000, 1.600000);
	TextDrawColor				(DynProfile[playerid][2], -1);
	TextDrawSetOutline			(DynProfile[playerid][2], 0);
	TextDrawSetProportional		(DynProfile[playerid][2], 1);
	TextDrawSetShadow			(DynProfile[playerid][2], 0);

	DynProfile[playerid][3] =
	TextDrawCreateSafe			(478.000000, 300.000000, act);
	TextDrawAlignment			(DynProfile[playerid][3], 3);
	TextDrawBackgroundColor		(DynProfile[playerid][3], 255);
	TextDrawFont				(DynProfile[playerid][3], 3);
	TextDrawLetterSize			(DynProfile[playerid][3], 0.490000, 1.599999);
	TextDrawColor				(DynProfile[playerid][3], -1);
	TextDrawSetOutline			(DynProfile[playerid][3], 0);
	TextDrawSetProportional		(DynProfile[playerid][3], 1);
	TextDrawSetShadow			(DynProfile[playerid][3], 0);

	new reptext[20];
	format						(reptext, 24, "REPUTATION: %i", rep);

    DynProfile[playerid][4] =
	TextDrawCreateSafe			(229.000000, 257.000000, reptext);
	TextDrawAlignment			(DynProfile[playerid][4], 2);
	TextDrawBackgroundColor		(DynProfile[playerid][4], 255);
	TextDrawFont				(DynProfile[playerid][4], 2);
	TextDrawLetterSize			(DynProfile[playerid][4], 0.190000, 0.899999);
	TextDrawColor				(DynProfile[playerid][4], 16711935);
	TextDrawSetOutline			(DynProfile[playerid][4], 0);
	TextDrawSetProportional		(DynProfile[playerid][4], 1);
	TextDrawSetShadow			(DynProfile[playerid][4], 0);

	DynProfile[playerid][5] =
	TextDrawCreateSafe			(229.000000, 284.000000, vip);
	TextDrawAlignment			(DynProfile[playerid][5], 2);
	TextDrawBackgroundColor		(DynProfile[playerid][5], 255);
	TextDrawFont				(DynProfile[playerid][5], 2);
	TextDrawLetterSize			(DynProfile[playerid][5], 0.190000, 0.899999);
	TextDrawColor				(DynProfile[playerid][5], 16777215);
	TextDrawSetOutline			(DynProfile[playerid][5], 0);
	TextDrawSetProportional		(DynProfile[playerid][5], 1);
	TextDrawSetShadow			(DynProfile[playerid][5], 0);

    DynProfile[playerid][6] =
	TextDrawCreateSafe			(229.000000, 311.000000, lvl);
	TextDrawAlignment			(DynProfile[playerid][6], 2);
	TextDrawBackgroundColor		(DynProfile[playerid][6], 255);
	TextDrawFont				(DynProfile[playerid][6], 2);
	TextDrawLetterSize			(DynProfile[playerid][6], 0.190000, 0.899999);
	TextDrawColor				(DynProfile[playerid][6], -16711681);
	TextDrawSetOutline			(DynProfile[playerid][6], 0);
	TextDrawSetProportional		(DynProfile[playerid][6], 1);
	TextDrawSetShadow			(DynProfile[playerid][6], 0);

	LOOP(DTD, 7) TextDrawShowForPlayer(playerid, DynProfile[playerid][DTD]);

    return true;
}

stock DestroyDynamicTextdraws(playerid)
{
    LOOP(DTD, 7) if(_:DynProfile[playerid][DTD]) TextDrawDestroy(DynProfile[playerid][DTD]);
	return true;
}

stock ShowOnlineProfileToUser(playerid, targetid, bool:ex = false)
{
	if(!Profile_ENABLED[targetid]) return SendClientMessage(playerid, -1, #PROFILE"Unable to load profile, Try later..");

	if(Profile_New[playerid])
	{
	    Profile_Background[playerid] = random((sizeof Backgrounds)-1);
	    Profile_Avatar[playerid] = random((sizeof Avatars)-1);
	    if(playerid == targetid)
	    {
	        SendClientMessage(playerid, -1, #PROFILE"Your {FFFFFF}new profile{737373},\
			we applied random Avatar & Background to it.");
			Profile_New[playerid] = false;
	    }
	}

	Profile_Currentuser[targetid] = Profile_Name[targetid];

	HideAllProfileTextDraws			(playerid);
	DestroyDynamicTextdraws			(playerid);

	LOOP_s(BTD, ProfileBase)		TextDrawShowForPlayer(playerid, ProfileBase[BTD]);
	TextDrawShowForPlayer			(playerid, CopyrightP);
	TextDrawShowForPlayer			(playerid, Backgrounds[Profile_Background[targetid]]);
	if(IsPlayerConnected(targetid))
	TextDrawShowForPlayer			(playerid, Status[1]);
	else TextDrawShowForPlayer		(playerid, Status[0]);
	TextDrawShowForPlayer			(playerid, Avatars[Profile_Avatar[targetid]]);

	LOOP_s(ETD,Elements) 			TextDrawShowForPlayer(playerid, Elements[ETD]);
	ShowRepBars						(playerid, Profile_Reputation[targetid]);
	ShowVipBars						(playerid, Profile_Viplevel[targetid]);
	ShowAdminBars					(playerid, Profile_Adminlevel[targetid]);

    if(Profile_Trusted[targetid])
	{
		TextDrawShowForPlayer(playerid,Awards[0][0]);
		TextDrawShowForPlayer(playerid,Awards[0][1]);
	}

	if(Profile_Featured[targetid])
	{
		TextDrawShowForPlayer(playerid,Awards[1][0]);
		TextDrawShowForPlayer(playerid,Awards[1][1]);
	}

	if(Profile_Pro[targetid])
	{
		TextDrawShowForPlayer(playerid,Awards[2][0]);
		TextDrawShowForPlayer(playerid,Awards[2][1]);
	}

	DynamicTextdraws
	(
		playerid,
		Profile_Name[targetid],
		Profile_Info[targetid],
		Profile_Registerdate[targetid],
		"Online Now",
		Profile_Reputation[targetid],
		Profile_Viptext[targetid],
		Profile_Admintext[targetid]
	);

	if(ex) return true;
	if(playerid == targetid)
	{
		SendClientMessage(playerid, -1, #PROFILE "You are currently viewing your own profile");
        SendClientMessage(playerid, -1, "{737373}> Modify: Background -{FFFFFF}/profileBG{737373} and Avatar - {FFFFFF}/profileAV");
        return true;
	}

	format(PROFILE_STRING, sizeof PROFILE_STRING, #PROFILE "You are currently viewing {FFFFFF}%s{737373}'s Profile",
	Profile_Name[targetid]); SendClientMessage(playerid, -1, PROFILE_STRING);
	return true;
}

stock ShowOfflineProfileToUser(playerid, targetname[])
{
	format(PROFILE_STRING, sizeof PROFILE_STRING, USER_DIRECTORY, targetname);
    if(!DOF2_FileExists(PROFILE_STRING)) return SendClientMessage(playerid, -1,
	"[PROFILE ERROR] User profile doesn't exist");

	new BG, AV, RP, VP, LV, TR, FT, PR,
	VIPTEXT[20], ADMINTEXT[20], INFO[256], REGDATE[20], LASTACTIVE[20];

    DOF2_GetStringEx(PROFILE_STRING, INFO_key, 		INFO, 		256);
    DOF2_GetStringEx(PROFILE_STRING, VIPTEXT_key, 	VIPTEXT, 	 20);
    DOF2_GetStringEx(PROFILE_STRING, LVLTEXT_key, 	ADMINTEXT, 	 20);
    DOF2_GetStringEx(PROFILE_STRING, REGDATE_key, 	REGDATE,	 20);
	DOF2_GetStringEx(PROFILE_STRING, LASTACTIVE_key,LASTACTIVE,	 20);

    BG 	= DOF2_GetInt(PROFILE_STRING, BG_key);
    AV 	= DOF2_GetInt(PROFILE_STRING, AV_key);
    RP 	= DOF2_GetInt(PROFILE_STRING, REP_key);
    VP 	= DOF2_GetInt(PROFILE_STRING, VIP_key);
    LV 	= DOF2_GetInt(PROFILE_STRING, LVL_key);
    TR  = DOF2_GetBool(PROFILE_STRING, TRUSTED_key);
    FT  = DOF2_GetBool(PROFILE_STRING, FEATURED_key);
    PR  = DOF2_GetBool(PROFILE_STRING, PRO_key);
    
    if(ExceedsIndex(BG, Backgrounds))
	{
		SendClientMessage(playerid, -1, #PROFILE" Unable to load profile. (Invalid Background)");
		printf("[Profile System] User %s seems to have an Invalid Background ID", targetname);
		return false;
	}
	
	if(ExceedsIndex(AV, Avatars))
	{
		SendClientMessage(playerid, -1, #PROFILE" Unable to load profile. (Invalid Avatar)");
		printf("[Profile System] User %s seems to have an Invalid Avatar ID", targetname);
		return false;
	}

	HideAllProfileTextDraws			(playerid);
	DestroyDynamicTextdraws			(playerid);

	LOOP_s(BTD, ProfileBase)		TextDrawShowForPlayer(playerid, ProfileBase[BTD]);
	TextDrawShowForPlayer			(playerid, CopyrightP);
	TextDrawShowForPlayer			(playerid, Backgrounds[BG]);
	TextDrawShowForPlayer			(playerid, Status[0]);
	TextDrawShowForPlayer			(playerid, Avatars[AV]);

	LOOP_s(ETD,Elements) 			TextDrawShowForPlayer(playerid, Elements[ETD]);
	ShowRepBars						(playerid, RP);
	ShowVipBars						(playerid, VP);
	ShowAdminBars					(playerid, LV);

	if(TR)
	{
		TextDrawShowForPlayer(playerid,Awards[0][0]);
		TextDrawShowForPlayer(playerid,Awards[0][1]);
	}
	
	if(FT)
	{
		TextDrawShowForPlayer(playerid,Awards[1][0]);
		TextDrawShowForPlayer(playerid,Awards[1][1]);
	}
	
	if(PR)
	{
		TextDrawShowForPlayer(playerid,Awards[2][0]);
		TextDrawShowForPlayer(playerid,Awards[2][1]);
	}

	DynamicTextdraws
	(
		playerid,
		targetname,
		INFO,
		REGDATE,
		LASTACTIVE,
		RP,
		VIPTEXT,
		ADMINTEXT
	);

	format(PROFILE_STRING, sizeof PROFILE_STRING, #PROFILE "You are currently viewing {FFFFFF}%s{737373}'s Profile.",
	targetname); SendClientMessage(playerid, -1, PROFILE_STRING);
	
	printf("[Profile System] User %s viewed offline profile of '%s'", Profile_Name[playerid], targetname);
	
	return true;
}

stock RefreshProfile(playerid)
{
	if(strlen(Profile_Currentuser[playerid]) && !strcmp(Profile_Currentuser[playerid], Profile_Name[playerid], true))
	ShowOnlineProfileToUser(playerid, playerid, true);
	return true;
}

stock HideProfile(playerid)
{
    DestroyDynamicTextdraws(playerid);
    HideAllProfileTextDraws(playerid);
    format(Profile_Currentuser[playerid], MAX_PLAYER_NAME, "\0");
	return true;
}

stock LoadUserProfile(playerid)
{
	GetPlayerName(playerid, Profile_Name[playerid], sizeof Profile_Name[]);
	format(PROFILE_STRING, sizeof PROFILE_STRING, USER_DIRECTORY, Profile_Name[playerid]);

	if(DOF2_FileExists(PROFILE_STRING))
	{
	    DOF2_GetStringEx(PROFILE_STRING, INFO_key, 		Profile_Info[playerid], 		256);
	    DOF2_GetStringEx(PROFILE_STRING, VIPTEXT_key, 	Profile_Viptext[playerid], 		20);
	    DOF2_GetStringEx(PROFILE_STRING, LVLTEXT_key, 	Profile_Admintext[playerid], 	20);
	    DOF2_GetStringEx(PROFILE_STRING, REGDATE_key, 	Profile_Registerdate[playerid], 20);
    	DOF2_GetStringEx(PROFILE_STRING, LASTACTIVE_key,Profile_Lastactive[playerid],	20);

	    Profile_Background[playerid] 	= DOF2_GetInt(PROFILE_STRING, BG_key);
	    Profile_Avatar[playerid] 		= DOF2_GetInt(PROFILE_STRING, AV_key);
	    Profile_Reputation[playerid] 	= DOF2_GetInt(PROFILE_STRING, REP_key);
	    Profile_Viplevel[playerid] 		= DOF2_GetInt(PROFILE_STRING, VIP_key);
	    Profile_Adminlevel[playerid] 	= DOF2_GetInt(PROFILE_STRING, LVL_key);
	    Profile_Trusted[playerid] 		= DOF2_GetBool(PROFILE_STRING, TRUSTED_key);
	    Profile_Featured[playerid] 		= DOF2_GetBool(PROFILE_STRING, FEATURED_key);
	    Profile_Pro[playerid] 			= DOF2_GetBool(PROFILE_STRING, PRO_key);

	    printf("[Profile System] Loaded profile data for %s", Profile_Name[playerid]);

	} else {
		printf("[Profile System] %s has no userfile", Profile_Name[playerid]);
		Profile_New[playerid] = true;
	}
	return true;
}

stock SaveUserProfile(playerid, reason[])
{
	if(Profile_New[playerid]) return true;
	format(PROFILE_STRING, sizeof PROFILE_STRING, USER_DIRECTORY, Profile_Name[playerid]);

	getdate(YEAR, MONTH, DAY);
	format(Profile_Lastactive[playerid], sizeof Profile_Lastactive[], "%i/%i/%i", DAY, MONTH, YEAR);

	DOF2_CreateFile	(PROFILE_STRING);
	DOF2_SetString	(PROFILE_STRING, INFO_key, 		Profile_Info[playerid]);
	DOF2_SetString	(PROFILE_STRING, REGDATE_key, 	Profile_Registerdate[playerid]);
	DOF2_SetString	(PROFILE_STRING, LASTACTIVE_key,Profile_Lastactive[playerid]);
	DOF2_SetInt		(PROFILE_STRING, BG_key, 		Profile_Background[playerid]);
	DOF2_SetInt		(PROFILE_STRING, AV_key, 		Profile_Avatar[playerid]);
	DOF2_SetInt		(PROFILE_STRING, REP_key, 		Profile_Reputation[playerid]);
	DOF2_SetInt		(PROFILE_STRING, VIP_key, 		Profile_Viplevel[playerid]);
	DOF2_SetInt		(PROFILE_STRING, LVL_key, 		Profile_Adminlevel[playerid]);
	DOF2_SetString	(PROFILE_STRING, VIPTEXT_key, 	Profile_Viptext[playerid]);
	DOF2_SetString	(PROFILE_STRING, LVLTEXT_key, 	Profile_Admintext[playerid]);
	DOF2_SetBool	(PROFILE_STRING, TRUSTED_key, 	Profile_Trusted[playerid]);
	DOF2_SetBool	(PROFILE_STRING, FEATURED_key, 	Profile_Featured[playerid]);
	DOF2_SetBool	(PROFILE_STRING, PRO_key, 		Profile_Pro[playerid]);
	DOF2_SaveFile	();

    printf("[Profile System] Saved profile data for %s (%s)", Profile_Name[playerid], reason);
	return true;
}

stock ClearProfile(playerid)
{
	format(Profile_Info[playerid], 			256, "\0");
	format(Profile_Registerdate[playerid], 	20, "\0");
	format(Profile_Lastactive[playerid], 	20, "\0");
	format(Profile_Viptext[playerid], 		20, "\0");
	format(Profile_Admintext[playerid], 	20, "\0");
	
	Profile_Background[playerid] 	= 0;
	Profile_Avatar[playerid] 		= 0;
	Profile_Reputation[playerid]	= 0;
	Profile_Viplevel[playerid] 		= 0;
	Profile_Adminlevel[playerid] 	= 0;
	Profile_Trusted[playerid] 		= false;
	Profile_Featured[playerid] 		= false;
	Profile_Pro[playerid] 			= false;
	Profile_EditMode[playerid] 		= 0;
	Profile_ENABLED[playerid] 		= false;
	Profile_Cooldown[playerid] 		= 0;
	
	KillTimer(Profile_CmdTimer[playerid]);
	return true;
}

stock HideAllProfileTextDraws(playerid)
{
    LOOP_s(ATD,Avatars) 		TextDrawHideForPlayer(playerid, Avatars[ATD]);
    LOOP_s(BTD,Backgrounds)		TextDrawHideForPlayer(playerid, Backgrounds[BTD]);
	LOOP_s(STD,Status)			TextDrawHideForPlayer(playerid, Status[STD]);
 	LOOP_s(ETD,Elements)		TextDrawHideForPlayer(playerid, Elements[ETD]);
	LOOP_s(RTD,RepBars)			TextDrawHideForPlayer(playerid, RepBars[RTD]);
	LOOP_s(VTD,VipBars)			TextDrawHideForPlayer(playerid, VipBars[VTD]);
	LOOP_s(LTD,LevelBars)		TextDrawHideForPlayer(playerid, LevelBars[LTD]);
	LOOP_s(BTD,ProfileBase)		TextDrawHideForPlayer(playerid, ProfileBase[BTD]);
	LOOP_s(ETD, EditArrows)		TextDrawHideForPlayer(playerid, EditArrows[ETD]);
	LOOP_s(ATD, Awards)
	{
		TextDrawHideForPlayer(playerid,Awards[ATD][0]);
		TextDrawHideForPlayer(playerid,Awards[ATD][1]);
	}
	TextDrawHideForPlayer		(playerid, CopyrightP);
	return true;
}

stock DestroyAllProfileTextDraws()
{
    LOOP_s(ATD,Avatars)			TextDrawDestroy(Avatars[ATD]);
    LOOP_s(BTD,Backgrounds)		TextDrawDestroy(Backgrounds[BTD]);
	LOOP_s(STD,Status)			TextDrawDestroy(Status[STD]);
	LOOP_s(ETD,Elements)		TextDrawDestroy(Elements[ETD]);
	LOOP_s(RTD,RepBars)			TextDrawDestroy(RepBars[RTD]);
	LOOP_s(VTD,VipBars)			TextDrawDestroy(VipBars[VTD]);
	LOOP_s(LTD,LevelBars)		TextDrawDestroy(LevelBars[LTD]);
	LOOP  (PTD,MAX_PLAYERS)     DestroyDynamicTextdraws(PTD);
    LOOP_s(BTD,ProfileBase)		TextDrawDestroy(ProfileBase[BTD]);
    LOOP_s(ETD,EditArrows)		TextDrawDestroy(EditArrows[ETD]);
    LOOP_s(ATD,Awards)
	{
		TextDrawDestroy(Awards[ATD][0]);
		TextDrawDestroy(Awards[ATD][1]);
	}
	TextDrawDestroy				(CopyrightP);
	return true;
}

stock AvatarEditArrows(playerid)
{
    TextDrawShowForPlayer(playerid, EditArrows[0]);
 	TextDrawShowForPlayer(playerid, EditArrows[1]);
 	
 	if(Profile_Avatar[playerid] == 1)
	 TextDrawHideForPlayer(playerid, EditArrows[0]);
	 
    if(Profile_Avatar[playerid] == (sizeof Avatars)-1)
	TextDrawHideForPlayer(playerid, EditArrows[1]);
	return true;
}

stock BackgroundEditArrows(playerid)
{
    TextDrawShowForPlayer(playerid, EditArrows[2]);
	TextDrawShowForPlayer(playerid, EditArrows[3]);
	
	if(Profile_Background[playerid] == 1)
	TextDrawHideForPlayer(playerid, EditArrows[2]);
	
	if(Profile_Background[playerid] == (sizeof Backgrounds)-1)
	TextDrawHideForPlayer(playerid, EditArrows[3]);
	return true;
}

/*============================================================================*/
// FILTERSCRIPT CALLBACKS


forward Profile_SetTrusted(playerid, bool:set);
public Profile_SetTrusted(playerid, bool:set)
{
    if(set)
	SendClientMessage(playerid, -1, #PROFILE"You have been awarded the tag: {111111}[{00FFAA}Trusted Member{111111}]");
	else
	SendClientMessage(playerid, -1, #PROFILE"\"{FFFFFF}Trusted Member{737373}\" tag has been removed from your profile");
 	PlayerPlaySound(playerid, 1057, 0, 0, 0);
	Profile_Trusted[playerid] = set;
	RefreshProfile(playerid);
	return true;
}

forward Profile_SetFeatured(playerid, bool:set);
public Profile_SetFeatured(playerid, bool:set)
{
    if(set)
    SendClientMessage(playerid, -1, #PROFILE"You have been awarded the tag: {111111}[{FFBB00}Featured Member{111111}]");
    else
	SendClientMessage(playerid, -1, #PROFILE"\"{FFFFFF}Featured Member{737373}\" tag has been removed from your profile");
	PlayerPlaySound(playerid, 1057, 0, 0, 0);
    Profile_Featured[playerid] = set;
    RefreshProfile(playerid);
	return true;
}

forward Profile_SetPro(playerid, bool:set);
public Profile_SetPro(playerid, bool:set)
{
    if(set)
    SendClientMessage(playerid, -1, #PROFILE"You have been awarded the tag: {111111}[{FF0000}PRO{111111}]");
    else
	SendClientMessage(playerid, -1, #PROFILE"\"{FFFFFF}PRO{737373}\" tag has been removed from your profile");
 	PlayerPlaySound(playerid, 1057, 0, 0, 0);
    Profile_Pro[playerid] = set;
    RefreshProfile(playerid);
	return true;
}

forward Profile_GiveRep(playerid, value);
public Profile_GiveRep(playerid, value)
{
    Profile_Reputation[playerid] += value;
    RefreshProfile(playerid);
	return true;
}

forward Profile_GetRep(playerid);
public Profile_GetRep(playerid)
{
    return Profile_Reputation[playerid];
}

forward Profile_SetVip(playerid, bars, status[]);
public Profile_SetVip(playerid, bars, status[])
{
    Profile_Viplevel[playerid] = bars;
    format(Profile_Viptext[playerid], 20, status);
    RefreshProfile(playerid);
	return true;
}

forward Profile_SetAdminLevel(playerid, bars, status[]);
public Profile_SetAdminLevel(playerid, bars, status[])
{
    Profile_Adminlevel[playerid] = bars;
    format(Profile_Admintext[playerid], 20, status);
    RefreshProfile(playerid);
	return true;
}

forward Profile_SetRegisterDate(playerid, date[]);
public Profile_SetRegisterDate(playerid, date[])
{
    format(Profile_Registerdate[playerid], 20, date);
    RefreshProfile(playerid);
	return true;
}

forward Profile_SetInfo(playerid, text[]);
public Profile_SetInfo(playerid, text[])
{
    InfoFormat(text);
    format(Profile_Info[playerid], 256, text);
    RefreshProfile(playerid);
	return true;
}

/*============================================================================*/
// NATIVE CALLBACKS

public OnFilterScriptInit()
{
    CreateTextdraws();
    
    LOOP(PID,MAX_PLAYERS) if(IsPlayerConnected(PID))
	{
		if(GetPlayerState(PID))
		{
			LoadUserProfile(PID);
			if(GetPlayerState(PID)) if(!Profile_New[PID]) Profile_ENABLED[PID] = true;
		}
    }
    
    printf("[Profile System] > LOADED < (c) iPLEOMAX");
    
    return true;
}

public OnFilterScriptExit()
{
	LOOP(PID,MAX_PLAYERS) if(Profile_ENABLED[PID]) SaveUserProfile(PID, "Unloadfs");
	
	DOF2_Exit();
    if(DestroyAllProfileTextDraws())
	printf("[Profile System] Successfully destroyed all textdraws.");
    printf("[Profile System] > EXITED <");
    return true;
}

public OnPlayerConnect(playerid)
{
    GetPlayerName(playerid, Profile_Name[playerid], MAX_PLAYER_NAME);
    return true;
}

public OnPlayerSpawn(playerid)
{
    if(!Profile_ENABLED[playerid])
	{
		Profile_ENABLED[playerid] = true;
		LoadUserProfile(playerid);
	}
	return true;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	switch(Profile_EditMode[playerid])
	{
	    case EDITMODE_AVATAR:
	    {
	        AvatarEditArrows(playerid);
	        
	        if(newkeys & 8192)
	        {
	            LOOP_s(ATD,Avatars) if(_:Avatars[ATD] != 0)
				TextDrawHideForPlayer(playerid, Avatars[ATD]);
				
	            if((Profile_Avatar[playerid]-1) > 0)
	            Profile_Avatar[playerid] -= 1;
	            
	            TextDrawShowForPlayer(playerid, Avatars[Profile_Avatar[playerid]]);

	        } else
	        
			if(newkeys & 16384)
	        {
	            LOOP_s(ATD,Avatars) if(_:Avatars[ATD] != 0)
				TextDrawHideForPlayer(playerid, Avatars[ATD]);
				
	            if((Profile_Avatar[playerid]+1) < sizeof Avatars)
	            Profile_Avatar[playerid] += 1;
	            
	            TextDrawShowForPlayer(playerid, Avatars[Profile_Avatar[playerid]]);
	        }
	        if(!Profile_EditMode[playerid]) HideProfile(playerid);
	    }
	    case EDITMODE_BACKGROUND:
	    {
	        BackgroundEditArrows(playerid);
	        
	        if(newkeys & 8192)
	        {
	            LOOP_s(BTD,Backgrounds) if(_:Backgrounds[BTD] != 0)
				TextDrawHideForPlayer(playerid, Backgrounds[BTD]);
				
	            if((Profile_Background[playerid]-1) > 0)
	            Profile_Background[playerid] -= 1;
	            
	            TextDrawShowForPlayer(playerid, Backgrounds[Profile_Background[playerid]]);

	        } else
	        
			if(newkeys & 16384)
	        {
	            LOOP_s(BTD,Backgrounds) if(_:Backgrounds[BTD] != 0)
				TextDrawHideForPlayer(playerid, Backgrounds[BTD]);
				
	            if((Profile_Background[playerid]+1) < sizeof Backgrounds)
	            Profile_Background[playerid] += 1;
	            
	            TextDrawShowForPlayer(playerid, Backgrounds[Profile_Background[playerid]]);
	        }
	        if(!Profile_EditMode[playerid]) HideProfile(playerid);
	    }
	}
	return true;
}

public OnPlayerDisconnect(playerid, reason)
{
	SaveUserProfile(playerid, "Disconnect");
	HideProfile(playerid);
	ClearProfile(playerid);
    return true;
}

stock CommandSpamCheck(playerid)
{
    if(Profile_Cooldown[playerid] >= 6)
	{
	    KillTimer(Profile_CmdTimer[playerid]);
	    Profile_Cooldown[playerid] = 6;
		SendClientMessage(playerid, -1, #PROFILE"Profile Commands are disabled for you. (Reason: Spam)");
		return false;
	}
	Profile_Cooldown[playerid] += 1;
	if(Profile_Cooldown[playerid] >= 2)
	{
		SendClientMessage(playerid, -1, #PROFILE"Don't spam commands, Wait before using again.");
		return false;
	}
	KillTimer(Profile_CmdTimer[playerid]);
	Profile_CmdTimer[playerid] = SetTimerEx("Reset_Cooldown", 2000, false, "d", playerid);
	return true;
}

forward Reset_Cooldown(playerid);
public Reset_Cooldown(playerid)
{
    Profile_Cooldown[playerid] = 0;
	return true;
}

/*============================================================================*/
// USER COMMANDS

CMD:showprofile(playerid, params[]) return cmd_profile(playerid, params);
CMD:myprofile(playerid, params[]) return cmd_profile(playerid, "");
CMD:profile(playerid, params[])
{
    if(!CommandSpamCheck(playerid)) return true;
    
	if(isnull(params)) return ShowOnlineProfileToUser(playerid, playerid);
	
    new bool:res;
	for(new user; user < MAX_PLAYERS; user++)
	{
	    if(!IsPlayerConnected(user)) continue;
	    if(strfind(Profile_Name[user], params, true) != -1)
	    {
	        ShowOnlineProfileToUser(playerid, user);
	        res = true;
	        break;
	    }
	}
	if(!res) ShowOfflineProfileToUser(playerid, params);
	return true;
}

CMD:profilec(playerid, params[]) return cmd_cprofile(playerid, params);
CMD:closeprofile(playerid, params[]) return cmd_cprofile(playerid, params);
CMD:cprofile(playerid, params[])
{
    if(!CommandSpamCheck(playerid)) return true;
    
	Profile_EditMode[playerid] = false;
    HideProfile(playerid);
	return true;
}

CMD:profilebackground(playerid, params[]) return cmd_profilebg(playerid, params);
CMD:profilebg(playerid, params[])
{
    if(!CommandSpamCheck(playerid)) return true;
    
    Profile_EditMode[playerid] = EDITMODE_BACKGROUND;
    ShowOnlineProfileToUser(playerid, playerid, true);
    BackgroundEditArrows(playerid);
	SendClientMessage(playerid, -1, #PROFILE"Now you can change the {FFFFFF}Background{737373} using Numpad 4 or 6.");
	return true;
}

CMD:profileavatar(playerid, params[]) return cmd_profileav(playerid, params);
CMD:profileav(playerid, params[])
{
    if(!CommandSpamCheck(playerid)) return true;
    
    Profile_EditMode[playerid] = EDITMODE_AVATAR;
    ShowOnlineProfileToUser(playerid, playerid, true);
    AvatarEditArrows(playerid);
	SendClientMessage(playerid, -1, #PROFILE"Now you can change the {FFFFFF}Avatar{737373} using Numpad 4 or 6.");
	return true;
}

CMD:sprofile(playerid, params[]) return cmd_profilesave(playerid, params);
CMD:saveprofile(playerid, params[]) return cmd_profilesave(playerid, params);
CMD:profilesave(playerid, params[])
{
    if(!CommandSpamCheck(playerid)) return true;
    
    SaveUserProfile(playerid, "User command");
    SendClientMessage(playerid, -1, #PROFILE"Your profile has been saved. (Profiles autosave on disconnect)");
	return true;
}

CMD:myinfo(playerid, params[])
{
    if(!CommandSpamCheck(playerid)) return true;
    
	if(!Profile_SetInfo(playerid, params)) SendClientMessage(playerid, -1, PROFILE_ERROR);
	else SendClientMessage(playerid, -1, #PROFILE"You're new info has been updated.");
	return true;
}

/*============================================================================*/
// *NOOBISH* STOCKS

stock ShowAdminBars(playerid, input)
{
	if(input >= 1) TextDrawShowForPlayer(playerid, LevelBars[0]);
	if(input >= 2) TextDrawShowForPlayer(playerid, LevelBars[1]);
	if(input >= 3) TextDrawShowForPlayer(playerid, LevelBars[2]);
	if(input >= 4) TextDrawShowForPlayer(playerid, LevelBars[3]);
	if(input >= 5) TextDrawShowForPlayer(playerid, LevelBars[4]);
	return true;
}

stock ShowVipBars(playerid, input)
{
	if(input >= 1) TextDrawShowForPlayer(playerid, VipBars[0]);
	if(input >= 2) TextDrawShowForPlayer(playerid, VipBars[1]);
	if(input >= 3) TextDrawShowForPlayer(playerid, VipBars[2]);
	if(input >= 4) TextDrawShowForPlayer(playerid, VipBars[3]);
	if(input >= 5) TextDrawShowForPlayer(playerid, VipBars[4]);
	return true;
}

stock ShowRepBars(playerid, input)
{
	if(input >= 10) 	TextDrawShowForPlayer(playerid, RepBars[0]);
	if(input >= 150) 	TextDrawShowForPlayer(playerid, RepBars[1]);
	if(input >= 350) 	TextDrawShowForPlayer(playerid, RepBars[2]);
	if(input >= 650) 	TextDrawShowForPlayer(playerid, RepBars[3]);
	if(input >= 1000)	TextDrawShowForPlayer(playerid, RepBars[4]);
	return true;
}

stock InfoFormat(string[])
{
	format(PROFILE_STRING, sizeof PROFILE_STRING, string);
	
    for(new pos=0; pos < strlen(PROFILE_STRING); pos++)
	if(PROFILE_STRING[pos] == '~') PROFILE_STRING[pos] = '_';

	new line_c = -3;
	for(new pos=0; pos < strlen(PROFILE_STRING); pos++)
	{
	    if(PROFILE_STRING[pos] >= 'A' && PROFILE_STRING[pos] <= 'Z') line_c++;
	    if(line_c >= 30) { strins(PROFILE_STRING, "~n~", pos); line_c = 0; }
	    line_c++;
	}
	
	format(string, 256, PROFILE_STRING);
}

/*============================================================================*/
// END OF FILE
