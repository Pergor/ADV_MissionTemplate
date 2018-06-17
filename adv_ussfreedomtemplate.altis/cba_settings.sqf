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
force TFAR_AICanHearPlayer = true;
force TFAR_AICanHearSpeaker = true;
force TFAR_enableIntercom = true;
force TFAR_fullDuplex = false;
force TFAR_giveLongRangeRadioToGroupLeaders = false;
force TFAR_giveMicroDagrToSoldier = false;
force TFAR_givePersonalRadioToRegularSoldier = false;
force TFAR_objectInterceptionEnabled = false;
force TFAR_SameLRFrequenciesForSide = true;
force TFAR_SameSRFrequenciesForSide = true;
force TFAR_spectatorCanHearEnemyUnits = true;
force TFAR_spectatorCanHearFriendlies = true;
force TFAR_takingRadio = 2;
force TFAR_setting_defaultFrequencies_lr_east = "51,52,53,54,55,56,57,58,59";
force TFAR_setting_defaultFrequencies_lr_independent = "71,72,73,74,75,76,78,79";
force TFAR_setting_defaultFrequencies_lr_west = "51,52,53,54,55,56,57,58,59";
force TFAR_setting_defaultFrequencies_sr_east = "41,42,43,44,45,46,47,48,49";
force TFAR_setting_defaultFrequencies_sr_independent = "61,62,63,64,65,67,68,69";
force TFAR_setting_defaultFrequencies_sr_west = "41,42,43,44,45,46,47,48,49";
force TFAR_setting_DefaultRadio_Rifleman_West = "TFAR_rf7800str";
force TFAR_setting_DefaultRadio_Personal_West = "TFAR_anprc152";
force TFAR_setting_DefaultRadio_Backpack_west = "TFAR_rt1523g";
force TFAR_setting_DefaultRadio_Airborne_West = "TFAR_anarc210";
force TFAR_setting_DefaultRadio_Rifleman_East = "TFAR_pnr1000a";
force TFAR_setting_DefaultRadio_Personal_east = "TFAR_fadak";
force TFAR_setting_DefaultRadio_Backpack_east = "TFAR_mr3000";
force TFAR_setting_DefaultRadio_Airborne_east = "TFAR_mr6000l";
force TFAR_setting_DefaultRadio_Rifleman_Independent = "TFAR_anprc154";
force TFAR_setting_DefaultRadio_Personal_Independent = "TFAR_anprc148jem";
force TFAR_setting_DefaultRadio_Backpack_Independent = "TFAR_anprc155";
force TFAR_setting_DefaultRadio_Airborne_Independent = "TFAR_anarc164";
force tfar_radiocode_east = "_opfor";
force tfar_radiocode_independent = "_independent";
force tfar_radiocode_west = "_bluefor";
force tfar_radioCodesDisabled = false;
TFAR_Teamspeak_Channel_Name = "Arma3-TFAR";
TFAR_Teamspeak_Channel_Password = "123";
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

// ACRE2
acre_sys_core_fullDuplex = false;
acre_sys_core_ignoreAntennaDirection = true;
acre_sys_core_interference = true;
acre_sys_core_revealToAI = true;
acre_sys_core_terrainLoss = 0.35;
acre_sys_core_ts3ChannelName = "Arma3-TFAR";
acre_sys_core_ts3ChannelPassword = "123";
acre_sys_core_ts3ChannelSwitch = true;
acre_sys_core_unmuteClients = true;
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

//NIArms:
niarms_magSwitch = true;

//ADV-ACE CPR:
adv_aceCPR_chance_2 = 40;
adv_aceCPR_chance_1 = 15;
adv_aceCPR_chance_0 = 5;
adv_aceCPR_chance_aed = 85;
adv_aceCPR_timeAdd = 20;
adv_aceCPR_maxTime = 1200;

//ADV-ACE Splint:
adv_aceSplint_reopenChance = 0;
adv_aceSplint_reopenTime = 600;
adv_aceSplint_reuseChance = 80;

//ACE:
ace_advanced_ballistics_ammoTemperatureEnabled = true;
ace_advanced_ballistics_barrelLengthInfluenceEnabled = true;
ace_advanced_ballistics_bulletTraceEnabled = true;
ace_advanced_ballistics_disabledInFullAutoMode = true;
ace_advanced_ballistics_enabled = true;
ace_advanced_ballistics_muzzleVelocityVariationEnabled = true;
ace_advanced_ballistics_simulateForEveryone = false;
ace_advanced_ballistics_simulateForGroupMembers = false;
ace_advanced_ballistics_simulateForSnipers = true;
ace_advanced_ballistics_simulationInterval = 0.05;
ace_advanced_ballistics_simulationRadius = 3000;

ace_advanced_fatigue_enabled = true;
ace_advanced_fatigue_loadFactor = 0.9;
ace_advanced_fatigue_performanceFactor = 1.5;
ace_advanced_fatigue_recoveryFactor = 1.8;
ace_advanced_fatigue_terrainGradientFactor = 0.9;

ace_advanced_throwing_enablePickUp = true;
ace_advanced_throwing_enablePickUpAttached = false;

