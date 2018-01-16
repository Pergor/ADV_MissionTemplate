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

//NIArms:
niarms_magSwitch = true;

//ACE:

force ace_advanced_ballistics_ammoTemperatureEnabled = true;
force ace_advanced_ballistics_barrelLengthInfluenceEnabled = true;
force ace_advanced_ballistics_bulletTraceEnabled = true;
force ace_advanced_ballistics_disabledInFullAutoMode = true;
force ace_advanced_ballistics_enabled = true;
force ace_advanced_ballistics_muzzleVelocityVariationEnabled = true;
force ace_advanced_ballistics_simulateForEveryone = false;
force ace_advanced_ballistics_simulateForGroupMembers = false;
force ace_advanced_ballistics_simulateForSnipers = true;
force ace_advanced_ballistics_simulationInterval = 0.05;
force ace_advanced_ballistics_simulationRadius = 3000;

force ace_advanced_fatigue_enabled = true;
force ace_advanced_fatigue_loadFactor = 0.9;
force ace_advanced_fatigue_performanceFactor = 1.5;
force ace_advanced_fatigue_recoveryFactor = 1.8;
force ace_advanced_fatigue_terrainGradientFactor = 0.9;

force ace_advanced_throwing_enablePickUp = true;
force ace_advanced_throwing_enablePickUpAttached = false;

force ace_arsenal_allowDefaultLoadouts = true;
force ace_arsenal_allowSharedLoadouts = true;

force ace_captives_allowHandcuffOwnSide = false;
force ace_captives_allowSurrender = true;
force ace_captives_requireSurrender = 2;
force ace_captives_requireSurrenderAi = false;

force ace_cargo_enable = true;
force ace_cargo_paradropTimeCoefficent = 2.5;

force ace_common_checkPBOsAction = 0;
force ace_common_checkPBOsCheckAll = false;
force ace_common_checkPBOsWhitelist = "[]";
force ace_common_forceAllSettings = false;
force ace_common_persistentLaserEnabled = true;

force ace_cookoff_ammoCookoffDuration = 1;
force ace_cookoff_enable = true;
force ace_cookoff_enableAmmoCookoff = true;
force ace_cookoff_enableAmmobox = true;
force ace_cookoff_probabilityCoef = 0.8;

force ace_explosives_explodeOnDefuse = true;
force ace_explosives_punishNonSpecialists = true;
force ace_explosives_requireSpecialist = false;

force ace_finger_enabled = true;
force ace_finger_maxRange = 10;

force ace_frag_enableDebugTrace = false;
force ace_frag_enabled = true;
force ace_frag_maxTrack = 10;
force ace_frag_maxTrackPerFrame = 10;
force ace_frag_reflectionsEnabled = false;
force ace_frag_spallEnabled = false;

force ace_gforces_enabledFor = 1;

force ace_goggles_effects = 2;
force ace_goggles_showInThirdPerson = false;

force ace_hearing_autoAddEarplugsToUnits = false;
force ace_hearing_earplugsVolume = 1;
force ace_hearing_enabledForZeusUnits = true;
force ace_hearing_unconsciousnessVolume = 0.2;

force ace_hitreactions_minDamageToTrigger = 0.1;

force ace_interaction_disableNegativeRating = false;
force ace_interaction_enableMagazinePassing = true;
force ace_interaction_enableTeamManagement = true;

force ace_laser_dispersionCount = 2;

force ace_laserpointer_enabled = true;

force ace_magazinerepack_timePerAmmo = 1.5;
force ace_magazinerepack_timePerBeltLink = 8;
force ace_magazinerepack_timePerMagazine = 2;

force ace_map_BFT_Enabled = false;
force ace_map_BFT_HideAiGroups = false;
force ace_map_BFT_Interval = 1;
force ace_map_BFT_ShowPlayerNames = false;

force ace_map_defaultChannel = -1;
force ace_map_gestures_enabled = true;
force ace_map_gestures_interval = 0.03;
force ace_map_gestures_maxRange = 7;
force ace_map_mapGlow = true;
force ace_map_mapIllumination = true;
force ace_map_mapLimitZoom = false;
force ace_map_mapShake = true;
force ace_map_mapShowCursorCoordinates = true;

