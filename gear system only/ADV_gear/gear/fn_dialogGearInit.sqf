//////////////////////////////////////////////////////////////////
// 
//LOADOUT ussf
//MADE BY Raspu
// 
//////////////////////////////////////////////////////////////////

disableSerialization;

//dialog
_display = _this select 0;
_listBox = _display displayCtrl 7377;
_comboBox = _display displayCtrl 7977;

// LBs leeren
lbClear _listBox;
lbClear _comboBox;

//Loadout-Liste:
_loadoutList = [
	"Zugführer",
	"Gruppenführer",
	"Truppführer",
	"LMG-Schütze",
	"MG-Schütze",
	"asst. MG-Schütze",
	"AT-Spezialist",
	"asst. AT-Spezialist",
	"AA-Spezialist",
	"asst. AA-Spezialist",
	"Grenadier",
	"Schütze (AT)",
	"Schütze",
	"Zielfernrohrschütze",
	"Sanitäter",
	"Einsatzersthelfer",
	"Pionier",
	"UAV-Spezialist",
	"Scharfschütze",
	"Beobachter",
	"Fahrzeugbesatzung",
	"Logistiker",
	"Taucher",
	"Taucher (Sanitäter)",
	"Taucher (Pionier)",
	"Pilot",
];

{ lbAdd [7377, _x] } foreach _loadoutList;

if (side (group player) == west) then {
	//Loadouts:
	lbSetData [7377, 0, "ADV_fnc_command"];
	lbSetData [7377, 1, "ADV_fnc_leader"];
	lbSetData [7377, 2, "ADV_fnc_ftLeader"];
	lbSetData [7377, 3, "ADV_fnc_lmg"];
	lbSetData [7377, 4, "ADV_fnc_AR"];
	lbSetData [7377, 5, "ADV_fnc_assAR"];
	lbSetData [7377, 6, "ADV_fnc_AT"];
	lbSetData [7377, 7, "ADV_fnc_assAT"];
	lbSetData [7377, 8, "ADV_fnc_AA"];
	lbSetData [7377, 9, "ADV_fnc_assAA"];
	lbSetData [7377, 10, "ADV_fnc_gren"];
	lbSetData [7377, 11, "ADV_fnc_soldierAT"];
	lbSetData [7377, 12, "ADV_fnc_soldier"];
	lbSetData [7377, 13, "ADV_fnc_marksman"];
	lbSetData [7377, 14, "ADV_fnc_medic"];
	lbSetData [7377, 15, "ADV_fnc_cls"];
	lbSetData [7377, 16, "ADV_fnc_spec"];
	lbSetData [7377, 17, "ADV_fnc_uavOp"];
	lbSetData [7377, 18, "ADV_fnc_sniper"];
	lbSetData [7377, 19, "ADV_fnc_spotter"];
	lbSetData [7377, 20, "ADV_fnc_driver"];
	lbSetData [7377, 21, "ADV_fnc_log"];
	lbSetData [7377, 22, "ADV_fnc_diver"];
	lbSetData [7377, 23, "ADV_fnc_diver_medic"];
	lbSetData [7377, 24, "ADV_fnc_diver_spec"];
	lbSetData [7377, 25, "ADV_fnc_pilot"];
};

if (true) exitWith {};