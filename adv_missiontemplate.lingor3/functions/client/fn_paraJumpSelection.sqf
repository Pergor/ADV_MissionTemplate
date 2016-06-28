/*
ADV_fnc_paraJump - by Belbo:

Allows player to jump with a parachute over a position that's defined by mapclick (or by position of group leader of the player)

Possible call - has to be executed where unit is local:
	[player] call ADV_fnc_paraJump;
Or, with an addaction:
	ADV_handle_paraJumpAction = OBJECT addAction [("<t color=""#33FFFF"">" + ("Parajump") + "</t>"), {[_this select 1] call ADV_fnc_paraJump},nil,3,false,true,"","player distance cursortarget <5"];
*/

params [
	["_unit",player,[objNull]]
];

if (_unit == leader group _unit) then {
	openmap true;
	[_unit] onMapSingleClick "openmap false; { [_x,[(_pos select 0)+20+(random 20),(_pos select 1)+20+(random 20),(_pos select 2)+10+(random 10)]] remoteExec ['ADV_fnc_paraJump',0]; nil;} count (units (group (_this select 0))); onmapsingleclick '';";
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

if (true) exitWith {};