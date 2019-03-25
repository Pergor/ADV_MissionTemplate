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
	"BWA3_PZF3","BWA3_RGW90"
	,"BWA3_PZF3_LOADED","BWA3_RGW90_LOADED"
	,"STI_M136"
	,"UK3CB_BAF_AT4_AP_LAUNCHER","UK3CB_BAF_AT4_CS_AP_LAUNCHER","UK3CB_BAF_NLAW_LAUNCHER"
	,"CUP_LAUNCH_NLAW","CUP_LAUNCH_RPG18","CUP_LAUNCH_M136","CUP_LAUNCH_M72A6_SPECIAL","CUP_LAUNCH_M72A6"
];

//the actual dropping of the launcher:
ADV_scriptfnc_dropLauncher = {
	_this spawn {
		params [
			["_unit", player, [objNull]]
		];
		waitUntil { !( (currentWeapon _unit) isEqualTo (secondaryWeapon _unit) ) };
		sleep 2.5;
		private _secWeap = secondaryWeapon _unit;
		if (toUpper _secWeap in ["BWA3_PZF3","BWA3_PZF3_LOADED"]) then {
			_secWeap = "BWA3_PZF3_USED";
		};
		if (toUpper _secWeap in ["BWA3_RGW90","BWA3_RGW90_LOADED"]) then {
			_secWeap = "BWA3_RGW90_USED";
		};
		systemChat "Dropped empty tube.";
		_unit removeWeapon _secWeap;
		private _emptyTube = createVehicle ["WeaponHolderSimulated", _unit modelToWorldVisual ((_unit selectionPosition "leftHand") vectorAdd [0,-0.45,-0.05]), [], 0, "CAN_COLLIDE"];
		_emptyTube setdir (getDir _unit -90);
		_emptyTube addWeaponCargoGlobal [_secWeap, 1];
		_emptyTube setVelocity [sin(getdir _unit+90)*2,cos(getdir _unit+90)*2,0];
		sleep 300;
		deleteVehicle _emptyTube;
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