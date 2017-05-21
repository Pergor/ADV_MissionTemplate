//////// You are not allowed to change anything below this line! ////////
ADV_missionAuthor = getText (missionconfigfile >> "Author");
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
				Großer Dank geht an [SeL] LeWarz für viele hitzige Diskussionen über Loadouts, Gruppenzusammensetzungen und Fahrzeuge.<br/>
				Es steht euch frei, Code daraus zu verwenden,<br/>
				solange keine sonstigen Lizenzen oder Urheberrechte<br/>
				dabei verletzt werden (siehe license.txt).<br/><br/>
				Viel Spaß beim Spielen!"
		],
		["Credits",
			"Verwendete Scripts", 
				"In dieser Mission wurden folgende Scripts verwendet:<br/><br/>
				FHQ TaskTracker von Varanon,<br/>
				IgiLoad von Igi_PL,<br/>
				RandomWeather von Meatball,<br/>
				TAW View Distance von Tonic,<br/>
				TPW CIVS von tpw,<br/>
				UPSMON von Monsada,<br/>
				Werthles' Headless Script von Werthles,<br/>
				fn_ZenOccupyHouse by Zenophon,<br/>
				ZBE Caching Script von zorrobyte.<br/><br/>
				Vielen Dank an die Autoren!"
		]
] call FHQ_TT_addBriefing;