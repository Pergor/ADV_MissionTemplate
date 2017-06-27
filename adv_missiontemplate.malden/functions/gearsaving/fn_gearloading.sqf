/*
 * Author: Belbo
 *
 * Adds gear loading action to object.
 *
 * Arguments:
 * Array of objects - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Is gearsaving even available? - <BOOL>
 *
 * Example:
 * [this] call adv_fnc_gearsaving;
 *
 * Public: No
 */
 
if ( (missionNamespace getVariable ["ADV_par_respWithGear",1]) isEqualTo 1 && count _this > 0) exitWith {
	{
		if (!isNil "_x") then {
			_target = _x;
			nul = _target addAction ["<t color='#ffff00'>Load loadout</t>", {
				[(_this select 1),adv_saveGear_loadout] call adv_fnc_readdGear;
				systemChat "loading loadout...";
			},nil,1.5,false,false,"","true",5];
			nil;
		};
	} count _this;
	true;
};

false;