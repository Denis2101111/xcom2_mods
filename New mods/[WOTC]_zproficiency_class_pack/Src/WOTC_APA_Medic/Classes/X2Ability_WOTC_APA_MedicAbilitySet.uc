
class X2Ability_WOTC_APA_MedicAbilitySet extends X2Ability_WOTC_APA_Utilities config(WOTC_APA_MedicSkills);

// Medical Specialist Proficiency Level Variables
var config int			MED_I_FREE_MEDKITS;
var config int			MED_I_EQUIPPED_MEDKITS_BONUS;
var config int			MED_II_MEDKIT_HEAL_BONUS;
var config int			MED_II_REVIVE_CHARGE_BONUS;					// Sets initial Revive charges
var config int			MED_III_FREE_MEDKITS;
var config int			MED_III_MEDKIT_HEAL_BONUS;

var config array<name>	MED_BONUS_MEDKITS_VALID_ITEMS;

/* Medical Specialist Proficiency Level Totals (These "variables" are only used for localization tags and are listed here purely for informational purposes)
localization tag		MED_III_FREE_MEDKITS_TOTAL = MED_I_FREE_MEDKITS + MED_III_FREE_MEDKITS
localization tag		MED_III_MEDKIT_HEAL_BONUS_TOTAL = MED_II_MEDKIT_HEAL_BONUS + MED_III_MEDKIT_HEAL_BONUS	*/

var localized string	strMedicalSpecialistHealModMsg;
var localized string	strMedicalSpecialist1Name;
var localized string	strMedicalSpecialist1Desc;
var localized string	strMedicalSpecialist2Name;
var localized string	strMedicalSpecialist2Desc;
var localized string	strMedicalSpecialist3Name;
var localized string	strMedicalSpecialist3Desc;

// Ability Variables
var config float		BATTLEFIELD_TRIAGE_HP_PERCENT_CAP;
var	config array<name>	BATTLEFIELD_TRIAGE_VALID_ABILITIES;
var config int			FLEET_FOOTED_DODGE_BONUS;
//	config array<name>	REPOSITION_TRIGGER_ABILITIES;				// Defined in X2Effect_WOTC_APA_Reposition:
//	config array<name>	REPOSITION_KILL_OVERRIDE_EFFECTS;			// Defined in X2Effect_WOTC_APA_Reposition:
//	config array<name>	REPOSITION_KILL_OVERRIDE_ABILITIES;			// Defined in X2Effect_WOTC_APA_Reposition:
var config float		REPOSITION_MOBILITY_PENALTY;
var config int			ADRENALINE_RUSH_COOLDOWN;
var config float		ADRENALINE_RUSH_DAMAGE_PENALTY;
var config int			TRAUMA_KITS_REVIVE_HEAL_BONUS;
var config int			TRAUMA_KITS_REVIVE_CHARGE_BONUS;
var config int			TRAUMA_KITS_BLEEDINGOUT_CHANCE_BONUS;
var config int			TRAUMA_KITS_BLEEDINGOUT_TURNS_BONUS;
var config int			COMBAT_CONDITIONING_MOBILITY_BONUS;
var config int			COMBAT_CONDITIONING_AIM_BONUS;
//	config array<name>	EMERGENCY_AID_VALID_ABILITIES;				// Defined in X2Effect_WOTC_APA_EmergencyAid:
var config int			EMERGENCY_AID_COOLDOWN;
var config int			SENTINEL_USES_PER_TURN;
//	config array<name>	SENTINEL_VALID_ABILITIES					//Defined in X2Effect_WOTC_APA_Sentinel:
var config int			BURST_FIRE_AMMO_COST;
var config int			BURST_FIRE_AIM_PENALTY;
var config int			BURST_FIRE_COOLDOWN;
var config float		ANTIVENOM_STIMS_DISTANCE;
var config int			ANTIVENOM_STIMS_ADRENALINE_COOLDOWN;
var config int			SMOKESCREEN_FREE_SMOKE_GRENADES;
var config int			SMOKESCREEN_EQUIPPED_SMOKE_BONUS;
var config array<name>	SMOKESCREEN_BONUS_VALID_ITEMS;
var config float		INFILTRATION_DETECTION_RANGE_BONUS;
var config int			FIRE_SUPPORT_AIM_BONUS;
//	config array<name>	RAPID_DEPLOYMENT_VALID_ABILITIES;			//Defined in X2Effect_WOTC_APA_RapidDeployment:
//	config array<name>	RAPID_DEPLOYMENT_VALID_GRENADE_ABILITIES;	//Defined in X2Effect_WOTC_APA_RapidDeployment:
//	config array<name>	RAPID_DEPLOYMENT_VALID_GRENADE_TYPES;		//Defined in X2Effect_WOTC_APA_RapidDeployment:
var config int			RAPID_DEPLOYMENT_COOLDOWN;
var config int			COMBAT_STIMULANTS_CHARGES;
var config int			COMBAT_STIMULANTS_COOLDOWN;
var config int			COMBAT_STIMULANTS_ACTION_POINT_BONUS;
var config float		COMBAT_STIMULANTS_DAMAGE_RESISTANCE;
var config int			COMBAT_STIMULANTS_TURN_DURATION;
var config int			COMBAT_STIMULANTS_WILL_PENALTY;
var config float		COMBAT_STIMULANTS_HEALTH_PENALTY;
var config float		COMBAT_STIMULANTS_STATS_BONUS;
var config float		APPLIED_KNOWLEDGE_CRIT_CHANCE_BONUS;
var config float		APPLIED_KNOWLEDGE_CRIT_DAMAGE_BONUS;
var config int			ARMED_INTERVENTION_COOLDOWN;



var config int			SIDEARM_SPECIALIST_AIM_BONUS;
var config int			SIDEARM_SPECIALIST_DAMAGE_BONUS;
var config array<name>	SIDEARM_SPECIALIST_VALID_WEAPON_CATEGORIES;
var config int			MEDIVAC_BONUS_HEAL_CHARGES;
var config int			CERTIFIED_CMT_MEDIKIT_CHARGE_BONUS;
var config int			CERTIFIED_CMT_MEDIKIT_HEAL_BONUS;
var config int			STUN_SHOT_COOLDOWN;
var config float		STUN_SHOT_AIM_PENALTY;

var localized string	strAdrenalineRushPenaltyDesc;
var localized string	strAdvTraumaKitsReviveHealFlyover;
var localized string	strSteadiedBurstFireName;
var localized string	strCombatStimulantsTickedFlyover;
var localized string	strCombatStimulantsRemovedFlyover;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	/**/`Log("WOTC_APA_Medic - Begin Adding Templates");

	Templates.AddItem(WOTC_APA_MedicalSpecialist());
	/*»»»*/	Templates.AddItem(WOTC_APA_ManageRevive());
	/*»»»*/	Templates.AddItem(WOTC_APA_MedkitRevive());
	Templates.AddItem(WOTC_APA_Sedate());
	/*»»»*/	Templates.AddItem(WOTC_APA_SedateClenseMindControl());
	Templates.AddItem(WOTC_APA_BattlefieldTriage());
	
	Templates.AddItem(WOTC_APA_AdrenalineRush());
	Templates.AddItem(WOTC_APA_Reposition());
	/*»»»*/	Templates.AddItem(WOTC_APA_RepositionMobilityPenalty());
	Templates.AddItem(WOTC_APA_FleetFooted());

	Templates.AddItem(WOTC_APA_AdvancedTraumaKits());
	Templates.AddItem(WOTC_APA_CombatConditioning());
	Templates.AddItem(WOTC_APA_EmergencyAid());
	
	Templates.AddItem(WOTC_APA_Sentinel());
	Templates.AddItem(WOTC_APA_BurstFire());
	Templates.AddItem(WOTC_APA_OverchargedCapacitors());
	/*»»»*/	Templates.AddItem(WOTC_APA_OverchargedCapacitorsDisorient());

	Templates.AddItem(WOTC_APA_AntiVenomStims());
	/*»»»*/	Templates.AddItem(WOTC_APA_AntiVenomStims_Clense());
	/*»»»*/	Templates.AddItem(WOTC_APA_AntiVenomStims_AdrenalineShot());
	Templates.AddItem(WOTC_APA_LowProfile());
	Templates.AddItem(WOTC_APA_SmokeScreen());
	
	Templates.AddItem(WOTC_APA_CovertInfiltration());
	Templates.AddItem(WOTC_APA_FireSupport());
	Templates.AddItem(WOTC_APA_RapidDeployment());

	Templates.AddItem(WOTC_APA_CombatStimulants());
	/*»»»*/	Templates.AddItem(WOTC_APA_ApplyCombatStimulant());
	Templates.AddItem(WOTC_APA_AppliedKnowledge());
	Templates.AddItem(WOTC_APA_ArmedIntervention());
	/*»»»*/	Templates.AddItem(WOTC_APA_ArmedInterventionShot());


	Templates.AddItem(WOTC_APA_Medivac());
	Templates.AddItem(WOTC_APA_SidearmSpecialist());
	Templates.AddItem(WOTC_APA_Quickdraw());
	Templates.AddItem(WOTC_APA_CertifiedCMT());
	Templates.AddItem(WOTC_APA_StunShot());

	Templates.AddItem(WOTC_APA_QualityOfCare());		// Shell ability to notify users to refresh skill trees on pre-existing Medics with old skill setups
	Templates.AddItem(TestStatusEffects());				// Used just for testing status effects

	/**/`Log("WOTC_APA_Medic - Finished Adding Templates");

	return Templates;
}


//// Plays flyover message with ability's LocFlyOverText when the ability is activated
//simulated function BasicFlyover_BuildVisualization(XComGameState VisualizeGameState)
//{
	//local XComGameStateHistory					History;
	//local XComGameStateContext_Ability			AbilityContext;
	//local XComGameState_Ability					AbilityState;
	//local X2AbilityTemplate						AbilityTemplate;
	//local StateObjectReference					SourceUnitRef;
	//local VisualizationActionMetadata			ActionMetadata;
	//local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;
	//
	//History = `XCOMHISTORY;
//
	//AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	//SourceUnitRef = AbilityContext.InputContext.SourceObject;
	////TargetUnitRef = AbilityContext.InputContext.PrimaryTarget;
	//AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID));
	//AbilityTemplate = AbilityState.GetMyTemplate();
	//
	//ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(SourceUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	//ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(SourceUnitRef.ObjectID);
	//if (ActionMetadata.StateObject_NewState == none)
		//ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
	//ActionMetadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(SourceUnitRef.ObjectID);
	//
	//SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	//SoundAndFlyOver.SetSoundAndFlyOverParameters(None, AbilityTemplate.LocFlyOverText, '', eColor_Good, AbilityTemplate.IconImage, `DEFAULTFLYOVERLOOKATTIME);
//}


