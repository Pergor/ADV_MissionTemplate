/*
 * Author: Belbo
 *
 * Contains the "storyboard" of the mission. Beware, the storyboard function is not scheduled!
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * is being called via postInit-command!
 *
 * Public: No
 */

//Don't change anything from here...
if ( (!isServer && hasInterface) || !isNil "adv_var_HCpresent" ) exitWith {};

private _hc = (count entities "HeadlessClient_F" > 0);
if (_hc && isServer) exitWith {
	{ adv_handle_werthles = [true, 30, false, false, 30, 5, false, []] spawn whk_fnc_headless } remoteExec ["call",0,true];
};

private _isHC = !(hasInterface || isServer);
missionNamespace setVariable ["adv_var_HCpresent",_isHC,true];

ADV_taskVar = missionNamespace getVariable ["ADV_taskVar",0];
ADV_spawnVar = missionNamespace getVariable ["ADV_spawnVar",0];

//failsafe for finishing the mission:
[{missionNamespace getVariable ["ADV_taskVar",0] isEqualTo 99}, { [] spawn { ["task_1", "SUCCEEDED", true] spawn BIS_fnc_taskSetState; sleep 20; ["End2",true,8] remoteExec ["BIS_fnc_endMission",0]; }; }] call CBA_fnc_waitUntilAndExecute;

//... to here. The rest is up to you!

//Use CBA_fnc_waitUntilAndExecute for the following mission parts:
private _taskVar_1_code = {
	_this spawn {
	};
};
[ {missionNamespace getVariable ["ADV_taskVar",0] isEqualTo 1}, _taskVar_1_code, []] call CBA_fnc_waitUntilAndExecute;


/*
//for adding new tasks, create a new case in ADV_tasks.sqf, a new task within this case and call like this:
[2] call adv_fnc_tasks;
//set task state:
["task_1", "SUCCEEDED", true] spawn BIS_fnc_taskSetState;

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