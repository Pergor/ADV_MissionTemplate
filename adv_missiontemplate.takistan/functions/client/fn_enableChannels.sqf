 /*
 * Author: Belbo
 *
 * Enables/disables channels.
 *
 * Arguments:
 * 0: Channels to be handled - <ARRAY>
 * 1: true if channels shall be enabled, false if not - <BOOL>
 * Channel numbers are:
 * 0 = Global
 * 1 = Side
 * 2 = Command
 * 3 = Group
 * 4 = Vehicle
 * 5 = Direct
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0,1,2],false] call adv_fnc_enableChannels;
 *
 * Public: No
 */

params [
	["_channels", [0], [[]]]
	,["_active", true, [true]]
];

{
	_x enableChannel [_active,false];
	nil;
} count _channels;

nil;