ace_arsenal_allowDefaultLoadouts = true;
ace_arsenal_allowSharedLoadouts = true;

ace_captives_allowHandcuffOwnSide = false;
ace_captives_allowSurrender = true;
ace_captives_requireSurrender = 2;
ace_captives_requireSurrenderAi = false;

ace_cargo_enable = true;
ace_cargo_paradropTimeCoefficent = 2.5;

ace_common_checkPBOsAction = 0;
ace_common_checkPBOsCheckAll = false;
ace_common_checkPBOsWhitelist = "[]";
ace_common_forceAllSettings = false;
ace_common_persistentLaserEnabled = true;

ace_cookoff_ammoCookoffDuration = 1;
ace_cookoff_enable = true;
ace_cookoff_enableAmmoCookoff = true;
ace_cookoff_enableAmmobox = true;
ace_cookoff_probabilityCoef = 0.8;

ace_explosives_explodeOnDefuse = true;
ace_explosives_punishNonSpecialists = true;
ace_explosives_requireSpecialist = false;

ace_finger_enabled = true;
ace_finger_maxRange = 10;

ace_frag_enableDebugTrace = false;
ace_frag_enabled = true;
ace_frag_maxTrack = 10;
ace_frag_maxTrackPerFrame = 10;
ace_frag_reflectionsEnabled = false;
ace_frag_spallEnabled = false;

ace_gforces_enabledFor = 1;

ace_goggles_effects = 2;
ace_goggles_showInThirdPerson = false;

ace_hearing_autoAddEarplugsToUnits = false;
ace_hearing_earplugsVolume = 1;
ace_hearing_enabledForZeusUnits = true;
ace_hearing_unconsciousnessVolume = 0.2;

ace_hitreactions_minDamageToTrigger = 0.1;

ace_interaction_disableNegativeRating = false;
ace_interaction_enableMagazinePassing = true;
ace_interaction_enableTeamManagement = true;

ace_laser_dispersionCount = 2;

ace_laserpointer_enabled = true;

ace_magazinerepack_timePerAmmo = 1.5;
ace_magazinerepack_timePerBeltLink = 8;
ace_magazinerepack_timePerMagazine = 2;

ace_map_BFT_Enabled = false;
ace_map_BFT_HideAiGroups = false;
ace_map_BFT_Interval = 1;
ace_map_BFT_ShowPlayerNames = false;

ace_map_defaultChannel = -1;
ace_map_gestures_enabled = true;
ace_map_gestures_interval = 0.03;
ace_map_gestures_maxRange = 7;
ace_map_mapGlow = true;
ace_map_mapIllumination = true;
ace_map_mapLimitZoom = false;
ace_map_mapShake = true;
ace_map_mapShowCursorCoordinates = true;

ace_markers_movableMarkersEnabled = false;
ace_markers_moveRestriction = 3;

ace_medical_AIDamageThreshold = 1;
ace_medical_ai_enabledFor = 2;
ace_medical_allowDeadBodyMovement = true;
ace_medical_allowLitterCreation = true;
ace_medical_allowUnconsciousAnimationOnTreatment = true;
ace_medical_amountOfReviveLives = -1;
ace_medical_bleedingCoefficient = 0.7;
ace_medical_blood_enabledFor = 2;
ace_medical_consumeItem_PAK = 0;
ace_medical_consumeItem_SurgicalKit = 0;
ace_medical_delayUnconCaptive = 0;
ace_medical_enableAdvancedWounds = false;
ace_medical_enableAirway = false;
ace_medical_enableFor = 0;
ace_medical_enableFractures = false;
ace_medical_enableOverdosing = true;
ace_medical_enableRevive = 1;
ace_medical_enableScreams = true;
ace_medical_enableUnconsciousnessAI = 0;
ace_medical_enableVehicleCrashes = true;
ace_medical_healHitPointAfterAdvBandage = true;
ace_medical_increaseTrainingInLocations = true;
ace_medical_keepLocalSettingsSynced = true;
ace_medical_level = 2;
//ace_medical_litterCleanUpDelay = 300;
//ace_medical_litterSimulationDetail = 1;
ace_medical_maxReviveTime = 900;
ace_medical_medicSetting = 2;
ace_medical_medicSetting_PAK = 2;
ace_medical_medicSetting_SurgicalKit = 1;
ace_medical_medicSetting_basicEpi = 1;
ace_medical_menu_allow = 1;
ace_medical_menu_maxRange = 3;
ace_medical_menu_useMenu = 1;
ace_medical_moveUnitsFromGroupOnUnconscious = false;
ace_medical_painCoefficient = 1;
ace_medical_painIsOnlySuppressed = false;
ace_medical_playerDamageThreshold = 2;
ace_medical_preventInstaDeath = true;
ace_medical_remoteControlledAI = true;
ace_medical_useCondition_PAK = 1;
ace_medical_useCondition_SurgicalKit = 0;
ace_medical_useLocation_PAK = 0;
ace_medical_useLocation_SurgicalKit = 0;
ace_medical_useLocation_basicEpi = 0;

ace_microdagr_mapDataAvailable = 1;

ace_missileguidance_enabled = 2;

