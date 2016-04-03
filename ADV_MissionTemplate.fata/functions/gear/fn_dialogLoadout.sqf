// Ausrüstungsskript by James, 
// in Anlehnung an Maeh, Feldhobel
//hint str(_this);

_loadout = _this select 0; //String zur Datei

if (_loadout == "") exitWith {hint "Kein Loadout angegeben";};

// Aufruf des ausgewählten Loadouts -> Übergabe aus Dialog
//[player] call compile preprocessFileLineNumbers (format [_loadout,%1]);
//call compile format ["[player] call %1;", _loadout];
player setVariable ["ADV_var_playerUnit",_loadout];

[player] call ADV_fnc_applyLoadout;

closeDialog 1; // OK