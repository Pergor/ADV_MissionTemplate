/*

Actions for choosing loadouts

*/

ADV_removeRespWithGear = {
	ADV_par_respWithGear = _this select 0;
	publicVariable "ADV_par_respWithGear";
	if (ADV_par_respWithGear <= 1) then {
		[{player removeEventHandler ["respawn",ADV_respawn_EVH];},"BIS_fnc_spawn",true] call BIS_fnc_MP;
	};
};

ADV_loadoutActionToAdd = false;
ADV_loadoutActionToAddBasic = true;
ADV_loadoutActionToAddAdmin = true;
{
	while {true} do {
		waitUntil {ADV_loadoutActionToAddAdmin};
		waitUntil {ADV_loadoutActionToAddBasic};
		sleep 0.5;
		_x addAction [("<t color=""#00FF00"">" + ("Loadouts auswählen") + "</t>"),{ADV_loadoutActionToAddBasic = false; ADV_loadoutActionToAdd = true; (_this select 0) removeAction (_this select 2);},nil,3,false,true,"","player distance cursortarget <5"];
		
		waitUntil {ADV_loadoutActionToAdd};
		_x addAction [("<t color=""#00FF00"">" + ("Sektionsführer") + "</t>"),{["command",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("Gruppenführer") + "</t>"),{["leader",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("Truppführer") + "</t>"),{["ftLeader",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];	
		_x addAction [("<t color=""#00FF00"">" + ("Sanitäter") + "</t>"),{["medic",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("MG-Schütze") + "</t>"),{["AR",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("asst. MG-Schütze") + "</t>"),{["assAR",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("LMG-Schütze") + "</t>"),{["lmg",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("AT-Spezialist") + "</t>"),{["AT",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("asst. AT-Spezialist") + "</t>"),{["assAT",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("Grenadier") + "</t>"),{["gren",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("Einsatzersthelfer") + "</t>"),{["cls",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("Soldat") + "</t>"),{["soldier",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		if (ADV_par_opfWeap == 0) then {
			_x addAction [("<t color=""#00FF00"">" + ("Soldat (AT)") + "</t>"),{["soldierAT",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		};
		_x addAction [("<t color=""#00FF00"">" + ("Zielfernrohrschütze") + "</t>"),{["marksman",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("Pionier") + "</t>"),{["spec",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("Drohnenspezialist") + "</t>"),{["uavOP",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("Scharfschütze") + "</t>"),{["sniper",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("Beobachter") + "</t>"),{["spotter",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("Fahrer") + "</t>"),{["driver",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("Kampftaucher") + "</t>"),{["diver",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("Kampftaucher-Sanitäter") + "</t>"),{["diver_medic",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("Kampftaucher-Pionier") + "</t>"),{["diver_spec",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		_x addAction [("<t color=""#00FF00"">" + ("Pilot") + "</t>"),{["pilot",(_this select 0)] spawn ADV_opf_fnc_chooseLoadout;},nil,3,false,true,"","player distance cursortarget <5"];
		
		_x addAction [("<t color=""#FFFFFF"">" + ("Zurück") + "</t>"),{removeAllActions (_this select 0); ADV_loadoutActionToAddBasic = true; ADV_loadoutActionToAdd = false;},nil,3,false,true,"","player distance cursortarget <5"];
		
		[_x] spawn {
			_target = _this select 0;
			if (servercommandavailable "#kick") then {
				ADV_loadout_dispenser = _target;
				_target addAction [("<t color=""#FFFFFF"">" + ("Loadout-Auswahl deaktivieren") + "</t>"),{
					[{removeAllActions ADV_loadout_dispenser;},"BIS_fnc_spawn",true] call BIS_fnc_MP;
					ADV_loadoutActionToAddAdmin = false;publicVariable "ADV_loadoutActionToAddAdmin";
					[] spawn {
						sleep 1;
						ADV_loadout_dispenser addAction [("<t color=""#FFFFFF"">" + ("Loadout-Auswahl reaktivieren") + "</t>"),{
							ADV_loadoutActionToAddAdmin = true;publicVariable "ADV_loadoutActionToAddAdmin";
							ADV_loadoutActionToAddBasic = true;publicVariable "ADV_loadoutActionToAddBasic";
							(_this select 0) removeAction (_this select 2);
						},nil,3,false,true,"","player distance cursortarget <5"];
					};
				},nil,3,false,true,"","player distance cursortarget <5"];
				if (ADV_par_respWithGear == 2) then {
					_target addAction [("<t color=""#FFFFFF"">" + ("Gear-Respawn deaktivieren") + "</t>"),{[0] call ADV_removeRespWithGear},nil,3,false,false,"","player distance cursortarget <5"];
					_target addAction [("<t color=""#FFFFFF"">" + ("Gear-Respawn reaktivieren") + "</t>"),{[2] call ADV_removeRespWithGear},nil,3,false,false,"","player distance cursortarget <5"];
					sleep 1;
				};
				sleep 0.5;
			};
		};
		ADV_loadoutActionToAdd = false;
		sleep 0.5;
	};
} forEach _this;

if (true) ExitWith {};