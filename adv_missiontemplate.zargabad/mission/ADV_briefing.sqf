/*
 * Author: Belbo
 *
 * Contains the regular briefing entries.
 * Utilizes fhq_tt-functions (more information available in the readme-folder).
 * For inserting a marker: <marker name='MARKER'>TEXT</marker>
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call adv_fnc_briefing;
 *
 * Public: No
 */

private _background = ["Hintergrund",
		"Was bisher geschah..."];
private _mission = ["Missionsziel",
		"Was wir vorhaben..."];
private _execution = ["Vorgehen",
		"Wie wir das machen..."];
private _assets = ["erwartete Feindstärke",
		"Und dabei nach Möglichkeit niemanden zu hart gängeln. Das macht doch sonst keinen Spaß.<br/> Und darauf kommt es doch an."];
private _ROEs = ["Rules Of Engagement",
		"- Die Schusswaffe darf nur nach positiver Identifizierung des Ziels (positive ID) gebraucht werden. Der Gruppenführer erteilt die Schussfreigabe.
		<br/>- Ohne vorherigen Anruf ist der Schusswaffengebrauch nur zulässig, wenn er das einzige Mittel ist, um unmittelbare Gefahr für Leib und Leben abzuwehren.
		<br/>- Der Gebrauch der Schusswaffe ist verboten, wenn er erkennbar Unbeteiligte mit hoher Wahrscheinlichkeit gefährdet.
		<br/>- Der Gebrauch der Schusswaffe ist verboten, wenn er sich gegen flüchtende Personen richtet, die erkennbar von ihrem Angriff abgelassen haben.
		<br/>- Militärische Gewalt darf gegen feindselige Kräfte eingesetzt werden, wenn diese die Durchführung des Auftrags behindern."];

///////////// Don't edit below this line if you don't know what you're doing. /////////////
private _par_respWithGear = if ( (missionNamespace getVariable ["adv_par_respWithGear",["param_respWithGear",2] call BIS_fnc_getParamValue]) isEqualTo 1 ) then {
	"<br/><br/>- Wenn ihr etwas an eurer Ausrüstung geändert habt, solltet ihr an den Kisten am Start ""Save gear"" auswählen!"
} else {""};
private _par_moveMarker = ["param_moveMarker",2] call BIS_fnc_getParamValue;
private _respawnHandling = switch _par_moveMarker do {
	case 0: { "Fester Respawn." };
	case 1: { "Teleport zum Gruppenführer/Zugführer über Flagge am Start." };
	case 3: { "Der Respawn-Punkt wird alle 120 Sekunden nachgezogen." };
	case 99: { "Kein Respawn." };
	default { "Teleport zum Gruppenführer über Flagge am Start.
		<br/>Es steht alternativ auch Fallschirmabwurf zur Verfügung. Nur für Gruppenführer ist es möglich, einen Fallschirmabwurf für die ganze Gruppe auszuwählen. (Vorsicht, alle Gruppenmitglieder werden per Fallschirm abgeworfen!)" };
};
private _ace_reviveTime = format ["%1",(["ace_medical_maxReviveTime",1200] call BIS_fnc_getParamValue)/60];
private _ace_PAKLocation = switch ( missionNamespace getVariable ["ace_medical_useLocation_PAK",0] ) do {
	case 1: {"nur in Sanitätsfahrzeugen"};
	case 2: {"nur im Lazarett"};
	case 3: {"nur in Sanitätsfahrzeugen oder im Lazarett"};
	default {"überall"};
};
private _ace_advancedWounds = if ( (["ace_medical_enableAdvancedWounds",0] call BIS_fnc_getParamValue) isEqualTo 0 ) then {
	"öffnen sich nicht."
} else {
	"müssen vernäht werden."
};
private _param_advancedFatigue = missionNamespace getVariable ["ace_advanced_fatigue_enabled",1];
private _ace_advancedFatigue = switch _param_advancedFatigue do {
	case 0: { "Standard-Ausdauersystem" };
	default { "ACE-Advanced-Ausdauersystem" };
};
private _ace_repairLocation = switch ( missionNamespace getVariable ["ace_repair_fullRepairLocation",0] ) do {
	case 1: {"nur mit Reparaturfahrzeug"};
	case 2: {"nur in der Basis"};
	case 3: {"nur mit Reparaturfahrzeug oder in der Basis"};
	default {"überall"};
};
[
	{true},
		_background,
		_mission,
		_execution,
		_assets,
		_ROEs,
		["Hinweise zur Mission",
			("Vor dem Aufbruch nicht vergessen:
			") + _par_respWithGear + ("
			<br/><br/>- ") + _respawnHandling + ("
			<br/><br/>- Revive-Zeit: ") + _ace_reviveTime + (" Minuten.
			<br/>- Revive durch PAK ist ") + _ace_pakLocation + (" möglich.
			<br/>- Wunden ") + _ace_advancedWounds + ("
			<br/>- Es wird das ") + _ace_advancedFatigue + (" verwendet.
			<br/><br/>- Reparatur nur für Pioniere und Logistiker mit Werkzeugkasten.
			<br/>- Vollständige Reparatur ist für Pioniere und Logistiker ") + _ace_repairLocation + (" moglich.
			<br/>- Bei Sprengmittelentschärfung besteht auch durch Pioniere ein Restrisiko.
			<br/><br/>- Wenn ihr technische Schwierigkeiten habt, schreibt bitte ausschließlich den Spiel-Admin an (rotes Icon im TS).
			<br/>- Bitte haltet euch zurück mit out-of-character-Gesprächen. Die anderen Spielerinnen und Spieler werden es euch danken.")]
] call FHQ_TT_addBriefing;
if ( isClass (configFile >> "CfgPatches" >> "task_force_radio") ) exitWith {
	[
		west,
		[
			"FUNKFREQUENZEN",
			"Frequenzen",
			"Funkfrequenzen:
			<br/><br/>Shortrange-Funkgeräte:
			<br/>Jupiter: SW CH1 41.0 MHz
			<br/>Mars: SW CH2 42.0 MHz
			<br/>Deimos: SW CH3 43.0 MHz
			<br/>Phobos: SW CH4 44.0 MHz
			<br/>Vulkan: SW CH5 45.0 MHz
			<br/>Merkur, Apollo, Saturn, Diana nach Absprache.
			<br/><br/>Longrange-Funkgeräte:
			<br/>Convoyfunk: LR CH1 51.0 MHz
			<br/>Kampfkreis: LR CH2 52.0 MHz
			<br/>Einsatzunterstützung: LR CH7 57.0 MHz
			<br/>Logistik: LR CH8 58.0 MHz
			<br/>OPZ/Zeus: LR CH9 59.0 MHz
			"
		],
		east,
		[
			"FUNKFREQUENZEN",
			"Frequenzen",
			"Funkfrequenzen:
			<br/><br/>Shortrange-Funkgeräte:
			<br/>Milan: SW CH1 41.0 MHz
			<br/>Adler: SW CH2 42.0 MHz
			<br/>Bussard: SW CH3 43.0 MHz
			<br/>Condor: SW CH4 44.0 MHz
			<br/>Drossel: SW CH5 45.0 MHz
			<br/>Elster, Falke, Greif, Habicht nach Absprache.
			<br/><br/>Longrange-Funkgeräte:
			<br/>Convoyfunk: LR CH1 51.0 MHz
			<br/>Kampfkreis: LR CH2 52.0 MHz
			<br/>Einsatzunterstützung: LR CH7 57.0 MHz
			<br/>Logistik: LR CH8 58.0 MHz
			<br/>OPZ/Zeus: LR CH9 59.0 MHz
			"
		],
		independent,
		[
			"FUNKFREQUENZEN",
			"Frequenzen",
			"Funkfrequenzen:
			<br/><br/>Shortrange-Funkgeräte:
			<br/>Natter: SW CH1 61.0 MHz
			<br/>Anakonda: SW CH2 62.0 MHz
			<br/>Boa: SW CH3 63.0 MHz
			<br/>Cobra: SW CH4 64.0 MHz
			<br/>Viper, Drache nach Absprache.
			<br/><br/>Longrange-Funkgeräte:
			<br/>Convoyfunk: LR CH1 71.0 MHz
			<br/>Kampfkreis: LR CH2 72.0 MHz
			<br/>Einsatzunterstützung: LR CH7 77.0 MHz
			<br/>Logistik: LR CH8 78.0 MHz
			<br/>OPZ/Zeus: LR CH9 79.0 MHz	
			"
		]
	] call FHQ_TT_addBriefing;
};
if ( isClass (configFile >> "CfgPatches" >> "acre_main") ) exitWith {
	[
		west,
		[
			"FUNKFREQUENZEN",
			"Frequenzen",
			"Funkfrequenzen:
			<br/><br/>AN/PRC-343:
			<br/>Jupiter: CH1
			<br/>Mars: CH2
			<br/>Deimos: CH3
			<br/>Phobos: CH4
			<br/>Vulkan: CH5
			<br/>Merkur: CH6
			<br/>Apollo: CH7
			<br/>Saturn: CH8
			<br/>Diana: CH9
			<br/><br/>AN/PRC-152 / AN/PRC-117F:
			<br/>Convoyfunk: CH1 - ""VEHICLES""
			<br/>Kampfkreis: CH2 - ""PLTNET 1""
			<br/>Logistik: CH3 - ""LOG""
			<br/>Aufklärung: CH4 - ""RECON""
			<br/>Luftfahrzeuge: CH5 - ""AIRNET""
			<br/>OPZ/Zeus: CH16 - ""ADMIN""
			"
		],
		east,
		[
			"FUNKFREQUENZEN",
			"Frequenzen",
			"Funkfrequenzen:
			<br/><br/>AN/PRC-343:
			<br/>Luchs: CH1
			<br/>Löwe: CH2
			<br/>Tiger: CH3
			<br/>Panther: CH4
			<br/>Leopard: CH5
			<br/>Gepard: CH6
			<br/>Orca: CH7
			<br/>Ozelot: CH8
			<br/>Jaguar: CH9
			<br/><br/>AN/PRC-148 / AN/PRC-117F:
			<br/>Convoyfunk: CH1 - ""VEHICLES""
			<br/>Kampfkreis: CH2 - ""PLTNET 1""
			<br/>Logistik: CH3 - ""LOG""
			<br/>Aufklärung: CH4 - ""RECON""
			<br/>Luftfahrzeuge: CH5 - ""AIRNET""
			<br/>OPZ/Zeus: CH16 - ""ADMIN""
			"
		],
		independent,
		[
			"FUNKFREQUENZEN",
			"Frequenzen",
			"Funkfrequenzen:
			<br/><br/>Shortrange-Funkgeräte:
			<br/>Natter: SW CH1 61MHz
			<br/>Anakonda: SW CH2 62MHz
			<br/>Boa: SW CH3 63MHz
			<br/>Cobra: SW CH4 64MHz
			<br/>Viper, Drache nach Absprache.
			<br/><br/>Longrange-Funkgeräte:
			<br/>Convoyfunk: LR CH1 71MHz
			<br/>Kampfkreis: LR CH2 72MHz
			<br/>Logistik: LR CH3 73MHz
			<br/>Aufklärung: LR CH4 74MHz
			<br/>Luftfahrzeuge: LR CH5 75MHz
			<br/>OPZ/Zeus: LR CH9 79MHz	
			"
		]
	] call FHQ_TT_addBriefing;
};

nil;