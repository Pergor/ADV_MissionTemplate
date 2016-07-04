
if ( !isClass(configFile >> "CfgPatches" >> "ace_explosives") || !hasInterface ) exitWith {};

{
	_mine = _x;
	if !( "ACE_DefuseObject" in (attachedObjects _mine) ) then {
		_defuseHelper = "ACE_DefuseObject" createVehicleLocal (getPos _mine);
		_defuseHelper attachTo [_mine, [0,0,0]];
		//_defuseHelper setVariable ["ACE_explosives_Explosive",_mine];
	};
	nil;
} count allMines;