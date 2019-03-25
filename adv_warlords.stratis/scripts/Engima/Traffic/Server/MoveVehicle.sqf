ENGIMA_TRAFFIC_MoveVehicle = {
	params ["_currentInstanceIndex", "_vehicle", "_areaMarkerName", ["_firstDestinationPos", []], ["_debug", false]];

    private ["_speed", "_roadSegments", "_destinationSegment"];
    private ["_destinationPos"];
    private ["_waypoint", "_fuel"];
    
    // Set fuel to something in between 0.3 and 0.9.
    _fuel = 0.3 + random (0.9 - 0.3);
    _vehicle setFuel _fuel;
    
    if (count _firstDestinationPos > 0) then {
        _destinationPos = +_firstDestinationPos;
    }
    else {
		_roadSegments = ENGIMA_TRAFFIC_roadSegments select _currentInstanceIndex;
		
        _destinationSegment = selectRandom _roadSegments;
        _destinationPos = getPos _destinationSegment;
        
        if (_areaMarkerName == "") then {
	        _destinationPos = [getPos _vehicle, _destinationPos] call ENGIMA_TRAFFIC_GetPosThisIsland;
	        private _segments = _destinationPos nearRoads 250;
	        private _tries = 0;

	        if (count _segments > 0) then {
	        	while { !(isOnRoad _destinationPos) && _tries < 10 } do {
		        	_destinationSegment = selectRandom _segments;
		        	_destinationPos = getPos _destinationSegment;
		        	_tries = _tries + 1;
	        	};
	        };
        };

		/*
        if (isNil "ENGIMA_TRAFFIC_MarkerNo") then { ENGIMA_TRAFFIC_MarkerNo = 1 };
        private _marker = createMarker ["ENGIMA_TRAFFIC_Marker_" + str ENGIMA_TRAFFIC_MarkerNo, _destinationPos];
        _marker setMarkerShape "ICON";
        _marker setMarkerType "hd_dot";
        _marker setMarkerColor "ColorRed";
        ENGIMA_TRAFFIC_MarkerNo = ENGIMA_TRAFFIC_MarkerNo + 1;
        */
    };
    
    //_speed = "NORMAL";
    _speed = "LIMITED";
    if (_vehicle distance _destinationPos < 500) then {
        _speed = "LIMITED";
    };
    
    private _group = group _vehicle;
    [_group] call ENGIMA_TRAFFIC_DeleteAllWaypointsFromGroup;
    
    _waypoint = _group addWaypoint [_destinationPos, 0];
    _waypoint setWaypointBehaviour "SAFE";
    _waypoint setWaypointSpeed _speed;
    _waypoint setWaypointCompletionRadius 10;
    _waypoint setWaypointStatements ["true", "_nil = [" + str _currentInstanceIndex + ", " + vehicleVarName _vehicle + ", """ + _areaMarkerName + """, [], " + str _debug + "] spawn ENGIMA_TRAFFIC_MoveVehicle;"];
    _group setBehaviour "SAFE";
};
