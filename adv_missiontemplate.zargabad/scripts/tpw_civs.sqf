/* 
TPW CIVS - Ambient civilians
Author: tpw 
Date: 20141111
Version: 1.42
Requires: CBA A3, tpw_core.sqf
Compatibility: SP, MP client

Disclaimer: Feel free to use and modify this code, on the proviso that you post back changes and improvements so that everyone can benefit from them, and acknowledge the original author (tpw) in any derivative works.     

To use: 
1 - Save this script into your mission directory as eg tpw_civs.sqf
2 - Call it with 0 = [10,150,5,5,4,50,0,8,10,1] execvm "scripts\tpw_civs.sqf"; where 5 = start delay,150 = radius, 15 = number of waypoints, 5 = how many houses per civilian, 4 = maximum squad inflicted civ casualties, 50 = max total casualties, 0 = what to do if casualty thresholds exceeded (0 - nothing, 1 - popup message, 2 - end mission), 10 = maximum possible civs regardless of density, 15 = civilian interaction radius. Civs closer than this to other civs will stop and talk (0 - no interaction), 1 = no civilians spawned during combat (0 = civs spawned during combat)

THIS SCRIPT WON'T RUN ON DEDICATED SERVERS
*/

if (isDedicated) exitWith {};
if (count _this < 10) exitwith {hint "TPW CIVS incorrect/no config, exiting."};
if (_this select 3 == 0) exitwith {};
WaitUntil {!isNull FindDisplay 46};
WaitUntil {!isnil "tpw_core_sunangle"};

private ["_clothes","_sqname","_centrec"];

// READ IN VARIABLES
tpw_civ_version = "1.42"; // Version string
tpw_civ_sleep = _this select 0;
tpw_civ_radius = _this select 1;
tpw_civ_waypoints = _this select 2;
tpw_civ_density = _this select 3;
tpw_civ_maxsquadcas  = _this select 4;
tpw_civ_maxallcas  = _this select 5;
tpw_civ_casdisplay = _this select 6;
tpw_civ_maxciv = _this select 7;
tpw_civ_interact = _this select 8;
tpw_civ_nocombatspawn = _this select 9;

// DFAULT VALUES IF MP
if (isMultiplayer) then 
	{
		tpw_civ_sleep = 10;
		tpw_civ_radius = 150;
		tpw_civ_waypoints = 4;
		tpw_civ_density = 4;
	};

// VARIABLES
tpw_civ_oldpos = [0,0,0];
tpw_civ_civarray = []; // array holding spawned civs
tpw_civ_houses = []; // array holding civilian houses near player
tpw_civ_civnum = 0; // number of civs to spawn
tpw_civ_debug = false; // Debugging
tpw_civ_allcas = 0; // all civ casualities 
tpw_civ_squadcas = 0; // civ casualities caused by squad
tpw_civ_active = true; // global activate/deactivate
tpw_civ_exclude = false; // player near exclusion object
tpw_civ_minstoptime = 6; // minimum time civs will interact
tpw_civ_maxstoptime = 10; // maximum time civs will interact
tpw_civ_resettime = tpw_civ_maxstoptime * 3; // time before civ can interact again
tpw_civ_stoprange = tpw_civ_maxstoptime - tpw_civ_minstoptime; 
tpw_civ_spawntime = 0; // Will be set up to 5 minutes past the last suppression event

tpw_civ_civanims = [
"HubBriefing_think",
"HubBriefing_lookaround1",
"HubBriefing_lookaround2",
"HubBriefing_pointleft",
"HubBriefing_pointright",
"HubBriefing_scratch",
"HubBriefing_stretch"
];

_greekclothes = [
"U_Competitor",
"U_C_HunterBody_grn",
"U_C_Poloshirt_blue",
"U_C_Poloshirt_burgundy",
"U_C_Poloshirt_redwhite",
"U_C_Poloshirt_salmon",
"U_C_Poloshirt_stripped",
"U_C_Poloshirt_tricolour",
"U_C_Poor_1",
"U_C_Poor_2",
"U_IG_Guerilla2_2",
"U_IG_Guerilla2_3",
"U_IG_Guerilla3_1",
"U_IG_Guerilla3_2",
"U_NikosBody",
"U_Marshal",
"U_C_Journalist",
"U_Rangemaster"
];

// DELAY
sleep tpw_civ_sleep;

// CREATE AI CENTRES SO SPAWNED UNITS KNOW WHO'S AN ENEMY
_centerC = createCenter civilian;

