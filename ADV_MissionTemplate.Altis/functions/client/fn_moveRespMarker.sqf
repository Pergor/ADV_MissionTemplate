/*
ADV_fnc_moveRespMarker by Belbo

Creates respawn markers that follow the current group leader every x seconds in a y radius.

Possible call - has to be executed on each client locally:
[TIME,RADIUS,0] spawn ADV_fnc_moveRespMarker;

_this select 0 = TIME;
_this select 1 = Radius;
_this select 2 = remove start marker ? 1/0;
*/

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
ADV_var_moveRespMarker = if (!isNil "ADV_par_moveMarker") then { ADV_par_moveMarker } else { 1 };

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

if (true) exitWith {};