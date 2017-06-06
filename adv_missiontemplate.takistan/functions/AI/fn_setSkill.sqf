/*
 * Author: Belbo
 *
 * Sets skill for given unit or group.
 *
 * Arguments:
 * 0: unit or group to set skills for - <OBJECT> or <GROUP>
 *
 * Return Value:
 * Skill set? - <BOOL>
 *
 * Example:
 * [unit_1] call adv_fnc_setSkill;
 *
 * Public: Yes
 */

params [
	[ "_target",objNull,[objNull,grpNull,[]] ]
];

private _isGroup = if ( _target isEqualType grpNull ) then { true } else { false };
private _receiver = if ( _isGroup ) then { units _target } else { _this };
if ( side _target isEqualTo civilian ) exitWith { false };

{
	private _unit = _x;
	_unit setSkill 0.7;
	_unit setSkill ["aimingAccuracy",0.58];
	_unit setSkill ["aimingShake",0.5];
	_unit setSkill ["aimingSpeed",0.7];
	_unit setSkill ["endurance",0.9];
	_unit setSkill ["spotDistance",0.4];
	_unit setSkill ["spotTime",0.7];
	_unit setSkill ["courage",0.9];
	_unit setSkill ["reloadSpeed",0.8];
	_unit setSkill ["commanding",0.9];
	_unit setSkill ["general",0.7];
	nil;
} count _receiver;

true;