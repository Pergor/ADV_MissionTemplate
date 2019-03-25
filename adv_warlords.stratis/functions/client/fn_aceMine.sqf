/*
 * Author: Belbo
 *
 * Adds ACE_DefuseObject to allMines in mission if they don't have one already.
 *
 * Arguments:
 * None.
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * call adv_fnc_aceMine;
 *
 * Public: No
 */

if ( !isClass(configFile >> "CfgPatches" >> "ace_explosives") || !hasInterface ) exitWith {};

{
	private _mine = _x;
	if !( "ACE_DefuseObject" in (attachedObjects _mine) ) then {
		private _defuseHelper = "ACE_DefuseObject" createVehicleLocal (getPos _mine);
		_defuseHelper attachTo [_mine, [0,0,0]];
		//_defuseHelper setVariable ["ACE_explosives_Explosive",_mine];
	};
	nil;
} count allMines;

true;