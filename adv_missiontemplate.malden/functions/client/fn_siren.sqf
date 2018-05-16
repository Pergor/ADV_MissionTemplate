/*
 * Author: Belbo
 *
 * Adds an action to a vehicle that switches a siren on/off and beacons on/off.
 *
 * Arguments:
 * 0: object the action should be attached to. - <OBJECT>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [target] spawn adv_fnc_siren;
 *
 * Public: No
 */

params [
	["_target",objNull,[objNull]]
];

if (!isNil "adv_handle_sirenActionLightsOff") then {
	_target removeAction adv_handle_sirenActionOn;
	_target removeAction adv_handle_sirenActionLightsOn;
};

adv_scriptfnc_sirenLights = {
	params ["_target","_caller","_action","_arguments"];
	_arguments params ["_lightsOn"];
	call {
		if ( toUpper (typeOf _target) in ["B_GEN_OFFROAD_01_GEN_F"] || _target animationPhase "hidePolice" isEqualTo 0 ) exitWith {
			_target animate ['BeaconsStart',_lightsOn];
		};
		if ( toUpper (typeOf _target) in ["C_OFFROAD_01_REPAIR_F","B_G_OFFROAD_01_REPAIR_F","I_G_OFFROAD_01_REPAIR_F","O_G_OFFROAD_01_REPAIR_F"] ||  _target animationPhase "HideServices" isEqualTo 0 ) exitWith {
			_target animate ['HideServices',0];
			_target animate ['BeaconsServicesStart',_lightsOn];
		};
	};
	_target setVariable ["adv_siren_lights_on",_lightsOn,true];
};

adv_scriptfnc_siren_condition = {
	params ["_target","_caller"];
	if (alive _target && driver _target isEqualTo _caller) exitWith {
		if !(_target getVariable ['adv_siren_on',false]) exitWith {
			true
		};
		false
	};
	false
};

adv_scriptfnc_sirenOn = {
	params ["_target","_caller","_action","_arguments"];
	_target removeaction _action;
	_target setVariable ["adv_siren_on", true, true];
	[_target,_caller,_action,1] call adv_scriptfnc_sirenLights;
	_tmp = true;
	adv_handle_sirenActionOff = _target addAction ["Sirene Aus",{0 = _this spawn adv_scriptfnc_sirenOff},[],54,false,true,"","_target getVariable ['adv_siren_on',false] && (alive _target && driver _target isEqualTo _this)"];
	while {_tmp} do {
		[_target,["AlarmCar",120]] remoteExecCall ["say3D",0];
		sleep 1.95;
		_tmp = _target getVariable "adv_siren_on";
	};
};

adv_scriptfnc_sirenOff = {
	params ["_target","_caller","_action","_arguments"];
	_target removeaction _action;
	adv_handle_sirenActionOn = _target addaction [
		"<t color='#00FF00'>" + ("Sirene Ein") + ("</t>"),
		{0 = _this spawn adv_scriptfnc_sirenOn},
		[],54,false,true,"",
		"!(_target getVariable ['adv_siren_on',false]) && (alive _target && driver _target isEqualTo _this)"
	];
	_target setVariable ["adv_siren_on", false, true];
};

adv_handle_sirenActionOn = _target addaction [
	"<t color='#00FF00'>" + ("Sirene Ein") + ("</t>"),
	{0 = _this spawn adv_scriptfnc_sirenOn},
	[],54,false,true,"",
	"!(_target getVariable ['adv_siren_on',false]) && (alive _target && driver _target isEqualTo _this)"
];
adv_handle_sirenActionLightsOn = _target addaction [
	"Blinklichter Ein",
	{_this call adv_scriptfnc_sirenLights},
	[1],53,false,true,"",
	"_target getVariable ['adv_siren_lights_on',0] isEqualTo 0 && (alive _target && driver _target isEqualTo _this)"
];
adv_handle_sirenActionLightsOff = _target addaction [
	"Blinklichter Aus",
	{_this call adv_scriptfnc_sirenLights},
	[0],53,false,true,"",
	" _target getVariable ['adv_siren_lights_on',0] > 0 && (alive _target && driver _target isEqualTo _this)"
];

if (isNil "adv_evh_siren") then {
	adv_evh_siren = _target addEventHandler ["killed", {
		params ["_unit","_killer","_instigator","_useEffects"];
		_unit setVariable ["adv_siren_lights_on",0,true];
		_unit setVariable ["adv_siren_on",false,true];
	}];
};

true;