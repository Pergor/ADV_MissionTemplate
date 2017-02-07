// Ausrüstungsskript by James, 
// in Anlehnung an Maeh, Feldhobel
//hint str(_this);

_loadout = _this select 0; //String zur Datei

if (_loadout isEqualTo "") exitWith {};

// Aufruf des ausgewählten Loadouts -> Übergabe aus Dialog
//[player] call compile preprocessFileLineNumbers (format [_loadout,%1]);
//call compile format ["[player] call %1;", _loadout];
player setVariable ["ADV_var_playerUnit",_loadout];
/*
if ((toUpper _loadout) in ["CSW","ACSW","MORTAR","AMORTAR","TOW","ATOW"] ) then {
	//if !(["CSW",(str player)] call BIS_fnc_inString || ["MOR",(str player)] call BIS_fnc_inString || ["TOW",(str player)] call BIS_fnc_inString) then {
		private _unitNameNumber = missionNamespace getVariable ["adv_csw_newUnitNames",0];
		missionNamespace setVariable ["adv_csw_newUnitNames",_unitNameNumber+1,true];
		private _sidePrefix = switch (side (group player)) do {
			case east: {"opf_"};
			case independent: {"ind_"};
			default {""};
		};
		private _newVarName = format ["%1%2_new_%3",_sidePrefix,_loadout,_unitNameNumber];
		[player,_newVarName] call ADV_fnc_changeUnit;
		player setVariable ["ADV_var_playerUnit",format ["ADV_%1fnc_soldier",_sidePrefix]];
	//};
};
*/

[player] call ADV_fnc_applyLoadout;

closeDialog 1; // OK