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
	[0.6] call acre_api_fnc_setLossModelScale;
	//babel:
	private _bluforLanguage = call {
		if (adv_par_customUni == 1 || adv_par_customUni == 2 || adv_par_customWeap == 1) exitWith {"Deutsch"};
		if (true) exitWith {"English"};
	};
	private _opforLanguage = call {
		if (adv_par_opfUni > 0 && adv_par_opfUni < 5) exitWith {"Russian"};
		if (adv_par_opfUni == 20) exitWith {"Chinese"};
		if (true) exitWith {"Farsi"};
	};
	[[west, _bluforLanguage],[east, _opforLanguage],[independent, _bluforLanguage, _opforLanguage],[civilian, _bluforLanguage, _opforLanguage, "Local Language"]] call acre_api_fnc_babelSetupMission;
	["en", _bluforLanguage] call acre_api_fnc_babelAddLanguageType;
	["ru", _opforLanguage] call acre_api_fnc_babelAddLanguageType;
	["gr", "Local Language"] call acre_api_fnc_babelAddLanguageType;
	//channel setup
	/*
	["ACRE_PRC148", "default", "acre_preset_1"] call acre_api_fnc_copyPreset;
	["ACRE_PRC152", "default", "acre_preset_1"] call acre_api_fnc_copyPreset;
	["ACRE_PRC117F", "default", "acre_preset_1"] call acre_api_fnc_copyPreset;
	
	["ACRE_PRC148", "default2", "acre_preset_2"] call acre_api_fnc_copyPreset;
	["ACRE_PRC152", "default2", "acre_preset_2"] call acre_api_fnc_copyPreset;
	["ACRE_PRC117F", "default2", "acre_preset_2"] call acre_api_fnc_copyPreset;
	
	["ACRE_PRC148", "default3", "acre_preset_3"] call acre_api_fnc_copyPreset;
	["ACRE_PRC152", "default3", "acre_preset_3"] call acre_api_fnc_copyPreset;
	["ACRE_PRC117F", "default3", "acre_preset_3"] call acre_api_fnc_copyPreset;
	*/
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

	if (hasInterface) then {
		[] spawn {
			waitUntil { player == player };
			switch ( side (group player) ) do {
				case west: {
					["en"] call acre_api_fnc_babelSetSpokenLanguages;
					["ACRE_PRC152", "default"] call acre_api_fnc_setPreset;
					["ACRE_PRC148", "default"] call acre_api_fnc_setPreset;
					["ACRE_PRC117F", "default"] call acre_api_fnc_setPreset;
				};
				case civilian: {
					["en","ru","gr"] call acre_api_fnc_babelSetSpokenLanguages;
					["ACRE_PRC152", "default"] call acre_api_fnc_setPreset;
					["ACRE_PRC148", "default"] call acre_api_fnc_setPreset;
					["ACRE_PRC117F", "default"] call acre_api_fnc_setPreset;
				};
				case east: {
					["ru"] call acre_api_fnc_babelSetSpokenLanguages;
					["ACRE_PRC152", "default2"] call acre_api_fnc_setPreset;
					["ACRE_PRC148", "default2"] call acre_api_fnc_setPreset;
					["ACRE_PRC117F", "default2"] call acre_api_fnc_setPreset;
				};
				case independent: {
					call {
						if ([independent,west] call BIS_fnc_sideIsFriendly) exitWith {
							["en","ru"] call acre_api_fnc_babelSetSpokenLanguages;
							["ACRE_PRC152", "default"] call acre_api_fnc_setPreset;
							["ACRE_PRC148", "default"] call acre_api_fnc_setPreset;
							["ACRE_PRC117F", "default"] call acre_api_fnc_setPreset;
						};
						if ([independent,east] call BIS_fnc_sideIsFriendly) exitWith {
							["en","ru"] call acre_api_fnc_babelSetSpokenLanguages;
							["ACRE_PRC152", "default2"] call acre_api_fnc_setPreset;
							["ACRE_PRC148", "default2"] call acre_api_fnc_setPreset;
							["ACRE_PRC117F", "default2"] call acre_api_fnc_setPreset;
						};
						["en","ru","gr"] call acre_api_fnc_babelSetSpokenLanguages;
						["ACRE_PRC152", "default3"] call acre_api_fnc_setPreset;
						["ACRE_PRC148", "default3"] call acre_api_fnc_setPreset;
						["ACRE_PRC117F", "default3"] call acre_api_fnc_setPreset;
					};
				};
			};
			waitUntil { [] call acre_api_fnc_isInitialized };
			sleep 10;
			switch true do {
				case ( toUpper (groupID group player) in ["JUPITER","NATTER","LUCHS"] ): {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 6] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 6] call acre_api_fnc_setRadioChannel;
					//[ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
				};
				case ( toUpper (groupID group player) in ["MARS","ANACONDA","LÖWE"] ): {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
				};
				case ( toUpper (groupID group player) in ["DEIMOS","BOA","TIGER"] ): {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
				};
				case ( toUpper (groupID group player) in ["PHOBOS","COBRA","PANTHER"] ): {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 4] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
				};
				case ( toUpper (groupID group player) in ["VULKAN","LEOPARD"] ): {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 5] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
				};
				case ( toUpper (groupID group player) in ["MERKUR","GEPARD"]) : {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 6] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel;
				};
				case ( toUpper (groupID group player) in ["DIANA","VIPER","JAGUAR"] ): {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 7] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 7] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 7] call acre_api_fnc_setRadioChannel;
				};
				case ( toUpper (groupID group player) in ["APOLLO","DRACHE","ORCA"] ): {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 10] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel;					
				};
				case ( toUpper (groupID group player) isEqualTo "ZEUS" ): {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 16] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 16] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 16] call acre_api_fnc_setRadioChannel;
					//[ (["ACRE_PRC117F"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
				};
				default {
					//[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel;
				};
			};
		};
	};
};

	/*
	["ACRE_PRC152", "acre_preset_1", 1, "description", "VEHICLES"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_1", 2, "description", "AIR TO AIR"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_1", 3, "description", "PLTNET 1"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_1", 4, "description", "PLTNET 2"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_1", 5, "description", "PLTNET 3"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_1", 6, "description", "LOG"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_1", 7, "description", "FAC"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_1", 16, "description", "ADMIN"] call acre_api_fnc_setPresetChannelField;

	["ACRE_PRC148", "acre_preset_1", 1, "label", "1-VEHICLES"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_1", 2, "label", "2-AIRNET"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_1", 3, "label", "3-PLTNET 1"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_1", 4, "label", "4-PLTNET 2"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_1", 5, "label", "5-PLTNET 3"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_1", 6, "label", "6-LOG"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_1", 7, "label", "7-FAC"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_1", 16, "label", "16-ADMIN"] call acre_api_fnc_setPresetChannelField;

	["ACRE_PRC117F", "acre_preset_1", 1, "name", "VEHICLES"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_1", 2, "name", "AIR TO AIR"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_1", 3, "name", "PLTNET 1"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_1", 4, "name", "PLTNET 2"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_1", 5, "name", "PLTNET 3"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_1", 6, "name", "LOG"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_1", 7, "name", "FAC"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_1", 16, "name", "ADMIN"] call acre_api_fnc_setPresetChannelField;
	
	["ACRE_PRC152", "acre_preset_2", 1, "description", "VEHICLES"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_2", 2, "description", "AIR TO AIR"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_2", 3, "description", "PLTNET 1"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_2", 4, "description", "PLTNET 2"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_2", 5, "description", "PLTNET 3"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_2", 6, "description", "LOG"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_2", 7, "description", "FAC"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_2", 16, "description", "ADMIN"] call acre_api_fnc_setPresetChannelField;

	["ACRE_PRC148", "acre_preset_2", 1, "label", "1-VEHICLES"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_2", 2, "label", "2-AIRNET"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_2", 3, "label", "3-PLTNET 1"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_2", 4, "label", "4-PLTNET 2"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_2", 5, "label", "5-PLTNET 3"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_2", 6, "label", "6-LOG"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_2", 7, "label", "7-FAC"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_2", 16, "label", "16-ADMIN"] call acre_api_fnc_setPresetChannelField;

	["ACRE_PRC117F", "acre_preset_2", 1, "name", "VEHICLES"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_2", 2, "name", "AIR TO AIR"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_2", 3, "name", "PLTNET 1"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_2", 4, "name", "PLTNET 2"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_2", 5, "name", "PLTNET 3"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_2", 6, "name", "LOG"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_2", 7, "name", "FAC"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_2", 16, "name", "ADMIN"] call acre_api_fnc_setPresetChannelField;
	*/