force ace_markers_movableMarkersEnabled = false;
force ace_markers_moveRestriction = 1;

force ace_medical_AIDamageThreshold = 1;
force ace_medical_ai_enabledFor = 2;
force ace_medical_allowDeadBodyMovement = true;
force ace_medical_allowLitterCreation = true;
force ace_medical_allowUnconsciousAnimationOnTreatment = true;
force ace_medical_amountOfReviveLives = -1;
force ace_medical_bleedingCoefficient = 0.7;
force ace_medical_blood_enabledFor = 2;
force ace_medical_consumeItem_PAK = 0;
force ace_medical_consumeItem_SurgicalKit = 0;
force ace_medical_delayUnconCaptive = 0;
force ace_medical_enableAdvancedWounds = false;
force ace_medical_enableAirway = false;
force ace_medical_enableFor = 0;
force ace_medical_enableFractures = false;
force ace_medical_enableOverdosing = true;
force ace_medical_enableRevive = 1;
force ace_medical_enableScreams = true;
force ace_medical_enableUnconsciousnessAI = 0;
force ace_medical_enableVehicleCrashes = true;
force ace_medical_healHitPointAfterAdvBandage = true;
force ace_medical_increaseTrainingInLocations = true;
force ace_medical_keepLocalSettingsSynced = true;
force ace_medical_level = 2;
force ace_medical_litterCleanUpDelay = 300;
force ace_medical_litterSimulationDetail = 1;
force ace_medical_maxReviveTime = 900;
force ace_medical_medicSetting = 2;
force ace_medical_medicSetting_PAK = 2;
force ace_medical_medicSetting_SurgicalKit = 1;
force ace_medical_medicSetting_basicEpi = 1;
force ace_medical_menu_allow = 1;
force ace_medical_menu_maxRange = 3;
force ace_medical_menu_useMenu = 1;
force ace_medical_moveUnitsFromGroupOnUnconscious = false;
force ace_medical_painCoefficient = 1;
force ace_medical_painIsOnlySuppressed = false;
force ace_medical_playerDamageThreshold = 2;
force ace_medical_preventInstaDeath = true;
force ace_medical_remoteControlledAI = true;
force ace_medical_useCondition_PAK = 1;
force ace_medical_useCondition_SurgicalKit = 0;
force ace_medical_useLocation_PAK = 0;
force ace_medical_useLocation_SurgicalKit = 0;
force ace_medical_useLocation_basicEpi = 0;

force ace_microdagr_mapDataAvailable = 1;

force ace_missileguidance_enabled = 2;

force ace_mk6mortar_airResistanceEnabled = true;
force ace_mk6mortar_allowCompass = true;
force ace_mk6mortar_allowComputerRangefinder = false;
force ace_mk6mortar_useAmmoHandling = false;

force ace_nametags_playerNamesMaxAlpha = 0.8;
force ace_nametags_playerNamesViewDistance = 10;
force ace_nametags_showCursorTagForVehicles = false;

force ace_nightvision_aimDownSightsBlur = 0.2;
force ace_nightvision_disableNVGsWithSights = false;
force ace_nightvision_effectScaling = 0.4;
force ace_nightvision_fogScaling = 0.5;

force ace_noradio_enabled = true;

force ace_overheating_displayTextOnJam = true;
force ace_overheating_enabled = true;
force ace_overheating_overheatingDispersion = true;
force ace_overheating_showParticleEffects = true;
force ace_overheating_showParticleEffectsForEveryone = false;
force ace_overheating_unJamFailChance = 0.1;
force ace_overheating_unJamOnreload = false;

force ace_overpressure_distanceCoefficient = 1;

force ace_parachute_hideAltimeter = false;

force ace_pylons_enabled = true;
force ace_pylons_rearmNewPylons = true;
force ace_pylons_requireEngineer = false;
force ace_pylons_requireToolkit = true;
force ace_pylons_searchDistance = 20;
force ace_pylons_timePerPylon = 5;

