/*
 * Author: Belbo
 *
 * This function turns a vehicle into a jammer for radio communications or remote detonation of ace IEDs
 *
 * Arguments:
 * 0: target to become jammer - <OBJECT>
 * 1: radius the jammer has to work in - <NUMBER>
 *
 * Return Value:
 * Script handle <HANDLE>
 *
 * Example:
 * _handle = [MRAP_1,500] call adv_fnc_jammer;
 *
 * Public: Yes/No
 */
 
_handle = _this spawn {
	params [
		["_target", objNull, [objNull]]
		,["_radius", 500, [0]]
	];
	//loop variables (can be terminated separately)
	adv_jammer_jammerLoop = true;
	adv_jammer_clientLoop = true;
	adv_jammer_serverLoop = true;
	adv_jammer_actionLoop = true;
	_target setVariable ["adv_var_isJamming",false];

	//switches for turning the jammer on and off (the code that's being executed locally by the activator):
	adv_jammer_scriptfnc_turnOn = {
		params ["_target"];
		_target setVariable ["adv_var_isJamming",true,true];
		systemChat "Jammer activated.";
	};
	adv_jammer_scriptfnc_turnOff = {
		params ["_target"];
		_target setVariable ["adv_var_isJamming",false,true];
		systemChat "Jammer deactivated.";
	};
	//condition for the jammer action:
	adv_jammer_condition = {
		params ["_target"];
		if ( (_target getVariable ["adv_var_isJamming",false]) || damage _target > 0.6 || !(adv_jammer_actionLoop || adv_jammer_clientLoop) ) exitWith {false};
		true
	};
	//condition for the mines:
	adv_jammer_mine_condition = {
		params ["_mine"];
		private _trigger = getText (configFile >> "cfgammo" >> typeOf _mine >> "mineTrigger"); 
		if ( toUpper _trigger isEqualTo "REMOTETRIGGER" ) exitWith {true};
		false;
	};
	adv_jammer_mine_reactivate_condition = {
		params ["_target","_pos"];
		if ( (_target distance _pos) > 50 || !(_target getVariable "adv_var_isJamming") ) exitWith {true};
		false;
	};
	//switches for the mines:
	adv_jammer_mine_place = {
		params ["_target","_typeOfMine","_pos","_dir","_vector","_active"];
		private _newType = call {
			if (toUpper _typeOfMine isEqualTo "IEDLANDBIG_REMOTE_AMMO") exitWith {"IEDLANDBIG_F"};
			if (toUpper _typeOfMine isEqualTo "IEDLANDSMALL_REMOTE_AMMO") exitWith {"IEDLANDSMALL_F"};
			if (toUpper _typeOfMine isEqualTo "IEDURBANBIG_REMOTE_AMMO") exitWith {"IEDURBANBIG_F"};
			if (toUpper _typeOfMine isEqualTo "IEDURBANSMALL_REMOTE_AMMO") exitWith {"IEDURBANSMALL_F"};
			_typeOfMine
		};
		private _magType = getText (configFile >> "CfgAmmo" >> _typeOfMine >> "defaultMagazine");
		private _model = getText (configFile >> "CfgAmmo" >> _typeOfMine >> "model");
		private _height = call {
			if ( toUpper _model isEqualTo "\A3\WEAPONS_F\EXPLOSIVES\IED_LAND_BIG"  ) exitWith { -0.115 };
			if ( toUpper _model isEqualTo "\A3\WEAPONS_F\EXPLOSIVES\IED_LAND_SMALL" ) exitWith { -0.115 };
			if ( toUpper _model isEqualTo "\A3\WEAPONS_F\EXPLOSIVES\IED_URBAN_BIG"  ) exitWith { -0.025 };
			if ( toUpper _model isEqualTo "\A3\WEAPONS_F\EXPLOSIVES\IED_URBAN_SMALL" ) exitWith { -0.008 };
			0
		};
		call {
			if !(_active) exitWith {
				private _gwh = "GroundWeaponHolder" createVehicle _pos;
				_gwh setPosATL [_pos select 0,_pos select 1,_height];
				_gwh setVectorDirAndUp _vector;
				//_gwh setDir _dir;
				_gwh addMagazineCargoGlobal [_magType,1];
				{_x addCuratorEditableObjects [[_gwh]]} count allCurators;
			};
			_new = createMine [_newType, _pos, [], 0];
			_gwh = nearestObjects [ _new, [ "GroundWeaponHolder" ], 2 ];
			{deleteVehicle _x; nil} count _gwh;
			_new setPosATL [(getPosATL _new) select 0,(getPosATL _new) select 1,_height];
			_new setVectorDirAndUp _vector;
			//_new setDir _dir;
		};
	};
	adv_jammer_mine_remove = {
		params ["_mine","_target"];
		private _typeOfMine = typeOf _mine;
		private _pos = getPosATL _mine;
		private _dir = getDir _mine;
		private _vector = [vectorDir _mine,vectorUp _mine];
		private _return = [_target,_typeOfMine,_pos,_dir,_vector];
		deleteVehicle _mine;
		[_target,_typeOfMine,_pos,_dir,_vector, false] call adv_jammer_mine_place;
		[ { [(_this select 0),(_this select 2)] call adv_jammer_mine_reactivate_condition }, {
			params ["_target","_typeOfMine","_pos","_dir","_vector"];
			[_target,_typeOfMine,_pos,_dir,_vector, true] call adv_jammer_mine_place;
		}, _return] call CBA_fnc_waitUntilAndExecute;
		_return;
	};
	
	//code that's only executed on the server, that handles the deactivation of the jammer by damage:
	if (isServer) then {
		if (_target getVariable ["adv_jammer_isJammer",false]) exitWith {};
		_target setVariable ["adv_jammer_isJammer",true];
		
		_index = _target addEventhandler ["DAMMAGED", {
			params ["_target","_hitSelection","_damage","_hitPartIndex","_hitPoint","_shooter","_projectile"];
			if ( damage _target > 0.6 || !alive _target ) then {
				_target setVariable ["adv_var_isJamming",false,true];
			};
		}];
		
		[_target] spawn {
			params ["_target"];
			while { adv_jammer_serverLoop } do {
				sleep 4;
				while { _target getVariable "adv_var_isJamming" } do {
					private _mines = (_target nearObjects ["PipeBombBase", 50]) + (_target nearObjects ["DirectionalBombBase", 50]);
					if ( count _mines > 0 ) then {
						{
							if ( [_x] call adv_jammer_mine_condition ) then {
								[_x,_target] call adv_jammer_mine_remove;
							};
							nil;
						} count _mines;
					};
					sleep 2;
				};
			};
		};
	};

	//the rest will be executed on the client:
	if ( hasInterface ) then {
		waitUntil {player == player};

		//code for ace interaction:
		if ( isClass(configFile >> "CfgPatches" >> "ace_interact_menu") ) then {
			_ace_jammerActionON = [
				"jammerActionOn",
				("<t color=""#00FF00"">" + ("ACTIVATE JAMMER") + "</t>"),
				"",
				{
					[_this select 0] call adv_jammer_scriptfnc_turnOn;
				},
				{ [_this select 0] call adv_jammer_condition },
				nil,[]
			] call ace_interact_menu_fnc_createAction;
			_ace_jammerActionOFF = [
				"jammerActionOff",
				("<t color=""#FF0000"">" + ("DEACTIVATE JAMMER") + "</t>"),
				"",
				{
					[_this select 0] call adv_jammer_scriptfnc_turnOff;
				},
				{ !([_this select 0] call adv_jammer_condition) },
				nil,[]
			] call ace_interact_menu_fnc_createAction;
		
			//adding the actions to the jammer:
			[_target , 0, ["ACE_MainActions"],_ace_jammerActionON] call ace_interact_menu_fnc_addActionToObject;
			[_target , 0, ["ACE_MainActions"],_ace_jammerActionOFF] call ace_interact_menu_fnc_addActionToObject;
			
			
		} else {
			//if ace is not present, we have to add actions the vanilla way:
			[_target] spawn {
				params ["_target"];
				while { alive _target && adv_jammer_actionLoop } do {
					waitUntil { sleep 1; (damage _target) < 0.6 };
					
					_target setVariable ["adv_var_isJamming",false,true];
					
					adv_handle_jammerActionOn = _arget addAction [("<t color=""#00FF00"">" + ("Activate Jammer") + "</t>"), {
						
						params ["_target","_caller","_action"];
						[_target] call adv_jammer_scriptfnc_turnOn;
						_target removeAction _action;

						adv_handle_jammerActionOff = _target addAction [("<t color=""#FF0000"">" + ("Deactivate Jammer") + "</t>"), {
							
							params ["_target","_caller","_action"];
							[_target] call adv_jammer_scriptfnc_turnOff;
							_target removeAction _action;
							
						},nil,6,false,true,"","true",5];
						
					},nil,6,false,true,"","true",5];
					waitUntil { sleep 1; _target getVariable "adv_var_isJamming" };
					waitUntil { sleep 1; ((damage _target) > 0.6 || !alive _target) || !(_target getVariable "adv_var_isJamming") };
					if (!isNil "adv_handle_jammerActionOff") then { _target removeAction adv_handle_jammerActionOff; };
				};
			};
		};
		if ( !isClass(configFile >> "CfgPatches" >> "task_force_radio") || !isClass(configFile >> "CfgPatches" >> "acre_main") ) exitWith { nil };
		
		private _originalInterception = call {
			if ( isClass(configFile >> "CfgPatches" >> "acre_main") ) exitWith {
				missionNamespace getVariable ["acre_sys_signal_terrainScaling",3];
			};
			missionNamespace getVariable ["tf_terrain_interception_coefficient",3];
		};
		private _originalInterference = player getVariable ["tf_sendingDistanceMultiplicator",1];
		
		while {adv_jammer_clientLoop} do {
			sleep 8;
			waitUntil {sleep 2; alive player};
			//_nearVehicles = nearestObjects [player,["LANDVEHICLE"], _radius, false];
			private _nearestJammer = [player,"adv_var_isJamming",_radius] call adv_fnc_findNearestObject;
			call {
				if ( player distance _nearestJammer < _radius ) exitWith {
					private _distance = player distance _nearestJammer;
					private _interference = _originalInterference * ((_distance / _radius) ^ 2);
					private _interception = _originalInterception + ( 2 / ((_distance / _radius) ^ 2) ) - 2;
					adv_debug_jammerVars = [_target,_nearestJammer,_interference,_distance];
					player setVariable ["tf_receivingDistanceMultiplicator", _interference];
					player setVariable ["tf_sendingDistanceMultiplicator", _interference];
					missionNamespace setVariable ["tf_terrain_interception_coefficient",_interception];
					if ( isClass(configFile >> "CfgPatches" >> "acre_main") ) then {
						[_interception] call acre_api_fnc_setLossModelScale;
					};
				};
				missionNamespace setVariable ["tf_terrain_interception_coefficient",_originalInterception];
				player setVariable ["tf_receivingDistanceMultiplicator", _originalInterference];
				player setVariable ["tf_sendingDistanceMultiplicator", _originalInterference];
				if ( isClass(configFile >> "CfgPatches" >> "acre_main") ) then {
					[_originalInterception] call acre_api_fnc_setLossModelScale;
				};
			};
		};
	};
};

_handle;
//Thank you for your attention.