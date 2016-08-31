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
	"---- Kommandoloadouts ----"
	,"Zugführer"
	,"Gruppenführer"
	,"Truppführer"
	,"Sanitäter"
	,"---- Manschaftsloadouts ----"
	,"LMG-Schütze"
	,"Grenadier"
	,"Schütze"
	,"Schütze (AT)"
	,"Munitionsträger"
	,"Einsatzersthelfer"
	,"---- Supportloadouts ----"
	,"MMG-Schütze"
	,"asst. MMG-Schütze"
	,"AT-Spezialist"
	,"asst. AT-Spezialist"
	,"AA-Spezialist"
	,"asst. AA-Spezialist"
	,"---- ZBV-Loadouts ----"
	,"Pionier"
	,"Zielfernrohrschütze"
	,"UAV-Spezialist"
	,"---- Logistikloadouts ----"
	,"Logistiker"
	,"Fahrzeugbesatzung"
	,"Pilot"
	,"---- SF-Loadouts ----"
	,"Scharfschütze"
	,"Beobachter"
	,"Taucher"
	,"Taucher (Sanitäter)"
	,"Taucher (Pionier)"
	/*,"---- CSW-Loadouts ----"
	,"HMG-Gunner"
	*/
];
if (side (group player) == east) then {
	_loadoutList set [1,"Sektionsführer"];
	_loadoutList set [8,"Soldat"];
	_loadoutList set [9,"Soldat (RPG)"];
};
if (side (group player) == independent) then {

};
if ( ADV_par_customWeap == 1 && (side (group player) == west) ) then {
	_loadoutList set [15,"Schütze (Pzf3)"];
	_loadoutList set [16,"Schütze (RGW90)"];
	_loadoutList set [17,"Luftabwehrschütze"];
	_loadoutList set [18,"asst. Luftabwehrschütze"];
	_loadoutList set [9,"Schütze (Pzf3)"];
};

{ lbAdd [7377, _x]; nil; } count _loadoutList;

