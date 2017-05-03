/*
 * Author: Belbo
 *
 * Contains all the variables important for acre.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * acre present and set? - <BOOL>
 *
 * Example:
 * [] call adv_fnc_acreSettings;
 *
 * Public: No
 */
 
if !( isClass (configFile >> "CfgPatches" >> "acre_main") ) exitWith { false };

//params needed in case paramsArray not yet defined on client in MP
missionNamespace getVariable ["adv_par_customUni", ["param_customUni",0] call BIS_fnc_getParamValue];
missionNamespace getVariable ["adv_par_customWeap", ["param_customWeap",0] call BIS_fnc_getParamValue];
missionNamespace getVariable ["adv_par_opfUni", ["param_opfUni",0] call BIS_fnc_getParamValue];
missionNamespace getVariable ["adv_par_opfWeap", ["param_opfWeap",0] call BIS_fnc_getParamValue];
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

acre_westBackpackRadio = call {
	if !(adv_par_customUni isEqualTo 9) exitWith {"ACRE_PRC117F"};
	if (true) exitWith {"ACRE_PRC77"};
};
acre_eastBackpackRadio = call {
	if !(adv_par_opfUni isEqualTo 5 || adv_par_opfUni isEqualTo 6) exitWith {"ACRE_PRC117F"};
	if (true) exitWith {"ACRE_PRC77"};
};
acre_guerBackpackRadio = call {
	if !(adv_par_indUni isEqualTo 20) exitWith {"ACRE_PRC117F"};
	if (true) exitWith {"ACRE_PRC77"};
};
//channel setup
_channelNames = ["VEHICLES","PLTNET 1","LOG","RECON","AIRNET","PLTNET 2","PLTNET 3","PLTNET 4","CHAN 9","CHAN 10","CHAN 11","CHAN 12","CHAN 13","CHAN 14","CHAN 15"];
_148chNames = ["1-VEHICLES","2-PLTNET 1","3-LOG","4-RECON","5-AIRNET"];
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
//zeus channel
["ACRE_PRC148", "default", 16, "label", "16-ADMIN"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC152", "default", 16, "description", "ADMIN"] call acre_api_fnc_setPresetChannelField;
["ACRE_PRC117F", "default", 16, "name", "ADMIN"] call acre_api_fnc_setPresetChannelField;
for "_i" from 2 to 3 do {
	["ACRE_PRC148", format ["default%1",_i], 16, "label", "16-ADMIN"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC152", format ["default%1",_i], 16, "description", "ADMIN"] call acre_api_fnc_setPresetChannelField;
	["ACRE_PRC117F", format ["default%1",_i], 16, "name", "ADMIN"] call acre_api_fnc_setPresetChannelField;
};

[] spawn {
	waitUntil {!isNil "ADV_params_defined"};
	
	//babel:
	private _bluforLanguage = call {
		if (adv_par_customUni isEqualTo 1 || adv_par_customUni isEqualTo 2 || adv_par_customWeap isEqualTo 1) exitWith {"Deutsch"};
		if (true) exitWith {"English"};
	};
	private _opforLanguage = call {
		if (adv_par_opfUni > 0 && adv_par_opfUni < 5) exitWith {"Russian"};
		if (adv_par_opfUni isEqualTo 20) exitWith {"Chinese"};
		if (true) exitWith {"Farsi"};
	};
	[[west, _bluforLanguage],[east, _opforLanguage],[independent, _bluforLanguage, _opforLanguage],[civilian, _bluforLanguage, _opforLanguage, "Local Language"]] call acre_api_fnc_babelSetupMission;
	["en", _bluforLanguage] call acre_api_fnc_babelAddLanguageType;
	["ru", _opforLanguage] call acre_api_fnc_babelAddLanguageType;
	["gr", "Local Language"] call acre_api_fnc_babelAddLanguageType;
	
	//local stuff:
	if (hasInterface) then {
		waitUntil { player == player && time > 1};
		//presets and languages per side:
		switch ( side (group player) ) do {
			case civilian: {
				["en","ru","gr"] call acre_api_fnc_babelSetSpokenLanguages;
			};
			case east: {
				private _languages = if (adv_par_acreBabel isEqualTo 0) then {["ru"]} else {["en","ru","gr"]};
				_languages call acre_api_fnc_babelSetSpokenLanguages;
			};
			case independent: {
				call {
					if ([independent,west] call BIS_fnc_sideIsFriendly || adv_par_acrePresets isEqualTo 1) exitWith {
						private _languages = if (adv_par_acreBabel isEqualTo 0) then {["en","gr"]} else {["en","ru","gr"]};
						_languages call acre_api_fnc_babelSetSpokenLanguages;
					};
					if ([independent,east] call BIS_fnc_sideIsFriendly) exitWith {
						private _languages = if (adv_par_acreBabel isEqualTo 0) then {["ru","gr"]} else {["en","ru","gr"]};
						_languages call acre_api_fnc_babelSetSpokenLanguages;
					};
					private _languages = if (adv_par_acreBabel isEqualTo 0) then {["gr"]} else {["en","ru","gr"]};
					_languages call acre_api_fnc_babelSetSpokenLanguages;
				};
			};
			default {
				private _languages = if (adv_par_acreBabel isEqualTo 0) then {["en"]} else {["en","ru","gr"]};
				_languages call acre_api_fnc_babelSetSpokenLanguages;
			};
		};
	};
};

true;