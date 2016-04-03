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
	"Munitionsträger"
];
if (side (group player) == east) then {
	_loadoutList set [0,"Sektionsführer"];
	_loadoutList set [11,"Soldat (RPG)"];
	_loadoutList set [12,"Soldat"];
};
if (side (group player) == independent) then {

};
if ( ADV_par_customWeap == 1 && (side (group player) == west) ) then {
	_loadoutList set [6,"Schütze (Pzf3)"];
	_loadoutList set [7,"Schütze (RGW90)"];
	_loadoutList set [8,"Luftabwehrschütze"];
	_loadoutList set [9,"asst. Luftabwehrschütze"];
	_loadoutList set [11,"Schütze (Pzf3)"];
};

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
	lbSetData [7377, 26, "ADV_fnc_ABearer"];
};
if (side (group player) == independent) then {
	//Loadouts:
	lbSetData [7377, 0, "ADV_ind_fnc_command"];
	lbSetData [7377, 1, "ADV_ind_fnc_leader"];
	lbSetData [7377, 2, "ADV_ind_fnc_ftLeader"];
	lbSetData [7377, 3, "ADV_ind_fnc_lmg"];
	lbSetData [7377, 4, "ADV_ind_fnc_AR"];
	lbSetData [7377, 5, "ADV_ind_fnc_assAR"];
	lbSetData [7377, 6, "ADV_ind_fnc_AT"];
	lbSetData [7377, 7, "ADV_ind_fnc_assAT"];
	lbSetData [7377, 8, "ADV_ind_fnc_AA"];
	lbSetData [7377, 9, "ADV_ind_fnc_assAA"];
	lbSetData [7377, 10, "ADV_ind_fnc_gren"];
	lbSetData [7377, 11, "ADV_ind_fnc_soldierAT"];
	lbSetData [7377, 12, "ADV_ind_fnc_soldier"];
	lbSetData [7377, 13, "ADV_ind_fnc_marksman"];
	lbSetData [7377, 14, "ADV_ind_fnc_medic"];
	lbSetData [7377, 15, "ADV_ind_fnc_cls"];
	lbSetData [7377, 16, "ADV_ind_fnc_spec"];
	lbSetData [7377, 17, "ADV_ind_fnc_uavOp"];
	lbSetData [7377, 18, "ADV_ind_fnc_sniper"];
	lbSetData [7377, 19, "ADV_ind_fnc_spotter"];
	lbSetData [7377, 20, "ADV_ind_fnc_driver"];
	lbSetData [7377, 21, "ADV_ind_fnc_log"];
	lbSetData [7377, 22, "ADV_ind_fnc_diver"];
	lbSetData [7377, 23, "ADV_ind_fnc_diver_medic"];
	lbSetData [7377, 24, "ADV_ind_fnc_diver_spec"];
	lbSetData [7377, 25, "ADV_ind_fnc_pilot"];
	lbSetData [7377, 26, "ADV_ind_fnc_ABearer"];
};
if (side (group player) == east) then {
	//Loadouts:
	lbSetData [7377, 0, "ADV_opf_fnc_command"];
	lbSetData [7377, 1, "ADV_opf_fnc_leader"];
	lbSetData [7377, 2, "ADV_opf_fnc_ftLeader"];
	lbSetData [7377, 3, "ADV_opf_fnc_lmg"];
	lbSetData [7377, 4, "ADV_opf_fnc_AR"];
	lbSetData [7377, 5, "ADV_opf_fnc_assAR"];
	lbSetData [7377, 6, "ADV_opf_fnc_AT"];
	lbSetData [7377, 7, "ADV_opf_fnc_assAT"];
	lbSetData [7377, 8, "ADV_opf_fnc_AA"];
	lbSetData [7377, 9, "ADV_opf_fnc_assAA"];
	lbSetData [7377, 10, "ADV_opf_fnc_gren"];
	lbSetData [7377, 11, "ADV_opf_fnc_soldierAT"];
	lbSetData [7377, 12, "ADV_opf_fnc_soldier"];
	lbSetData [7377, 13, "ADV_opf_fnc_marksman"];
	lbSetData [7377, 14, "ADV_opf_fnc_medic"];
	lbSetData [7377, 15, "ADV_opf_fnc_cls"];
	lbSetData [7377, 16, "ADV_opf_fnc_spec"];
	lbSetData [7377, 17, "ADV_opf_fnc_uavOp"];
	lbSetData [7377, 18, "ADV_opf_fnc_sniper"];
	lbSetData [7377, 19, "ADV_opf_fnc_spotter"];
	lbSetData [7377, 20, "ADV_opf_fnc_driver"];
	lbSetData [7377, 21, "ADV_opf_fnc_log"];
	lbSetData [7377, 22, "ADV_opf_fnc_diver"];
	lbSetData [7377, 23, "ADV_opf_fnc_diver_medic"];
	lbSetData [7377, 24, "ADV_opf_fnc_diver_spec"];
	lbSetData [7377, 25, "ADV_opf_fnc_pilot"];
	lbSetData [7377, 26, "ADV_opf_fnc_ABearer"];
};

if (true) exitWith {};