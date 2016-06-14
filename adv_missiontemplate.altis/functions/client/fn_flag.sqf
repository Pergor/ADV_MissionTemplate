/*
ADV_fnc_flag by Belbo

Attaches an action to an object that allows teleport to the current group leader (or the next member in group for group leaders).

Possible call - has to be executed on each client locally:
[FLAGNAME_1,FLAGNAME_2] spawn ADV_fnc_flag;

_this = objects the action should be attached to.
*/
if (count _this == 0) exitWith {};

{
	_x addAction [
		"<t color='#00FF00'>Teleport zum Gruppenführer</t>",
		{
			_unit = _this select 1;
			_leader = leader _unit;
			if (vehicle _leader != _leader) then {
				_vehicle = vehicle _leader;
				_unit moveInCargo _vehicle;
			} else {
				_unit setPos (getPos _leader);
			};
			if (_leader == _unit) then {
				_target = (units group _unit) select 1;
				if (!isNil "_target") then {
					if (vehicle _target != _target) then {
						_vehicle = vehicle _target;
						_unit moveInCargo _vehicle;
					} else {
						_unit setPos (getPos _target);
					};
				};
			};
		},nil,6,false,false,"","player distance cursortarget <5"
	];
} forEach _this;
	
if (true) exitWith {};