#include <amxx>
#include <amxx_stocks>

new const szResetCmds[] [] =
{
	"/rs",
	"rs",
	"resetscore",
	"reset",
	"/resetscore",
	"retry"

};

public plugin_init()
{
	register_plugin( "Reset score", AMXX_BLUE_VERS, AMXX_BLUE_TEAM );
	for( new i = 0; i < sizeof szResetCmds; i++ )
	{
		RegisterChatCmd( szResetCmds[i], "reset_function" );
	}
}

public reset_function(id)
{
	set_user_frags(id, 0 );
	cs_set_user_deaths( id, 0 );

	set_user_frags( id, 0 );
	cs_set_user_deaths( id, 0 );

	print_colored_message( id, 0, "^3[AMXX]^1 You have succesfully reseted your score." );
	return PLUGIN_HANDLED;
}
