/*
 * Author: Belbo
 *
 * Contains the "dramaturgy" of the mission.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Script handle - <HANDLE>
 *
 * Example:
 * _handle = execVM "mission\adv_dramaturgy.sqf";
 *
 * Public: No
 */

if (!isServer && hasInterface) exitWith {};
missionNamespace getVariable ["ADV_taskVar",0];
missionNamespace getVariable ["ADV_spawnVar",0];
if !(isServer || hasInterface) then {
	missionNamespace setVariable ["ADV_HCpresent",1,true];
};
if (isServer) then {
	missionNamespace setVariable ["ADV_HCpresent",0,true];
};

//failsafe for finishing the mission:
[{missionNamespace getVariable ["ADV_taskVar",0] isEqualTo 99}, { [] spawn { ["task_1", "succeeded"] remoteExec ["FHQ_TT_setTaskState",2]; sleep 20; ["End2",true,8] remoteExec ["BIS_fnc_endMission",0]; }] call CBA_fnc_waitUntilAndExecute;

//Use CBA_fnc_waitUntilAndExecute for the following mission parts:

private _taskVar_1_code = {
	_this spawn {
	};
};
[ {missionNamespace getVariable ["ADV_taskVar",0] isEqualTo 1}, _taskVar_1_code, []] call CBA_fnc_waitUntilAndExecute;


/*
//for adding new tasks, create a new case in ADV_tasks.sqf, a new task within this case and call like this:
[2] remoteExec ["adv_fnc_tasks",2];

//possible spawn calls:
[spawnLogic,["O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_soldier_AR_F","O_medic_F"],east,0,200] call adv_fnc_aiTask;
[spawnLogic,["O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_soldier_AR_F","O_medic_F"],east,2,100] call adv_fnc_aiTask;
[spawnLogic,["O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_soldier_AR_F","O_medic_F"],east,4,200,["attackMarker",50]] call adv_fnc_aiTask;

	//or (deprecated):
	[[spawnLogic_1],["O_Soldier_TL_F","O_Soldier_GL_F","O_Soldier_F","O_soldier_AR_F","O_medic_F"],east,50,["LIMITED","CARELESS","STAG COLUMN"]] call ADV_fnc_spawnPatrol;
	[[spawnLogic_1,spawnLogic_2],["I_Soldier_TL_F","I_Soldier_AR_F","I_Soldier_F","I_soldier_GL_F","I_medic_F"],independent,50,["LIMITED","CARELESS","STAG COLUMN"],"area_1"] call ADV_fnc_spawnPatrol;
	[[spawnLogic_1],["I_Soldier_TL_F","I_Soldier_AR_F","I_Soldier_F","I_soldier_GL_F","I_medic_F"],independent,50,attackLogic_1] call ADV_fnc_spawnAttack;
	//for calling custom loadouts on last group spawned (just add one spawnLogic/Marker):
	_grp = [[spawnLogic_1],["B_Sniper_F","B_Spotter_F"],west,200,["LIMITED","STAG COLUMN","NOFOLLOW"]] call ADV_fnc_spawnPatrol;
	[(units _grp) select 0] call ADV_fnc_sniper;
	[(units _grp) select 1] call ADV_fnc_spotter;
*/

if (true) exitWith {};