// Used to test status effect removal (Development Testing)
static function X2AbilityTemplate TestStatusEffects()
{
	local X2AbilityTemplate											Template;
	local X2AbilityCost_ActionPoints								ActionCost;
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'TestStatusEffects');
	
	// Icon Properties
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_shaken";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_LIEUTENANT_PRIORITY;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	
	// Activated by a button press; additionally, tells the AI this is an activatable
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	// Can't shoot while dead
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	
	ActionCost = new class'X2AbilityCost_ActionPoints';
	ActionCost.iNumPoints = 1;
	ActionCost.bFreeCost = true;
	Template.AbilityCosts.AddItem(ActionCost);
	
	Template.AbilityToHitCalc = default.DeadEye;

	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	
	//Template.AddTargetEffect(class'X2StatusEffects'.static.CreateStunnedStatusEffect(2,100));
	//Template.AddTargetEffect(class'X2StatusEffects'.static.CreatePanickedStatusEffect());
	//Template.AddTargetEffect(class'X2StatusEffects'.static.CreateMindControlStatusEffect());
	//Template.AddTargetEffect(class'X2StatusEffects'.static.CreatePoisonedStatusEffect());
	//Template.AddTargetEffect(class'X2StatusEffects'.static.CreateUnconsciousStatusEffect());
	//Template.AddTargetEffect(class'X2StatusEffects'.static.CreateBleedingOutStatusEffect());
	//Template.AddTargetEffect(class'X2StatusEffects'.static.CreateDazedStatusEffect());
	Template.AddTargetEffect(class'X2StatusEffects'.static.CreateBurningStatusEffect(1, 0));

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITooltip = false;
	Template.bLimitTargetIcons = true;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	
	Template.bShowActivation = true;
	Template.bSkipFireAction = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	
	return Template;
}


