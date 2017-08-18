class dummy_settings_ace {
	title = "---------------------- ACE-Settings ----------------------";
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
class param_ace_medical_GivePAK
{
	title = "ACE-Medical: An wen sollen PAKs/Defibrillatoren (siehe nächsten Parameter) ausgegeben werden?";
	values[] = {0, 1};
	default = 0;
	texts[] =  {"Nur der Zugsanitäter", "Zugsanitäter & Gruppensanitäter"};
};
class param_ace_aceCPR_AED
{
	title = "ACE-Medical: Sollen PAKs durch Defibrillatoren ausgetauscht werden? (Nur mit adv_aceCPR)";
	values[] = {0, 1, 2};
	default = 2;
	texts[] =  {"Es werden nur PAKs ausgegeben","Es werden PAKs UND Defibrillatoren ausgegeben","Es werden nur Defibrillatoren ausgegeben"};
};
class param_adv_aceCPR_onlyDoctors
{
	title = "ACE-Medical: Wer soll Patienten mit CPR wiederbeleben können? (Nur mit adv_aceCPR)";
	values[] = {0, 1, 2};
	default = 0;
	texts[] =  {"Jeder", "Medics & Doctors", "Doctors only"};
};
class ace_medical_consumeItem_PAK
{
	title = "ACE-Medical Consume Item PAK";
	ACE_setting = 1;
	values[] = {0, 1};
	default = 0;
	texts[] =  {"Disabled", "Enabled"};
};
class ace_medical_enableAdvancedWounds
{
	title = "ACE-Medical Enable Advanced Wounds";
	ACE_setting = 1;
	values[] = {0, 1};
	default = 0;
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