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
		nil;
	} count (assignedItems _unit);
	{_unit unlinkItem _x; _unit removeItems _x;} count _actualRadio;
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
	/*
			//radios
			acre_westBackpackRadio = "ACRE_PRC117F";
			acre_eastBackpackRadio = "ACRE_PRC117F";
			acre_guerBackpackRadio = "ACRE_PRC117F";
			//specific radio types
			if (adv_par_customUni isEqualTo 9) then {
				acre_westBackpackRadio = "ACRE_PRC77";
			};
			if (adv_par_opfUni isEqualTo 5 || adv_par_opfUni isEqualTo 6) then {
				acre_eastBackpackRadio = "ACRE_PRC77";
			};
			if (adv_par_indUni isEqualTo 20) then {
				acre_guerBackpackRadio = "ACRE_PRC77";
			};
			*/
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

[_unit] spawn adv_fnc_setFrequencies;

true;