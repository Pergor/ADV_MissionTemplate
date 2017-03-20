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
	adv_evh_radioSettings = _settings;
	if (call TFAR_fnc_haveSWRadio) then {
		[(call TFAR_fnc_activeSwRadio), _settings select 0] call TFAR_fnc_setSwSettings;
		/*
		for "_i" from 0 to (count _sw)-1 do {
			[(call TFAR_fnc_activeSwRadio), _i+1, _sw select _i] call TFAR_fnc_SetChannelFrequency;
		};
		*/
	};
	if (call TFAR_fnc_haveLRRadio) then {
		[(call TFAR_fnc_activeLrRadio), _settings select 1] call TFAR_fnc_setLrSettings;
		/*
		for "_i" from 0 to (count _lr)-1 do {
			[(call TFAR_fnc_activeLRRadio), _i+1, _lr select _i] call TFAR_fnc_SetChannelFrequency;
		};
		*/
	};
	
	adv_scriptfnc_setFrequencies = {
		private _unit = _this select 0;
		private _veh = _this select 2;
		if !(_veh call TFAR_fnc_hasVehicleRadio) exitWith {};
		private _vehLR = _unit call TFAR_fnc_VehicleLR;
		private _slot = _vehLR select 1;
		if ( !(_slot in (_veh getVariable ["adv_vehRadioSet",[]])) && ((_veh getVariable ["tf_side", west]) isEqualTo (side group _unit)) ) then {
			[_vehLR, adv_evh_radioSettings select 1] call TFAR_fnc_setLrSettings;
			private _radiosSet = _veh getVariable ["adv_vehRadioSet",[]];
			_radiosSet pushBack _slot;
			_veh setVariable ["adv_vehRadioSet",_radiosSet,true];
		};	
	};
	
	if (isNil "adv_evh_tfarVehicle") then {
		adv_evh_tfarVehicle = _unit addEventhandler ["GetInMan",{
			_this call adv_scriptfnc_setFrequencies;
		}];
		adv_evh_tfarSeatSwitched = _unit addEventhandler ["SeatSwitchedMan",{
			_this call adv_scriptfnc_setFrequencies;
		}];
	};
	
	_settings;
};