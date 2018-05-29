/*
 * Author: Belbo
 *
 * Contains the params and standard values for this params of the mission.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * class: name of the param class. Each parameter starting with param_ will be changed to a global variable in format adv_par_*, where * are the characters that follow param_
 * title: Title of the param shown in the MP lobby.
 * values: Numerical values that are assigned to the...
 * texts: Text that is shown for each numerical value in the alpha numeric order of the numerical values.
 * default: Default value that will be default if you start the mission without editing anything in the MP lobb. EDIT ONLY THESE!
 *
 * Public: Yes
 */

class dummy_base {
	title = "---------------------- Basis-Parameter ----------------------";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
};
class param_headlessClient
{
	title="Was für eine Art von Mission soll gespielt werden?";
	values[]  = {3,2,1,0};
	texts[] = {"Combat Patrol (wird am Briefing-Board gestartet)","UPSMON-KI","Zeus","Weder, noch."};
	default = 1;
};
class param_sideRelations
{
	title="Mit welcher Seite soll GREENFOR verbündet sein?";
	values[]  = {3,2,1,0};
	texts[] = {"Sowohl mit OPFOR, als auch mit BLUFOR","Mit OPFOR","Mit BLUFOR","Mit keiner"};
	default = 0;
};
class param_civilians
{
	title="Sollen automatisch Zivilisten gespawnt werden? (mapabhängige Zivilisten, nur server-/HC-seitig, nur in der Nähe von Spielern, werden automatisch gelöscht)";
	values[] = {3,2,1,0};
	texts[] = {"Fahrzeuge und Fußgänger","Nur Fahrzeuge","Nur Fußgänger","Nein"};
	default = 0;
};
class dummy_environment {
	title = "---------------------- Umweltparameter ----------------------";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
};
class param_hour
{
	title="Startzeit";
	values[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
	texts[] = {"0 Uhr","1 Uhr","2 Uhr","3 Uhr","4 Uhr","5 Uhr","6 Uhr","7 Uhr","8 Uhr","9 Uhr","10 Uhr","11 Uhr","12 Uhr","13 Uhr","14 Uhr","15 Uhr","16 Uhr","17 Uhr","18 Uhr","19 Uhr","20 Uhr","21 Uhr","22 Uhr","23 Uhr"};
	default = 6;
};
class param_minute
{
	title="Minuten";
	values[] = {0,10,20,30,40,50};
	texts[] = {"0 Minuten","10 Minuten","20 Minuten","30 Minuten","40 Minuten","50 Minuten"};
	default = 0;
};
class param_day
{
	title="Mondphase";
	values[] = {14,23,30,6};
	texts[] = {"Neumond","zunehmender Halbmond (sichtbar in der ersten Hälfte der Nacht)","Vollmond","abnehmender Halbmond (sichtbar in der zweiten Hälfte der Nacht)"};
	default = 23;
};
class param_randomWeather
{
	title="Dynamisches Wetter (derzeit deaktiviert)";
	values[] = {99,1,2,3,4,5,6,7,8,9};
	texts[] = {"Kein dynamisches Wetter","Klar","Bewölkt","Leichter Regen","Mittlerer Regen","Schwerer Regen","Leichter Nebel","Mittlerer Nebel","Dichter Nebel","Zufälliges Wetter"};
	default = 99;
};
class param_weather
{
	title="Dauerhaftes Wetter";
	values[] = {99,1,2,3,4,5,6,7,8,9,98};
	texts[] = {"Keine Veränderung","Sonnig","Klar","Bewölkt","Leichter Regen","Mittlerer Regen","Schwerer Regen","Leichter Nebel","Mittlerer Nebel","Dichter Nebel","Zufälliges Wetter"};
	default = 98;
};
class dummy_respawn {
	title = "---------------------- Respawn ----------------------";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
};
class param_remRespWest
{
	title="Soll der Respawn-Marker am Start nach 60 secs entfernt werden?";
	values[] = {1,0};
	texts[] = {"Ja","Nein"};
	default = 0;
};
class param_moveMarker
{
	title="Wie soll mit respawnenden oder nachzuführenden Spielern umgegangen werden?";
	values[] = {99,3,2,1,0};
	texts[] = {"Kein Respawn","Beweglicher Respawn (wird alle 120 sek. nachgezogen)","Fester Respawn (Nachführung durch Teleport, oder Fallschirmabwurf. Gruppenführern steht Fallschirmabwurf für gesamte Gruppe zur Verfügung)","Fester Respawn (Nachführung durch Teleport)","Fester Respawn"};
	default = 2;
};
class param_vehicleRespawn
{
	title="Wie hoch soll der Respawn-Timer für Fahrzeuge eingestellt werden?";
	values[] = {900,600,300,60,30,20,10,9999};
	texts[] = {"15 Minuten","10 Minuten","5 Minuten","60 Sekunden","30 Sekunden","20 Sekunden","10 Sekunden","Deaktiviert"};
	default = 300;
};
class dummy_settings_game {
	title = "---------------------- Game Settings ----------------------";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
};
class param_invinciZeus
{
	title="Soll die spielbare Zeus-Einheit unsterblich sein?";
	values[] = {1,0};
	texts[] = {"Ja","Nein"};
	default = 0;
};
class param_fatigue
{
	title="Sollen die Spieler Ausdauer verlieren können?";
	values[] = {1,0};
	texts[] = {"Ja","Nein"};
	default = 1;
};
class param_engineArtillery
{
	title="Soll der Artillerie-Computer deaktiviert werden?";
	values[] = {1,0};
	texts[] = {"Ja","Nein"};
	default = 0;
};
class param_TIEquipment
{
	title="Soll NV- und Thermal-Imaging in Fahrzeugen und statischen Waffen deaktiviert werden?";
	values[] = {
		4,3
		,2,1
		,0
	};
	texts[] = {
		"Kein NV- und Thermal-Imaging für alle Fahrzeuge & statische Waffen","Kein NV- und Thermal-Imaging für Spieler-Fahrzeuge"
		,"Kein Thermal-Imaging für alle Fahrzeuge & statische Waffen","Kein Thermal-Imaging für Spieler-Fahrzeuge"
		,"Nein"
	};
	default = 0;
};
class param_l_suppress
{
	title="Soll Laxemans Suppression-Script aktiviert werden?";
	values[] = {1,0};
	texts[] = {"Ja","Nein"};
	default = 1;
};
class dummy_tfar {
	title = "---------------------- TFAR-Settings ----------------------";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
};
class param_seriousMode
{
	title="Soll der TFAR-serious-Mode aktiviert werden?";
	values[] = {1,0};
	texts[] = {"Ja","Nein"};
	default = 1;
};
class dummy_acre {
	title = "---------------------- ACRE-Settings ----------------------";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
};
class param_acreBabel
{
	title="Sollen alle Seiten die gleichen Sprachen sprechen?";
	values[] = {1,0};
	texts[] = {"Ja","Nein"};
	default = 0;
};
class param_acrePresets
{
	title="Sollen alle Seiten im Funk die selben Frequenzen nutzen?";
	values[] = {1,0};
	texts[] = {"Ja","Nein"};
	default = 0;
};
class dummy_equipment {
	title = "---------------------- Ausrüstung (allgemein) ----------------------";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
};
class param_customLoad
{
	title="Sollen die Spieler mit custom loadouts ausgerüstet werden?";
	values[] = {2,1,0};
	texts[] = {"Spieler starten und respawnen mit custom loadouts.","Spieler starten mit custom loadouts (nur mit gearsaving).","Keine custom loadouts."};
	default = 1;
};
class param_chooseLoad
{
	title="Sollen die Spieler am Start ihre Ausrüstung wechseln dürfen?";
	values[] = {1,0};
	texts[] = {"Ja","Nein"};
	default = 1;
};
class param_radios
{
	title="Sollen die Spieler bei Missionsbeginn mit Funkgeräten ausgerüstet werden?";
	values[] = {3,2,1,0};
	texts[] = {"Alle erhalten einstellbare Funkgeräte","Nur Führungsrollen","Alle erhalten rollenspezifische Funkgeräte","Nein"};
	default = 1;
};
class param_tablets
{
	title="Mit welchen Tablets sollen die Spieler bei Missionsbeginn ausgerüstet werden?";
	values[] = {3,2,1,99,0};
	texts[] = {"BWmod Navipad","ACE-GPS","cTab","Nur Vanilla-GPS","Keine"};
	default = 1;
};
class param_gasmasks
{
	title="Sollen die Spieler bei Missionsbeginn mit Atemschutzmasken ausgerüstet werden?";
	values[] = {2,1,0};
	texts[] = {"Atemschutzmasken im Inventar","Atemschutzmasken aufgesetzt","Nein"};
	default = 0;
};
class param_logisticAmount
{
	title="Wieviel Logistik-Nachschub soll den Spielern am Start zur Verfügung stehen?";
	values[] = {99,3,2,1,0};
	texts[] = {"Unendlich","Viel","Normal","Wenig","Garkein"};
	default = 99;
};
class param_logisticTeam
{
	title="Sollen den Spielern am Start Sonderkisten zur Verfügung stehen? (unbegrenzt)";
	values[] = {5,4,3,2,1,0};
	texts[] = {"Alle Sonderkisten und Drohnen","Ausrüstungsdrohnen mit Ausrüstung für ~ eine Person","Slingloadbare Kisten und Fire Team-Kisten","Slingloadbare Kiste mit mehr Ausrüstung (spawnt bei einem der Transporthubschrauber)","Kisten mit Ausrüstung für ein Fire Team","Nein"};
	default = 2;
};
class param_logisticDrop
{
	title="Soll der Logistik-Nachschub per Mapclick in der Luft abgeworfen werden können?";
	values[] = {2,1,0};
	texts[] = {"Nur Slingload-Kisten","Ja","Nein"};
	default = 2;
};
class dummy_blu_equipment {
	title = "---------------------- BLUFOR-Ausrüstung ----------------------";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
};
class param_NVGs
{
	title="Sollen die (BLUFOR- & INDFOR-)Spieler bei Missionsbeginn mit Nachtausrüstung ausgerüstet werden?";
	values[] = {2,1,0};
	texts[] = {"Nachtausrüstung mit NVGs","Nachtausrüstung ohne NVGs","Nein"};
	default = 0;
};
class param_optics
{
	title="Sollen die (BLUFOR- & INDFOR-)Spieler, sofern voreingestellt, bei Missionsbeginn mit optischen Zielhilfen ausgerüstet werden (betrifft nicht Scharfschützen)?";
	values[] = {2,1,0};
	texts[] = {"50:50","Ja","Nein"};
	default = 1;
};
class param_Silencers
{
	title="Sollen die (BLUFOR- & INDFOR-)Spieler bei Missionsbeginn mit Schalldämpfern ausgerüstet werden?";
	values[] = {2,1,0};
	texts[] = {"Schalldämpfer im Inventar","Schalldämpfer an den Waffen","Nein"};
	default = 0;
};
class param_customUni
{
	title="Welche Uniform-Sets sollen an Einheiten ausgegeben werden? (Kann durch worldname beeinflusst werden.)";
	values[] = {
		12
		,10,8,7
		,6,13
		,2,1
		,31,9,30,20,0
	};
	texts[] = {
		"UK3CB - BAF"
		,"RHS - MARPAT","RHS - UCP","RHS - OCP"
		,"CUP - BAF","CUP - PMC"
		,"BWmod - Flecktarn","BWmod - Tropentarn"
		,"Vanilla Woodland (benötigt ADV-Retex)","Vanilla - Guerilla","Vanilla - CTRG","Apex - NATO","Vanilla - NATO"
	};
	default = 0;
};
class param_customWeap
{
	title="Welche Waffen-Sets sollen an Einheiten ausgegeben werden? (Kann durch worldname beeinflusst werden.)";
	values[] = {
		9
		,8
		,7,6,5
		,4,3,2
		,1
		,20,0
	};
	texts[] = {
		"FAL, G3 und M60 - größtenteils ohne Optiken, keine Schalldämpfer (benötigt HLC_FAL, HLC_G3, HLC_MP5, HLC_M60)"
		,"BAF (benötigt UK3CB-Equipment und -Weapons)"
		,"CUP BAF (benötigt CUP)","CUP Arma 2 (benötigt CUP)","CUP Operation Arrowhead (benötigt CUP)"
		,"RHS SOF (benötigt RHSUSF)","RHS Marines (benötigt RHSUSF, optional HLC_MP5, HLC_M60)","RHS Army (benötigt RHSUSF, optional HLC_MP5)"
		,"BWmod (benötigt BWmod, optional HLC_G36)"
		,"Apex - NATO","Vanilla - NATO"
	};
	default = 0;
};
class dummy_ind_equipment {
	title = "---------------------- INDFOR-Parameter ----------------------";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
};
class param_indWeap
{
	title="Welche Waffen sollen an INDFOR-Einheiten ausgegeben werden?";
	values[] = {
		3
		,2
		,21,20
		,1,0
	};
	texts[] = {
		"FAL, G3 und M60 - größtenteils ohne Optiken, keine Schalldämpfer (benötigt HLC_FAL, HLC_G3, HLC_MP5, HLC_M60)"
		,"RHSUSF (benötigt RHSUSF, optional hlc_mp5 und RH-Pistols)"
		,"Apex - AKs (größtenteils ohne Optiken, keine Schalldämpfer)","Apex - SPAR"
		,"Vanilla - TRG","Vanilla - Mk20"
	};
	default = 0;
};
class param_indUni
{
	title="Welche Uniformen sollen an INDFOR-Einheiten ausgegeben werden?";
	values[] = {
		2
		,20,1,0
	};
	texts[] = {
		"TFA - PMC"
		,"Apex - Syndikat","Vanilla - PMC","Vanilla - AAF"
	};
	default = 0;
};
class param_indCarAssets
{
	title="Sollen die INDFOR-Fahrzeuge ersetzt/entfernt werden?";
	values[] = {99,0};
	texts[] = {"Keine Fahrzeuge","Nein"};
	default = 0;
};
class dummy_opf_equipment {
	title = "---------------------- OPFOR-Ausrüstung ----------------------";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
};
class param_opfNVGs
{
	title="Sollen die OPFOR-Spieler bei Missionsbeginn mit Nachtausrüstung ausgerüstet werden?";
	values[] = {2,1,0};
	texts[] = {"Nachtausrüstung mit NVGs","Nachtausrüstung ohne NVGs","Nein"};
	default = 0;
};
class param_opfOptics
{
	title="Sollen die (OPFOR-)Spieler, sofern voreingestellt, bei Missionsbeginn mit optischen Zielhilfen ausgerüstet werden (betrifft nicht Scharfschützen)?";
	values[] = {2,1,0};
	texts[] = {"50:50","Ja","Nein"};
	default = 1;
};
class param_opfSilencers
{
	title="Sollen die OPFOR-Spieler bei Missionsbeginn mit Schalldämpfern ausgerüstet werden?";
	values[] = {2,1,0};
	texts[] = {"Schalldämpfer im Inventar","Schalldämpfer an den Waffen","Nein"};
	default = 0;
};
class param_opfUni
{
	title="Welche Uniform-Sets sollen an OPFOR-Einheiten ausgegeben werden?";
	values[] = {
		6
		,4,3,2,1
		,5,20,0
	};
	texts[] = {
		"Afghan Militia (CUP)"
		,"EMR Desert (RHS)","Mountain Flora (RHS)","Flora (RHS)","EMR Summer (RHS)"
		,"Vanilla - Guerilla","Apex - CSAT","Vanilla - CSAT"
	};
	default = 0;
};
class param_opfWeap
{
	title="Welche Waffen-Sets sollen an OPFOR-Einheiten ausgegeben werden?";
	values[] = {
		4
		,3
		,2,1
		,21,20,0
	};
	texts[] = {
		"HLC AK Pack (no logistic, no ammo in vehicles), am besten mit RHSAFRF"
		,"CUP (benötigt CUP)"
		,"RHS-Guerillas (benötigt RHSAFRF)","RHS (benötigt RHSAFRF)"
		,"Apex - AK12","Apex - CAR-95","Vanilla - CSAT"
	};
	default = 0;
};
class dummy_vehicles {
	title = "---------------------- Fahrzeuge (Allgemein) ----------------------";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
};
class param_Assets_cars
{
	title="Sollen am Startpunkt leichte Fahrzeuge für alle Seiten zur Verfügung stehen?";
	values[] = {1,0,99};
	texts[] = {"Ja","Nein (Die Fahrzeuge bleiben stehen, sind aber abgeschlossen und deaktiviert.)","Alle leichten Fahrzeuge werden von der Karte entfernt."};
	default = 1;
};
class param_Assets_heavy
{
	title="Sollen am Startpunkt schwere Fahrzeuge für alle Seiten zur Verfügung stehen?";
	values[] = {1,0,99};
	texts[] = {"Ja","Nein (Die Fahrzeuge bleiben stehen, sind aber abgeschlossen und deaktiviert.)","Alle schweren Fahrzeuge werden von der Karte entfernt."};
	default = 1;
};
class param_Assets_tanks
{
	title="Sollen am Startpunkt Panzer für alle Seiten zur Verfügung stehen?";
	values[] = {1,0,99};
	texts[] = {"Ja","Nein (Die Fahrzeuge bleiben stehen, sind aber abgeschlossen und deaktiviert.)","Alle Panzer werden von der Karte entfernt."};
	default = 1;
};
class param_Assets_air_helis
{
	title="Sollen am Startpunkt Hubschrauber für alle Seiten zur Verfügung stehen?";
	values[] = {1,0,99};
	texts[] = {"Ja","Nein (Die Fahrzeuge bleiben stehen, sind aber abgeschlossen und deaktiviert.)","Alle Hubschrauber werden von der Karte entfernt."};
	default = 1;
};
class param_Assets_air_fixed
{
	title="Sollen am Startpunkt Flugzeuge für alle Seiten zur Verfügung stehen?";
	values[] = {1,0,99};
	texts[] = {"Ja","Nein (Die Fahrzeuge bleiben stehen, sind aber abgeschlossen und deaktiviert.)","Alle Flugzeuge werden von der Karte entfernt."};
	default = 1;
};
class dummy_blu_vehicles {
	title = "---------------------- BLUFOR-Fahrzeuge ----------------------";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
};
class param_modCarAssets
{
	title="Sollen leichte Fahrzeuge durch AddOn-Fahrzeuge ersetzt werden?";
	values[] = {99
		,30
		,21,20
		,11,10
		,2,1,0
	};
	texts[] = {"Keine leichten Fahrzeuge"
		,"CUP BAF"
		,"RHS Marines","RHS Army"
		,"BW-Fahrzeuge + Redd & Tank TPZ Fuchs","BW-Fahrzeuge (benötigt CUP, BWmod und German PzSpw Fennek Pack)"
		,"ADV-Retex Fenneks","Apex Prowler","Nein"
	};
	default = 0;
};
class param_modTruckAssets
{
	title="Sollen Trucks durch AddOn-Fahrzeuge ersetzt werden?";
	values[] = {99
		,40
		,31,30
		,20
		,10
		,0
	};
	texts[] = {"Keine Trucks"
		,"DAR MTVR"
		,"CUP BAF Coyotes","CUP MTVR"
		,"RHS - Army"
		,"BW-Retex LKW (benötigt Bundeswehr ReTex Pack)"
		,"Nein"
	};
	default = 0;
};
class param_modHeavyAssets
{
	title="Sollen schwere Fahrzeuge durch AddOn-Fahrzeuge ersetzt werden?";
	values[] = {99
		,40
		,34,33,32,31,30
		,22,21,20
		,12,11,10
		,3,2,1,0
	};
	texts[] = {"Keine schweren Fahrzeuge"
		,"DAR MaxxPro"
		,"CUP BAF MRAPs","CUP BAF APCs","CUP AAV7","CUP LAV25","CUP Stryker"
		,"RHS MRAPs","RHS M113","RHS Bradleys"
		,"Redd & Tank SPZ Marder","Redd & Tank TPZ Fuchs","BWmod Puma"
		,"stv retexture/ADV-Retex - Marid","stv retexture/ADV-Retex - Warrior/Mora","ADV-Retex - Gorgon","Nein"
	};
	default = 0;
};
class param_modTankAssets
{
	title="Sollen Panzer durch AddOn-Fahrzeuge ersetzt werden?";
	values[] = {99
		,40
		,30
		,21,20
		,11,10
		,1,0
	};
	texts[] = {"Keine Panzer/Artillerie"
		,"Burne's M1A2"
		,"CUP BAF"
		,"RHS (mit M119-Artillerie)","RHS (mit M109A6-Artillerie)"
		,"Redd & Tank SPZ Marder","BWmod Leopard"
		,"stv retexture/ADV-Retex - Leopard/Kuma","Nein"
	};
	default = 0;
};
class param_modHeliAssets
{
	title="Sollen Helikopter durch AddOn-Helikopter ersetzt werden?";
	values[] = {99,30,22,21,20,10,0};
	texts[] = {"Keine Helikopter","CUP BAF-Helis","RHS Army (mit OH-6-Variants)","RHS Army (mit AH-64)","RHS Marines","BW-Helis","Nein"};
	default = 0;
};
class param_modAirAssets
{
	title="Sollen Flugzeuge durch AddOn-Flugzeuge ersetzt werden?";
	values[] = {99,42,41,40,31,30,21,20,0};
	texts[] = {"Keine Flugzeuge","FIR F-14D","F/A-18F (Zweisitzer)","F/A-18E (Einsitzer)","CUP F35","CUP AV-8B Harrier","RHS F-22/C130","RHS A-10/C130","Nein"};
	default = 0;
};
class dummy_opf_vehicles {
	title = "---------------------- OPFOR-Fahrzeuge ----------------------";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
};
class param_opfCarAssets
{
	title="Sollen leichte Fahrzeuge durch AddOn-Fahrzeuge ersetzt werden?";
	values[] = {99,40,21,20,1,0};
	texts[] = {"Keine leichten Fahrzeuge","RDS Zivil-Fahrzeuge","RHS GAZ","RHS UAZ","Apex Qilin","Nein"};
	default = 0;
};
class param_opfTruckAssets
{
	title="Sollen Trucks durch AddOn-Fahrzeuge ersetzt werden?";
	values[] = {99,21,20,0};
	texts[] = {"Keine Trucks","RHS Zivil-Trucks","RHS","Nein"};
	default = 0;
};
class param_opfHeavyAssets
{
	title="Sollen schwere Fahrzeuge durch AddOn-Fahrzeuge ersetzt werden?";
	values[] = {99,21,20,0};
	texts[] = {"Keine schweren Fahrzeuge","RHS BMPs","RHS BTRs","Nein"};
	default = 0;
};
class param_opfTankAssets
{
	title="Sollen Panzer durch AddOn-Fahrzeuge ersetzt werden?";
	values[] = {99,41,40,22,21,20,0};
	texts[] = {"Keine Panzer","RDS T34","RDS T55","RHS T72","RHS T80","RHS T90","Nein"};
	default = 0;
};
class param_opfHeliAssets
{
	title="Sollen Helikopter durch AddOn-Helikopter ersetzt werden?";
	values[] = {99,25,24,23,22,21,20,0};
	texts[] = {"Keine Helikopter","RHS Civilian","RHS CAS only", "RHS Transport + Mi28", "RHS Transport + Ka52","RHS Transport + Mi24","RHS Transport","Nein"};
	default = 0;
};
class param_opfAirAssets
{
	title="Sollen Flugzeuge durch AddOn-Flugzeuge ersetzt werden?";
	values[] = {99,40,21,20,0};
	texts[] = {"Keine Flugzeuge","JS SU35","RHS SU-50","RHS SU-25","Nein"};
	default = 0;
};