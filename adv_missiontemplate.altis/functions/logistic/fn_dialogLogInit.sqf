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
	"MMG-Kiste",
	"AT-Kiste",
	"AA-Kiste",
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
lbSetData [7377, 8, "ADV_LOGISTIC_CRATEEMPTY"];
lbSetData [7377, 9, "ADV_FNC_NIL"];
lbSetData [7377, 10, "ADV_LOGISTIC_CRATEDELETE"];
lbSetData [7377, 11, "ADV_FNC_NIL"];
_lbSetDataCount = 11;
switch ( ADV_par_logisticTeam ) do {
	case 1: { _lbSetDataCount = _lbSetDataCount+1; lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATETEAM"]; };
	case 2: { _lbSetDataCount = _lbSetDataCount+1; lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATELARGE"]; };
	case 3: {
		_lbSetDataCount = _lbSetDataCount+1; lbSetData [7377, _lbSetDataCount, "ADV_LOGISTIC_CRATETEAM"];
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