//creator of the mission:
ADV_missionAuthor = "[SeL] Belbo // Adrian";
publicVariable "ADV_missionAuthor";

[
	{true},
		["Credits",
			"Mission", 
				format ["Diese Mission wurde von %1 höchstpersönlich gebaut.", ADV_missionAuthor]
		],
		["Credits",
			"ADV_MissionTemplate", 
				"Dieses Mission-Template wurde von [SeL] Belbo geschrieben und zusammengestellt.<br/>
				Es steht euch frei, Code daraus zu verwenden,<br/>
				solange keine sonstigen Lizenzen oder Urheberrechte<br/>
				dabei verletzt werden (siehe license.txt).<br/><br/>
				Viel Spaß beim Spielen!"
		],
		["Credits",
			"Verwendete Scripts", 
				"In dieser Mission wurden folgende Scripts verwendet:<br/><br/>
				FHQ TaskTracker von Varanon,<br/>
				Get-/set-loadout-script von Aeroson,<br/>
				IgiLoad von Igi_PL,<br/>
				RandomWeather von Meatball,<br/>
				Repetitive CleanUp von Aeroson,<br/>
				TAW View Distance von Tonic,<br/>
				TPW CIVS von tpw,<br/>
				UPSMON von Monsada,<br/>
				Werthles' Headless Script von Werthles,<br/>
				ZBE Caching Script von zorrobyte.<br/><br/>
				Vielen Dank an die Autoren!"
		]
] call FHQ_TT_addBriefing;