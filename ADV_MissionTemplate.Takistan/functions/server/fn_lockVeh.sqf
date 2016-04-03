/*
ADV_fnc_lockVehicle

This function locks one vehicle or multiple vehicles for all but players.
*/

if (!isServer) exitWith{};

{
	_x addEventHandler [
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
} forEach _this;

if (true) exitWith {};