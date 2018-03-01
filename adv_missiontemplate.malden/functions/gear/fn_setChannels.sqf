/*
 * Author: Belbo
 *
 * Sets the player's radio (with acre and tfar) to a certain channel depending on his group. Frequencies will be reset to the standard from adv_fnc_tfarSettings.
 *
 * Arguments:
 * 0: target - <OBJECT>
 *
 * Return Value:
 * tfar/acre present and set? - <BOOL>
 *
 * Example:
 * [player] call adv_fnc_setChannels;
 *
 * Public: No
 */

params [
	["_unit", player, [objNull]]
];

/*
LR-Kreise:
1. Landfahrzeuge
2. Kampfkreis
3. Sonderkreis
4. Sonderkreis
5. Sonderkreis
6. Sonderkreis
7. Einsatzunterstützung
8. Logistik
9. OPZ/Zeus
*/

private _groups = call adv_fnc_radioGroups;
_groups = _groups apply { _x apply {toUpper _x} };
_groups params [
	"_sr_0","_sr_1","_sr_2","_sr_3","_sr_4","_sr_5","_sr_6","_sr_7"
	,"_lr_1","_lr_2","_lr_3","_lr_4","_lr_5","_lr_6","_lr_7","_lr_8","_lr_9"
];

//set frequencies depending on group for tfar
if ( isClass (configFile >> "CfgPatches" >> "tfar_core") && hasInterface ) exitWith {
	waitUntil { time > 1 && call TFAR_fnc_haveSWRadio };
	[_unit] call adv_fnc_setFrequencies;
	call {
		private _activeSWRadio = call TFAR_fnc_activeSwRadio;
		if ( toUpper (groupID group _unit) in _sr_1 ) exitWith {
			[_activeSWRadio, 1] call TFAR_fnc_setSwChannel;
		};
		if ( toUpper (groupID group _unit) in _sr_2 ) exitWith {
			[_activeSWRadio, 2] call TFAR_fnc_setSwChannel;
		};
		if ( toUpper (groupID group _unit) in _sr_3 ) exitWith {
			[_activeSWRadio, 3] call TFAR_fnc_setSwChannel;
		};
		if ( toUpper (groupID group _unit) in _sr_4 ) exitWith {
			[_activeSWRadio, 4] call TFAR_fnc_setSwChannel;
		};
		if ( toUpper (groupID group _unit) in _sr_5 ) exitWith {
			[_activeSWRadio, 5] call TFAR_fnc_setSwChannel;
		};
		if ( toUpper (groupID group _unit) in _sr_6 ) exitWith {
			[_activeSWRadio, 6] call TFAR_fnc_setSwChannel;
		};
		if ( toUpper (groupID group _unit) in _sr_7 ) exitWith {
			[_activeSWRadio, 7] call TFAR_fnc_setSwChannel;
		};
		[_activeSWRadio, 0] call TFAR_fnc_setSwChannel;
	};
	call {
		private _hasLRRadio = call TFAR_fnc_haveLRRadio;
		private _activeLRRadio = if (_hasLRRadio) then {call TFAR_fnc_activeLRRadio} else {[""]};
		if !( _hasLRRadio ) exitWith {};
		if ( toUpper (groupID group _unit) in _lr_2 ) exitWith {
			[_activeLRRadio, 2] call TFAR_fnc_setLRChannel;
		};
		if ( toUpper (groupID group _unit) in _lr_3 ) exitWith {
			[_activeLRRadio, 3] call TFAR_fnc_setLRChannel;
		};
		if ( toUpper (groupID group _unit) in _lr_4 ) exitWith {
			[_activeLRRadio, 4] call TFAR_fnc_setLRChannel;
		};
		if ( toUpper (groupID group _unit) in _lr_5 ) exitWith {
			[_activeLRRadio, 5] call TFAR_fnc_setLRChannel;
		};
		if ( toUpper (groupID group _unit) in _lr_6 ) exitWith {
			[_activeLRRadio, 6] call TFAR_fnc_setLRChannel;
		};
		if ( toUpper (groupID group _unit) in _lr_7 ) exitWith {
			[_activeLRRadio, 7] call TFAR_fnc_setLRChannel;
		};
		if ( toUpper (groupID group _unit) in _lr_8 ) exitWith {
			[_activeLRRadio, 8] call TFAR_fnc_setLRChannel;
		};
		[_activeLRRadio, 1] call TFAR_fnc_setLRChannel;
	};
	true;
};

