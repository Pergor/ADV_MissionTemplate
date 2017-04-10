/*
 * Author: Belbo
 *
 * Returns true and creates ADV_preInitIsDon variable as soon as it is called in preInit.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [] call adv_fnc_preInit;
 *
 * Public: No
 */

ADV_preInitIsDone = true;
publicVariable "ADV_preInitIsDone";

true;