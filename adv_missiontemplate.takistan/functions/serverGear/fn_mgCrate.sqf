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
	if (ADV_par_customWeap == 0) then {
		_crate addMagazineCargoGlobal ["130Rnd_338_Mag",20];
	};
	
} forEach _this;

if (true) exitWith {};