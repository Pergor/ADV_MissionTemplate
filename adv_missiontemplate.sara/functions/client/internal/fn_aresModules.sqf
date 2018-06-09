/*
 * Author: Belbo
 *
 * Adds modules to Ares menu with most common adv_missiontemplate functions.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call adv_fnc_aresModules;
 *
 * Public: No
 */
 
if ( !hasInterface || !isClass(configFile >> "CfgPatches" >> "achilles_functions_f_ares") ) exitWith {};

adv_scriptfnc_aresModules_getLocations = {
	private _logicsArray = missionNamespace getVariable ["adv_var_aresModulesLogics",[[objNull,"No Location"]]];
	
	private _selectionArray = [];
	private _objectArray = [];
	{_selectionArray pushBack (_x select 1); nil} count _logicsArray;
	{_objectArray pushBack (_x select 0); nil} count _logicsArray;
	
	private _return = [_objectArray,_selectionArray,_logicsArray];
	_return
};

//GENERAL:
["ADV MissionTemplate - Common", "Create Location/Target", 
	{
		params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
		if (isnil "adv_locationsGroup") then {
			private _center = createCenter sideLogic;
			adv_locationsGroup = createGroup _center;
			adv_locationsGroup setGroupIDGlobal ["Locations"];
		};		
		private _return = [_pos,adv_locationsGroup] call adv_fnc_createAresLogic;
		systemChat (format ["%1 created at %2",_return select 1, _pos]);
	}
] call Ares_fnc_RegisterCustomModule;

["ADV MissionTemplate - Misc", "Artillery Barrage", 
	{
		params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
		
		//Dialog:
		private _dialogResult = [
			"Artillery Barrage",
			[
				// The last number is optional! If you want the first selection you can remove the number.
				["Radius (NUMBER)", "", "100"]
				,["Number of rounds overall (NUMBER)", "", "5"]
				,["Kind of shells", ["Mortar Shells","Howitzer Shells","Howitzer Cluster","HE-Rockets","Cluster Rockets"]]
			]
		] call Ares_fnc_showChooseDialog;

		// If the dialog was closed.
		if (_dialogResult isEqualTo []) exitWith {};
		_dialogResult params ["_radius","_count","_shell"];
		
		_radius = parseNumber _radius;
		_count = parseNumber _count;
		private _shellType = switch _shell do {
			case 0: {"Sh_82mm_AMOS"};
			case 1: {"Sh_155mm_AMOS"};
			case 2: {"Cluster_155mm_AMOS"};
			case 3: {"R_230mm_HE"};
			case 4: {"R_230mm_Cluster"};
			default {"Sh_155mm_AMOS"};
		};
		if ( _count isEqualTo 0 || _radius isEqualTo 0 ) exitWith {
			["No proper values were provided"] call Achilles_fnc_showZeusErrorMessage;
		};		
		[[_pos],_shellType,[3,10],300,_count,_radius] remoteExec ["adv_fnc_artillery",2];
	}
] call Ares_fnc_RegisterCustomModule;

["ADV MissionTemplate - Misc", "Flare", 
	{
		params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
		
		//Dialog:
		private _dialogResult = [
			"Flares",
			[
				// The last number is optional! If you want the first selection you can remove the number.
				["Radius (NUMBER)", "", "100"]
				,["Number of Flares (NUMBER)", "", "10"]
				,["Colour", ["WHITE","GREEN","RED","YELLOW","IR","SIGNAL GREEN","SIGNAL RED"]]
			]
		] call Ares_fnc_showChooseDialog;

		// If the dialog was closed.
		if (_dialogResult isEqualTo []) exitWith {};
		_dialogResult params ["_radius","_count","_color"];
		
		_radius = parseNumber _radius;
		_count = parseNumber _count;

		private _colorType = switch _color do {
			case 0: {"WHITE"};
			case 1: {"GREEN"};
			case 2: {"RED"};
			case 3: {"YELLOW"};
			case 4: {"CIR"};
			case 5: {"SIGNAL_GREEN"};
			case 6: {"SIGNAL_RED"};
			default {"WHITE"};
		};
		
		private _height = if (_color in [5,6]) then {80} else {200};
		
		if ( _count isEqualTo 0 || _radius isEqualTo 0 ) exitWith {
			["No proper values were provided"] call Achilles_fnc_showZeusErrorMessage;
		};
		
		_pos set [2,0];
		[_pos,_colorType,_radius,_count,_height] spawn {
			params ["_pos","_type","_radius","_count","_height"];
			for "_i" from 1 to _count do {
				[[_pos],_type,_radius,_height] call adv_fnc_flare;
				sleep (random 3);
			};
		};
	}
] call Ares_fnc_RegisterCustomModule;

