#include <amxmodx>
#include <fun>
#include <hamsandwich>
#include <cstrike>

new cvar_on

public plugin_init()
{
	RegisterHam(Ham_Spawn, "player", "CBasePlayer_Spawn_Post", true);
	cvar_on = register_cvar("bot_armor", "0");
}

public cz_bot_ham_registerable( id )
{
	RegisterHamFromEntity(Ham_Spawn, id, "CBasePlayer_Spawn_Post", true)
}

public CBasePlayer_Spawn_Post( id )
{
	if( is_user_alive(id) )
	{
		if(get_pcvar_num(cvar_on)) 
			cs_set_user_armor ( id, 100, CS_ARMOR_VESTHELM );
	}
}