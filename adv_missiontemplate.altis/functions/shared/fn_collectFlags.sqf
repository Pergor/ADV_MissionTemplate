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

private _westFlags = ["FLAG_1","FLAG_2","FLAG_3","FLAG_4"];
private _eastFlags = ["OPF_FLAG_1","OPF_FLAG_2","OPF_FLAG_3","OPF_FLAG_4"];
private _indFlags = ["IND_FLAG_1","IND_FLAG_2","IND_FLAG_3","IND_FLAG_4"];
adv_objects_westFlags = [];
adv_objects_eastFlags = [];
adv_objects_indFlags = [];
{
	if ( (toUpper (str _x)) in _westFlags ) then {
		adv_objects_westflags pushBack _x;
	};
	if ( (toUpper (str _x)) in _eastFlags ) then {
		adv_objects_eastflags pushBack _x;
	};
	if ( (toUpper (str _x)) in _indFlags ) then {
		adv_objects_indflags pushBack _x;
	};
	nil;
} count (allMissionObjects "FlagCarrier");
adv_objects_flags = adv_objects_westFlags+adv_objects_eastFlags+adv_objects_indFlags;

true;