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

private _westCrates = ["CRATE_1","CRATE_2","CRATE_3","CRATE_4","CRATE_5","CRATE_6","CRATE_7","CRATE_8","CRATE_9","CRATE_10"];
private _eastCrates = ["OPF_CRATE_1","OPF_CRATE_2","OPF_CRATE_3","OPF_CRATE_4","OPF_CRATE_5","OPF_CRATE_6","OPF_CRATE_7","OPF_CRATE_8","OPF_CRATE_9","OPF_CRATE_10"];
private _indCrates = ["IND_CRATE_1","IND_CRATE_2","IND_CRATE_3","IND_CRATE_4","IND_CRATE_5","IND_CRATE_6","IND_CRATE_7","IND_CRATE_8","IND_CRATE_9","IND_CRATE_10"];
private _emptyCrates = ["CRATE_EMPTY","OPF_CRATE_EMPTY","IND_CRATE_EMPTY","MGCRATE","OPF_MGCRATE","IND_MGCRATE"];
ADV_objects_clearCargo = [];
ADV_objects_westCargo = [];
ADV_objects_eastCargo = [];
ADV_objects_indCargo = [];
{
	if ( (toUpper (str _x)) in _westCrates ) then {
		ADV_objects_clearCargo pushBack _x;
		ADV_objects_westCargo pushBack _x;
	};
	if ( (toUpper (str _x)) in _eastCrates ) then {
		ADV_objects_clearCargo pushBack _x;
		ADV_objects_eastCargo pushBack _x;
	};
	if ( (toUpper (str _x)) in _indCrates ) then {
		ADV_objects_clearCargo pushBack _x;
		ADV_objects_indCargo pushBack _x;
	};
	if ( (toUpper (str _x)) in _emptyCrates ) then {
		ADV_objects_clearCargo pushBack _x;
	};
	nil;
} count (entities "ReammoBox_F");

true;