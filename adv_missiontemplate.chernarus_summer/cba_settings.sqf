/*
 * Author: Belbo
 *
 * Contains all cba-settings for this mission.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * force VARIABLE = override client settings.
 * force force = override mission and client settings (only for server).
 *
 * Public: Yes
 */

//settings for tfar 1.0:
force TFAR_giveLongRangeRadioToGroupLeaders = false;
force TFAR_givePersonalRadioToRegularSoldier = false;
force TFAR_giveMicroDagrToSoldier = false;
force force TFAR_SameSRFrequenciesForSide = true;
force force TFAR_SameLRFrequenciesForSide = true;
force TFAR_fullDuplex = false;
force TFAR_enableIntercom = true;
force TFAR_objectInterceptionEnabled = false;
force TFAR_spectatorCanHearEnemyUnits = true;
force TFAR_spectatorCanHearFriendlies = true;
/*
TFAR_default_radioVolume = 7;
TFAR_volumeModifier_forceSpeech = false;
TFAR_intercomVolume = 0.3;
TFAR_pluginTimeout = 10;
TFAR_tangentReleaseDelay = 300;
TFAR_PosUpdateMode = 0;
TFAR_ShowVolumeHUD = true;
TFAR_VolumeHudTransparency = 1;
TFAR_oldVolumeHint = false;
TFAR_showTransmittingHint = true;
TFAR_showChannelChangedHint = true;
*/

//settings for acre:
force acre_sys_core_unmuteClients = true;
force acre_sys_core_interference = true;
force acre_sys_core_fullDuplex = false;
force acre_sys_core_ignoreAntennaDirection = true;
force acre_sys_core_terrainLoss = 0.35;
force acre_sys_core_revealToAI = true;
/*
acre_sys_core_postmixGlobalVolume = 1;
acre_sys_core_premixGlobalVolume = 1;
acre_sys_core_spectatorVolume = 1;
*/

//settings for stHud:
force STHud_Settings_Occlusion = true;
STHud_Settings_SquadBar = false;
force STHud_Settings_RemoveDeadViaProximity = true;
/*
STHud_Settings_Font = "PuristaSemibold";
STHud_Settings_HUDMode = 3;
STHud_Settings_TextShadow = 1;
STHud_Settings_ColourBlindMode = "Normal";
*/

//settings for SAN Headlamps:
SAN_Headlamp_Arcade = false;
SAN_Headlamp_RenderDistance = 1500;
SAN_Headlamp_Multiplayer_UpdateRate = 30;
SAN_Headlamp_AI_UpdateRate = 30;
SAN_Headlamp_SoundClickEnabled = true;

//settings for BWmod:
BWA3_NaviPad_showMembers = true;

//settings for tfar prior to 1.0:
force TF_no_auto_long_range_radio = true;
force TF_give_personal_radio_to_regular_soldier = false;
force TF_give_microdagr_to_soldier = false;
force TF_same_sw_frequencies_for_side = true;
force TF_same_lr_frequencies_for_side = true;
force TF_same_dd_frequencies_for_side = true;
//TF_default_radioVolume = 7;

//settings for ASR AI:
asr_ai3_main_setskills = true;
asr_ai3_main_seekcover = true;
asr_ai3_main_usebuildings = 0.8;
asr_ai3_main_getinweapons = 0.5;
asr_ai3_main_rearm = 0;
asr_ai3_main_rearm_mags = 0;
asr_ai3_main_rearm_fak = 0;
asr_ai3_main_radiorange = 0;
asr_ai3_main_rrdelaymin = 5;
asr_ai3_main_rrdelayplus = 10;
asr_ai3_main_packNVG = true;
asr_ai3_main_fallDown = true;
asr_ai3_main_pgaistamina = false;
asr_ai3_main_onteamswitchleader = true;
asr_ai3_main_debug_setskill = false;
asr_ai3_main_debug_setcamo = false;
asr_ai3_main_debug_findcover = false;
asr_ai3_main_debug_rearm = false;
asr_ai3_main_debug_reveal = false;
