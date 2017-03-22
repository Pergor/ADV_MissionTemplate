// Add save/load loadout actions to all ammo boxes
if (ADV_par_respWithGear == 1) then {
	if (count _this == 0) exitWith {};
	{
		_x addAction ["<t color='#ffff00'>Load loadout</t>", {[(_this select 1),adv_saveGear_loadout] call adv_fnc_readdGear;systemChat "loading loadout...";},nil,1.5,false,false,"","true",5];
	} forEach _this;
};