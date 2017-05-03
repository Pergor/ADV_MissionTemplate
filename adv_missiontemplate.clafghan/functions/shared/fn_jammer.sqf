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
 
if !( isClass(configFile >> "CfgPatches" >> "task_force_radio") ) exitWith { nil };

_handle = _this spawn {
	params [
		["_target", objNull, [objNull]]
		,["_radius", 500, [0]]
	];
	//loop variables (can be terminated separately)
	adv_jammer_jammerLoop = true;
	adv_jammer_clientLoop = true;
	adv_jammer_serverLoop = true;
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
	adv_jammer_condition = {
		params ["_target"];
		if ( !(_target getVariable ["adv_var_isJamming",false]) && damage _target < 0.6 && (adv_jammer_actionLoop || adv_jammer_clientLoop) ) exitWith {true};
		false;
	};
	adv_jammer_mine_activate = {
		params ["_typeOfMine","_pos","_dir"];
		_new = createMine [_typeOfMine, _pos, [], 0];
		_new setDir _dir;
	};
	adv_jammer_mine_deactivate = {
		params ["_target"];
		private _typeOfMine = typeOf _target;
		private _pos = getPos _target;
		private _dir = getDir _mine;
		private _return = [_typeOfMine,_pos,_dir];
		_target enableSimulationGlobal true;
		deleteVehicle _target;
		_return spawn {
			
		};
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
				while { _target getVariable "adv_jammer_isJamming" } do {
					{
						call {
							if (_x distance _target < 50 && mineActive _x) exitWith {
								if (floor random 10 > 6) then {
									//[_x] call adv_jammer_mine_deactivate;
									_x enableSimulationGlobal false;
								};
							};
							if (_x distance _target > 50 && _x distance _target > 200 && !(simulationEnabled _x)) exitWith {
								_x enableSimulationGlobal true;
							};
						};
					} count allMines;
					sleep 4;
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
		
		private _originalInterception = tfar_terrain_interception_coefficient;
		private _originalInterference = player getVariable ["tf_sendingDistanceMultiplicator",1];
		
		if (isNil "adv_jammer_clientLoop") then {
			while {adv_jammer_clientLoop} do {
				sleep 8;
				waitUntil {sleep 2; alive player};
				//_nearVehicles = nearestObjects [player,["LANDVEHICLE"], _radius, false];
				private _nearestJammer = [player,"adv_var_isJamming",_radius] call adv_fnc_findNearestObject;
				call {
					if ( player distance _nearestJammer < _radius ) exitWith {
						private _distance = player distance _nearestJammer;
						private _interference = _originalInterference * ((_distance / _radius) ^ 2);
						adv_debug_jammerVars = [_target,_nearestJammer,_interference,_distance];
						player setVariable ["tf_receivingDistanceMultiplicator", _interference];
						player setVariable ["tf_sendingDistanceMultiplicator", _interference];
						tfar_terrain_interception_coefficient = _originalInterception + ( ( 2 / ((_distance / _radius) ^ 2) ) - 2 );
					};
					tfar_terrain_interception_coefficient = _originalInterception;
					player setVariable ["tf_receivingDistanceMultiplicator", _originalInterference];
					player setVariable ["tf_sendingDistanceMultiplicator", _originalInterference];
				};
			};
		};
	};
};

_handle;
//Thank you for your attention.