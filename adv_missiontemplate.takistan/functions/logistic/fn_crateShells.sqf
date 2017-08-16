/*
 * Author: Belbo
 *
 * Fills a crate with Shells for Mortar
 *
 * Arguments:
 * Array of objects - <ARRAY> of <OBJECTS>
 *
 * Return Value:
 * Function executed - <BOOL>
 *
 * Example:
 * [this] call adv_fnc_crateShells;
 *
 * Public: Yes
 */
 
if !(isClass (configFile >> "CfgPatches" >> "ACE_mk6mortar")) exitWith { false };

{
	private _target = _x;

	_target addMagazineCargoGlobal ["ACE_1Rnd_82mm_Mo_HE",16];
	_target addMagazineCargoGlobal ["ACE_1Rnd_82mm_Mo_Smoke",8];
	if ( missionNamespace getVariable ["adv_par_NVGs",1] > 0 || missionNamespace getVariable ["adv_par_opfNVGs",1] > 0 ) then {
		_target addMagazineCargoGlobal ["ACE_1Rnd_82mm_Mo_Illum",8];
	};
	
} count _this;

true;