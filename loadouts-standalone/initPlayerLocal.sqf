//waitUntil-player is initialized:
waitUntil {player == player && !isNil "ADV_params_defined"};
if (adv_par_customLoad > 0) then {
	player unlinkItem "ItemRadio";
};

//defines the player's unit:
[player] call ADV_fnc_playerUnit;

//stupid goggles are removed:
if ( (toUpper (goggles player)) in ["MASK_M40_OD","MASK_M40","MASK_M50","G_BALACLAVA_BLK","G_BALACLAVA_COMBAT","G_BALACLAVA_LOWPROFILE","G_BALACLAVA_OLI","G_BANDANNA_AVIATOR","G_BANDANNA_BEAST","G_BANDANNA_BLK",
	"G_BANDANNA_KHK","G_BANDANNA_OLI","G_BANDANNA_SHADES","G_BANDANNA_SPORT","G_BANDANNA_TAN","G_GOGGLES_VR","MURSHUN_CIGS_CIG0","MURSHUN_CIGS_CIG1","MURSHUN_CIGS_CIG2","MURSHUN_CIGS_CIG3","MURSHUN_CIGS_CIG4"]
) then { removeGoggles player; };
sleep 1;

waitUntil {time > 0};

//logistics menu
if ( ADV_par_logisticAmount > 0 ) then {
	{ nul = _x addAction [("<t color='#33FFFF' size='2'>" + ("Logistik-Menü") + "</t>"), {createDialog "adv_logistic_mainDialog";},nil,3,false,true,"","side player == west",5]; nil; } count adv_objects_westFlags;
	{ nul = _x addAction [("<t color='#33FFFF' size='2'>" + ("Logistik-Menü") + "</t>"), {createDialog "adv_logistic_mainDialog";},nil,3,false,true,"","side player == east",5]; nil; } count adv_objects_eastFlags;
	{ nul = _x addAction [("<t color='#33FFFF' size='2'>" + ("Logistik-Menü") + "</t>"), {createDialog "adv_logistic_mainDialog";},nil,3,false,true,"","side player == independent",5]; nil; } count adv_objects_indFlags;
};

//gearsaving
ADV_objects_gearsaving spawn adv_fnc_gearsaving;
ADV_objects_gearSaving spawn adv_fnc_gearloading;

//loadout menu:
{ nul = _x addAction [("<t color='#00FF00' size='2' align='center'>" + ("Loadout-Menü") + "</t>"), {createDialog "adv_loadouts_mainDialog";},nil,6,true,true,"","side player == west",5]; nil;} count adv_objects_westFlags;
{ nul = _x addAction [("<t color='#00FF00' size='2' align='center'>" + ("Loadout-Menü") + "</t>"), {createDialog "adv_loadouts_mainDialog";},nil,6,true,true,"","side player == east",5]; nil;} count adv_objects_eastFlags;
{ nul = _x addAction [("<t color='#00FF00' size='2' align='center'>" + ("Loadout-Menü") + "</t>"), {createDialog "adv_loadouts_mainDialog";},nil,6,true,true,"","side player == independent",5]; nil; } count adv_objects_indFlags;

sleep 1;
//loadouts and RespawnMPEVH are placed on the units on spawn. [target]
[player] call ADV_fnc_applyLoadout;