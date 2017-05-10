/*
 * Author: Belbo
 *
 * Selects vehicle to disable for BLUFOR.
 *
 * Arguments:
 * 0: Vehicle - OBJECT;
 *
 * Return Value:
 * Function executed <BOOL>
 *
 * Example:
 * [MRAP_1] call adv_fnc_disableVehSelector;
 *
 * Public: No
 */

if (!isServer) exitWith {};

params [
	["_veh", objNull, [objNull]]
];

//disables the vehicles
if (ADV_par_Assets_cars isEqualTo 0) then {
	if (str _veh in ADV_veh_light) then {
		[_veh] call ADV_fnc_disableVeh;
	};
};
if (ADV_par_Assets_heavy isEqualTo 0) then {
	if (str _veh in ADV_veh_heavys) then {
		[_veh] call ADV_fnc_disableVeh;
	};
};
if (ADV_par_Assets_tanks isEqualTo 0) then {
	if (str _veh in ADV_veh_tanks+ADV_veh_artys) then {
		[_veh] call ADV_fnc_disableVeh;
	};
};
if (ADV_par_Assets_air_helis isEqualTo 0) then {
	if (str _veh in ADV_veh_helis) then {
		[_veh] call ADV_fnc_disableVeh;
	};
};
if (ADV_par_Assets_air_fixed isEqualTo 0) then {
	if (str _veh in ADV_veh_fixedWing) then {
		[_veh] call ADV_fnc_disableVeh;
	};
};

true;