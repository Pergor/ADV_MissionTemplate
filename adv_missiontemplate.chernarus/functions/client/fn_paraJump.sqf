/*
ADV_fnc_paraJump - by Belbo:

Allows player to jump with a parachute over a position that's defined by mapclick (or by position of group leader of the player).
If you want to change the altitudes of the jump and the forced opening, set these variables globally:
adv_parajump_start -> starting altitude
adv_parajump_opening -> forced opening altitude

Possible call - has to be executed where unit is local:
	[player] call ADV_fnc_paraJump;
Or, with an addaction:
	ADV_handle_paraJumpAction = OBJECT addAction [("<t color=""#33FFFF"">" + ("Parajump") + "</t>"), {[_this select 1] call ADV_fnc_paraJump},nil,3,false,true,"","player distance cursortarget <5"];
*/

params [
	["_unit",player,[objNull]],
	["_targetPos",[0,0,0], [[]]]
];

if (!local _unit) exitWith {};

//has the unit had a backpack?
_unit setVariable ["adv_var_parajump_backpack", backpack _unit];
_unit setVariable ["adv_var_parajump_backpackItems", backpackItems _unit];
if !((_unit getVariable "adv_var_parajump_backpack") == "") then {
	//removeBackpack _unit;
	_gwh = "Weapon_Empty" createVehicle [0,0,0]; 
	_unit setVariable ["adv_var_parajump_gwh", _gwh];
	_unit action ["DropBag", _gwh, backpack _unit];
	systemChat "Backpack saved. Wait after landing for it to be readded!";
	sleep 2;
};
sleep 1;
//Parachute is given
_unit addBackpackGlobal "B_Parachute";
sleep 2+(random 4);
//unit is moved to height 2000 on given position
_startingHeight = missionNamespace getVariable ["adv_parajump_start",2000];
_openingHeight = missionNamespace getVariable ["adv_parajump_opening",120];
private _ACE_GForceCoef = _unit getVariable ["ACE_GForceCoef",1];
_unit setVariable ["ACE_GForceCoef", 0.2];
_target = [(_targetPos select 0)+(20+(random 10)), (_targetPos select 1)+(20+(random 10)), _startingHeight];
_unit setPos _target;
_unit allowDamage false;
_openingHeight =  if ( _openingHeight < 119 ) then { 120 } else { _openingHeight };

//safety:
waitUntil {((getPosWorld _unit) select 2) > 500};
_unit moveTo _targetPos;
waitUntil {((getPosWorld _unit) select 2) < _openingHeight};
if (isClass(configFile >> "CfgPatches" >> "ace_parachute")) then {
	if !(backpack _unit == "ACE_ReserveParachute") then {
		_unit action ["openParachute", _unit];
	};
} else {
	_unit action ["openParachute", _unit];
};
_unit moveTo _targetPos;
waitUntil {((getPosWorld _unit) select 2) < 50};
_unit allowDamage true;
_unit setVariable ["ACE_GForceCoef", _ACE_GForceCoef];

//removal of the parachute:
waitUntil {sleep 0.2; ( isTouchingGround _unit || ((getPosATL _unit) select 2) < 1 )};
if !(isClass(configFile >> "CfgPatches" >> "ace_parachute")) then { _unit playMove "AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon"; };
sleep 1;
_unit action ["PutBag"];
sleep 1;
//and readding the old one:
if !((_unit getVariable "adv_var_parajump_backpack") == "") then {
	sleep 2;
	/*
	_unit addBackpackGlobal (_unit getVariable "adv_var_parajump_backpack");
	{ (backpackContainer _unit) addItemCargoGlobal [_x,1] } count (_unit getVariable "adv_var_parajump_backpackItems");
	*/
	_unit action ["TakeBag", (firstBackpack (_unit getVariable "adv_var_parajump_gwh"))];
	sleep 1;
	deleteVehicle (_unit getVariable "adv_var_parajump_gwh");
	systemChat "Backpack readded.";
};

if (true) exitWith {};