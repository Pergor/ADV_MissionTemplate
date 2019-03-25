/*
 * Author: Belbo
 *
 * Add markers that you want to be seen only by one side:
 *
 */

//markers only visible for BLUFOR:
private _bluforMarker = ["base","base_1","flagMarker","flagMarker_1","briefArea","briefArea_1","crates","crates_1","garage_1","garage_2","garage_heavy_1","garage_heavy_2","garage_heavy_3","garage_air_1","garage_air_2"];

//markers only visible for OPFOR:
private _opforMarker = ["opf_base","opf_base_1","opf_flagMarker","opf_flagMarker_1","opf_briefArea","opf_briefArea_1","opf_crates","opf_crates_1","opf_garage_1","opf_garage_2","opf_garage_heavy_1","opf_garage_heavy_2","opf_garage_heavy_3","opf_garage_air_1","opf_garage_air_2"];

//markers only visible for INDFOR:
private _indMarker = ["ind_base","ind_base_1","ind_flagMarker","ind_flagMarker_1","ind_briefArea","ind_briefArea_1","ind_crates","ind_crates_1","ind_garage_1","ind_garage_2","ind_garage_heavy_1","ind_garage_heavy_2","ind_garage_heavy_3","ind_garage_air_1","ind_garage_air_2"];

//markers to be set more opaque, but still visible for all sides:
private _opaqueMarker = ["snipe_pos_1","snipe_pos_2"];

	///// DON'T edit below this line /////
	
_return = [_bluforMarker,_opforMarker,_indMarker,_opaqueMarker];

_return