/*
zeus script by Belbo
Makes most units placed in the editor and playable units editable by Zeus.
Call from init.sqf via:
if (isServer) then {[CURATORMODULENAME,true] execVM "fn_zeus.sqf";};
*/

if (!isServer) exitWith {};

/*
_HC = [_this, 0, ObjNull, [ObjNull]] call BIS_fnc_param;
_units = [_this, 1, allUnits, [[]]] call BIS_fnc_param;
*/

params [
	["_HC", objNull, [objNull]],
	["_units", allUnits, [[]]]
];

{
	if (!isPlayer _x && !(_x getVariable ["Owned_by_HC",false])) then {
		_x setOwner (owner _HC);
		_x setVariable ["Owned_by_HC",true];
	};
} forEach _units;

if (true) exitWith {};