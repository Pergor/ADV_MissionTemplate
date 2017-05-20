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

if !( serverCommandAvailable "#kick" ) exitWith { false };
if ( (call BIS_fnc_admin) isEqualTo 1 ) exitWith { false };

systemChat "ADMIN-COMMANDS has been added to the briefing.";

private _remoteExecServer = {
	params ["_function"];
	{_function} remoteExec ["bis_fnc_call",2];
};
private _remoteExecGlobal = {
	params ["_function"];
	{_function} remoteExec ["bis_fnc_call",0];
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
</font>
<br/>
-----------------------------
<br/>
ADV_aceCPR-Settings:<br/>
<br/>
<font color='#A0F020'>
<execute expression='missionNamespace setVariable [""adv_aceCPR_onlyDoctors"",0,true];systemChat ""All players can revive with CPR."";'>Allow all players to revive with CPR.</execute><br/>
<execute expression='missionNamespace setVariable [""adv_aceCPR_onlyDoctors"",1,true];systemChat ""Only medics and doctors can revive with CPR."";'>Allow only medics and doctors to revive with CPR.</execute><br/>
<execute expression='missionNamespace setVariable [""adv_aceCPR_onlyDoctors"",1,true];systemChat ""Only doctors can revive with CPR."";'>Allow only doctors to revive with CPR.</execute><br/>
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

player createDiaryRecord ["debugMenu",["Server","
<br/>
Zu wem soll GREENFOR verbündet sein?<br/>
<br/>
<font color='#A0F020'>
<execute expression='[east setFriend [resistance, 1]] call _remoteExecServer;[resistance setFriend [east, 1]] call _remoteExecServer;[resistance setFriend [west, 0]] call _remoteExecServer;[west setFriend [resistance, 0]] call _remoteExecServer;systemChat ""GREENFOR allied to OPFOR"";'>OPFOR</execute><br/>
<execute expression='[east setFriend [resistance, 0]] call _remoteExecServer;[resistance setFriend [east, 0]] call _remoteExecServer;[resistance setFriend [west, 1]] call _remoteExecServer;[west setFriend [resistance, 1]] call _remoteExecServer;systemChat ""GREENFOR allied to BLUFOR"";'>BLUFOR</execute><br/>
<execute expression='[east setFriend [resistance, 1]] call _remoteExecServer;[resistance setFriend [east, 1]] call _remoteExecServer;[resistance setFriend [west, 1]] call _remoteExecServer;[west setFriend [resistance, 1]] call _remoteExecServer;systemChat ""GREENFOR allied to ALL"";'>ALL</execute><br/>
<execute expression='[east setFriend [resistance, 0]] call _remoteExecServer;[resistance setFriend [east, 0]] call _remoteExecServer;[resistance setFriend [west, 0]] call _remoteExecServer;[west setFriend [resistance, 0]] call _remoteExecServer;systemChat ""GREENFOR allied to NONE"";'>NONE</execute><br/>
</font>"]];

player createDiaryRecord ["debugMenu",["Ausrüstung","
<br/>
Loadout-Variables:<br/>
<br/>
Hier eingestellte Loadout-Variablen haben erst durch Neuausgabe der Ausrüstung einen Effekt.
<br/><br/>
<font color='#A0F020'>
<execute expression='missionNamespace setVariable [""adv_par_optics"",1,true];missionNamespace setVariable [""adv_par_opfOptics"",1,true];systemChat ""Scopes enabled."";'>Enable Scopes</execute><br/>
<execute expression='missionNamespace setVariable [""adv_par_optics"",0,true];missionNamespace setVariable [""adv_par_opfOptics"",0,true];systemChat ""Scopes disabled."";'>Disable Scopes</execute><br/>
<br/>
<execute expression='missionNamespace setVariable [""adv_par_silencers"",1,true];missionNamespace setVariable [""adv_par_opfSilencers"",1,true];systemChat ""Silencers enabled."";'>Enable Silencers</execute><br/>
<execute expression='missionNamespace setVariable [""adv_par_silencers"",0,true];missionNamespace setVariable [""adv_par_opfSilencers"",0,true];systemChat ""Silencers disabled."";'>Disable Silencers</execute><br/>
<br/>
<execute expression='missionNamespace setVariable [""adv_par_NVGs"",2,true];missionNamespace setVariable [""adv_par_opfNVGs"",2,true];systemChat ""NVGs enabled."";'>Enable NVGs</execute><br/>
<execute expression='missionNamespace setVariable [""adv_par_NVGs"",1,true];missionNamespace setVariable [""adv_par_opfNVGs"",1,true];systemChat ""Flashlights enabled."";'>Enable flashlights</execute><br/>
<execute expression='missionNamespace setVariable [""adv_par_NVGs"",0,true];missionNamespace setVariable [""adv_par_opfNVGs"",0,true];systemChat ""NVGs disabled."";'>Disable NVGs or flashlights</execute><br/>
</font>
<br/>
-----------------------------
<br/>
Loadout-Functions:<br/>
<br/>
<font color='#A0F020'>
<execute expression='[[] call adv_fnc_tfarSettings] call _remoteExecGlobal;[[] call adv_fnc_acreSettings] call _remoteExecGlobal;[[player] call adv_fnc_setFrequencies] call _remoteExecGlobal;systemChat ""Die Funkfrequenzen wurden neu eingestellt."";'>Funkfrequenzen neu einstellen und zurücksetzen</execute><br/>
<br/>
<executeClose expression='[[player] call adv_fnc_applyLoadout] call _remoteExecGlobal;systemChat ""Ausrüstung neu ausgegeben."";'>Ausrüstung aller Spieler neu ausgeben</executeClose><br/>
</font>"]];

player createDiaryRecord ["debugMenu",["Spieler","
<br/>
Spieler-Funktionen:
<br/>
<br/>
<font color='#A0F020'>
<executeClose expression='[[player] call adv_fnc_fullHeal] call _remoteExecGlobal; systemChat ""Alle Spieler wurden geheilt."";'>Alle Spieler heilen</executeClose><br/>
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