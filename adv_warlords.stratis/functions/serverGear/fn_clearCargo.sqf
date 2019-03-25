/*
 * Author: Belbo
 *
 * Removes all items from inventory of vehicles or ammoboxes.
 *
 * Arguments:
 * Array of vehicles - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [crate_1, crate_2, ..., crate_n] call adv_fnc_clearCargo;
 *
 * Public: Yes
 */

private _targets = _this;
if (_targets isEqualType objNull) then {_targets = [_targets]};

if (count _targets isEqualTo 0) exitWith {};

//removes all content from the target:
{
	if !(_x isEqualTo objNull) then {
		private _target = _x;
		clearWeaponCargoGlobal _target;clearMagazineCargoGlobal _target;clearBackpackCargoGlobal _target;clearItemCargoGlobal _target;
	};
} count _targets;

true;