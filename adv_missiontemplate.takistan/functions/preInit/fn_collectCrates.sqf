/*
 * Author: Belbo
 *
 * Puts all items with provided names into variables. These items will be emptied with adv_fnc_clearCargo and then filled with adv_fnc_crate/adv_ind_fnc_crate/adv_opf_fnc_crate.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [] call adv_fnc_collectCrates;
 *
 * Public: No
 */

ADV_objects_clearCargo = [];
ADV_objects_westCargo = [];
ADV_objects_eastCargo = [];
ADV_objects_indCargo = [];
ADV_objects_westTents = [];
ADV_objects_eastTents = [];
ADV_objects_indTents = [];

{
	if ( ["crate",str _x] call BIS_fnc_inString ) then {
		ADV_objects_clearCargo pushBack _x;
	};
	call {
		if ( ["crate_empty",str _x] call BIS_fnc_inString ) exitWith {};
		if ( ["opf_crate",str _x] call BIS_fnc_inString ) exitWith {
			ADV_objects_eastCargo pushBack _x;
		};
		if ( ["ind_crate",str _x] call BIS_fnc_inString ) exitWith {
			ADV_objects_indCargo pushBack _x;
		};
		if ( ["crate",str _x] call BIS_fnc_inString ) exitWith {
			ADV_objects_westCargo pushBack _x;
		};
	};
	nil
} count (entities "ReammoBox_F");

{
	call {
		if ( ["opf_medical_tent",str _x] call BIS_fnc_inString ) exitWith {
			ADV_objects_eastTents pushBack _x;
		};
		if ( ["ind_medical_tent",str _x] call BIS_fnc_inString ) exitWith {
			ADV_objects_indTents pushBack _x;
		};
		if ( ["medical_tent",str _x] call BIS_fnc_inString ) exitWith {
			ADV_objects_westTents pushBack _x;
		};
	};
	nil
} count (allMissionObjects "Land_MedicalTent_01_base_F");

true;