// Medical Specialist - Base Class Proficiency Ability
static function X2AbilityTemplate WOTC_APA_MedicalSpecialist()
{
	
	local X2AbilityTemplate											Template;
	local X2Condition_WOTC_APA_Class_TargetRankRequirement			RankCondition1, RankCondition2, RankCondition2AndUp, RankCondition3;
	local X2Effect_WOTC_APA_Class_BonusItems						MedkitEffect1, MedkitEffect2, MedkitEffect3;
	local X2Effect_WOTC_APA_ModifyHealAmount						HealModEffect2, HealModEffect3;
	local X2Effect_WOTC_APA_Class_AddAbilitiesToTarget				ReviveEffect;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_MedicalSpecialist');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_revive"; 
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;
	
	
	// Establish Rank conditions for each Proficiency Level effect:
	RankCondition1 = new class 'X2Condition_WOTC_APA_Class_TargetRankRequirement';
	RankCondition1.iMinRank = -1;	// No minimum rank for level 1 bonuses
	RankCondition1.iMaxRank = 2;	// Max rank is 1 below minimum rank for level 2 bonuses
	RankCondition1.LogEffectName = "Medical Specialist 1";	// EffectName to use in logs
	RankCondition1.ExcludeProject = 'WOTC_APA_MedicUnlock1';

	RankCondition2 = new class 'X2Condition_WOTC_APA_Class_TargetRankRequirement';
	RankCondition2.iMinRank = 3;
	RankCondition2.iMaxRank = 5;
	RankCondition2.LogEffectName = "Medical Specialist 2";
	RankCondition2.ExcludeProject = 'WOTC_APA_MedicUnlock2';
	RankCondition2.GiveProject = 'WOTC_APA_MedicUnlock1';

	RankCondition2AndUp = new class 'X2Condition_WOTC_APA_Class_TargetRankRequirement';
	RankCondition2AndUp.iMinRank = 3;
	RankCondition2AndUp.iMaxRank = -1;
	RankCondition2AndUp.LogEffectName = "Add/Enable Revive";
	RankCondition2AndUp.GiveProject = 'WOTC_APA_MedicUnlock1';
	
	RankCondition3 = new class 'X2Condition_WOTC_APA_Class_TargetRankRequirement';
	RankCondition3.iMinRank = 6;
	RankCondition3.iMaxRank = -1;	// No max rank for level 3 bonuses
	RankCondition3.LogEffectName = "Medical Specialist 3";
	RankCondition3.GiveProject = 'WOTC_APA_MedicUnlock2';
	

	// Create effects to add bonus charges to medkits for each proficiency level
	MedkitEffect1 = new class'X2Effect_WOTC_APA_Class_BonusItems';
	MedkitEffect1.BonusItems = default.MED_BONUS_MEDKITS_VALID_ITEMS;
	MedkitEffect1.FreeCharges = default.MED_I_FREE_MEDKITS;
	MedkitEffect1.BonusCharges = default.MED_I_EQUIPPED_MEDKITS_BONUS;
	MedkitEffect1.BuildPersistentEffect (1, true, false, false);
	MedkitEffect1.SetDisplayInfo(ePerkBuff_Passive, default.strMedicalSpecialist1Name, default.strMedicalSpecialist1Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_MedicalSpecialist1", true,, Template.AbilitySourceName);
	MedkitEffect1.TargetConditions.AddItem(RankCondition1);
	Template.AddTargetEffect(MedkitEffect1);

	MedkitEffect2 = new class'X2Effect_WOTC_APA_Class_BonusItems';
	MedkitEffect2.BonusItems = default.MED_BONUS_MEDKITS_VALID_ITEMS;
	MedkitEffect2.FreeCharges = default.MED_I_FREE_MEDKITS;
	MedkitEffect2.BonusCharges = default.MED_I_EQUIPPED_MEDKITS_BONUS;
	MedkitEffect2.BuildPersistentEffect (1, true, false, false);
	MedkitEffect2.SetDisplayInfo(ePerkBuff_Passive, default.strMedicalSpecialist2Name, default.strMedicalSpecialist2Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_MedicalSpecialist2", true,, Template.AbilitySourceName);
	MedkitEffect2.TargetConditions.AddItem(RankCondition2);
	Template.AddTargetEffect(MedkitEffect2);

	MedkitEffect3 = new class'X2Effect_WOTC_APA_Class_BonusItems';
	MedkitEffect3.BonusItems = default.MED_BONUS_MEDKITS_VALID_ITEMS;
	MedkitEffect3.FreeCharges = default.MED_I_FREE_MEDKITS + default.MED_III_FREE_MEDKITS;
	MedkitEffect3.BonusCharges = default.MED_I_EQUIPPED_MEDKITS_BONUS;
	MedkitEffect3.BuildPersistentEffect (1, true, false, false);
	MedkitEffect3.SetDisplayInfo(ePerkBuff_Passive, default.strMedicalSpecialist3Name, default.strMedicalSpecialist3Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_MedicalSpecialist3", true,, Template.AbilitySourceName);
	MedkitEffect3.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(MedkitEffect3);


	// Create effect to modify healing HP amounts for each proficiency level
	HealModEffect2 = new class'X2Effect_WOTC_APA_ModifyHealAmount';
	HealModEffect2.HealModifier = default.MED_II_MEDKIT_HEAL_BONUS;
	HealModEffect2.strFlyoverMessage = default.strMedicalSpecialistHealModMsg;
	HealModEffect2.strFlyoverIcon = "img:///UILibrary_WOTC_APA_Class_Pack.perk_MedicalSpecialist2";
	HealModEffect2.BuildPersistentEffect (1, true, false, false);
	HealModEffect2.TargetConditions.AddItem(RankCondition2);
	Template.AddTargetEffect(HealModEffect2);

	HealModEffect3 = new class'X2Effect_WOTC_APA_ModifyHealAmount';
	HealModEffect3.HealModifier = default.MED_II_MEDKIT_HEAL_BONUS + default.MED_III_MEDKIT_HEAL_BONUS;
	HealModEffect3.strFlyoverMessage = default.strMedicalSpecialistHealModMsg;
	HealModEffect3.strFlyoverIcon = "img:///UILibrary_WOTC_APA_Class_Pack.perk_MedicalSpecialist3";
	HealModEffect3.BuildPersistentEffect (1, true, false, false);
	HealModEffect3.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(HealModEffect3);


	// Add ability to manage granting the Revive ability and bonus charges at appropriate rank
	// Has to be granted through a separate managing ability because Revive must be assigned a medikit as a source weapon to function correctly and
	// the free medikits being added here in Medical Specialist aren't yet in the gamestate for X2Effect_WOTC_APA_Class_AddAbilitiesToTarget to find
	ReviveEffect = new class'X2Effect_WOTC_APA_Class_AddAbilitiesToTarget';
	ReviveEffect.AddAbilities.AddItem('WOTC_APA_ManageRevive');
	ReviveEffect.TargetConditions.AddItem(RankCondition2AndUp);
	Template.AddTargetEffect(ReviveEffect);


	// Used for testing abilities that remove status effects	!! - SHOULD BE COMMENTED OUT BEFORE RELEASE - !!
	//Template.AdditionalAbilities.AddItem('TestStatusEffects');


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}



// Give Medkit Revive ability to target - Medkit Revive must be assigned a medkit as a source weapon to work correctly. Using a separate ability to grant it
// (rather than build it into the Medical Specialist ability) allows the free medkits given by Medical Specialist to be processed into the gamestate first.
// This sort of nonsense isn't neccesary when granting abilities that will be assigned to fixed weapon slots, like the primary weapon, or not tied to an item at all.
static function X2AbilityTemplate WOTC_APA_ManageRevive()
{
	
	local X2AbilityTemplate											Template;
	local X2Effect_WOTC_APA_Class_AddAbilitiesToTarget				ReviveEffect;
	local X2Condition_WOTC_APA_Class_TargetRankRequirement			RankCondition3;
	local X2Condition_WOTC_APA_Class_AbilityRequirement				AbilityCondition;
	local X2Effect_WOTC_APA_Class_ModifyAbilityCharges				ReviveChargeEffect1, ReviveChargeEffect2;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_ManageRevive');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_revive"; 
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;


	// Create effect to add Revive ability to target
	ReviveEffect = new class'X2Effect_WOTC_APA_Class_AddAbilitiesToTarget';
	ReviveEffect.AddAbilities.AddItem('WOTC_APA_MedkitRevive');
	ReviveEffect.ApplyToWeaponCat = 'medikit';
	Template.AddTargetEffect(ReviveEffect);


	//// Establish Rank conditions for appropriate Proficiency Level effect:
	//RankCondition3 = new class 'X2Condition_WOTC_APA_Class_TargetRankRequirement';
	//RankCondition3.iMinRank = 6;
	//RankCondition3.iMaxRank = -1;	// No max rank for level 3 bonuses
	//RankCondition3.LogEffectName = "Medical Specialist 3";
	//RankCondition3.GiveProject = 'WOTC_APA_MedicUnlock2';

	//// Create effect to add additional Revive charges at appropriate rank
	//ReviveChargeEffect1 = new class'X2Effect_WOTC_APA_Class_ModifyAbilityCharges';
	//ReviveChargeEffect1.AbilitiesToModify.AddItem('WOTC_APA_MedkitRevive');
	//ReviveChargeEffect1.iChargeModifier = default.MED_III_REVIVE_CHARGE_BONUS;
	//ReviveChargeEffect1.TargetConditions.AddItem(RankCondition3);
	//Template.AddTargetEffect(ReviveChargeEffect1);


	// Establish ability conditions for bonus charge effect:
	AbilityCondition = new class 'X2Condition_WOTC_APA_Class_AbilityRequirement';
	AbilityCondition.RequiredAbilityNames.AddItem('WOTC_APA_AdvancedTraumaKits');
	AbilityCondition.bCheckSourceUnit = true;

	// Create effect to add additional Revive charges with the Advanced Trauma Kits ability
	ReviveChargeEffect2 = new class'X2Effect_WOTC_APA_Class_ModifyAbilityCharges';
	ReviveChargeEffect2.AbilitiesToModify.AddItem('WOTC_APA_MedkitRevive');
	ReviveChargeEffect2.iChargeModifier = default.TRAUMA_KITS_REVIVE_CHARGE_BONUS;
	ReviveChargeEffect2.TargetConditions.AddItem(AbilityCondition);
	Template.AddTargetEffect(ReviveChargeEffect2);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

// Medkit Revive - Active:
static function X2AbilityTemplate WOTC_APA_MedkitRevive()
{

	local X2AbilityTemplate											Template;
	local X2AbilityCost_ActionPoints								ActionPointCost;
	local X2AbilityCost_Ammo										AmmoCost;
	local X2AbilityCost_Charges										ChargeCost;
	local X2AbilityCharges											AbilityCharges;
	local X2AbilityTarget_Single									SingleTarget;
	local X2AbilityPassiveAOE_SelfRadius							PassiveAOEStyle;
	local X2Effect_RemoveEffects									RemoveEffects;
	local X2Effect_RemoveEffectsByDamageType						RemoveDamageTypes;
	local X2Effect_WOTC_APA_ReviveHealAmount						MedSpecialistHeal;

	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_MedkitRevive');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_revive";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.STABILIZE_PRIORITY - 1;
	Template.bDisplayInUITooltip = false;
	Template.bUseAmmoAsChargesForHUD = false;
	Template.bLimitTargetIcons = true;
	Template.Hostility = eHostility_Defensive;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.bIsPassive = false;
	Template.bShowActivation = false;
	Template.ActivationSpeech = 'HealingAlly';
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();
	Template.bCrossClassEligible = false;
	

	// Set ability targeting conditions, charges, and costs - This ability MUST be assigned a medikit as a source weapon to function correctly!
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.DoNotConsumeAllSoldierAbilities.AddItem('WOTC_APA_AdvancedTraumaKits');
	Template.AbilityCosts.AddItem(ActionPointCost);

	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	AmmoCost.bReturnChargesError = true;
	Template.AbilityCosts.AddItem(AmmoCost);

	ChargeCost = new class'X2AbilityCost_Charges';
	ChargeCost.NumCharges = 1;
	Template.AbilityCosts.AddItem(ChargeCost);

	AbilityCharges = new class'X2AbilityCharges';
	AbilityCharges.InitialCharges = default.MED_II_REVIVE_CHARGE_BONUS;
	Template.AbilityCharges = AbilityCharges;

	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.OnlyIncludeTargetsInsideWeaponRange = true;
	SingleTarget.bIncludeSelf = true;
	SingleTarget.bShowAOE = true;
	Template.AbilityTargetStyle = SingleTarget;

	PassiveAOEStyle = new class'X2AbilityPassiveAOE_SelfRadius';
	PassiveAOEStyle.OnlyIncludeTargetsInsideWeaponRange = true;
	Template.AbilityPassiveAOEStyle = PassiveAOEStyle;

	Template.AbilityTargetConditions.AddItem(new class'X2Condition_WOTC_APA_ReviveTargetConditions');
	
	
	// Special handling to allow Reviving of units in Bleed-Out state without first Stabilizing
	Template.AddTargetEffect(new class'X2Effect_WOTC_APA_ReviveVisualization');


	// Clense Damage Types and Effects from target
	RemoveEffects = new class'X2Effect_RemoveEffects';
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.ConfusedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.PanickedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.StunnedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.DazedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.ObsessedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.BerserkName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.ShatteredName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2StatusEffects'.default.BleedingOutName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2StatusEffects'.default.UnconsciousName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2Ability_AdvPriest'.default.HolyWarriorEffectName);
	RemoveEffects.bDoNotVisualize = true;
	Template.AddTargetEffect(RemoveEffects);

	RemoveDamageTypes = new class'X2Effect_RemoveEffectsByDamageType';
	RemoveDamageTypes.DamageTypesToRemove.AddItem('mental');
	RemoveDamageTypes.DamageTypesToRemove.AddItem('Fire');
	RemoveDamageTypes.DamageTypesToRemove.AddItem('Poison');
	RemoveDamageTypes.DamageTypesToRemove.AddItem('ParthenogenicPoison');
	RemoveDamageTypes.DamageTypesToRemove.AddItem('Acid');
	RemoveDamageTypes.DamageTypesToRemove.AddItem('Bleeding');
	Template.AddTargetEffect(RemoveDamageTypes);

	//Template.AddTargetEffect(class'X2StatusEffects'.static.CreateStunRecoverEffect());
	//Template.AddTargetEffect(class'X2StatusEffects'.static.UnconsciousCleansedVisualization());
	Template.AddTargetEffect(new class'X2Effect_RestoreActionPoints');


	// Create healing effect to apply Medical Specialist and ability modifying healing boosts. Also handles flyover visualization.
	MedSpecialistHeal = new class'X2Effect_WOTC_APA_ReviveHealAmount';
	Template.AddTargetEffect(MedSpecialistHeal);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}


// Sedate - Passive: Stuns with the Arc-Thrower against allies remove Mind Control effects and are applied for the minimum duration (Doesn't increase with tech level)
static function X2AbilityTemplate WOTC_APA_Sedate()
{

	local X2AbilityTemplate											Template;
	local X2Effect_Persistent										ClenseEffect;


	Template = CreatePassiveAbility('WOTC_APA_Sedate', "img:///UILibrary_LWSecondariesWOTC.LW_AbilityElectroshock", 'Arcthrower_PreventNegativeEffectsOnAlliesEffect');

	
	// Create a persistent effect that tells the ArcThrower abilities/effects to removes Mind Control effects from stunned allies
	ClenseEffect = new class 'X2Effect_Persistent';
	ClenseEffect.EffectName = 'Arcthrower_ClenseMindControlledAllyEffect';
	ClenseEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(ClenseEffect);


	// Add the additional ability that creates the Mind Control clense effect
	Template.AdditionalAbilities.AddItem('WOTC_APA_SedateClenseMindControl');


	return Template;
}

// Sedate Clense Mind Control - Passive: Clears active Mind Control effects once the Arcthrower's Stun has worn off
static function X2AbilityTemplate WOTC_APA_SedateClenseMindControl()
{

	local X2AbilityTemplate											Template;
	local X2Effect_RemoveEffects									ClenseEffect;
	local X2AbilityTrigger_EventListener							EventListener;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_SedateClenseMindControl');
	Template.IconImage = "img:///UILibrary_LWSecondariesWOTC.LW_AbilityElectroshock";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.bCrossClassEligible = false;


	// This ability triggers after an Sedate Arcthrower Stun wears off
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = class' X2Effect_WOTC_APA_ArcthrowerRemoveMindControl'.default.WOTC_APA_ArcthrowerRemoveMindControl_TriggeredName;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.VoidRiftInsanityListener;
	Template.AbilityTriggers.AddItem(EventListener);


	// Clense any Mind Control effects on the target ally
	ClenseEffect = new class'X2Effect_RemoveEffects';
	ClenseEffect.EffectNamesToRemove.AddItem(class'X2Effect_MindControl'.default.EffectName);
	Template.AddTargetEffect(ClenseEffect);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}


// Battlefield Triage - Passive:
static function X2AbilityTemplate WOTC_APA_BattlefieldTriage()
{

	local X2AbilityTemplate											Template;
	local X2Effect_WOTC_APA_BattlefieldTriage						ActiveHealEffect;
	local X2Effect_WOTC_APA_Medivac									PassiveHealEffect;
	local X2Effect_WOTC_APA_MedivacSource							SourceEffect;
	

	//Template = CreatePassiveAbility('WOTC_APA_BattlefieldTriage', "img:///UILibrary_PerkIcons.UIPerk_rapidregeneration", 'WOTC_APA_BattlefieldTriageIcon');
	Template = CreatePassiveAbility('WOTC_APA_BattlefieldTriage', "img:///UILibrary_WOTC_APA_Class_Pack.perk_QualityofCare", 'WOTC_APA_BattlefieldTriageIcon');
	Template.AbilityMultiTargetStyle = new class'X2AbilityMultiTarget_AllAllies';
	

	// Create the post-healing wound time reduction effect for active heals in-mission
	ActiveHealEffect = new class'X2Effect_WOTC_APA_BattlefieldTriage';
	ActiveHealEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(ActiveHealEffect);

	
	// Register all allies for the post-mission wound time reduction effect - exclude the source unit themselves
	PassiveHealEffect = new class'X2Effect_WOTC_APA_Medivac';
	PassiveHealEffect.BuildPersistentEffect(1, true, false, false);
	PassiveHealEffect.TargetConditions.AddItem(new class'X2Condition_WOTC_APA_Class_ExcludeSource');
	Template.AddMultiTargetEffect(PassiveHealEffect);


	// Create effect to identify and exclude the SourceUnit and facilitate charge counting post-mission
	SourceEffect = new class'X2Effect_WOTC_APA_MedivacSource';
	SourceEffect.BuildPersistentEffect(1, true, false);
	Template.AddTargetEffect(SourceEffect);


	return Template;
}


// Adrenaline Rush - Active:
static function X2AbilityTemplate WOTC_APA_AdrenalineRush()
{

	local X2AbilityTemplate											Template;
	local X2AbilityCooldown											Cooldown;
	local X2AbilityCost_ActionPoints								ActionPointCost;
	local X2Effect_GrantActionPoints								ActionPointEffect;
	local X2Effect_WOTC_APA_AdrenalineRushDamagePenalty				DamagePenaltyEffect;
	
	`CREATE_X2ABILITY_TEMPLATE (Template, 'WOTC_APA_AdrenalineRush');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_AdrenalineRush";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.STABILIZE_PRIORITY - 3;
	Template.bLimitTargetIcons = true;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.bIsPassive = false;
	Template.bSkipFireAction = true;
	Template.bShowActivation=true;
	Template.ActivationSpeech = 'RunAndGun';
	Template.AbilityConfirmSound = "TacticalUI_Activate_Ability_Run_N_Gun";
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();
	Template.bCrossClassEligible = false;


	// Set ability cooldown, costs, and conditions
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.ADRENALINE_RUSH_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	Template.AbilityCosts.AddItem(ActionPointCost);


	// Create effect to give Run and Gun action point
	ActionPointEffect = new class'X2Effect_GrantActionPoints';
	ActionPointEffect.NumActionPoints = 1;
	ActionPointEffect.PointType = class'X2CharacterTemplateManager'.default.RunAndGunActionPoint;
	Template.AddTargetEffect(ActionPointEffect);


	// Create a stat change effect lasting through the end of the player's turn that multiplies the unit's damage by [default: 0.75] 
	DamagePenaltyEffect = new class'X2Effect_WOTC_APA_AdrenalineRushDamagePenalty';
	DamagePenaltyEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	DamagePenaltyEffect.SetDisplayInfo(ePerkBuff_Penalty, Template.LocFriendlyName, default.strAdrenalineRushPenaltyDesc, Template.IconImage);
	Template.AddTargetEffect(DamagePenaltyEffect);


	class'X2Ability_RangerAbilitySet'.static.SuperKillRestrictions(Template, 'RunAndGun_SuperKillCheck');


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}


// Reposition - Passive:
static function X2AbilityTemplate WOTC_APA_Reposition()
{

	local X2AbilityTemplate											Template;
	local X2Effect_WOTC_APA_Reposition								RepositionEffect;
	
	`CREATE_X2ABILITY_TEMPLATE (Template, 'WOTC_APA_Reposition');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_Reposition";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;


	// Add the Reposition effect
	RepositionEffect = new class'X2Effect_WOTC_APA_Reposition';
	RepositionEffect.EffectName = 'WOTC_APA_Reposition';
	RepositionEffect.BuildPersistentEffect(1, true, false, false);
	RepositionEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	RepositionEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(RepositionEffect);


	// Add the additional ability that creates the Mobility penalty
	Template.AdditionalAbilities.AddItem('WOTC_APA_RepositionMobilityPenalty');


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

// Reposition Mobility Penalty
static function X2AbilityTemplate WOTC_APA_RepositionMobilityPenalty()
{

	local X2AbilityTemplate											Template;
	local X2Effect_WOTC_APA_Class_StatChangeUntilMovement			MobilityPenaltyEffect;
	local X2AbilityTrigger_EventListener							EventListener;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_RepositionMobilityPenalty');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_Reposition";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bDisplayInUITooltip = false;
	Template.bCrossClassEligible = false;


	// This ability triggers after X2Effect_WOTC_APA_Reposition successfully fires
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = class'X2Effect_WOTC_APA_Reposition'.default.WOTC_APA_Reposition_TriggeredName;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	Template.AbilityTriggers.AddItem(EventListener);


	// Create a stat change effect lasting through the end of the player's turn that multiplies the unit's mobility by [default: 0.65] 
	MobilityPenaltyEffect = new class'X2Effect_WOTC_APA_Class_StatChangeUntilMovement';
	MobilityPenaltyEffect.EffectName = 'WOTC_APA_RepositionMobilityPenalty';
	MobilityPenaltyEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnEnd);
	MobilityPenaltyEffect.SetDisplayInfo(ePerkBuff_Penalty, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage);
	MobilityPenaltyEffect.AddPersistentStatChange(eStat_Mobility, default.REPOSITION_MOBILITY_PENALTY, MODOP_Multiplication);
	MobilityPenaltyEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(MobilityPenaltyEffect);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = BasicSourceFlyover_BuildVisualization;
	return Template;
}


// Fleet-Footed - Passive:
static function X2AbilityTemplate WOTC_APA_FleetFooted()
{
	
	local X2AbilityTemplate											Template;
	local X2Effect_PersistentStatChange								StatEffect;
	local X2Effect_Persistent										IconEffect;
	local X2Condition_WOTC_APA_Class_AbilityRequirement				IconCondition;
	

	`CREATE_X2ABILITY_TEMPLATE (Template, 'WOTC_APA_FleetFooted');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_FleetFooted";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;


	// Create a persistent stat change effect that adds [default: 5] dodge
	StatEffect = new class 'X2Effect_PersistentStatChange';
	StatEffect.BuildPersistentEffect(1, true, false, false);
	StatEffect.AddPersistentStatChange(eStat_Dodge, default.FLEET_FOOTED_DODGE_BONUS);
	//StatEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,, Template.AbilitySourceName);
	Template.AddTargetEffect(StatEffect);


	// Add UI stat markups corresponding to effect stat boosts
	Template.SetUIStatMarkup(class'XLocalizedData'.default.DodgeLabel, eStat_Dodge, default.FLEET_FOOTED_DODGE_BONUS);
		

	// Effect to show a passive icon in the tactical UI when the soldier has Emergency Aid or Rapid Deployment
	IconCondition = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
	IconCondition.RequiredAbilityNames.AddItem('WOTC_APA_EmergencyAid');
	IconCondition.RequiredAbilityNames.AddItem('WOTC_APA_RapidDeployment');
	IconCondition.bRequireAll = false;

	IconEffect = new class'X2Effect_Persistent';
	IconEffect.BuildPersistentEffect(1, true, false);
	IconEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,, Template.AbilitySourceName);
	IconEffect.TargetConditions.AddItem(IconCondition);
	Template.AddTargetEffect(IconEffect);


	// Grants Shadowstep ability to ignore reaction shots
	Template.AdditionalAbilities.AddItem('Shadowstep');


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Advanced Trauma Kits - Passive:
static function X2AbilityTemplate WOTC_APA_AdvancedTraumaKits()
{

	local X2AbilityTemplate											Template;
	local X2Effect_Persistent										IconEffect;
	local X2Effect_WOTC_APA_AdvancedTraumaKits						BleedoutBonusEffect;
	local X2Condition_UnitProperty									UnitPropertyCondition;
	local X2Condition_WOTC_APA_Class_ExcludeSource					ExcludeSourceCondition;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_AdvancedTraumaKits');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_AdvancedTraumaKits";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.AbilityMultiTargetStyle = new class'X2AbilityMultiTarget_AllAllies';
	Template.bCrossClassEligible = false;
	

	// Dummy effect to show a passive icon in the tactical UI for the SourceUnit
	IconEffect = new class'X2Effect_Persistent';
	IconEffect.BuildPersistentEffect(1, true, false);
	IconEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, true,, Template.AbilitySourceName);
	Template.AddTargetEffect(IconEffect);


	// Create an effect that increases Bleedout turns and chance
	BleedoutBonusEffect = new class'X2Effect_WOTC_APA_AdvancedTraumaKits';
	BleedoutBonusEffect.BuildPersistentEffect(1, true, false);

	// SourceUnit cannot be Bleeding Out, Stunned, Unconscious, etc.
	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.IsBleedingOut = false;
	UnitPropertyCondition.ExcludeStunned = true;
	UnitPropertyCondition.ExcludeUnableToAct = true;
	UnitPropertyCondition.ExcludeDazed = true;
	UnitPropertyCondition.ExcludePanicked = true;
	UnitPropertyCondition.ExcludeInStasis = true;


	// Exclude SourceUnit from receiving effects
	ExcludeSourceCondition = new class'X2Condition_WOTC_APA_Class_ExcludeSource';
	BleedoutBonusEffect.TargetConditions.AddItem(ExcludeSourceCondition);
	Template.AddMultiTargetEffect(BleedoutBonusEffect);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Combat Conditioning - Passive: Grants a bonus to Aim and Mobility
static function X2AbilityTemplate WOTC_APA_CombatConditioning()
{

	local X2AbilityTemplate											Template;
	local X2Effect_PersistentStatChange								Effect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_CombatConditioning');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_CombatConditioning";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	Template.bCrossClassEligible = false;


	// Create a persistent stat change effect that adds [default: 2] mobility and [default: 5] aim
	Effect = new class 'X2Effect_PersistentStatChange';
	Effect.EffectName = 'WOTC_APA_CombatConditioning';
	Effect.BuildPersistentEffect(1, true, false, false);
	Effect.AddPersistentStatChange(eStat_Mobility, default.COMBAT_CONDITIONING_MOBILITY_BONUS);
	Effect.AddPersistentStatChange(eStat_Offense, default.COMBAT_CONDITIONING_AIM_BONUS);
	Effect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(Effect);


	// Add UI stat markups corresponding to effect stat boosts
	Template.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, default.COMBAT_CONDITIONING_MOBILITY_BONUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.AimLabel, eStat_Offense, default.COMBAT_CONDITIONING_AIM_BONUS);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Emergency Aid
static function X2AbilityTemplate WOTC_APA_EmergencyAid()
{

	local X2AbilityTemplate											Template;
	local X2AbilityCooldown											Cooldown;
	local X2Effect_WOTC_APA_EmergencyAid							EmergencyAidEffect;
	local X2Effect_WOTC_APA_FleetFootedEmergencyAidActionPoint		ActionPointEffect;
	local X2Condition_WOTC_APA_Class_AbilityRequirement				AbilityCondition;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_EmergencyAid');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_EmergencyAid";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.STABILIZE_PRIORITY - 3;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.bIsPassive = false;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();
	Template.bCrossClassEligible = false;


	// Set ability cooldown and costs
	Cooldown = new class'X2AbilityCooldown';
    Cooldown.iNumTurns = default.EMERGENCY_AID_COOLDOWN;
    Template.AbilityCooldown = Cooldown;

	Template.AbilityCosts.AddItem(default.FreeActionCost);
	

	// Add the Emergency Aid effect
	EmergencyAidEffect = new class'X2Effect_WOTC_APA_EmergencyAid';
	EmergencyAidEffect.BuildPersistentEffect (1, false, false, false, eGameRule_PlayerTurnEnd);
	EmergencyAidEFfect.EffectName = 'Medikit_FreeAction';
	Template.AddTargetEffect(EmergencyAidEffect);


	// Create effect to give FleetFootedFree action point if unit has WOTC_APA_FleetFooted
	AbilityCondition = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
	AbilityCondition.RequiredAbilityNames.AddItem('WOTC_APA_FleetFooted');
	AbilityCondition.LogEffectName = "FleetFootedFreeActionPoint";
	
	ActionPointEffect = new class'X2Effect_WOTC_APA_FleetFootedEmergencyAidActionPoint';
	ActionPointEffect.BuildPersistentEffect (1, false, false, false, eGameRule_PlayerTurnEnd);
	ActionPointEffect.TargetConditions.AddItem(AbilityCondition);
	Template.AddTargetEffect(ActionPointEffect);
	

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = BasicSourceFlyover_BuildVisualization;
	return Template;
}


// Sentinel
static function X2AbilityTemplate WOTC_APA_Sentinel()
{
	
	local X2AbilityTemplate											Template;
	local X2Effect_WOTC_APA_Sentinel								Effect;
	
	`CREATE_X2ABILITY_TEMPLATE (Template, 'WOTC_APA_Sentinel');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_sentinel";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;


	// Add the Sentinel effect
	Effect = new class'X2Effect_WOTC_APA_Sentinel';
	Effect.BuildPersistentEffect(1, true, false, false);
	Effect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(Effect);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Burst Fire
static function X2AbilityTemplate WOTC_APA_BurstFire()
{
	
	local X2AbilityTemplate											Template;
	//local X2AbilityCost_ActionPoints								ActionPointCost;
	//local X2AbilityCost_Ammo										AmmoCost;
	local X2AbilityCooldown											Cooldown;
	local X2Effect_ApplyWeaponDamage								WeaponDamageEffect;
	local X2AbilityMultiTarget_BurstFire							BurstFireMultiTarget;
	local X2AbilityToHitCalc_WOTC_APA_BurstFireAimModifier			ToHitCalc;

	Template = class'X2Ability_WeaponCommon'.static.Add_StandardShot('WOTC_APA_BurstFire');
	//`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_BurstFire');
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_LIEUTENANT_PRIORITY;
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_BurstFire";

	X2AbilityCost_ActionPoints(Template.AbilityCosts[0]).DoNotConsumeAllSoldierAbilities.Length = 0;
	X2AbilityCost_Ammo(Template.AbilityCosts[1]).iAmmo = default.BURST_FIRE_AMMO_COST;

	// Define action point and ammo costs
	//ActionPointCost = new class'X2AbilityCost_ActionPoints';
	//ActionPointCost.iNumPoints = 1;
	//ActionPointCost.bConsumeAllPoints = true;
	//Template.AbilityCosts.AddItem(ActionPointCost);
	//
	//AmmoCost = new class'X2AbilityCost_Ammo';
	//AmmoCost.iAmmo = default.BURST_FIRE_AMMO_COST;
	//Template.AbilityCosts.AddItem(AmmoCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.BURST_FIRE_COOLDOWN;
	Template.AbilityCooldown = Cooldown;


	// Damage Effect
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	//Template.AddTargetEffect(WeaponDamageEffect);
	Template.AddMultiTargetEffect(WeaponDamageEffect);

	BurstFireMultiTarget = new class'X2AbilityMultiTarget_BurstFire';
	BurstFireMultiTarget.NumExtraShots = 1;
	Template.AbilityMultiTargetStyle = BurstFireMultiTarget;
	
	// Apply an aim penalty when taking a quick Burst-Fire (used as last standard action) vs a steadied Burst-Fire (more than 1 standard action remaining)
	ToHitCalc = new class'X2AbilityToHitCalc_WOTC_APA_BurstFireAimModifier';
	ToHitCalc.BuiltInHitMod = default.BURST_FIRE_AIM_PENALTY;
	Template.AbilityToHitCalc = ToHitCalc;
	Template.AbilityToHitOwnerOnMissCalc = ToHitCalc;
	

	Template.AlternateFriendlyNameFn = BurstFire_SteadiedFriendlyName;

	return Template;
}

// Burst-Fire Alternate LocFriendlyName
static function bool BurstFire_SteadiedFriendlyName(out string AlternateDescription, XComGameState_Ability AbilityState, StateObjectReference TargetRef)
{
	local XComGameState_Unit										SourceUnit;
	local int														iCheck;
	
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
	
	// Set checker variable to initial number of action points required for the Steadied Burst Fire (no aim penalty)
	iCheck = 2;

	// Search for invalid action point types being present. Increment checker value by 1 for each invalid action point type found.
	// Keeps check vs total # action points looking for that initial number of valid action points. Assumes that only 1 of an invalid action point type would ever be present.
	if (SourceUnit.ActionPoints.Find('FleetFootedEmergencyAid') != -1)
		iCheck += 1;

	if (SourceUnit.ActionPoints.Find('FleetFootedRapidDeployment') != -1)
		iCheck += 1;

	// Check number of action points present vs checker variable to see if an aim penalty should be applied or not.
	if (SourceUnit.ActionPoints.length < iCheck)
		return false;
	
	// Change LocFriendlyName for the ability (ability LocLongDescription is updated with loc tags - loc tags cannot update LocFriendlyName)
	AlternateDescription = default.strSteadiedBurstFireName;
	return true;
}


// Overcharged Capacitors - Misses with the Arc-Thrower disorient the target. Hits on the target apply a disorient effect on the target for one turn after the stun wears off.
static function X2AbilityTemplate WOTC_APA_OverchargedCapacitors()
{

	local X2AbilityTemplate											Template;
	local X2Effect_Persistent										IconEffect, DisorientEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_OverchargedCapacitors');
	Template.IconImage = "img:///UILibrary_LWSecondariesWOTC.LW_AbilityChainLightning";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	Template.bCrossClassEligible = false;


	// Create a persistent effect that tells the ArcThrower abilities/effects to apply an immediate disoriented effect on missed shots. Also displays passive icon.
	IconEffect = new class 'X2Effect_Persistent';
	IconEffect.EffectName = 'Arcthrower_DisorientOnMissEffect';
	IconEffect.BuildPersistentEffect(1, true, false, false);
	IconEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(IconEffect);


	// Create a persistent effect that tells the ArcThrower abilities/effects to apply a delayed disoriented effect on hit shots that applies after the stun wears off.
	DisorientEffect = new class 'X2Effect_Persistent';
	DisorientEffect.EffectName = 'Arcthrower_DisorientAfterStunEffect';
	DisorientEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(DisorientEffect);

	// Add the additional ability that creates the Disoriented effect
	Template.AdditionalAbilities.AddItem('WOTC_APA_OverchargedCapacitorsDisorient');


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

// Overcharged Capacitors Disorient - Applies the Disorient effect once the Arcthrower's Stun has worn off
static function X2AbilityTemplate WOTC_APA_OverchargedCapacitorsDisorient()
{

	local X2AbilityTemplate											Template;
	local X2Effect_Persistent										DisorientedEffect;
	local X2AbilityTrigger_EventListener							EventListener;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_OverchargedCapacitorsDisorient');
	Template.IconImage = "img:///UILibrary_LWSecondariesWOTC.LW_AbilityChainLightning";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.bCrossClassEligible = false;


	// This ability triggers after an Overcharged Capacitors Arcthrower Stun wears off
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = class'X2Effect_WOTC_APA_ArcthrowerDisorientAfterStun'.default.WOTC_APA_ArcthrowerDisorientAfterStun_TriggeredName;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.VoidRiftInsanityListener;
	Template.AbilityTriggers.AddItem(EventListener);


	// Create the Disoriented effect on the target
	DisorientedEffect = class'X2StatusEffects'.static.CreateDisorientedStatusEffect(, , false);
	DisorientedEffect.bRemoveWhenSourceDies = false;
	Template.AddTargetEffect(DisorientedEffect);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}


// Anti-Venom Stims
static function X2AbilityTemplate WOTC_APA_AntiVenomStims()
{

	local X2AbilityTemplate											Template;
	local X2Condition_UnitProperty									MultiTargetConditions;
	local X2Effect_WOTC_APA_AntiVenomStims							MovementEffect;
	local X2Effect_Persistent										IconEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_AntiVenomStims');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_AntiVenomStims";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.AbilityMultiTargetStyle = new class'X2AbilityMultiTarget_AllAllies';
	Template.bIsPassive = true;
	Template.bSkipFireAction = true;
	Template.AddShooterEffectExclusions();
	Template.bCrossClassEligible = false;
	

	// Dummy effect to show a passive icon in the tactical UI
	IconEffect = new class'X2Effect_Persistent';
	IconEffect.BuildPersistentEffect(1, true, false);
	IconEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,, Template.AbilitySourceName);
	Template.AddTargetEffect(IconEffect);


	// Add target type conditions
	MultiTargetConditions = new class'X2Condition_UnitProperty';
	MultiTargetConditions.ExcludeHostileToSource = true;
	MultiTargetConditions.TreatMindControlledSquadmateAsHostile = true;
    MultiTargetConditions.ExcludeFriendlyToSource = false;
    MultiTargetConditions.RequireSquadmates = true;
	MultiTargetConditions.ExcludeRobotic = true;
	MultiTargetConditions.ExcludeCosmetic = true;
	Template.AbilityMultiTargetConditions.AddItem(MultiTargetConditions);


	// Add the Anti-Venom Stims effect to all allies of proper type (but no range restriction) to update effect status on movement
	MovementEffect = new class'X2Effect_WOTC_APA_AntiVenomStims';
	MovementEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddMultiTargetEffect(MovementEffect);


	// Add additional abilities that handle removing the effects and providing the AOE preview
	Template.AdditionalAbilities.AddItem('WOTC_APA_AntiVenomStims_Clense');
	Template.AdditionalAbilities.AddItem('WOTC_APA_AntiVenomStims_AdrenalineShot');

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}

// Anti-Venom Stims Clense
static function X2AbilityTemplate WOTC_APA_AntiVenomStims_Clense()
{

	local X2AbilityTemplate											Template;
	local X2AbilityTrigger_EventListener							EventListener;
	local X2Condition_UnitProperty									DistanceCondition, FriendCondition;
	local X2Effect_RemoveEffects									PoisonRemoveEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_AntiVenomStims_Clense');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_AntiVenomStims";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.bSkipFireAction = true;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();
	Template.bCrossClassEligible = false;


	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = 'UnitMoveFinished';
	EventListener.ListenerData.Filter = eFilter_None;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.SolaceCleanseListener;  // keep this, since it's generically just calling the associate ability
	Template.AbilityTriggers.AddItem(EventListener);


	// Removes any ongoing effects
	PoisonRemoveEffect = new class'X2Effect_RemoveEffects';
	PoisonRemoveEffect.EffectNamesToRemove.AddItem(class'X2StatusEffects'.default.PoisonedName);
	PoisonRemoveEffect.EffectNamesToRemove.AddItem(class'X2Effect_ParthenogenicPoison'.default.EffectName);
	FriendCondition = new class'X2Condition_UnitProperty';
	FriendCondition.ExcludeFriendlyToSource = false;
	FriendCondition.ExcludeHostileToSource = true;
	PoisonRemoveEffect.TargetConditions.AddItem(FriendCondition);
	Template.AddTargetEffect(PoisonRemoveEffect);


	// Distance Condition - Add 0.01 to distance variable to smooth rounding wierdness on half values (helps some of the time at least)
	DistanceCondition = new class'X2Condition_UnitProperty';
	DistanceCondition.RequireWithinRange = true;
	DistanceCondition.WithinRange = (default.ANTIVENOM_STIMS_DISTANCE + 0.01) *  class'XComWorldData'.const.WORLD_StepSize;
	DistanceCondition.ExcludeFriendlyToSource = false;
	DistanceCondition.ExcludeHostileToSource = false;
	Template.AbilityTargetConditions.AddItem(DistanceCondition);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}

// Anti-Venom Stims Adrenaline Shot Targetable Ability with Range Preview
static function X2AbilityTemplate WOTC_APA_AntiVenomStims_AdrenalineShot()
{

	local X2AbilityTemplate											Template;
	local X2AbilityPassiveAOE_WeaponRadius							PassiveAOEStyle;
	local X2Condition_UnitProperty									TargetCondition;
	local X2Condition_WOTC_APA_Class_EffectRequirement				HasEffectCondition;
	local X2Effect_RemoveEffects									RemoveEffects;
	local X2AbilityCooldown											Cooldown;
	local X2AbilityCost_ActionPoints								ActionPointCost;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_AntiVenomStims_AdrenalineShot');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_AntiVenomStimsAdrenaline";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.MEDIKIT_HEAL_PRIORITY + 2;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.bLimitTargetIcons = true;
	Template.Hostility = eHostility_Defensive;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	//Template.bShowActivation = true;
	//Template.bSkipFireAction = true;
	Template.bShowPostActivation = true;
	Template.CustomFireAnim = 'HL_Revive';
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.ActivationSpeech = 'StabilizingAlly';
	Template.AddShooterEffectExclusions();
	Template.bCrossClassEligible = false;

	// Targetable ability cooldown and action point costs
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.ANTIVENOM_STIMS_ADRENALINE_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	Template.AbilityCosts.AddItem(ActionPointCost);


	// Show Anti-Venom Stim's AOE range when hovering over it
	PassiveAOEStyle = new class'X2AbilityPassiveAOE_WeaponRadius'; 
	PassiveAOEStyle.fTargetRadius = (default.ANTIVENOM_STIMS_DISTANCE + 0.01 + 1);
	Template.AbilityPassiveAOEStyle = PassiveAOEStyle;


	// General target and range conditions
	TargetCondition = new class'X2Condition_UnitProperty';
	TargetCondition.ExcludeFriendlyToSource = false;
	TargetCondition.ExcludeHostileToSource = true;
	TargetCondition.RequireWithinRange = true;
	TargetCondition.ExcludeRobotic = true;
	TargetCondition.WithinRange = (default.ANTIVENOM_STIMS_DISTANCE + 0.01) *  class'XComWorldData'.const.WORLD_StepSize;
	Template.AbilityTargetConditions.AddItem(TargetCondition);


	// Limit to targets suffering from an effect this ability can clear
	HasEffectCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	HasEffectCondition.bRequireAll = false;
	HasEffectCondition.RequiredEffectNames.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	HasEffectCondition.RequiredEffectNames.AddItem(class'X2AbilityTemplateManager'.default.ConfusedName);
	HasEffectCondition.RequiredEffectNames.AddItem(class'X2AbilityTemplateManager'.default.PanickedName);
	HasEffectCondition.RequiredEffectNames.AddItem(class'X2AbilityTemplateManager'.default.StunnedName);
	HasEffectCondition.RequiredEffectNames.AddItem(class'X2AbilityTemplateManager'.default.DazedName);
	HasEffectCondition.RequiredEffectNames.AddItem(class'X2AbilityTemplateManager'.default.ObsessedName);
	HasEffectCondition.RequiredEffectNames.AddItem(class'X2AbilityTemplateManager'.default.BerserkName);
	HasEffectCondition.RequiredEffectNames.AddItem(class'X2AbilityTemplateManager'.default.ShatteredName);
	Template.AbilityTargetConditions.AddItem(HasEffectCondition);


	// Effect to remove Panicked and Stunned status effects
	RemoveEffects = new class'X2Effect_RemoveEffects';
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.ConfusedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.PanickedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.StunnedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.DazedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.ObsessedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.BerserkName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.ShatteredName);
	Template.AddTargetEffect(RemoveEffects);
	
	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}


// Low Profile - Passive:
static function X2AbilityTemplate WOTC_APA_LowProfile()
{

	local X2AbilityTemplate											Template;
	local X2Effect_WOTC_APA_LowProfile								LowProfileEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_LowProfile');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_LowProfile";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	Template.bCrossClassEligible = false;


	// Create an effect that adds Low Profile defense modifier
	LowProfileEffect = new class'X2Effect_WOTC_APA_LowProfile';
	LowProfileEffect.BuildPersistentEffect (1, true, false);
	LowProfileEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(LowProfileEffect);
	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Smokescreen - Passive:
static function X2AbilityTemplate WOTC_APA_Smokescreen()
{

	local X2AbilityTemplate											Template;
	local X2Effect_WOTC_APA_Class_BonusItems						ItemEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_Smokescreen');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_Smokescreen";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;


	// Create an effect that adds [default: 1] free smoke grenade and adds [default: 1] additional charges to equipped smoke grenades
	ItemEffect = new class'X2Effect_WOTC_APA_Class_BonusItems';
	ItemEffect.BonusItems = default.SMOKESCREEN_BONUS_VALID_ITEMS;
	ItemEffect.FreeCharges = default.SMOKESCREEN_FREE_SMOKE_GRENADES;
	ItemEffect.BonusCharges = default.SMOKESCREEN_EQUIPPED_SMOKE_BONUS;
	ItemEffect.BuildPersistentEffect (1, true, false, false);
	ItemEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(ItemEffect);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Covert Infiltration - Passive:
static function X2AbilityTemplate WOTC_APA_CovertInfiltration()
{

	local X2AbilityTemplate											Template;
	local X2Effect_Persistent										ConcealEffect;
	local X2Effect_PersistentStatChange								DetectionEffect;
	

	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_CovertInfiltration');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_CovertInfiltration";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.bDisplayInUITooltip = true;
	Template.bDisplayInUITacticalText = true;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
    Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;
	

	// Create effect to keep target unit concealed
	ConcealEffect = new class'X2Effect_StayConcealed';
	ConcealEffect.BuildPersistentEffect(1, true, false);
	Template.AddTargetEffect(ConcealEffect);


	// Create effect to reduce detection radius
	DetectionEffect = new class'X2Effect_PersistentStatChange';
	DetectionEffect.BuildPersistentEffect(1, true, false);
	DetectionEffect.SetDisplayInfo (ePerkBuff_Passive,Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, true,, Template.AbilitySourceName); 
	DetectionEffect.AddPersistentStatChange(eStat_DetectionModifier, default.INFILTRATION_DETECTION_RANGE_BONUS);
	Template.AddTargetEffect(DetectionEffect);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Fire Support - Passive: Gain rifle suppression and [default: +10] bonus aim on suppression reaction shots
static function X2AbilityTemplate WOTC_APA_FireSupport()
{

	local X2AbilityTemplate											Template;
	local X2Effect_WOTC_APA_FireSupportBonus						AimEffect;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_FireSupport');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_FireSupport";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;


	// Create effect to add aim bonus if the soldier has the FireSupport ability
	AimEffect = new class'X2Effect_WOTC_APA_FireSupportBonus';
	AimEffect.BuildPersistentEffect(1, true, false, false, eGameRule_PlayerTurnBegin);
	AimEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, true,, Template.AbilitySourceName);
	Template.AddTargetEffect(AimEffect);


	// Add Suppression ability to target
	Template.AdditionalAbilities.AddItem('WOTC_APA_Suppression');
	Template.AdditionalAbilities.AddItem('WOTC_APA_SuppressionShot');
	Template.AdditionalAbilities.AddItem('WOTC_APA_SuppressionShotCF');


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Rapid Deployment - Active:
static function X2AbilityTemplate WOTC_APA_RapidDeployment()
{

	local X2AbilityTemplate											Template;
	local X2AbilityCooldown											Cooldown;
	local X2Effect_WOTC_APA_RapidDeployment							RapidDeploymentEffect;
	local X2Effect_WOTC_APA_FleetFootedRapidDeploymentActionPoint	ActionPointEffect;
	local X2Condition_WOTC_APA_Class_AbilityRequirement				AbilityCondition;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_RapidDeployment');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_RapidDeployment";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.STANDARD_GRENADE_PRIORITY - 3;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.bIsPassive = false;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();
	Template.bCrossClassEligible = false;


	// Set ability cooldown and costs
	Cooldown = new class'X2AbilityCooldown';
    Cooldown.iNumTurns = default.RAPID_DEPLOYMENT_COOLDOWN;
    Template.AbilityCooldown = Cooldown;

	Template.AbilityCosts.AddItem(default.FreeActionCost);

	
	// Add the Rapid Deployment effect
	RapidDeploymentEffect = new class 'X2Effect_WOTC_APA_RapidDeployment';
	RapidDeploymentEffect.BuildPersistentEffect (1, false, false, false, eGameRule_PlayerTurnEnd);
	RapidDeploymentEFfect.EffectName = 'SupportGrenade_FreeAction';
	Template.AddTargetEffect(RapidDeploymentEffect);


	// Create effect to give FleetFootedFree action point if unit has WOTC_APA_FleetFooted
	AbilityCondition = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
	AbilityCondition.RequiredAbilityNames.AddItem('WOTC_APA_FleetFooted');
	AbilityCondition.LogEffectName = "FleetFootedFreeActionPoint";
	
	ActionPointEffect = new class'X2Effect_WOTC_APA_FleetFootedRapidDeploymentActionPoint';
	ActionPointEffect.BuildPersistentEffect (1, false, false, false, eGameRule_PlayerTurnEnd);
	ActionPointEffect.TargetConditions.AddItem(AbilityCondition);
	Template.AddTargetEffect(ActionPointEffect);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = BasicSourceFlyover_BuildVisualization;
	return Template;
}


// Combat Stimulants - Passive:
static function X2AbilityTemplate WOTC_APA_CombatStimulants()
{
	
	local X2AbilityTemplate											Template;
	local X2Effect_WOTC_APA_Class_AddAbilitiesToTarget				AddAbility;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_CombatStimulants');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_CombatStimulants"; 
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;


	// Create effect to add the Combat Stimulant activatable ability to target
	AddAbility = new class'X2Effect_WOTC_APA_Class_AddAbilitiesToTarget';
	AddAbility.AddAbilities.AddItem('WOTC_APA_ApplyCombatStimulant');
	AddAbility.ApplyToWeaponCat = 'medikit';
	Template.AddTargetEffect(AddAbility);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

// Combat Stimulants - Active:
static function X2AbilityTemplate WOTC_APA_ApplyCombatStimulant()
{

	local X2AbilityTemplate											Template;
	local X2AbilityCooldown											Cooldown;
	local X2AbilityCost_ActionPoints								ActionPointCost;
	local X2AbilityCost_Ammo										AmmoCost;
	local X2AbilityCost_Charges										ChargeCost;
	local X2AbilityCharges											AbilityCharges;
	local X2AbilityTarget_Single									SingleTarget;
	local X2AbilityPassiveAOE_SelfRadius							PassiveAOEStyle;
	local X2Condition_UnitProperty									UnitPropertyCondition;
	local X2Condition_UnitEffectsWithAbilitySource					EffectAlreadyAppliedCondition;
	local X2Effect_Persistent										EffectAlreadyAppliedEffect;
	local X2Effect_RemoveEffects									RemoveEffects;
	local X2Effect_DamageImmunity									ImmunityEffect;
	local X2Effect_PersistentStatChange								StatChangeEffect;
	local X2Effect_WOTC_APA_CombatStimulants						ActionPointEffect;
	local X2Effect_ConditionalDamageModifier						DamageResistanceEffect;

	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_ApplyCombatStimulant');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_CombatStimulants";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.MEDIKIT_HEAL_PRIORITY + 3;
	Template.bDisplayInUITooltip = false;
	Template.bUseAmmoAsChargesForHUD = false;
	Template.bLimitTargetIcons = true;
	Template.Hostility = eHostility_Defensive;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.bIsPassive = false;
	Template.bShowActivation = true;
	Template.ActivationSpeech = 'Inspire';
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();
	Template.bCrossClassEligible = false;
	

	// Set ability targeting conditions, charges, and costs - This ability MUST be assigned a medikit as a source weapon to function correctly!
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.COMBAT_STIMULANTS_COOLDOWN;
	Template.AbilityCooldown = Cooldown;
	
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	AmmoCost.bReturnChargesError = true;
	Template.AbilityCosts.AddItem(AmmoCost);

	ChargeCost = new class'X2AbilityCost_Charges';
	ChargeCost.NumCharges = 1;
	Template.AbilityCosts.AddItem(ChargeCost);

	AbilityCharges = new class'X2AbilityCharges';
	AbilityCharges.InitialCharges = default.COMBAT_STIMULANTS_CHARGES;
	Template.AbilityCharges = AbilityCharges;

	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.OnlyIncludeTargetsInsideWeaponRange = true;
	SingleTarget.bIncludeSelf = false;
	SingleTarget.bShowAOE = true;
	Template.AbilityTargetStyle = SingleTarget;

	PassiveAOEStyle = new class'X2AbilityPassiveAOE_SelfRadius';
	PassiveAOEStyle.OnlyIncludeTargetsInsideWeaponRange = true;
	Template.AbilityPassiveAOEStyle = PassiveAOEStyle;

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeHostileToSource = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = false;
	UnitPropertyCondition.ExcludeFullHealth = false;
	UnitPropertyCondition.ExcludeRobotic = true;
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);


	// Do not allow reapplying Combat Stimulants again to the same unit in a mission
	EffectAlreadyAppliedCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	EffectAlreadyAppliedCondition.AddExcludeEffect('WOTC_APA_CombatStimulantsTarget', 'AA_UnitIsImmune');
	Template.AbilityTargetConditions.AddItem(EffectAlreadyAppliedCondition);

	EffectAlreadyAppliedEffect = new class'X2Effect_Persistent';
	EffectAlreadyAppliedEffect.EffectName = 'WOTC_APA_CombatStimulantsTarget';
	EffectAlreadyAppliedEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(EffectAlreadyAppliedEffect);
	

	// Clense Mental Damage Types and Effects from target
	RemoveEffects = new class'X2Effect_RemoveEffects';
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.ConfusedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.PanickedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.StunnedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.DazedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.ObsessedName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.BerserkName);
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.ShatteredName);
	RemoveEffects.bDoNotVisualize = true;
	Template.AddTargetEffect(RemoveEffects);
	

	// Create Immunity effect to mental afflictions
	ImmunityEffect = new class'X2Effect_DamageImmunity';
	ImmunityEffect.EffectName = 'WOTC_APA_CombatStimulantsImmunity';
	ImmunityEffect.ImmuneTypes.AddItem('Mental');
	ImmunityEffect.ImmuneTypes.AddItem(class'X2Item_DefaultDamageTypes'.default.DisorientDamageType);
	ImmunityEffect.ImmuneTypes.AddItem('stun');
	ImmunityEffect.ImmuneTypes.AddItem('Unconscious');
	ImmunityEffect.BuildPersistentEffect(default.COMBAT_STIMULANTS_TURN_DURATION, false, false, false, eGameRule_PlayerTurnBegin);
	Template.AddTargetEffect(ImmunityEffect);


	// Create Stat Change effect
	StatChangeEffect = new class'X2Effect_PersistentStatChange';
	StatChangeEffect.EffectName = 'WOTC_APA_CombatStimulantsStats';
	StatChangeEffect.BuildPersistentEffect(default.COMBAT_STIMULANTS_TURN_DURATION, false, false, false, eGameRule_PlayerTurnBegin);
	StatChangeEffect.AddPersistentStatChange(eStat_Mobility, 1 + (default.COMBAT_STIMULANTS_STATS_BONUS / 100), MODOP_Multiplication);
	StatChangeEffect.AddPersistentStatChange(eStat_Dodge, default.COMBAT_STIMULANTS_STATS_BONUS);
	StatChangeEffect.AddPersistentStatChange(eStat_Offense, default.COMBAT_STIMULANTS_STATS_BONUS);	
	StatChangeEffect.AddPersistentStatChange(eStat_CritChance, default.COMBAT_STIMULANTS_STATS_BONUS);
	StatChangeEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, false,,Template.AbilitySourceName);
	Template.AddTargetEffect(StatChangeEffect);


	// Create effect that grants additional action points each turn and deducts Will and HP penalties on removal
	ActionPointEffect = new class'X2Effect_WOTC_APA_CombatStimulants';
	ActionPointEffect.EffectName = 'WOTC_APA_CombatStimulantsActionPoints';
	ActionPointEffect.ActionPointType = class'X2CharacterTemplateManager'.default.MoveActionPoint;
	ActionPointEffect.NumActionPoints = default.COMBAT_STIMULANTS_ACTION_POINT_BONUS;
	ActionPointEffect.BuildPersistentEffect(default.COMBAT_STIMULANTS_TURN_DURATION, false, false, false, eGameRule_PlayerTurnBegin);
	ActionPointEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage,,, Template.AbilitySourceName);
	ActionPointEffect.bRemoveWhenTargetDies = true;
	Template.AddTargetEffect(ActionPointEffect);


	// Create effect that grants a damage resistence modifier
	DamageResistanceEffect = new class'X2Effect_ConditionalDamageModifier';
	DamageResistanceEffect.EffectName = 'WOTC_APA_CombatStimulantsDamageReduction';
	DamageResistanceEffect.bModifyIncomingDamage = true;
	DamageResistanceEffect.DamageModifier = (1 - default.COMBAT_STIMULANTS_DAMAGE_RESISTANCE);
	DamageResistanceEffect.BuildPersistentEffect(default.COMBAT_STIMULANTS_TURN_DURATION, false, false, false, eGameRule_PlayerTurnBegin);
	DamageResistanceEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, false,, Template.AbilitySourceName);
	DamageResistanceEffect.bRemoveWhenTargetDies = true;
	Template.AddTargetEffect(DamageResistanceEffect);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}


// Applied Knowledge - Passive:
static function X2AbilityTemplate WOTC_APA_AppliedKnowledge()
{
	local X2AbilityTemplate											Template;
	local X2Effect_WOTC_APA_AppliedKnowledgeCritModifier			CritEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_AppliedKnowledge');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_AppliedKnowledge";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;
	Template.bIsPassive = true;

	
	// Create the effect that modifies crit chance and damage on Autopsied enemy types - the conditions are handled within the crit effect
	CritEffect = new class'X2Effect_WOTC_APA_AppliedKnowledgeCritModifier';
	CritEffect.BuildPersistentEffect(1, true, false);
	CritEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(CritEffect);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Armed Intervention - Active:
static function X2AbilityTemplate WOTC_APA_ArmedIntervention()
{
	local X2AbilityTemplate										Template;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2AbilityCooldown										Cooldown;
	local X2Effect_ReserveActionPoints							ReservePointsEffect;
	local X2Condition_UnitEffects								SuppressedCondition;
	
	
	Template = CreateSelfActiveAbility('WOTC_APA_ArmedIntervention', "img:///UILibrary_WOTC_APA_Class_Pack.perk_ArmedIntervention");

	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.OVERWATCH_PRIORITY + 2;
	Template.AbilityConfirmSound = "Unreal2DSounds_OverWatch";
	Template.Hostility = eHostility_Defensive;
	Template.ActivationSpeech = 'KillZone';
	Template.ConcealmentRule = eConceal_Never;
	Template.bSkipFireAction = true;


	// Set ability costs, cooldowns, and restrictions
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.bAddWeaponTypicalCost = true;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.ARMED_INTERVENTION_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	Template.AddShooterEffectExclusions();
	SuppressedCondition = new class'X2Condition_UnitEffects';
	SuppressedCondition.AddExcludeEffect(class'X2Effect_Suppression'.default.EffectName, 'AA_UnitIsSuppressed');
	Template.AbilityShooterConditions.AddItem(SuppressedCondition);

	ReservePointsEffect = new class'X2Effect_ReserveActionPoints';
	ReservePointsEffect.ReserveType = 'WOTC_APA_ArmedIntervention';
	Template.AddShooterEffect(ReservePointsEffect);

	Template.AdditionalAbilities.AddItem('WOTC_APA_ArmedInterventionShot');

	return Template;
}

static function X2AbilityTemplate WOTC_APA_ArmedInterventionShot()
{
	local X2AbilityTemplate										Template;
	local X2AbilityCost_Ammo									AmmoCost;
	local X2AbilityCost_ReserveActionPoints						ReserveActionPointCost;
	local X2AbilityToHitCalc_StandardAim						StandardAim;
	local X2AbilityTarget_Single								SingleTarget;
	local X2AbilityTrigger_Event								Trigger;
	local X2Effect_Persistent									InterventionShotEffect, DisorientedEffect;
	local X2Condition_UnitEffectsWithAbilitySource				InterventionShotCondition;
	local X2Condition_Visibility								TargetVisibilityCondition;
	local X2Condition_UnitProperty								ShooterCondition;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_ArmedInterventionShot');

	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);

	ReserveActionPointCost = new class'X2AbilityCost_ReserveActionPoints';
	ReserveActionPointCost.iNumPoints = 1;
	ReserveActionPointCost.bFreeCost = true;
	ReserveActionPointCost.AllowedTypes.AddItem('WOTC_APA_ArmedIntervention');
	Template.AbilityCosts.AddItem(ReserveActionPointCost);

	StandardAim = new class'X2AbilityToHitCalc_StandardAim';
	StandardAim.bReactionFire = true;
	Template.AbilityToHitCalc = StandardAim;

	Template.AbilityTargetConditions.AddItem(default.LivingHostileUnitDisallowMindControlProperty);
	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	TargetVisibilityCondition.bDisablePeeksOnMovement = true;
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);
	Template.AbilityTargetConditions.AddItem(class'X2Ability_DefaultAbilitySet'.static.OverwatchTargetEffectsCondition());

	//  Do not shoot targets that were already hit by this unit this turn with this ability
	InterventionShotCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	InterventionShotCondition.AddExcludeEffect('WOTC_APA_ArmedInterventionTarget', 'AA_UnitIsImmune');
	Template.AbilityTargetConditions.AddItem(InterventionShotCondition);
	//  Mark the target as shot by this unit so it cannot be shot again this turn
	InterventionShotEffect = new class'X2Effect_Persistent';
	InterventionShotEffect.EffectName = 'WOTC_APA_ArmedInterventionTarget';
	InterventionShotEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	InterventionShotEffect.SetupEffectOnShotContextResult(true, true);      //  mark them regardless of whether the shot hit or missed
	Template.AddTargetEffect(InterventionShotEffect);

	// Apply Disorient to targets
	DisorientedEffect = class'X2StatusEffects'.static.CreateDisorientedStatusEffect(, , false);
	DisorientedEffect.bRemoveWhenSourceDies = false;
	DisorientedEffect.ApplyChance = 100;
	DisorientedEffect.SetupEffectOnShotContextResult(true, true);      //  disorient them regardless of whether the shot hit or missed
	Template.AddTargetEffect(DisorientedEffect);

	ShooterCondition = new class'X2Condition_UnitProperty';
	ShooterCondition.ExcludeConcealed = true;
	Template.AbilityShooterConditions.AddItem(ShooterCondition);

	Template.AddShooterEffectExclusions();

	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.OnlyIncludeTargetsInsideWeaponRange = true;
	Template.AbilityTargetStyle = SingleTarget;

	//  Put holo target effect first because if the target dies from this shot, it will be too late to notify the effect.
	Template.AddTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.HoloTargetEffect());
	Template.AddTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect());

	Template.bAllowAmmoEffects = true;
	Template.bAllowBonusWeaponEffects = true;

	// Add Weapon Stock damage on misses
	Template.AddTargetEffect(default.WeaponUpgradeMissDamage);

	//Trigger on movement - interrupt the move
	Trigger = new class'X2AbilityTrigger_Event';
	Trigger.EventObserverClass = class'X2TacticalGameRuleset_AttackObserver';
	Trigger.MethodName = 'InterruptGameState';
	Template.AbilityTriggers.AddItem(Trigger);

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_overwatch";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_MAJOR_PRIORITY;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}


