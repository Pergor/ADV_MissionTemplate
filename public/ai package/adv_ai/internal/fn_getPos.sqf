/*
 * Author: Belbo
 *
 * Returns a position depending on the type of position provided. Helps to turn a marker, a group, an object or a position into posATL.
 * Default fall back is NOT [0,0,0] but world's safePositionAnchor.
 * Height in case of marker or safePositionAnchor is always 0.
 *
 * Arguments:
 * 0: object, position or marker to turn into posATL - <ARRAY>, <OBJECT>, <STRING>, <GROUP>
 *
 * Return Value:
 * Position ATL - <ARRAY>
 *
 * Example:
 * _objPos = [player] call adv_ai_fnc_getPos;
 *
 * Public: No
 */

params [
	["_pos", [0,0,0], [[], "", objNull,grpNull,0]]
	,["_pos1", 0, [0]]
	,["_pos2", 0, [0]]
];

private _worldAnchor = (configFile >> "CfgWorlds" >> worldName >> "safePositionAnchor") call BIS_fnc_getCfgData;
private _anchorPos = if (!isNil "_worldAnchor") then {
	[_worldAnchor select 0,_worldAnchor select 1,0];
} else {
	[0,0,0]
};

private _base = call {
	if ( _pos isEqualType "" ) exitWith { getMarkerPos _pos };
	if ( _pos isEqualType objNull ) exitWith { getPosATL _pos };
	if ( _pos isEqualType grpNull ) exitWith { getPosATL (leader _pos) };
	if ( _pos isEqualType [] ) exitWith {
		if (count _pos isEqualTo 3) exitWith {
			_pos
		};
		if (count _pos isEqualTo 2) exitWith {
			[_pos select 0, _pos select 1,0]
		};
		_anchorPos;
	};
	if ( _pos isEqualType 0 ) exitWith {
		if !( _pos1 isEqualTo 0 ) exitWith { [_pos,_pos1,_pos2] };
		_anchorPos
	};
	_anchorPos
};

if ( _base isEqualTo [0,0,0] ) then {
	_base = _anchorPos
};

private _return = _base;
_return;