//for inserting a marker: <marker name='MARKER'>TEXT</marker>

//briefing for leader
if (!isNil "commander_1") then {
	[
		group commander_1,
		[
			"Geheime Kommandosache", 
				"Ein Briefing nur für den Commander."
		]
	] call FHQ_TT_addBriefing;
};

if (!isNil "opf_commander_1") then {
	[
		group opf_commander_1,
		[
			"Geheime Kommandosache", 
				"Ein Briefing nur für den Commander."
		]
	] call FHQ_TT_addBriefing;
};

if (!isNil "ind_commander_1") then {
	[
		group ind_commander_1,
		[
			"Geheime Kommandosache", 
				"Ein Briefing nur für den Commander."
		]
	] call FHQ_TT_addBriefing;
};

if (true) exitWith {};