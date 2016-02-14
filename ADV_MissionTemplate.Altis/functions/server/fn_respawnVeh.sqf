/*
Vehicle Respawn Script by belbo
Respawnt ein Fahrzeug nach angegebener Zeit.
defined in cfgFunctions (functions\server\fn_respawnVeh.sqf)

_this select 0 = respawnendes Fahrzeuge - object
_this select 1 = Respawn-Zeit - integer
_this select 2 = new vehicle class (optional) - object

call via:

[VEHICLE,DELAY] spawn ADV_fnc_respawnVeh;

*/
if (!isServer) exitWith {};
waitUntil {time > 20};

/*
private ["_veh","_delay","_name","_markerName","_respawnPos","_vehType"];
_veh = [_this, 0, ObjNull, [ObjNull]] call BIS_fnc_param;
_delay = [_this, 1, 5, [0]] call BIS_fnc_param;
*/

params [
	["_veh", objNull, [objNull]],
	["_delay", 5, [0]],
	"_name","_newVehicleName","_markerName","_respawnPos","_vehType"
];

//delay
if (_delay < 5) then {_delay = 5};
if (_delay == 9999) exitWith {};

//initial respawn position
_name = vehicleVarname _veh;
if (_name == "") then {
	if (isNil "ADV_respawnVeh_newNameNumber") then {ADV_respawnVeh_newNameNumber=1;};
	_newVehicleName = format ["%1%2","newVehicle_",ADV_respawnVeh_newNameNumber];
	_veh setVehicleVarname _newVehicleName;
	_name = _newVehicleName;
	ADV_respawnVeh_newNameNumber = ADV_respawnVeh_newNameNumber+1;
};
_markerName = format ["%1%2","respPos_",_name];
_respawnPos = createMarkerLocal [_markerName, getPos _veh];
_respawnPos setMarkerDirLocal (getDir _veh);

//vehicle classname
if (count _this > 2) then {_vehType = _this select 2;} else {_vehType = typeOf _veh;};

while {true} do {
	waitUntil {sleep 1; !alive _veh};
	sleep 1;
	if (isNull _veh) exitWith {
		deleteMarkerLocal _respawnPos;
	};
	sleep _delay-3;
	{detach _x; deleteVehicle _x} forEach attachedObjects _veh;
	if (_veh distance2D (getMarkerPos _respawnPos) < 100) then { deleteVehicle _veh; };
	_veh enableSimulation false;
	sleep 2;
	_veh = createVehicle [_vehType, (getMarkerPos _respawnPos), [], 0, "CAN_COLLIDE"];
	_veh setDir (markerDir _respawnPos);
	_veh setVehicleVarName _name;
	sleep 2;
	{_x addCuratorEditableObjects [[_veh],false];} forEach allCurators;
	[_veh] call ADV_fnc_disableVehSelector;
	[_veh] call ADV_fnc_clearCargo;
	if ((str _veh) in ADV_veh_all) then {
		[_veh] call ADV_fnc_addVehicleLoad;
		if (ADV_par_TIEquipment > 0) then {
			_veh disableTIEquipment true;
			if (ADV_par_TIEquipment > 2) then {
				_veh disableNVGEquipment true;
			};
		};
	} else {
		if (_veh isKindOf "Helicopter" || _veh isKindOf "Ship") then {[_veh,false,false,2,false] call ADV_fnc_vehicleLoad;};
		if (_veh isKindOf "Plane") then {[_veh,false,false,1,false] call ADV_fnc_vehicleLoad;};
		if (_veh isKindOf "Tank") then {[_veh,false,false,2,false] call ADV_fnc_vehicleLoad;};
		if (_veh isKindOf "Car") then {[_veh,false,false,1,false] call ADV_fnc_vehicleLoad;};
		if (_veh isKindOf "Motorcycle") then {[_veh,false,false,1,false] call ADV_fnc_vehicleLoad;};
	};
	if ( ADV_par_Radios > 0 && (_veh isKindOf "CAR" || _veh isKindOf "TANK" || _veh isKindOf "AIR") ) then {
		_veh setVariable ["tf_hasRadio", true, true];
		//_veh setVariable ["tf_side", west, true];
	};
	if (!isNil "ADV_veh_artys") then {
		if (_name in ADV_veh_artys) then {
			[_veh] call ADV_fnc_showArtiSetting;
		};
	};
	if (!isNil "ADV_veh_indAllVeh") then {
		if (_name in ADV_veh_indAllVeh) then {
			sleep 2;
			_veh setObjectTextureGlobal [0,'#(rgb,8,8,3)color(0,0,0,1)'];
			_veh setObjectTextureGlobal [1,'#(rgb,8,8,3)color(0,0,0,1)'];
		};
	};
};
	
if (true) exitWith{};