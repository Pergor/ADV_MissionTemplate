/*
Vehicle disabling selector by belbo
vehicle = _this select 0
*/
if (!isServer) exitWith {};

params [
	["_veh", objNull, [objNull]]
];

if (true) exitWith {

	//disables the vehicles
	if (ADV_par_Assets_cars == 0) then {
		if (str _veh in ADV_veh_light) then {
			[_veh] call ADV_fnc_disableVeh;
		};
	};
	if (ADV_par_Assets_heavy == 0) then {
		if (str _veh in ADV_veh_heavys) then {
			[_veh] call ADV_fnc_disableVeh;
		};
	};
	if (ADV_par_Assets_tanks == 0) then {
		if (str _veh in ADV_veh_tanks+ADV_veh_artys) then {
			[_veh] call ADV_fnc_disableVeh;
		};
	};
	if (ADV_par_Assets_air_helis == 0) then {
		if (str _veh in ADV_veh_helis) then {
			[_veh] call ADV_fnc_disableVeh;
		};
	};
	if (ADV_par_Assets_air_fixed == 0) then {
		if (str _veh in ADV_veh_fixedWing) then {
			[_veh] call ADV_fnc_disableVeh;
		};
	};

};