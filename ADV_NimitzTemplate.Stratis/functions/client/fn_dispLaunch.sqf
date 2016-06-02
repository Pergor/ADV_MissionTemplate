/*
ADV_fnc_dispLaunch by Belbo
Adds action to remove disposable launchers.

Possible call - has to be executed on each client locally at mission startup:
[] spawn ADV_fnc_dispLaunch;
*/

private ["_secWeap","_gwh"];

//the actual dropping of the launcher:
ADV_scriptfnc_dropLauncher = {
	params [
		["_unit", player, [objNull]],
		"_secWeap","_gwh"
	];

	_secWeap = secondaryWeapon _unit;
	_gwh = "GroundWeaponHolder" createVehicle position _unit;
	_gwh addWeaponCargo [_secWeap,1];
	//{_x addCuratorEditableObjects [[_gwh],false];} forEach allCurators;
	_unit removeWeapon _secWeap;
	_unit selectWeapon (primaryWeapon _unit);
};

//add names of used disposable launchers, if necessary:
ADV_array_dispLaunch = [
	"ACE_LAUNCH_NLAW_USED_F",
	"BWA3_PZF3_USED","BWA3_RGW90_USED",
	"RHS_WEAP_M136_HP_USED","RHS_WEAP_M136_USED","RHS_WEAP_M136_HEDP_USED",
	"RHS_WEAP_M72A7_USED",
	"RHS_WEAP_RPG26_USED","RHS_WEAP_RSHG2_USED","RHS_WEAP_RPG18_USED",
	"STI_M136_USED"
];

//this is where the magic happens:
if ( isClass(configFile >> "CfgPatches" >> "ace_interact_menu") ) then {
	//if ace is present, this ace-selfaction will be added:
	_ace_dropLaunch = [
		"dropLauncherSelfAction",
		("<t color=""#FF0000"">" + ("DROP LAUNCHER") + "</t>"),
		"",
		{ [player] call ADV_scriptfnc_dropLauncher },
		{ !(secondaryWeapon player == "") && ( toUpper (secondaryWeapon player) ) in ADV_array_dispLaunch }
	] call ace_interact_menu_fnc_createAction;
	[player , 1, ["ACE_SelfActions"],_ace_dropLaunch] call ace_interact_menu_fnc_addActionToObject;
} else {
	//if ace is not present, this loop will start that adds a regular addaction to the player:
	while {true} do {
		waitUntil { sleep 2; !(secondaryWeapon player == "") };
		waitUntil { sleep 1; ( toUpper (secondaryWeapon player) ) in ADV_array_dispLaunch };
		sleep 1;
		ADV_action_dropIt = player addAction ["<t color=""#FFFFFF"">" + ("Drop Launcher") + "</t>",{[player] call ADV_scriptfnc_dropLauncher},"",6];
		sleep 1;
		waitUntil {	sleep 1; !( ( toUpper (secondaryWeapon player) ) in ADV_array_dispLaunch ) };
		player removeAction ADV_action_dropIt;
		sleep 1;
	};
};