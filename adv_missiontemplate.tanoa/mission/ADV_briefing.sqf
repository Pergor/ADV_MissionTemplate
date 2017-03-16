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
private _param_advancedFatigue = ["ace_advanced_fatigue_enabled",0] call BIS_fnc_getParamValue;
private _ace_advancedFatigue = switch _param_advancedFatigue do {
	case 0: { "Das Standard-Ausdauersystem wird verwendet" };
	default { "Das ACE-Advanced-Ausdauersystem wird verwendet" };
};
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
			<br/>- ") + _ace_advancedFatigue + (".
			<br/>- Reparatur nur für Pioniere und Logistiker mit Werkzeugkasten.
			<br/>- Bei Sprengmittelentschärfung besteht ein Restrisiko.
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
			<br/>Jupiter: SW CH1 41MHz
			<br/>Mars: SW CH2 42MHz
			<br/>Deimos: SW CH3 43MHz
			<br/>Phobos: SW CH4 44MHz
			<br/>Vulkan: SW CH5 45MHz
			<br/>Merkur, Apollo, Saturn, Diana nach Absprache.
			<br/><br/>Longrange-Funkgeräte:
			<br/>Convoyfunk: LR CH1 51MHz
			<br/>Kampfkreis: LR CH2 52MHz
			<br/>Einsatzunterstützung: LR CH7 57MHz
			<br/>Logistik: LR CH8 58MHz
			<br/>OPZ/Zeus: LR CH9 59MHz
			"
		],
		east,
		[
			"FUNKFREQUENZEN",
			"Frequenzen",
			"Funkfrequenzen:
			<br/><br/>Shortrange-Funkgeräte:
			<br/>Milan: SW CH1 41MHz
			<br/>Adler: SW CH2 42MHz
			<br/>Bussard: SW CH3 43MHz
			<br/>Condor: SW CH4 44MHz
			<br/>Drossel: SW CH5 45MHz
			<br/>Elster, Falke, Greif, Habicht nach Absprache.
			<br/><br/>Longrange-Funkgeräte:
			<br/>Convoyfunk: LR CH1 51MHz
			<br/>Kampfkreis: LR CH2 52MHz
			<br/>Einsatzunterstützung: LR CH7 57MHz
			<br/>Logistik: LR CH8 58MHz
			<br/>OPZ/Zeus: LR CH9 59MHz
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
			<br/>Einsatzunterstützung: LR CH7 77MHz
			<br/>Logistik: LR CH8 78MHz
			<br/>OPZ/Zeus: LR CH9 79MHz	
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

if (true) exitWith {};