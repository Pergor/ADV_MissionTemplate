/*
taw_vds init
*/

if ( missionNamespace getVariable ["tawvd_addon_disable",true] ) then {
	execFSM "scripts\taw_vd\fn_stateTracker.fsm";
};

nil