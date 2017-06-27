/*
 * Author: Belbo
 *
 * Contains the tasks for the players that are either available from the start or are planned to be created throughout the mission.
 * Uses https://community.bistudio.com/wiki?title=Arma_3_Tasks_Overhaul 
 * Create new tasks by creating new cases for the switch and then copy over the task_1-stuff. Edit to your likings.
 * You can make the new task available by calling the function with the according switch case on the server. Look at example.
 * For inserting a marker: <marker name='MARKER'>TEXT</marker>
 *
 * Arguments:
 * 0: Number of pre-written task you want to have created on client.
 *
 * Return Value:
 * Name of task.
 *
 * Example:
 * [2] call adv_fnc_tasks;
 *
 * Public: Yes
 */

params [
	["_task","",[0,""]]
	,"_owner","_taskID","_description","_title","_marker","_destination","_state","_priority","_showNotification","_taskType","_alwaysVisible"
];
_task = if (_task isEqualType "") then {0} else {_task};
 
switch (_task) do {
	case 1: {
	};
	default {
		_owner = true;						//to whom shall the task belong (can be bool, side, object, group or array of objects)
		_taskID = "task_1";					//unique ID of the task (can be string or array in format ["taskID","parentTaskID"])
		_title = "Viel Spaß haben!";		//title for the task that's being displayed in the menu.
		_description = "Habt viel Spaß!";	//long description of the task
		_marker = "";						//task marker (no idea)
		_destination = objNull;				//task destination - will be shown on map (can be object, array or string)
		_state = true;						//current task state (can be bool (for current), number or "CREATED", "ASSIGNED", "SUCCEEDED", "FAILED", "CANCELED")
		_priority = 0;						//task priority (when automatically selecting a new current task, higher priority is selected first)
		_showNotification = true;			//show notification (default: true)
		_taskType = "default";				//task type as defined in the CfgTaskTypes (https://community.bistudio.com/wiki/Arma_3_Tasks_Overhaul#Appendix)
		_alwaysVisible = true;				//should the task being shared (default: false), if set to true, the assigned players are being counted
	};
};

private _texts = [_description,_title,_marker];
private _taskContent = [_owner,_taskID,_texts,_destination,_state,_priority,_showNotification,_taskType,_alwaysVisible];

_taskContent call BIS_fnc_taskCreate;

_taskID;

//obsolete content:
/*
	_taskContent = [_owner,[_taskID,_description,_title,_marker,_destination,_state]];
	_taskContent call FHQ_TT_addTasks;
*/