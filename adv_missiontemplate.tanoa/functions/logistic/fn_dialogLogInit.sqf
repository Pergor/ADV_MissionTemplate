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
if (isNil "ADV_par_logisticTeam") then {ADV_par_logisticTeam = 1;};

// LBs leeren
lbClear _listBox;
lbClear _comboBox;

//Loadout-Liste:
_loadoutList = [
	"Munitions-Kiste",
	"MG-Kiste",
	"AT-Kiste",
	"Granaten-Kiste",
	"Medic-Kiste",
	"Support-Kiste",
	"EOD-Kiste",
	"Leere Kiste",
	"",
	"Kisten in der Nähe löschen",
	""
];
switch (ADV_par_logisticTeam) do {
	case 1: { _loadoutList append ["Fire Team-Kiste"]; };
	case 2: { _loadoutList append ["Slingloading-Ausrüstungskiste"]; };
	case 3: { _loadoutList append ["Fire Team-Kiste","Slingloading-Ausrüstungskiste"]; };
	default {};
};
if (isClass(configFile >> "CfgPatches" >> "ace_repair")) then {
	_loadoutList append ["Ersatzreifen","Ersatzkette"];
};
if (isClass(configFile >> "CfgPatches" >> "scorch_invitems")) then {
	_loadoutList append ["Rations-Kiste"];
};

{ lbAdd [7377, _x] } foreach _loadoutList;

//Loadouts:
lbSetData [7377, 0, "ADV_logistic_crateNormal"];
lbSetData [7377, 1, "ADV_logistic_crateMG"];
lbSetData [7377, 2, "ADV_logistic_crateAT"];
lbSetData [7377, 3, "ADV_logistic_crateGrenades"];
lbSetData [7377, 4, "ADV_logistic_crateMedic"];
lbSetData [7377, 5, "ADV_logistic_crateSupport"];
lbSetData [7377, 6, "ADV_logistic_crateEOD"];
lbSetData [7377, 7, "ADV_logistic_crateEmpty"];
lbSetData [7377, 8, "ADV_fnc_nil"];
lbSetData [7377, 9, "ADV_logistic_crateDelete"];
lbSetData [7377, 10, "ADV_fnc_nil"];
_lbSetDataCount = 10;
switch ( ADV_par_logisticTeam ) do {
	case 1: { _lbSetDataCount = _lbSetDataCount+1; lbSetData [7377, _lbSetDataCount, "ADV_logistic_crateTeam"]; };
	case 2: { _lbSetDataCount = _lbSetDataCount+1; lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATELARGE"]; };
	case 3: {
		_lbSetDataCount = _lbSetDataCount+1; lbSetData [7377, _lbSetDataCount, "ADV_logistic_crateTeam"];
		_lbSetDataCount = _lbSetDataCount+1; lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATELARGE"]; 
	};
	default {};
};
if (isClass(configFile >> "CfgPatches" >> "ace_repair")) then {
	_lbSetDataCount = _lbSetDataCount+1;
	lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_WHEEL"];
	_lbSetDataCount = _lbSetDataCount+1;
	lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_TRACK"];	
};
if (isClass(configFile >> "CfgPatches" >> "scorch_invitems")) then {
	_lbSetDataCount = _lbSetDataCount+1;
	lbSetData [7377, _lbSetDataCount, "ADV_logistic_crateStuff"];
};

if (true) exitWith {};