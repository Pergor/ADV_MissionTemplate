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
 * 5: Classname of the cargo or object that will be transported and dropped - <STRING> or <OBJECT>
 * 6: Function, array of functions or code to be executed. Cargo is _this inside code if STRING is provided, _this select 0 in function.
 *    If array is provided, functions inside array will be executed from first to last.
 *    Code will be executed scheduled, function and functions will be called. (optional) - <FUNCTION>, <ARRAY>, <STRING>
 *
 * Return Value:
 * Array containing [VEHICLE,ARRAY of CREW,GROUP of AIRCRAFT,CARGO] - <ARRAY>
 * If aircraft could not slingload or load cargo, return value is false - <BOOL>
 *
 * Example:
 * [target,start,west,"B_Heli_Transport_03_F","B_CargoNet_01_ammo_F",[adv_fnc_clearCargo,adv_fnc_crateLarge]] call adv_fnc_slingloadSupply;
 * or
 * [target,start,1,"B_T_VTOL_01_vehicle_F","B_Slingload_01_Cargo_F","clearWeaponCargoGlobal _this"] call adv_fnc_slingloadSupply;
 * or
 * [target,start,1,"B_Heli_Transport_03_F","B_LSV_01_armed_F","[_this] call adv_fnc_clearCargo;[_this,false,true,2] call adv_fnc_vehicleLoad"] call adv_fnc_slingloadSupply;
 *
 * Public: Yes
 */

if (!isServer && hasInterface) exitWith {};

params [
	["_target", objNull, [objNull,"",[]]]
	,["_start", [999,999,999], [objNull,"",[]]]
	,["_side", west, [west,0]]
	,["_vehType", "B_Heli_Transport_03_F", [""]]
	,["_cargoType", "B_CargoNet_01_ammo_F", ["",objNull]]
	,["_code", [], [[],"",objNull]]
];

//just some small code to delete Vehicle later
private _deleteVehicle = {
	params ["_veh","_crew","_cargo"];
	{deleteVehicle _x} forEach _crew;
	deleteVehicle _veh;
	deleteVehicle _cargo;
};

private _isReady = if (_cargoType isEqualType objNull) then {true} else {false};
private _readyCargo = if (_cargoType isEqualType objNull) then {_cargoType} else {objNull};
if (_isReady) then {_cargoType = "B_CargoNet_01_ammo_F"};

