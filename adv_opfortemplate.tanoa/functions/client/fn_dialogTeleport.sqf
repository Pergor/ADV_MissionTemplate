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
private _teleportList = [
	"Teleport zu Gruppe"
	/*
	"",
	"Teleport zum Zugführer"
	*/
];

{ lbAdd [7377, _x] } foreach _teleportList;

if (side (group player) == west) then {
	//Loadouts:
	lbSetData [7377, 0, "TELEPORT_GROUP"];
	//lbSetData [7377, 2, "TELEPORT_COMMAND"];
};

if (true) exitWith {};