/*
ADV_fnc_acreSettings by Belbo
contains all the variables that are important for acre2
*/
params [
	["_unit", player, [objNull]]
];

//set frequencies depending on group for tfar
if ( isClass (configFile >> "CfgPatches" >> "task_force_radio") && hasInterface ) exitWith {
	waitUntil { time > 1 && call TFAR_fnc_haveSWRadio };
	call {
		private _activeSWRadio = call TFAR_fnc_activeSwRadio;
		private _hasLRRadio = call TFAR_fnc_haveLRRadio;			
		private _activeLRRadio = if (_hasLRRadio) then {call TFAR_fnc_activeLRRadio} else {["",0]};
		if ( toUpper (groupID group _unit) in ["JUPITER","NATTER","LUCHS"] ) exitWith {
			[_activeSWRadio, 0] call TFAR_fnc_setSwChannel;
			if (_hasLRRadio) then {
				[_activeLRRadio select 0, _activeLRRadio select 1, 5] call TFAR_fnc_setAdditionalLrChannel;
				[_activeLRRadio select 0, _activeLRRadio select 1, 2] call TFAR_fnc_setLRChannel;
			};
		};
		if ( toUpper (groupID group _unit) in ["MARS","ANAKONDA","LÖWE"] ) exitWith {
			[_activeSWRadio, 1] call TFAR_fnc_setSwChannel;
			if (_hasLRRadio) then { [_activeLRRadio select 0, _activeLRRadio select 1, 2] call TFAR_fnc_setLRChannel; };
		};
		if ( toUpper (groupID group _unit) in ["DEIMOS","BOA","TIGER"] ) exitWith {
			[_activeSWRadio, 2] call TFAR_fnc_setSwChannel;
			if (_hasLRRadio) then { [_activeLRRadio select 0, _activeLRRadio select 1, 2] call TFAR_fnc_setLRChannel; };
		};
		if ( toUpper (groupID group _unit) in ["PHOBOS","COBRA","PANTHER"] ) exitWith {
			[_activeSWRadio, 3] call TFAR_fnc_setSwChannel;
			if (_hasLRRadio) then { [_activeLRRadio select 0, _activeLRRadio select 1, 2] call TFAR_fnc_setLRChannel; };
		};
		if ( toUpper (groupID group _unit) in ["VULKAN","LEOPARD"] ) exitWith {
			[_activeSWRadio, 4] call TFAR_fnc_setSwChannel;
			if (_hasLRRadio) then { [_activeLRRadio select 0, _activeLRRadio select 1, 2] call TFAR_fnc_setLRChannel; };
		};
		if ( toUpper (groupID group _unit) in ["DIANA","VIPER","JAGUAR"] ) exitWith {
			[_activeSWRadio, 5] call TFAR_fnc_setSwChannel;
			if (_hasLRRadio) then { [_activeLRRadio select 0, _activeLRRadio select 1, 3] call TFAR_fnc_setLRChannel; };
		};
		if ( toUpper (groupID group _unit) in ["APOLLO","DRACHE","ORCA"] ) exitWith {
			[_activeSWRadio, 6] call TFAR_fnc_setSwChannel;
			if (_hasLRRadio) then { [_activeLRRadio select 0, _activeLRRadio select 1, 1] call TFAR_fnc_setLRChannel; };
		};
		if ( toUpper (groupID group _unit) in ["MERKUR","GEPARD"]) exitWith {
			[_activeSWRadio, 7] call TFAR_fnc_setSwChannel;
			if (_hasLRRadio) then { [_activeLRRadio select 0, _activeLRRadio select 1, 5] call TFAR_fnc_setLRChannel; };
		};
		if ( toUpper (groupID group _unit) in ["SATURN","OZELOT"]) exitWith {
			[_activeSWRadio, 0] call TFAR_fnc_setSwChannel;
			if (_hasLRRadio) then { [_activeLRRadio select 0, _activeLRRadio select 1, 0] call TFAR_fnc_setLRChannel; };
		};
		if ( toUpper (groupID group _unit) isEqualTo "ZEUS" ) exitWith {
			[_activeSWRadio, 0] call TFAR_fnc_setSwChannel;
			if (_hasLRRadio) then { [_activeLRRadio select 0, _activeLRRadio select 1, 2] call TFAR_fnc_setLRChannel; };
		};
	};
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
	//ChannelnameS: ["VEHICLES","AIRNET","PLTNET 1","PLTNET 2","PLTNET 3","LOG","FAC","CHAN 8","CHAN 9","CHAN 10","CHAN 11","CHAN 12","CHAN 13","CHAN 14","CHAN 15"];
	call {
		private _has343 = [_unit, "ACRE_PRC343"] call acre_api_fnc_hasKindOfRadio;
		private _has152 = [_unit, "ACRE_PRC152"] call acre_api_fnc_hasKindOfRadio;
		private _has148 = [_unit, "ACRE_PRC148"] call acre_api_fnc_hasKindOfRadio;
		private _has117F = [_unit, "ACRE_PRC117F"] call acre_api_fnc_hasKindOfRadio;
		if ( toUpper (groupID group _unit) in ["JUPITER","NATTER","LUCHS"] ) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 6] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 6] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) in ["MARS","ANAKONDA","LÖWE"] ) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) in ["DEIMOS","BOA","TIGER"] ) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) in ["PHOBOS","COBRA","PANTHER"] ) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 4] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) in ["VULKAN","LEOPARD"] ) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 5] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) in ["MERKUR","GEPARD"]) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 6] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 5] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) in ["DIANA","VIPER","JAGUAR"] ) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 7] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 7] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 7] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) in ["APOLLO","DRACHE","ORCA"] ) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 8] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) in ["SATURN","OZELOT"]) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 9] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
		};
		if ( toUpper (groupID group _unit) isEqualTo "ZEUS" ) exitWith {
			if (_has343) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 16] call acre_api_fnc_setRadioChannel; };
			if (_has152) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 16] call acre_api_fnc_setRadioChannel; };
			if (_has148) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 16] call acre_api_fnc_setRadioChannel; };
			if (_has117F) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
			["en","ru","gr"] call acre_api_fnc_babelSetSpokenLanguages;
		};
	};
};