lbSetData [7377, 0, ""];
lbSetData [7377, 5, ""];
lbSetData [7377, 12, ""];
lbSetData [7377, 19, ""];
lbSetData [7377, 23, ""];
lbSetData [7377, 27, ""];
//lbSetData [7377, 33, ""];
if (side (group player) == west) then {
	//Loadouts:
	lbSetData [7377, 1, "ADV_fnc_command"];
	lbSetData [7377, 2, "ADV_fnc_leader"];
	lbSetData [7377, 3, "ADV_fnc_ftLeader"];
	lbSetData [7377, 4, "ADV_fnc_medic"];
	lbSetData [7377, 6, "ADV_fnc_lmg"];
	lbSetData [7377, 7, "ADV_fnc_gren"];
	lbSetData [7377, 8, "ADV_fnc_soldier"];
	lbSetData [7377, 9, "ADV_fnc_soldierAT"];
	lbSetData [7377, 10, "ADV_fnc_ABearer"];
	lbSetData [7377, 11, "ADV_fnc_cls"];
	lbSetData [7377, 13, "ADV_fnc_AR"];
	lbSetData [7377, 14, "ADV_fnc_assAR"];
	lbSetData [7377, 15, "ADV_fnc_AT"];
	lbSetData [7377, 16, "ADV_fnc_assAT"];
	lbSetData [7377, 17, "ADV_fnc_AA"];
	lbSetData [7377, 18, "ADV_fnc_assAA"];
	lbSetData [7377, 20, "ADV_fnc_spec"];
	lbSetData [7377, 21, "ADV_fnc_marksman"];
	lbSetData [7377, 22, "ADV_fnc_uavOp"];
	lbSetData [7377, 24, "ADV_fnc_log"];
	lbSetData [7377, 25, "ADV_fnc_driver"];
	lbSetData [7377, 26, "ADV_fnc_pilot"];
	lbSetData [7377, 28, "ADV_fnc_sniper"];
	lbSetData [7377, 29, "ADV_fnc_spotter"];
	lbSetData [7377, 30, "ADV_fnc_diver"];
	lbSetData [7377, 31, "ADV_fnc_diver_medic"];
	lbSetData [7377, 32, "ADV_fnc_diver_spec"];
	//lbSetData [7377, 34, "CSW"];
};
if (side (group player) == independent) then {
	//Loadouts:
	lbSetData [7377, 1, "ADV_ind_fnc_command"];
	lbSetData [7377, 2, "ADV_ind_fnc_leader"];
	lbSetData [7377, 3, "ADV_ind_fnc_ftLeader"];
	lbSetData [7377, 4, "ADV_ind_fnc_medic"];
	lbSetData [7377, 6, "ADV_ind_fnc_lmg"];
	lbSetData [7377, 7, "ADV_ind_fnc_gren"];
	lbSetData [7377, 8, "ADV_ind_fnc_soldier"];
	lbSetData [7377, 9, "ADV_ind_fnc_soldierAT"];
	lbSetData [7377, 10, "ADV_ind_fnc_ABearer"];
	lbSetData [7377, 11, "ADV_ind_fnc_cls"];
	lbSetData [7377, 13, "ADV_ind_fnc_AR"];
	lbSetData [7377, 14, "ADV_ind_fnc_assAR"];
	lbSetData [7377, 15, "ADV_ind_fnc_AT"];
	lbSetData [7377, 16, "ADV_ind_fnc_assAT"];
	lbSetData [7377, 17, "ADV_ind_fnc_AA"];
	lbSetData [7377, 18, "ADV_ind_fnc_assAA"];
	lbSetData [7377, 20, "ADV_ind_fnc_spec"];
	lbSetData [7377, 21, "ADV_ind_fnc_marksman"];
	lbSetData [7377, 22, "ADV_ind_fnc_uavOp"];
	lbSetData [7377, 24, "ADV_ind_fnc_log"];
	lbSetData [7377, 25, "ADV_ind_fnc_driver"];
	lbSetData [7377, 26, "ADV_ind_fnc_pilot"];
	lbSetData [7377, 28, "ADV_ind_fnc_sniper"];
	lbSetData [7377, 29, "ADV_ind_fnc_spotter"];
	lbSetData [7377, 30, "ADV_ind_fnc_diver"];
	lbSetData [7377, 31, "ADV_ind_fnc_diver_medic"];
	lbSetData [7377, 32, "ADV_ind_fnc_diver_spec"];
};
if (side (group player) == east) then {
	//Loadouts:
	lbSetData [7377, 1, "ADV_opf_fnc_command"];
	lbSetData [7377, 2, "ADV_opf_fnc_leader"];
	lbSetData [7377, 3, "ADV_opf_fnc_ftLeader"];
	lbSetData [7377, 4, "ADV_opf_fnc_medic"];
	lbSetData [7377, 6, "ADV_opf_fnc_lmg"];
	lbSetData [7377, 7, "ADV_opf_fnc_gren"];
	lbSetData [7377, 8, "ADV_opf_fnc_soldier"];
	lbSetData [7377, 9, "ADV_opf_fnc_soldierAT"];
	lbSetData [7377, 10, "ADV_opf_fnc_ABearer"];
	lbSetData [7377, 11, "ADV_opf_fnc_cls"];
	lbSetData [7377, 13, "ADV_opf_fnc_AR"];
	lbSetData [7377, 14, "ADV_opf_fnc_assAR"];
	lbSetData [7377, 15, "ADV_opf_fnc_AT"];
	lbSetData [7377, 16, "ADV_opf_fnc_assAT"];
	lbSetData [7377, 17, "ADV_opf_fnc_AA"];
	lbSetData [7377, 18, "ADV_opf_fnc_assAA"];
	lbSetData [7377, 20, "ADV_opf_fnc_spec"];
	lbSetData [7377, 21, "ADV_opf_fnc_marksman"];
	lbSetData [7377, 22, "ADV_opf_fnc_uavOp"];
	lbSetData [7377, 24, "ADV_opf_fnc_log"];
	lbSetData [7377, 25, "ADV_opf_fnc_driver"];
	lbSetData [7377, 26, "ADV_opf_fnc_pilot"];
	lbSetData [7377, 28, "ADV_opf_fnc_sniper"];
	lbSetData [7377, 29, "ADV_opf_fnc_spotter"];
	lbSetData [7377, 30, "ADV_opf_fnc_diver"];
	lbSetData [7377, 31, "ADV_opf_fnc_diver_medic"];
	lbSetData [7377, 32, "ADV_opf_fnc_diver_spec"];
};

if (true) exitWith {};