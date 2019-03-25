if ( !(_this isEqualTo []) && {!(missionNamespace getVariable ["adv_par_civilians",0] isEqualTo 2 || missionNamespace getVariable ["adv_par_civilians",0] isEqualTo 3)} ) exitWith {};

call compile preprocessFileLineNumbers "scripts\Engima\Traffic\Common\Common.sqf";
call compile preprocessFileLineNumbers "scripts\Engima\Traffic\Common\Debug.sqf";
call compile preprocessFileLineNumbers "scripts\Engima\Traffic\HeadlessClient.sqf";

ENGIMA_TRAFFIC_instanceIndex = -1;
ENGIMA_TRAFFIC_areaMarkerNames = [];
ENGIMA_TRAFFIC_roadSegments = [];
ENGIMA_TRAFFIC_edgeTopLeftRoads = [];
ENGIMA_TRAFFIC_edgeTopRightRoads = [];
ENGIMA_TRAFFIC_edgeBottomRightRoads = [];
ENGIMA_TRAFFIC_edgeBottomLeftRoads = [];
ENGIMA_TRAFFIC_edgeRoadsUseful = [];

private _headlessClientPresent = (count entities "HeadlessClient_F" > 0);
private _runOnThisMachine = false;

if (_headlessClientPresent && isMultiplayer) then {
    if !(hasInterface || isServer) then {
        _runOnThisMachine = true;
    };
}
else {
    if (isServer) then {
        _runOnThisMachine = true;;   
    };
};

if (_runOnThisMachine) then {
	call compile preprocessFileLineNumbers "scripts\Engima\Traffic\Server\Functions.sqf";
	call compile preprocessFileLineNumbers "scripts\Engima\Traffic\Server\MoveVehicle.sqf";
	call compile preprocessFileLineNumbers "scripts\Engima\Traffic\Server\StartTraffic.sqf";
	call compile preprocessFileLineNumbers "scripts\Engima\Traffic\ConfigAndStart.sqf";
};
