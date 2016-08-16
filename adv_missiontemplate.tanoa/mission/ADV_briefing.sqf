/*
adv_briefing.sqf

Add your mission briefing here.

For inserting a marker: <marker name='MARKER'>TEXT</marker>
*/
private _hintergrund = ["Hintergrund",
		"Was bisher geschah..."];
private _missionsziel = ["Missionsziel",
		"Was wir vorhaben..."];
private _vorgehen = ["Vorgehen",
		"Wie wir das machen..."];
private _feindstaerke = ["erwartete Feindstärke",
		"Und dabei nach Möglichkeit niemanden zu hart gängeln. Das macht doch sonst keinen Spaß.<br/> Und darauf kommt es doch an."];

///////////// Don't edit below this line if you don't know what you're doing. /////////////
private _param_moveMarker = ["param_moveMarker",2] call BIS_fnc_getParamValue;
private _respawnHandling = switch _param_moveMarker do {
	case 0: { "Fester Respawn" };
	case 1: { "Der Respawn-Punkt wird alle 120 Sekunden nachgezogen" };
	case 99: { "Kein Respawn" };
	default { "Teleport zum Gruppenführer über Flagge am Start" };
};
private _ace_reviveTime = format ["%1",(["ace_medical_maxReviveTime",1200] call BIS_fnc_getParamValue)/60];
private _ace_advancedWounds = if ( (["ace_medical_enableAdvancedWounds",0] call BIS_fnc_getParamValue) isEqualTo 0 ) then {
	"Wunden öffnen sich nicht"
} else {
	"Wunden müssen vernäht werden"
};
[
	{true},
		_hintergrund,
		_missionsziel,
		_vorgehen,
		_feindstaerke,
		["Hinweise zur Mission",
			("Vor dem Aufbruch nicht vergessen:
			<br/><br/>- Wenn ihr etwas an eurer Ausrüstung geändert habt, solltet ihr an den Kisten am Start ""Save gear"" auswählen!
			<br/>- ") + _respawnHandling + (".
			<br/>- Revive-Zeit: ") + _ace_reviveTime + (" Minuten.
			<br/>- Revive durch PAK überall.
			<br/>- ") + _ace_advancedWounds + (".
			<br/>- Reparatur nur für Pioniere und Logistiker mit Werkzeugkasten.
			<br/>- Bei Sprengmittelentschärfung besteht ein Restrisiko.
			<br/><br/>- Wenn ihr technische Schwierigkeiten habt, schreibt bitte ausschließlich den Spiel-Admin an (rotes Icon im TS).
			<br/>- Bitte haltet euch zurück mit out-of-character-Gesprächen. Die anderen Spielerinnen und Spieler werden es euch danken.")]
] call FHQ_TT_addBriefing;

if (true) exitWith {};