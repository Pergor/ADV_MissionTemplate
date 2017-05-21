/*
 * Author: Belbo
 *
 * Contains the briefings that are only available to the commanders.
 * Utilizes fhq_tt-functions (more information available in the readme-folder).
 * For inserting a marker: <marker name='MARKER'>TEXT</marker>
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call adv_fnc_leaderBriefing;
 *
 * Public: No
 */

[] spawn {
	waitUntil {!isNil "commander_1"};
	[
		commander_1,
		[
			//place your briefing for the blufor commander here:
			"Geheime Kommandosache", 
				"Ein Briefing nur für den Commander."
		]
	] call FHQ_TT_addBriefing;
};

[] spawn {
	waitUntil {!isNil "opf_commander_1"};
	[
		opf_commander_1,
		[
			//place your briefing for the opfor commander here:
			"Geheime Kommandosache", 
				"Ein Briefing nur für den Commander."
		]
	] call FHQ_TT_addBriefing;
};

[] spawn {
	waitUntil {!isNil "ind_commander_1"};
	[
		ind_commander_1,
		[
			//place your briefing for the indfor commander here:
			"Geheime Kommandosache", 
				"Ein Briefing nur für den Commander."
		]
	] call FHQ_TT_addBriefing;
};

///////////// Don't edit below this line if you don't know what you're doing. /////////////

/*
[ { !isNil "commander_1" }, _commander_briefing, []] call CBA_fnc_waitUntilAndExecute;
[ { !isNil "opf_commander_1" }, _opf_commander_briefing, []] call CBA_fnc_waitUntilAndExecute;
[ { !isNil "ind_commander_1" }, _ind_commander_briefing, []] call CBA_fnc_waitUntilAndExecute;
*/


nil;