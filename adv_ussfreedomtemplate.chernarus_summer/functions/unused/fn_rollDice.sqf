if (!hasInterface) exitWith {};

ADV_scriptfnc_rollDice = {
	params [
		["_player", player, [objNull]],
		["_dice", 6, [0]]
	];
	_name = name _player;
	_value = floor (random _dice)+1;
	//[1,[(format ["%1 rolled a %2 with a %3 sided dice.",_name,_value,_dice]),"PLAIN",2]] remoteExec ["cutText",0];
	(format ["%1 rolled a %2 with a %3 sided dice.",_name,_value,_dice])remoteExec ["hint",0];
	(format ["%1 rolled a %2 with a %3 sided dice.",_name,_value,_dice]) remoteExec ["systemChat",0];
	[player,["Dice Log",["Dice Log",(format ["%1 rolled a %2 with a %3 sided dice.",_name,_value,_dice])]]] remoteExec ["createDiaryRecord",0];
	true;
};

{
	_target = _x;
	_target addAction [
		("<t color=""#00FF00"">" + ("Roll 20-sided dice") + "</t>"),
		{
			[(_this select 1),20] call ADV_scriptfnc_rollDice;
		},nil,3,false,true,"","player distance cursortarget <5"
	];
	_target addAction [
		("<t color=""#00FF00"">" + ("Roll 10-sided dice") + "</t>"),
		{
			[(_this select 1),10] call ADV_scriptfnc_rollDice;
		},nil,3,false,true,"","player distance cursortarget <5"
	];
	_target addAction [
		("<t color=""#00FF00"">" + ("Roll 8-sided dice") + "</t>"),
		{
			[(_this select 1),8] call ADV_scriptfnc_rollDice;
		},nil,3,false,true,"","player distance cursortarget <5"
	];
	_target addAction [
		("<t color=""#00FF00"">" + ("Roll 6-sided dice") + "</t>"),
		{
			[(_this select 1),6] call ADV_scriptfnc_rollDice;
		},nil,3,false,true,"","player distance cursortarget <5"
	];
	_target addAction [
		("<t color=""#00FF00"">" + ("Roll 4-sided dice") + "</t>"),
		{
			[(_this select 1),4] call ADV_scriptfnc_rollDice;
		},nil,3,false,true,"","player distance cursortarget <5"
	];
} forEach _this;

true;