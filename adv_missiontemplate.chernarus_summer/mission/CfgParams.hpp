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
	default = 14;
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
	values[] = {14,23,29,7};
	texts[] = {"Neumond","zunehmender Halbmond (sichtbar in der ersten Hälfte der Nacht)","Vollmond","abnehmender Halbmond (sichtbar in der zweiten Hälfte der Nacht)"};
	default = 23;
};
class param_Weather
{
	title="Zufälliges Wetter";
	values[] = {99,1,2,3,4,5,6,7,8,9};
	texts[] = {"Kein zufälliges Wetter","Klar","Bewölkt","Leichter Regen","Mittlerer Regen","Schwerer Regen","Leichter Nebel","Mittlerer Nebel","Dichter Nebel","Zufälliges Wetter"};
	default = 99;
};
class param_fixedWeather
{
	title="Dauerhaftes Wetter";
	values[] = {99,1,2,3,4,5,6,7,8,9,98};
	texts[] = {"Keine Veränderung","Sonnig","Klar","Bewölkt","Leichter Regen","Mittlerer Regen","Schwerer Regen","Leichter Nebel","Mittlerer Nebel","Dichter Nebel","Zufälliges Wetter"};
	default = 99;
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
	title="Wie soll mit respawnenden Spielern umgegangen werden?";
	values[] = {99,4,3,2,1,0};
	texts[] = {"Kein Respawn","Fester Respawn (Nachführung durch Fallschirmabwurf oder Teleport)","Fester Respawn (Nachführung durch Fallschirmabwurf)","Fester Respawn (Nachführung durch Teleport)","Beweglicher Respawn (wird alle 120 sek. nachgezogen)","Fester Respawn"};
	default = 2;
};
class param_vehicleRespawn
{
	title="Wie hoch soll der Respawn-Timer für Fahrzeuge eingestellt werden?";
	values[] = {900,600,300,60,30,20,10,5,9999};
	texts[] = {"15 Minuten","10 Minuten","5 Minuten","60 Sekunden","30 Sekunden","20 Sekunden","10 Sekunden","5 Sekunden","Deaktiviert"};
	default = 300;
};
class dummy_settings_game {
	title = "---------------------- Game Settings ----------------------";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
};
class param_sideRelations
{
	title="Mit welcher Seite soll GREENFOR verbündet sein?";
	values[]  = {3,2,1,0};
	texts[] = {"Sowohl mit OPFOR, als auch mit BLUFOR","Mit OPFOR","Mit BLUFOR","Mit keiner"};
	default = 0;
};
class param_headlessClient
{
	title="Wird mit Headless Client oder mit Zeus gespielt?";
	values[]  = {2,1,0};
	texts[] = {"Headless Client","Zeus","Weder, noch."};
	default = 1;
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
	values[] = {4,3,2,1,0};
	texts[] = {"Kein NV- und Thermal-Imaging für alle Fahrzeuge & statische Waffen","Kein NV- und Thermal-Imaging für Spieler-Fahrzeuge und statische Waffen","Kein Thermal-Imaging für alle Fahrzeuge & statische Waffen","Kein Thermal-Imaging für Spieler-Fahrzeuge und statische Waffen","Nein"};
	default = 0;
};
class param_seriousMode
{
	title="Soll der TFAR-serious-Mode aktiviert werden?";
	values[] = {1,0};
	texts[] = {"Ja","Nein"};
	default = 1;
};
class dummy_equipment {
	title = "---------------------- Ausrüstung (allgemein) ----------------------";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
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
	values[] = {2,1,99,0};
	texts[] = {"ACE-GPS","cTab","Nur Vanilla-GPS","Keine"};
	default = 1;
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
	values[] = {3,2,1,0};
	texts[] = {"Slingloadbare Kisten und Fire Team-Kisten","Slingloadbare Kiste mit mehr Ausrüstung (spawnt bei einem der Transporthubschrauber)","Kisten mit Ausrüstung für ein Fire Team","Nein"};
	default = 2;
};
class param_logisticDrop
{
	title="Soll der Logistik-Nachschub per Mapclick in der Luft abgeworfen werden können?";
	values[] = {1,0};
	texts[] = {"Ja","Nein"};
	default = 1;
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
	values[] = {1,0};
	texts[] = {"Ja","Nein"};
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
	values[] = {14,13,12,11,10,8,7,6,5,4,3,2,1,9,20,0};
	texts[] = {"TRYK - Snow","TRYK - SpecOps","UK3CB BAF","RHS - MARPAT Woodland","RHS - MARPAT Desert","RHS - UCP","RHS - OCP","TFA - ACU","TFA - Desert","TFA - Woodland","TFA - Mixed","BWmod - Flecktarn","BWmod - Tropentarn","Vanilla-Guerilla","Apex NATO","Vanilla NATO"};
	default = 0;
};
class param_customWeap
{
	title="Welche Waffen-Sets sollen an Einheiten ausgegeben werden? (Kann durch worldname beeinflusst werden.)";
	values[] = {9,8,7,6,5,4,3,2,1,20,0};
	texts[] = {"FAL, G3 und M60 - größtenteils ohne Optiken, keine Schalldämpfer (benötigt HLC_FAL, HLC_G3, HLC_MP5, HLC_M60)","BAF (benötigt UK3CB-Equipment und -Weapons)","BAF (benötigt CUP)","CUP Arma 2 (benötigt CUP)","CUP Operation Arrowhead (benötigt CUP)","RHS SOF (benötigt RHSUSF)","RHS Marines (benötigt RHSUSF, optional HLC_MP5, HLC_M60)","RHS Army (benötigt RHSUSF, optional HLC_MP5)","BWmod (benötigt BWmod, optional HLC_G36)","Apex NATO","Vanilla NATO"};
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
	values[] = {3,2,20,1,0};
	texts[] = {"FAL, G3 und M60 - größtenteils ohne Optiken, keine Schalldämpfer (benötigt HLC_FAL, HLC_G3, HLC_MP5, HLC_M60)","RHSUSF (benötigt RHSUSF, optional hlc_mp5 und RH-Pistols)","Apex AKs - größtenteils ohne Optiken, keine Schalldämpfer","Vanilla Mk20","Vanilla MX"};
	default = 0;
};
class param_indUni
{
	title="Welche Uniformen sollen an INDFOR-Einheiten ausgegeben werden?";
	values[] = {2,20,1,0};
	texts[] = {"TFA PMC","Apex Syndikat","Vanilla AAF","Vanilla PMC"};
	default = 0;
};
class param_indCarAssets
{
	title="Sollen die INDFOR-Fahrzeuge ersetzt/entfernt werden?";
	values[] = {99,1,0};
	texts[] = {"Keine Fahrzeuge","AAF-Fahrzeuge","Nein"};
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
	values[] = {1,0};
	texts[] = {"Ja","Nein"};
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
	values[] = {6,5,4,3,2,1,20,0};
	texts[] = {"Afghan Militia (EricJ's Afghan Fighters & RHS)","Guerilla","EMR Desert (RHS)","Mountain Flora (RHS)","Flora (RHS)","EMR Summer (RHS)","Apex CSAT","Vanilla CSAT"};
	default = 0;
};
class param_opfWeap
{
	title="Welche Waffen-Sets sollen an OPFOR-Einheiten ausgegeben werden?";
	values[] = {4,3,2,1,21,20,0};
	texts[] = {"HLC AK Pack (no logistic, no ammo in vehicles), am besten mit RHSAFRF","CUP (benötigt CUP)","RHS-Guerillas (benötigt RHSAFRF)","RHS (benötigt RHSAFRF)","Apex AK12","Apex CAR-95","Vanilla CSAT"};
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
	values[] = {99,10,9,8,7,6,5,4,3,2,1,0};
	texts[] = {"Keine leichten Fahrzeuge","ADV-Retex Fenneks","RHS Marines - Woodland","RHS Marines - Sand","RHS Army - Plain Green","RHS Army - Woodland","RHS Army - Sand","UK3CB BAF vehicles - Woodland","UK3CB BAF vehicles - Sand","BW-Fahrzeuge - Woodland","BW-Fahrzeuge - Sand","Nein"};
	default = 0;
};
class param_modTruckAssets
{
	title="Sollen Trucks durch AddOn-Fahrzeuge ersetzt werden?";
	values[] = {99,5,4,3,2,1,0};
	texts[] = {"Keine Trucks","BAF Coyotes - Woodland","BAF Coyotes - Sand","RHS - Woodland","RHS - Sand","DAR MTVR","Nein"};
	default = 0;
};
class param_modHeavyAssets
{
	title="Sollen schwere Fahrzeuge durch AddOn-Fahrzeuge ersetzt werden?";
	values[] = {99,13,12,11,10,9,8,7,6,5,4,3,2,1,0};
	texts[] = {"Keine schweren Fahrzeuge","Cha LAV25 - Woodland","Cha LAV25 - Sand","RHS MRAP - Woodland","RHS MRAP - Sand","RHS M2 - Woodland","RHS M2 - Sand","stv retexture/ADV-Retex - Marid","stv retexture/ADV-Retex - Warrior/Mora","DAR MaxxPro","Stryker - Woodland","Stryker - Sand","BWmod Puma - Woodland","BWmod Puma - Sand","Nein"};
	default = 0;
};
class param_modTankAssets
{
	title="Sollen Panzer durch AddOn-Fahrzeuge ersetzt werden?";
	values[] = {99,9,8,7,6,5,4,3,2,1,0};
	texts[] = {"Keine Panzer/Artillerie","Burne's M1A2 - Woodland","Burne's M1A2 - Sand","RHS - Woodland (mit M119-Artillerie)","RHS - Woodland (mit M109A6-Artillerie)","RHS - Sand (mit M119-Artillerie)","RHS - Sand (mit M109A6-Artillerie)","stv retexture - Leopard/Kuma","BWmod Leopard - Woodland","BWmod Leopard - Sand","Nein"};
	default = 0;
};
class param_modHeliAssets
{
	title="Sollen Helikopter durch AddOn-Helikopter ersetzt werden?";
	values[] = {99,6,5,4,3,2,1,0};
	texts[] = {"Keine Helikopter","RHS Army with MELB","RHS Army with RHS AH6/MH6","RHS Marines","UK3CB BAF-Helis","RHS Army","BW-Helis","Nein"};
	default = 0;
};
class param_modAirAssets
{
	title="Sollen Flugzeuge durch AddOn-Flugzeuge ersetzt werden?";
	values[] = {99,6,5,4,3,2,1,0};
	texts[] = {"Keine Flugzeuge","FIR F-14D","RHS F-22/C130","RHS A-10/C130","AV-8B Harrier","F/A-18F (Zweisitzer)","F/A-18E (Einsitzer)","Nein"};
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
	values[] = {99,3,2,1,0};
	texts[] = {"Keine leichten Fahrzeuge","RDS Zivil-Fahrzeuge","RHS GAZ","RHS UAZ","Nein"};
	default = 0;
};
class param_opfTruckAssets
{
	title="Sollen Trucks durch AddOn-Fahrzeuge ersetzt werden?";
	values[] = {99,2,1,0};
	texts[] = {"Keine Trucks","RHS Zivil-Trucks","RHS","Nein"};
	default = 0;
};
class param_opfHeavyAssets
{
	title="Sollen schwere Fahrzeuge durch AddOn-Fahrzeuge ersetzt werden?";
	values[] = {99,2,1,0};
	texts[] = {"Keine schweren Fahrzeuge","RHS BMPs","RHS BTRs","Nein"};
	default = 0;
};
class param_opfTankAssets
{
	title="Sollen Panzer durch AddOn-Fahrzeuge ersetzt werden?";
	values[] = {99,5,4,1,2,3,0};
	texts[] = {"Keine Panzer","RDS T55","RDS T34","RHS T72","RHS T80","RHS T90","Nein"};
	default = 0;
};
class param_opfHeliAssets
{
	title="Sollen Helikopter durch AddOn-Helikopter ersetzt werden?";
	values[] = {99,5,4,3,2,1,0};
	texts[] = {"Keine Helikopter","RHS Civilian","RHS CAS only","RHS Transport + Ka52","RHS Transport + Mi24","RHS Transport","Nein"};
	default = 0;
};
class param_opfAirAssets
{
	title="Sollen Flugzeuge durch AddOn-Flugzeuge ersetzt werden?";
	values[] = {99,3,2,1,0};
	texts[] = {"Keine Flugzeuge","JS SU35","RHS SU-50","RHS SU-25","Nein"};
	default = 0;
};