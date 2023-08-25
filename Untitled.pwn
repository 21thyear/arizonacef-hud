// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT
#define SSCANF_NO_NICE_FEATURES
#include <a_samp>
#include <cef>
#include <foreach>
#include <fmt>
#include <sscanf2>
#include <streamer>
#include <Pawn.CMD>
#define ID_BROWSER_DIALOGS  5

main(){}

public OnGameModeInit(){
	cef_subscribe("OnHudInitialization", "OnHudInitialization");
}

public OnPlayerSpawn(playerid){
	cef_create_browser(playerid, ID_BROWSER_DIALOGS, "file:///C:/OSPanel/domains/localhost/index.html", false, false);

}
forward OnHudInitialization(playerid);
public OnHudInitialization(playerid){
	return true;
}

CMD:test(playerid)
{
	new
	    Float:hp,
		Float:maxHp = 100.0,
		Float:arm,
		breath,
		wanted,
		weapon,
		ammo,
		max_ammo,
		money,
		speed,
		Float:maxArm = 100.0
	;
	GetPlayerHealth(playerid, hp);
	GetPlayerArmour(playerid, arm);
	weapon = GetPlayerWeapon(playerid);
	ammo = GetPlayerAmmo(playerid);
	money = GetPlayerMoney(playerid);
	
	wanted = GetPlayerWantedLevel(playerid);
	speed = 0;
	max_ammo = 0;
	breath = 0;
	
    hudUpdate(playerid, floatround(hp), maxHp, arm, breath, wanted, weapon, ammo, max_ammo, money, speed, maxArm);
    return true;
}

stock hudUpdate(playerid, Float:hp, Float:maxHp, Float:arm, breath, wanted, weapon, ammo, max_ammo, money, speed, Float:maxArm)
{
    cef_emit_event(
		playerid,
		"game:data:playerStats",
		CEFFLOAT(hp),
		CEFFLOAT(maxHp),
		CEFFLOAT(arm),
		CEFINT(breath),
		CEFINT(wanted),
		CEFINT(weapon),
		CEFINT(ammo),
		CEFINT(max_ammo),
		CEFINT(money),
		CEFINT(speed),
		CEFFLOAT(maxArm)
	);
	
	cef_emit_event(
	    playerid,
	    "update_sa",
		CEFINT(GetPlayerPoolSize()+1),
		CEFINT(playerid),
		CEFINT(1),
		CEFSTR("21th year"),
		CEFINT(100)
	);
}
