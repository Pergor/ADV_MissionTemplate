params [
	["_unit", player, [objNull]],
	["_loadout", [], [[]]]
];

_assignedItems = _loadout select 9;
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
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

_loadout set [9,_assignedItems];

_unit setUnitLoadout [_loadout,true];