/*
 * Author: Belbo
 *
 * Adds rhs decals to BLUFOR vehicle
 *
 * Arguments:
 * 0: vehicle - <OBJECT>
 *
 * Return Value:
 * decal applied - <BOOL>
 *
 * Example:
 * [MRAP_1] call adv_fnc_rhsDecals;
 *
 * Public: Yes
 */

if !(isClass(configFile >> "CfgPatches" >> "rhsusf_main")) exitWith {};

params [
	["_veh", objNull, [objNull]]
];

switch true do {
	case (_veh isKindOf "rhsusf_hmmwe_base"): {
		/*
		if ( (missionNamespace getVariable ["ADV_par_modCarAssets",0]) isEqualTo 7 ) then {
			[_veh,["OLIVE",1],nil] call BIS_fnc_initVehicle;
			true;
		};
		*/
	};
	default {};
};

false;