ace_mk6mortar_airResistanceEnabled = true;
ace_mk6mortar_allowCompass = true;
ace_mk6mortar_allowComputerRangefinder = false;
ace_mk6mortar_useAmmoHandling = false;

//ace_nametags_playerNamesMaxAlpha = 0.8;
ace_nametags_playerNamesViewDistance = 10;
//ace_nametags_showCursorTagForVehicles = false;

ace_nightvision_aimDownSightsBlur = 0.2;
ace_nightvision_disableNVGsWithSights = false;
ace_nightvision_effectScaling = 0.2;
ace_nightvision_fogScaling = 0.5;
ace_nightvision_noiseScaling = 0.4;
ace_nightvision_shutterEffects = true;

ace_noradio_enabled = true;

//ace_overheating_displayTextOnJam = true;
ace_overheating_enabled = true;
ace_overheating_overheatingDispersion = true;
//ace_overheating_showParticleEffects = true;
//ace_overheating_showParticleEffectsForEveryone = false;
ace_overheating_unJamFailChance = 0.1;
ace_overheating_unJamOnreload = false;

ace_overpressure_distanceCoefficient = 1;

ace_parachute_hideAltimeter = false;

ace_pylons_enabled = true;
ace_pylons_rearmNewPylons = true;
ace_pylons_requireEngineer = false;
ace_pylons_requireToolkit = true;
ace_pylons_searchDistance = 20;
ace_pylons_timePerPylon = 5;

ace_quickmount_distance = 3;
ace_quickmount_enabled = true;
ace_quickmount_speed = 18;

ace_rearm_level = 1;
ace_rearm_supply = 0;

ace_refuel_hoseLength = 12;
ace_refuel_rate = 1;

ace_repair_addSpareParts = true;
ace_repair_autoShutOffEngineWhenStartingRepair = true;
ace_repair_consumeItem_toolKit = 0;
ace_repair_engineerSetting_fullRepair = 2;
ace_repair_engineerSetting_repair = 1;
ace_repair_engineerSetting_wheel = 0;
ace_repair_fullRepairLocation = 0;
ace_repair_repairDamageThreshold = 0.6;
ace_repair_repairDamageThreshold_engineer = 0.4;
ace_repair_wheelRepairRequiredItems = 1;

ace_respawn_bodyRemoveTimer = 0;
ace_respawn_removeDeadBodiesDisconnected = true;
ace_respawn_savePreDeathGear = false;

ace_scopes_correctZeroing = true;
ace_scopes_deduceBarometricPressureFromTerrainAltitude = false;
ace_scopes_defaultZeroRange = 100;
ace_scopes_enabled = true;
ace_scopes_forceUseOfAdjustmentTurrets = false;
ace_scopes_overwriteZeroRange = false;
ace_scopes_simplifiedZeroing = false;
ace_scopes_zeroReferenceBarometricPressure = 1013.25;
ace_scopes_zeroReferenceHumidity = 0;
ace_scopes_zeroReferenceTemperature = 15;

ace_spectator_enableAI = true;
ace_spectator_restrictModes = 0;
ace_spectator_restrictVisions = 0;

ace_switchunits_enableSafeZone = true;
ace_switchunits_enableSwitchUnits = false;
ace_switchunits_safeZoneRadius = 100;
ace_switchunits_switchToCivilian = false;
ace_switchunits_switchToEast = false;
ace_switchunits_switchToIndependent = false;
ace_switchunits_switchToWest = false;

ace_ui_allowSelectiveUI = false;
ace_ui_ammoCount = false;
ace_ui_groupBar = false;
ace_ui_gunnerAmmoCount = true;
ace_ui_gunnerZeroing = true;

ace_vehiclelock_defaultLockpickStrength = 10;
ace_vehiclelock_lockVehicleInventory = true;
ace_vehiclelock_vehicleStartingLockState = -1;

ace_viewdistance_enabled = false;
ace_viewdistance_limitViewDistance = 10000;

ace_weather_enabled = false;
ace_weather_enableServerController = false;
ace_weather_serverUpdateInterval = 60;
ace_weather_syncMisc = false;
ace_weather_syncRain = false;
ace_weather_syncWind = false;
ace_weather_updateInterval = 60;
ace_weather_windSimulation = true;

ace_winddeflection_enabled = true;
ace_winddeflection_simulationInterval = 0.05;
ace_winddeflection_simulationRadius = 3000;
ace_winddeflection_vehicleEnabled = true;

ace_zeus_autoAddObjects = false;
ace_zeus_radioOrdnance = false;
ace_zeus_remoteWind = false;
ace_zeus_revealMines = 0;
ace_zeus_zeusAscension = false;
ace_zeus_zeusBird = false;

acex_headless_delay = 15;
acex_headless_enabled = false;
acex_headless_endMission = 0;
acex_headless_log = false;

acex_sitting_enable = true;

acex_viewrestriction_mode = 0;
acex_viewrestriction_modeSelectiveAir = 0;
acex_viewrestriction_modeSelectiveFoot = 0;
acex_viewrestriction_modeSelectiveLand = 0;
acex_viewrestriction_modeSelectiveSea = 0;