/*
Vehicle disabling Script by belbo
Ersetzt ein Fahrzeug durch ein anderes
_this = vehicle
*/
if (!isServer) exitWith {};
if (count _this == 0) exitWith {};

{
	_x enableSimulationGlobal false;
	[_x] call ADV_fnc_clearCargo;
	_x lock true;
} forEach _this;
	
if (true) exitWith{};