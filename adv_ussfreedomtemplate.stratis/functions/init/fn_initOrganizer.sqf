/*
 * Author: Belbo
 *
 * Init organizer regulates the execution order of the init scripts. These are not executed in the regular initialization order.
 * Instead this function is called via preInit. The init scripts (working like regular init.sqf/initPlayerLocal.sqf/initServer.sqf) are spawned from this function only.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 *
 * Public: No
 */

if (isServer) then {
	[] spawn adv_fnc_initServer;
};
if (hasInterface) then {
	[] spawn adv_fnc_initPlayerLocal;
};
[] spawn adv_fnc_init;

nil