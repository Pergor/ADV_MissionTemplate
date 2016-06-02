/*
ADV_fnc_paraJump - by Belbo:

Allows player to jump with a parachute over a position that's defined by mapclick (or by position of group leader of the player)

Possible call - has to be executed where unit is local:
	[player] call ADV_fnc_paraJump;
Or, with an addaction:
	ADV_handle_paraJumpAction = OBJECT addAction [("<t color=""#33FFFF"">" + ("Parajump") + "</t>"), {[_this select 1] call ADV_fnc_paraJump},nil,3,false,true,"","player distance cursortarget <5"];
*/

params [
	["_unit",player,[objNull]]
];

if !(local _unit) exitWith {};

//script function defined for use below:
ADV_scriptfnc_paraJump = {
	params [
		["_unit",player,[objNull]],
		["_targetPos",[0,0,0], [[]]]
	];
	
	//has the unit had a backpack?
	_unit setVariable ["adv_var_parajump_backpack", backpack _unit, true];
	_unit setVariable ["adv_var_parajump_backpackItems", backpackItems _unit, true];
	if !((_unit getVariable "adv_var_parajump_backpack") == "") then {
		removeBackpack _unit;
		systemChat "Backpack saved. Wait after landing for it to be readded!";
	};
	
	//Parachute is given
	_unit addBackpack "B_Parachute";
	sleep 1+(random 2);
	//unit is moved to height 1500 on given position
	_targetPos = [(_targetPos select 0)+(random 10), (_targetPos select 1)+(random 10), 1500];
	_unit setPos _targetPos;
	
	//safety:
	waitUntil {((getPos _unit) select 2) > 900};
	waitUntil {((getPos _unit) select 2) < 110};
	if (isClass(configFile >> "CfgPatches" >> "ace_parachute")) then {
		if !(backpack _unit == "ACE_ReserveParachute") then {
			_unit action ["openParachute", _unit];
		};
	} else {
		_unit action ["openParachute", _unit];
	};
	
	//removal of the parachute:
	waitUntil {sleep 0.2; isTouchingGround _unit};
	if !(isClass(configFile >> "CfgPatches" >> "ace_parachute")) then { _unit playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon"; };
	sleep 1;
	_unit action ["PutBag"];
	sleep 1;
	//and readding the old one:
	if !((_unit getVariable "adv_var_parajump_backpack") == "") then {
		sleep 2;
		_unit addBackpack (_unit getVariable "adv_var_parajump_backpack");
		{ (backpackContainer _unit) addItemCargoGlobal [_x,1] } forEach (_unit getVariable "adv_var_parajump_backpackItems");
		systemChat "Backpack readded.";
	};
};

//actual code:
if (_unit == leader group _unit) then {
	openmap true;
	[_unit] onMapSingleClick "openmap false; { [_x,_pos] remoteExec ['ADV_scriptfnc_paraJump',0] } forEach (units (group (_this select 0))); onmapsingleclick '';";
/*
} else {
	[_unit] spawn {
		_unit = _this select 0;
		_leader = (leader group _unit);
		sleep 4;
		[_unit,[ (getPos _leader select 0) + (random 5) + 5, (getPos _leader select 1) + (random 5) + 5, 1500 ]] spawn ADV_scriptfnc_paraJump;
	};
*/
};

if (true) exitWith {};