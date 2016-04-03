/*
Author: SENSEI
Last modified: 7/24/2015
Description: switches an array of units to another side and groups them
             returns group
__________________________________________________________________*/
private ["_side","_newgrp"];
params [["_units", [], [[]]], ["_side", SEN_enemySide]];

_newgrp = createGroup _side;
{[_x] joinSilent _newgrp} count _units;

_newgrp