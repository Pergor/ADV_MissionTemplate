/*
 * Author: Belbo
 *
 * Contains all the variables important for tfar. Basic settings have to be set in cba_settings.sqf in main mission folder.
 *
 */

if (isClass(configFile >> "CfgPatches" >> "tfar_core")) exitWith {

	if (!isNil "TFAR_setting_defaultFrequencies_lr_east") exitWith {
		//With version 1.0.274 you have to set all this in cba_settings.sqf... :(
	};
	
	//general:
	tf_terrain_interception_coefficient = 3.0;
	tf_speakerDistance = 20;

	//radios:
	TFAR_DefaultRadio_Personal_West = "tfar_anprc152";
	TFAR_DefaultRadio_Personal_East = "tfar_fadak";
	TFAR_DefaultRadio_Personal_Independent = "tfar_anprc148jem";
	
	TFAR_DefaultRadio_Rifleman_West = "tfar_anprc154";
	TFAR_DefaultRadio_Rifleman_East = "tfar_pnr1000a";
	TFAR_DefaultRadio_Rifleman_Independent = "tfar_anprc154";
	
	//tfar serious mode channel name and password:
	call {
		if ( ("param_seriousMode" call BIS_fnc_getParamValue) isEqualTo 0 ) exitWith {
			TFAR_Teamspeak_Channel_Name = "NONE";
			TFAR_Teamspeak_Channel_Password = "NONE";
		};
		if !( ["SPEZIALEINHEIT LUCHS", serverName] call BIS_fnc_inString ) exitWith {
			TFAR_Teamspeak_Channel_Name = "TaskForceRadio";
			TFAR_Teamspeak_Channel_Password = "123";
		};
		TFAR_Teamspeak_Channel_Name = "Arma3-TFAR";
		TFAR_Teamspeak_Channel_Name = "123";
	};
	tf_radio_channel_name = TFAR_Teamspeak_Channel_Name;
	tf_radio_channel_password = TFAR_Teamspeak_Channel_Password;
	
	//update the plugin settings:
	call TFAR_fnc_sendPluginConfig;

	//side settings:
	//blufor:
	_defaultFrequencies_sr_west = ["41","42","43","44","45","46","47","48"];
	_defaultFrequencies_lr_west = ["51","52","53","54","55","56","57","58","59"];
	_west_code = "_bluefor";
	/*
	//if you want to set different channel sets depending on certain conditions:
	if ( ["LUCHS", (str player) ] call BIS_fnc_inString ) then {
		_defaultFrequencies_sr_west = ["31","32","33","34","35","36","37","38"];
		_defaultFrequencies_lr_west = ["51","52","53","54","55","56","57","58","59"];
		_west_code = "_bluefor";
	};
	*/
	
	//opfor:
	private _defaultFrequencies_sr_east = ["41","42","43","44","45","46","47","48"];
	private _defaultFrequencies_lr_east = ["51","52","53","54","55","56","57","58","59"];
	private _east_code = "_opfor";
	
	//indfor:
	private _defaultFrequencies_sr_independent = ["61","62","63","64","65","66","67","68"];
	private _defaultFrequencies_lr_independent = ["71","72","73","74","75","76","77","78","79"];
	private _ind_code = "";		//leave blank if you want indfor to use the code of whatever side it's affiliated with or "_independent" if it's not affiliated to anyone.
	
	//// don't edit below this line ////
	
	_settingsSRWest = false call TFAR_fnc_generateSRSettings;
	_settingsLrWest = false call TFAR_fnc_generateLrSettings;
	
	_settingsSREast = false call TFAR_fnc_generateSRSettings;
	_settingsLrEast = false call TFAR_fnc_generateLrSettings;
	
	_settingsSRGuer = false call TFAR_fnc_generateSRSettings;
	_settingsLrGuer = false call TFAR_fnc_generateLrSettings;
	
	_settingsSRWest set [2, _defaultFrequencies_sr_west];
	_settingsSRWest set [4, _west_code];
	TFAR_freq_sr_west = _settingsSRWest;
	//TFAR_setting_defaultFrequencies_sr_west = _defaultFrequencies_sr_west;
	
	_settingsLrWest set [2, _defaultFrequencies_lr_west];
	_settingsLrWest set [4, _west_code];
	TFAR_freq_lr_west = _settingsLrWest;
	//TFAR_setting_defaultFrequencies_lr_west = _defaultFrequencies_lr_west;
	
	_settingsSREast set [2, _defaultFrequencies_sr_east];
	_settingsSREast set [4, _east_code];
	TFAR_freq_sr_east = _settingsSREast;
	//TFAR_setting_defaultFrequencies_sr_east = _defaultFrequencies_sr_east;
	
	_settingsLrEast set [2, _defaultFrequencies_lr_east];
	_settingsLrEast set [4, _east_code];
	TFAR_freq_lr_east = _settingsLrEast;
	//TFAR_setting_defaultFrequencies_lr_east = _defaultFrequencies_lr_east;
	
	_settingsSRGuer set [2, _defaultFrequencies_sr_independent];
	_settingsLrGuer set [2, _defaultFrequencies_lr_independent];
	TFAR_freq_sr_independent = _settingsSRGuer;
	//TFAR_setting_defaultFrequencies_sr_independent = _defaultFrequencies_sr_independent;
	TFAR_freq_lr_independent = _settingsLrGuer;
	//TFAR_setting_defaultFrequencies_lr_independent = _defaultFrequencies_lr_independent;
	
	if ( _ind_code isEqualTo "" ) then {
		_ind_code = call {
			if ([independent,west] call BIS_fnc_sideIsFriendly) exitWith {_west_code};
			if ([independent,east] call BIS_fnc_sideIsFriendly) exitWith {_east_code};
			"_independent"
		};
	};
	TFAR_freq_sr_independent set [4, _ind_code];
	TFAR_freq_lr_independent set [4, _ind_code];
	
	missionNamespace setVariable ["tf_west_radio_code",_west_code];
	missionNamespace setVariable ["tf_east_radio_code",_east_code];
	missionNamespace setVariable ["tf_independent_radio_code",_ind_code];

	true;
};
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) exitWith {
	//für zusätzliche variablen/functions: https://github.com/michail-nikolaev/task-force-arma-3-radio/wiki/API:-Variables
	call compile preprocessFileLineNumbers "\task_force_radio\functions\common.sqf";
	
	//tfar 0.9.12
	["TF_no_auto_long_range_radio", true, true, "server"] call CBA_settings_fnc_set;
	["TF_give_personal_radio_to_regular_soldier", false, true, "server"] call CBA_settings_fnc_set;
	["TF_give_microdagr_to_soldier", false, true, "server"] call CBA_settings_fnc_set;
	["TF_same_sw_frequencies_for_side", true, true, "server"] call CBA_settings_fnc_set;
	["TF_same_lr_frequencies_for_side", true, true, "server"] call CBA_settings_fnc_set;
	["TF_same_dd_frequencies_for_side", true, true, "server"] call CBA_settings_fnc_set;
	//general
	tf_terrain_interception_coefficient = 3.0;
	tf_speakerDistance = 10;

	//radios
	TF_defaultWestPersonalRadio = "tf_anprc152";
	TF_defaultEastPersonalRadio = "tf_fadak";
	TF_defaultGuerPersonalRadio = "tf_anprc148jem";
	
	TF_defaultWestRiflemanRadio = "tf_anprc154";
	TF_defaultEastRiflemanRadio = "tf_pnr1000a";
	TF_defaultGuerRiflemanRadio = "tf_anprc154";
	//tfar serious mode
	[] spawn {
		waitUntil {!isNil "adv_par_seriousMode" && !isNil "adv_par_customUni" };
		if (adv_par_customUni isEqualTo 9) then { TF_defaultWestPersonalRadio = "tf_anprc148jem"; };
		if ( (adv_par_customWeap isEqualTo 1 || adv_par_customUni isEqualTo 2) && isClass(configFile >> "CfgPatches" >> "tfw_sem52sl") ) then { TF_defaultWestPersonalRadio = "tf_sem52sl"; };
		if ( ADV_par_seriousMode > 0 ) then {
			tf_radio_channel_name = "Arma3-TFAR";
			tf_radio_channel_password = "123";
		};
	};

	//frequencies
	//blufor
	_settingsSwWest = false call TFAR_fnc_generateSwSettings;
	_settingsSwEast = false call TFAR_fnc_generateSwSettings;
	_settingsSwGuer = false call TFAR_fnc_generateSwSettings;
	
	_settingsLrWest = false call TFAR_fnc_generateLrSettings;
	_settingsLrEast = false call TFAR_fnc_generateLrSettings;
	_settingsLrGuer = false call TFAR_fnc_generateLrSettings;
	
	_settingsSwWest set [2, ["41","42","43","44","45","46","47","48"]];
	_settingsLrWest set [2, ["51","52","53","54","55","56","57","58","59"]];
	_settingsSwWest set [4, "_bluefor"];
	_settingsLrWest set [4, "_bluefor"];
	tf_freq_west = _settingsSwWest;
	tf_freq_west_lr = _settingsLrWest;

	_settingsSwEast set [2, ["41","42","43","44","45","46","47","48"]];
	_settingsLrEast set [2, ["51","52","53","54","55","56","57","58","59"]];

	_settingsSwGuer set [2, ["61","62","63","64","65","66","67","68"]];
	_settingsLrGuer set [2, ["71","72","73","74","75","76","77","78","79"]];
	
	_settingsSwEast set [4, "_opfor"];
	_settingsLrEast set [4, "_opfor"];
	tf_freq_east = _settingsSwEast;
	tf_freq_east_lr = _settingsLrEast;

	call {
		if ([independent,west] call BIS_fnc_sideIsFriendly) exitWith {
			_settingsSWGuer set [4, "_bluefor"];
			_settingsLrGuer set [4, "_bluefor"];
		};
		if ([independent,east] call BIS_fnc_sideIsFriendly) exitWith {
			_settingsSWGuer set [4, "_opfor"];
			_settingsLrGuer set [4, "_opfor"];
		};
		_settingsSWGuer set [4, "_indfor"];
		_settingsLrGuer set [4, "_indfor"];
	};

	tf_freq_guer = _settingsSwGuer;
	tf_freq_guer_lr = _settingsLrGuer;
	
	true;
};

false;