["ADV MissionTemplate - Misc", "Start Combat Patrol", 
	{
		params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
		private _dialogResult = [
			"Combat Patrol",
			[
				["CP Mission", ["RANDOM","SABOTAGE VEHICLES","SABOTAGE COMMS","ELIMINATE HVT"]]
			]
		] call Ares_fnc_showChooseDialog;
		if (_dialogResult isEqualTo []) exitWith {};
		_dialogResult params ["_type"];
		if (_type < 1) then {_type = -1;};
		[_type] remoteExec ["adv_fnc_cpinit",0];
		"Combat Patrol startet..." remoteExec ["systemChat",0];
	}
] call Ares_fnc_RegisterCustomModule;

if ( isClass(configFile >> "CfgPatches" >> "tfar_core") ) then {
	["ADV MissionTemplate - Misc", "Turn Vehicle into Relay", 
		{
			params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
			
			if ( isNull _target ) exitWith {
				["No object was selected!"] call Achilles_fnc_showZeusErrorMessage;
			};
			
			//Dialog:
			private _dialogResult = [
				"Settings for Relay",
				[
					["Height above NN", "", "50"]
					,["Range", "", "20000"]
				]
			] call Ares_fnc_showChooseDialog;
			
			if (_dialogResult isEqualTo []) exitWith {};
			_dialogResult params ["_height","_range"];
			_height = parseNumber _height;
			_range = parseNumber _range;
			if ( _range isEqualTo 0 || _height isEqualTo 0 ) exitWith {
				["Provided values aren't correct."] call Achilles_fnc_showZeusErrorMessage;
			};
			
			[_target, _height, _range] remoteExec ["adv_fnc_radioRelay",0];
			systemChat (format ["%1 is now a radio relay.",_target]);
		}
	] call Ares_fnc_RegisterCustomModule;
};

["ADV MissionTemplate - Player", "Set Rating", 
	{
		params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
		
		if ( isNull _target ) exitWith {
			["No object was selected!"] call Achilles_fnc_showZeusErrorMessage;
		};
		
		//Dialog:
		private _dialogResult = [
			"Set new rating for selected unit",
			[
				// The last number is optional! If you want the first selection you can remove the number.
				["New Rating", "", "500"]
			]
		] call Ares_fnc_showChooseDialog;

		// If the dialog was closed.
		if (_dialogResult isEqualTo []) exitWith {};
		_dialogResult params ["_rating"];
		_rating = parseNumber _rating;
		if ( _rating isEqualTo 0 ) exitWith {
			["No rating value was provided"] call Achilles_fnc_showZeusErrorMessage;
		};
		
		[_target,_rating] call adv_fnc_setRating;
	}
] call Ares_fnc_RegisterCustomModule;

["ADV MissionTemplate - Player", "Teleport Yourself", 
	{
		params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
		
		(vehicle player) setVehiclePosition [_pos,[],0,"NONE"];
	}
] call Ares_fnc_RegisterCustomModule;

["ADV MissionTemplate - Player", "Assign Curator", 
	{
		params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
		if ( isNull _target ) exitWith {
			["No object was selected!"] call Achilles_fnc_showZeusErrorMessage;
		};		
		if !( isNull (getAssignedCuratorLogic _target) ) exitWith {
			["Object already has curator access"] call Achilles_fnc_showZeusErrorMessage;
		};		
		[str _target,3] remoteExec ["adv_fnc_createZeus",2];
	}
] call Ares_fnc_RegisterCustomModule;

