/*
cratefiller script by Belbo
put this into init-line of the crate that's supposed to contain the items specified below:
nul = [this] call ADV_fnc_crate;
*/

if (!isServer) exitWith {};
{
	_crate = _x;
	//makes the crates indestructible:
	_crate allowDamage false;
	
	//weapons & ammo
	if (ADV_par_opfWeap == 0) then {
		_crate addMagazineCargoGlobal ["150Rnd_93x64_Mag",20];
	};
	
	//medical stuff
	if (isClass (configFile >> "CfgPatches" >> "AGM_Core")) then {
		if (isClass (configFile >> "CfgPatches" >> "AGM_Interaction")) then {
			[_crate,false] call AGM_Drag_fnc_makeDraggable;
		};
	};
} forEach _this;

if (true) exitWith {};