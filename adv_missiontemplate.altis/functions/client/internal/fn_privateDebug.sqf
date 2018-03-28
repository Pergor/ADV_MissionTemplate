if !(getPlayerUID player in ["76561197985568467"]) exitWith {false};

if !(missionNamespace getVariable ["adv_var_adminCommandsApplied",false]) then {
	[] call adv_fnc_adminCommands;
};

private _handle = ["ace_unconscious", {
	_this spawn {
		params ["_unit","_state"];
		
		if !(_unit isEqualTo player) exitWith {};
		if !(getPlayerUID player in ["76561197985568467"]) exitWith {};
		
		_unit setVariable ["adv_var_belboIsUnconscious",_state];
		
		if (_state) then {
		
			while { (_unit getVariable "adv_var_belboIsUnconscious") } do {
				hintSilent "";
				
				private _RS = _unit getVariable ["ace_medical_inReviveState",false];
				private _CA = _unit getVariable ["ace_medical_inCardiacArrest",false];
				private _BV = _unit getVariable ["ace_medical_bloodVolume",100];
				private _HR = _unit getVariable ["ace_medical_heartRate",60];
				private _PN = _unit getVariable ["ace_medical_pain",0];
				private _BP = _unit getVariable ["ace_medical_bloodPressure",[80,120]];
				_BP params ["_BP_2","_BP_1"];
				
				private _RT = "N/A";
				if (_RS) then {
					private _RST = _unit getVariable ["ace_medical_reviveStartTime",nil];
					private _maxRT = missionNamespace getVariable ["ace_medical_maxReviveTime",600];
					_RT = floor ((_maxRT+_RST)-CBA_missionTime);
				};
				
				private _BL = 0;
				private _CT = "N/A";
				if (isClass(configFile >> "CfgPatches" >> "adv_aceCPR")) then {
					_BL = [_unit, _unit] call adv_aceCPR_fnc_getBloodLoss;
			
					if (_RS) then {
						private _maxRevTime = missionNamespace getVariable ["ace_medical_maxReviveTime",900];
						private _startTime = _unit getVariable ["ace_medical_reviveStartTime",0];
						private _cprMaxTime = missionNamespace getVariable ["adv_aceCPR_maxTime",900];
						private _timeLeft = _startTime + ( _maxRevTime min _cprMaxTime );
						_CT = abs ( (round (cba_missionTime - _timeLeft)) min 0 );
					};
				};
				
				private _format = ["Hey Belbo! Es sieht schlecht aus:
					\n Dein Revive State ist %1.
					\n Dein Cardiac Arrest State ist %2.
					\n Dein Blood Volume liegt bei %3%4.
					\n Dein Blutdruck liegt bei %5 zu %6.
					\n Deine Herzrate liegt bei %7 bpm.
					\n Du bist noch %8 Sekunden im Revive State.
					\n Dir bleiben noch %9 Sekunden für CPR.
					\n Dein Bloodloss beträgt %10.
					\n Du hast Schmerzen in Höhe von %11."
				,_RS,_CA,round _BV,"%",round _BP_1,round _BP_2,round _HR,_RT,_CT,_BL,_PN];
				
				hintSilent format _format;
				
				sleep 5;
				hintSilent "";
				
			};
			
		};
	};
}] call CBA_fnc_addEventHandler;

_handle