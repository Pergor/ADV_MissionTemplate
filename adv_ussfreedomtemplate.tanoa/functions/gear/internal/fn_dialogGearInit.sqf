//////////////////////////////////////////////////////////////////
// 
//LOADOUT ussf
//MADE BY Raspu
// 
//////////////////////////////////////////////////////////////////

//mission variables and parameters:
private [
	"_par_customWeap","_par_opfWeap","_par_indWeap","_par_customUni","_par_indUni","_par_opfUni","_par_NVGs","_par_opfNVGs","_par_optics","_par_opfOptics","_par_Silencers","_par_opfSilencers"
	,"_par_tablets","_par_radios","_par_TIEquipment","_par_ace_medical_GivePAK","_var_aridMaps","_var_saridMaps","_var_lushMaps","_var_europeMaps","_par_invinciZeus","_par_customLoad","_par_logisticAmount"
	,"_loadoutVariables"
];
if (isNil "_loadoutVariables") then {call adv_fnc_loadoutVariables;};

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
	,"---- Mannschaftsloadouts ----"
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
	,"EOD"
	,"Zielfernrohrschütze"
	,"UAV-Spezialist"
	,"Jet-Pilot"
	,"---- Logistikloadouts ----"
	,"Logistiker"
	,"Repair-Spezialist"
	,"Fahrzeugbesatzung"
	,"Pilot"
	,"---- SF-Loadouts ----"
	,"Scharfschütze"
	,"Beobachter"
	,"Taucher"
	,"Taucher (Sanitäter)"
	,"Taucher (Pionier)"
	,"---- CSW-Loadouts ----"
	,"HMG-Schütze"
	,"asst. HMG-Schütze"
	,"Mörserschütze"
	,"asst. Mörserschütze"
	,"TOW-Schütze"
	,"asst. TOW-Schütze"
	
];
if (side (group player) isEqualTo east) then {
	_loadoutList set [1,"Sektionsführer"];
	_loadoutList set [8,"Soldat"];
	_loadoutList set [9,"Soldat (RPG)"];
};
if (side (group player) isEqualTo independent) then {

};
if ( side (group player) isEqualTo west ) then {
	if ( _par_customWeap in [5,6,7] ) then {
		_loadoutList set [17,"AA-Spezialist (nicht nachladbar)"];
		_loadoutList set [18,"AA-Spezialist (nicht nachladbar)"];
	};
	if ( _par_customWeap isEqualTo 1 ) then {
		_loadoutList set [9,"Schütze (Pzf3)"];
		_loadoutList set [15,"Schütze (Pzf3)"];
		_loadoutList set [16,"Schütze (RGW90)"];
		_loadoutList set [17,"Luftabwehrschütze"];
		_loadoutList set [18,"asst. Luftabwehrschütze"];
	};
};

{ lbAdd [7377, _x]; nil; } count _loadoutList;

