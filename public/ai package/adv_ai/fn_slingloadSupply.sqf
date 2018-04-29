/*
 * Author: Belbo
 *
 * Spawns an aircraft that will fly to specified location with slingloaded or carried cargo. Cargo will be unhooked/unloaded at target location.
 * Aircraft will fly back to start and be deleted upon return, if it's a helicopter, or to the opposite position, if it's a plane.
 * If aircraft cannot slingload or load cargo, it will be deleted automatically.
 * Has to be executed on server.
 *
 * Arguments:
 * 0: target position, can be position, object or marker - <ARRAY>, <OBJECT>, <STRING>
 * 1: starting position, can be position, object or marker - <ARRAY>, <OBJECT>, <STRING>
 * 3: Side of the helicopter and the crew (side ID can be provided) - <SIDE>, <NUMBER>
 * 4: Classname of the aircraft - <STRING>
 * 5: Classname of the cargo - <STRING>
 * 6: Function, array of functions or code to be executed. Cargo is _this inside code if STRING is provided, _this select 0 in function.
 *    If array is provided, functions inside array will be executed from first to last.
 *    Code will be executed scheduled, function and functions will be called. (optional) - <FUNCTION>, <ARRAY>, <STRING>
 *
 * Return Value:
 * Array containing [VEHICLE,ARRAY of CREW,GROUP of AIRCRAFT,CARGO] - <ARRAY>
 * If aircraft could not slingload or load cargo, return value is false - <BOOL>
 *
 * Example:
 * [target,start,west,"B_Heli_Transport_03_F","B_CargoNet_01_ammo_F",[adv_fnc_clearCargo,adv_fnc_crateLarge]] call adv_ai_fnc_slingloadSupply;
 * or
 * [target,start,1,"B_T_VTOL_01_vehicle_F","B_Slingload_01_Cargo_F","clearWeaponCargoGlobal _this"] call adv_ai_fnc_slingloadSupply;
 * or
 * [target,start,1,"B_Heli_Transport_03_F","B_LSV_01_armed_F","[_this] call adv_fnc_clearCargo;[_this,false,true,2] call adv_fnc_vehicleLoad"] call adv_ai_fnc_slingloadSupply;
 *
 * Public: Yes
 */

if (!isServer && hasInterface) exitWith {};

params [
	["_target", objNull, [objNull,"",[]]]
	,["_start", objNull, [objNull,"",[]]]
	,["_side", west, [west,0]]
	,["_vehicleType", "B_Heli_Transport_03_F", [""]]
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
if !(isClass (configFile >> "CfgVehicles" >> _vehicleType)) then {
	_vehicleType = "B_Heli_Transport_03_F";
};
if !(isClass (configFile >> "CfgVehicles" >> _cargoType)) then {
	_cargoType = "B_CargoNet_01_ammo_F";
};

//target position:
private _targetPos = [_target] call adv_ai_fnc_getPos;
private _targetPosEmpty = _targetPos findEmptyPosition [1, 80, _cargoType];
if !(_targetPosEmpty distance _targetPos > 81 || _targetPosEmpty isEqualTo []) then {
	_targetPos = _targetPosEmpty;
};

//start position:
private _startPos = [_start] call adv_ai_fnc_getPos;
if (_targetPos distance2D _startPos < 500) then {
	_startPos = [0,0,50];
};

//get side, if side ID is provided:
if (_side isEqualType 0) then {
	_side = _side call BIS_fnc_sideType;
};

//spawn the heli:
private _spawnedArr = [_startPos, _startPos getDir _targetPos, _vehicleType, _side] call BIS_fnc_spawnVehicle;
_spawnedArr params ["_vehicle","_crew","_group"];
//make it invincible for the approach:
_vehicle allowDamage false;
{_x allowDamage false} count _crew;

//give the crew some edge:
private _pilot = driver _vehicle;
_pilot setSkill 1;
{_pilot disableAI _x} forEach ["TARGET", "AUTOTARGET","AUTOCOMBAT"];
_group allowFleeing 0;
_group deleteGroupWhenEmpty true;
if (_vehicle isKindOf "PLANE") then {
	_vehicle flyInHeight 200;
};

//create the cargo:
private _cargo = _cargoType createVehicle _startPos;

//delete and exit if not slingloadable:
private _canSling = _vehicle canSlingLoad _cargo;
private _canCargo = (_vehicle canVehicleCargo _cargo) select 0;
if !(_canSling || _canCargo) exitWith {
	[_vehicle,_crew,_cargo] call _deleteVehicle;
	false
};

//slingload the cargo:
private _mode = 0;
if ( _canSling ) then {
	_vehicle setSlingLoad _cargo;
	_mode = 1;
};
//or load it:
if ( _canCargo && _mode isEqualTo 0 ) then {
	_vehicle setVehicleCargo _cargo;
	_mode = 2;
};

//add everything to curator:
{ _x addCuratorEditableObjects [[_cargo,_vehicle]+_crew,false] } forEach allCurators;

//create target waypoint:
private _targetWP = _group addWaypoint [_targetPos, 20];
_group setSpeedMode "FULL";
if (_mode isEqualTo 1 && !((getSlingLoad _vehicle) isEqualTo objNull) ) then {
	_targetWP setWaypointType "UNHOOK";
	//make vehicle and crew destructable again:
	_targetWP setWaypointStatements ["true", "(vehicle this) allowDamage true; {_x allowDamage true} foreach thisList;"];
};
if ( _mode isEqualTo 2 && !(getVehicleCargo _vehicle isEqualTo []) ) then {
	_targetWP setWaypointStatements ["true", "objNull setVehicleCargo ((getVehicleCargo (vehicle this)) select 0);(vehicle this) allowDamage true; {_x allowDamage true} foreach thisList;"];
	if (_cargo isKindOf "ReammoBox_F" || _cargo isKindOf "ReammoBox") then {
		[_cargo] spawn {
			params ["_cargo"];
			waitUntil {sleep 1; ((getPosATL _cargo) select 2) < 30};
			_smoke = "G_40mm_SmokeOrange" createVehicle (getPosWorld _cargo);
			_smoke attachTo [_cargo, [0, 0, -1]];
			waitUntil {sleep 1; ((getPosATL _cargo) select 2) < 2};
			detach _cargo;
		};
	};
};

//create return waypoint:
private _returnPos = if ( _vehicle isKindOf "PLANE" ) then {[_startPos,_targetPos,false] call adv_ai_fnc_getOppPos} else {_startPos};
private _returnWP = _group addWaypoint [_returnPos, 0];
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