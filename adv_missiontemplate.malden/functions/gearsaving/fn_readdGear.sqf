/*
 * Author: Belbo
 *
 * Adds loadout to unit (with a fix for instanciated radios.
 *
 * Arguments:
 * 0: target - <OBJECT>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [player] call adv_fnc_readdGear;
 *
 * Public: No
 */

params [
	["_unit", player, [objNull]],
	["_loadout", [], [[]]]
];

_assignedItems = _loadout select 9;

call {
	if (isClass (configFile >> "CfgPatches" >> "tfar_core")) exitWith {
		{
			if (["rc154",_x] call BIS_fnc_inString) then {
				_assignedItems set [2,"tfar_anprc154"];
			};
			if (["rc148",_x] call BIS_fnc_inString) then {
				_assignedItems set [2,"tfar_anprc148jem"];
			};
			if (["rc152",_x] call BIS_fnc_inString) then {
				_assignedItems set [2,"tfar_anprc152"];
			};
			if (["fadak",_x] call BIS_fnc_inString) then {
				_assignedItems set [2,"tfar_fadak"];
			};
			if (["rf780",_x] call BIS_fnc_inString) then {
				_assignedItems set [2,"tfar_rf7800str"];
			};
			if (["pnr10",_x] call BIS_fnc_inString) then {
				_assignedItems set [2,"tfar_pnr1000a"];
			};
			nil;
		} count _assignedItems;
	};

	if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) exitWith {
		{
			if (["rc154",_x] call BIS_fnc_inString) then {
				_assignedItems set [2,"tf_anprc154"];
			};
			if (["rc148",_x] call BIS_fnc_inString) then {
				_assignedItems set [2,"tf_anprc148jem"];
			};
			if (["rc152",_x] call BIS_fnc_inString) then {
				_assignedItems set [2,"tf_anprc152"];
			};
			if (["fadak",_x] call BIS_fnc_inString) then {
				_assignedItems set [2,"tf_fadak"];
			};
			if (["rf780",_x] call BIS_fnc_inString) then {
				_assignedItems set [2,"tf_rf7800str"];
			};
			if (["pnr10",_x] call BIS_fnc_inString) then {
				_assignedItems set [2,"tf_pnr1000a"];
			};
			nil;
		} count _assignedItems;

	};
};

_loadout set [9,_assignedItems];

_unit setUnitLoadout [_loadout,true];
 
true;