//make sure classnames are provided:
//always revert to B_Heli_Transport_03_F, if no classname is given:
if !(isClass (configFile >> "CfgVehicles" >> _vehType)) then {
	_vehType = "B_Heli_Transport_03_F";
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
private _startPos = [_start,nil,nil,false] call adv_fnc_getPos;
private _dist = if (_vehType isKindOf 'PLANE') then {6000} else {4000};
if ( _targetPos distance2D _startPos < 500 || _startPos isEqualTo [999,999,999] ) then {
	_startPos = [[_targetPos, _dist, _dist, 0, false],true] call CBA_fnc_randPosArea;
};
_startPos set [2,100];
private _dir = _startPos getDir _targetPos;


//get side, if side ID is provided:
if (_side isEqualType 0) then {
	_side = _side call BIS_fnc_sideType;
};

//spawn the heli:
//private _veh = createVehicle ['CUP_B_C130J_Cargo_GB', position player, [], 0, "FLY"];
private _spawnedArr = [_startPos, _dir, _vehType, _side] call BIS_fnc_spawnVehicle;
_spawnedArr params ["_veh","_crew","_group"];
_veh engineOn true;
//make it invincible for the approach:
_veh allowDamage false;
{_x allowDamage false} count _crew;
//other vehicle parameters:
_group setBehaviour "CARELESS";
_veh setCollisionLight true;
_veh setPilotLight true;
_veh enableDynamicSimulation false;
_veh setFeatureType 2;
_veh setVehicleReportOwnPosition true;

//give the crew some edge:
private _pilot = driver _veh;
_pilot setSkill 1;
{_pilot disableAI _x} forEach ["TARGET", "AUTOTARGET","AUTOCOMBAT"];
_group allowFleeing 0;
_group deleteGroupWhenEmpty true;
if (_veh isKindOf "PLANE") then {
	_veh flyInHeight 200;
	_veh setvelocity [100 * (sin _dir),100 * (cos _dir),0];
};
//add an onEachFram-EVH for the frickin' lights:
private _evhID = [format ["adv_evh_logistic_lightsOn_%1",(missionNamespace getVariable ["adv_evh_logistic_lightsOn_NR",0])], "onEachFrame", {params ["_veh","_pilot"];_pilot action ["lightOn",_veh];}, [_veh,_pilot]] call BIS_fnc_addStackedEventHandler;
_veh setVariable ["adv_evh_logistic_lightsOn_EVH",_evhID];
missionNamespace setVariable ["adv_evh_logistic_lightsOn_NR",(missionNamespace getVariable ["adv_evh_logistic_lightsOn_NR",0])+1,true];
[{ !alive (_this select 0) }, { params ["_veh"];[_veh getVariable ['adv_evh_logistic_lightsOn_EVH',''],'onEachFrame'] call BIS_fnc_removeStackedEventHandler; }, [_veh]] call CBA_fnc_waitUntilAndExecute;
//add a getOut-EVH in case the vehicle comes under attack:
_veh addEventHandler ["GetOut", {
	params ["_vehicle", "_role", "_unit", "_turret"];
	_unit setDamage 1;
}];

//create or get the cargo:
private _cargo = if (!_isReady) then { _cargoType createVehicle _startPos } else {_readyCargo};
_cargo enableDynamicSimulation false;
_cargo setFeatureType 2;

//delete and exit if not slingloadable:
private _canSling = _veh canSlingLoad _cargo;
private _canCargo = (_veh canVehicleCargo _cargo) select 0;
if !(_canSling || _canCargo) exitWith {
	if (_isReady) then {
		[_veh,_crew,objNull] call _deleteVehicle;
	} else {
		[_veh,_crew,_cargo] call _deleteVehicle;
	};
	false
};

//slingload the cargo:
private _mode = 0;
if ( _canCargo ) then {
	_veh setVehicleCargo _cargo;
	_mode = 2;
};
//or load it:
if ( _canSling && _mode isEqualTo 0 ) then {
	_veh setSlingLoad _cargo;
	_mode = 1;
};

//add everything to curator:
{ _x addCuratorEditableObjects [[_cargo,_veh]+_crew,false] } forEach allCurators;

//create target waypoint:
private _targetWP = _group addWaypoint [_targetPos, 20];
_group setSpeedMode "FULL";
if (_mode isEqualTo 1 && !((getSlingLoad _veh) isEqualTo objNull) ) then {
	_targetWP setWaypointType "UNHOOK";
	//make vehicle and crew destructable again:
	_targetWP setWaypointStatements ["true", "(vehicle this) allowDamage true; {_x allowDamage true} foreach thisList; [(vehicle this) getVariable ['adv_evh_logistic_lightsOn_EVH',''],'onEachFrame'] call BIS_fnc_removeStackedEventHandler;"];
};
if ( _mode isEqualTo 2 && !(getVehicleCargo _veh isEqualTo []) ) then {
	_targetWP setWaypointStatements ["true", "objNull setVehicleCargo ((getVehicleCargo (vehicle this)) select 0);(vehicle this) allowDamage true; {_x allowDamage true} foreach thisList; [(vehicle this) getVariable ['adv_evh_logistic_lightsOn_EVH',''],'onEachFrame'] call BIS_fnc_removeStackedEventHandler;"];
	if (_cargo isKindOf "ReammoBox_F" || _cargo isKindOf "ReammoBox") then {
		[_cargo] spawn {
			params ["_cargo"];
			waitUntil {sleep 1; ((getPosATL _cargo) select 2) < 30};
			private _smoke = "G_40mm_SmokeOrange" createVehicle (getPosWorld _cargo);
			private _IRlight = "B_IRStrobe" createVehicle (getPosWorld _cargo);
			private _signals = [_smoke,_IRlight];
			if (sunOrMoon < 1) then {
				private _lightType = if ( isClass(configFile >> "CfgPatches" >> "ace_grenades") && ((missionNamespace getVariable ["adv_par_NVGs",0] < 2) || (missionNamespace getVariable ["adv_par_opfNVGs",0] < 2)) ) then { "ACE_F_Hand_Red" } else { "Chemlight_red" };
				private _light = _lightType createVehicle (getPosWorld _cargo);
				_signals pushBack _light;
			};
			{_x attachTo [_cargo, [0, 0, 0.82]]; nil} count _signals;
			waitUntil {sleep 1; ((getPosATL _cargo) select 2) < 2};
			detach _cargo;
		};
	};
};

//create return waypoint:
private _returnPos = if ( _veh isKindOf "PLANE" ) then {[_startPos,_targetPos,false] call adv_fnc_getOppPos} else {_startPos};
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
private _return = [_veh,_crew,_group,_cargo];
_return