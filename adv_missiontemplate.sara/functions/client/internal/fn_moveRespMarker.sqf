/*
 * Author: Belbo
 *
 * Creates respawn markers that follow the current group leader every x seconds in a y radius. Additionally it can delete respawn markers at start.
 *
 * Arguments:
 * 0: timer for marker movement (optional) - <NUMBER>
 * 1: radius around player to move the marker to (optional) - <NUMBER>
 * 2: Should respawn markers from start be deleted? 0/1 (optional) - <NUMBER>
 *
 * Return Value:
 * Script handle - <HANDLE>
 *
 * Example:
 * _handle = [120, 20, 0] spawn adv_fnc_moveRespMarker;
 *
 * Public: No
 */

_handle = _this spawn {
	params [
		["_moveTimer", 120, [0]],
		["_markerRadius", 10, [0]],
		["_deleteStartMarker", 0, [0]],
		"_RespMarker","_dist","_dir","_grpLeader","_respawnMarker","_RespMarker","_respPos1"
	];

	//removes the initial respawn_x-marker 60 secs after missionstart.
	[_deleteStartMarker] spawn {
		_deleteStartMarker = _this select 0;
		if (_deleteStartMarker == 1) then {
			waitUntil {time > 60};
			deleteMarker "respawn_west";
			deleteMarker "respawn_east";
			deleteMarker "respawn_guerrila";
		};
	};

	sleep 30;

	// creates, moves and deletes the respawn_X_99-marker for every player's group leader.
	_RespMarker = switch (side (group player)) do {
		case WEST: {"respawn_west_99";};
		case EAST: {"respawn_east_99";};
		case INDEPENDENT: {"respawn_guerrila_99";};
		case CIVILIAN: {"respawn_civilian_99";};
		default {"No_Respawn_99"};
	};
	// creates, moves and deletes a respawn-marker for every player
	ADV_var_moveRespMarker = missionNamespace getVariable ["ADV_par_moveMarker",0];

	while { ADV_var_moveRespMarker == 1 } do {
		if !(isNil _RespMarker) then {deleteMarkerLocal _RespMarker;};
		_dist = random _MarkerRadius;
		_dir = random 360;
		_grpLeader = leader (group (vehicle player));
		_respawnMarker = createMarkerLocal [_RespMarker, position player];
		_respPos1 = [getpos _grpLeader, _dist, _dir] call BIS_fnc_relPos;
		_RespMarker setMarkerPosLocal (_respPos1);
		_RespMarker setMarkerTextLocal "Respawn on group leader";
		sleep _moveTimer;
	};
};

_handle;