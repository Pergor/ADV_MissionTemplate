/*
fn_addRadios: adds radios to a unit.
call like this:
[_unit] call ADV_fnc_addRadios;
*/

params [
	["_unit", player, [objNull]]
];

if ( isClass (configFile >> "CfgPatches" >> "task_force_radio") ) then {
	_linkedRadios = _unit call TFAR_fnc_radiosList;
	_actualRadio = [];
	{
		if ( _x in _linkedRadios ) then {
			_actualRadio pushBack _x
		};
	} forEach (assignedItems _unit);
	{_unit unlinkItem _x; _unit removeItems _x;} forEach _actualRadio;
};

switch ( true ) do {
	case ( isClass (configFile >> "CfgPatches" >> "task_force_radio") ): {
		if ( isClass(configFile >> "CfgPatches" >> "tfw_sem52sl") ) then {
			if ( ADV_par_customUni == 1 || ADV_par_customUni == 2 || ADV_par_customWeap == 1 ) then {
				TF_defaultWestPersonalRadio = "tf_sem52sl";
				TF_defaultWestRiflemanRadio = "tf_sem52sl";
			};
		};
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
		switch ADV_par_Radios do {
			//everyone gets role specific radio
			default {
				if ( _givePersonalRadio ) then { _unit linkItem _personalRadioType; };
				if ( _giveRiflemanRadio && _givePersonalRadio ) then { _unit addItem _riflemanRadioType; };
				if ( _giveRiflemanRadio && !_givePersonalRadio ) then { _unit linkItem _riflemanRadioType; };
				if ( _tfar_microdagr > 0 ) then { _unit addItem "tf_microdagr"; };
			};
			//only leaders get Radio
			case 2: {
				if ( _givePersonalRadio ) then { _unit linkItem _personalRadioType; };
			};
			//everyone gets personal radio
			case 3: {
				_unit linkItem _personalRadioType;
			};
		};
	};
	case ( isClass (configFile >> "CfgPatches" >> "acre_main") ): {
		switch ADV_par_Radios do {
			//everyone gets role specific radio
			default {
				{ _unit addItem _x; } forEach _ACREradios;
			};
			//only leaders get Radio
			case 2: {
				_ACREradios deleteAt 0; _ACREradios deleteAt 2;
				{ _unit addItem _x; } forEach _ACREradios;
			};
			//everyone gets personal radio
			case 3: {
				if ( count _ACREradios > 0 ) then { _unit addItem "ACRE_PRC148"; };
			};
		};
	};
	default {
		_unit linkItem "ItemRadio";
	};
};

true;