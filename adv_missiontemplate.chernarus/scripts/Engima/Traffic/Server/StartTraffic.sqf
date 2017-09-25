/*
 * Name:	StartTraffic
 * Date:	2017-08-05
 * Version: 1.0
 * Author:  Engima
 *
 * Description:
 * Starts a traffic instance.
 *
 * Parameter(s):
 * A list with configuration options for the traffic instance.
 */

ENGIMA_TRAFFIC_StartTraffic = {
	private ["_allPlayerPositions", "_allPlayerPositionsTemp", "_activeVehicles", "_undamagedVehiclesCount", "_vehiclesGroup", "_spawnSegment", "_vehicle", "_group", "_result", "_vehicleClassName", "_vehiclesCrew", "_skill", "_minDistance", "_trafficLocation"];
	private ["_currentEntityNo", "_vehicleVarName", "_tempVehicles", "_deletedVehiclesCount", "_firstIteration", "_roadSegments", "_destinationSegment", "_destinationPos", "_direction"];
	private ["_roadSegmentDirection", "_testDirection", "_facingAway", "_posX", "_posY", "_pos", "_currentInstanceIndex"];
	private ["_debugMarkerName"];

	private _side = [_this, "SIDE", civilian] call ENGIMA_TRAFFIC_GetParamValue;
	private _possibleVehicles = [_this, "VEHICLES", ["C_Offroad_01_F", "C_Offroad_01_repair_F", "C_Quadbike_01_F", "C_Hatchback_01_F", "C_Hatchback_01_sport_F", "C_SUV_01_F", "C_Van_01_transport_F", "C_Van_01_box_F", "C_Van_01_fuel_F"]] call ENGIMA_TRAFFIC_GetParamValue;
	private _vehicleCount = [_this, "VEHICLES_COUNT", 10] call ENGIMA_TRAFFIC_GetParamValue;
	private _maxGroupsCount = [_this, "MAX_GROUPS_COUNT", 0] call ENGIMA_TRAFFIC_GetParamValue;
	private _minSpawnDistance = [_this, "MIN_SPAWN_DISTANCE", 800] call ENGIMA_TRAFFIC_GetParamValue;
	private _maxSpawnDistance = [_this, "MAX_SPAWN_DISTANCE", 1200] call ENGIMA_TRAFFIC_GetParamValue;
	private _minSkill = [_this, "MIN_SKILL", 0.3] call ENGIMA_TRAFFIC_GetParamValue;
	private _maxSkill = [_this, "MAX_SKILL", 0.7] call ENGIMA_TRAFFIC_GetParamValue;
	private _areaMarkerName = [_this, "AREA_MARKER", ""] call ENGIMA_TRAFFIC_GetParamValue;
	private _hideAreaMarker = [_this, "HIDE_AREA_MARKER", true] call ENGIMA_TRAFFIC_GetParamValue;
	private _fnc_onUnitCreating = [_this, "ON_UNIT_CREATING", { true }] call ENGIMA_TRAFFIC_GetParamValue;
	private _fnc_onUnitCreated = [_this, "ON_UNIT_CREATED", {}] call ENGIMA_TRAFFIC_GetParamValue;
	private _fnc_onUnitRemoving = [_this, "ON_UNIT_REMOVING", {}] call ENGIMA_TRAFFIC_GetParamValue;
	private _fnc_onSpawnVehicleObsolete = [_this, "ON_SPAWN_CALLBACK", {}] call ENGIMA_TRAFFIC_GetParamValue;
	private _fnc_onRemoveVehicleObsolete = [_this, "ON_REMOVE_CALLBACK", {}] call ENGIMA_TRAFFIC_GetParamValue;
	private _debug = [_this, "DEBUG", false] call ENGIMA_TRAFFIC_GetParamValue;
	
	if (_areaMarkerName != "" && _hideAreaMarker) then {
		_areaMarkerName setMarkerAlpha 0;
	};
	
	if (_maxGroupsCount <= 0) then {
		_maxGroupsCount = _vehicleCount;
	}
	else {
	   if (_maxGroupsCount < _vehicleCount) then {
	       _vehicleCount = _maxGroupsCount;
	   };
	};
	
	sleep random 1;
	
	ENGIMA_TRAFFIC_instanceIndex = ENGIMA_TRAFFIC_instanceIndex + 1;
	_currentInstanceIndex = ENGIMA_TRAFFIC_instanceIndex;
	
	ENGIMA_TRAFFIC_areaMarkerNames set [_currentInstanceIndex, _areaMarkerName];
	ENGIMA_TRAFFIC_edgeRoadsUseful set [_currentInstanceIndex, false];
	ENGIMA_TRAFFIC_roadSegments set [_currentInstanceIndex, []];
	
	_activeVehicles = [];
	
	private _closeCircleMarker = "";
	private _farCircleMarker = "";
	
	if (_debug) then {
		_closeCircleMarker = createMarkerLocal ["ENG_CloseMarker", getPos vehicle player];
		_closeCircleMarker setMarkerShapeLocal "ELLIPSE";
		_closeCircleMarker setMarkerSizeLocal [_minSpawnDistance, _minSpawnDistance];
		_closeCircleMarker setMarkerColorLocal "ColorRed";
		_closeCircleMarker setMarkerBrushLocal "Border";
		
		_farCircleMarker = createMarkerLocal ["ENG_FarMarker", getPos vehicle player];
		_farCircleMarker setMarkerShapeLocal "ELLIPSE";
		_farCircleMarker setMarkerSizeLocal [_maxSpawnDistance, _maxSpawnDistance];
		_farCircleMarker setMarkerColorLocal "ColorBlue";
		_farCircleMarker setMarkerBrushLocal "Border";
	};
	
	_firstIteration = true;
	
	[] spawn ENGIMA_TRAFFIC_FindEdgeRoads;
	waitUntil { sleep 1; (ENGIMA_TRAFFIC_edgeRoadsUseful select _currentInstanceIndex) };
	sleep 5;
	
	while {true} do {
	    scopeName "mainScope";
	    private ["_sleepSeconds", "_calculatedMaxVehicleCount", "_markerSize", "_avgMarkerRadius", "_coveredShare", "_restDistance", "_coveredAreaShare"];

		_allPlayerPositionsTemp = [];
		if (isMultiplayer) then {
			{
				if (isPlayer _x) then {
					private _pos = position vehicle _x;
					private _aheadPos = _pos getPos [(speed vehicle _x) * 3, getDir _x];
					_allPlayerPositionsTemp = _allPlayerPositionsTemp + [[_pos, _aheadPos]];
					
					if (_debug && { _x == player }) then {
						_closeCircleMarker setMarkerPosLocal _pos;
						_farCircleMarker setMarkerPosLocal _aheadPos;
					};
					
				};
			} foreach (playableUnits);
		}
		else {
			private _pos = position vehicle player;
			private _aheadPos = _pos getPos [(speed vehicle player) * 3, getDir player];
			
			_allPlayerPositionsTemp = _allPlayerPositionsTemp + [[_pos, _aheadPos]];
			
			if (_debug) then {
				_closeCircleMarker setMarkerPosLocal _pos;
				_farCircleMarker setMarkerPosLocal _aheadPos;
			};			
		};
	
		if (count _allPlayerPositionsTemp > 0) then {
			_allPlayerPositions = _allPlayerPositionsTemp;
		};
		
	    if (_areaMarkerName == "") then {
		    _calculatedMaxVehicleCount = _vehicleCount;
	    }
	    else {
	    	private _highestCalculatedShare = 0;
	    	
	    	{
	    		private _farPos = _x select 1;
		    	private _playerCalculatedShare = [_farPos, _maxSpawnDistance, _areaMarkerName] call ENGIMA_TRAFFIC_CalculatePlayerMarkerCoverage;
		    	
		    	if (_playerCalculatedShare > _highestCalculatedShare) then {
		    		_highestCalculatedShare = _playerCalculatedShare;
		    	};
	    	} foreach (_allPlayerPositions);
	    	
	    	_calculatedMaxVehicleCount = round (_vehicleCount * _highestCalculatedShare);
	    	
	    	// If the vehicle count gets rounded to 0, then let it always be one traffic unit.
	    	if (_calculatedMaxVehicleCount == 0 && _highestCalculatedShare > 0) then {
	    		_calculatedMaxVehicleCount = 1;
	    	};
	    	
	    	/*
	    	_markerSize = getMarkerSize _areaMarkerName;
	    	_avgMarkerRadius = ((_markerSize select 0) + (_markerSize select 1)) / 2;

			if (_avgMarkerRadius > _maxSpawnDistance) then {
			    _calculatedMaxVehicleCount = floor (_vehicleCount / 2);
		    	_coveredShare = 0;
		    	
			    {
					private _farPos = _x select 1;
				
			    	_restDistance = _maxSpawnDistance - ((_farPos distance getMarkerPos _areaMarkerName) - _avgMarkerRadius);
			    	_coveredAreaShare = _restDistance / (_maxSpawnDistance * 2);
				    if (_coveredAreaShare > _coveredShare) then {
					    _coveredShare = _coveredAreaShare;
				    };
				    
				    sleep 0.01;
			    } foreach (_allPlayerPositions);
			    
			    _calculatedMaxVehicleCount = floor (_vehicleCount * _coveredShare);
	    	}
	    	else {
	    		_calculatedMaxVehicleCount = _vehicleCount;
	    	};
	    	*/
	    };
	
		// If any vehicle is too far away, delete it
		// #region Delete Vehicles
	
        _undamagedVehiclesCount = 0;
	    _tempVehicles = [];
	    _deletedVehiclesCount = 0;
		{
	        private ["_closestUnitDistance", "_distance", "_crewUnits"];
	        private ["_scriptHandle"];
	        
	        _vehicle = _x select 0;
	        _group = _x select 1;
	        _crewUnits = _x select 2;
	        _debugMarkerName = _x select 3;
	        private _lastPos = _x select 4;
	        private _lastMoveTime = _x select 5;
	        
	        // Update the vehicle's position and find out if the vehicle has become stationary or not
	        
	        private _vehiclesPos = getPos _vehicle;
	        
	        if (!(_lastPos distance2D _vehiclesPos < 3)) then {
	        	_lastMoveTime = time;
	        	_x set [4, _vehiclesPos];
	        	_x set [5, time];
	        };
	        
	        private _isStationary = time - _lastMoveTime > 60;
	        
	        _closestUnitDistance = 1000000;
	        private _keepVehicle = false;
	        
	        {
	        	scopeName "current";
	        	
				private _closePos = _x select 0;
				private _farPos = _x select 1;
			
	            _distance = (_farPos distance _vehicle);
	            if (_distance < _closestUnitDistance) then {
	                _closestUnitDistance = _distance;
	                
	                if (_closestUnitDistance < _maxSpawnDistance || (_closePos distance2D _vehicle) < _closePos distance2D _farPos) then {
	                	if (_closestUnitDistance < _minSpawnDistance || { canMove _vehicle  && !_isStationary }) then {
		                	_keepVehicle = true;
		                	breakOut "current";
	                	};
	                };
	            };
	            
	            sleep 0.01;
	        } foreach _allPlayerPositions;
	        
	        if (_keepVehicle) then {
	        	// Keep vehicle
	        	
	            _tempVehicles pushBack _x;
	            
	            if (canMove _vehicle) then {
	            	_undamagedVehiclesCount = _undamagedVehiclesCount + 1;
	            };
	        }
	        else {
	        	// Remove vehicle
	        
	            // Run callback before removing
	            [_vehicle, _group, (count _activeVehicles) - _deletedVehiclesCount, _calculatedMaxVehicleCount] call _fnc_onUnitRemoving;
	            _vehicle call _fnc_OnRemoveVehicleObsolete;
	            
	            // Delete crew
	            {
	                deleteVehicle _x;
	            } foreach _crewUnits;
	            
	            deleteVehicle _vehicle;
	            deleteGroup _group;
	
	            [_debugMarkerName] call ENGIMA_TRAFFIC_DeleteDebugMarkerAllClients;
	            _deletedVehiclesCount = _deletedVehiclesCount + 1;
	        };
	        
            sleep 0.01;
		} foreach _activeVehicles;
	    
	    _activeVehicles = _tempVehicles;
	    
	    // #endregion
		
	    // If there are few vehicles, add a vehicle
	    // #region Add Vehicle
	    
	    if (count _activeVehicles < _calculatedMaxVehicleCount || { _undamagedVehiclesCount < _calculatedMaxVehicleCount && count _activeVehicles < _maxGroupsCount}) then {
			sleep 0.1;
			
	        // Get all spawn positions within range
	        if (_firstIteration) then {
	            _minDistance = 300;
	            
	            if (_minDistance > _maxSpawnDistance) then {
	                _minDistance = 0;
	            };
	        }
	        else {
	            _minDistance = _minSpawnDistance;
	        };
	        
	        _spawnSegment = [_currentInstanceIndex, _allPlayerPositions, _minDistance, _maxSpawnDistance, _activeVehicles] call ENGIMA_TRAFFIC_FindSpawnSegment;
	        
	        // If there were spawn positions
	        if (str _spawnSegment != """NULL""") then {
	        
	            // Get first destination
	            _trafficLocation = floor random 5;
	            private _allRoadSegments = ENGIMA_TRAFFIC_roadSegments select _currentInstanceIndex;
	            switch (_trafficLocation) do {
	                case 0: { _roadSegments = (getPos (ENGIMA_TRAFFIC_edgeBottomLeftRoads select _currentInstanceIndex)) nearRoads 100; };
	                case 1: { _roadSegments = (getPos (ENGIMA_TRAFFIC_edgeTopLeftRoads select _currentInstanceIndex)) nearRoads 100; };
	                case 2: { _roadSegments = (getPos (ENGIMA_TRAFFIC_edgeTopRightRoads select _currentInstanceIndex)) nearRoads 100; };
	                case 3: { _roadSegments = (getPos (ENGIMA_TRAFFIC_edgeBottomRightRoads select _currentInstanceIndex)) nearRoads 100; };
	                default { _roadSegments = _allRoadSegments };
	            };
	            
		        if (_areaMarkerName == "") then {
		            _destinationSegment = selectRandom _roadSegments;
		            _destinationPos = getPos _destinationSegment;
		            
		            _destinationPos = [getPos _spawnSegment, _destinationPos] call ENGIMA_TRAFFIC_GetPosThisIsland;
		            private _segments = _destinationPos nearRoads 250;
		            if (count _segments > 0) then {
		            	_destinationSegment = selectRandom _segments;
		            	_destinationPos = getPos _destinationSegment;
		            };
		            
		            /*
				    if (isNil "ENGIMA_TRAFFIC_LineMarkerNo") then { ENGIMA_TRAFFIC_LineMarkerNo = 1 };
				    private _marker = createMarker ["ENGIMA_TRAFFIC_LineMarker_" + str ENGIMA_TRAFFIC_LineMarkerNo, _destinationPos];
				    _marker setMarkerShape "ICON";
				    _marker setMarkerType "hd_dot";
				    _marker setMarkerColor "ColorGreen";
				    ENGIMA_TRAFFIC_LineMarkerNo = ENGIMA_TRAFFIC_LineMarkerNo + 1;
					*/
		        }
		        else {
		            _destinationSegment = selectRandom _roadSegments;
		            _destinationPos = getPos _destinationSegment;
		        };

	            _direction = ((_destinationPos select 0) - (getPos _spawnSegment select 0)) atan2 ((_destinationPos select 1) - (getpos _spawnSegment select 1));
	            _roadSegmentDirection = getDir _spawnSegment;
	            
	            while {_roadSegmentDirection < 0} do {
	                _roadSegmentDirection = _roadSegmentDirection + 360;
	            };
	            while {_roadSegmentDirection > 360} do {
	                _roadSegmentDirection = _roadSegmentDirection - 360;
	            };
	            
	            while {_direction < 0} do {
	                _direction = _direction + 360;
	            };
	            while {_direction > 360} do {
	                _direction = _direction - 360;
	            };
	
	            _testDirection = _direction - _roadSegmentDirection;
	            
	            while {_testDirection < 0} do {
	                _testDirection = _testDirection + 360;
	            };
	            while {_testDirection > 360} do {
	                _testDirection = _testDirection - 360;
	            };
	            
	            _facingAway = false;
	            if (_testDirection > 90 && _testDirection < 270) then {
	                _facingAway = true;
	            };
	            
	            if (_facingAway) then {
	                _direction = _roadSegmentDirection + 180;
	            }
	            else {
	                _direction = _roadSegmentDirection;
	            };            
	            
	            _posX = (getPos _spawnSegment) select 0;
	            _posY = (getPos _spawnSegment) select 1;
	            
	            _posX = _posX + 2.5 * sin (_direction + 90);
	            _posY = _posY + 2.5 * cos (_direction + 90);
	            _pos = [_posX, _posY, 0];
	            
	            // Create vehicle
	            _vehicleClassName = selectRandom _possibleVehicles;
	            
	            private _spawnArgs = [_pos, _vehicleClassName];
	            private _goOnWithSpawn = [_spawnArgs, count _activeVehicles, _calculatedMaxVehicleCount] call _fnc_onUnitCreating;
	            
	            // Retrieve the possibly altered values
	            _pos = _spawnArgs select 0;
	            _vehicleClassName = _spawnArgs select 1;
	            
                if (isNil "_goOnWithSpawn") then {
                    _goOnWithSpawn = true;
                };
                
                // If the user has not messed something up, use the edited class list
                private _userMessedUp = false;
                private _logMsg = "";
                if (count _spawnArgs != 2) then {
                    _userMessedUp = true;
                    _logMsg = "Engima.Traffic: Error - Altered params array in ON_UNIT_CREATING has wrong number of items. Should be 2.";
                };
                if (isNil "_pos" || { !(_pos isEqualTypeArray [0,0] || _pos isEqualTypeArray [0,0,0]) }) then {
                    _pos = [0,0,0];
                    _userMessedUp = true;
                    _logMsg = "Engima.Traffic: Error - Altered parameter 0 in ON_UNIT_CREATING is not a position. Must be on format [0,0,0]";
                };
                if (isNil "_vehicleClassName" || { !(typeName _vehicleClassName == "String") }) then {
                    _vehicleClassName = "";
                    _userMessedUp = true;
                    _logMsg = "Engima.Traffic: Error - Altered parameter 1 in ON_UNIT_CREATING is not an array. Must be an array with unit class names.";
                };
                
                if (_userMessedUp) then {
                    diag_log _logMsg;
                    player sideChat _logMsg;
                };
                
				if (_goOnWithSpawn && { _vehicleClassName != "" } && { !_userMessedUp }) then {
		            _result = [_pos, _direction, _vehicleClassName, _side] call BIS_fnc_spawnVehicle;
		            _vehicle = _result select 0;
		            _vehiclesCrew = _result select 1;
		            _vehiclesGroup = _result select 2;
		            
		            // Name vehicle
		            sleep random 0.1;
		            if (isNil "ENGIMA_TRAFFIC_CurrentEntityNo") then {
		                ENGIMA_TRAFFIC_CurrentEntityNo = 0
		            };
		            
		            _currentEntityNo = ENGIMA_TRAFFIC_CurrentEntityNo;
		            ENGIMA_TRAFFIC_CurrentEntityNo = ENGIMA_TRAFFIC_CurrentEntityNo + 1;
		            
		            _vehicleVarName = "ENGIMA_TRAFFIC_Entity_" + str _currentEntityNo;
		            _vehicle setVehicleVarName _vehicleVarName;
		            _vehicle call compile format ["%1=_this;", _vehicleVarName];
		            sleep 0.01;
		            
		            // Set crew skill
		            {
		                _skill = _minSkill + random (_maxSkill - _minSkill);
		                _x setSkill _skill;
			            sleep 0.01;
		            } foreach _vehiclesCrew;
		            
		            _debugMarkerName = "ENGIMA_TRAFFIC_DebugMarker" + str _currentEntityNo;
		            
		            // Start vehicle
		            [_currentInstanceIndex, _vehicle, _areaMarkerName, _destinationPos, _debug] spawn ENGIMA_TRAFFIC_MoveVehicle;
		            _activeVehicles pushBack [_vehicle, _vehiclesGroup, _vehiclesCrew, _debugMarkerName, [0,0,0], time];
		            sleep 0.01;
		            
		            // Run spawn callbacks
		            [_vehicle, _vehiclesGroup, count _activeVehicles, _calculatedMaxVehicleCount] call _fnc_OnUnitCreated;
		            _result spawn _fnc_OnSpawnVehicleObsolete;
		        };
			};
	    };
	    
	    // #endregion
	    
	    // Do nothing but update debug markers for X seconds
	    _sleepSeconds = 5;
	    if (_debug) then {
		    for "_i" from 1 to _sleepSeconds do {
		        {
		            private ["_debugMarkerColor"];
		            
		            _vehicle = _x select 0;
		            _group = _x select 1;
		            _debugMarkerName = _x select 3;
		            _side = side _group;
		            
		            _debugMarkerColor = "Default";
		            if (_side == west) then {
		                _debugMarkerColor = "ColorBlufor";
		            };
		            if (_side == east) then {
		                _debugMarkerColor = "ColorOpfor";
		            };
		            if (_side == civilian) then {
		                _debugMarkerColor = "ColorCivilian";
		            };
		            if (_side == resistance) then {
		                _debugMarkerColor = "ColorIndependent";
		            };
		            
		            if (!canMove _vehicle) then {
		            	_debugMarkerColor = "ColorBlack";
		            }
		            else {
		            	if (vehicle driver _vehicle != _vehicle) then {
			            	_debugMarkerColor = "ColorGrey";
		            	};
		            };
		            
		            [_debugMarkerName, getPos (_vehicle), "mil_dot", _debugMarkerColor, "Traffic"] call ENGIMA_TRAFFIC_SetDebugMarkerAllClients;
		            
		        } foreach _activeVehicles;
		    
		    	sleep 1;
		    };
    	}
    	else {
    		sleep _sleepSeconds;
    	};
	    
	    _firstIteration = false;
	};
};
