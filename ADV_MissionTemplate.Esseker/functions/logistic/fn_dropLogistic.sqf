ADV_sriptfnc_dropLogistic = {
	params [
		["_crate", objNull, [objNull]],
		["_targetPos", [0,0,0], [[]]]
	];
	systemChat "ETA: ~3 minutes.";
	sleep 180;
	_targetPos = [_targetPos select 0, _targetPos select 1, 600];
	_chute = createVehicle ["B_Parachute_02_F", _targetPos, [], 0, "NONE"];
	_crate setPos _targetPos;
	{ _x addCuratorEditableObjects [[_crate],false] } forEach allCurators;
	_crate attachTo [_chute, [0, 0, -1]];
	_chute setVelocity [0,0,-50];
	_light = createVehicle ["Chemlight_red", (getPosATL _crate), [], 0, "NONE"];
	_IRlight = createVehicle ["B_IRStrobe", (getPosATL _crate), [], 0, "NONE"];
	{_x attachTo [_crate, [0, 0, 0]];} forEach [_light,_IRlight];
	[_crate,"G_40mm_SmokeGreen"] spawn {
		waitUntil {sleep 1; ((getPosATL (_this select 0)) select 2) < 30};
		_smoke = createVehicle [(_this select 1), (getPosATL (_this select 0)), [], 0, "NONE"];
		_smoke attachTo [(_this select 0), [0, 0, -1]];
		waitUntil {sleep 1; ((getPosATL (_this select 0)) select 2) < 2};
		detach (_this select 0);
	};
};

{
	ADV_action_dropLogistic = _x addAction [
		("<t color=""#FFFFFF"">" + ("Abwurf vorbereiten") + "</t>"), 
		{
			openmap true;
			[_this select 0] onMapSingleClick "openmap false; [_this select 0,_pos] spawn ADV_sriptfnc_dropLogistic; onmapsingleclick '';";
			(_this select 0) removeAction (_this select 2);
		},
		nil,3,false,true,"","player distance cursortarget <5"
	];
} forEach _this;

if (true) exitWith {};