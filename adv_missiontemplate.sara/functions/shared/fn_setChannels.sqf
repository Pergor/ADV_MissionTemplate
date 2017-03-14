if (isClass(configFile >> "CfgPatches" >> "tfar_core")) exitWith {

	private _settings = switch ( side (group player) ) do {
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

	nil;

};