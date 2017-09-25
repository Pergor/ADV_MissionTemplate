/*
 * Author: Belbo
 *
 * Returns classnames of all things provided in the array.
 *
 * Arguments:
 * 1: base array to search - <ARRAY> of <OBJECTS>
 * 2: condition to limit search (optional) - <CODE>
 *
 * Return Value:
 * Array of classnames - <ARRAY> of <STRINGS>
 *
 * Example:
 * _classNamesOfCivilians = [allUnits, {side _x isEqualTo civilian}] call adv_fnc_getClassNames;
 *
 * Public: No
 */

params [
	["_checkArray",allUnits,[[]]]
	,["_condition",{true},[{}]]
];

private _array = [];

{
	_array pushBackUnique typeOf _x;
	nil;
} count (_checkArray select _condition);

_array;