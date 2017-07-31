#include <amxx>
#include <amxx_stocks>
#include <amxx_give_weapon>

public plugin_init()
{
	register_plugin( "Give Weapon", AMXX_BLUE_VERS, AMXX_BLUE_TEAM );

	register_clcmd( "amx_give_weapon", "Cl" );
	register_clcmd(" amx_weaponlist", "Cl2" );

}
public Cl( id )
{
	/* Example checking if is admin and restrict his power */

	if( !is_user_admin(id) )
	{
		client_print( id, print_console, "You have no acces for this command." );
		return PLUGIN_HANDLED;
	}
	
	/* Example of finding a target */
	new Arg1[64],Arg2[32], Arg3[11], Arg4[11], szAdminName[32];

	read_argv( 1, Arg1, cm(Arg1) );
	read_argv( 2, Arg2, cm(Arg2) );
	read_argv( 3, Arg3, cm(Arg3) );
	read_argv( 4, Arg4, cm(Arg4) )

	get_user_name( id, szAdminName, cm( szAdminName ) );

	new PlayerId = find_player("al", Arg1 );
	new Weapon = get_weaponid(Arg2);

	if( Arg1[0] == EOS )
	{
		client_print( id, print_console, "[AMXX-BLUE] Specify the name of the user: amx_give_weapon 'Name' 'Weapon' 'Ammo' 'BpAmmo' " );
		return PLUGIN_HANDLED;
	}

	if( !PlayerId || !is_user_connected(PlayerId) )
	{
		client_print( id, print_console, "[AMXX-BLUE] '%s' not finded, try again with better description", Arg1 );
		return PLUGIN_HANDLED;
	}
	
	if(!Weapon)
	{
		client_print(id, print_console, "[AMXX-BLUE] Wrong weapon id, type amx_weaponlist for a list with all weapon_* names to use." );
		return PLUGIN_HANDLED;
	}

	/* Doing the things after we find player */

	new WeaponName[20];
	give_user_weapon( PlayerId, Weapon, str_to_num(Arg3), str_to_num(Arg4), WeaponName, cm(WeaponName) );
	
	print_colored_message( 0 , 0, "^1[ ^3AMXX-BLUE^1 ]^4%s^1 give weapon [name:^4%s^1/bullets:^4%s^1/bpammo:^4%s^1] to player ^4%s^1.", szAdminName, WeaponName, Arg3, Arg4, Arg1 );
 
	return PLUGIN_HANDLED;
}

public Cl2(id)
{
	if( !is_user_admin( id ) )
	{
		client_print( id, print_console, "You have no acces to this command." );
		return PLUGIN_HANDLED;
	}

	new szWeaponName[20];
	client_print( id, print_console, "* List with all weapons avaible to use with amx_give_weapon <> *" );

	for( new i = 1; i < 31; i++ )
	{
		get_weaponname( i, szWeaponName, charsmax(szWeaponName) );
		client_print( id, print_console, "%s",szWeaponName );
	}
	return PLUGIN_HANDLED;
}
