/*
 * Author: Belbo
 *
 * Locks one or multiple vehicles for AI and not for players.
 *
 * Arguments:
 * Array of vehicles - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [MRAP_1, MRAP_2, ..., MRAP_n] call adv_fnc_lockVeh;
 *
 * Public: Yes
 */

if (!isServer) exitWith{};

{
	_target = _x;
	if (isNil "_target") exitWith {};
	_target addEventHandler [
		"GetIn", {
			_unit = _this select 2;
			if !(isPlayer _unit) then {
				_veh = _this select 0;
				_fuel = fuel _veh;
				_veh setFuel 0;
				_unit action ["eject", _veh];
				[_unit,_veh,_fuel] spawn {
					waitUntil {
						sleep 1;
						vehicle (_this select 0) == (_this select 0)
					};
					(_this select 1) setFuel (_this select 2);
				};
			};
		}
	];
	nil;
} count _this;

true;