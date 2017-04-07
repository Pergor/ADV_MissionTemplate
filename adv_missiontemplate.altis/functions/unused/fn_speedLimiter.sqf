adv_speedLimiter_fnc_speedlimiter = {
	params ["_driver", "_vehicle"];

	if (ace_vehicles_isSpeedLimiter) exitWith {
		["Speedlimiter off"] call ace_common_fnc_displayTextStructured;
		playSound "ACE_Sound_Click";
		ace_vehicles_isSpeedLimiter = false;
	};

	["Speedlimiter on"] call ace_common_fnc_displayTextStructured;
	playSound "ACE_Sound_Click";
	ace_vehicles_isSpeedLimiter = true;

	private _maxSpeed = speed _vehicle max 5;

	[{
		params ["_args", "_idPFH"];
		_args params ["_driver", "_vehicle", "_maxSpeed"];

		if (ace_vehicles_isUAV) then {
			private _uavControll = UAVControl _vehicle;
			if ((_uavControll select 0) != _driver || _uavControll select 1 != "DRIVER") then {
				ace_vehicles_isSpeedLimiter = false;
			};
		} else {
			if (_driver != driver _vehicle) then {
				ace_vehicles_isSpeedLimiter = false;
			};
		};

		if (!ace_vehicles_isSpeedLimiter) exitWith {
			[_idPFH] call CBA_fnc_removePerFrameHandler;
		};

		private _speed = speed _vehicle;

		if (_speed > _maxSpeed) then {
			_vehicle setVelocity ((velocity _vehicle) vectorMultiply ((_maxSpeed / _speed) - 0.00001));
		};

	} , 0, [_driver, _vehicle, _maxSpeed]] call CBA_fnc_addPerFrameHandler;
};

if (!hasInterface) exitWith {};
ace_vehicles_isSpeedLimiter = false;

["ACE3 Vehicles", "ace_vehicles_speedLimiter", "Speed Limiter",
{
    private _connectedUAV = getConnectedUAV ACE_player;
    private _uavControll = UAVControl _connectedUAV;
    if ((_uavControll select 1) == "DRIVER") then {
        if !(_connectedUAV isKindOf "UGV_01_base_F") exitWith {false};
        ace_vehicles_isUAV = true;
        [_uavControll select 0, _connectedUAV] call adv_speedLimiter_fnc_speedlimiter;
        true
    } else {
        if !([ACE_player, objNull, ["isnotinside"]] call ace_common_fnc_canInteractWith) exitWith {false};
        if !(ACE_player == driver vehicle ACE_player &&
        {vehicle ACE_player isKindOf 'Car' ||
            {vehicle ACE_player isKindOf 'Tank'}}) exitWith {false};
        ace_vehicles_isUAV = false;
        [ACE_player, vehicle ACE_player] call adv_speedLimiter_fnc_speedlimiter;
        true
    };

},
{false},
[211, [false, false, false]], false] call CBA_fnc_addKeybind;

true;