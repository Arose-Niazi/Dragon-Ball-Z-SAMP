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

/*

native CreateExplosionEx(playerid, Float:Distance, type, Float:Radius);

*/