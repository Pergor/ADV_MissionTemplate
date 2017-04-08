/*
 * Author: Belbo
 *
 * Removes disposable launchers after shooting and changing back to other weapon.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * fired EVH index - <NUMBER>
 *
 * Example:
 * _index = [] call adv_fnc_dispLaunch;
 *
 * Public: Yes
 */

ADV_array_dropLaunch = [];
if (isClass(configFile >> "CfgPatches" >> "ace_disposable")) then {
	ADV_array_dropLaunch pushBack "LAUNCH_NLAW_F";
};
ADV_array_dropLaunch append [
	"BWA3_Pzf3","BWA3_RGW90"
	,"BWA3_PZF3_LOADED","BWA3_RGW90_LOADED"
	,"STI_M136"
	,"CUP_launch_NLAW","CUP_launch_RPG18","CUP_launch_M136"
];

//the actual dropping of the launcher:
ADV_scriptfnc_dropLauncher = {
	_this spawn {
		params [
			["_unit", player, [objNull]],
			"_secWeap","_gwh"
		];
		_secWeap = secondaryWeapon _unit;
		waitUntil { !( (currentWeapon _unit) isEqualTo _secWeap ) };
		sleep 2.5;
		_gwh = "GroundWeaponHolder" createVehicle position _unit;
		_gwh addWeaponCargo [_secWeap,1];
		_unit removeWeapon _secWeap;
	};
};

_index = player addEventhandler ["fired",
	{
		params ["_unit","_weapon"];
		if !( _weapon isEqualTo (secondaryWeapon _unit) ) exitWith {};
		if ( (toUpper _weapon) in ADV_array_dropLaunch ) exitWith {
			[_unit] call ADV_scriptfnc_dropLauncher;
		};
	}
];

_index;