force ace_quickmount_distance = 3;
force ace_quickmount_enabled = true;
force ace_quickmount_speed = 18;

force ace_rearm_level = 1;
force ace_rearm_supply = 0;

force ace_refuel_hoseLength = 12;
force ace_refuel_rate = 1;

force ace_repair_addSpareParts = true;
force ace_repair_autoShutOffEngineWhenStartingRepair = true;
force ace_repair_consumeItem_toolKit = 0;
force ace_repair_engineerSetting_fullRepair = 2;
force ace_repair_engineerSetting_repair = 1;
force ace_repair_engineerSetting_wheel = 0;
force ace_repair_fullRepairLocation = 0;
force ace_repair_repairDamageThreshold = 0.6;
force ace_repair_repairDamageThreshold_engineer = 0.4;
force ace_repair_wheelRepairRequiredItems = 1;

force ace_respawn_bodyRemoveTimer = 0;
force ace_respawn_removeDeadBodiesDisconnected = true;
force ace_respawn_savePreDeathGear = false;

force ace_scopes_correctZeroing = true;
force ace_scopes_deduceBarometricPressureFromTerrainAltitude = false;
force ace_scopes_defaultZeroRange = 100;
force ace_scopes_enabled = true;
force ace_scopes_forceUseOfAdjustmentTurrets = false;
force ace_scopes_overwriteZeroRange = false;
force ace_scopes_simplifiedZeroing = false;
force ace_scopes_zeroReferenceBarometricPressure = 1013.25;
force ace_scopes_zeroReferenceHumidity = 0;
force ace_scopes_zeroReferenceTemperature = 15;

force ace_spectator_enableAI = false;
force ace_spectator_filterSides = 0;
force ace_spectator_filterUnits = 2;
force ace_spectator_restrictModes = 0;
force ace_spectator_restrictVisions = 0;

force ace_switchunits_enableSafeZone = true;
force ace_switchunits_enableSwitchUnits = false;
force ace_switchunits_safeZoneRadius = 100;
force ace_switchunits_switchToCivilian = false;
force ace_switchunits_switchToEast = false;
force ace_switchunits_switchToIndependent = false;
force ace_switchunits_switchToWest = false;

force ace_ui_allowSelectiveUI = false;
force ace_ui_ammoCount = false;
force ace_ui_gunnerAmmoCount = true;
force ace_ui_gunnerZeroing = true;

force ace_vehiclelock_defaultLockpickStrength = 10;
force ace_vehiclelock_lockVehicleInventory = true;
force ace_vehiclelock_vehicleStartingLockState = -1;

force ace_viewdistance_enabled = false;
force ace_viewdistance_limitViewDistance = 10000;

force ace_weather_enableServerController = false;
force ace_weather_enabled = false;
force ace_weather_serverUpdateInterval = 60;
force ace_weather_syncMisc = false;
force ace_weather_syncRain = false;
force ace_weather_syncWind = false;
force ace_weather_updateInterval = 60;
force ace_weather_useACEWeather = false;
force ace_weather_windSimulation = false;

force ace_winddeflection_enabled = true;
force ace_winddeflection_simulationInterval = 0.05;
force ace_winddeflection_simulationRadius = 3000;
force ace_winddeflection_vehicleEnabled = true;

force ace_zeus_autoAddObjects = false;
force ace_zeus_radioOrdnance = false;
force ace_zeus_remoteWind = false;
force ace_zeus_revealMines = 0;
force ace_zeus_zeusAscension = false;
force ace_zeus_zeusBird = false;

force acex_headless_delay = 15;
force acex_headless_enabled = false;
force acex_headless_endMission = 0;
force acex_headless_log = false;

force acex_sitting_enable = true;

force acex_viewrestriction_mode = 0;
force acex_viewrestriction_modeSelectiveAir = 0;
force acex_viewrestriction_modeSelectiveFoot = 0;
force acex_viewrestriction_modeSelectiveLand = 0;
force acex_viewrestriction_modeSelectiveSea = 0;