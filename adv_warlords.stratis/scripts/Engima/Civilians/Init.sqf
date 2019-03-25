if ( !(_this isEqualTo []) && {!(missionNamespace getVariable ["adv_par_civilians",0] isEqualTo 1 || missionNamespace getVariable ["adv_par_civilians",0] isEqualTo 3)} ) exitWith {};

call compile preprocessFileLineNumbers "scripts\Engima\Civilians\Common\Common.sqf";
call compile preprocessFileLineNumbers "scripts\Engima\Civilians\Common\Debug.sqf";

// The following constants may be used to tweak behaviour

ENGIMA_CIVILIANS_SIDE = civilian;      // If you for some reason want the units to spawn into another side.
ENGIMA_CIVILIANS_MINSKILL = 0;       // If you spawn something other than civilians, you may want to set another skill level of the spawned units.
ENGIMA_CIVILIANS_MAXSKILL = 0;       // If you spawn something other than civilians, you may want to set another skill level of the spawned units.

ENGIMA_CIVILIANS_MAXWAITINGTIME = 300; // Maximum standing still time in seconds
ENGIMA_CIVILIANS_RUNNINGCHANCE = 0.02; // Chance of running instead of walking

// Civilian personalities
ENGIMA_CIVILIANS_BEHAVIOURS = [
	["CITIZEN", 100] // Default citizen with ordinary behaviour. Spawns in a house and walks to another house, and so on...
];

// Do not edit anything beneath this line!

ENGIMA_CIVILIANS_INSTANCE_NO = 0;

private _headlessClientPresent = (count entities "HeadlessClient_F" > 0);
private _runOnThisMachine = false;

if (_headlessClientPresent && isMultiplayer) then {
    if !(hasInterface || isServer) then {
        _runOnThisMachine = true;
    };
}
else {
    if (isServer) then {
        _runOnThisMachine = true;;   
    };
};

if (_runOnThisMachine) then {
	call compile preprocessFileLineNumbers "scripts\Engima\Civilians\Server\ServerFunctions.sqf";
	call compile preprocessFileLineNumbers "scripts\Engima\Civilians\ConfigAndStart.sqf";
};
