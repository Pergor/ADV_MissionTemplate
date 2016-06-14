// Add save/load loadout actions to all ammo boxes
if (ADV_par_respWithGear == 1) then {
	if (count _this == 0) exitWith {};
	{
		_x addAction ["<t color='#ffff00'>Load loadout</t>", {[player,aeroson_loadout] spawn aeroson_fnc_setLoadout;systemChat "loading loadout...";},nil,1.5,false,false,"","player distance cursortarget <5"];
	} forEach _this;
};