// IF CIV IS SHOT BY PLAYER
tpw_civ_fnc_casualty = 
    {
    private ["_civ","_shooter"];
	_civ = _this select 0;
	_shooter = _this select 1;
	if (_civ getvariable ["tpw_civ_cas",0] == 0) then
		{
		_civ setvariable ["tpw_civ_cas",1];
		tpw_civ_allcas = tpw_civ_allcas + 1;
		if (_shooter in (units (group player))) then 
			{
			tpw_civ_squadcas = tpw_civ_squadcas + 1;
			};
		};
	if (tpw_civ_allcas > tpw_civ_maxallcas || tpw_civ_squadcas > tpw_civ_maxsquadcas) then 
		{
		switch tpw_civ_casdisplay do
			{
			case 1: 
				{
				hint format ["Warning: significant civilian casualties!\n %1 total casualties.\n%2 attributed to your squad.",tpw_civ_allcas,tpw_civ_squadcas];
				};
			case 2:
				{
				[nil,false,nil] call BIS_fnc_endMission;
				};
			};	
		};
	};

// SPAWN CIV INTO EMPTY GROUP
tpw_civ_fnc_civspawn =
	{
	private ["_civtype","_civ","_spawnpos","_i","_ct","_sqname","_house","_wp","_wppos"];
	
	// Only bother if enough time has passed since battle
	if (time < tpw_civ_spawntime) exitwith {};
	
	// Pick a random house for civ to spawn into
	_spawnpos = getpos (tpw_civ_houses select (floor (random (count tpw_civ_houses))));
	_civtype = tpw_core_civs select (floor (random (count tpw_core_civs)));

	//Spawn civ into empty group
	_sqname = creategroup civilian;
	_civ = _sqname createUnit [_civtype,_spawnpos, [], 0, "FORM"]; 
	_civ setskill 0;
	_civ disableAI 'TARGET';
	_civ disableAI 'AUTOTARGET';
	
	// Random uniform if greek
	if (["c_man",str _civtype] call BIS_fnc_inString) then
		{
		_civ forceAddUniform (_greekclothes select  (floor (random (count _greekclothes))));
		};
	
	//Mark it as owned by this player
	_civ setvariable ["tpw_civ_owner", [player],true];

	//Add killed/hit eventhandlers
	_civ addeventhandler ["Hit",{_this call tpw_civ_fnc_casualty}];
	_civ addeventhandler ["Killed",{_this call tpw_civ_fnc_casualty}];

	//Add it to the array of civs for this player
	tpw_civ_civarray set [count tpw_civ_civarray,_civ];

	//Speed and behaviour
	_sqname setspeedmode "LIMITED";
	_sqname setBehaviour "SAFE";
	
	// Prevent "chimp walking"
	_civ addeventhandler ["animstatechanged",
		{
		private ["_unit","_anim"];
		_unit = _this select 0;
		_anim = _this select 1;
		if ( // Chimp walking
		_anim == "AmovPknlMwlkSnonWnonDf" ||
		_anim == "AmovPknlMrunSnonWnonDf" 
		) then 
			{
			_unit setunitpos "auto";
			_unit switchmove "AmovPknlMstpSnonWnonDnon_AmovPercMstpSnonWnonDnon";
			};
		}];

	//Assign waypoints
	for "_i" from 1 to tpw_civ_waypoints do
		{
		waituntil
			{
			sleep 0.2;
			if (count tpw_civ_houses > 0) then 
				{
				_house = tpw_civ_houses select (floor (random (count tpw_civ_houses)));
				}
			else
				{
				_house = nearestbuilding (leader _sqname); 
				};
			((leader _sqname) distance _house < 150); 
			};
		_wppos = getpos _house;
		_wp =_sqname addWaypoint [_wppos,5];
		_wp setWaypointCompletionRadius 5;

		if (_i == tpw_civ_waypoints) then 
			{
			_wp setwaypointtype "CYCLE";
			} else
			{
			_wp setWaypointType "MOVE";
			};
		};
	};
    
// SEE IF ANY CIVS OWNED BY OTHER PLAYERS ARE WITHIN RANGE, WHICH CAN BE USED INSTEAD OF SPAWNING A NEW CIV
tpw_civ_fnc_nearciv =
	{
	private ["_owner","_shareflag"];
	_shareflag = 0;
	if (isMultiplayer) then         
		{
			{
			// Live units within range
			if (_x distance vehicle player < tpw_civ_radius && alive _x) then 
				{
				_owner = _x getvariable ["tpw_civ_owner",[]];

				//Units with owners, but not this player
				if ((count _owner > 0) && !(player in _owner)) exitwith
					{
					_shareflag = 1;
					_owner set [count _owner,player]; // add player as another owner of this civ
					_x setvariable ["tpw_civ_owner",_owner,true]; // update ownership
					tpw_civ_civarray set [count tpw_civ_civarray,_x]; // add this civ to the array of civs for this player
					};
				};
			} foreach allunits;
		};    

	//Otherwise, spawn a new civ
	if (_shareflag == 0) then 
		{
		[] call tpw_civ_fnc_civspawn;    
		};     
	};
	
