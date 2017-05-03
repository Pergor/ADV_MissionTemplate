/*
 * Author: Belbo
 *
 * Contains the tasks for the players that are either available from the start or are planned to be created throughout the mission.
 * Utilizes fhq_tt-functions (more information available in the readme-folder).
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
 * [2] remoteExec ["adv_fnc_tasks",2];
 *
 * Public: No
 */

params [
	["_task","",[0,""]]
];

_task = if (_task isEqualType "") then {0} else {_task};
 
private _taskContent = switch (_task) do {
	case 1: {
	};
	default {
		[
			{true},
				[
					"task_1", 							//TaskName.
					"Habt viel Spaß!", 					//Task Long Description - en detail.
					"Viel Spaß haben!",					//Task Short Description - Titel der Aufgabe.
					"", 								//Task WayPoint Description - Wird als Floating Text auf dem Waypoint der Task angezeigt.
					"", 								//Target - beispielsweise ein Objekt oder ein Marker (format: (getMarkerpos "respawn_west") or OBJECTNAME)
					"assigned"							//initial task state. "created", "assigned", "succeeded", "failed", "canceled".
				]
		];
	};
};

_taskContent call FHQ_TT_addTasks;

private _return = _taskContent select 0;

_return