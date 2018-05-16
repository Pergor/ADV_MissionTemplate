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
_par_logisticTeam = missionNamespace getVariable ["ADV_par_logisticTeam",1];
_par_logisticAmount = missionNamespace getVariable ["adv_par_logisticAmount",99];

// LBs leeren
lbClear _listBox;
lbClear _comboBox;

//Loadout-Liste:
_loadoutList = [
	"Infanterie-Munition"
	,"MMG-Munition"
	,"AT-Raketen"
	,"AA-Raketen"
	,"Granaten"
	,"Medic-Kiste"
	,"Support-Kiste"
	,"EOD-Kiste"
];
if ( missionNamespace getVariable ["ace_mk6mortar_useAmmoHandling",false] ) then {
	_loadoutList append ["Mörsergranaten-Kiste"];
};
_loadoutList append [
	"Leere Kiste"
	,"Leere Slingloading-Kiste"
	,""
	,"Kisten in der Nähe löschen"
	,""
];
if (isClass(configFile >> "CfgPatches" >> "ace_repair")) then {
	_loadoutList append ["Ersatzreifen","Ersatzkette"];
};
if ( _par_logisticAmount > 2 ) then {
	_loadoutList append ["Fahrzeuginventar auffrischen"];
};
switch ( _par_logisticTeam ) do {
	case 1: { _loadoutList append ["","Fire Team-Kiste"]; };
	case 2: { _loadoutList append ["","Slingloading-Ausrüstungskiste"]; };
	case 3: { _loadoutList append ["","Fire Team-Kiste","Slingloading-Ausrüstungskiste"]; };
	case 4: { _loadoutList append ["","Ausrüstungs-Drohne","Sanitäts-Drohne"]; };
	case 5: { _loadoutList append ["","Fire Team-Kiste","Slingloading-Ausrüstungskiste","Ausrüstungs-Drohne","Sanitäts-Drohne"]; };
	default { _loadoutList append [""] };
};
if ( isClass(configFile >> "CfgPatches" >> "scorch_invitems") || isClass(configFile >> "CfgPatches" >> "murshun_cigs") ) then {
	_loadoutList append ["Rations-Kiste"];
};

{ lbAdd [7377, _x] } foreach _loadoutList;

//Loadouts:
lbSetData [7377, 0, "ADV_LOGISTIC_CRATENORMAL"];
lbSetData [7377, 1, "ADV_LOGISTIC_CRATEMG"];
lbSetData [7377, 2, "ADV_LOGISTIC_CRATEAT"];
lbSetData [7377, 3, "ADV_LOGISTIC_CRATEAA"];
lbSetData [7377, 4, "ADV_LOGISTIC_CRATEGRENADES"];
lbSetData [7377, 5, "ADV_LOGISTIC_CRATEMEDIC"];
lbSetData [7377, 6, "ADV_LOGISTIC_CRATESUPPORT"];
lbSetData [7377, 7, "ADV_LOGISTIC_CRATEEOD"];
_lbSetDataCount = 7;
if ( missionNamespace getVariable ["ace_mk6mortar_useAmmoHandling",false] ) then {
	_lbSetDataCount = _lbSetDataCount+1;
	lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATESHELLS"];
};
_lbSetDataCount = _lbSetDataCount+1;
lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATEEMPTY"];
_lbSetDataCount = _lbSetDataCount+1;
lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATELARGEEMPTY"];
_lbSetDataCount = _lbSetDataCount+1;
lbSetData [7377, _lbSetDataCount, "ADV_FNC_NIL"];
_lbSetDataCount = _lbSetDataCount+1;
lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATEDELETE"];
_lbSetDataCount = _lbSetDataCount+1;
lbSetData [7377, _lbSetDataCount, "ADV_FNC_NIL"];
if (isClass(configFile >> "CfgPatches" >> "ace_repair")) then {
	_lbSetDataCount = _lbSetDataCount+1;
	lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_WHEEL"];
	_lbSetDataCount = _lbSetDataCount+1;
	lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_TRACK"];	
};
if ( _par_logisticAmount > 2 ) then {
	_lbSetDataCount = _lbSetDataCount+1;
	lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_VEHICLE"];
};
switch ( _par_logisticTeam ) do {
	case 1: {
		_lbSetDataCount = _lbSetDataCount+1;
		lbSetData [7377, _lbSetDataCount, "ADV_FNC_NIL"];
		_lbSetDataCount = _lbSetDataCount+1;
		lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATETEAM"];
	};
	case 2: {
		_lbSetDataCount = _lbSetDataCount+1;
		lbSetData [7377, _lbSetDataCount, "ADV_FNC_NIL"];		
		_lbSetDataCount = _lbSetDataCount+1;
		lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATELARGE"];
	};
	case 3: {
		_lbSetDataCount = _lbSetDataCount+1;
		lbSetData [7377, _lbSetDataCount, "ADV_FNC_NIL"];
		_lbSetDataCount = _lbSetDataCount+1;
		lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATETEAM"];
		_lbSetDataCount = _lbSetDataCount+1;
		lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATELARGE"]; 
	};
	case 4: {
		_lbSetDataCount = _lbSetDataCount+1;
		lbSetData [7377, _lbSetDataCount, "ADV_FNC_NIL"];
		_lbSetDataCount = _lbSetDataCount+1;
		lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATEDRONE"];
		_lbSetDataCount = _lbSetDataCount+1;
		lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATEDRONE_MEDIC"];
	};
	case 5: {
		_lbSetDataCount = _lbSetDataCount+1;
		lbSetData [7377, _lbSetDataCount, "ADV_FNC_NIL"];
		_lbSetDataCount = _lbSetDataCount+1;
		lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATETEAM"];
		_lbSetDataCount = _lbSetDataCount+1;
		lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATELARGE"]; 
		_lbSetDataCount = _lbSetDataCount+1;
		lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATEDRONE"];
		_lbSetDataCount = _lbSetDataCount+1;
		lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATEDRONE_MEDIC"];
	};
	default {
		_lbSetDataCount = _lbSetDataCount+1;
		lbSetData [7377, _lbSetDataCount, "ADV_FNC_NIL"];	
	};
};
if (isClass(configFile >> "CfgPatches" >> "scorch_invitems")) then {
	_lbSetDataCount = _lbSetDataCount+1;
	lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATESTUFF"];
};

true;