/*
 * Author: Belbo
 *
 * Creates briefing entry for debugging actions.
 *
 * Arguments:
 * None.
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [] call adv_fnc_adminCommands;
 *
 * Public: No
 */

if !(getPlayerUID player in ["76561197985568467"]) then {
	if !( serverCommandAvailable "#kick" ) exitWith { false };
	if ( (call BIS_fnc_admin) isEqualTo 1 ) exitWith { false };
};

missionNamespace setVariable ["adv_var_adminCommandsApplied",true];

private _ships = allMissionObjects "Land_Carrier_01_base_F";
private _freedomText = if (count _ships > 0) then {
"<execute expression='{[[],true] call adv_fnc_clearFreedom} remoteExec [""call"",2];systemChat ""Landedeck wird freigeräumt."";'>Landedeck der USS Freedom von Wracks freiräumen.</execute><br/>
<execute expression='{[[],false] call adv_fnc_clearFreedom} remoteExec [""call"",2];systemChat ""Landedeck wird freigeräumt."";'>Landedeck der USS Freedom freiräumen (Fahrzeuge an Deck respawnen)</execute><br/>
<br/>"
} else {
	""
};

player createDiarySubject ["debugMenu","ADMIN-COMMANDS"];

player createDiaryRecord ["debugMenu",["ACE-Settings","
<br/>
ACE-Medical-Settings:<br/>
<br/>
<font color='#A0F020'>
<execute expression='missionNamespace setVariable [""ace_medical_enableAdvancedWounds"",true,true];systemChat ""Advanced Wounds enabled."";'>Enable Advanced Wounds</execute><br/>
<execute expression='missionNamespace setVariable [""ace_medical_enableAdvancedWounds"",false,true];systemChat ""Advanced Wounds disabled."";'>Disable Advanced Wounds</execute><br/>
<br/>
<execute expression='missionNamespace setVariable [""ace_medical_healHitPointAfterAdvBandage"",true,true];systemChat ""Heal Hitpoint After AdvBandage enabled."";'>Enable Heal Hitpoint After AdvBandage</execute><br/>
<execute expression='missionNamespace setVariable [""ace_medical_healHitPointAfterAdvBandage"",false,true];systemChat ""Heal Hitpoint After AdvBandage disabled."";'>Disable Heal Hitpoint After AdvBandage</execute><br/>
<br/>
<execute expression='missionNamespace setVariable [""ace_medical_enableUnconsciousnessAI"",1,true];systemChat ""Unconscious AI enabled."";'>Enable Unconscious AI</execute><br/>
<execute expression='missionNamespace setVariable [""ace_medical_enableUnconsciousnessAI"",0,true];systemChat ""Unconscious AI disabled."";'>Disable Unconscious AI</execute><br/>
<br/>
<execute expression='missionNamespace setVariable [""ace_medical_useCondition_PAK"",1,true];systemChat ""Patient needs to be in stable condition for PAK."";'>Patient needs to be in stable condition for PAK</execute><br/>
<execute expression='missionNamespace setVariable [""ace_medical_useCondition_PAK"",0,true];systemChat ""Patient does not need to be in stable condition for PAK."";'>Patient does not need to be in stable condition for PAK</execute><br/>
</font>
<br/>
-----------------------------
<br/>
ADV_aceCPR-Settings:<br/>
<br/>
<font color='#A0F020'>
<execute expression='missionNamespace setVariable [""adv_aceCPR_onlyDoctors"",0,true];systemChat ""All players can revive with CPR."";'>Allow all players to revive with CPR.</execute><br/>
<execute expression='missionNamespace setVariable [""adv_aceCPR_onlyDoctors"",1,true];systemChat ""Only medics and doctors can revive with CPR."";'>Allow only medics and doctors to revive with CPR.</execute><br/>
<execute expression='missionNamespace setVariable [""adv_aceCPR_onlyDoctors"",2,true];systemChat ""Only doctors can revive with CPR."";'>Allow only doctors to revive with CPR.</execute><br/>
</font>
<br/>
-----------------------------
<br/>
Misc. ACE-Settings:<br/>
<br/>
<font color='#A0F020'>
<execute expression='missionNamespace setVariable [""ace_mk6mortar_allowComputerRangefinder"",true,true];missionNamespace setVariable [""ace_mk6mortar_airResistanceEnabled"",false,true];systemChat ""Artillery Computer enabled."";'>Enable Artillery Computer</execute><br/>
<execute expression='missionNamespace setVariable [""ace_mk6mortar_allowComputerRangefinder"",false,true];missionNamespace setVariable [""ace_mk6mortar_airResistanceEnabled"",true,true];systemChat ""Artillery Computer disabled."";'>Disable Artillery Computer</execute><br/>
<br/>
<execute expression='missionNamespace setVariable [""ace_rearm_level"",0,true];systemChat ""Entire vehicle."";'>Set Rearm to ""Entire vehicle"".</execute><br/>
<execute expression='missionNamespace setVariable [""ace_rearm_level"",1,true];systemChat ""Entire magazine."";'>Set Rearm to ""Entire magazine"".</execute><br/>
<execute expression='missionNamespace setVariable [""ace_rearm_level"",2,true];systemChat ""Amount based on caliber."";'>Set Rearm to ""Amount based on caliber"".</execute><br/>
</font>"]];

player createDiaryRecord ["debugMenu",["Server",("
<br/>
AI-Settings:<br/>
<br/>
Zu wem soll GREENFOR verbündet sein?<br/>
<br/>
<font color='#A0F020'>
<execute expression='{east setFriend [resistance, 1]} remoteExec [""call"",2];{west setFriend [resistance, 0]} remoteExec [""call"",2];{resistance setFriend [east, 1]} remoteExec [""call"",2];{resistance setFriend [west, 0]} remoteExec [""call"",2];systemChat ""GREENFOR allied to OPFOR"";'>OPFOR</execute><br/>
<execute expression='{east setFriend [resistance, 0]} remoteExec [""call"",2];{west setFriend [resistance, 1]} remoteExec [""call"",2];{resistance setFriend [east, 0]} remoteExec [""call"",2];{resistance setFriend [west, 1]} remoteExec [""call"",2];systemChat ""GREENFOR allied to BLUFOR"";'>BLUFOR</execute><br/>
<execute expression='{east setFriend [resistance, 1]} remoteExec [""call"",2];{west setFriend [resistance, 1]} remoteExec [""call"",2];{resistance setFriend [east, 1]} remoteExec [""call"",2];{resistance setFriend [west, 1]} remoteExec [""call"",2];systemChat ""GREENFOR allied to ALL"";'>ALL</execute><br/>
<execute expression='{east setFriend [resistance, 0]} remoteExec [""call"",2];{west setFriend [resistance, 0]} remoteExec [""call"",2];{resistance setFriend [east, 0]} remoteExec [""call"",2];{resistance setFriend [west, 0]} remoteExec [""call"",2];systemChat ""GREENFOR allied to NONE"";'>NONE</execute><br/>
</font>
<br/>
-----------------------------
<br/>
Missions-Funktionen:<br/>
<br/>
<font color='#A0F020'>
<execute expression='[] remoteExec [""adv_fnc_cpinit"",0];systemChat ""CP startet..."";'>Starte Combat Patrol-Mission</execute><br/>
</font>
<br/>
-----------------------------
<br/>
Sonstige Server-Funktionen:<br/>
<br/>
<font color='#A0F020'>
<execute expression='{[98] call adv_fnc_weather} remoteExec [""call"",0];systemChat ""Zufälliges Wetter eingestellt."";'>Zufälliges, konstantes Wetter einstellen (wechselt ohne Übergang!)</execute><br/>
<br/>") + _freedomText + ("
<execute expression='missionNamespace setVariable [""adv_par_logisticDrop"",1,true];systemChat ""Automatic logistic drop activated."";'>Activate logistic drop option on crates</execute><br/>
<execute expression='missionNamespace setVariable [""adv_par_logisticDrop"",0,true];systemChat ""Automatic logistic drop deactivated."";'>Deactivate logistic drop option on crates</execute><br/>
<br/>
</font>")]];

player createDiaryRecord ["debugMenu",["Ausrüstung","
<br/>
Loadout-Variables:<br/>
<br/>
Hier eingestellte Loadout-Variablen haben erst durch Neuausgabe der Ausrüstung einen Effekt.<br/>
<br/>
<font color='#A0F020'>
<execute expression='missionNamespace setVariable [""adv_par_optics"",2,true];missionNamespace setVariable [""adv_par_opfOptics"",2,true];systemChat ""Scopes 50:50 enabled."";'>Enable 50:50 Scopes</execute><br/>
<execute expression='missionNamespace setVariable [""adv_par_optics"",1,true];missionNamespace setVariable [""adv_par_opfOptics"",1,true];systemChat ""Scopes enabled."";'>Enable Scopes</execute><br/>
<execute expression='missionNamespace setVariable [""adv_par_optics"",0,true];missionNamespace setVariable [""adv_par_opfOptics"",0,true];systemChat ""Scopes disabled."";'>Disable Scopes</execute><br/>
<br/>
<execute expression='missionNamespace setVariable [""adv_par_silencers"",2,true];missionNamespace setVariable [""adv_par_opfSilencers"",2,true];systemChat ""Silencers in inventory enabled."";'>Enable Silencers in inventory</execute><br/>
<execute expression='missionNamespace setVariable [""adv_par_silencers"",1,true];missionNamespace setVariable [""adv_par_opfSilencers"",1,true];systemChat ""Silencers enabled."";'>Enable Silencers</execute><br/>
<execute expression='missionNamespace setVariable [""adv_par_silencers"",0,true];missionNamespace setVariable [""adv_par_opfSilencers"",0,true];systemChat ""Silencers disabled."";'>Disable Silencers</execute><br/>
<br/>
<execute expression='missionNamespace setVariable [""adv_par_NVGs"",2,true];missionNamespace setVariable [""adv_par_opfNVGs"",2,true];systemChat ""NVGs enabled."";'>Enable NVGs</execute><br/>
<execute expression='missionNamespace setVariable [""adv_par_NVGs"",1,true];missionNamespace setVariable [""adv_par_opfNVGs"",1,true];systemChat ""Flashlights enabled."";'>Enable flashlights</execute><br/>
<execute expression='missionNamespace setVariable [""adv_par_NVGs"",0,true];missionNamespace setVariable [""adv_par_opfNVGs"",0,true];systemChat ""NVGs disabled."";'>Disable NVGs or flashlights</execute><br/>
<br/>
<execute expression='missionNamespace setVariable [""adv_par_gasmasks"",2,true];systemChat ""Gasmasks in inventory enabled."";'>Enable gasmasks in inventory</execute><br/>
<execute expression='missionNamespace setVariable [""adv_par_gasmasks"",1,true];systemChat ""Wearing gasmasks enabled."";'>Enable wearing gasmasks</execute><br/>
<execute expression='missionNamespace setVariable [""adv_par_gasmasks"",0,true];systemChat ""Gasmasks disabled."";'>Disable gasmasks</execute><br/>
<br/>
<execute expression='missionNamespace setVariable [""adv_par_noLRRadios"",false,true];systemChat ""Backpack radios enabled."";'>Enable backpack radios</execute><br/>
<execute expression='missionNamespace setVariable [""adv_par_noLRRadios"",true,true];systemChat ""Backpack radios disabled."";'>Disable backpack radios</execute><br/>
</font>
<br/>
-----------------------------
<br/>
Loadout-Functions:<br/>
<br/>
<font color='#A0F020'>
<execute expression='{[] call adv_fnc_tfarSettings} remoteExec [""call"",0];{[] call adv_fnc_acreSettings} remoteExec [""call"",0];{[player] call adv_fnc_setFrequencies} remoteExec [""call"",0];systemChat ""Die Funkfrequenzen wurden neu eingestellt."";'>Funkfrequenzen neu einstellen und zurücksetzen</execute><br/>
<br/>
<executeClose expression='{[player] call adv_fnc_applyLoadout} remoteExec [""call"",0];systemChat ""Ausrüstung neu ausgegeben."";'>Ausrüstung aller Spieler neu ausgeben</executeClose><br/>
</font>"]];

player createDiaryRecord ["debugMenu",["Spieler","
<br/>
Spieler-Funktionen:<br/>
<br/>
<font color='#A0F020'>
<executeClose expression='{[player] call adv_fnc_fullHeal} remoteExec [""call"",0]; systemChat ""Alle Spieler wurden geheilt."";'>Alle Spieler heilen</executeClose><br/>
<br/>
<executeClose expression='{[player,1000] call adv_fnc_setRating} remoteExec [""call"",0]; systemChat ""Rating aller Spieler wurde auf 1000 gesetzt."";'>Rating aller Spieler auf 1000 setzen</executeClose><br/>
<br/>
<executeClose expression='missionNamespace setVariable [""L_suppress_active"",true,true]; systemChat ""L_suppress activated."";'>Activate Laxemann's Suppress</executeClose><br/>
<executeClose expression='missionNamespace setVariable [""L_suppress_active"",false,true]; systemChat ""L_suppress deactivated."";'>Deactivate Laxemann's Suppress</executeClose><br/>
</font>"]];

player createDiaryRecord ["debugMenu",["Admin-Commands","
<br/>
In den unten aufgeführten Menüs stehen dem eingeloggten Admin diverse Auswahlmöglichkeiten zur Verfügung, mit denen bestimmte Variablen neu eingestellt werden können, oder mit denen bestimmte Commands ausgeführt werden können.
<br/>
<br/>
ACHTUNG:
<br/>
Diese Settings sind nur für den NOTFALL gedacht!
<br/>
Sei dir absolut sicher, wenn du hier Missionssettings änderst - mangelnde Vorsicht kann die gesamte Mission für ALLE Spieler ruinieren.
"]];

true;

/*


*/