/*
 * Author: Belbo
 *
 * Adds radio items to to unit depending on adv_missiontemplate-variables - has to be called by adv_fnc_gear;
 *
 * Arguments:
 * 0: target - <OBJECT>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [player] call adv_fnc_addRadios;
 *
 * Public: No
 */

params [
	["_unit", player, [objNull]]
];

//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

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
		switch _par_Radios do {
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
			case east: { missionNamespace getVariable ["acre_eastPersonalRadio","ACRE_PRC148"] };
			case independent: { missionNamespace getVariable ["acre_guerPersonalRadio","ACRE_PRC148"] };
			default { missionNamespace getVariable ["acre_westPersonalRadio","ACRE_PRC152"] };
		};
		_backpackRadioType = switch ( side (group _unit) ) do {
			case east: { missionNamespace getVariable ["acre_eastBackpackRadio","ACRE_PRC117F"] };
			case independent: { missionNamespace getVariable ["acre_guerBackpackRadio","ACRE_PRC117F"] };
			default { missionNamespace getVariable ["acre_westBackpackRadio","ACRE_PRC117F"] };
		};
		switch _par_Radios do {
			//everyone gets role specific radio
			default {
				if ( _giveRiflemanRadio ) then { _unit addItem _riflemanRadioType; };
				if ( _givePersonalRadio ) then { _unit addItem _personalRadioType; };
				if ( _giveBackpackRadio ) then { _unit addItemToBackpack _backpackRadioType; };
			};
			//only leaders get Radio
			case 2: {
				if ( (toUpper (rank _unit)) in ["SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"] ) then {
					call {
						if (_giveBackpackRadio) exitWith {
							_unit additemToBackpack _backpackRadioType
						};
						_unit addItem _personalRadioType;
					};
				};
			};
			//everyone gets personal radio
			case 3: {
				_unit addItem _riflemanRadioType;
				_unit addItem _personalRadioType;
				if ( _giveBackpackRadio ) then { _unit addItemToBackpack _backpackRadioType; };
			};
		};
	};
	default {
		switch _par_Radios do {
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

true;