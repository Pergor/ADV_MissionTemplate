/*
 * Author: Belbo
 *
 * Puts all items with provided names into variables. These items will receive logistic menu and teleport menu in initPlayerLocal.sqf
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [] call adv_fnc_collectFlags;
 *
 * Public: No
 */

adv_objects_flags = [];
adv_objects_westFlags = [];
adv_objects_eastFlags = [];
adv_objects_indFlags = [];

{
	if ( ["flag",str _x] call BIS_fnc_inString ) then {
		adv_objects_flags pushBack _x;
	};
	call {
		if ( ["opf_flag",str _x] call BIS_fnc_inString ) exitWith {
			adv_objects_eastflags pushBack _x;
		};
		if ( ["ind_flag",str _x] call BIS_fnc_inString ) exitWith {
			adv_objects_indflags pushBack _x;
		};
		if ( ["flag",str _x] call BIS_fnc_inString ) exitWith {
			adv_objects_westflags pushBack _x;
		};
	};
	nil;
} count (allMissionObjects "FlagCarrierCore");

true;