#include a_samp
new
	Text: L_draw[ 15 ], Float: L_update[ 4 ], total_speed,
	L_color [] = {
		0xffffffff, 0xCBFFBFff, 0xCBFFBFff,
		0x94FF7Dff, 0xB5FE63ff, 0xEBFE63ff,
		0xFFE862ff, 0xFFD362ff, 0xFEB063ff,
		0xFEA043ff, 0xFEA043ff, 0xFE7B43ff,
		0xFE7B43ff, 0xFF0606ff, 0xFF0606ff
	} ;
public OnFilterScriptInit()
{
    L_draw [ 0 ] = TextDrawCreate ( 45.00, 410.00, "10" ) ;
    L_draw [ 1 ] = TextDrawCreate ( 32.00, 399.00, "20" ) ;
    L_draw [ 2 ] = TextDrawCreate ( 25.00, 384.00, "40" ) ;
    L_draw [ 3 ] = TextDrawCreate ( 25.00, 368.00, "60" ) ;
    L_draw [ 4 ] = TextDrawCreate ( 31.00, 352.00, "80" ) ;
    L_draw [ 5 ] = TextDrawCreate ( 42.00, 338.00, "100" ) ;
    L_draw [ 6 ] = TextDrawCreate ( 62.00, 331.00, "120" ) ;
    L_draw [ 7 ] = TextDrawCreate ( 79.00, 330.00, "140" ) ;
    L_draw [ 8 ] = TextDrawCreate ( 98.00, 331.00, "160" ) ;
    L_draw [ 9 ] = TextDrawCreate ( 116.00, 338.00, "180" ) ;
    L_draw [ 10 ] = TextDrawCreate ( 130.00, 352.00, "200" ) ;
    L_draw [ 11 ] = TextDrawCreate ( 136.00, 368.00, "220" ) ;
    L_draw [ 12 ] = TextDrawCreate ( 136.00, 384.00, "240" ) ;
    L_draw [ 13 ] = TextDrawCreate ( 130.00, 399.00, "260" ) ;
    L_draw [ 14 ] = TextDrawCreate ( 117.00, 410.00, "280" ) ;
    for ( new i ; i != sizeof L_draw ; i ++ )
		TextDrawBackgroundColor ( L_draw[ i ], 0x00000033 ), TextDrawFont ( L_draw[ i ], 2 ),
		TextDrawLetterSize ( L_draw[ i ], 0.240, 1.300 ), TextDrawColor ( L_draw[ i ], 0x66666644 ),
		TextDrawSetOutline ( L_draw[ i ], false ), TextDrawSetProportional ( L_draw[ i ], true ),
		TextDrawSetShadow ( L_draw[ i ], false ) ;
    return 1;
}
public OnFilterScriptExit()
{
    for ( new i = 1 ; i != sizeof L_draw ; ++ i ) TextDrawHideForAll ( L_draw[ i ] ),
		TextDrawDestroy( L_draw[ i ] ) ;
    return 1;
}
public OnPlayerStateChange ( playerid, newstate, oldstate )
{
	if ( newstate == 2 )
		for ( new i ; i != sizeof L_draw ; ++ i ) TextDrawColor ( L_draw[ i ], 0x66666644 ),
			TextDrawShowForPlayer ( playerid, L_draw[ i ] ) ;
	else
		for ( new i ; i != sizeof L_draw ; i ++ )
			TextDrawHideForPlayer ( playerid, L_draw[ i ] ) ;
	return 1 ;
}
public OnPlayerUpdate ( playerid )
{
	if ( GetPlayerState ( playerid ) == 2 )
	{
		GetVehicleVelocity ( GetPlayerVehicleID ( playerid ), L_update[ 0 ], L_update[ 1 ], L_update[ 2 ] ) ;
		L_update[ 3 ] = floatsqroot ( floatpower ( floatabs (L_update[ 0 ] ), 2.0 ) + floatpower ( floatabs ( L_update[ 1 ] ), 2.0 ) + floatpower ( floatabs ( L_update[ 2 ] ), 2.0 ) ) * 10.0 ;
		total_speed = floatround ( L_update[ 3 ] ) ;
		for ( new i ; i != 15 ; ++ i )
		{
			if ( i < total_speed ) TextDrawColor( L_draw[ i ], L_color[ i ] ) ;
				else TextDrawColor( L_draw[ i ], 0x66666644 ) ;
			TextDrawShowForPlayer( playerid, L_draw[ i ] ) ;
		}
	}
	return 1 ;
}
