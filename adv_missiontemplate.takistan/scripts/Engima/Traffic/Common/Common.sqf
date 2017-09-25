/*
 * Summary: Gets a parameter value in a paired list on format ["KEY", value].
 * Arguments:
 *   _params: List of paired value parameters.
 *   _key: String with key to look for.
 *   _default: Value that is returned if key was not found.
 * Returns: Value associated with key. ObjNull if no key was found.
 */
ENGIMA_TRAFFIC_GetParamValue = {
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
 * Summary: Checks if a marker exists.
 * Arguments:
 *   _marker: Marker name of marker to test.
 * Returns: true if marker exists, else false.
 */
ENGIMA_TRAFFIC_MarkerExists = {
	private ["_exists", "_marker"];

	_marker = _this select 0;

	_exists = false;
	if (((getMarkerPos _marker) select 0) != 0 || ((getMarkerPos _marker) select 1 != 0)) then {
		_exists = true;
	};
	_exists
};