["ADV MissionTemplate - Player", "Remove Curator Access",
	{
		params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
		if ( isNull _target ) exitWith {
			["No object was selected!"] call Achilles_fnc_showZeusErrorMessage;
		};		
		if ( isNull (getAssignedCuratorLogic _target) ) exitWith {
			["Object is not curator"] call Achilles_fnc_showZeusErrorMessage;
		};
		private _logic = getAssignedCuratorLogic _target;
		[_logic] remoteExec ["unassignCurator",2];
		deleteVehicle _logic;
	}
] call Ares_fnc_RegisterCustomModule;

//GEAR:
["ADV MissionTemplate - Gear", "Vehicle Loadout", 
	{
		params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
		
		if ( isNull _target ) exitWith {
			["No object was selected!"] call Achilles_fnc_showZeusErrorMessage;
		};
		
		//Dialog:
		private _dialogResult = [
			"Vehicle Loadout",
			[
				// The last number is optional! If you want the first selection you can remove the number.
				["Side of the vehicle", "SIDE", 2]
				,["Medical Vehicle?", ["Not a Medical Vehicle","Medical Vehicle"]]
				,["Repair Vehicle?", ["Not a Repair Vehicle","Repair Vehicle"]]
				,["With Ammo & Weapons?", ["With Weapons and Ammunition","Without Weapons and Ammunition"]]
			]
		] call Ares_fnc_showChooseDialog;

		// If the dialog was closed.
		if (_dialogResult isEqualTo []) exitWith{};
		_dialogResult params ["_side","_medical","_repair","_ammo","_spareparts"];
		
		private _function = switch _side do {
			case 1: {adv_opf_fnc_vehicleLoad};
			case 3: {adv_ind_fnc_vehicleLoad};
			default {adv_fnc_vehicleLoad};
		};
		
		private _isMedical = if (_medical > 0) then {true} else {false};
		private _hasAmmo = if (_ammo > 0) then {false} else {true};
		private _isRepair = if (_repair > 0) then {true} else {false};
		
		[_target] call adv_fnc_clearCargo;
		[_target, _isMedical, _hasAmmo, 0, _isRepair] call _function;
		
	}
] call Ares_fnc_RegisterCustomModule;

["ADV MissionTemplate - Gear", "Set unit loadout", 
	{
		params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
		
		if ( isNull _target ) exitWith {
			["No object was selected!"] call Achilles_fnc_showZeusErrorMessage;
		};
		
		//Dialog:
		private _dialogResult = [
			"Unit loadout Function (know your functions before you call them!)",
			[
				// The last number is optional! If you want the first selection you can remove the number.
				["Function to call", "", "adv_fnc_*"]
				,["Special State (eg. ""AT"" for soldierAT)", "", ""]
			]
		] call Ares_fnc_showChooseDialog;

		// If the dialog was closed.
		if (_dialogResult isEqualTo []) exitWith {};
		_dialogResult params ["_function",["_special",""]];
		
		if ( _function isEqualTo "adv_fnc_*" || _function isEqualTo "" ) exitWith {
			["No function was provided!"] call Achilles_fnc_showZeusErrorMessage;
		};
		[_target,_special] remoteExec [_function,_target];
	}
] call Ares_fnc_RegisterCustomModule;

["ADV MissionTemplate - Gear", "Reset/Set Insignia", 
	{
		params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
		
		if ( isNull _target ) exitWith {
			["No object was selected!"] call Achilles_fnc_showZeusErrorMessage;
		};
		
		//Dialog:
		private _dialogResult = [
			"Choose specific insignia. Leave empty for pre-configured insignia (RECOMMENDED).",
			[
				["Specific insignia", "", ""]
			]
		] call Ares_fnc_showChooseDialog;

		// If the dialog was closed.
		if (_dialogResult isEqualTo []) exitWith {};
		_dialogResult params [["_insignia",""]];
		
		if (_insignia isEqualTo "") then {
			[_target] call adv_fnc_insignia;
		} else {
			[_target,""] call BIS_fnc_setUnitInsignia;
			[_target,_insignia] call BIS_fnc_setUnitInsignia;
		};
	}
] call Ares_fnc_RegisterCustomModule;

