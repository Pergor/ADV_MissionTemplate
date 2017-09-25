// Calculates the blacklist coverage share for one player.
// _playerPos (Array): The player's position.
// Returns (Scalar): Coverage chare for surrounding blacklist markers. 0 if no area is
//                   covered by blacklist marker, and 1 if all area is covered.
ENGIMA_TRAFFIC_CalculatePlayerMarkerCoverage = {
	params ["_playerPos", "_maxSpawnDistance", "_marker"];
	
	//private _minSpawnDistance = _mConfiguration.MinSpawnDistance;
	//private _playerRadius = _mConfiguration.MaxSpawnDistance;
	//private _blacklistMarkers = _mConfiguration.BlacklistMarkers;
	
	private _sumCoveredShare = 0;
	
	private _distanceToMarker = _playerPos distance2D (getMarkerPos _marker);
	private _avgMarkerRadius = (((getMarkerSize _marker) select 0) + ((getMarkerSize _marker) select 1)) / 2;
	private _coveredShare = 0;
	
	// If the marker is covered at all
	if (_distanceToMarker < _maxSpawnDistance + _avgMarkerRadius) then
	{
		// If the marker is completely surrounded by the player radius
		if (_maxSpawnDistance > _distanceToMarker + _avgMarkerRadius) then {
			_coveredShare = _avgMarkerRadius / _maxSpawnDistance;
		}
		else {
			_coveredShare = (_maxSpawnDistance + _avgMarkerRadius - _distanceToMarker) / (2 * _maxSpawnDistance);
			
			// If player radius is completely surrounded by the marker, the covered share must not be greater than 1.
			if (_coveredShare > 1) then {
				_coveredShare = 1;
			};
		};
	};

	_sumCoveredShare = _sumCoveredShare + _coveredShare;
	
	/*
	private _circleParts = 12;
	private _waterCount = 0;
	private _sumWaterCoveredShare = 0;
	
	for "_i" from 1 to _circleParts do {
		private _x = (_playerPos select 0) + _minSpawnDistance * sin (_i * 360 / _circleParts);
		private _y = (_playerPos select 1) + _minSpawnDistance * cos (_i * 360 / _circleParts);
		
		if (surfaceIsWater [_x, _y] && !([[_x, _y], _mConfiguration.BlacklistMarkers] call MarkerHelper.PositionInsideAnyMarker)) then {
			_waterCount = _waterCount + 1;
		};
	};

	_sumWaterCoveredShare = _waterCount / _circleParts;
	*/
	
	//_sumCoveredShareBlacklist + _sumWaterCoveredShare
	_sumCoveredShare
};

// Calculates how much area that is covered when blacklist markers are taken account of,
// and takes all players and all blacklist markers in account.
// _playerPositions (Array): All players' positions.
// Returns (Scalar): The average share of area covered by blacklist markers. 0 = Nothing 
// covered, 1 = all covered.
/*
ENGIMA_TRAFFIC_CalculateBlacklistCoverage = {
	params ["_playerPositions" as Array];
	
	private _sumShare = 0;
	
	{
		_sumShare = _sumShare + ([_x] call _self.CalculatePlayerBlacklistCoverage);
	} foreach _playerPositions as Array;
	
	_sumShare / count _playerPositions
};
*/

