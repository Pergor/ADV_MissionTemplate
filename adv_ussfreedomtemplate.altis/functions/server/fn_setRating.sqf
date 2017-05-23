/*
 * Author: Belbo
 *
 * Sets rating of a unit to a specific value - only multiples of 10 are possible values.
 *
 * Arguments:
 * Objects - <OBJECTS>
 *
 * Return Value:
 * new rating of unit - <BOOL>
 *
 * Example:
 * [player,1000] call adv_fnc_setRating;
 *
 * Public: Yes
 */

params [
	["_unit",objNull,[objNull]]
	,["_newRating",1000,[0]]
];

private _startRating = rating _unit;
if ( _startRating > _newRating ) then {
	for "_i" from 1 to 10000 do {
		if (rating _unit <= _newRating) exitWith {};
		_unit addRating -10;
	};
} else {
	for "_i" from 1 to 10000 do {
		if (rating _unit >= _newRating) exitWith {};
		_unit addRating 10;
	};
};

private _return = rating _unit;

_return;