adv_scriptfnc_aresModules_slingLoad = {
	params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]], "_mode"];

	if ( isNull _target ) exitWith {
		["No object was selected!"] call Achilles_fnc_showZeusErrorMessage;
	};
	//////get location:
	private _logics = call adv_scriptfnc_aresModules_getLocations;
	_logics params ["_objectArray","_selectionArray","_logicsArray"];
	if (count _logicsArray isEqualTo 1) exitWith {
		["Create at least one location first! Find it under ADV MissionTemplate - Common"] call Achilles_fnc_showZeusErrorMessage;
	};
	_selectionArray deleteAt 0;
	_objectArray deleteAt 0;
	//////get location
	
	//Dialog:
	private _dialogResult = [
		"Settings for Slingload Supply",
		[
			["Target Destination", _selectionArray, (count _selectionArray)]
			,["Side of supply aircraft", "SIDE", 2]
			//,["Aircraft (leave empty for standard)", "", "B_T_VTOL_01_vehicle_F"]
		]
	] call Ares_fnc_showChooseDialog;
	
	if ( _dialogResult isEqualTo [] ) exitWith {};
	_dialogResult params ["_destNR","_side"];
	private _dest = _objectArray select _destNR;
	_side = _side-1;
	private _aircraft = switch _side do {
		case 0: {["O_Heli_Transport_04_black_F","O_T_VTOL_02_vehicle_grey_F"]};
		case 1: {["B_Heli_Transport_03_F","B_T_VTOL_01_vehicle_F"]};
		case 2: {["I_Heli_Transport_02_F","B_T_VTOL_01_vehicle_blue_F"]};
		case 3: {["B_Heli_Transport_03_F","B_T_VTOL_01_vehicle_blue_F"]};
		default {["B_Heli_Transport_03_F","B_T_VTOL_01_vehicle_F"]};
	};

	if ( isClass(configFile >> "CfgPatches" >> "CUP_Vehicles_Core") ) then {
		_aircraft = switch _side do {
			case 0: {["CUP_O_Mi8_VIV_RU","CUP_O_C130J_Cargo_TKA"]};
			case 1: {["CUP_B_CH47F_USA","CUP_B_C130J_Cargo_USMC"]};
			case 2: {["CUP_B_Merlin_HC3A_GB","CUP_B_C130J_Cargo_GB"]};
			case 3: {["CUP_B_Merlin_HC3A_GB","CUP_B_C130J_Cargo_GB"]};
			default {["B_Heli_Transport_03_F","B_T_VTOL_01_vehicle_F"]};
		};
	};
	
	_aircraft params ["_heli","_plane"];
	
	private _vehicle = if (_mode isEqualTo 0) then {_heli} else {
		if (_mode isEqualTo 1) then {_plane} else {""};
	};
	
	[_dest,nil,_side,_vehicle,_target] remoteExec ["adv_fnc_slingloadSupply",2];
};

["ADV MissionTemplate - Logistic", "Slingload object to Destination", 
	{
		private _array = _this;
		_array pushBack 0;
		_array call adv_scriptfnc_aresModules_slingLoad
	}
] call Ares_fnc_RegisterCustomModule;

["ADV MissionTemplate - Logistic", "Airdrop object at Destination", 
	{
		private _array = _this;
		_array pushBack 1;
		_array call adv_scriptfnc_aresModules_slingLoad
	}
] call Ares_fnc_RegisterCustomModule;