// PERIODICALLY UPDATE POOL OF ENTERABLE HOUSES NEAR PLAYER, DETERMINE MAX CIVILIAN NUMBER, DISOWN CIVS FROM DEAD PLAYERS IN MP
0 = [] spawn 
	{
	while {true} do
		{
		if (tpw_civ_oldpos distance position player > (tpw_civ_radius / 2)) then
			{
			tpw_civ_oldpos = position player;
			private ["_civarray","_deadplayer","_housestring","_uninhab","_house","_exc","_i"];
			
			// Scan for habitable houses 
			[tpw_civ_radius] call tpw_core_fnc_houses;
			tpw_civ_houses = tpw_core_houses;
			tpw_civ_civnum = floor ((count tpw_civ_houses) / tpw_civ_density);			
			if (tpw_civ_civnum > tpw_civ_maxciv) then
					{
					tpw_civ_civnum = tpw_civ_maxciv;
					};
					
			tpw_civ_exclude = false;

			// Fewer civs at night
			if (daytime < 5 || daytime > 20) then 
				{
				tpw_civ_civnum = floor (tpw_civ_civnum / 2);
				};
			
			// Refresh array of exclusion objects
			tpw_civ_excarray = [];
			tpw_civ_exclude = false;	
			if !(isnil "tpwcivexc") then {tpw_civ_excarray set [count tpw_civ_excarray,tpwcivexc]};
			if !(isnil "tpwcivexc_1") then {tpw_civ_excarray set [count tpw_civ_excarray,tpwcivexc_1]};	
			if !(isnil "tpwcivexc_2") then {tpw_civ_excarray set [count tpw_civ_excarray,tpwcivexc_2]};
			if !(isnil "tpwcivexc_3") then {tpw_civ_excarray set [count tpw_civ_excarray,tpwcivexc_3]};
			if !(isnil "tpwcivexc_4") then {tpw_civ_excarray set [count tpw_civ_excarray,tpwcivexc_4]};
			if !(isnil "tpwcivexc_5") then {tpw_civ_excarray set [count tpw_civ_excarray,tpwcivexc_5]};
			if !(isnil "tpwcivexc_6") then {tpw_civ_excarray set [count tpw_civ_excarray,tpwcivexc_6]};
			if !(isnil "tpwcivexc_7") then {tpw_civ_excarray set [count tpw_civ_excarray,tpwcivexc_7]};
			if !(isnil "tpwcivexc_8") then {tpw_civ_excarray set [count tpw_civ_excarray,tpwcivexc_8]};
			if !(isnil "tpwcivexc_9") then {tpw_civ_excarray set [count tpw_civ_excarray,tpwcivexc_9]};			
		
			// No houses to spawn at if player near exclusion object
			for "_i" from 0 to (count tpw_civ_excarray - 1) do
				{
				_exc = tpw_civ_excarray select _i;
				if (_exc distance position vehicle player < tpw_civ_radius) exitwith
					{
					tpw_civ_exclude = true;
					tpw_civ_houses = [];
					};	
				};
				
			// Check if any players have been killed and disown their civs
			if (isMultiplayer) then 
				{
					{
					if ((isplayer _x) && !(alive _x)) then
						{
						_deadplayer = _x;
						_civarray = _x getvariable ["tpw_civarray"];
							{
							_x setvariable ["tpw_civ_owner",(_x getvariable "tpw_civ_owner") - [_deadplayer],true];
							} foreach _civarray;
						};
					} foreach allunits;    
				};
			};	
		sleep 10;
		};
	};

