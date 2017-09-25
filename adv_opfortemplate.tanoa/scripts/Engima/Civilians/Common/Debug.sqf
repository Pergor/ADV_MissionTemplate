ENGIMA_CIVILIANS_SilentDebugMode = false;

ENGIMA_CIVILIANS_DebugTextEventArgs = []; // Empty
ENGIMA_CIVILIANS_DebugMarkerEventArgs = []; // [name, position, size, direction, shape ("RECTANGLE" or "ELLIPSE"), markerColor, markerText (optional)] or alternatively [name, position, type, markerColor (optional), markerText (optional)]
ENGIMA_CIVILIANS_DeleteDebugMarkerEventArgs = [];  // [name]

"ENGIMA_CIVILIANS_DebugTextEventArgs" addPublicVariableEventHandler {
    ENGIMA_CIVILIANS_DebugTextEventArgs call ENGIMA_CIVILIANS_ShowDebugTextLocal;
};

"ENGIMA_CIVILIANS_DebugMarkerEventArgs" addPublicVariableEventHandler {
    ENGIMA_CIVILIANS_DebugMarkerEventArgs call ENGIMA_CIVILIANS_SetDebugMarkerLocal;
};

"ENGIMA_CIVILIANS_DeleteDebugMarkerEventArgs" addPublicVariableEventHandler {
    ENGIMA_CIVILIANS_DeleteDebugMarkerEventArgs call ENGIMA_CIVILIANS_DeleteDebugMarkerLocal;
};

/*
 * Summary: Checks if a marker exists.
 * Arguments:
 *   _marker: Marker name of marker to test.
 * Returns: true if marker exists, else false.
 */
ENGIMA_CIVILIANS_MarkerExists = {
	private ["_exists", "_marker"];

	_marker = _this select 0;

	_exists = false;
	if (((getMarkerPos _marker) select 0) != 0 || ((getMarkerPos _marker) select 1 != 0)) then {
		_exists = true;
	};
	_exists
};

/*
 * Summary: Shows debug text on all clients.
 * Remarks:
 *   if global variable "dre_var_CL_SilentDebugMode" is set to true, debug text will only be written to RTF-file and not shown on screen.
 * Arguments:
 *   _text: Debug text.
 */
ENGIMA_CIVILIANS_ShowDebugTextAllClients = {
    ENGIMA_CIVILIANS_DebugTextEventArgs = _this;
    publicVariable "ENGIMA_CIVILIANS_DebugTextEventArgs";
    ENGIMA_CIVILIANS_DebugTextEventArgs call ENGIMA_CIVILIANS_ShowDebugTextLocal;
};

/*
 * Summary: Shows debug text on local client.
 * Remarks:
 *   if global variable "dre_var_CL_SilentDebugMode" is set to true, debug text will only be written to RTF-file and not shown on screen.
 * Arguments:
 *   _text: Debug text.
 */
ENGIMA_CIVILIANS_ShowDebugTextLocal = {
    private ["_minutes", "_seconds"];
    
    if (!isNull player) then {
        if (!ENGIMA_CIVILIANS_SilentDebugMode) then {
            player sideChat (_this select 0);
        };
    };
    
    _minutes = floor (time / 60);
    _seconds = floor (time - (_minutes * 60));
    diag_log ((str _minutes + ":" + str _seconds) + " Debug: " + (_this select 0));
};

/*
 * Summary: Shows debug marker on local client.
 * Remarks:
 *   if global variable "dre_var_CL_SilentDebugMode" is set to true, debug marker will not shown.
 * Arguments alternative #1 (Marker representing an area):
 *   _markerName: Marker's name. (must be global unique).
 *   _position: Marker's position.
 *   _size: Marker's size on array format [x, y].
 *   _direction: Marker's direction.
 *   _shape: "RECTANGLE" or "ELLIPSE".
 *   _markerColor: Marker's color ("Default", "ColorRed", "ColorYellow" etc.).
 *   [_markerText]: Optional. Marker's text.
 * Arguments alternative #2 (Marker representing an icon).
 *   _markerName: Marker's name. (must be global unique).
 *   _position: Marker's position.
 *   _type: Markers icon type (applies to icons in cfgIcons, like "Warning", "Dot" etc.).
 *   [_markerColor]: Optional. Marker's color ("Default", "ColorRed", "ColorYellow" etc.).
 *   [_markerText]. Optional. Marker's text.
 */