["ADV MissionTemplate - Logistic", "Spawn logistic crate", 
	{
		params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
		
		//Dialog:
		private _selections = ["Infanterie-Munition","MMG-Munition","AT-Raketen","AA-Raketen","Granaten"
			,"Medic-Kiste","Support-Kiste","EOD-Kiste","Fire-Team-Kiste","Leere Kiste","Leere Slingloading-Kiste"
		];
		if ( missionNamespace getVariable ["ace_mk6mortar_useAmmoHandling",false] ) then {
			_selections append ["Mörsergranaten-Kiste"];
		};
		private _dialogResult = [
			"Settings for Slingload Supply",
			[
				["Which side is the crate for?", "SIDE", 2]
				,["Crate selection", _selections]
			]
		] call Ares_fnc_showChooseDialog;

		// If the dialog was closed.
		if (_dialogResult isEqualTo []) exitWith {};
		_dialogResult params ["_side","_selection"];
		_side = _side-1;
		
		private _crateSelection = switch _selection do {
			case 0: {"ADV_LOGISTIC_CRATENORMAL"};
			case 1: {"ADV_LOGISTIC_CRATEMG"};
			case 2: {"ADV_LOGISTIC_CRATEAT"};
			case 3: {"ADV_LOGISTIC_CRATEAA"};
			case 4: {"ADV_LOGISTIC_CRATEGRENADES"};
			case 5: {"ADV_LOGISTIC_CRATEMEDIC"};
			case 6: {"ADV_LOGISTIC_CRATESUPPORT"};
			case 7: {"ADV_LOGISTIC_CRATEEOD"};
			case 8: {"ADV_LOGISTIC_CRATETEAM"};
			case 9: {"ADV_LOGISTIC_CRATEEMPTY"};
			case 10: {"ADV_LOGISTIC_CRATELARGEEMPTY"};
			case 11: {"ADV_LOGISTIC_CRATESHELLS"};
			default {"ADV_FNC_NIL"};
		};
		
		_pos = AGLToASL _pos;
		[_crateSelection,true,_side,_pos] call adv_fnc_dialogLogistic;
	}
] call Ares_fnc_RegisterCustomModule;

//AI
["ADV MissionTemplate - AI", "Ambient Civilians", 
	{
		params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
		
		//Dialog:
		private _dialogResult = [
			"Engima's Civilians",
			[
				// The last number is optional! If you want the first selection you can remove the number.
				["Civilians", ["Civilian Pedestrians","Civilian Traffic","Civilian Pedestrians & Traffic"]]
			]
		] call Ares_fnc_showChooseDialog;

		// If the dialog was closed.
		if (_dialogResult isEqualTo []) exitWith{};
		_dialogResult params ["_selection"];
		
		if ( _selection isEqualTo 2 && (!isNil "ENGIMA_CIVILIANS_MINSKILL" && !isNil "ENGIMA_TRAFFIC_areaMarkerNames") ) exitWith {
			["Civilian Pedestrians & Traffic already activated"] call Achilles_fnc_showZeusErrorMessage;
		};
		
		if ( _selection in [0,2] ) then {
			if (!isNil "ENGIMA_CIVILIANS_MINSKILL") exitWith {
				["Civilian Pedestrians already activated"] call Achilles_fnc_showZeusErrorMessage;
			};
			[] remoteExec ["engima_fnc_civilians_init",0];
		};
		if ( _selection in [1,2] ) then {
			if (!isNil "ENGIMA_TRAFFIC_areaMarkerNames") exitWith {
				["Civilian Traffic already activated"] call Achilles_fnc_showZeusErrorMessage;
			};
			[] remoteExec ["engima_fnc_traffic_init",0];
		};
		
	}
] call Ares_fnc_RegisterCustomModule;

