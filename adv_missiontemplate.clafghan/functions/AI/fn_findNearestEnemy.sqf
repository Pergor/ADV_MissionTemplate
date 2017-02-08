params [
	["_unit", objNull, [objNull]],
	["_radius", 2000, [0]],
	"_closest"
];

_closest = (_unit findNearestEnemy _unit);

if ( !isNull _closest ) exitWith {
	_closest;
};

private _enemySides = [side _unit] call BIS_fnc_enemySides;
private _nearEnemies = allUnits select { (_x distance _unit) < _radius && (side _x) in _enemySides};

private _closestdist = _radius+1;
{
	if (_x distance _unit < _closestdist) then {
		_closest = _x;
		_closestdist = _x distance _unit;
	};
} forEach _nearEnemies;

_closest;