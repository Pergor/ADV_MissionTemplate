ENGIMA_CIVILIANS_GetParamValue = {
  	private ["_params", "_key"];
  	private ["_value"];

   	_params = _this select 0;
   	_key = _this select 1;
	_value = if (count _this > 2) then { _this select 2 } else { objNull };

   	{
   		if (_x select 0 == _key) then {
   			_value = _x select 1;
   		};
   	} foreach (_params);
    	
   	_value
};

/*
 * Summary: Checks if a position is inside a marker.
 * Remarks: Marker can be of shape "RECTANGLE" or "ELLIPSE" and at any angle.
 * Arguments:
 *   _markerName: Name of current marker.
 *   _pos: Position to test.
 * Returns: true if position is inside marker. Else false.
 */
ENGIMA_CIVILIANS_PositionIsInsideMarker = {
	params ["_pos","_markerName"];
	private _return = _pos inArea _markerName;
	_return;

	/*
    private ["_markerName", "_pos"];
	private ["_isInside", "_px", "_py", "_mpx", "_mpy", "_msx", "_msy", "_ma", "_xmin", "_xmax", "_ymin", "_ymax", "_rpx", "_rpy", "_res"];

	_pos = _this select 0;
	_markerName = _this select 1;

	_px = _pos select 0;
	_py = _pos select 1;
	_mpx = (getMarkerPos _markerName) select 0;
	_mpy = (getMarkerPos _markerName) select 1;
	_msx = (getMarkerSize _markerName) select 0;
	_msy = (getMarkerSize _markerName) select 1;
	_ma = -(markerDir _markerName);

	_xmin = _mpx - _msx;
	_xmax = _mpx + _msx;
	_ymin = _mpy - _msy;
	_ymax = _mpy + _msy;

	//Now, rotate point to investigate around markers center in order to check against a nonrotated marker
	_rpx = ( (_px - _mpx) * cos(_ma) ) + ( (_py - _mpy) * sin(_ma) ) + _mpx;
	_rpy = (-(_px - _mpx) * sin(_ma) ) + ( (_py - _mpy) * cos(_ma) ) + _mpy;

	_isInside = false;

    if (markerShape _markerName == "RECTANGLE") then {
        if (((_rpx > _xmin) && (_rpx < _xmax)) && ((_rpy > _ymin) && (_rpy < _ymax))) then
        {
            _isInside = true;
        };
    };
    
    if (markerShape _markerName == "ELLIPSE") then {
        _res = (((_rpx-_mpx)^2)/(_msx^2)) + (((_rpy-_mpy)^2)/(_msy^2));
        if ( _res < 1 ) then
        {
            _isInside = true;
        };
    };

	_isInside
	*/
};

ENGIMA_CIVILIANS_GetAllPlayersPositions = {
	private ["_playerPositions"];

	_playerPositions = [];
	
	if (isMultiplayer) then {
		{
			if (isPlayer _x) then {
				_playerPositions pushBack (position vehicle _x);
			};
		} foreach (playableUnits);
	}
	else {
		if (player == player) then {
			_playerPositions = [position vehicle player];
		};
	};
	
	// testing
	//_playerPositions = [p1, p2];
	
	_playerPositions
};

ENGIMA_CIVILIANS_CountPositionsInBuilding = {
	private ["_building"];
	private ["_count"];
	
	_building = _this select 0;
	
	_count = 0;
	while { format ["%1", _building buildingPos _count] != "[0,0,0]" } do {
		_count = _count + 1;
	};
	
	_count
};

