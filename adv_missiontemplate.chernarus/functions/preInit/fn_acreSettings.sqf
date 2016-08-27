/*
ADV_fnc_acreSettings by Belbo
contains all the variables that are important for acre2
*/

if ( isClass (configFile >> "CfgPatches" >> "acre_main") ) exitWith {
	//Initialize ACRE radios
	[true, true] call acre_api_fnc_setupMission;
	[true] call acre_api_fnc_setRevealToAI;
	[false] call acre_api_fnc_setFullDuplex;
	[true] call acre_api_fnc_setInterference;
	[true] call acre_api_fnc_ignoreAntennaDirection;
	[0.15] call acre_api_fnc_setLossModelScale;
	//radios
	acre_westPersonalRadio = "ACRE_PRC152";
	acre_eastPersonalRadio = "ACRE_PRC148";
	acre_guerPersonalRadio = "ACRE_PRC148";
	
	acre_westRiflemanRadio = "ACRE_PRC343";
	acre_eastRiflemanRadio = "ACRE_PRC343";
	acre_gerRiflemanRadio = "ACRE_PRC343";
	
	acre_westBackpackRadio = "ACRE_PRC117F";
	acre_eastBackpackRadio = "ACRE_PRC117F";
	acre_guerBackpackRadio = "ACRE_PRC117F";
	//channel setup
	_channelNames = ["VEHICLES","AIR TO AIR","PLTNET 1","PLTNET 2","PLTNET 3","LOG","FAC","CHAN 8","CHAN 9","CHAN 10","CHAN 11","CHAN 12","CHAN 13","CHAN 14","CHAN 15"];
	_148chNames = ["1-VEHICLES","2-AIR TO AIR","3-PLTNET 1","4-PLTNET 2","5-PLTNET 3","6-LOG","7-FAC"];
	for "_i" from 1 to (count _channelNames) do {
		["ACRE_PRC152", "default", _i, "description", _channelNames select (_i-1)] call acre_api_fnc_setPresetChannelField;
		["ACRE_PRC117F", "default", _i, "name", _channelNames select (_i-1)] call acre_api_fnc_setPresetChannelField;
		
		["ACRE_PRC152", "default2", _i, "description", _channelNames select (_i-1)] call acre_api_fnc_setPresetChannelField;
		["ACRE_PRC117F", "default2", _i, "name", _channelNames select (_i-1)] call acre_api_fnc_setPresetChannelField;
		
		["ACRE_PRC152", "default3", _i, "description", _channelNames select (_i-1)] call acre_api_fnc_setPresetChannelField;
		["ACRE_PRC117F", "default3", _i, "name", _channelNames select (_i-1)] call acre_api_fnc_setPresetChannelField;
	};
	for "_i" from 1 to (count _148chNames) do {
		["ACRE_PRC148", "default", _i, "label", _148chNames select (_i-1)] call acre_api_fnc_setPresetChannelField;
		["ACRE_PRC148", "default2", _i, "label", _148chNames select (_i-1)] call acre_api_fnc_setPresetChannelField;
		["ACRE_PRC148", "default3", _i, "label", _148chNames select (_i-1)] call acre_api_fnc_setPresetChannelField;
	};
	["ACRE_PRC148", format ["default",_i], 16, "label", "16-ADMIN"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", format ["default",_i], 16, "description", "ADMIN"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", format ["default",_i], 16, "name", "ADMIN"] call acre_api_fnc_setPresetChannelField;
	for "_i" from 2 to 3 do {
		["ACRE_PRC148", format ["default%1",_i], 16, "label", "16-ADMIN"] call acre_api_fnc_setPresetChannelField;
		["ACRE_PRC152", format ["default%1",_i], 16, "description", "ADMIN"] call acre_api_fnc_setPresetChannelField;
		["ACRE_PRC117F", format ["default%1",_i], 16, "name", "ADMIN"] call acre_api_fnc_setPresetChannelField;
	};

	[] spawn {
		waitUntil {!isNil "ADV_params_defined"};
		//specific radio types
		if (adv_par_customUni isEqualTo 9) then {
			acre_westPersonalRadio = "ACRE_PRC148";
			acre_westBackpackRadio = "ACRE_PRC77";
		};
		if (adv_par_opfUni isEqualTo 5 || adv_par_opfUni isEqualTo 6) then {
			acre_eastBackpackRadio = "ACRE_PRC77";
		};
		if (adv_par_indUni isEqualTo 20) then {
			acre_guerBackpackRadio = "ACRE_PRC77";
		};
		private _bluforLanguage = call {
			if (adv_par_customUni == 1 || adv_par_customUni == 2 || adv_par_customWeap == 1) exitWith {"Deutsch"};
			if (true) exitWith {"English"};
		};
		private _opforLanguage = call {
			if (adv_par_opfUni > 0 && adv_par_opfUni < 5) exitWith {"Russian"};
			if (adv_par_opfUni == 20) exitWith {"Chinese"};
			if (true) exitWith {"Farsi"};
		};
		//babel:
		[[west, _bluforLanguage],[east, _opforLanguage],[independent, _bluforLanguage, _opforLanguage],[civilian, _bluforLanguage, _opforLanguage, "Local Language"]] call acre_api_fnc_babelSetupMission;
		["en", _bluforLanguage] call acre_api_fnc_babelAddLanguageType;
		["ru", _opforLanguage] call acre_api_fnc_babelAddLanguageType;
		["gr", "Local Language"] call acre_api_fnc_babelAddLanguageType;
		
		//local stuff:
		if (hasInterface) then {
			waitUntil { player == player && time > 1};
			//presets and languages per side:
			switch ( side (group player) ) do {
				case west: {
					["ACRE_PRC152", "default"] call acre_api_fnc_setPreset;
					["ACRE_PRC148", "default"] call acre_api_fnc_setPreset;
					["ACRE_PRC117F", "default"] call acre_api_fnc_setPreset;
					private _languages = if (adv_par_acreBabel isEqualTo 0) then {["en"]} else {["en","ru","gr"]};
					_languages call acre_api_fnc_babelSetSpokenLanguages;
				};
				case civilian: {
					["en","ru","gr"] call acre_api_fnc_babelSetSpokenLanguages;
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
					private _languages = if (adv_par_acreBabel isEqualTo 0) then {["ru"]} else {["en","ru","gr"]};
					_languages call acre_api_fnc_babelSetSpokenLanguages;
				};
				case independent: {
					call {
						if ([independent,west] call BIS_fnc_sideIsFriendly || adv_par_acrePresets isEqualTo 1) exitWith {
							private _languages = if (adv_par_acreBabel isEqualTo 0) then {["en","gr"]} else {["en","ru","gr"]};
							_languages call acre_api_fnc_babelSetSpokenLanguages;
							["ACRE_PRC152", "default"] call acre_api_fnc_setPreset;
							["ACRE_PRC148", "default"] call acre_api_fnc_setPreset;
							["ACRE_PRC117F", "default"] call acre_api_fnc_setPreset;
						};
						if ([independent,east] call BIS_fnc_sideIsFriendly) exitWith {
							private _languages = if (adv_par_acreBabel isEqualTo 0) then {["ru","gr"]} else {["en","ru","gr"]};
							_languages call acre_api_fnc_babelSetSpokenLanguages;
							["ACRE_PRC152", "default2"] call acre_api_fnc_setPreset;
							["ACRE_PRC148", "default2"] call acre_api_fnc_setPreset;
							["ACRE_PRC117F", "default2"] call acre_api_fnc_setPreset;
						};
						private _languages = if (adv_par_acreBabel isEqualTo 0) then {["gr"]} else {["en","ru","gr"]};
						_languages call acre_api_fnc_babelSetSpokenLanguages;
						["ACRE_PRC152", "default3"] call acre_api_fnc_setPreset;
						["ACRE_PRC148", "default3"] call acre_api_fnc_setPreset;
						["ACRE_PRC117F", "default3"] call acre_api_fnc_setPreset;
					};
				};
			};
			waitUntil { [] call acre_api_fnc_isInitialized };
			sleep 5;
			//set channels for groups:
			switch true do {
				case ( toUpper (groupID group player) in ["JUPITER","NATTER","LUCHS"] ): {
					if ([player, "ACRE_PRC343"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC152"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 6] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC148"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 6] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC117F"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
				};
				case ( toUpper (groupID group player) in ["MARS","ANAKONDA","LÖWE"] ): {
					if ([player, "ACRE_PRC343"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC152"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC148"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC117F"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
				};
				case ( toUpper (groupID group player) in ["DEIMOS","BOA","TIGER"] ): {
					if ([player, "ACRE_PRC343"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC152"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC148"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC117F"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
				};
				case ( toUpper (groupID group player) in ["PHOBOS","COBRA","PANTHER"] ): {
					if ([player, "ACRE_PRC343"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 4] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC152"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC148"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC117F"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
				};
				case ( toUpper (groupID group player) in ["VULKAN","LEOPARD"] ): {
					if ([player, "ACRE_PRC343"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 5] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC152"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC148"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC117F"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
				};
				case ( toUpper (groupID group player) in ["MERKUR","GEPARD"]) : {
					if ([player, "ACRE_PRC343"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 6] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC152"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC148"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC117F"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel; };
				};
				case ( toUpper (groupID group player) in ["DIANA","VIPER","JAGUAR"] ): {
					if ([player, "ACRE_PRC343"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 7] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC152"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 7] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC148"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 7] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC117F"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
				};
				case ( toUpper (groupID group player) in ["APOLLO","DRACHE","ORCA"] ): {
					if ([player, "ACRE_PRC343"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 8] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC152"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC148"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC117F"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel; };
				};
				case ( toUpper (groupID group player) isEqualTo "ZEUS" ): {
					if ([player, "ACRE_PRC343"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 16] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC152"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 16] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC148"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 16] call acre_api_fnc_setRadioChannel; };
					if ([player, "ACRE_PRC117F"] call acre_api_fnc_hasKindOfRadio) then { [ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel; };
					["en","ru","gr"] call acre_api_fnc_babelSetSpokenLanguages;
				};
				default {};
			};
		};
	};
};