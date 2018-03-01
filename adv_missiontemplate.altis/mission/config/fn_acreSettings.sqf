/*
 * Author: Belbo
 *
 * Contains all the variables important for acre. Basic settings have to be set in cba_settings.sqf in main mission folder.
 *
 */
 
if !( isClass (configFile >> "CfgPatches" >> "acre_main") ) exitWith { false };

//params needed in case paramsArray not yet defined on client in MP
private _par_customUni = missionNamespace getVariable ["adv_par_customUni", ["param_customUni",0] call BIS_fnc_getParamValue];
private _par_customWeap = missionNamespace getVariable ["adv_par_customWeap", ["param_customWeap",0] call BIS_fnc_getParamValue];
private _par_opfUni = missionNamespace getVariable ["adv_par_opfUni", ["param_opfUni",0] call BIS_fnc_getParamValue];
private _par_opfWeap = missionNamespace getVariable ["adv_par_opfWeap", ["param_opfWeap",0] call BIS_fnc_getParamValue];
private _par_indUni = missionNamespace getVariable ["adv_par_indUni", ["param_indUni",0] call BIS_fnc_getParamValue];
private _par_indWeap = missionNamespace getVariable ["adv_par_indWeap", ["param_indWeap",0] call BIS_fnc_getParamValue];
private _par_acreBabel = missionNamespace getVariable ["adv_par_acreBabel", ["param_acreBabel",0] call BIS_fnc_getParamValue];
private _par_acrePresets = missionNamespace getVariable ["adv_par_acrePresets", ["param_acrePresets",0] call BIS_fnc_getParamValue];

//radios
acre_westPersonalRadio = call {
	if ( _par_customUni isEqualTo 1 || _par_customUni isEqualTo 2 ) exitWith {"ACRE_SEM52SL"};
	"ACRE_PRC152"
};
acre_eastPersonalRadio = "ACRE_PRC148";
acre_guerPersonalRadio = "ACRE_PRC148";

acre_westRiflemanRadio = "ACRE_PRC343";
acre_eastRiflemanRadio = "ACRE_PRC343";
acre_gerRiflemanRadio = "ACRE_PRC343";

acre_westBackpackRadio = call {
	if ( _par_customUni isEqualTo 1 || _par_customUni isEqualTo 2 ) exitWith {"ACRE_SEM70"};
	if ( _par_customUni isEqualTo 9 ) exitWith {"ACRE_PRC77"};
	"ACRE_PRC117F"
};
acre_eastBackpackRadio = call {
	if ( _par_opfUni  isEqualTo 5 || _par_opfUni isEqualTo 6 ) exitWith {"ACRE_PRC77"};
	"ACRE_PRC117F"
};
acre_guerBackpackRadio = call {
	if ( _par_indUni isEqualTo 20 ) exitWith {"ACRE_PRC77"};
	"ACRE_PRC117F"
};
//channel setup
_channelNames = ["VEHICLES","PLTNET 1","LOG","RECON","AIRNET","PLTNET 2","PLTNET 3","PLTNET 4","CHAN 9","CHAN 10","CHAN 11","CHAN 12","CHAN 13","CHAN 14","CHAN 15"];
_148chNames = ["1-VEHICLES","2-PLTNET 1","3-LOG","4-RECON","5-AIRNET"];
//_sem52Names = ["1-VEHICLES","2-PLTNET 1","3-LOG","4-RECON","5-AIRNET","6-PLTNET 2","7-PLTNET 3","8-PLTNET 4","9-CHAN 9","10-CHAN 10","11-CHAN 11","12-ADMIN"];
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
/*
for "_i" from 1 to (count _sem52Names) do {
	["ACRE_SEM52SL", "default", _i, "name", _sem52Names select (_i-1)] call acre_api_fnc_setPresetChannelField;
	["ACRE_SEM52SL", "default2", _i, "name", _sem52Names select (_i-1)] call acre_api_fnc_setPresetChannelField;
	["ACRE_SEM52SL", "default3", _i, "name", _sem52Names select (_i-1)] call acre_api_fnc_setPresetChannelField;
};
*/
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
	_par_customUni = missionNamespace getVariable ["adv_par_customUni",0];
	_par_customWeap = missionNamespace getVariable ["adv_par_customWeap",0];
	_par_opfUni = missionNamespace getVariable ["adv_par_opfUni",0];
	_par_acreBabel = missionNamespace getVariable ["adv_par_acreBabel",0];
	
	//babel:
	private _bluforLanguage = call {
		if ( _par_customUni isEqualTo 1 || _par_customUni isEqualTo 2 || _par_customWeap isEqualTo 1 ) exitWith {"Deutsch"};
		if (true) exitWith {"English"};
	};
	private _opforLanguage = call {
		if ( _par_opfUni > 0 && _par_opfUni < 5 ) exitWith {"Russian"};
		if ( _par_opfUni isEqualTo 20 ) exitWith {"Chinese"};
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
		private _languages = call {
			if ( _par_acreBabel isEqualTo 1 ) exitWith { ["en"] };
			if ( side (group player) isEqualTo EAST) exitWith {["ru"]};
			if ( side (group player) isEqualTo INDEPENDENT) exitWith {
				if ( [independent,west] call BIS_fnc_sideIsFriendly && [independent,east] call BIS_fnc_sideIsFriendly ) exitWith {["en","ru"]};
				if ( [independent,west] call BIS_fnc_sideIsFriendly ) exitWith {["en","gr"]};
				if ( [independent,east] call BIS_fnc_sideIsFriendly ) exitWith {["ru","gr"]};
				["gr"]
			};
			if ( side (group player) isEqualTo CIVILIAN) exitWith {["en","gr"]};
			["en"]
		};
		_languages call acre_api_fnc_babelSetSpokenLanguages;
	};
};

true;