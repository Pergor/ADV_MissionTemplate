/*
 * Author: Belbo
 *
 * Shows a timed hint for a set duration.
 *
 * Arguments:
 * 1: Text of the hint to show - <STRING>
 * 2: Duration for the hint to be shown (optional) - <NUMBER>
 * 3: Should the hint be silent? (optional) - <BOOLEAN>
 *
 * Return Value:
 * nil
 *
 * Example:
 * ["this is visible for 6 seconds", 6] call adv_fnc_timedHint;
 *
 * Public: No
 */

_this spawn {
	params [
		["_hint", "", [""]]
		,["_duration",5, [0]]
		,["_isSilent",false,[true]]
	];
	if (_isSilent) then {
		hintSilent format ["%1",_hint];
	} else {
		hint format ["%1",_hint];
	};
	sleep _duration;
	hintSilent "";
};