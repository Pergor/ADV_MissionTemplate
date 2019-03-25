class TAW_VDS {
	tag = "TAWVDS";

	class Initialize {
		file = "scripts\taw_vd";
		class stateTracker {
			ext = ".fsm";
			//postInit = 1;
			headerType = -1;
		};
		
		class init {
			postInit = 1;
		};
			
		class onSliderChanged {};
		class onTerrainChanged {};
		class updateViewDistance {};
		class openMenu {};
		class onChar {};
		class openSaveManager {};
		class onSavePressed {};
		class onSaveSelectionChanged {};
	};
};