/*
 * Author: Belbo
 *
 * Adds teleport menu/action to objects.
 *
 * Arguments:
 * Array of objects - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [flag_1, flag_2, ..., flag_n] call adv_fnc_flag;
 *
 * Public: No
 */

 if (count _this == 0) exitWith {};
private _teleport = if ( missionNamespace getVariable ["ADV_par_moveMarker",2] isEqualTo 2 ) then {"Teleport/Parajump"} else {"Teleport"};
{
	if (!isNil "_x") then {
		private _target = _x;
		nul = _target addAction [
			"<t color='#00FF00' size='2' align='center'>"+_teleport+"</t>",
			{
			createDialog "adv_teleport_mainDialog"
			/*
				_unit = _this select 1;
				_leader = leader _unit;
				if (vehicle _leader != _leader) then {
					_vehicle = vehicle _leader;
					_unit moveInCargo _vehicle;
				} else {
					_unit setPos (getPos _leader);
				};
				if (_leader == _unit) then {
					_target = (units group _unit) select 1;
					if (!isNil "_target") then {
						if (vehicle _target != _target) then {
							_vehicle = vehicle _target;
							_unit moveInCargo _vehicle;
						} else {
							_unit setPos (getPos _target);
						};
					};
				};
			*/
			},nil,6,true,true,"","true",5
		];
	};
	nil;
} count _this;
	
true;