// Sidearm Specialist - Passive: Gain +10 Aim and +1 damage with sidearms (pistols and arcthrower)
static function X2AbilityTemplate WOTC_APA_SidearmSpecialist()
{

	local X2AbilityTemplate											Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory			WeaponCondition;
	local X2Effect_BonusWeaponDamage								DamageEffect;
	local X2Effect_ToHitModifier									HitModEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_SidearmSpecialist');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_SidearmSpecialist";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;
	

	// A valid sidearm must be equipped in the inventory slot the ability is assigned to
	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories = default.SIDEARM_SPECIALIST_VALID_WEAPON_CATEGORIES;
	Template.AbilityShooterConditions.AddItem(WeaponCondition);


	// Create an effect that increases the damage and displays the passive icon
	DamageEffect = new class'X2Effect_BonusWeaponDamage';
    DamageEffect.BonusDmg = default.SIDEARM_SPECIALIST_DAMAGE_BONUS;
    DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,, Template.AbilitySourceName);
	Template.AddTargetEffect(DamageEffect);


	// Create an effect that increases the aim on sidearm secondary weapons
	HitModEffect = new class'X2Effect_ToHitModifier';
	HitModEffect.AddEffectHitModifier(eHit_Success, default.SIDEARM_SPECIALIST_AIM_BONUS, Template.LocFriendlyName,,,,,,,,true);
	HitModEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(HitModEffect);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Quickdraw - Passive: Firing pistols and the arcthrower no longer end the turn
