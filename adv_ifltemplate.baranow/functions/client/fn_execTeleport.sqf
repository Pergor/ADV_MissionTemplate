/*
ADV_fnc_execTeleport by Belbo
*/

params [
	["_unit", player, [objNull]],
	["_selection", "TELEPORT_GROUP", [""]]
];

adv_var_teleport_target = [];
adv_var_teleport_opf_target = [];
adv_var_teleport_ind_target = [];

switch (toUpper _selection) do {
	case "TELEPORT_COMMAND": {
		{
			private _unit = _x;
			private _unitName = str _unit;
			if ( [_unitName,0,6] call BIS_fnc_trimString == "command" ) then { adv_var_teleport_target pushBack _unit; };
			if ( [_unitName,0,10] call BIS_fnc_trimString == "opf_command" ) then { adv_var_teleport_opf_target pushBack _unit; };
			if ( [_unitName,0,10] call BIS_fnc_trimString == "ind_command" ) then { adv_var_teleport_ind_target pushBack _unit; };
			nil;
		} count playableUnits;
	};
	case "TELEPORT_GROUP": {
		private _leader = leader _unit;
		private _groupTarget = [];
		call {
			if !( _unit isEqualTo _leader ) exitWith {
				_groupTarget = [_leader];
			};
			{
				if ((_unit distance _x) > 50 ) then { _groupTarget pushBack _x };
				nil;
			} count (units group _unit);
		};
		adv_var_teleport_target = _groupTarget;
		adv_var_teleport_opf_target = _groupTarget;
		adv_var_teleport_ind_target = _groupTarget;
	};
};

_target = switch (side (group _unit)) do {
	case east: { selectRandom adv_var_teleport_opf_target };
	case independent: { selectRandom adv_var_teleport_ind_target };
	default { selectRandom adv_var_teleport_target };
};

if (isNil "_target") exitWith {};

if (vehicle _target != _target) then {
	_vehicle = vehicle _target;
	_unit moveInCargo _vehicle;
} else {
	_unit setPosATL (getPosATL _target);
};

true;