// Tests and calculates the width of a road segment.
// _roadSegment (Object): The road segment to test for its width.
// Returns (Scalar): The width of the road in meters.
ENGIMA_TRAFFIC_CalculateRoadWidth = {
	params ["_roadSegment"];

	private _nextNode = objNull;
	private _connectedRoads = roadsConnectedTo _roadSegment;
	private _dir = 0;
	
	if ( count _connectedRoads > 0 ) then {
		_nextNode = _connectedRoads select 0;
		_dir = [ getPos _roadSegment, getPos _nextNode ] call BIS_fnc_dirTo;
	};
	
	_dir = _dir + 90;
	
	private _step = 0;
	//private _arrow = "Sign_Arrow_F" createVehicle ([ _roadSegment, _step, _dir ] call BIS_fnc_relPos);
	//_arrow setPos ([ _roadSegment, _step, _dir ] call BIS_fnc_relPos);
	
	while { isOnRoad ([ _roadSegment, _step, _dir ] call BIS_fnc_relPos) } do {
		_step = _step + 0.1;
	};
	
	//_arrow = "Sign_Arrow_F" createVehicle ([ _roadSegment, _step, _dir ] call BIS_fnc_relPos);
	//_arrow setPos ([ _roadSegment, _step, _dir ] call BIS_fnc_relPos);
	
	_step * 2
};

// Deletes all waypoints from a group.
// _group (Group): The group to delete all waypoints from.
ENGIMA_TRAFFIC_DeleteAllWaypointsFromGroup = {
	params ["_group"];
	private ["_waypoints", "_i"];
	
	_waypoints = waypoints _group;
	
	for [{_i = (count _waypoints) - 1}, {_i >= 0}, {_i = _i - 1}] do {
		deleteWaypoint [_group, _i];
	} 
};

ENGIMA_TRAFFIC_GetPosThisIsland = {
	params ["_startPos", "_targetPos"];
	
	scopeName "main";
	
	private _stepDistance = 100;
	private _direction = _startPos getDir _targetPos;
	private _totDistance = _startPos distance2D _targetPos;
	private _lastLandPos = _startPos;
	private _i = 0;
	private _pos = _startPos;
	private _waterPositionsInARow = 0;
	
	while { _stepDistance * _i < _totDistance } do {
		_pos = _startPos getPos [_stepDistance * (_i + 1), _direction];
		
		if (surfaceIsWater _pos) then {
			_waterPositionsInARow = _waterPositionsInARow + 1;
		}
		else {
			_lastLandPos = _pos;
		};
		
		if (_waterPositionsInARow >= 3) then {
			_lastLandPos breakOut "main";
		};
		
		_i = _i + 1;
	};
	
	_lastLandPos
};

