/*
 * Author: Belbo
 *
 * Allows selection of a target position for adv_fnc_paraJump.
 *
 * Arguments:
 * 0: target - <OBJECT>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * flag_1 addAction [("<t color='#00FF00' size='2'>" + ("Parajump") + "</t>"), {[_this select 1] call ADV_fnc_paraJumpSelection},nil,3,false,true,"","player == leader (group player)",5];
 *
 * Public: No
 */

params [
	["_unit",player,[objNull]]
];

if (_unit isEqualTo leader group _unit) then {
	openmap true;
	//[_unit] onMapSingleClick "openmap false; { [_x,[(_pos select 0)+20+(random 20),(_pos select 1)+20+(random 20),(_pos select 2)+10+(random 10)]] remoteExec ['ADV_fnc_paraJump',0]; nil;} count (units (group (_this select 0))); onmapsingleclick '';";
	[_unit] onMapSingleClick "openmap false; { [_x, ([[_pos, 40, 40, 0, false],false] call CBA_fnc_randPosArea) ] remoteExec ['ADV_fnc_paraJump',0]; nil;} count (units (group (_this select 0))); onmapsingleclick '';";
/*
} else {
	[_unit] spawn {
		_unit = _this select 0;
		_leader = (leader group _unit);
		sleep 4;
		[_unit,[ (getPos _leader select 0) + (random 5) + 5, (getPos _leader select 1) + (random 5) + 5, 1500 ]] spawn ADV_scriptfnc_paraJump;
	};
*/
};

true;