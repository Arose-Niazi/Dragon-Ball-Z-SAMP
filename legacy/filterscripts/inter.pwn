#include <a_samp>
#define FILTERSCRIPT
#if defined FILTERSCRIPT

// ---> Menu's

new Menu: HIMenu;
new Menu: MenuCharac;
new Menu: MenuGirlfr;
new Menu: MenuRestBar;
new Menu: MenuShopAmmu;
new Menu: MenuShopAmmu2;
new Menu: MenuCasino;
new Menu: MenuStrip;
new Menu: MenuIndus;
new Menu: MenuIndus2;
new Menu: MenuStadium;
new Menu: MenuStadium2;
new Menu: MenuSafehouse;
new Menu: MenuSafehouse2;
new Menu: MenuAirLC;
new Menu: MenuBurglary;
new Menu: MenuBurglary2;

public OnFilterScriptInit()
{
	print("\n---------------------------------");
	print(" Basss' Hidden Interior Explorer");
	print("---------------------------------\n");
	
	CreateObject(8171,449,-53,998.56,0,180,0);     // Floor Rusty Browns Ring Donuts Diner & Small Restaurant
	CreateObject(8171,-1860,54,1054.2,0,180,90);   // Floor Los Santos Terminal
	CreateObject(8171,2220,1620,1042.42,0,180,90); // Floor Caligula's Office

	// --------------------------------------------------------------------------> Menu

    HIMenu = CreateMenu("Basss' Hidden Interior Explorer!",1,150,150,450,450);
    AddMenuItem(HIMenu,0,"Houses from Characters");      // MenuCharac
    AddMenuItem(HIMenu,0,"Houses from Girlfriends");     // MenuGirlfr
    AddMenuItem(HIMenu,0,"Restaurants & Bars");          // MenuRestbar
    AddMenuItem(HIMenu,0,"Shops & Ammu-Nations");        // MenuShopAmmu
    AddMenuItem(HIMenu,0,"Casino's & Business");         // MenuCasino
    AddMenuItem(HIMenu,0,"Stripclubs & Brothels");       // MenuStrip
    AddMenuItem(HIMenu,0,"Commercial & Industrial");     // MenuIndus
    AddMenuItem(HIMenu,0,"Stadiums, Gyms & Garages");    // MenuStadium
    AddMenuItem(HIMenu,0,"Safehouses");                  // MenuSafehouse
    AddMenuItem(HIMenu,0,"Aircraft & Liberty City");     // MenuAirLC
    AddMenuItem(HIMenu,0,"Burglary Houses");             // MenuBurglary
    
    // --------------------------------------------------------------------------> Houses from Characters
    
 	MenuCharac = CreateMenu("Houses from Characters",1,150,150,400,400);
 	AddMenuItem(MenuCharac,0,"B Dup's Appartement");
 	AddMenuItem(MenuCharac,0,"B Dup's Crack Palace");
 	AddMenuItem(MenuCharac,0,"Big Smoke's Crack Palace");
 	AddMenuItem(MenuCharac,0,"Colonel Fuhrberger's House");
 	AddMenuItem(MenuCharac,0,"Madd Dogg's Mansion East");
 	AddMenuItem(MenuCharac,0,"Madd Dogg's Mansion West");
 	AddMenuItem(MenuCharac,0,"OG Loc's House");
 	AddMenuItem(MenuCharac,0,"Ryder's Place");
 	AddMenuItem(MenuCharac,0,"Sweet's House");
 	AddMenuItem(MenuCharac,0,"Wu Zi Mu's Crib");
 	
 	// --------------------------------------------------------------------------> Houses from Girlfriends
 	
 	MenuGirlfr = CreateMenu("Houses from Girlfriends",1,150,150,400,400);
 	AddMenuItem(MenuGirlfr,0,"Barbara's House");
 	AddMenuItem(MenuGirlfr,0,"Denise's House");
 	AddMenuItem(MenuGirlfr,0,"Helena's House");
 	AddMenuItem(MenuGirlfr,0,"Katie's House");
 	AddMenuItem(MenuGirlfr,0,"Michelle's House");
 	AddMenuItem(MenuGirlfr,0,"Millie's House");
 	
 	// --------------------------------------------------------------------------> Restaurants & Bars
 	
 	MenuRestBar = CreateMenu("Restaurants and Bars",1,150,150,400,400);
	AddMenuItem(MenuRestBar,0,"Burger Shot");
 	AddMenuItem(MenuRestBar,0,"Clucking' Bell");
 	AddMenuItem(MenuRestBar,0,"Diner");
 	AddMenuItem(MenuRestBar,0,"Jim's Sticky Ring");
 	AddMenuItem(MenuRestBar,0,"Lil' Probe'Inn");
 	AddMenuItem(MenuRestBar,0,"Red Restaurant");
 	AddMenuItem(MenuRestBar,0,"Rusty Browns Ring Donuts");
 	AddMenuItem(MenuRestBar,0,"Small Restaurant");
 	AddMenuItem(MenuRestBar,0,"The Bar");
 	AddMenuItem(MenuRestBar,0,"The Welcome Pump");
 	AddMenuItem(MenuRestBar,0,"Well Stacked Pizza");
 	
 	// --------------------------------------------------------------------------> Shops, Hotels & Motels
 	
 	MenuShopAmmu = CreateMenu("Shops and Ammunations",1,150,150,400,400);
 	AddMenuItem(MenuShopAmmu,0,"Ammu-Nation 1");
 	AddMenuItem(MenuShopAmmu,0,"Ammu-Nation 2");
 	AddMenuItem(MenuShopAmmu,0,"Ammu-Nation 3");
 	AddMenuItem(MenuShopAmmu,0,"Ammu-Nation 4");
 	AddMenuItem(MenuShopAmmu,0,"Ammu-Nation 5");
 	AddMenuItem(MenuShopAmmu,0,"Barber");
 	AddMenuItem(MenuShopAmmu,0,"Bingo");
 	AddMenuItem(MenuShopAmmu,0,"Didier Sachs");
 	AddMenuItem(MenuShopAmmu,0,"ProLaps");
 	AddMenuItem(MenuShopAmmu,0,"Macisla Unisex Hair Salon");
 	AddMenuItem(MenuShopAmmu,0,"Reeces Hair Facial Studio");
 	AddMenuItem(MenuShopAmmu,0,">>> Page 2 <<<");
 	
 	MenuShopAmmu2 = CreateMenu("Shops and Ammunations 2",1,150,150,400,400);
	AddMenuItem(MenuShopAmmu2,0,"Sex Shop");
 	AddMenuItem(MenuShopAmmu2,0,"Sub Urban");
 	AddMenuItem(MenuShopAmmu2,0,"Tattoo Los Santos");
 	AddMenuItem(MenuShopAmmu2,0,"Tattoo San Fierro");
 	AddMenuItem(MenuShopAmmu2,0,"Tattoo Las Venturas");
 	AddMenuItem(MenuShopAmmu2,0,"Victim");
 	AddMenuItem(MenuShopAmmu2,0,"Zero's RC Shop");
 	AddMenuItem(MenuShopAmmu2,0,"ZIP");
 	
 	// --------------------------------------------------------------------------> Casino's & Business
 	
 	MenuCasino = CreateMenu("Casino's and Business",1,150,150,400,400);
 	AddMenuItem(MenuCasino,0,"Caligula's Casino");
 	AddMenuItem(MenuCasino,0,"Caligula's Office");
 	AddMenuItem(MenuCasino,0,"Caligula's Penthouse Suites");
 	AddMenuItem(MenuCasino,0,"Caligula's Storage");
 	AddMenuItem(MenuCasino,0,"Inside Track Betting Shop");
 	AddMenuItem(MenuCasino,0,"The Casino");
 	AddMenuItem(MenuCasino,0,"The Four Dragons Casino");
	AddMenuItem(MenuCasino,0,"The Four Dragons Janitor Room");
	AddMenuItem(MenuCasino,0,"The Four Dragons Managment Room");
 	
 	// --------------------------------------------------------------------------> Stripclubs & Disco's
 	
 	MenuStrip = CreateMenu("Stripclubs and Disco's",1,150,150,400,400);
 	AddMenuItem(MenuStrip,0,"Brothel 1");
 	AddMenuItem(MenuStrip,0,"Brothel 2");
 	AddMenuItem(MenuStrip,0,"Brothel 3");
 	AddMenuItem(MenuStrip,0,"Disco");
 	AddMenuItem(MenuStrip,0,"Jizzy's Pleasure Domes");
 	AddMenuItem(MenuStrip,0,"The Big Spread Ranch");
 	AddMenuItem(MenuStrip,0,"The Pig Pen");
 	
 	// --------------------------------------------------------------------------> Factories & Warehouses
 	
 	MenuIndus = CreateMenu("Commercial and Industrial",1,150,150,400,400);
 	AddMenuItem(MenuIndus,0,"24/7 Supermarket 1");
 	AddMenuItem(MenuIndus,0,"24/7 Supermarket 2");
 	AddMenuItem(MenuIndus,0,"24/7 Supermarket 3");
 	AddMenuItem(MenuIndus,0,"24/7 Supermarket 4");
 	AddMenuItem(MenuIndus,0,"24/7 Supermarket 5");
 	AddMenuItem(MenuIndus,0,"24/7 Supermarket 6");
 	AddMenuItem(MenuIndus,0,"Area 69");
 	AddMenuItem(MenuIndus,0,"Atrium");
 	AddMenuItem(MenuIndus,0,"Bike School");
 	AddMenuItem(MenuIndus,0,"Driving School");
 	AddMenuItem(MenuIndus,0,"Jefferson Motel");
 	AddMenuItem(MenuIndus,0,">>> Page 2 <<<");
 	
 	MenuIndus2 = CreateMenu("Commercial and Industrial 2",1,150,150,400,400);
 	AddMenuItem(MenuIndus2,0,"Las Venturas Police Department");
 	AddMenuItem(MenuIndus2,0,"Los Santos Police Department");
	AddMenuItem(MenuIndus2,0,"Planning Department");
	AddMenuItem(MenuIndus2,0,"Blastin' Fools Records");
 	AddMenuItem(MenuIndus2,0,"San Fierro Police Department");
 	AddMenuItem(MenuIndus2,0,"Sherman Dam Generator Hall");
 	AddMenuItem(MenuIndus2,0,"Sindacco Abattoir");
 	AddMenuItem(MenuIndus2,0,"U Get Inn Motel");
 	AddMenuItem(MenuIndus2,0,"Warehouse 1");
 	AddMenuItem(MenuIndus2,0,"Warehouse 2");
 	AddMenuItem(MenuIndus2,0,"Warehouse LV");
 	
 	// --------------------------------------------------------------------------> Stadiums & Garages
 	
 	MenuStadium = CreateMenu("Stadiums, Gyms and Garages",1,150,150,400,400);
 	AddMenuItem(MenuStadium,0,"8-Track Stadium");
 	AddMenuItem(MenuStadium,0,"Ammu-Nation Garage");
 	AddMenuItem(MenuStadium,0,"Below the Belt Gym");
 	AddMenuItem(MenuStadium,0,"Bloodring Stadium");
 	AddMenuItem(MenuStadium,0,"Cobra Marital Arts");
 	AddMenuItem(MenuStadium,0,"Dirttrack Stadium");
 	AddMenuItem(MenuStadium,0,"Doherty Garage");
 	AddMenuItem(MenuStadium,0,"Ganton Gym");
 	AddMenuItem(MenuStadium,0,"Gas Station Dillimore");
 	AddMenuItem(MenuStadium,0,"Hotring Stadium");
 	AddMenuItem(MenuStadium,0,"Hyman Memorial Stadium (VC)");
 	AddMenuItem(MenuStadium,0,">>> Page 2 <<<");
 	
	MenuStadium2 = CreateMenu("Stadiums, Gyms and Garages 2",1,150,150,400,400);
	AddMenuItem(MenuStadium2,0,"Kickstart Stadium");
 	AddMenuItem(MenuStadium2,0,"Loco Low Co.");
 	AddMenuItem(MenuStadium2,0,"Michelle's Garage");
 	AddMenuItem(MenuStadium2,0,"San Fierro Bomb Shop");
 	AddMenuItem(MenuStadium2,0,"Sumo Stadium");
 	AddMenuItem(MenuStadium2,0,"Sweet's Garage");
 	AddMenuItem(MenuStadium2,0,"Transfender");
 	AddMenuItem(MenuStadium2,0,"Wheel Arch Angels");
 	
 	// --------------------------------------------------------------------------> Safehouses
 	
 	MenuSafehouse = CreateMenu("Safehouses",1,150,150,400,400);
 	AddMenuItem(MenuSafehouse,0,"Abandoned Airport Safehouse");
 	AddMenuItem(MenuSafehouse,0,"Angel Pine Trailer");
 	AddMenuItem(MenuSafehouse,0,"Hashbury Safehouse");
 	AddMenuItem(MenuSafehouse,0,"Jefferson Safehouse 1");
 	AddMenuItem(MenuSafehouse,0,"Jefferson Safehouse 2");
 	AddMenuItem(MenuSafehouse,0,"Johnson House");
 	AddMenuItem(MenuSafehouse,0,"Modern Safehouse");
 	AddMenuItem(MenuSafehouse,0,"Prickle Pine Safehouse");
	AddMenuItem(MenuSafehouse,0,"Vank Hoff Hotel Suite");
 	AddMenuItem(MenuSafehouse,0,">>> Page 2 <<<");
 	
 	MenuSafehouse2 = CreateMenu("Safehouses 2",1,150,150,400,400);
 	AddMenuItem(MenuSafehouse2,0,"Safehouse 1");
 	AddMenuItem(MenuSafehouse2,0,"Safehouse 2");
 	AddMenuItem(MenuSafehouse2,0,"Safehouse 3");
 	AddMenuItem(MenuSafehouse2,0,"Safehouse 4");
 	AddMenuItem(MenuSafehouse2,0,"Safehouse 5");
 	AddMenuItem(MenuSafehouse2,0,"Safehouse 6");
 	AddMenuItem(MenuSafehouse2,0,"Safehouse 7");
 	
 	// --------------------------------------------------------------------------> Aircraft & Liberty City
 	
 	MenuAirLC = CreateMenu("Aircraft and Liberty City",1,150,150,400,400);
 	AddMenuItem(MenuAirLC,0,"Andromada");
 	AddMenuItem(MenuAirLC,0,"Francis Bagage Terminal");
 	AddMenuItem(MenuAirLC,0,"Francis Front Building");
 	AddMenuItem(MenuAirLC,0,"Liberty City");
 	AddMenuItem(MenuAirLC,0,"Los Santos Terminal Inside");
 	AddMenuItem(MenuAirLC,0,"Los Santos Terminal Roof");
 	AddMenuItem(MenuAirLC,0,"Saint Marco's Bistro");
 	AddMenuItem(MenuAirLC,0,"Shamal");
 	
 	// --------------------------------------------------------------------------> Burglary Houses
 	
 	MenuBurglary = CreateMenu("Burglary Houses",1,150,150,400,400);
 	AddMenuItem(MenuBurglary,0,"Burglary House 1 (Small)");
 	AddMenuItem(MenuBurglary,0,"Burglary House 2 (Small)");
 	AddMenuItem(MenuBurglary,0,"Burglary House 3 (Medium)");
 	AddMenuItem(MenuBurglary,0,"Burglary House 4 (Large)");
 	AddMenuItem(MenuBurglary,0,"Burglary House 5 (Large)");
 	AddMenuItem(MenuBurglary,0,"Burglary House 6 (Large)");
 	AddMenuItem(MenuBurglary,0,"Burglary House 7 (Medium)");
 	AddMenuItem(MenuBurglary,0,"Burglary House 8 (Medium)");
 	AddMenuItem(MenuBurglary,0,"Burglary House 9 (Medium)");
 	AddMenuItem(MenuBurglary,0,"Burglary House 10 (Large)");
 	AddMenuItem(MenuBurglary,0,"Burglary House 11 (Huge)");
 	AddMenuItem(MenuBurglary,0,">>> Page 2 <<<");
 	
 	MenuBurglary2 = CreateMenu("Burglary Houses 2",1,150,150,400,400);
 	AddMenuItem(MenuBurglary2,0,"Burglary House 12 (Large)");
 	AddMenuItem(MenuBurglary2,0,"Burglary House 13 (Medium)");
 	AddMenuItem(MenuBurglary2,0,"Burglary House 14 (Medium)");
 	AddMenuItem(MenuBurglary2,0,"Burglary House 15 (Large)");
 	AddMenuItem(MenuBurglary2,0,"Burglary House 16 (Medium)");
 	AddMenuItem(MenuBurglary2,0,"Burglary House 17 (Large)");
 	AddMenuItem(MenuBurglary2,0,"Burglary House 18 (Medium)");
 	AddMenuItem(MenuBurglary2,0,"Burglary House 19 (Medium)");
 	AddMenuItem(MenuBurglary2,0,"Burglary House 20 (Medium)");
 	AddMenuItem(MenuBurglary2,0,"Burglary House 21 (Medium)");
 	AddMenuItem(MenuBurglary2,0,"Burglary House 22 (Medium)");
 	AddMenuItem(MenuBurglary2,0,"Burglary House 23 (Huge)");
 	
 	// -------------------------------------------------------------------------->
 	
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    // --------------------------------------------------------------------------> Lijst command

	if (strcmp("/hilist",cmdtext,true,10) == 0)
	{
		TogglePlayerControllable(playerid,0);
		ShowMenuForPlayer(HIMenu,playerid);
		return 1;
	}
	
	// -------------------------------------------------------------------------->
	
	return 0;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
    TogglePlayerControllable(playerid, 1);
	SetCameraBehindPlayer(playerid);
	new Menu:Current = GetPlayerMenu(playerid);
	
	// --------------------------------------------------------------------------> Hidden Interior Menu

	if (Current == HIMenu)
	{
		switch(row)
		{
			case 0:  {ShowMenuForPlayer(MenuCharac,playerid);    TogglePlayerControllable(playerid,0);}
			case 1:  {ShowMenuForPlayer(MenuGirlfr,playerid);    TogglePlayerControllable(playerid,0);}
			case 2:  {ShowMenuForPlayer(MenuRestBar,playerid);   TogglePlayerControllable(playerid,0);}
			case 3:  {ShowMenuForPlayer(MenuShopAmmu,playerid);  TogglePlayerControllable(playerid,0);}
			case 4:  {ShowMenuForPlayer(MenuCasino,playerid);    TogglePlayerControllable(playerid,0);}
			case 5:  {ShowMenuForPlayer(MenuStrip,playerid);     TogglePlayerControllable(playerid,0);}
			case 6:  {ShowMenuForPlayer(MenuIndus,playerid);     TogglePlayerControllable(playerid,0);}
			case 7:  {ShowMenuForPlayer(MenuStadium,playerid);   TogglePlayerControllable(playerid,0);}
			case 8:  {ShowMenuForPlayer(MenuSafehouse,playerid); TogglePlayerControllable(playerid,0);}
			case 9:  {ShowMenuForPlayer(MenuAirLC,playerid);     TogglePlayerControllable(playerid,0);}
			case 10: {ShowMenuForPlayer(MenuBurglary,playerid);  TogglePlayerControllable(playerid,0); SendClientMessage(playerid,0x00F600AA,"CAUTION: You will crash when you visit too much Burglary houses at one time! (Ingame SA bug)"); SendClientMessage(playerid,0x00F600AA,"CAUTION: What also happen, is that the furniture won't load after too much visits. (That's what gives you sometimes crashes)");}
		}
	}
	
	// --------------------------------------------------------------------------> Houses from Characters
	
    if (Current == MenuCharac)
	{
		switch(row)
		{
		    case 0: {SetPlayerPos(playerid,1531,-10,1003);       SetPlayerInterior(playerid,3); SetPlayerFacingAngle(playerid,180);} // B Dup's Appartement
		    case 1: {SetPlayerPos(playerid,1526.5,-48,1003);     SetPlayerInterior(playerid,2); SetPlayerFacingAngle(playerid,90);}  // B Dup's Crack Palace
		    case 2: {SetPlayerPos(playerid,2543,-1306,1025);     SetPlayerInterior(playerid,2); SetPlayerFacingAngle(playerid,180);} // Big Smoke's Crack Palace
		    case 3: {SetPlayerPos(playerid,2807.5,-1172.5,1026); SetPlayerInterior(playerid,8); SetPlayerFacingAngle(playerid,0);}   // Colonel Fuhrberger's House
		    case 4: {SetPlayerPos(playerid,1299,-795.2,1084);	 SetPlayerInterior(playerid,5); SetPlayerFacingAngle(playerid,0);}   // Madd Dogg's Mansion East
		    case 5: {SetPlayerPos(playerid,1263,-785.3,1092);    SetPlayerInterior(playerid,5); SetPlayerFacingAngle(playerid,270);} // Madd Dogg's Mansion West
		    case 6: {SetPlayerPos(playerid,520,-17.5,1002);      SetPlayerInterior(playerid,3); SetPlayerFacingAngle(playerid,90);}  // OG Loc's House
		    case 7: {SetPlayerPos(playerid,2464,-1698,1014);     SetPlayerInterior(playerid,2); SetPlayerFacingAngle(playerid,90);}  // Ryder's Place
		    case 8: {SetPlayerPos(playerid,2526.5,-1679.5,1016); SetPlayerInterior(playerid,1); SetPlayerFacingAngle(playerid,270);} // Sweet's House
			case 9: {SetPlayerPos(playerid,-2163,642,1053);      SetPlayerInterior(playerid,1); SetPlayerFacingAngle(playerid,90);}  // Wu Zi Mu's Crib
		}
	}
	
	// --------------------------------------------------------------------------> Houses from Girlfriends
	
	if (Current == MenuGirlfr)
	{
	    switch(row)
	    {
	        case 0: {SetPlayerPos(playerid,322,303,1000);   SetPlayerInterior(playerid,5); SetPlayerFacingAngle(playerid,0);}   // Barbara's House
	        case 1: {SetPlayerPos(playerid,245,305,1000);   SetPlayerInterior(playerid,1); SetPlayerFacingAngle(playerid,270);} // Denise's House
	        case 2: {SetPlayerPos(playerid,292,310,1000);   SetPlayerInterior(playerid,3); SetPlayerFacingAngle(playerid,90);}  // Helena's House
	        case 3: {SetPlayerPos(playerid,267.6,305,1000); SetPlayerInterior(playerid,2); SetPlayerFacingAngle(playerid,270);} // Katie's House
	        case 4: {SetPlayerPos(playerid,309,311,1004);   SetPlayerInterior(playerid,4); SetPlayerFacingAngle(playerid,180);} // Michelle's House
	        case 5: {SetPlayerPos(playerid,345,305,1000);   SetPlayerInterior(playerid,6); SetPlayerFacingAngle(playerid,270);} // Millie's House
		}
	}
	
	// --------------------------------------------------------------------------> Restaurants & Bars

	if (Current == MenuRestBar)
	{
	    switch(row)
	    {
	        case 0: {SetPlayerPos(playerid,364.4,-73.6,1002); SetPlayerInterior(playerid,10); SetPlayerFacingAngle(playerid,315);} // Burger Shot
	        case 1: {SetPlayerPos(playerid,365.7,-10.7,1002); SetPlayerInterior(playerid,9);  SetPlayerFacingAngle(playerid,0);}   // Clucking' Bell
	        case 2: {SetPlayerPos(playerid,459,-108.5,1005);  SetPlayerInterior(playerid,5);  SetPlayerFacingAngle(playerid,0); SendClientMessage(playerid,0x00F600AA,"In normal game this interior is compleetly unsolid, the FS has makes it solid so you can explore it.");}   // Diner
	        case 3: {SetPlayerPos(playerid,377,-192,1001);    SetPlayerInterior(playerid,17); SetPlayerFacingAngle(playerid,0);}   // Jim's Sticky Ring
	        case 4: {SetPlayerPos(playerid,-227,1401,28);	  SetPlayerInterior(playerid,18); SetPlayerFacingAngle(playerid,270);} // Lil' Probe'Inn
	        case 5: {SetPlayerPos(playerid,455,-21,1001);     SetPlayerInterior(playerid,1);  SetPlayerFacingAngle(playerid,0);}   // Red Restaurant
	        case 6: {SetPlayerPos(playerid,459,-88.5,1000);   SetPlayerInterior(playerid,4);  SetPlayerFacingAngle(playerid,90);}  // Rusty Browns Ring Donuts
	        case 7: {SetPlayerPos(playerid,442,-51,1005);	  SetPlayerInterior(playerid,6);  SetPlayerFacingAngle(playerid,180); SendClientMessage(playerid,0x00F600AA,"In normal game this interior is compleetly unsolid, the FS has makes it solid so you can explore it.");} // Small Restaurant
	        case 8: {SetPlayerPos(playerid,502,-69,999);      SetPlayerInterior(playerid,11); SetPlayerFacingAngle(playerid,180);} // The Bar
	        case 9: {SetPlayerPos(playerid,681.5,-451,-26);   SetPlayerInterior(playerid,1);  SetPlayerFacingAngle(playerid,180);} // The Welcome Pump
	        case 10: {SetPlayerPos(playerid,372,-131,1002);   SetPlayerInterior(playerid,5);  SetPlayerFacingAngle(playerid,0);}   // Well Stacked Pizza
		}
	}
	
	// --------------------------------------------------------------------------> Shops & Ammu-Nations

	if (Current == MenuShopAmmu)
	{
	    switch(row)
	    {
	        case 0: {SetPlayerPos(playerid,286,-40.6,1002);    SetPlayerInterior(playerid,1);  SetPlayerFacingAngle(playerid,0);} // Ammu-Nation 1
	        case 1: {SetPlayerPos(playerid,297,-110,1002);     SetPlayerInterior(playerid,6);  SetPlayerFacingAngle(playerid,0);} // Ammu-Nation 2
	        case 2: {SetPlayerPos(playerid,286,-84,1002);      SetPlayerInterior(playerid,4);  SetPlayerFacingAngle(playerid,0);} // Ammu-Nation 3
	        case 3: {SetPlayerPos(playerid,316.5,-168,1000);   SetPlayerInterior(playerid,6);  SetPlayerFacingAngle(playerid,0);} // Ammu-Nation 4
	        case 4: {SetPlayerPos(playerid,316,-141.5,1000);   SetPlayerInterior(playerid,7);  SetPlayerFacingAngle(playerid,0);} // Ammu-Nation 5
	        case 5: {SetPlayerPos(playerid,418.6,-82.6,1002);  SetPlayerInterior(playerid,3);  SetPlayerFacingAngle(playerid,0);} // Barber
	        case 6: {SetPlayerPos(playerid,207.7,-109.8,1006); SetPlayerInterior(playerid,15); SetPlayerFacingAngle(playerid,0);} // Bingo
	        case 7: {SetPlayerPos(playerid,204.3,-166.7,1001); SetPlayerInterior(playerid,14); SetPlayerFacingAngle(playerid,0);} // Didier Sachs
	        case 8: {SetPlayerPos(playerid,207,-138.8,1004);   SetPlayerInterior(playerid,3);  SetPlayerFacingAngle(playerid,0);} // ProLaps
	        case 9: {SetPlayerPos(playerid,412,-52.6,1002);	   SetPlayerInterior(playerid,12); SetPlayerFacingAngle(playerid,0);} // Macisla Unisex Hair Salon
	        case 10: {SetPlayerPos(playerid,411.6,-21.4,1002); SetPlayerInterior(playerid,2);  SetPlayerFacingAngle(playerid,0);} // Reeces Hair Facial Studio
	        case 11: {ShowMenuForPlayer(MenuShopAmmu2,playerid);  TogglePlayerControllable(playerid,0);}                          // Show Page 2
		}
	}
	
	if (Current == MenuShopAmmu2)
	{
		switch(row)
		{
		    case 0: {SetPlayerPos(playerid,-100,-23,1001);     SetPlayerInterior(playerid,3);  SetPlayerFacingAngle(playerid,0);}  // Sex Shop
		    case 1: {SetPlayerPos(playerid,203.8,-48.5,1002);  SetPlayerInterior(playerid,1);  SetPlayerFacingAngle(playerid,0);}  // Sub Urban
		    case 2: {SetPlayerPos(playerid,-204.5,-26,1003);   SetPlayerInterior(playerid,16); SetPlayerFacingAngle(playerid,0);}  // Tattoo Los Santos
		    case 3: {SetPlayerPos(playerid,-204.4,-8.5,1003);  SetPlayerInterior(playerid,17); SetPlayerFacingAngle(playerid,0);}  // Tattoo San Fierro
		    case 4: {SetPlayerPos(playerid,-204.4,-43.6,1003); SetPlayerInterior(playerid,3);  SetPlayerFacingAngle(playerid,0);}  // Tattoo Las Venturas
		    case 5: {SetPlayerPos(playerid,226.3,-7.4,1003);   SetPlayerInterior(playerid,5);  SetPlayerFacingAngle(playerid,90);} // Victim
		    case 6: {SetPlayerPos(playerid,-2240,129.2,1036);  SetPlayerInterior(playerid,6);  SetPlayerFacingAngle(playerid,0);}  // Zero's RC Shop
		    case 7: {SetPlayerPos(playerid,161.4,-95.3,1002);  SetPlayerInterior(playerid,18); SetPlayerFacingAngle(playerid,0);}  // ZIP
		}
	}
	
	// --------------------------------------------------------------------------> Casino's & Business
	
	if (Current == MenuCasino)
	{
	    switch(row)
	    {
			case 0: {SetPlayerPos(playerid,2234,1710.7,1012); SetPlayerInterior(playerid,1);  SetPlayerFacingAngle(playerid,180);} // Caligula's Casino
			case 1: {SetPlayerPos(playerid,2185.7,1629,1048); SetPlayerInterior(playerid,2);  SetPlayerFacingAngle(playerid,180); SendClientMessage(playerid,0x00F600AA,"In normal game this interior is compleetly unsolid, the FS has makes it solid so you can explore it.");} // Caligula's Office
			case 2: {SetPlayerPos(playerid,2268.7,1648,1085); SetPlayerInterior(playerid,1);  SetPlayerFacingAngle(playerid,270);} // Caligula's Penthouse Suites
			case 3: {SetPlayerPos(playerid,2169.7,1619,1000); SetPlayerInterior(playerid,1);  SetPlayerFacingAngle(playerid,270);} // Caligula's Storage
	        case 4: {SetPlayerPos(playerid,827,5.5,1005);	  SetPlayerInterior(playerid,3);  SetPlayerFacingAngle(playerid,0);}   // Inside Track Betting Shop
	        case 5: {SetPlayerPos(playerid,1133,-11.4,1001);  SetPlayerInterior(playerid,12); SetPlayerFacingAngle(playerid,0);}   // The Casino
	        case 6: {SetPlayerPos(playerid,2015.4,1017,997);  SetPlayerInterior(playerid,10); SetPlayerFacingAngle(playerid,90);}  // The Four Dragons Casino
	        case 7: {SetPlayerPos(playerid,1889.5,1018,32);   SetPlayerInterior(playerid,10); SetPlayerFacingAngle(playerid,270);} // The Four Dragons Janitor Room
	        case 8: {SetPlayerPos(playerid,2012,1015,39);     SetPlayerInterior(playerid,11); SetPlayerFacingAngle(playerid,0);}   // The Four Dragons Managment Room
		}
	}
	
	// --------------------------------------------------------------------------> Stripclubs & Disco's
	
	if (Current == MenuStrip)
	{
	    switch(row)
	    {
	        case 0: {SetPlayerPos(playerid,941,-17,1001);     SetPlayerInterior(playerid,3);  SetPlayerFacingAngle(playerid,0);}   // Brothel 1
	        case 1: {SetPlayerPos(playerid,965,-53,1001.2);   SetPlayerInterior(playerid,3);  SetPlayerFacingAngle(playerid,90);}  // Brothel 2
	        case 2: {SetPlayerPos(playerid,744.5,1437,1103);  SetPlayerInterior(playerid,6);  SetPlayerFacingAngle(playerid,0);}   // Brothel 3
	        case 3: {SetPlayerPos(playerid,493.4,-22.7,1001); SetPlayerInterior(playerid,17); SetPlayerFacingAngle(playerid,0);}   // Disco
	        case 4: {SetPlayerPos(playerid,-2640,1406,907);   SetPlayerInterior(playerid,3);  SetPlayerFacingAngle(playerid,90);}  // Jizzy's Pleasure Domes
	        case 5: {SetPlayerPos(playerid,1212,-28.7,1001);  SetPlayerInterior(playerid,3);  SetPlayerFacingAngle(playerid,180);} // The Big Spread Ranch
	        case 6: {SetPlayerPos(playerid,1205,-11.6,1001);  SetPlayerInterior(playerid,2);  SetPlayerFacingAngle(playerid,0);}   // The Pig Pen
		}
	}
	
	// --------------------------------------------------------------------------> Commercial & Industrial

	if (Current == MenuIndus)
	{
	    switch(row)
	    {
	        case 0: {SetPlayerPos(playerid,-31,-89.6,1004);		  SetPlayerInterior(playerid,18); SetPlayerFacingAngle(playerid,0);}   // 24/7 1
	        case 1: {SetPlayerPos(playerid,-27,-56,1004);		  SetPlayerInterior(playerid,6);  SetPlayerFacingAngle(playerid,0);}   // 24/7 2
	        case 2: {SetPlayerPos(playerid,-27,-27.6,1004);		  SetPlayerInterior(playerid,4);  SetPlayerFacingAngle(playerid,0);}   // 24/7 3
	        case 3: {SetPlayerPos(playerid,-25,-186,1004);		  SetPlayerInterior(playerid,17); SetPlayerFacingAngle(playerid,0);}   // 24/7 4
	        case 4: {SetPlayerPos(playerid,-25,-139.6,1004);	  SetPlayerInterior(playerid,16); SetPlayerFacingAngle(playerid,0);}   // 24/7 5
	        case 5: {SetPlayerPos(playerid,6,-28.6,1004);		  SetPlayerInterior(playerid,10); SetPlayerFacingAngle(playerid,0);}   // 24/7 6
	        case 6: {SetPlayerPos(playerid,214,1874,13);		  SetPlayerInterior(playerid,0);  SetPlayerFacingAngle(playerid,180);} // Area 69
	        case 7: {SetPlayerPos(playerid,1726,-1641,21);		  SetPlayerInterior(playerid,18); SetPlayerFacingAngle(playerid,180);} // Atrium
	        case 8: {SetPlayerPos(playerid,1494.4,1305.6,1094);   SetPlayerInterior(playerid,3);  SetPlayerFacingAngle(playerid,0);}   // Bike School
	        case 9: {SetPlayerPos(playerid,-2027,-105,1035);      SetPlayerInterior(playerid,3);  SetPlayerFacingAngle(playerid,90);}  // Driving School
	        case 10: {SetPlayerPos(playerid,2216.3,-1150.5,1026); SetPlayerInterior(playerid,15); SetPlayerFacingAngle(playerid,270);} // Jefferson Motel
			case 11: {ShowMenuForPlayer(MenuIndus2,playerid);  TogglePlayerControllable(playerid,0);} 							       // Show Page 2
		}
	}
	
	if (Current == MenuIndus2)
	{
	    switch(row)
	    {
	        case 0: {SetPlayerPos(playerid,238.7,141,1003);    SetPlayerInterior(playerid,3);  SetPlayerFacingAngle(playerid,0);}   // Las Venturas Police Department
	        case 1: {SetPlayerPos(playerid,246.8,64,1004); 	   SetPlayerInterior(playerid,6);  SetPlayerFacingAngle(playerid,0);}   // Los Santos Police Department
	        case 2: {SetPlayerPos(playerid,389,173.8,1009);    SetPlayerInterior(playerid,3);  SetPlayerFacingAngle(playerid,90);}  // Planning Department
	        case 3: {SetPlayerPos(playerid,1038,-0.6,1002);    SetPlayerInterior(playerid,3);  SetPlayerFacingAngle(playerid,0);}   // Blastin' Fools Records
	        case 4: {SetPlayerPos(playerid,246.4,108.8,1004);  SetPlayerInterior(playerid,10); SetPlayerFacingAngle(playerid,0);}   // San Fierro Police Department
	        case 5: {SetPlayerPos(playerid,-959.6,1953,9);     SetPlayerInterior(playerid,17); SetPlayerFacingAngle(playerid,180);} // Sherman Dam Generator Hall
	        case 6: {SetPlayerPos(playerid,964,2155.4,1011);   SetPlayerInterior(playerid,1);  SetPlayerFacingAngle(playerid,180);} // Sindacco Abattoir
	        case 7: {SetPlayerPos(playerid,444.7,509,1002);    SetPlayerInterior(playerid,12); SetPlayerFacingAngle(playerid,270);} // U Get Inn Motel
	        case 8: {SetPlayerPos(playerid,1413,4,1001);       SetPlayerInterior(playerid,1);  SetPlayerFacingAngle(playerid,90);}  // Warehouse 1
	        case 9: {SetPlayerPos(playerid,1303,3.5,1001);     SetPlayerInterior(playerid,18); SetPlayerFacingAngle(playerid,90);}  // Warehouse 2
	        case 10: {SetPlayerPos(playerid,1059.5,2087.6,11); SetPlayerInterior(playerid,0);  SetPlayerFacingAngle(playerid,270);} // Warehouse LV
		}
	}
	
	// --------------------------------------------------------------------------> Stadiums
	
	if (Current == MenuStadium)
	{
	    switch(row)
	    {
	        case 0: {SetPlayerPos(playerid,-1405.5,-260.5,1044); SetPlayerInterior(playerid,7);  SetPlayerFacingAngle(playerid,344);} // 8-Track Stadium
	        case 1: {SetPlayerPos(playerid,-2112,-2461.5,31);    SetPlayerInterior(playerid,0);  SetPlayerFacingAngle(playerid,50); SendClientMessage(playerid,0x00F600AA,"Tip: Use a gun to look around inside this interior.");}  // Ammu-Nation Garage
	        case 2: {SetPlayerPos(playerid,773.6,-77,1001); 	 SetPlayerInterior(playerid,7);  SetPlayerFacingAngle(playerid,0);}   // Below the Belt Gym
	        case 3: {SetPlayerPos(playerid,-1424,936,1036.5);    SetPlayerInterior(playerid,15); SetPlayerFacingAngle(playerid,0);}   // Bloodring Stadium
	        case 4: {SetPlayerPos(playerid,774,-48,1001);        SetPlayerInterior(playerid,6);  SetPlayerFacingAngle(playerid,0);}   // Cobra Marital Arts
	        case 5: {SetPlayerPos(playerid,-1424,-664,1060);     SetPlayerInterior(playerid,4);  SetPlayerFacingAngle(playerid,90);}  // Dirttrack Stadium
	        case 6: {SetPlayerPos(playerid,-2038,179,29);	     SetPlayerInterior(playerid,1);  SetPlayerFacingAngle(playerid,90); SendClientMessage(playerid,0x00F600AA,"Tip: Use a gun to look around inside this interior.");}  // Doherty Garage
	        case 7: {SetPlayerPos(playerid,772,-4,1001);		 SetPlayerInterior(playerid,5);  SetPlayerFacingAngle(playerid,0);}   // Ganton Gym
	        case 8: {SetPlayerPos(playerid,664.3,-573.4,17);     SetPlayerInterior(playerid,0);  SetPlayerFacingAngle(playerid,270);} // Gas Station Dillimore
	        case 9: {SetPlayerPos(playerid,-1393,905,1042);      SetPlayerInterior(playerid,15); SetPlayerFacingAngle(playerid,0);}   // Hotring Statium
	        case 10: {SetPlayerPos(playerid,-1401.5,106.5,1033); SetPlayerInterior(playerid,1);  SetPlayerFacingAngle(playerid,0);}   // Hyman Memorial Stadium (VC)
	        case 11: {ShowMenuForPlayer(MenuStadium2,playerid);  TogglePlayerControllable(playerid,0);} 							  // Show Page 2
		}
	}
	
	if (Current == MenuStadium2)
	{
	    switch(row)
	    {
	        case 0: {SetPlayerPos(playerid,-1465,1557,1053);  SetPlayerInterior(playerid,14); SetPlayerFacingAngle(playerid,0);}   // Kickstart Stadium
	        case 1: {SetPlayerPos(playerid,612.6,-75.6,998);  SetPlayerInterior(playerid,2);  SetPlayerFacingAngle(playerid,0);}   // Loco Low Co.
			case 2: {SetPlayerPos(playerid,-1787,1213.7,29);  SetPlayerInterior(playerid,0);  SetPlayerFacingAngle(playerid,180);} // Michelle's Garage
			case 3: {SetPlayerPos(playerid,-1691.7,1035.7,45);SetPlayerInterior(playerid,0);  SetPlayerFacingAngle(playerid,90);}  // San Fierro Bomb Shop
			case 4: {SetPlayerPos(playerid,-1397,1246,1040);  SetPlayerInterior(playerid,16); SetPlayerFacingAngle(playerid,0);}   // Sumo Stadium
			case 5: {SetPlayerPos(playerid,2522.5,-1673.8,15);SetPlayerInterior(playerid,0);  SetPlayerFacingAngle(playerid,90);}  // Sweet's Garage
			case 6: {SetPlayerPos(playerid,626.8,-11.8,1001); SetPlayerInterior(playerid,1);  SetPlayerFacingAngle(playerid,90);}  // Transfender
			case 7: {SetPlayerPos(playerid,620,-120.8,999);   SetPlayerInterior(playerid,3);  SetPlayerFacingAngle(playerid,180);} // Wheel Arch Angels
		}
	}
	
	// --------------------------------------------------------------------------> Safehouses
	
	if (Current == MenuSafehouse)
	{
	    switch(row)
	    {
	        case 0: {SetPlayerPos(playerid,420.6,2536.5,10);     SetPlayerInterior(playerid,10); SetPlayerFacingAngle(playerid,90);}  // Abandoned Airport Safehouse
	        case 1: {SetPlayerPos(playerid,1.6,-3,1000);         SetPlayerInterior(playerid,2);  SetPlayerFacingAngle(playerid,90);}  // Angel Pine Trailer
	        case 2: {SetPlayerPos(playerid,2268.4,-1210.4,1048); SetPlayerInterior(playerid,10); SetPlayerFacingAngle(playerid,90);}  // Hashbury Safehouse
	        case 3: {SetPlayerPos(playerid,2254,-1140,1051);     SetPlayerInterior(playerid,9);  SetPlayerFacingAngle(playerid,90);}  // Jefferson Safehouse 1
	        case 4: {SetPlayerPos(playerid,2261,-1136,1050.6);   SetPlayerInterior(playerid,10); SetPlayerFacingAngle(playerid,270);} // Jefferson Safehouse 2
			case 5: {SetPlayerPos(playerid,2496,-1694.2,1015);   SetPlayerInterior(playerid,3);  SetPlayerFacingAngle(playerid,180);} // Johnson House
	        case 6: {SetPlayerPos(playerid,2324.4,-1147.5,1051); SetPlayerInterior(playerid,12); SetPlayerFacingAngle(playerid,0);}   // Modern Safehouse
	        case 7: {SetPlayerPos(playerid,2318,-1025,1051);     SetPlayerInterior(playerid,9);  SetPlayerFacingAngle(playerid,0);}   // Prickle Pine Safehouse
	        case 8: {SetPlayerPos(playerid,2233,-1110,1051);     SetPlayerInterior(playerid,5);  SetPlayerFacingAngle(playerid,0);}   // Vank Hoff Hotel Suite
	        case 9: {ShowMenuForPlayer(MenuSafehouse2,playerid); TogglePlayerControllable(playerid,0);} 					          // Show Page 2
		}
	}
	
	if (Current == MenuSafehouse2)
	{
		switch(row)
		{
		    case 0: {SetPlayerPos(playerid,2283,-1139,1051);   SetPlayerInterior(playerid,11); SetPlayerFacingAngle(playerid,0);}  // Safehouse 1
	     	case 1: {SetPlayerPos(playerid,2365,-1133,1051);   SetPlayerInterior(playerid,8);  SetPlayerFacingAngle(playerid,0);}  // Safehouse 2
	     	case 2: {SetPlayerPos(playerid,2333,-1075,1049);   SetPlayerInterior(playerid,6);  SetPlayerFacingAngle(playerid,0);}  // Safehouse 3
	     	case 3: {SetPlayerPos(playerid,2216.5,-1076,1051); SetPlayerInterior(playerid,1);  SetPlayerFacingAngle(playerid,90);} // Safehouse 4
	     	case 4: {SetPlayerPos(playerid,2195,-1204,1050);   SetPlayerInterior(playerid,6);  SetPlayerFacingAngle(playerid,90);} // Safehouse 5
	     	case 5: {SetPlayerPos(playerid,2309,-1211,1049);   SetPlayerInterior(playerid,6);  SetPlayerFacingAngle(playerid,0);}  // Safehouse 6
	     	case 6: {SetPlayerPos(playerid,2237.6,-1079,1049); SetPlayerInterior(playerid,2);  SetPlayerFacingAngle(playerid,0);}  // Safehouse 7
		}
	}
	
	// --------------------------------------------------------------------------> Aircraft & Liberty City
	
	if (Current == MenuAirLC)
	{
	    switch(row)
	    {
	        case 0: {SetPlayerPos(playerid,316,1038,1944);     SetPlayerInterior(playerid,9);  SetPlayerFacingAngle(playerid,180);} // Andromada
	        case 1: {SetPlayerPos(playerid,-1842.5,19,1062);   SetPlayerInterior(playerid,14); SetPlayerFacingAngle(playerid,180);} // Francis Bagage Terminal
	        case 2: {SetPlayerPos(playerid,-1860,-33,1062);    SetPlayerInterior(playerid,14); SetPlayerFacingAngle(playerid,180);} // Francis Front Building
	        case 3: {SetPlayerPos(playerid,-747,502,1373);     SetPlayerInterior(playerid,1);  SetPlayerFacingAngle(playerid,270);} // Liberty City
			case 4: {SetPlayerPos(playerid,-1831.7,59.4,1056); SetPlayerInterior(playerid,14); SetPlayerFacingAngle(playerid,90); SendClientMessage(playerid,0x00F600AA,"In normal game this interior is compleetly unsolid, the FS has makes it solid so you can explore it.");} // Los Santos Terminal Inside
	        case 5: {SetPlayerPos(playerid,-1861,57.5,1062);   SetPlayerInterior(playerid,14); SetPlayerFacingAngle(playerid,0);}   // Los Santos Terminal Roof
	        case 6: {SetPlayerPos(playerid,-795,493.5,1377);   SetPlayerInterior(playerid,1);  SetPlayerFacingAngle(playerid,0);}   // Saint Marco's Bistro
	        case 7: {SetPlayerPos(playerid,1.7,32.75,1200);    SetPlayerInterior(playerid,1);  SetPlayerFacingAngle(playerid,180);} // Shamal
		}
	}
	
	// --------------------------------------------------------------------------> Burglary Houses
	
	if (Current == MenuBurglary)
	{
	    switch(row)
	    {
	        case 0: {SetPlayerPos(playerid,223,1288,1082);     SetPlayerInterior(playerid,1); SetPlayerFacingAngle(playerid,0);}  // Burglary House 1
	        case 1: {SetPlayerPos(playerid,225.4,1240,1082);   SetPlayerInterior(playerid,2); SetPlayerFacingAngle(playerid,90);} // Burglary House 2
			case 2: {SetPlayerPos(playerid,447,1398,1085.3);   SetPlayerInterior(playerid,2); SetPlayerFacingAngle(playerid,0);}  // Burglary House 3
			case 3: {SetPlayerPos(playerid,491,1399,1081);     SetPlayerInterior(playerid,2); SetPlayerFacingAngle(playerid,0);}  // Burglary House 4
			case 4: {SetPlayerPos(playerid,235,1187,1080.3);   SetPlayerInterior(playerid,3); SetPlayerFacingAngle(playerid,0);}  // Burglary House 5
			case 5: {SetPlayerPos(playerid,-263,1456.7,1084.4);SetPlayerInterior(playerid,4); SetPlayerFacingAngle(playerid,90);} // Burglary House 6
			case 6: {SetPlayerPos(playerid,221.4,1142.4,1083); SetPlayerInterior(playerid,4); SetPlayerFacingAngle(playerid,0);}  // Burglary House 7
			case 7: {SetPlayerPos(playerid,261,1286.5,1081);   SetPlayerInterior(playerid,4); SetPlayerFacingAngle(playerid,0);}  // Burglary House 8
			case 8: {SetPlayerPos(playerid,22.8,1404.6,1085);  SetPlayerInterior(playerid,5); SetPlayerFacingAngle(playerid,0);}  // Burglary House 9
			case 9: {SetPlayerPos(playerid,229,1114.4,1081);   SetPlayerInterior(playerid,5); SetPlayerFacingAngle(playerid,270);}// Burglary House 10
			case 10: {SetPlayerPos(playerid,140.5,1369,1084);  SetPlayerInterior(playerid,5); SetPlayerFacingAngle(playerid,0);}  // Burglary House 11
			case 11: {ShowMenuForPlayer(MenuBurglary2,playerid);  TogglePlayerControllable(playerid,0);} 					 	  // Show Page 2
		}
	}
	
	if (Current == MenuBurglary2)
	{
	    switch(row)
	    {
	        case 0: {SetPlayerPos(playerid,83.1,1324.2,1084);  SetPlayerInterior(playerid,9);  SetPlayerFacingAngle(playerid,0);}  // Burglary 12
	        case 1: {SetPlayerPos(playerid,260.3,1239.7,1085); SetPlayerInterior(playerid,9);  SetPlayerFacingAngle(playerid,0);}  // Burglary 13
	        case 2: {SetPlayerPos(playerid,9433,1341.3,1085);  SetPlayerInterior(playerid,10); SetPlayerFacingAngle(playerid,0);}  // Burglary 14
	        case 3: {SetPlayerPos(playerid,234.3,1066.4,1085); SetPlayerInterior(playerid,6);  SetPlayerFacingAngle(playerid,0);}  // Burglary 15
	        case 4: {SetPlayerPos(playerid,-69,1354,1081);     SetPlayerInterior(playerid,6);  SetPlayerFacingAngle(playerid,0);}  // Burglary 16
	        case 5: {SetPlayerPos(playerid,-285.7,1470.7,1085);SetPlayerInterior(playerid,15); SetPlayerFacingAngle(playerid,90);} // Burglary 17
	        case 6: {SetPlayerPos(playerid,327.8,1479.7,1085); SetPlayerInterior(playerid,15); SetPlayerFacingAngle(playerid,0);}  // Burglary 18
	        case 7: {SetPlayerPos(playerid,375.6,1417.4,1082); SetPlayerInterior(playerid,15); SetPlayerFacingAngle(playerid,90);} // Burglary 19
	        case 8: {SetPlayerPos(playerid,384.6,1471.5,1081); SetPlayerInterior(playerid,15); SetPlayerFacingAngle(playerid,90);} // Burglary 20
	        case 9: {SetPlayerPos(playerid,295.5,1474.7,1081); SetPlayerInterior(playerid,15); SetPlayerFacingAngle(playerid,0);}  // Burglary 21
	        case 10: {SetPlayerPos(playerid,-42.5,1407.6,1085); SetPlayerInterior(playerid,8); SetPlayerFacingAngle(playerid,0);}  // Burglary 22
	        case 11: {SetPlayerPos(playerid,225.7,1023,1084);  SetPlayerInterior(playerid,7);  SetPlayerFacingAngle(playerid,0);}  // Burglary 23
	 	}
	}
	return 1;
}

// ------------------------------------------------------------------------------> When player exit menu

public OnPlayerExitedMenu(playerid)
{
	new Menu:Current = GetPlayerMenu(playerid);
	
	// --------------------------------------------------------------------------> Hidden Interior Menu
	
	if (Current == HIMenu)
	{
		HideMenuForPlayer(HIMenu,playerid);
		TogglePlayerControllable(playerid,1);
	}

    // --------------------------------------------------------------------------> Else

	else
	{
	    ShowMenuForPlayer(HIMenu,playerid);
		TogglePlayerControllable(playerid,0);
	}
	return 1;
}

// ------------------------------------------------------------------------------>

#endif
