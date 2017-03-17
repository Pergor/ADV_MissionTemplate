params [
	["_unit", player, [objNull]]
];

if (isClass(configFile >> "CfgPatches" >> "tfar_core")) exitWith {
	private _settings = switch ( side (group _unit) ) do {
		default { [TFAR_freq_sw_west,TFAR_freq_lr_west] };
		case east: { [TFAR_freq_sw_east,TFAR_freq_lr_east] };
		case independent: { [TFAR_freq_sw_independent,TFAR_freq_lr_independent] };
	};
	private _sw = (_settings select 0) select 2;
	private _lr = (_settings select 1) select 2;
	if (call TFAR_fnc_haveSWRadio) then {
		for "_i" from 0 to (count _sw) do {
			[(call TFAR_fnc_activeSwRadio), _i+1, _sw select _i] call TFAR_fnc_SetChannelFrequency;
		};
	};
	if (call TFAR_fnc_haveLRRadio) then {
		for "_i" from 0 to (count _lr) do {
			[(call TFAR_fnc_activeLRRadio), _i+1, _lr select _i] call TFAR_fnc_SetChannelFrequency;
		};
	};
	
	if (isNil "adv_evh_tfarVehicle") then {
		adv_evh_radioSettings = _settings;
		adv_evh_tfarVehicle = _unit addEventhandler ["GetInMan",{
			private _unit = _this select 0;
			private _veh = _this select 2;
			if ( !(_veh getVariable ["adv_vehRadioSet",false]) && ((_veh getVariable ["tf_side", west]) isEqualTo (side group _unit)) ) then {
				[_unit call TFAR_fnc_VehicleLR, adv_evh_radioSettings select 1] call TFAR_fnc_setLrSettings;
				_veh setVariable ["adv_vehRadioSet",true,true];
			};
		}];
	};
	
	_settings;
};