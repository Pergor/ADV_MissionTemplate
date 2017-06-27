/*
 * Author: Belbo
 *
 * Selects vehicle to disable for INDFOR.
 *
 * Arguments:
 * 0: Vehicle - OBJECT;
 *
 * Return Value:
 * Function executed <BOOL>
 *
 * Example:
 * [MRAP_1] call adv_ind_fnc_disableVehSelector;
 *
 * Public: No
 */
 
if (!isServer) exitWith {};

params [
	["_veh", objNull, [objNull]]
];

//disables the vehicles
if (ADV_par_Assets_cars == 0) then {
	if (str _veh in ADV_ind_veh_light) then {
		[_veh] call ADV_fnc_disableVeh;
	};
};
if (ADV_par_Assets_heavy == 0) then {
	if (str _veh in ADV_ind_veh_heavys) then {
		[_veh] call ADV_fnc_disableVeh;
	};
};
if (ADV_par_Assets_tanks == 0) then {
	if (str _veh in ADV_ind_veh_tanks+ADV_ind_veh_artys) then {
		[_veh] call ADV_fnc_disableVeh;
	};
};
if (ADV_par_Assets_air_helis == 0) then {
	if (str _veh in ADV_ind_veh_helis) then {
		[_veh] call ADV_fnc_disableVeh;
	};
};
if (ADV_par_Assets_air_fixed == 0) then {
	if (str _veh in ADV_ind_veh_fixedWing) then {
		[_veh] call ADV_fnc_disableVeh;
	};
};
	
true;