["ADV MissionTemplate - AI", "Spawn Convoy", 
	{
		params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
		
		//////get location:
		private _logics = call adv_scriptfnc_aresModules_getLocations;
		_logics params ["_objectArray","_selectionArray","_logicsArray"];
		if (count _logicsArray isEqualTo 1) exitWith {
			["Create at least one location first! Find it under ADV MissionTemplate - Common"] call Achilles_fnc_showZeusErrorMessage;
		};
		_selectionArray deleteAt 0;
		_objectArray deleteAt 0;
		//////get location
		
		//Dialog:
		private _dialogResult = [
			"Spawn Convoy",
			[
				["Destination", _selectionArray,(count _selectionArray)]
				,["Side of the convoy", "SIDE", 0]
				,["Vehicle classes (in order of convoy, no """")", "", "O_MRAP_02_hmg_F,O_Truck_02_transport_F,O_Truck_02_transport_F,O_Truck_02_transport_F,O_MRAP_02_hmg_F"]
				,["Units that are transported in convoy (no """")", "", "O_Soldier_SL_F,O_Soldier_AR_F,O_Soldier_GL_F,O_Soldier_F,O_soldier_LAT_F,O_Soldier_F,O_Soldier_A_F,O_medic_F"]
				,["Add additional waypoint stations (Needs additional locations)?",["No","Yes"]]
			]
		] call Ares_fnc_showChooseDialog;
		
		if (_dialogResult isEqualTo []) exitWith {};
		_dialogResult params ["_destNR","_side","_vehsSTR","_unitsSTR","_wpAdd"];
		
		private _dest = _objectArray select _destNR;
		private _vehs = _vehsSTR splitString ", ";
		if (count _vehs isEqualTo 0) then {
			_vehs = ["O_MRAP_02_hmg_F","O_Truck_02_transport_F","O_Truck_02_transport_F","O_Truck_02_transport_F","O_MRAP_02_hmg_F"];
		};
		private _units = _unitsSTR splitString ", ";
		if (count _units isEqualTo 0) then {
			_units = ["O_Soldier_SL_F","O_Soldier_AR_F","O_Soldier_GL_F","O_Soldier_F","O_soldier_LAT_F","O_Soldier_F","O_Soldier_A_F","O_medic_F"];
		};
		_side = _side-1;
		private _array = [_pos,_dest,_vehs,_units,_side,["NORMAL","SAFE","GREEN","COLUMN"]];
		// If the dialog was closed.
		
		if (_wpAdd > 0) then {
			private _finder = _objectArray find _dest;
			_objectArray deleteAt _finder;
			_selectionArray deleteAt _finder;
			if (count _objectArray < 1) exitWith {
				["Create at least two locations first! Find it under ADV MissionTemplate - Common"] call Achilles_fnc_showZeusErrorMessage;
			};
			private _counter = 1;
			private _dialogArray = [];
			{
				private _array = [(format ["Waypoint %1",_counter]), _selectionArray, _counter];
				_counter = _counter + 1;
				_dialogArray pushBack _array;
				nil
			} count _objectArray;
			private _dialogWPs = [
				"Spawn Convoy",
				_dialogArray
			] call Ares_fnc_showChooseDialog;
			if (_dialogWPs isEqualTo []) exitWith {
				["Convoy creation aborted."] call Achilles_fnc_showZeusErrorMessage;
			};
			//_dialogWPs params ["_wp1","_wp2","_wp3","_wp4"];
			private _WPs = [];
			{
				private _wp = _objectArray select _x;
				if !(_wp isEqualTo _dest) then {
					_WPs pushBackUnique _wp;
				};
				nil
			} count _dialogWPs;
			_array pushBack _WPs;
		};
		
		_array remoteExec ["ADV_fnc_spawnConvoy",2];
		
	}
] call Ares_fnc_RegisterCustomModule;