ENGIMA_CIVILIANS_FindSpawnPosition = {
	private ["_minSpawnDistance", "_playerBuildings", "_blackListMarkers"];
	private ["_playerPositions", "_tries", "_positionFound", "_foundPosition", "_buildingPosCount", "_building", "_tooClose", "_buildingPosNo", "_playerBuilding"];
	
	_minSpawnDistance = _this select 0;
	_playerBuildings = _this select 1;
	_blackListMarkers = _this select 2;
	
	_playerPositions = call ENGIMA_CIVILIANS_GetAllPlayersPositions;
	
	_tries = 0;
	_positionFound = false;
	_foundPosition = [];

	while { count _playerBuildings > 0 && !_positionFound && _tries < 10 } do {
		_tries = _tries + 1;
		_playerBuilding = _playerBuildings select floor random count _playerBuildings;
		_building = _playerBuilding select 0;
		_buildingPosCount = _playerBuilding select 1;
		
		//_buildingPosCount = [_building] call ENGIMA_CIVILIANS_CountPositionsInBuilding;
		
		if (_buildingPosCount > 0) then {
			_buildingPosNo = floor random _buildingPosCount;
			
			_tooClose = false;
			if (time > 5) then {
				{
					if (_x distance _building < _minSpawnDistance) then {
						_tooClose = true;
					};
				} foreach _playerPositions;
			};
			
			if (!_tooClose) then {
				if (!([getPos _building, _blackListMarkers] call ENGIMA_CIVILIANS_PositionInsideBlackMarker)) then {
					_foundPosition = _building buildingPos _buildingPosNo;
					_positionFound = true;
				};
			};
		};
	};

	_foundPosition
};

ENGIMA_CIVILIANS_PositionInsideBlackMarker = {
	private ["_pos", "_blackListMarkers"];
	private ["_isInsideMarker"];
	
	_pos = _this select 0;
	_blackListMarkers = _this select 1;
	
	_isInsideMarker = false;
	
	{
		if ([_pos, _x] call ENGIMA_CIVILIANS_PositionIsInsideMarker) then { 
			_isInsideMarker = true;
		};
	} foreach _blackListMarkers;
	
	_isInsideMarker
};

ENGIMA_CIVILIANS_FindDestinationPosition = {
	private ["_civilian", "_blackListMarkers", "_maxSpawnDistance"];
	private ["_tries", "_positionFound", "_foundPosition", "_buildingPosCount", "_buildings", "_building", "_buildingPosNo", "_unitPos"];
	
	_civilian = _this select 0;
	_blackListMarkers = _this select 1;
	_maxSpawnDistance = _this select 2;

	_foundPosition = [];
	_tries = 0;
	_positionFound = false;
	_unitPos = getPosAtl _civilian;
	
	if (random 100 > 50) then {
		// Pick a building
		_buildings = nearestObjects [_unitPos, ["house"], _maxSpawnDistance];
		
		while { count _buildings > 0 && !_positionFound && _tries < 10 } do {
			_tries = _tries + 1;
			
			_building = _buildings select floor random count _buildings;
			_buildingPosCount = [_building] call ENGIMA_CIVILIANS_CountPositionsInBuilding;
			
			if (_buildingPosCount > 0) then {
				if (!([getPos _building, _blackListMarkers] call ENGIMA_CIVILIANS_PositionInsideBlackMarker)) then {
					_buildingPosNo = floor random _buildingPosCount;
					_foundPosition = _building buildingPos _buildingPosNo;
					_positionFound = true;
				};
			};
		};
	}
	else {
		private ["_distance", "_angle", "_x", "_y", "_pos"];
		
		while { !_positionFound && _tries < 10 } do {
			_tries = _tries + 1;
			
			_distance = random 200;
			_angle = random 360;
			_x = _distance * cos _angle;
			_y = _distance * sin _angle;
			
			_pos = [(_unitPos select 0) + _x, (_unitPos select 1) + _y];
			if (!isOnRoad _pos && !surfaceIsWater _pos && !([_pos, _blackListMarkers] call ENGIMA_CIVILIANS_PositionInsideBlackMarker)) then {
				_foundPosition = _pos;
				_positionFound = true;
			};
		};
	};	
	
	_foundPosition
};

