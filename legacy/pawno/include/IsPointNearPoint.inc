/*
native IsPointNearPoint(Float:radi, Float:oldposx, Float:oldposy, Float:oldposz, Float:x, Float:y, Float:z);
native IsPlayerNearPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
native IsPlayerNearPlayer(Float:radi,playerid1, playerid2);
native IsPlayerNearVehicle(Float:radi,playerid, vehicleid);
native IsPlayerNearObject(Float:radi,playerid, objectid);
*/

stock IsPointNearPoint(Float:radi, Float:oldposx, Float:oldposy, Float:oldposz, Float:x, Float:y, Float:z)//soeh
{
	new Float:tempposx, Float:tempposy, Float:tempposz;
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))	return 1;
	return 0;
}

stock IsPlayerNearPoint(Float:radi, playerid, Float:x, Float:y, Float:z)//soeh
{
	new Float:px,Float:py,Float:pz;
	GetPlayerPos(playerid,px,py,pz);
	if(IsPointNearPoint(radi,px,py,pz, x, y, z))	return 1;
	return 0;
}

stock IsPlayerNearPlayer(Float:radi,playerid1, playerid2)//soeh
{
	new Float:px,Float:py,Float:pz;
	new Float:kx,Float:ky,Float:kz;
	GetPlayerPos(playerid1, px, py, pz);
	GetPlayerPos(playerid2, kx, ky, kz);
	if(IsPointNearPoint(radi,px, py, pz, kx, ky, kz)) 	return 1;
	return 0;
}

stock IsPlayerNearVehicle(Float:radi,playerid, vehicleid)//aggiunta di Sasino
{
	new Float:px,Float:py,Float:pz;
	new Float:kx,Float:ky,Float:kz;
	GetPlayerPos(playerid, px, py, pz);
	GetVehiclePos(vehicleid, kx, ky, kz);
	if(IsPointNearPoint(radi,px, py, pz, kx, ky, kz)) 	return 1;
	return 0;
}

stock IsPlayerNearObject(Float:radi,playerid, objectid)//aggiunta di Sasino
{
	new Float:px,Float:py,Float:pz;
	new Float:kx,Float:ky,Float:kz;
	GetPlayerPos(playerid, px, py, pz);
	GetObjectPos(objectid, kx, ky, kz);
	if(IsPointNearPoint(radi,px, py, pz, kx, ky, kz)) 	return 1;
	return 0;
}