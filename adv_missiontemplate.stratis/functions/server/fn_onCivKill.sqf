if (!isServer) exitWith {};
if (isNil "FHQ_TT_addTasks") exitWith {};

[
	{true},
		[
			"task_civ",
			"Im Einsatzgebiet befinden sich Zivilisten. Vermeiden Sie zivile Verluste um jeden Preis.",
			"Vermeiden Sie zivile Verluste.",
			"",
			"",
			"created"
		]
] call FHQ_TT_addTasks;

civKill = 0;

[] spawn {
	waitUntil {time > 1};
	waitUntil {sleep 2; civKill == 1};
	["task_civ", "failed"] call FHQ_TT_setTaskState;
};

while {true} do {
	{
		_hasEventhandler = _x getVariable ["ADV_EH_civKill",false];
		if (!ADV_EH_civKill) then {
			if ((side _x) == civilian) then {
				ADV_EH_civKill = _x addEventhandler ["killed",{ if ( isPlayer (_this select 1) ) then { civKill = 1; publicVariable "civKill"; };}];
			};
		};
	} forEach allUnits;
	sleep 10;
};

true;