if ( isClass (configFile >> "CfgPatches" >> "task_force_radio") && hasInterface ) exitWith {
	waitUntil { time > 1 && call TFAR_fnc_haveSWRadio };

	call {
		private _activeSWRadio = call TFAR_fnc_activeSwRadio;
		if ( toUpper (groupID group _unit) in _sr_1 ) exitWith {
			[_activeSWRadio, 1] call TFAR_fnc_setSwChannel;
		};
		if ( toUpper (groupID group _unit) in _sr_2 ) exitWith {
			[_activeSWRadio, 2] call TFAR_fnc_setSwChannel;
		};
		if ( toUpper (groupID group _unit) in _sr_3 ) exitWith {
			[_activeSWRadio, 3] call TFAR_fnc_setSwChannel;
		};
		if ( toUpper (groupID group _unit) in _sr_4 ) exitWith {
			[_activeSWRadio, 4] call TFAR_fnc_setSwChannel;
		};
		if ( toUpper (groupID group _unit) in _sr_5 ) exitWith {
			[_activeSWRadio, 5] call TFAR_fnc_setSwChannel;
		};
		if ( toUpper (groupID group _unit) in _sr_6 ) exitWith {
			[_activeSWRadio, 6] call TFAR_fnc_setSwChannel;
		};
		if ( toUpper (groupID group _unit) in _sr_7 ) exitWith {
			[_activeSWRadio, 7] call TFAR_fnc_setSwChannel;
		};
		[_activeSWRadio, 0] call TFAR_fnc_setSwChannel;
	};
	call {
		private _hasLRRadio = call TFAR_fnc_haveLRRadio;
		private _activeLRRadio = if (_hasLRRadio) then {call TFAR_fnc_activeLRRadio} else {[""]};
		if !( _hasLRRadio ) exitWith {};
		if ( toUpper (groupID group _unit) in _lr_2 ) exitWith {
			[_activeLRRadio select 0, _activeLRRadio select 1, 2] call TFAR_fnc_setLRChannel;
		};
		if ( toUpper (groupID group _unit) in _lr_3 ) exitWith {
			[_activeLRRadio select 0, _activeLRRadio select 1, 3] call TFAR_fnc_setLRChannel;
		};
		if ( toUpper (groupID group _unit) in _lr_4 ) exitWith {
			[_activeLRRadio select 0, _activeLRRadio select 1, 4] call TFAR_fnc_setLRChannel;
		};
		if ( toUpper (groupID group _unit) in _lr_5 ) exitWith {
			[_activeLRRadio select 0, _activeLRRadio select 1, 5] call TFAR_fnc_setLRChannel;
		};
		if ( toUpper (groupID group _unit) in _lr_6 ) exitWith {
			[_activeLRRadio select 0, _activeLRRadio select 1, 6] call TFAR_fnc_setLRChannel;
		};
		if ( toUpper (groupID group _unit) in _lr_7 ) exitWith {
			[_activeLRRadio select 0, _activeLRRadio select 1, 7] call TFAR_fnc_setLRChannel;
		};
		if ( toUpper (groupID group _unit) in _lr_8 ) exitWith {
			[_activeLRRadio select 0, _activeLRRadio select 1, 8] call TFAR_fnc_setLRChannel;
		};
		[_activeLRRadio select 0, _activeLRRadio select 1, 1] call TFAR_fnc_setLRChannel;
	};
	true;
};
//set frequencies depending on group for acre
if ( isClass (configFile >> "CfgPatches" >> "acre_main") && hasInterface ) exitWith {
	//presets per side:
	switch ( side (group _unit) ) do {
		case west: {
			["ACRE_PRC152", "default"] call acre_api_fnc_setPreset;
			["ACRE_PRC148", "default"] call acre_api_fnc_setPreset;
			["ACRE_PRC117F", "default"] call acre_api_fnc_setPreset;
		};
		case civilian: {
			["ACRE_PRC152", "default"] call acre_api_fnc_setPreset;
			["ACRE_PRC148", "default"] call acre_api_fnc_setPreset;
			["ACRE_PRC117F", "default"] call acre_api_fnc_setPreset;
		};
		case east: {
			call {
				if (adv_par_acrePresets isEqualTo 0) exitWith {
					["ACRE_PRC152", "default2"] call acre_api_fnc_setPreset;
					["ACRE_PRC148", "default2"] call acre_api_fnc_setPreset;
					["ACRE_PRC117F", "default2"] call acre_api_fnc_setPreset;
				};
				["ACRE_PRC152", "default"] call acre_api_fnc_setPreset;
				["ACRE_PRC148", "default"] call acre_api_fnc_setPreset;
				["ACRE_PRC117F", "default"] call acre_api_fnc_setPreset;
			};
		};
		case independent: {
			call {
				if ([independent,west] call BIS_fnc_sideIsFriendly || adv_par_acrePresets isEqualTo 1) exitWith {
					["ACRE_PRC152", "default"] call acre_api_fnc_setPreset;
					["ACRE_PRC148", "default"] call acre_api_fnc_setPreset;
					["ACRE_PRC117F", "default"] call acre_api_fnc_setPreset;
				};
				if ([independent,east] call BIS_fnc_sideIsFriendly) exitWith {
					["ACRE_PRC152", "default2"] call acre_api_fnc_setPreset;
					["ACRE_PRC148", "default2"] call acre_api_fnc_setPreset;
					["ACRE_PRC117F", "default2"] call acre_api_fnc_setPreset;
				};
				["ACRE_PRC152", "default3"] call acre_api_fnc_setPreset;
				["ACRE_PRC148", "default3"] call acre_api_fnc_setPreset;
				["ACRE_PRC117F", "default3"] call acre_api_fnc_setPreset;
			};
		};
	};
	waitUntil { [] call acre_api_fnc_isInitialized };
	//set channels for groups:
	//["1-VEHICLES","2-PLTNET 1","3-LOG","4-RECON","5-AIRNET"];
	call {
		private _has343 = [_unit, "ACRE_PRC343"] call acre_api_fnc_hasKindOfRadio;
		private _has152 = [_unit, "ACRE_PRC152"] call acre_api_fnc_hasKindOfRadio;
		private _has148 = [_unit, "ACRE_PRC148"] call acre_api_fnc_hasKindOfRadio;
		private _has117F = [_unit, "ACRE_PRC117F"] call acre_api_fnc_hasKindOfRadio;
		if ( toUpper (groupID group _unit) in ["JUPITER","NATTER","LUCHS"] ) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) in ["MARS","ANAKONDA","LÖWE"] ) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) in ["DEIMOS","BOA","TIGER"] ) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) in ["PHOBOS","COBRA","PANTHER"] ) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 4] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) in ["VULKAN","LEOPARD"] ) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 5] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) in ["MERKUR","GEPARD"]) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 6] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) in ["APOLLO","DRACHE","ORCA"] ) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 7] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 5] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 5] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 5] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) in ["SATURN","OZELOT"]) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 8] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) in ["DIANA","VIPER","JAGUAR"] ) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 9] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 4] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 4] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 4] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) isEqualTo "ZEUS" ) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 16] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 16] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 16] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
			["en","ru","gr"] call acre_api_fnc_babelSetSpokenLanguages;
		};
	};
	true;
};

false;