ENGIMA_CIVILIANS_GetPlayerBuildings = {
	private ["_allPlayerPositions", "_maxSpawnDistance", "_blackListMarkers"];
	private ["_playerBuildings", "_buildings", "_playerBuildingsTemp", "_buildingPosCount"];

	_allPlayerPositions = _this select 0;
	_maxSpawnDistance = _this select 1;
	_blackListMarkers = _this select 2;

	_playerBuildings = [];
	_allPlayerPositions = call ENGIMA_CIVILIANS_GetAllPlayersPositions;
	
	{
		_buildings = nearestObjects [_x, ["house"], _maxSpawnDistance];
		sleep 0.01;
		_buildings = _buildings - _playerBuildings;
		sleep 0.01;
		_playerBuildings = _playerBuildings + _buildings;
		sleep 0.01;
	} foreach _allPlayerPositions;
	
	// Remove all buildings that have no positions or are inside blacklist markers
	_playerBuildingsTemp = [];
	{
		_buildingPosCount = [_x] call ENGIMA_CIVILIANS_CountPositionsInBuilding;
		
		if (_buildingPosCount > 0) then {
			if (!([getPos _x, _blackListMarkers] call ENGIMA_CIVILIANS_PositionInsideBlackMarker)) then {
				_playerBuildingsTemp pushBack [_x, _buildingPosCount];
			};
		}
	} foreach _playerBuildings;

//	hint str count _playerBuildingsTemp;
	
//	{
//		[str getPos (_x select 0), getPos (_x select 0), "mil_dot", "ColorYellow", ""] call ENGIMA_CIVILIANS_SetDebugMarkerAllClients;
//	} foreach _playerBuildingsTemp;
		
	_playerBuildingsTemp
};

