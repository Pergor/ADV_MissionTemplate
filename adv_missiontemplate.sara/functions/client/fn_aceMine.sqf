
if ( !isClass(configFile >> "CfgPatches" >> "ace_explosives") || !hasInterface ) exitWith {};

adv_handle_aceMine = [] spawn {
	while {true} do {
		{
			_mine = _x;
			if !(_mine getVariable ["adv_aceMine_helperAttached",false]) then {
				_defuseHelper = "ACE_DefuseObject" createVehicleLocal (getPos _mine);
				_defuseHelper attachTo [_mine, [0,0,0]];
				//_defuseHelper setVariable ["ACE_explosives_Explosive",_mine];
				_mine setVariable ["adv_aceMine_helperAttached",true];
			};
			nil;
		} count allMines;
		sleep 10;
	};
};