ENGIMA_TRAFFIC_FindEdgeRoads = {
	private ["_minTopLeftDistances", "_minTopRightDistances", "_minBottomRightDistances", "_minBottomLeftDistances"];
	private ["_worldTrigger", "_worldSize", "_mapTopLeftPos", "_mapTopRightPos", "_mapBottomRightPos", "_mapBottomLeftPos", "_i", "_nextStartPos", "_segmentsCount"];
	
	if (!isNil "ENGIMA_TRAFFIC_edgeRoadsInitializing") exitWith {};
	ENGIMA_TRAFFIC_edgeRoadsInitializing = true;
	
	sleep 3; // Wait for all traffic instances to be registered
	
	_worldTrigger = call BIS_fnc_worldArea;
	_worldSize = triggerArea _worldTrigger;
	_mapTopLeftPos = [0, 2 * (_worldSize select 1)];
	_mapTopRightPos = [2 * (_worldSize select 0), 2 * (_worldSize select 1)];
	_mapBottomRightPos = [2 * (_worldSize select 0), 0];
	_mapBottomLeftPos = [0, 0];
	
	_minTopLeftDistances = [];
	_minTopRightDistances = [];
	_minBottomRightDistances = [];
	_minBottomLeftDistances = [];
	
	for "_i" from 0 to ENGIMA_TRAFFIC_instanceIndex do {
		_minTopLeftDistances pushBack 1000000;
		_minTopRightDistances pushBack 1000000;
		_minBottomRightDistances pushBack 1000000;
		_minBottomLeftDistances pushBack 1000000;
	};
	
	ENGIMA_TRAFFIC_allRoadSegments = [0,0,0] nearRoads 1000000;
	sleep 0.01;
	_segmentsCount = count ENGIMA_TRAFFIC_allRoadSegments;
	
	// Find all edge road segments
	
	_i = 0;
	_nextStartPos = 1;
	while { _i < _segmentsCount } do {
		private ["_instanceIndex", "_road", "_roadPos", "_markerName", "_insideMarker", "_roads"];
		
		_road = ENGIMA_TRAFFIC_allRoadSegments select _i;
		_roadPos = getPos _road;
		
		_instanceIndex = 0;
	
		//if (isOnRoad (_roadPos)) then { // A path is not a road (like on Tanoa).
			while { _instanceIndex <= ENGIMA_TRAFFIC_instanceIndex } do {
				_markerName = ENGIMA_TRAFFIC_areaMarkerNames select _instanceIndex; // Get the marker name for the current instance
				
				_insideMarker = true;
				if (_markerName != "") then {
					_insideMarker = _roadPos inArea _markerName;
				};
				
				if (_insideMarker) then {
					_roads = ENGIMA_TRAFFIC_roadSegments select _instanceIndex;
					
					if (isOnRoad getPos _road) then { // A path is not a road (like on Tanoa).
						_roads pushBack _road;
					
						// Top left
						if (_roadPos distance _mapTopLeftPos < (_minTopLeftDistances select _instanceIndex)) then {
							_minTopLeftDistances set [_instanceIndex, _roadPos distance _mapTopLeftPos];
							ENGIMA_TRAFFIC_edgeTopLeftRoads set [_instanceIndex, _road];
						};
						
						// Top right
						if (_roadPos distance _mapTopRightPos < (_minTopRightDistances select _instanceIndex)) then {
							_minTopRightDistances set [_instanceIndex, _roadPos distance _mapTopRightPos];
							ENGIMA_TRAFFIC_edgeTopRightRoads set [_instanceIndex, _road];
						};
						
						// Bottom right
						if (_roadPos distance _mapBottomRightPos < (_minBottomRightDistances select _instanceIndex)) then {
							_minBottomRightDistances set [_instanceIndex, _roadPos distance _mapBottomRightPos];
							ENGIMA_TRAFFIC_edgeBottomRightRoads set [_instanceIndex, _road];
						};
						
						// Bottom left
						if (_roadPos distance _mapBottomLeftPos < (_minBottomLeftDistances select _instanceIndex)) then {
							_minBottomLeftDistances set [_instanceIndex, _roadPos distance _mapBottomLeftPos];
							ENGIMA_TRAFFIC_edgeBottomLeftRoads set [_instanceIndex, _road];
						};
						
						if (!(ENGIMA_TRAFFIC_edgeRoadsUseful select _instanceIndex)) then {
							ENGIMA_TRAFFIC_edgeRoadsUseful set [_instanceIndex, true];
						};
						sleep 0.01;
					};
				};
				
				_instanceIndex = _instanceIndex + 1;
			};
			
			sleep 0.01;
			_i = _i + 50;
			if (_i >= _segmentsCount) then {
				_i = _nextStartPos;
				_nextStartPos = _nextStartPos + 1;
				if (_nextStartPos == 50) then {
					_i = _segmentsCount;
				};
			};
		//};
	};
	
	ENGIMA_TRAFFIC_edgeRoadsInitialized = true;
};