// CIV INTERACTION LOOP - NEARBY CIVS WILL MOVE TOWARDS EACH OTHER AND STOP TO "TALK"
if (tpw_civ_interact > 0) then
	{
	[] spawn
		{
		while {true} do
			{
			private ["_civ","_test","_other","_i"];
			for "_i" from 0 to (count tpw_civ_civarray - 1) do
				{
				_civ = tpw_civ_civarray select _i;
				_test = tpw_civ_civarray - [_civ]; // all the other civs but this one
					
					// Civ interact if near another civ
				for "_i" from 0 to (count _test - 1) do	
					{
					_other = _test select _i;
					if (
					_other distance _civ < tpw_civ_interact && // another civ nearby
					{_civ getvariable ["tpw_civ_stopped",0] == 0} && // civ is not already stopped
					{stance _civ == "STAND"} &&  // civ is standing up
					{stance _OTHER == "STAND"}// other civ is standing up
					) exitwith
						{						
						_civ setvariable ["tpw_civ_stopped",1]; // unit can't be stopped again
						
						// Move towards other civ
						[_civ,_other] spawn
							{
							private ["_civ","_other","_dir","_ct","_anim"];
							_civ = _this select 0;
							_other = _this select 1;
							_ct = 0;
							waituntil 
								{
								sleep 0.5;
								_ct = _ct + 1;
								_civ domove (position _other);
								(_civ distance _other < 3 || _ct > 50)
								};
							_dir = [_civ,_other] call bis_fnc_dirto; // direction to nearest civ
							_civ setdir _dir; // face nearest civ
							_civ disableai "move"; // stop moving 
							sleep random 2;
							_anim = tpw_civ_civanims select (floor (random (count tpw_civ_civanims))); // talking anim
							_civ switchmove _anim;
							sleep tpw_civ_minstoptime;
							_civ switchmove "AmovPercMstpSrasWnonDnon";
							};

						_civ setvariable ["tpw_civ_restart",diag_ticktime + tpw_civ_minstoptime + random tpw_civ_stoprange]; // how long til unit moves again
						_civ setvariable ["tpw_civ_reset",diag_ticktime + tpw_civ_resettime]; // how long until unit can be stopped again
						};
					};
				
				// If enough time has passed since stopping then move
				if	(diag_ticktime > _civ getvariable ["tpw_civ_restart",0]) then
					{
					_civ enableai "move"; // start moving
					};
				
				// If enough time has passed then allow stopping				
				if	(diag_ticktime > _civ getvariable ["tpw_civ_reset",0]) then
					{
					_civ setvariable ["tpw_civ_stopped",0]; // unit can be stopped again
					};	
				};
			sleep 5;	
			};	
		};
	};	
	
// MAIN LOOP - ADD AND REMOVE CIVS AS NECESSARY
while {true} do 
	{
	if (tpw_civ_active) then
		{
		private ["_group","_deleteradius","_civ","_i"];
		tpw_civ_removearray = [];

		//Debugging
		if (tpw_civ_debug) then {hintsilent format ["Civs:%1 Houses:%2",count tpw_civ_civarray,count tpw_civ_houses]};
		
		// No new civs if there's combat (as determined by TPW_EBS suppression)
		if (!(isnil "tpw_ebs_active") && {tpw_ebs_active}) then 
			{
				{
				if (_x getvariable "tpw_ebs_supstate" >= 2 && (tpw_civ_nocombatspawn == 1)) exitwith 
					{
					tpw_civ_spawntime = time + (random 300);
					tpw_civ_exclude = true;
					};
				} foreach tpw_ebs_unitarray;
			};

		// Add civs if there are less than the calculated civilian density for the player's current location 
		if ((count tpw_civ_civarray < tpw_civ_civnum) && (count tpw_civ_houses > 0)) then
			{
			[] call tpw_civ_fnc_nearciv;
			};

		// Shrink deletion radius if near an exclusion zone, to get rid of civs quicker
		if (tpw_civ_exclude) then
			{
			_deleteradius = tpw_civ_radius / 4;
			} 
		else
			{
			_deleteradius = tpw_civ_radius;
			};
			
		for "_i" from 0 to (count tpw_civ_civarray - 1) do
			{
			_civ = tpw_civ_civarray select _i;
			
			// Remove dead civ from players array (but leave body)
			if !(alive _civ) then 
				{
				tpw_civ_removearray set [count tpw_civ_removearray,_civ];    
				}
				else
				{
				// Civs run in the rain
				if (rain > 0.1) then 
					{
					_civ setspeedmode "FULL";
					}
				else
					{
					_civ setspeedmode "LIMITED";
					};
					
				// Check if civ is out of range and not visible to player. If so, disown it and remove it from players civ array    
				if (_civ distance vehicle player > _deleteradius && ((lineintersects [eyepos player,getposasl _civ,player,_civ]) || (terrainintersectasl [eyepos player,getposasl _civ]))) then
					{
					_civ setvariable ["tpw_civ_owner", (_civ getvariable "tpw_civ_owner") - [player],true];            
					tpw_civ_removearray set [count tpw_civ_removearray,_civ];    
					};

				// Delete the live civ and its waypoints if it's not owned by anyone    
				if (count (_civ getvariable ["tpw_civ_owner",[]]) == 0) then
					{
					_group = group _civ;	
					for "_i" from count (waypoints _group) to 1 step -1 do
						{
						deleteWaypoint ((waypoints _group) select _i);
						};
					deletevehicle _civ;
					deletegroup _group;
					};    
				};  
			};

		//Update player's civ array    
		tpw_civ_civarray = tpw_civ_civarray - tpw_civ_removearray;
		player setvariable ["tpw_civarray",tpw_civ_civarray,true];   
		};
	sleep random 10;    
	};  

