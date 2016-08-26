/*
ADV_fnc_acreSettings by Belbo
contains all the variables that are important for acre2
*/

if ( isClass (configFile >> "CfgPatches" >> "acre_main") ) exitWith {

	//Initialize ACRE radios
	[true] call acre_api_fnc_setRevealToAI;
	[false] call acre_api_fnc_setFullDuplex;
	[false] call acre_api_fnc_setInterference;
	[0.6] call acre_api_fnc_setLossModelScale;
	//babel:
	[[west, "English"],[east, "Russian"],[independent, "English", "Russian"],[civilian, "English", "Russian"]] call acre_api_fnc_setupMission;
	["en", "English"] call acre_api_fnc_babelAddLanguageType;
	["ru", "Russian"] call acre_api_fnc_babelAddLanguageType;
	if (hasInterface) then {
		[] spawn {
			waitUntil {player == player};
			switch ( side (group player) ) do {
				case west: {
					["en"] call acre_api_fnc_babelSetSpokenLanguages;
				};
				case civilian: {
					["en","ru"] call acre_api_fnc_babelSetSpokenLanguages;
				};
				case east: {
					["ru"] call acre_api_fnc_babelSetSpokenLanguages;
				};
				case independent: {
					["en","ru"] call acre_api_fnc_babelSetSpokenLanguages;
				};
			};
		};
	};
	//channel setup
	["ACRE_PRC148", "default", "acre_preset_1"] call acre_api_fnc_copyPreset;
	["ACRE_PRC152", "default", "acre_preset_1"] call acre_api_fnc_copyPreset;
	["ACRE_PRC117F", "default", "acre_preset_1"] call acre_api_fnc_copyPreset;
	
	["ACRE_PRC152", "acre_preset_1", 1, "description", "VEHICLES"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_1", 2, "description", "AIR TO AIR"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_1", 3, "description", "PLTNET 1"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_1", 4, "description", "PLTNET 2"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_1", 5, "description", "LOG"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", "acre_preset_1", 6, "description", "FAC"] call acre_api_fnc_setPresetChannelField;

	["ACRE_PRC148", "acre_preset_1", 1, "label", "1-VEHICLES"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_1", 2, "label", "2-AIRNET"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_1", 3, "label", "3-PLTNET 1"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_1", 4, "label", "4-PLTNET 2"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_1", 5, "label", "5-LOG"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC148", "acre_preset_1", 6, "label", "6-FAC"] call acre_api_fnc_setPresetChannelField;

	["ACRE_PRC117F", "acre_preset_1", 1, "name", "VEHICLES"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_1", 2, "name", "AIR TO AIR"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_1", 3, "name", "PLTNET 1"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_1", 4, "name", "PLTNET 2"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_1", 5, "name", "LOG"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", "acre_preset_1", 6, "name", "FAC"] call acre_api_fnc_setPresetChannelField;
	
	if (hasInterface) then {
		[] spawn {
			waitUntil { ([] call acre_api_fnc_isInitialized) && time > 5 };
			sleep 5;
			switch (toUpper (groupID group player)) do {
				case "JUPITER": {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
				};
				case "MARS": {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
				};
				case "DEIMOS": {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
				};
				case "PHOBOS": {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 4] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
				};
				case "VULKAN": {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 5] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel;
				};
				case "MERKUR": {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 6] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel;
				};
				case "DIANA 1": {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 7] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 6] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 6] call acre_api_fnc_setRadioChannel;
				};
				case "DIANA 2": {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 8] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 6] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 6] call acre_api_fnc_setRadioChannel;
				};
				case "APOLLO": {
					[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 10] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC152"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel;
					[ (["ACRE_PRC148"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel;					
				};
				default {
					//[ (["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel;
				};
			};
		};
	};
	
};