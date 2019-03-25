/*
 * Author: Belbo (QA and approved by Nyaan)
 *
 * This function turns a vehicle into a radio repeater for use with TFAR. 
 * If the vehicle is within sending range of a radio, the repeater will boost its signal to the provided range.
 * If a radio repeater is destroyed, damaged beyond 60% or descended below the given minimum height it will stop working as a radio repeater.
  *
 * Arguments:
 * 0: target to become relay - <OBJECT>
 * 1: minimum height (over NN) above which the relay can be switched on (optional) - <NUMBER>
 * 2: Range in meters the signal will be boosted to by the relay (optional) - <NUMBER>
 *
 * Return Value:
 * Script handle <HANDLE>
 *
 * Example:
 * _handle = [MRAP_1, 50, 20000] call adv_fnc_radioRelay;
 *
 * Public: Yes/No
 */

if !( isClass(configFile >> "CfgPatches" >> "tfar_core") ) exitWith {};

_handle = _this spawn {
	params [
		["_relay", objNull, [objNull]]
		,["_minHeight", 10, [0]]
		,["_range",20000,[0]]
	];
	
	if !( _relay getVariable ["adv_radioRelay_available",true] ) exitWith {};

	_relay setVariable ["adv_var_isRelay",false];

	//switches for turning the relay on and off (the code that's being executed locally by the activator:
	adv_radioRelay_scriptfnc_turnOn = {
		params ["_relay","_range"];
		_relay setVariable ["adv_var_isRelay",true,true];
		[_relay, _range] call TFAR_antennas_fnc_initRadioTower;
		if (typeOf _relay == "Land_DataTerminal_01_F") then { [_relay,3] call BIS_fnc_dataTerminalAnimate; };
		systemChat "Radio repeater activated.";
	};
	adv_radioRelay_scriptfnc_turnOff = {
		params ["_relay"];
		_relay setVariable ["adv_var_isRelay",false,true];
		[_relay] call TFAR_antennas_fnc_deleteRadioTower;
		if (typeOf _relay == "Land_DataTerminal_01_F") then { [_relay,0] call BIS_fnc_dataTerminalAnimate; };
		systemChat "Radio repeater deactivated.";
	};
	adv_radioRelay_condition = {
		params ["_relay","_unit"];
		if ( !(_relay getVariable ["adv_var_isRelay",false]) && damage _relay < 0.6 && speed _relay isEqualTo 0 ) exitWith {true};
		false;
	};

	//code executed for players so they have actions to activate/deactivate the relay:
	if ( hasInterface ) then {
		waitUntil {player == player};

		//code for ace interaction:
		if ( isClass(configFile >> "CfgPatches" >> "ace_interact_menu") ) then {
			_ace_relayActionON = [
				"relayActionOn",
				("<t color=""#00FF00"">" + ("ACTIVATE RADIO REPEATER") + "</t>"),
				"",
				{
					params ["_relay","_caller","_arguments"];
					_arguments params ["_minHeight","_range"];
					if ( (getPosASL _relay select 2) < _minHeight ) exitWith {
						systemChat (format ["Radio repeater not activated: Below minimal height of %1 meters above MSL.",_minHeight]);
					};
					
					[_relay,_range] call adv_radioRelay_scriptfnc_turnOn;
				},
				{ [_this select 0, _this select 1] call adv_radioRelay_condition },
				nil,[_minHeight,_range]
			] call ace_interact_menu_fnc_createAction;
			_ace_relayActionOFF = [
				"relayActionOff",
				("<t color=""#FF0000"">" + ("DEACTIVATE RADIO REPEATER") + "</t>"),
				"",
				{
					params ["_relay","_caller","_arguments"];
					_arguments params ["_minHeight","_range"];
					
					[_relay] call adv_radioRelay_scriptfnc_turnOff;
				},
				{ !([_this select 0, _this select 1] call adv_radioRelay_condition) },
				nil,[_minHeight,_range]
			] call ace_interact_menu_fnc_createAction;
		
			//adding the actions to the relay:
			[_relay , 0, ["ACE_MainActions"],_ace_relayActionON] call ace_interact_menu_fnc_addActionToObject;
			[_relay , 0, ["ACE_MainActions"],_ace_relayActionOFF] call ace_interact_menu_fnc_addActionToObject;
			
			//and make it carryable if it's a DataTerminal:
			if (typeOf _relay == "Land_DataTerminal_01_F") then {
				[_relay,true,[0,1,0]] call ace_dragging_fnc_setDraggable;
			};
			
		} else {
			//if ace is not present, we have to add actions the vanilla way:
			adv_handle_relayActionOn = _relay addAction [("<t color=""#00FF00"">" + ("Activate Radio Repeater") + "</t>"), {
				
				params ["_relay","_caller","_action","_arguments"];
				_arguments params ["_minHeight","_range"];
				
				if ( (getPosASL _relay select 2) < _minHeight ) exitWith {
					systemChat (format ["Radio repeater not activated: Below minimal height of %1 meters above MSL.",_minHeight]);
				};
				[_relay,_range] call adv_radioRelay_scriptfnc_turnOn;
				_relay removeAction _action;
				
			},[_minHeight,_range],6,false,true,"","[_target,_caller] call adv_radioRelay_condition",5];

			adv_handle_relayActionOff = _relay addAction [("<t color=""#FF0000"">" + ("Deactivate Radio Repeater") + "</t>"), {
				
				params ["_relay","_caller","_action","_arguments"];
				_arguments params ["_minHeight","_range"];
				[_relay] call adv_radioRelay_scriptfnc_turnOff;
				_relay removeAction _action;
				
			},[_minHeight,_range],6,false,true,"","!([_target,_caller] call adv_radioRelay_condition)",5];
		};
	};

	//code that's only executed on the server, that handles the deactivation of the radio relay by damage or height or speed, and that handles the effect of the relay:
	if (isServer) exitWith {
		if ( _relay getVariable ["adv_radioRelay_available",true] ) then {
			_relay setVariable ["adv_radioRelay_available",false];
			[_relay,_minHeight] spawn {
				params ["_relay","_minHeight"];
				while {alive _relay} do {
					waitUntil { sleep 2; damage _relay > 0.6 || !alive _relay || getTerrainHeightASL (getPos _relay) < _minHeight || !((speed _relay) == 0) };
					if ( _relay getVariable "adv_var_isRelay" ) then {
						[_relay] call adv_radioRelay_scriptfnc_turnOff;
						{
							systemChat "Radio repeater deactivated.";
						} remoteExec ["call",driver _relay];
					};
					waitUntil { sleep 2; damage _relay < 0.4 || !alive _relay  || ((speed _relay) == 0) };
				};
				_relay setVariable ["adv_radioRelay_available",true];
			};
		};
	};
};

_handle;
//Thank you for your attention.