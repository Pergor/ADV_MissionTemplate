// Add save/load loadout actions to all ammo boxes
if (ADV_par_respWithGear == 1) then {
	if (count _this == 0) exitWith {};
	{
		_x addAction ["<t color='#00cc00'>Save loadout</t>", {aeroson_loadout = [player] call aeroson_fnc_getLoadout;systemChat "loadout saved.";},nil,1.5,false,false,"","player distance cursortarget <5"];
	} forEach _this;
};