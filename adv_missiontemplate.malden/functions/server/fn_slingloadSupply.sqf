/*
 * Author: Belbo
 *
 * Spawns a helicopter that will fly to specified location with slingloaded cargo. Cargo will be unhooked at target location.
 * Helicopter will fly back to start and be deleted upon return.
 * If helicopter cannot slingload cargo, it will be deleted automatically.
 * Has to be executed on server.
 *
 * Arguments:
 * 0: target position, can be position, object or marker - <ARRAY>, <OBJECT>, <STRING>
 * 1: starting position, can be position, object or marker - <ARRAY>, <OBJECT>, <STRING>
 * 3: Side of the helicopter and the crew (side ID can be provided) - <SIDE>, <NUMBER>
 * 4: Classname of the helicopter - <STRING>
 * 5: Classname of the cargo - <STRING>
 * 6: Function, array of functions or code to be executed. Cargo is _this inside code if STRING is provided, _this select 0 in function.
 *    If array is provided, functions inside array will be executed from first to last.
 *    Code will be executed scheduled, function and functions will be called. (optional) - <FUNCTION>, <ARRAY>, <STRING>
 *
 * Return Value:
 * Array containing [HELICOPTER,ARRAY of CREW,GROUP of HELICOPTER,CARGO] - <ARRAY>
 * If helicopter could not slingload cargo, return value is false - <BOOL>
 *
 * Example:
 * [target,start,west,"B_Heli_Transport_03_F","B_CargoNet_01_ammo_F",[adv_fnc_clearCargo,adv_fnc_crateLarge]] call ADV_fnc_dropHeliSupply;
 * or
 * [target,start,west,"B_Heli_Transport_03_F","B_CargoNet_01_ammo_F","clearWeaponCargoGlobal _this"] call ADV_fnc_dropHeliSupply;
 *
 * Public: Yes
 */

if (!isServer && hasInterface) exitWith {};

params [
	["_target", objNull, [objNull,"",[]]]
	,["_start", objNull, [objNull,"",[]]]
	,["_side", west, [west,0]]
	,["_heliClass", "B_Heli_Transport_03_F", [""]]
	,["_cargoType", "B_CargoNet_01_ammo_F", [""]]
	,["_code", [], [[],"",objNull]]
];

//just some small code to delete Vehicle later
private _deleteVehicle = {
	params ["_vehicle","_crew","_cargo"];
	{deleteVehicle _x} forEach _crew;
	deleteVehicle _vehicle;
	deleteVehicle _cargo;
};

//make sure classnames are provided:
//always revert to B_Heli_Transport_03_F, if no classname is given:
if !(isClass (configFile >> "CfgVehicles" >> _heliClass)) then {
	_heliClass = "B_Heli_Transport_03_F";
};
if !(isClass (configFile >> "CfgVehicles" >> _cargoType)) then {
	_cargoType = "B_CargoNet_01_ammo_F";
};

//target position:
private _targetPos = [_target] call adv_fnc_getPos;
private _targetPosEmpty = _targetPos findEmptyPosition [1, 80, _cargoType];
if !(_targetPosEmpty distance _targetPos > 81 || _targetPosEmpty isEqualTo []) then {
	_targetPos = _targetPosEmpty;
};

//start position:
private _startPos = [_start] call adv_fnc_getPos;
if (_targetPos distance2D _startPos < 500) then {
	_startPos = [0,0,50];
};

//get side, if side ID is provided:
if (_side isEqualType 0) then {
	_side = _side call BIS_fnc_sideType;
};

//spawn the heli:
private _spawnedArr = [_startPos, _startPos getDir _targetPos, _heliClass, _side] call BIS_fnc_spawnVehicle;
_spawnedArr params ["_vehicle","_crew","_group"];
//make it invincible for the approach:
_vehicle allowDamage false;
{_x allowDamage false} count _crew;

//give the crew some edge:
private _pilot = driver _vehicle;
_pilot setSkill 1;
_group allowFleeing 0;
_group deleteGroupWhenEmpty true;

//create the cargo:
private _cargo = _cargoType createVehicle _startPos;

//delete and exit if not slingloadable:
if !(_vehicle canSlingLoad _cargo) exitWith {
	[_vehicle,_crew,_cargo] call _deleteVehicle;
	false
};

//slingload the cargo:
_vehicle setSlingLoad _cargo;

//add everything to curator:
{ _x addCuratorEditableObjects [[_cargo,_vehicle]+_crew,false] } forEach allCurators;

//create target waypoint:
private _targetWP = _group addWaypoint [_targetPos, 20];
_group setSpeedMode "FULL";
_targetWP setWaypointType "UNHOOK";
//make vehicle and crew destructable again:
_targetWP setWaypointStatements ["true", "(vehicle this) allowDamage true; {_x allowDamage true} foreach thisList;"];

//create return waypoint:
private _returnWP = _group addWaypoint [_startPos, 0];
_returnWP setWaypointTimeout [2, 2, 2];
_returnWP setWaypointStatements ["true", "deleteVehicle (vehicle this); {deleteVehicle _x} foreach thisList;"];

//execute code for cargo:
if (_code isEqualType "") then {
	_cargo spawn compile _code;
};
if (_code isEqualType objNull) then {
	[_cargo] call _code;
};
if (_code isEqualType []) then {
	{[_cargo] call _x} forEach _code;
};

//return:
private _return = [_vehicle,_crew,_group,_cargo];
_return