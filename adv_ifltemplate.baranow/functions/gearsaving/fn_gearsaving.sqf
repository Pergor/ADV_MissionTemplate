// Add save/load loadout actions to all ammo boxes
if (ADV_par_respWithGear == 1 && count _this > 0) exitWith {
	{
		if (!isNil "_x") then {
			_target = _x;
			_target addAction ["<t color='#00cc00'>Save loadout</t>", {
				//[(_this select 1)] call adv_fnc_saveGear;
				adv_saveGear_loadout = getUnitLoadout (_this select 1);
				systemChat "loadout saved.";
			},nil,1.5,false,false,"","true",5];
			nil;
		};
	} count _this;
};