ENGIMA_CIVILIANS_SetDebugMarkerLocal = {
    private ["_markerName", "_position", "_size", "_direction", "_type", "_shape", "_markerColor", "_markerText"];
    private ["_marker"];

    if (!isNull player) then {
        if (!ENGIMA_CIVILIANS_SilentDebugMode) then {
            _markerName = _this select 0;
            _position = _this select 1;
            _markerColor = "Default";
            _markerText = "";
            
            if (count _this == 6) then {
                _size = _this select 2;
                _direction = _this select 3;
                _shape = _this select 4;
                _markerColor = _this select 5;
            };
            if (count _this == 7) then {
                _size = _this select 2;
                _direction = _this select 3;
                _shape = _this select 4;
                _markerColor = _this select 5;
                _markerText = _this select 6;
            };
            if (count _this == 3) then {
                _type = _this select 2;
                _shape = "ICON";
            };
            if (count _this == 4) then {
                _type = _this select 2;
                _shape = "ICON";
                _markerColor = _this select 3;
            };
            if (count _this == 5) then {
                _type = _this select 2;
                _shape = "ICON";
                _markerColor = _this select 3;
                _markerText = _this select 4;
            };
            
            // Delete old marker
            if ([_markerName] call ENGIMA_CIVILIANS_MarkerExists) then {
                deleteMarkerLocal _markerName;
            };
            
            // Set new marker
            _marker = createMarkerLocal [_markerName, _position];
            _marker setMarkerShapeLocal _shape;
            _marker setMarkerColorLocal _markerColor;
            _marker setMarkerTextLocal _markerText;
            
            if (count _this == 6 || count _this == 7) then {
                _marker setMarkerSizeLocal _size;
                _marker setMarkerDirLocal _direction;
            };
            if (count _this == 3 || count _this == 4 || count _this == 5) then {
                _marker setMarkerTypeLocal _type;
            };
        };
    };
};

/*
 * Summary: Shows debug marker on all clients.
 * Remarks:
 *   if global variable "dre_var_CL_SilentDebugMode" is set to true, debug marker will not shown.
 * Arguments alternative #1 (Marker representing an area):
 *   _markerName: Marker's name. (must be global unique).
 *   _position: Marker's position.
 *   _size: Marker's size on array format [x, y].
 *   _direction: Marker's direction.
 *   _shape: "RECTANGLE" or "ELLIPSE".
 *   _markerColor: Marker's color ("Default", "ColorRed", "ColorYellow" etc.).
 *   [_markerText]: Optional. Marker's text.
 * Arguments alternative #2 (Marker representing an icon).
 *   _markerName: Marker's name. (must be global unique).
 *   _position: Marker's position.
 *   _type: Markers icon type (applies to icons in cfgIcons, like "Warning", "Dot" etc.).
 *   [_markerColor]: Optional. Marker's color ("Default", "ColorRed", "ColorYellow" etc.).
 *   [_markerText]. Optional. Marker's text.
 */
ENGIMA_CIVILIANS_SetDebugMarkerAllClients = {
    ENGIMA_CIVILIANS_DebugMarkerEventArgs = _this;
    publicVariable "ENGIMA_CIVILIANS_DebugMarkerEventArgs";
    ENGIMA_CIVILIANS_DebugMarkerEventArgs call ENGIMA_CIVILIANS_SetDebugMarkerLocal;
};

/*
 * Summary: Deletes a debug marker on local client.
 * Arguments:
 *   _markerName: Name of marker to delete.
 */
ENGIMA_CIVILIANS_DeleteDebugMarkerLocal = {
    private ["_markerName"];
    _markerName = _this select 0;
    deleteMarkerLocal _markerName;
};

/*
 * Summary: Deletes a debug marker on all clients.
 * Arguments:
 *   _markerName: Name of marker to delete.
 */
ENGIMA_CIVILIANS_DeleteDebugMarkerAllClients = {
    ENGIMA_CIVILIANS_DeleteDebugMarkerEventArgs = _this;
    publicVariable "ENGIMA_CIVILIANS_DeleteDebugMarkerEventArgs";
    ENGIMA_CIVILIANS_DeleteDebugMarkerEventArgs call ENGIMA_CIVILIANS_DeleteDebugMarkerLocal;
};