static function X2AbilityTemplate WOTC_APA_Quickdraw()
{

	local X2AbilityTemplate											Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory			WeaponCondition;
	local X2Effect_Persistent										IconEffect;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_Quickdraw');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_quickdraw";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;


	// A valid sidearm must be equipped in the inventory slot the ability is assigned to
	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories = default.SIDEARM_SPECIALIST_VALID_WEAPON_CATEGORIES;
	Template.AbilityShooterConditions.AddItem(WeaponCondition);


	// Create a persistent effect that tells the Arcthrower abilities to not end the turn
	IconEffect = new class 'X2Effect_Persistent';
	IconEffect.BuildPersistentEffect(1, true, false, false);
	IconEffect.EffectName = 'Arcthrower_DoNotConsumeAllActionsEffect';
	IconEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(IconEffect);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Medivac - Passive: Grant +2 additional charges for post-mission healing
static function X2AbilityTemplate WOTC_APA_Medivac()
{

	local X2AbilityTemplate					Template;
	
	Template = CreatePassiveAbility('WOTC_APA_Medivac', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Medivac",, false /*Don't show icon in tactical*/);
	
	return Template;
}


// Certified CMT - Passive:
static function X2AbilityTemplate WOTC_APA_CertifiedCMT()
{

	local X2AbilityTemplate											Template;
	local X2Effect_WOTC_APA_Class_BonusItems						MedkitEffect;
	local X2Effect_WOTC_APA_ModifyHealAmount						HealModEffect;


	Template = CreatePassiveAbility('WOTC_APA_CertifiedCMT', "img:///UILibrary_WOTC_APA_Class_Pack.perk_CertifiedCMT");
	

	// Create effect to add bonus charges to medkits
	MedkitEffect = new class'X2Effect_WOTC_APA_Class_BonusItems';
	MedkitEffect.BonusItems = default.MED_BONUS_MEDKITS_VALID_ITEMS;
	MedkitEffect.BonusCharges = default.CERTIFIED_CMT_MEDIKIT_CHARGE_BONUS;
	MedkitEffect.BuildPersistentEffect (1, true, false, false);
	Template.AddTargetEffect(MedkitEffect);


	// Create effect to modify healing HP amounts for each proficiency level
	HealModEffect = new class'X2Effect_WOTC_APA_ModifyHealAmount';
	HealModEffect.HealModifier = default.CERTIFIED_CMT_MEDIKIT_HEAL_BONUS;
	HealModEffect.strFlyoverMessage = default.strMedicalSpecialistHealModMsg;
	HealModEffect.strFlyoverIcon = "img:///UILibrary_WOTC_APA_Class_Pack.perk_CertifiedCMT";
	HealModEffect.BuildPersistentEffect (1, true, false, false);
	Template.AddTargetEffect(HealModEffect);


	return Template;
}



// Quality of Care - Shell ability that lets players know they need to rebuild the class ability trees for pre-existing Field Medics
static function X2AbilityTemplate WOTC_APA_QualityOfCare()
{

	local X2AbilityTemplate					Template;
	
	Template = CreatePassiveAbility('WOTC_APA_QualityOfCate', "img:///UILibrary_PerkIcons.UIPerk_shaken",, false /*Don't show icon in tactical*/);
	
	return Template;
}


// Stunning Shot - Active:
static function X2AbilityTemplate WOTC_APA_StunShot()
{

	local X2AbilityTemplate										Template;
	local X2AbilityCooldown										Cooldown;
	local X2AbilityCost_Ammo									AmmoCost;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2AbilityToHitCalc_StandardAim						StandardAim;


	Template = class'X2Ability_WeaponCommon'.static.Add_PistolStandardShot('WOTC_APA_StunShot');
	
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_StunningShot";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_MAJOR_PRIORITY;


	Template.AbilityCosts.Length=0;

	// Set ability costs, cooldowns, and restrictions
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.STUN_SHOT_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);
	Template.bAllowAmmoEffects = true;

	ActionPointCost = new class 'X2AbilityCost_ActionPoints';
	ActionPointCost.bAddWeaponTypicalCost = true;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	
	// Modify chance to hit
	StandardAim = new class'X2AbilityToHitCalc_StandardAim';
	StandardAim.FinalMultiplier = default.STUN_SHOT_AIM_PENALTY;
	Template.AbilityToHitCalc = StandardAim;


	// Add Stun and Disorient effects
	Template.AddTargetEffect(class'X2StatusEffects'.static.CreateStunnedStatusEffect(1, 100, false));
	Template.AddTargetEffect(class'X2StatusEffects'.static.CreateDisorientedStatusEffect(, , false));


	return Template;
}


//// Medivac
//static function X2AbilityTemplate WOTC_APA_Medivac()
//{
//
	//local X2AbilityTemplate					Template;
	//local X2Effect_WOTC_APA_Medivac			HealEffect;
	//local X2Effect_WOTC_APA_MedivacSource	SourceEffect;
	//
//
	//`CREATE_X2ABILITY_TEMPLATE (Template, 'WOTC_APA_Medivac');
	//Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_Medivac";
	//Template.AbilitySourceName = 'eAbilitySource_Perk';
	//Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	//Template.Hostility = eHostility_Neutral;
	//Template.AbilityToHitCalc = default.DeadEye;
	//Template.AbilityTargetStyle = default.SelfTarget;
	//Template.AbilityMultiTargetStyle = new class'X2AbilityMultiTarget_AllAllies';
	//Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	//Template.bCrossClassEligible = false;
//
//
	//// Register all allies for the post-mission wound time reduction effect - exclude the source unit themselves
	//HealEffect = new class'X2Effect_WOTC_APA_Medivac';
	//HealEffect.BuildPersistentEffect(1, true, false, false);
	//HealEffect.TargetConditions.AddItem(new class'X2Condition_WOTC_APA_Class_ExcludeSource');
	//Template.AddMultiTargetEffect(HealEffect);
//
//
	//// Create effect to identify the SourceUnit and facilitate charge counting post-mission and to show a passive icon in the tactical UI
	//SourceEffect = new class'X2Effect_WOTC_APA_MedivacSource';
	//SourceEffect.BuildPersistentEffect(1, true, false);
	//SourceEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, true,, Template.AbilitySourceName);
	//Template.AddTargetEffect(SourceEffect);
//
//
	//Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//return Template;
//}


//// Battlefield Triage
//static function X2AbilityTemplate WOTC_APA_BattlefieldTriage()
//{
	//local X2AbilityTemplate							Template;
	//local X2Effect_WOTC_APA_BattlefieldTriage		HealEffect;
//
//
	//`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_BattlefieldTriage');
	//Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_rapidregeneration";
	//Template.AbilitySourceName = 'eAbilitySource_Perk';
	//Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	//Template.Hostility = eHostility_Neutral;
	//Template.AbilityToHitCalc = default.DeadEye;
	//Template.AbilityTargetStyle = default.SelfTarget;
	//Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	//Template.bCrossClassEligible = false;
	//Template.bIsPassive = true;
	//
//
	//// Create the post-mission healing/wound time reduction effect
	//HealEffect = new class 'X2Effect_WOTC_APA_BattlefieldTriage';
	//HealEffect.BuildPersistentEffect (1, true, false);//, false, eGameRule_TacticalGameEnd);
	//HealEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, true,, Template.AbilitySourceName);
	//Template.AddTargetEffect(HealEffect);
//
	//
	//Template.AdditionalAbilities.AddItem('WOTC_APA_BattlefieldTriageSquadWill');
//
//
	//Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//return Template;
//}
//
//// Battlefield Triage - Squad Will Boost
//static function X2AbilityTemplate WOTC_APA_BattlefieldTriageSquadWill()
//{
	//local X2AbilityTemplate							Template;
	//local X2AbilityTrigger_EventListener			EventListener;
	//local X2Effect_WOTC_APA_BattlefieldTriageSquad	WillEffect;
	//local X2Condition_UnitProperty					MultiTargetConditions;
	//local X2Condition_WOTC_APA_Class_ExcludeSource	ExcludeSourceCondition;
//
//
	//`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_BattlefieldTriageSquadWill');
	//Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_rapidregeneration";
	//Template.AbilitySourceName = 'eAbilitySource_Perk';
	//Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	//Template.Hostility = eHostility_Neutral;
	//Template.AbilityToHitCalc = default.DeadEye;
	//Template.AbilityTargetStyle = default.SelfTarget;
	//Template.AbilityMultiTargetStyle = new class'X2AbilityMultiTarget_AllAllies';
	//Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	//Template.bCrossClassEligible = false;
	//Template.bIsPassive = true;
//
//
	//// This ability triggers after X2Effect_WOTC_APA_BattlefieldTriage successfully fires
	//EventListener = new class'X2AbilityTrigger_EventListener';
	//EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	//EventListener.ListenerData.EventID = class'X2Effect_WOTC_APA_BattlefieldTriage'.default.WOTC_APA_BattlefieldTriage_TriggeredName;
	//EventListener.ListenerData.Filter = eFilter_Unit;
	//EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	//Template.AbilityTriggers.AddItem(EventListener);
//
	//
	//// Exclude SourceUnit from receiving effects
	//ExcludeSourceCondition = new class'X2Condition_WOTC_APA_Class_ExcludeSource';
//
//
	//// Set target conditions for squad Will boost
	//MultiTargetConditions = new class'X2Condition_UnitProperty';
    //MultiTargetConditions.ExcludeHostileToSource = true;
	//MultiTargetConditions.TreatMindControlledSquadmateAsHostile = true;
    //MultiTargetConditions.ExcludeFriendlyToSource = false;
    //MultiTargetConditions.RequireSquadmates = true;
	//MultiTargetConditions.ExcludeRobotic = true;
	//MultiTargetConditions.ExcludeCosmetic = true;
    //MultiTargetConditions.ExcludePanicked = true;	
	//MultiTargetConditions.ExcludeStunned = true;
//
//
	//WillEffect = new class'X2Effect_WOTC_APA_BattlefieldTriageSquad';
	//WillEffect.TargetConditions.AddItem(MultiTargetConditions);
	//WillEffect.TargetConditions.AddItem(ExcludeSourceCondition);
	//Template.AddMultiTargetEffect(WillEffect);
//
//
	//Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	////Template.BuildVisualizationFn = BattlefieldTriageSquadWill_BuildVisualization;
	//return Template;
//}

//// Plays a Flyover message displaying Will gained
//static function BattlefieldTriageSquadWill_BuildVisualization(XComGameState VisualizeGameState)
//{
	//local XComGameStateContext_Ability								AbilityContext;
	//local int														TargetID, i;
	//local VisualizationActionMetadata								ActionMetadata;
	//local string													WorldMessage;
	//local X2Action_Delay											DelayAction;
	//local X2Action_PlaySoundAndFlyOver								SoundAndFlyOver;
	//
	//AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
//
	//DelayAction = X2Action_Delay(class'X2Action_Delay'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	//DelayAction.bIgnoreZipMode = true;
	//DelayAction.Duration = 1;
//
	//for( i = 0; i < AbilityContext.InputContext.MultiTargets.Length; ++i )
	//{
		//TargetID = AbilityContext.InputContext.MultiTargets[i].ObjectID;
//
		//ActionMetadata.StateObject_OldState = `XCOMHISTORY.GetGameStateForObjectID(TargetID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
		//ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(TargetID);
		//if (ActionMetadata.StateObject_NewState == none)
			//ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
		//ActionMetadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(TargetID);
//
		//WorldMessage = "+" $ default.BATTLEFIELD_TRIAGE_SQUAD_WILL_BONUS @ class'X2TacticalGameRulesetDataStructures'.default.m_aCharStatLabels[eStat_Will];
//
		//SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
		//SoundAndFlyOver.SetSoundAndFlyOverParameters(None, WorldMessage, '', eColor_Good,, `DEFAULTFLYOVERLOOKATTIME, true);
	//}
//}