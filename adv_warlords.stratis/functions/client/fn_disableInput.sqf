/*
 * Author: Belbo
 *
 * Disables or enables userInput.
 *
 * Arguments:
 * 1: Should user input be disabled? - <BOOL>
 *
 * Return Value:
 * nil
 *
 * Example:
 * [true] call adv_fnc_disableInput;
 *
 * Public: No
 */

params ["_state"];

if !(_state) exitWith {
	disableUserInput false;
	disableUserInput true;
	disableUserInput false;
	disableUserInput false;
};

disableUserInput true;