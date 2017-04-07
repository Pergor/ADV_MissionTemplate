/*
fn_addRadios: adds radios to a unit.
call like this:
[_unit] call ADV_fnc_addRadios;
*/

params [
	["_unit", player, [objNull]]
];

_unit unlinkItem "ItemRadio";

if ( isClass (configFile >> "CfgPatches" >> "task_force_radio") ) then {
	_linkedRadios = _unit call TFAR_fnc_radiosList;
	_actualRadio = [];
	{
		if ( _x in _linkedRadios ) then {
			_actualRadio pushBack _x
		};
		nil;
	} count (assignedItems _unit);
	{_unit unlinkItem _x; _unit removeItems _x;} count _actualRadio;
};

switch ( true ) do {
	case ( isClass (configFile >> "CfgPatches" >> "task_force_radio") ): {
		_personalRadioType = "";
		_riflemanRadioType = "";
		if !(isClass(configFile >> "CfgPatches" >> "tfar_core")) then {
			_personalRadioType = switch ( side (group _unit) ) do {
				case east: { TF_defaultEastPersonalRadio };
				case independent: { TF_defaultGuerPersonalRadio };
				default { TF_defaultWestPersonalRadio };
			};
			_riflemanRadioType = switch ( side (group _unit) ) do {
				case east: { TF_defaultEastRiflemanRadio };
				case independent: { TF_defaultGuerRiflemanRadio };
				default { TF_defaultWestRiflemanRadio };
			};
		};
		if (isClass(configFile >> "CfgPatches" >> "tfar_core")) then {
			_personalRadioType = switch ( side (group _unit) ) do {
				case east: { TFAR_DefaultRadio_Personal_East };
				case independent: { TFAR_DefaultRadio_Personal_Independent };
				default { TFAR_DefaultRadio_Personal_West };
			};
			_riflemanRadioType = switch ( side (group _unit) ) do {
				case east: { TFAR_DefaultRadio_Rifleman_East };
				case independent: { TFAR_DefaultRadio_Rifleman_Independent };
				default { TFAR_DefaultRadio_Rifleman_West };
			};
		};
		switch ADV_par_Radios do {
			//everyone gets role specific radio
			default {
				if ( _givePersonalRadio ) then { _unit linkItem _personalRadioType; };
				if ( _giveRiflemanRadio && !_givePersonalRadio ) then { _unit linkItem _riflemanRadioType; };
				//if ( _giveRiflemanRadio && _givePersonalRadio ) then { _unit addItem _riflemanRadioType; };
				if ( _tfar_microdagr > 0 && _givePersonalRadio ) then { _unit addItem "tf_microdagr"; };
				if ( _tfar_microdagr > 0 && !_givePersonalRadio ) then { _unit linkItem "tf_microdagr"; };
			};
			//only leaders get Radio
			case 2: {
				if ( (toUpper (rank _unit)) in ["SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"] ) then { _unit linkItem _personalRadioType; };
			};
			//everyone gets personal radio
			case 3: {
				_unit linkItem _personalRadioType;
			};
		};
	};
	case ( isClass (configFile >> "CfgPatches" >> "acre_main") ): {
		_riflemanRadioType = "ACRE_PRC343";
		_personalRadioType = switch ( side (group _unit) ) do {
			case east: { acre_eastPersonalRadio };
			case independent: { acre_guerPersonalRadio };
			default { acre_westPersonalRadio };
		};
		_backpackRadioType = switch ( side (group _unit) ) do {
			case east: { acre_eastBackpackRadio };
			case independent: { acre_guerBackpackRadio };
			default { acre_westBackpackRadio };
		};
		switch ADV_par_Radios do {
			//everyone gets role specific radio
			default {
				if ( _giveRiflemanRadio ) then { _unit addItem _riflemanRadioType; };
				if ( _givePersonalRadio ) then { _unit addItem _personalRadioType; };
				if ( _giveBackpackRadio ) then { _unit addItem _backpackRadioType; };
			};
			//only leaders get Radio
			case 2: {
				if ( (toUpper (rank _unit)) in ["SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"] ) then {
					call {
						if (_giveBackpackRadio) exitWith {
							_unit additem _backpackRadioType
						};
						_unit addItem _personalRadioType;
					};
				};
			};
			//everyone gets personal radio
			case 3: {
				_unit addItem _riflemanRadioType;
				_unit addItem _personalRadioType;
				if ( _giveBackpackRadio ) then { _unit addItem _backpackRadioType; };
			};
		};
	};
	default {
		switch ADV_par_Radios do {
			//everyone gets role specific radio
			default {
				_unit linkItem "ItemRadio";
			};
			//only leaders get Radio
			case 2: {
				if ( (toUpper (rank _unit)) in ["SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"] ) then {
					_unit linkItem "ItemRadio";
				};
			};
		};
	};
};

if (isPlayer _unit) then {
	[_unit] spawn adv_fnc_setChannels;
};

nil;