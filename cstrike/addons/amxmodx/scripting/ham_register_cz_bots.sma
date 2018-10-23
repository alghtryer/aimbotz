#include <amxmodx>
#include <fakemeta>
#include <hamsandwich>

#define VERSION "2.1.3"

new g_iFwdSetClientKeyValue

public plugin_init()
{
	register_plugin("Ham Register Cz Bots", VERSION, "ConnorMcLeod")
}

public client_putinserver( id )
{
	if( !g_iFwdSetClientKeyValue && is_user_bot(id) )
	{
		g_iFwdSetClientKeyValue = register_forward(FM_SetClientKeyValue, "SetClientKeyValue")
	}
}

public SetClientKeyValue(id, infobuffer[], key[], value[])
{
	if( value[0] == '1' && equal(key, "*bot") )
	{
		unregister_forward(FM_SetClientKeyValue, g_iFwdSetClientKeyValue)
		if( IsCzBot( id ) )
		{
			new iRet, iForward = CreateMultiForward("cz_bot_ham_registerable", ET_IGNORE, FP_CELL)
			ExecuteForward(iForward, iRet, id)
			DestroyForward(iForward)
			pause("ac")
		}
		else
		{
			g_iFwdSetClientKeyValue = 0
		}
	}
}

IsCzBot( id )
{
#if defined Ham_CS_Player_IsBot
	static valid = -1
	if( valid == -1 )
	{
		valid = IsHamValid( Ham_CS_Player_IsBot )
	}
	if( valid )
	{
		return ExecuteHam(Ham_CS_Player_IsBot, id)
	}
	return ExecuteHam(Ham_Weapon_ExtractClipAmmo, id, 0)
#else
	return ExecuteHam(Ham_Weapon_ExtractClipAmmo, id, 0)
#endif
}