ENGIMA_CIVILIANS_StartCivilians = {
	private ["_unitClasses", "_unitsPerBuilding", "_maxGroupsCount", "_minSpawnDistance", "_maxSpawnDistance", "_blackListMarkers", "_hideBlacklistMarkers", "_fnc_OnSpawnCallback", "_fnc_OnRemoveCallback", "_debug"];
	private ["_side", "_minSkill", "_maxSkill", "_unit", "_unitsCount"];
	private ["_civilianItems", "_civilianItemsTemp"];
	private ["_spawnUnit", "_allPlayerPositions", "_playerBuildings"];
	
	_unitClasses = [_this, "UNIT_CLASSES", ["C_man_1", "C_man_1_1_F", "C_man_1_2_F", "C_man_1_3_F", "C_man_polo_1_F", "C_man_polo_1_F_afro", "C_man_polo_1_F_euro", "C_man_polo_1_F_asia", "C_man_polo_2_F", "C_man_polo_2_F_afro", "C_man_polo_2_F_euro", "C_man_polo_2_F_asia", "C_man_polo_3_F", "C_man_polo_3_F_afro", "C_man_polo_3_F_euro", "C_man_polo_3_F_asia", "C_man_polo_4_F", "C_man_polo_4_F_afro", "C_man_polo_4_F_euro", "C_man_polo_4_F_asia", "C_man_polo_5_F", "C_man_polo_5_F_afro", "C_man_polo_5_F_euro", "C_man_polo_5_F_asia", "C_man_polo_6_F", "C_man_polo_6_F_afro", "C_man_polo_6_F_euro", "C_man_polo_6_F_asia", "C_man_p_fugitive_F", "C_man_p_fugitive_F_afro", "C_man_p_fugitive_F_euro", "C_man_p_fugitive_F_asia", "C_man_p_beggar_F", "C_man_p_beggar_F_afro", "C_man_p_beggar_F_euro", "C_man_p_beggar_F_asia", "C_man_w_worker_F", "C_scientist_F", "C_man_hunter_1_F", "C_man_p_shorts_1_F", "C_man_p_shorts_1_F_afro", "C_man_p_shorts_1_F_euro", "C_man_p_shorts_1_F_asia", "C_man_shorts_1_F", "C_man_shorts_1_F_afro", "C_man_shorts_1_F_euro", "C_man_shorts_1_F_asia", "C_man_shorts_2_F", "C_man_shorts_2_F_afro", "C_man_shorts_2_F_euro", "C_man_shorts_2_F_asia", "C_man_shorts_3_F", "C_man_shorts_3_F_afro", "C_man_shorts_3_F_euro", "C_man_shorts_3_F_asia", "C_man_shorts_4_F", "C_man_shorts_4_F_afro", "C_man_shorts_4_F_euro", "C_man_shorts_4_F_asia", "C_Orestes", "C_Nikos", "C_Nikos_aged"]] call ENGIMA_CIVILIANS_GetParamValue;
	_unitsPerBuilding = [_this, "UNITS_PER_BUILDING", 0.1] call ENGIMA_CIVILIANS_GetParamValue;
	_maxGroupsCount = [_this, "MAX_GROUPS_COUNT", 100] call ENGIMA_CIVILIANS_GetParamValue;
	_minSpawnDistance = [_this, "MIN_SPAWN_DISTANCE", 100] call ENGIMA_CIVILIANS_GetParamValue;
	_maxSpawnDistance = [_this, "MAX_SPAWN_DISTANCE", 500] call ENGIMA_CIVILIANS_GetParamValue;
	_blackListMarkers = [_this, "BLACKLIST_MARKERS", []] call ENGIMA_CIVILIANS_GetParamValue;
	_hideBlacklistMarkers = [_this, "HIDE_BLACKLIST_MARKERS", true] call ENGIMA_CIVILIANS_GetParamValue;
	_fnc_OnSpawnCallback = [_this, "ON_UNIT_SPAWNED_CALLBACK", {}] call ENGIMA_CIVILIANS_GetParamValue;
	_fnc_OnRemoveCallback = [_this, "ON_UNIT_REMOVE_CALLBACK", { true }] call ENGIMA_CIVILIANS_GetParamValue;
	_debug = [_this, "DEBUG", false] call ENGIMA_CIVILIANS_GetParamValue;

	if (_hideBlacklistMarkers) then {
		{
			if (_x isEqualType "") then {
				_x setMarkerAlpha 0;
			};
		} foreach _blackListMarkers;
	};

	_side = ENGIMA_CIVILIANS_SIDE;
	_minSkill = ENGIMA_CIVILIANS_MINSKILL;
	_maxSkill = ENGIMA_CIVILIANS_MAXSKILL;
	
	_spawnUnit = {
		private ["_side", "_minSpawnDistance", "_unitClasses", "_playerBuildings", "_blackListMarkers", "_fnc_OnSpawnCallback"];
		private ["_pos", "_unit", "_group"];
		
		_side = _this select 0;
		_minSpawnDistance = _this select 1;
		_unitClasses = _this select 2;
		_playerBuildings = _this select 3;
		_blackListMarkers = _this select 4;
		_fnc_OnSpawnCallback = _this select 5;
		
		_pos = [_minSpawnDistance, _playerBuildings, _blackListMarkers] call ENGIMA_CIVILIANS_FindSpawnPosition;
		_unit = objNull;
		
		if (count _pos > 0) then {
			_group = createGroup _side;
			_unit = _group createUnit [_unitClasses select floor random count _unitClasses, [0, 0, 100], [], random 360, "FORM"];
			[_unit] joinSilent _group;
			//[[_unit], _side] call adv_fnc_setSide;
			
			ENGIMA_CIVILIANS_INSTANCE_NO = ENGIMA_CIVILIANS_INSTANCE_NO + 1;
			_unit setVehicleVarName "ENGIMA_CIVILIAN_UNIT_" + str ENGIMA_CIVILIANS_INSTANCE_NO;
			
            doStop _unit;
            _unit setPos _pos;
            
			[_unit] spawn _fnc_OnSpawnCallback;
		};
		
		_unit
	};

	sleep 0.5;
	
	_civilianItems = []; // Items of type [unit, behaviour, destination pos, last pos, isMoving, nextActionTime, isRunning].
	
	while { true } do {
	
		_allPlayerPositions = call ENGIMA_CIVILIANS_GetAllPlayersPositions;
		_playerBuildings = [_allPlayerPositions, _maxSpawnDistance, _blackListMarkers] call ENGIMA_CIVILIANS_GetPlayerBuildings;
		_unitsCount = ceil (_unitsPerBuilding * count _playerBuildings);
		if (_unitsCount > _maxGroupsCount) then {
			_unitsCount = _maxGroupsCount;
		};
		
		if (count _civilianItems < _unitsCount) then {
		
			_unit = [_side, _minSpawnDistance, _unitClasses, _playerBuildings, _blackListMarkers, _fnc_OnSpawnCallback] call _spawnUnit;
			if (!isNull _unit) then {
				_unit setSkill _minSkill + random (_maxSkill - _minSkill);
				_civilianItems pushBack [_unit, "CITIZEN", [], getPos _unit, false, time, random 1 < ENGIMA_CIVILIANS_RUNNINGCHANCE];
			};
			
			sleep 0.1;
		};
		
		_civilianItemsTemp = [];
		{
			private ["_civilian"];
			private ["_tooClose", "_removeUnit", "_group"];
			
			_civilian = _x select 0;
			_tooClose = false;
			
			{
				if (_x distance _civilian < _maxSpawnDistance) then {
					_tooClose = true;
				};
			} foreach _allPlayerPositions;
			
			if (_tooClose) then {
				_civilianItemsTemp pushBack _x;
			}
			else {
				_removeUnit = [_civilian] call _fnc_OnRemoveCallback;
				
				if (isNil "_removeUnit") then {
					_removeUnit = true;
				};
				
				if (typeName _removeUnit != "BOOL") then {
					_removeUnit = true;
				};
				
				if (!_removeUnit) then {
					_civilianItemsTemp pushBack _x;
				}
				else {
					_group = group _civilian;
					[vehicleVarName _civilian] call ENGIMA_CIVILIANS_DeleteDebugMarkerAllClients;
					deleteVehicle _civilian;
					deleteGroup _group;
				};
			};
			
			sleep 0.01;
		} foreach _civilianItems;
		
		_civilianItems = _civilianItemsTemp;
		
		{
			private ["_unit", "_behaviour", "_destinationPos", "_lastPos", "_isMoving", "_nextActionTime", "_isRunning"];
			private ["_destPos"];
			
			_unit = _x select 0;
			_behaviour = _x select 1;
			_destinationPos = _x select 2;
			_lastPos = _x select 3;
			_isMoving = _x select 4;
			_nextActionTime = _x select 5;
			_isRunning = _x select 6;
			
			// If civilian has reached its destination
			if (_isMoving && _lastPos distance getPos _unit < 1) then {
				_isMoving = false;
				_nextActionTime = time + random ENGIMA_CIVILIANS_MAXWAITINGTIME;
				
				_x set [4, _isMoving]; // Set isMoving = false
				_x set [5, _nextActionTime]; // Next action time
				
				(group _unit) setFormDir random 360;
			};
			
			// If it is time for civilian to move
			if (!_isMoving && time > _nextActionTime) then {
				
				_destPos = [_unit, _blackListMarkers, _maxSpawnDistance] call ENGIMA_CIVILIANS_FindDestinationPosition;
				if (count _destPos > 0) then {
					_unit doMove _destPos;
					_unit setBehaviour "SAFE";
					
					_destinationPos = _destPos;
					_isMoving = true;
					_isRunning = random 1 < ENGIMA_CIVILIANS_RUNNINGCHANCE;
					
					_x set [3, _destinationPos]; // Set destinationPos
					_x set [4, _isMoving]; // Set isMoving
					_x set [6, _isRunning]; // Set isRunning
				};
			};
			
			if (_isRunning) then {
				_unit setSpeedMode "NORMAL";
			}
			else {
				_unit setSpeedMode "LIMITED";
			};
			
			_x set [3, getPos _unit];
			
			if (_debug) then {
				[vehicleVarName _unit, getPos _unit, "mil_dot", "ColorWhite", "Civ"] call ENGIMA_CIVILIANS_SetDebugMarkerAllClients;
			};
			
		} foreach _civilianItems;

		sleep 3;
	};
};

