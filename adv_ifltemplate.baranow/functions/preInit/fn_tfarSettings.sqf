/*
ADV_fnc_tfarSettings by Belbo
contains all the variables that are important for tfar
*/
params [
	["_initState", "", [""]]
];

if ( hasInterface && !isServer && _initState == "preInit" ) exitWith {
	adv_radioSettings_exitState = "exit with preInit";
};
if ( isServer && _initState == "postInit") exitWith {
	adv_radioSettings_exitState = "exit with postInit";
};

if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) exitWith {
	//params needed in case paramsArray not yet defined on client in MP
	adv_par_customUni = ["param_customUni",0] call BIS_fnc_getParamValue;
	//if (isNil "ADV_par_customWeap") then { adv_par_customWeap = ["param_customWeap",0] call BIS_fnc_getParamValue; };
	//if (isNil "ADV_par_opfUni") then { adv_par_opfUni = ["param_opfUni",0] call BIS_fnc_getParamValue; };
	adv_par_seriousMode = ["param_seriousMode",0] call BIS_fnc_getParamValue;
	//für zusätzliche variablen/functions: https://github.com/michail-nikolaev/task-force-arma-3-radio/wiki/API:-Variables
	compile preprocessFileLineNumbers "\task_force_radio\functions\common.sqf";
	tf_no_auto_long_range_radio = true;
	tf_give_personal_radio_to_regular_soldier = false;
	tf_give_microdagr_to_soldier = false;
	tf_same_sw_frequencies_for_side = true;
	tf_same_lr_frequencies_for_side = true;
	tf_same_dd_frequencies_for_side = true;
	tf_terrain_interception_coefficient = 3.0;
	tf_speakerDistance = 20;

	//radios
	TF_defaultWestPersonalRadio = "tf_anprc152";
	TF_defaultEastPersonalRadio = "tf_fadak";
	TF_defaultGuerPersonalRadio = "tf_anprc148jem";
	
	TF_defaultWestRiflemanRadio = "tf_anprc154";
	TF_defaultEastRiflemanRadio = "tf_pnr1000a";
	TF_defaultGuerRiflemanRadio = "tf_anprc154";
	//tfar serious mode
	[] spawn {
		tf_radio_channel_name = "TaskForceRadio";
		waitUntil {!isNil "ADV_params_defined"};
		if (adv_par_customUni isEqualTo 9) then { TF_defaultWestPersonalRadio = "tf_anprc148jem"; };
		sleep 1;
		if ( ADV_par_seriousMode > 0 ) then {
			tf_radio_channel_name = "Arma3-TFAR";
			tf_radio_channel_password = "123";
			if (isServer) then {
				{ publicVariable _x } forEach ["tf_radio_channel_name","tf_radio_channel_password"];
			};
		};
	};

	//frequencies
	//blufor
	_settingsSwWest = [false] call TFAR_fnc_generateSwSettings;
	_settingsSwEast = [false] call TFAR_fnc_generateSwSettings;
	_settingsSwGuer = [false] call TFAR_fnc_generateSwSettings;
	
	_settingsLrWest = [false] call TFAR_fnc_generateLrSettings;
	_settingsLrEast = [false] call TFAR_fnc_generateLrSettings;
	_settingsLrGuer = [false] call TFAR_fnc_generateLrSettings;
	
	_settingsSwWest set [2, ["41","42","43","44","45","46","47","48"]];
	_settingsLrWest set [2, ["51","52","53","54","55","56","57","58","59"]];

	_settingsSwEast set [2, ["41","42","43","44","45","46","47","48"]];
	_settingsLrEast set [2, ["51","52","53","54","55","56","57","58","59"]];

	_settingsSwGuer set [2, ["61","62","63","64","65","66","67","68"]];
	_settingsLrGuer set [2, ["71","72","73","74","75","76","77","78","79"]];
	
	_settingsSwWest set [4, "_bluefor"];
	_settingsLrWest set [4, "_bluefor"];
	tf_freq_west = _settingsSwWest;
	tf_freq_west_lr = _settingsLrWest;
	
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
};