ENGIMA_TRAFFIC_FindSpawnSegment = {
    params ["_currentInstanceIndex", "_allPlayerPositions", "_minSpawnDistance", "_maxSpawnDistance", "_activeVehicles"];
    private ["_insideMarker", "_areaMarkerName", "_refPlayerPos", "_roadSegments", "_roadSegment", "_isOk", "_tries", "_result", "_spawnDistanceDiff", "_refPosX", "_refPosY", "_dir", "_tooFarAwayFromAll", "_tooClose", "_tooCloseToAnotherVehicle"];
	
    _spawnDistanceDiff = _maxSpawnDistance - _minSpawnDistance;
    _roadSegment = "NULL";
    _refPlayerPos = (selectRandom _allPlayerPositions) select 1;
    _areaMarkerName = ENGIMA_TRAFFIC_areaMarkerNames select _currentInstanceIndex;
    
    _isOk = false;
    _tries = 0;
    while {!_isOk && _tries < 10} do {
        _isOk = true;
        
        _dir = random 360;

        _refPosX = (_refPlayerPos select 0) + (_minSpawnDistance + _spawnDistanceDiff / 2) * sin _dir;
        _refPosY = (_refPlayerPos select 1) + (_minSpawnDistance + _spawnDistanceDiff / 2) * cos _dir;
        
        _roadSegments = [_refPosX, _refPosY] nearRoads (_spawnDistanceDiff / 2);
        
        if (count _roadSegments > 0) then {
            _roadSegment = selectRandom _roadSegments;
            private _roadPos = getPos _roadSegment;
			
			if (isOnRoad _roadPos) then
			{
	            // Check if road segment is ok
	            _tooFarAwayFromAll = true;
	            _tooClose = false;
	            _insideMarker = true;
	            _tooCloseToAnotherVehicle = false;
	            
	            if (_areaMarkerName != "" && !((_roadPos) inArea _areaMarkerName)) then {
	            	_insideMarker = false;
	            };
	            
	            if (_insideMarker) then {
		            {
		            	private _closePos = _x select 0;
		            	private _farPos = _x select 1;
		                private _tooFarAway = false;
		                
		                if (_closePos distance (_roadPos) < _minSpawnDistance) then {
		                    _tooClose = true;
		                }
		                else {
			                if (_farPos distance (_roadPos) > _maxSpawnDistance) then {
			                    _tooFarAway = true;
			                };
		                };
		                
		                if (!_tooFarAway) then {
		                    _tooFarAwayFromAll = false;
		                };
		                
		                sleep 0.01;
		            } foreach _allPlayerPositions;
				
	                {
	                    private ["_vehicle"];
	                    _vehicle = _x select 0;
	                    
	                    if ((_roadPos) distance _vehicle < 100) then {
	                        _tooCloseToAnotherVehicle = true;
	                    };
	                    
	                    sleep 0.01;
	                } foreach _activeVehicles;
				};
		                
	            _isOk = true;
	            
	            if (_tooClose || _tooFarAwayFromAll || _tooCloseToAnotherVehicle || !_insideMarker) then {
	                _isOk = false;
	                _tries = _tries + 1;
	            };
			}
			else {
	            _isOk = false;
	            _tries = _tries + 1;
			};
        }
        else {
            _isOk = false;
            _tries = _tries + 1;
        };
        
		sleep 0.1;
    };

    if (!_isOk) then {
        _result = "NULL";
    }
    else {
        _result = _roadSegment;
    };

    _result
};

ENGIMA_TRAFFIC_RoadsConnected = {
	params ["_thisSegment", "_targetSegment", ["_visitedSegments", []]];
	
	scopeName "main";
	
	if (isNil "ENGIMA_TRAFFIC_MarkerNo") then {
		ENGIMA_TRAFFIC_MarkerNo = 1;
	};
	
	/*
	private _marker = createMarker ["ENGIMA_TRAFFIC_TraceMarker" + str ENGIMA_TRAFFIC_MarkerNo, getPos _thisSegment];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "hd_dot";
	ENGIMA_TRAFFIC_MarkerNo = ENGIMA_TRAFFIC_MarkerNo + 1;
	*/
	if (_thisSegment == _targetSegment) then {
		//_marker setMarkerColor "ColorBlue";
		true breakOut "main";
	};
	
	_visitedSegments pushBack _thisSegment;
	
	private _connectedSegments = roadsConnectedTo _thisSegment;
	
	{
		if (!(_x in _visitedSegments)) then {
			if ([_x, _targetSegment, _visitedSegments] call ENGIMA_TRAFFIC_RoadsConnected) then {
				true breakOut "main";
			};
		};
	} foreach _connectedSegments;
	
	false
};
