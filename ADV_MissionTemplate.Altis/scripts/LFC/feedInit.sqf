waitUntil {!isnull player};
private ["_feedArray","_MonitorName","_array","_newArray"];

_monitorArray=(_this select 0);
_monitorHDD=_monitorArray select 0;
_array=(_this select 1);
_MonitorName= format ["%1",_monitorHDD];

   _newArray=[];

	{
    if (isNil "_x") then {
				}else{	
				       _call = format ["%1",_x];
						call (compile _call);
						_newArray=_newArray+[call(compile _call)];
					};
	} forEach _array;
	
	_feedArray=server getvariable _MonitorName;	
	
		if (isnil "_feedArray")
			then {
			_feedArray=[];
			{
			if (isnil "_x") then {}else{_feedArray=_feedArray + [_x]; };
			}foreach _newArray;
			
			server setvariable [_MonitorName,_feedArray,true];
					};
					
	player setvariable ["MonName",_MonitorName];

	
		{
    if (isNil "_x") then {
				}else{	
				       _call = format ["%1",_x];
						call (compile _call);
						_newArray=_newArray+[call(compile _call)];
					};
	} forEach _array;
	
	waituntil {!isnil "_MonitorName"};		
		_feedArray=server getvariable _MonitorName;

	if	((player in _newArray)and !(player in _feedArray)) then {
			
		_feedArray=_feedArray +[player];
		server setvariable [_MonitorName,_feedArray,true];
						};
	
	_feedArray=server getvariable _MonitorName;	

if (!isserver || !isdedicated) 
		then {
			{
		null = [_x,_feedArray,server] execVM "scripts\LFC\livefeed.sqf";
		_x setObjectTexture [0,'#(argb,8,8,3)color(0,0,1,1)'];
		_x allowdamage false;
		_x enablesimulation false;
			}foreach _monitorArray;
			};

	{
	_x setvariable ["MonName",_MonitorName];
	_x setvariable ["MonitorArray",_monitorArray];
	
if (isplayer _x) 
	then {

	_x addEventHandler ["Respawn","CALL fnc_PLAYER_KILLED"];
					
			}else{
			
			_x addmpEventHandler ["MPkilled","CALL fnc_AI_KILLED"];	
		
			};
			
	}foreach _feedArray;
	

	
fnc_AI_KILLED={

	_unit = _this select 0;
	_corpse = _this select 1;
	
		_MonitorName=_unit getvariable "MonName";
		_monitorArray=_unit getvariable "MonitorArray";
		
		
		_feedArray=server getvariable _MonitorName;
		_feedArray=_feedArray -[_unit];	

				server setvariable [_MonitorName,_feedArray,true];

};


fnc_PLAYER_KILLED={

	_unit = _this select 0;
	_corpse = _this select 1;
	
			_MonitorName=_unit getvariable "MonName";
			_monitorArray=_unit getvariable "MonitorArray";
			
			
		_feedArray=server getvariable _MonitorName;
		_feedArray=_feedArray -[_corpse];
		_feedArray=_feedArray +[_unit];
						
						_feedArray=_feedArray call BIS_fnc_arrayShuffle;			
				
		server setvariable [_MonitorName,_feedArray,true];

};


[_monitorArray,_MonitorName] spawn {

	private ["_monitorArray","_MonitorName"];
	
	_monitorArray=(_this select 0);
	_MonitorName=(_this select 1);
	
while {true} do {

	_feedArray=server getvariable _MonitorName;
	_oldArray = format ["%1",_feedArray];
		
		sleep 5;

	_feedArray=server getvariable _MonitorName;
	_newArray = format ["%1",_feedArray];
	
		if (_newArray != _oldArray || (count _feedArray) <= 1) then{	
				{
			null = [_x,_feedArray] execVM "scripts\LFC\livefeed.sqf";			
				}foreach _monitorArray;
			};
		};
};