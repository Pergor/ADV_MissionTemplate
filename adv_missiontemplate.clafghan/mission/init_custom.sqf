/*
this init is supposed to be mission specific.
It's being executed right after the mission is being loaded.
Every call, spawn or execVM that's mission specific should be placed in here.
*/
//////////////////////////////////////////////////////////////////////////////////
//calls before mission start (during the loading- and briefing-screen):
//////////////////////////////////////////////////////////////////////////////////
// place your custom content here:
//Laxeman variables




	//everything that's only supposed to run on the server:
	if (isServer) then {
	// place your custom content here:
		if (isClass(configFile >> "CfgPatches" >> "adv_retex")) then {
			{
				if (_x isKindof "B_MRAP_01_F" || _x isKindof "B_MRAP_01_hmg_F" || _x isKindof "B_MRAP_01_gmg_F") then {
					[_x] call adv_retex_fnc_setTextureRHSHunter;
				};
				nil;
			} count vehicles;
		};

	
	
	
	};





//////////////////////////////////////////////////////////////////////////////////
//calls after mission start (after the briefing-screen):
		waitUntil {time > 1};
//////////////////////////////////////////////////////////////////////////////////
// place your custom content here:




	//everything that's only supposed to run on the server:
	if (isServer) then {
	// place your custom content here:
	
	
	
	
	};




//////////////////////////////////////////////////////////////////////////////////
//end of the init-script:
if (true) exitWith {};
//////////////////////////////////////////////////////////////////////////////////