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
	,""
	,"Teleport zum Zugführer"
];

if ( missionNamespace getVariable ["ADV_par_moveMarker",2] > 1 ) then {
	_teleportList append [
		""
		,"Fallschirmsprung"
	];
	if ( player == leader (group player) ) then {
		_teleportList append [
			""
			,"Fallschirmsprung (Gruppe)"
		];
	};
};

{ lbAdd [7377, _x] } foreach _teleportList;

//Teleports:
lbSetData [7377, 0, "TELEPORT_GROUP"];
lbSetData [7377, 2, "TELEPORT_COMMAND"];

if ( missionNamespace getVariable ["ADV_par_moveMarker",2] > 1 ) then {
	lbSetData [7377, 4, "PARAJUMP"];
	if ( player == leader (group player) ) then {
		lbSetData [7377, 6, "PARAJUMP_GROUP"];
	};
};

true;