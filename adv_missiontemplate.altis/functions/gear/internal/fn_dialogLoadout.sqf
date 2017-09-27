// Ausrüstungsskript by James, 
// in Anlehnung an Maeh, Feldhobel
params ["_loadout"];

if (_loadout isEqualTo "") exitWith {};

private _playerUnit = call compile _loadout;

player setVariable ["ADV_var_playerUnit",_playerUnit];

[player] call ADV_fnc_applyLoadout;

closeDialog 1; // OK

true;