["ADV MissionTemplate - AI", "Spawn Patrol/Attack/Garrison", 
	{
		params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
		
		//Dialog:
		private _dialogResult = [
			"Spawn Patrol/Attack/Garrison",
			[
				["Mode", ["Patrol","Garrison","Defend Area","Attack"]]
				,["Radius around position (NUMBER)", "", "200"]
				,["Side of the units", "SIDE", 0]
				,["Units (no """")", "", "O_Soldier_SL_F,O_Soldier_AR_F,O_Soldier_GL_F,O_Soldier_F,O_soldier_LAT_F,O_Soldier_F,O_Soldier_A_F,O_medic_F"]
			]
		] call Ares_fnc_showChooseDialog;

		// If the dialog was closed.
		if (_dialogResult isEqualTo []) exitWith {};
		_dialogResult params ["_mode","_radiusSTR","_side","_unitsSTR"];
		_mode = if (_mode > 0) then {_mode+1} else {_mode};
		private _radius = parseNumber _radiusSTR;
		_side = _side-1;
		private _units = _unitsSTR splitString ", ";
		
		private _dest = objNull;
		private _attack = false;
		if (_mode isEqualTo 4) then {

			//////get location:
			private _logics = call adv_scriptfnc_aresModules_getLocations;
			_logics params ["_objectArray","_selectionArray","_logicsArray"];
			_selectionArray set [0,"Next enemy unit (in 5km radius)"];
			//////get location
		
			private _dialogLocation = [
				"Location for the Attack",
				[
					["Location", _selectionArray]
				]
			] call Ares_fnc_showChooseDialog;	
			
			if (_dialogLocation isEqualTo []) exitWith {};
			_dialogLocation params ["_destNR"];
			_dest = _objectArray select _destNR;
			_attack = true;
		};
		
		private _array = [_pos,_units,_side,_mode,_radius];
		if !(_dest isEqualTo objNull) then {_array pushBack [_dest,_radius]};
		if (_mode isEqualTo 4 && !_attack) exitWith {
			["Attack aborted!"] call Achilles_fnc_showZeusErrorMessage;
		};

		_array remoteExec ["ADV_fnc_aiTask",2];
	}
] call Ares_fnc_RegisterCustomModule;

if (isClass(configFile >> "CfgPatches" >> "ace_captives")) then {
	["ADV MissionTemplate - AI", "Make unit hostage", 
		{
			params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
			if ( isNull _target ) exitWith {
				["No object was selected!"] call Achilles_fnc_showZeusErrorMessage;
			};
			
			//////get location:
			private _logics = call adv_scriptfnc_aresModules_getLocations;
			_logics params ["_objectArray","_selectionArray","_logicsArray"];
			if ( count _logicsArray isEqualTo 1 ) exitWith {
				["Create at least one location (for Exfil) first! Find it under ADV MissionTemplate - Common"] call Achilles_fnc_showZeusErrorMessage;
			};
			_selectionArray deleteAt 0;
			_objectArray deleteAt 0;
			//////get location
			
			private _dialogLocation = [
				"Exfil-Location",
				[
					["Exfil Location", _selectionArray]
					,["Diameter of Exfil location","","20"]
				]
			] call Ares_fnc_showChooseDialog;	
			
			if (_dialogLocation isEqualTo []) exitWith {};
			_dialogLocation params ["_destNR","_radiusSTR"];
			private _dest = _objectArray select _destNR;
			private _radius = (parseNumber _radiusSTR)/2;
			
			[_target,_dest,_radius] remoteExec ["adv_fnc_aceHostage",2];
		}
	] call Ares_fnc_RegisterCustomModule;
};

nil


 /*
["ADV MissionTemplate", "Vorlage", 
	{
		params [["_pos", [0,0,0], [[]], 3], ["_target", objNull, [objNull]]];
		
		//Für Objekte:
		private _selectedObjects = if ( isNull _target ) then {
			["Objects"] call Achilles_fnc_SelectUnits;
		} else {
			[_target];
		};
		if ( _selectedObjects isEqualTo [] ) exitWith {
			["No object was selected!"] call Achilles_fnc_showZeusErrorMessage;
		};
		
		//Dialog:
		private _dialogResult = [
			"Vorlage",
			[
				// The last number is optional! If you want the first selection you can remove the number.
				["Combo Box Control", ["Choice 1","Choice 2"], 1],
				["Text Control", "", "default text"],
				["Slider Control", "SLIDER", 1],
				["Side Control", "SIDE", 2]
			]
		] call Ares_fnc_showChooseDialog;

		// If the dialog was closed.
		if (_dialogResult isEqualTo []) exitWith{};
		
	}
] call Ares_fnc_RegisterCustomModule;
*/