lbSetData [7377, 0, ""];
lbSetData [7377, 5, ""];
lbSetData [7377, 12, ""];
lbSetData [7377, 19, ""];
lbSetData [7377, 25, ""];
lbSetData [7377, 30, ""];
lbSetData [7377, 36, ""];
if (side (group player) isEqualTo civilian) then {
	_loadoutList = [
		"Zivilist"
		,"Techniker"
		,"Pilot"
		,"Arzt"
		,"Polizist"
		,"Taucher"
		,"Reporter"
	];
};
if (side (group player) isEqualTo west) then {
	//Loadouts:
	lbSetData [7377, 1, "['ADV_FNC_COMMAND','']"];
	lbSetData [7377, 2, "['ADV_FNC_LEADER','']"];
	lbSetData [7377, 3, "['ADV_FNC_FTLEADER','']"];
	lbSetData [7377, 4, "['ADV_FNC_MEDIC','']"];
	lbSetData [7377, 6, "['ADV_FNC_LMG','']"];
	lbSetData [7377, 7, "['ADV_FNC_GREN','']"];
	lbSetData [7377, 8, "['ADV_FNC_SOLDIER','']"];
	lbSetData [7377, 9, "['ADV_FNC_SOLDIER','AT']"];
	lbSetData [7377, 10, "['ADV_FNC_ABEARER','']"];
	lbSetData [7377, 11, "['ADV_FNC_CLS','']"];
	lbSetData [7377, 13, "['ADV_FNC_AR','']"];
	lbSetData [7377, 14, "['ADV_FNC_ASSAR','']"];
	lbSetData [7377, 15, "['ADV_FNC_AT','AT']"];
	lbSetData [7377, 16, "['ADV_FNC_ASSAT','']"];
	lbSetData [7377, 17, "['ADV_FNC_AT','AA']"];
	lbSetData [7377, 18, "['ADV_FNC_ASSAA','']"];
	lbSetData [7377, 20, "['ADV_FNC_SPEC','']"];
	lbSetData [7377, 21, "['ADV_FNC_SPEC','EOD']"];
	lbSetData [7377, 22, "['ADV_FNC_MARKSMAN','']"];
	lbSetData [7377, 23, "['ADV_FNC_UAVOP','']"];
	lbSetData [7377, 24, "['ADV_FNC_JETPILOT','']"];
	lbSetData [7377, 26, "['ADV_FNC_LOG','']"];
	lbSetData [7377, 27, "['ADV_FNC_SPEC','REPAIR']"];
	lbSetData [7377, 28, "['ADV_FNC_DRIVER','']"];
	lbSetData [7377, 29, "['ADV_FNC_PILOT','']"];
	lbSetData [7377, 31, "['ADV_FNC_SNIPER','']"];
	lbSetData [7377, 32, "['ADV_FNC_SPOTTER','']"];
	lbSetData [7377, 33, "['ADV_FNC_DIVER','']"];
	lbSetData [7377, 34, "['ADV_FNC_DIVER_MEDIC','']"];
	lbSetData [7377, 35, "['ADV_FNC_DIVER_SPEC','']"];
	lbSetData [7377, 37, "['ADV_FNC_FTLEADER','CSW']"];
	lbSetData [7377, 38, "['ADV_FNC_FTLEADER','ACSW']"];
	lbSetData [7377, 39, "['ADV_FNC_FTLEADER','MORTAR']"];
	lbSetData [7377, 40, "['ADV_FNC_FTLEADER','AMORTAR']"];
	lbSetData [7377, 41, "['ADV_FNC_FTLEADER','TOW']"];
	lbSetData [7377, 42, "['ADV_FNC_FTLEADER','ATOW']"];
};
if (side (group player) isEqualTo independent) then {
	lbSetData [7377, 1, "['ADV_IND_FNC_COMMAND','']"];
	lbSetData [7377, 2, "['ADV_IND_FNC_LEADER','']"];
	lbSetData [7377, 3, "['ADV_IND_FNC_FTLEADER','']"];
	lbSetData [7377, 4, "['ADV_IND_FNC_MEDIC','']"];
	lbSetData [7377, 6, "['ADV_IND_FNC_LMG','']"];
	lbSetData [7377, 7, "['ADV_IND_FNC_GREN','']"];
	lbSetData [7377, 8, "['ADV_IND_FNC_SOLDIER','']"];
	lbSetData [7377, 9, "['ADV_IND_FNC_SOLDIER','AT']"];
	lbSetData [7377, 10, "['ADV_IND_FNC_ABEARER','']"];
	lbSetData [7377, 11, "['ADV_IND_FNC_CLS','']"];
	lbSetData [7377, 13, "['ADV_IND_FNC_AR','']"];
	lbSetData [7377, 14, "['ADV_IND_FNC_ASSAR','']"];
	lbSetData [7377, 15, "['ADV_IND_FNC_AT','AT']"];
	lbSetData [7377, 16, "['ADV_IND_FNC_ASSAT','']"];
	lbSetData [7377, 17, "['ADV_IND_FNC_AT','AA']"];
	lbSetData [7377, 18, "['ADV_IND_FNC_ASSAA','']"];
	lbSetData [7377, 20, "['ADV_IND_FNC_SPEC','']"];
	lbSetData [7377, 21, "['ADV_IND_FNC_SPEC','EOD']"];
	lbSetData [7377, 22, "['ADV_IND_FNC_MARKSMAN','']"];
	lbSetData [7377, 23, "['ADV_IND_FNC_UAVOP','']"];
	lbSetData [7377, 24, "['ADV_IND_FNC_JETPILOT','']"];
	lbSetData [7377, 26, "['ADV_IND_FNC_LOG','']"];
	lbSetData [7377, 27, "['ADV_IND_FNC_SPEC','REPAIR']"];
	lbSetData [7377, 28, "['ADV_IND_FNC_DRIVER','']"];
	lbSetData [7377, 29, "['ADV_IND_FNC_PILOT','']"];
	lbSetData [7377, 31, "['ADV_IND_FNC_SNIPER','']"];
	lbSetData [7377, 32, "['ADV_IND_FNC_SPOTTER','']"];
	lbSetData [7377, 33, "['ADV_IND_FNC_DIVER','']"];
	lbSetData [7377, 34, "['ADV_IND_FNC_DIVER_MEDIC','']"];
	lbSetData [7377, 35, "['ADV_IND_FNC_DIVER_SPEC','']"];
	lbSetData [7377, 37, "['ADV_IND_FNC_FTLEADER','CSW']"];
	lbSetData [7377, 38, "['ADV_IND_FNC_FTLEADER','ACSW']"];
	lbSetData [7377, 39, "['ADV_IND_FNC_FTLEADER','MORTAR']"];
	lbSetData [7377, 40, "['ADV_IND_FNC_FTLEADER','AMORTAR']"];
	lbSetData [7377, 41, "['ADV_IND_FNC_FTLEADER','TOW']"];
	lbSetData [7377, 42, "['ADV_IND_FNC_FTLEADER','ATOW']"];
};
if (side (group player) isEqualTo east) then {
	lbSetData [7377, 1, "['ADV_OPF_FNC_COMMAND','']"];
	lbSetData [7377, 2, "['ADV_OPF_FNC_LEADER','']"];
	lbSetData [7377, 3, "['ADV_OPF_FNC_FTLEADER','']"];
	lbSetData [7377, 4, "['ADV_OPF_FNC_MEDIC','']"];
	lbSetData [7377, 6, "['ADV_OPF_FNC_LMG','']"];
	lbSetData [7377, 7, "['ADV_OPF_FNC_GREN','']"];
	lbSetData [7377, 8, "['ADV_OPF_FNC_SOLDIER','']"];
	lbSetData [7377, 9, "['ADV_OPF_FNC_SOLDIER','AT']"];
	lbSetData [7377, 10, "['ADV_OPF_FNC_ABEARER','']"];
	lbSetData [7377, 11, "['ADV_OPF_FNC_CLS','']"];
	lbSetData [7377, 13, "['ADV_OPF_FNC_AR','']"];
	lbSetData [7377, 14, "['ADV_OPF_FNC_ASSAR','']"];
	lbSetData [7377, 15, "['ADV_OPF_FNC_AT','AT']"];
	lbSetData [7377, 16, "['ADV_OPF_FNC_ASSAT','']"];
	lbSetData [7377, 17, "['ADV_OPF_FNC_AT','AA']"];
	lbSetData [7377, 18, "['ADV_OPF_FNC_ASSAA','']"];
	lbSetData [7377, 20, "['ADV_OPF_FNC_SPEC','']"];
	lbSetData [7377, 21, "['ADV_OPF_FNC_SPEC','EOD']"];
	lbSetData [7377, 22, "['ADV_OPF_FNC_MARKSMAN','']"];
	lbSetData [7377, 23, "['ADV_OPF_FNC_UAVOP','']"];
	lbSetData [7377, 24, "['ADV_OPF_FNC_JETPILOT','']"];
	lbSetData [7377, 26, "['ADV_OPF_FNC_LOG','']"];
	lbSetData [7377, 27, "['ADV_OPF_FNC_SPEC','REPAIR']"];
	lbSetData [7377, 28, "['ADV_OPF_FNC_DRIVER','']"];
	lbSetData [7377, 29, "['ADV_OPF_FNC_PILOT','']"];
	lbSetData [7377, 31, "['ADV_OPF_FNC_SNIPER','']"];
	lbSetData [7377, 32, "['ADV_OPF_FNC_SPOTTER','']"];
	lbSetData [7377, 33, "['ADV_OPF_FNC_DIVER','']"];
	lbSetData [7377, 34, "['ADV_OPF_FNC_DIVER_MEDIC','']"];
	lbSetData [7377, 35, "['ADV_OPF_FNC_DIVER_SPEC','']"];
	lbSetData [7377, 37, "['ADV_OPF_FNC_FTLEADER','CSW']"];
	lbSetData [7377, 38, "['ADV_OPF_FNC_FTLEADER','ACSW']"];
	lbSetData [7377, 39, "['ADV_OPF_FNC_FTLEADER','MORTAR']"];
	lbSetData [7377, 40, "['ADV_OPF_FNC_FTLEADER','AMORTAR']"];
	lbSetData [7377, 41, "['ADV_OPF_FNC_FTLEADER','TOW']"];
	lbSetData [7377, 42, "['ADV_OPF_FNC_FTLEADER','ATOW']"];
};
if (side (group player) isEqualTo civilian) then {
	//Loadouts:
	lbSetData [7377, 0, "['ADV_FNC_CIV','']"];
	lbSetData [7377, 1, "['ADV_FNC_CIVENGINEER','']"];
	lbSetData [7377, 2, "['ADV_FNC_CIVPILOT','']"];
	lbSetData [7377, 3, "['ADV_FNC_CIVDOC','']"];
	lbSetData [7377, 4, "['ADV_FNC_CIVPOLICE','']"];
	lbSetData [7377, 5, "['ADV_FNC_CIVDIVER','']"];
	lbSetData [7377, 6, "['ADV_FNC_CIVPRESS','']"];
};

true;