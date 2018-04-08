class dummy_settings_adv_aceCPR {
	title = "---------------------- ADV_ACECPR-Settings ----------------------";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
};
class param_adv_aceCPR_onlyDoctors
{
	title = "ACE-Medical: Wer soll Patienten mit CPR wiederbeleben können? (Nur mit adv_aceCPR)";
	values[] = {0, 1, 2};
	default = 0;
	texts[] =  {"Jeder", "Medics & Doctors", "Doctors only"};
};
class param_adv_aceCPR_maxTime
{
	title = "ACE-Medical: Soll die Zeit, in der CPR erfolgreich wiederbeleben kann, auf einen Prozentanteil der maximalen Revive-Zeit gesetzt werden? (CPR verhindert immer noch das Ablaufen des Revive-Timers)";
	values[] = {0, 10, 20, 30, 40, 50, 60, 70, 80, 90};
	default = 0;
	texts[] =  {
		"Nein"
		, "10% (bei maxReviveTime von 10 Minuten wird CPR nur 1 Minute lang erfolgreich ausführbar sein)"
		, "20%"
		, "30%"
		, "40%"
		, "50% (bei maxReviveTime von 10 Minuten wird CPR nur 5 Minuten lang erfolgreich ausführbar sein)"
		, "60%"
		, "70%"
		, "80%"
		, "90% (bei maxReviveTime von 10 Minuten wird CPR nur 9 Minuten lang erfolgreich ausführbar sein)"
	};
};
class param_adv_aceCPR_AED
{
	title = "ACE-Medical: Sollen PAKs durch Defibrillatoren ausgetauscht werden? (Nur mit adv_aceCPR)";
	values[] = {0, 1, 2};
	default = 2;
	texts[] =  {"Es werden nur PAKs ausgegeben","Es werden PAKs UND Defibrillatoren ausgegeben","Es werden nur Defibrillatoren ausgegeben"};
};
class dummy_settings_ace {
	title = "---------------------- ACE-Settings ----------------------";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
};
class param_ace_medical_GivePAK
{
	title = "ACE-Medical: An wen sollen PAKs/Defibrillatoren ausgegeben werden?";
	values[] = {0, 1};
	default = 0;
	texts[] =  {"Nur an Zugsanitäter", "Zugsanitäter & Gruppensanitäter"};
};
class param_jamChance
{
	title="ACE-Overheating: Soll die Jamming-Wahrscheinlichkeit für aufgehobene Feindwaffen erhöht werden? (Betrifft nur OPFOR- und BLUFOR-Spieler - es gilt NICHT für INDFOR-Spieler!)";
	values[] = {1,0};
	texts[] = {"Ja","Nein"};
	default = 1;
};
class dummy_settings_ace_old {
	title = "----- ACE-Settings (overwriting both mission & server cba settings) -----";
	values[] = {-99999};
	default = -99999;
	texts[] = {""};
};
class ace_medical_level
{
	title = "ACE-Medical Level";
	ACE_setting = 1;
	values[] = {1, 2};
	default = 2;
	texts[] =  {"Basic", "Advanced"};
};
class ace_medical_consumeItem_PAK
{
	title = "ACE-Medical Consume Item PAK";
	ACE_setting = 1;
	values[] = {0, 1};
	default = 0;
	texts[] =  {"Disabled", "Enabled"};
};
class ace_medical_useLocation_PAK
{
	title = "ACE-Medical Use Location PAK";
	ACE_setting = 1;
	values[] = {0, 1, 2, 3};
	default = 0;
	texts[] =  {"Anywhere", "Medical vehicles", "Medical facility (not present in non-edited version of ADV - Template!)", "Vehicles & facilities (facilities not present in non-edited version of ADV - Template!)"};
};
class ace_medical_enableAdvancedWounds
{
	title = "ACE-Medical Enable Advanced Wounds";
	ACE_setting = 1;
	values[] = {0, 1};
	default = 0;
	texts[] =  {"Disabled", "Enabled"};
};
class ace_medical_healHitPointAfterAdvBandage
{
	title = "ACE-Medical Heal Hitpoint After Advanced Bandage";
	ACE_setting = 1;
	values[] = {0, 1};
	default = 1;
	texts[] =  {"Disabled", "Enabled"};
};
class ace_medical_preventInstaDeath
{
	title = "ACE-Medical Prevent Instant Death";
	ACE_setting = 1;
	values[] = {0, 1};
	default = 1;
	texts[] =  {"Instant Death", "No Instant Death"};
};
class ace_medical_enableRevive
{
	title = "ACE-Medical Enable Revive";
	ACE_setting = 1;
	values[] = {0, 1, 2};
	default = 1;
	texts[] =  {"Disabled", "Players only", "Players and AI"};
};
class ace_medical_maxReviveTime
{
	title = "ACE-Medical Max Revive Time";
	ACE_setting = 1;
	values[] = {60, 180, 600, 1200, 1800, 2700, 3600};
	default = 1200;
	texts[] =  {"1 Minute", "3 Minutes", "10 Minutes", "20 Minutes", "30 Minutes", "45 Minutes", "60 Minutes"};
};
class ace_medical_enableFor
{
	title = "ACE-Medical Enable For";
	ACE_setting = 1;
	values[] = {0, 1};
	default = 0;
	texts[] =  {"Players only", "Players and AI"};
};
class ace_medical_enableUnconsciousnessAI
{
	title = "ACE-Medical Enable Unconsciousness AI";
	ACE_setting = 1;
	values[] = {0, 1, 2};
	default = 0;
	texts[] =  {"Disabled", "50/50", "Enabled"};
};
class ace_rearm_level
{
	title = "ACE-Rearm Amount";
	ACE_setting = 1;
	values[] = {0, 1, 2};
	default = 1;
	texts[] =  {"Entire vehicle", "Entire magazine", "Amount based on caliber"};
};
class ace_mk6mortar_useAmmoHandling
{
	title = "ACE-MK6 Mortar Ammo Handling";
	ACE_setting = 1;
	values[] = {0, 1};
	default = 0;
	texts[] =  {"Don't use ammunition handling","Use ammunition handling"};
};