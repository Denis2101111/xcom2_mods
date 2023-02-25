
class X2Ability_WOTC_APA_MarksmanAbilitySet extends X2Ability_WOTC_APA_Utilities config(WOTC_APA_MarksmanSkills);

// Precision Targeting Proficiency Level Variables
var config float			PRECISION_TARGETING_SQUADSIGHT_PENALTY_NEGATED_1;
var config float			PRECISION_TARGETING_SQUADSIGHT_PENALTY_NEGATED_2;
var config float			PRECISION_TARGETING_SQUADSIGHT_PENALTY_NEGATED_3;

var config int				PRECISION_TARGETING_COVER_CRIT_BONUS_1;
var config int				PRECISION_TARGETING_COVER_CRIT_BONUS_2;
var config int				PRECISION_TARGETING_COVER_CRIT_BONUS_3;

var config int				PRECISION_TARGETING_ENEMY_DODGE_NEGATED_1;
var config int				PRECISION_TARGETING_ENEMY_DODGE_NEGATED_2;
var config int				PRECISION_TARGETING_ENEMY_DODGE_NEGATED_3;

var localized string		strPrecisionTargeting1Name;
var localized string		strPrecisionTargeting1Desc;
var localized string		strPrecisionTargeting2Name;
var localized string		strPrecisionTargeting2Desc;
var localized string		strPrecisionTargeting3Name;
var localized string		strPrecisionTargeting3Desc;

var config bool				OVERRIDE_BRACE_REQUIREMENTS;

var config int				BRACED_AIM_BONUS;
var config int				BRACED_RANGE_BONUS;
var config int				STALKER_CRIT_CHANCE_BONUS;
var config int				STALKER_CRIT_DAMAGE_BONUS;
var config float			STALK_MOBILITY_MODIFIER;
var config float			STALK_DETECTION_MODIFIER;
var config int				WEAPON_HANDLING_VEKTOR_CRIT_BONUS;
var config array<name>		SNAPSHOT_HIDE_IF_AVAILABLE_ABILITIES;
var config array<name>		SNAPSHOT_OVERRIDE_ABILITIES;
var config int				LEAD_TARGET_AIM_BONUS;
var config int				LEAD_TARGET_COOLDOWN;
var config int				MUFFLED_SHOT_COOLDOWN;
var config float			MUFFLED_SHOT_DAMAGE_MULTIPLIER;
var config float			MUFFLED_SHOT_CRIT_DAMAGE_MULTIPLIER;
var config int				BLINDSIDE_COOLDOWN;
var config float			BLINDSIDE_DAMAGE_MULTIPLIER;
var config float			BLINDSIDE_CRIT_DAMAGE_MULTIPLIER;
var config float			HIGH_APPROACH_ANGLE_COVER_MULTIPLIER;
var config int				QUICK_BRACE_COOLDOWN;
var config int				RAPTORS_PERCH_ACTIVATIONS;
var config int				OPPORTUNIST_DAMAGE_BONUS;
var config int				WEAPON_SPECIALIST_DAMAGE_BONUS;
var config int				GHOST_MOBILITY_BONUS;
var config int				EAGLE_EYE_SHOT_CHANCE;
var config int				EAGLE_EYE_SHOT_CHANCE_BRACED;
var config int				EAGLE_EYE_SHOT_CHANCE_VEKTOR_BONUS;
var config float			PRECISION_SHOT_MULTIPLIER;
var config float			PRECISION_SHOT_AIM_MULTIPLIER;
var config int				PRECISION_SHOT_STUN_DURATION;
var config int				PRECISION_SHOT_COOLDOWN;
var config int				HARRIERS_TALON_ARMOR_PIERCE;
var config int				APEX_PREDATOR_CRIT_DAMAGE_BONUS;
var config float			APEX_PREDATOR_PANIC_RADIUS;
var config int				APEX_PREDATOR_DISORIENT_CHANCE;
var config int				APEX_PREDATOR_PANIC_CHANCE;
var config int				APEX_PREDATOR_WEAPON_MODIFIER;

var config float			RECON_DETECTION_MODIFIER;
var config float			RECON_VISION_RANGE_MODIFIER;
var config int				HIGH_CALIBER_ARMOR_PIERCE;
var config int				HIGH_CALIBER_DAMAGE_BONUS;
var config int				HIGH_CALIBER_AMMO_MODIFIER;
var config int				CONCEALING_SMOKE_CHARGES;
var config float			CONCEALING_SMOKE_RADIUS;
var config int				SIXTH_SENSE_DODGE_BONUS;
var config int				SIXTH_SENSE_TILE_RADIUS;
var config int				STEADY_HANDS_CRIT_CHANCE_BONUS;
var config int				STEADY_HANDS_CRIT_DAMAGE_BONUS;
var config int				HAWKEYE_RANGE_BONUS;
var config int				DEATH_FROM_ABOVE_ACTIVATIONS;

var name					BraceTriggeredName;
var name					LeadTheTargetMarkEffectName;
var name					LeadTheTargetReserveActionName;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	/**/`Log("WOTC_APA_Marksman - Begin Adding Templates");

	Templates.AddItem(WOTC_APA_PrecisionTargeting());
	// Holotarget (From LW2 Secondaries)
	// Phantom (Base Game)
	Templates.AddItem(WOTC_APA_Brace());
	/*»»»*/	Templates.AddItem(WOTC_APA_ActivateBrace());
	/*»»»*/	Templates.AddItem(WOTC_APA_ExecuteBrace());

	Templates.AddItem(WOTC_APA_LeadTheTarget());
	/*»»»*/	Templates.AddItem(WOTC_APA_LeadTheTargetShot());
	Templates.AddItem(WOTC_APA_WeaponHandling());
	/*»»»*/	Templates.AddItem(WOTC_APA_Snapshot());
	Templates.AddItem(WOTC_APA_Stalker());
	/*»»»*/	Templates.AddItem(WOTC_APA_StalkOn());
	/*»»»*/	Templates.AddItem(WOTC_APA_StalkOff());
	
	Templates.AddItem(WOTC_APA_HighApproachAngle());
	Templates.AddItem(WOTC_APA_LightweightOptics());
	Templates.AddItem(WOTC_APA_Blindside());
	/*»»»*/	Templates.AddItem(WOTC_APA_BlindsideShot());
	
	Templates.AddItem(WOTC_APA_RaptorsPerch());
	Templates.AddItem(WOTC_APA_EfficientTargeting());
	Templates.AddItem(WOTC_APA_QuicksetBipod());
	/*»»»*/	Templates.AddItem(WOTC_APA_TempBrace());
	/*»»»*/	Templates.AddItem(WOTC_APA_MoveBrace());

	Templates.AddItem(WOTC_APA_WeaponSpecialist());
	Templates.AddItem(WOTC_APA_VitalPointTargeting());
	Templates.AddItem(WOTC_APA_Opportunist());	
	
	Templates.AddItem(WOTC_APA_PrecisionShot());
	/*»»»*/	Templates.AddItem(WOTC_APA_PrecisionSpecialShot());
	Templates.AddItem(WOTC_APA_ReadyForAnything());
	/*»»»*/	Templates.AddItem(WOTC_APA_ReadyForAnythingFlyover());
	Templates.AddItem(WOTC_APA_Ghost());
	/*»»»*/	Templates.AddItem(WOTC_APA_GhostMeleeModifier());

	Templates.AddItem(WOTC_APA_ApexPredator());
	/*»»»*/	Templates.AddItem(WOTC_APA_ApexPredatorPanic());
	Templates.AddItem(WOTC_APA_Sentry());
	Templates.AddItem(WOTC_APA_HarriersTalon());


	Templates.AddItem(WOTC_APA_Recon());
	Templates.AddItem(WOTC_APA_Bandolier());
	Templates.AddItem(WOTC_APA_HighCaliber());
	Templates.AddItem(WOTC_APA_ConcealingSmoke());
	Templates.AddItem(WOTC_APA_EagleEye());
	/*»»»*/	Templates.AddItem(WOTC_APA_EagleEyeTrigger());
	/*»»»*/	Templates.AddItem(WOTC_APA_EagleEyeShot());
	Templates.AddItem(WOTC_APA_MuffledShot());
	/*»»»*/	Templates.AddItem(WOTC_APA_MuffledStandardShot());
	Templates.AddItem(WOTC_APA_SixthSense());
	/*»»»*/	Templates.AddItem(WOTC_APA_SixthSenseTrigger());
	/*»»»*/	Templates.AddItem(WOTC_APA_SixthSenseSpawnTrigger());
	Templates.AddItem(WOTC_APA_HawkEye());
	Templates.AddItem(WOTC_APA_SteadyHands());
	Templates.AddItem(WOTC_APA_DeathFromAbove());

	/**/`Log("WOTC_APA_Marksman - Finished Adding Templates");

	return Templates;
}


// Precision Targeting - Base Class Proficiency Ability
static function X2AbilityTemplate WOTC_APA_PrecisionTargeting()
{
	
	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_TargetRankRequirement		RankCondition1, RankCondition2, RankCondition3;
	local X2Condition_WOTC_APA_Braced							BracedCondition;
	local X2Condition_WOTC_APA_TargetInCover					CoverCondition;
	local X2Effect_WOTC_APA_Class_NegateRangePenalty			RangeEffect1, RangeEffect2, RangeEffect3;
	local X2Effect_WOTC_APA_Class_ConditionalHitModifier		CritChance1, CritChance2, CritChance3;
	local X2Effect_WOTC_APA_Class_ConditionalHitModifier		GrazeReduction1, GrazeReduction2, GrazeReduction3;
	local X2Effect_Persistent									BraceOverrideEffect;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_PrecisionTargeting');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_PrecisionTargeting"; 
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
	RankCondition1.LogEffectName = "Precision Targeting 1";	// EffectName to use in logs
	RankCondition1.ExcludeProject = 'WOTC_APA_MarksmanUnlock1';
	
	RankCondition2 = new class 'X2Condition_WOTC_APA_Class_TargetRankRequirement';
	RankCondition2.iMinRank = 3;
	RankCondition2.iMaxRank = 5;
	RankCondition2.LogEffectName = "Precision Targeting 2";
	RankCondition2.ExcludeProject = 'WOTC_APA_MarksmanUnlock2';
	RankCondition2.GiveProject = 'WOTC_APA_MarksmanUnlock1';
	
	RankCondition3 = new class 'X2Condition_WOTC_APA_Class_TargetRankRequirement';
	RankCondition3.iMinRank = 6;
	RankCondition3.iMaxRank = -1;	// No max rank for level 3 bonuses
	RankCondition3.LogEffectName = "Precision Targeting 3";
	RankCondition3.GiveProject = 'WOTC_APA_MarksmanUnlock2';
	

	// Establish conditions requiring Braced or Temp Braced effects
	BracedCondition = new class'X2Condition_WOTC_APA_Braced';
	BracedCondition.bAllowTempBrace = true;
	BracedCondition.ExcludedAbilityNames.AddItem('WOTC_APA_Snapshot');


	// Setup effect reducing Squadsight's range penalty while Braced (this effect doesn't apply to Temporary Brace)
	RangeEffect1 = new class'X2Effect_WOTC_APA_Class_NegateRangePenalty';
	RangeEffect1.RangePenaltyPercentNegated = default.PRECISION_TARGETING_SQUADSIGHT_PENALTY_NEGATED_1;
	RangeEffect1.bLimitToSquadSightRange = true;
	RangeEffect1.SetDisplayInfo(ePerkBuff_Passive, default.strPrecisionTargeting1Name, default.strPrecisionTargeting1Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_PrecisionTargeting1", true,, Template.AbilitySourceName);
	RangeEffect1.RequiredEffectNames.AddItem('WOTC_APA_Brace_BracedEffect');
	RangeEffect1.ExcludedAbilityNames.AddItem('WOTC_APA_Snapshot');
	RangeEffect1.TargetConditions.AddItem(RankCondition1);
	Template.AddTargetEffect(RangeEffect1);

	RangeEffect2 = new class'X2Effect_WOTC_APA_Class_NegateRangePenalty';
	RangeEffect2.RangePenaltyPercentNegated = default.PRECISION_TARGETING_SQUADSIGHT_PENALTY_NEGATED_2;
	RangeEffect2.bLimitToSquadSightRange = true;
	RangeEffect2.SetDisplayInfo(ePerkBuff_Passive, default.strPrecisionTargeting2Name, default.strPrecisionTargeting2Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_PrecisionTargeting2", true,, Template.AbilitySourceName);
	RangeEffect2.RequiredEffectNames.AddItem('WOTC_APA_Brace_BracedEffect');
	RangeEffect2.ExcludedAbilityNames.AddItem('WOTC_APA_Snapshot');
	RangeEffect2.TargetConditions.AddItem(RankCondition2);
	Template.AddTargetEffect(RangeEffect2);

	RangeEffect3 = new class'X2Effect_WOTC_APA_Class_NegateRangePenalty';
	RangeEffect3.RangePenaltyPercentNegated = default.PRECISION_TARGETING_SQUADSIGHT_PENALTY_NEGATED_3;
	RangeEffect3.bLimitToSquadSightRange = true;
	RangeEffect3.SetDisplayInfo(ePerkBuff_Passive, default.strPrecisionTargeting3Name, default.strPrecisionTargeting3Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_PrecisionTargeting3", true,, Template.AbilitySourceName);
	RangeEffect3.RequiredEffectNames.AddItem('WOTC_APA_Brace_BracedEffect');
	RangeEffect3.ExcludedAbilityNames.AddItem('WOTC_APA_Snapshot');
	RangeEffect3.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(RangeEffect3);


	// Setup effect granting bonus Critical Hit chance against targets in cover
	CoverCondition = new class'X2Condition_WOTC_APA_TargetInCover';
	CoverCondition.bApplyToTargetsNotUsingCover = true;

	CritChance1 = new class'X2Effect_WOTC_APA_Class_ConditionalHitModifier';
	CritChance1.AddEffectHitModifier(eHit_Crit, default.PRECISION_TARGETING_COVER_CRIT_BONUS_1, default.strPrecisionTargeting1Name);
	CritChance1.ToHitConditions.AddItem(BracedCondition);
	CritChance1.ToHitConditions.AddItem(CoverCondition);
	CritChance1.BuildPersistentEffect(1, true, false, false);
	CritChance1.TargetConditions.AddItem(RankCondition1);
	Template.AddTargetEffect(CritChance1);

	CritChance2 = new class'X2Effect_WOTC_APA_Class_ConditionalHitModifier';
	CritChance2.AddEffectHitModifier(eHit_Crit, default.PRECISION_TARGETING_COVER_CRIT_BONUS_2, default.strPrecisionTargeting2Name);
	CritChance2.ToHitConditions.AddItem(BracedCondition);
	CritChance2.ToHitConditions.AddItem(CoverCondition);
	CritChance2.BuildPersistentEffect(1, true, false, false);
	CritChance2.TargetConditions.AddItem(RankCondition2);
	Template.AddTargetEffect(CritChance2);

	CritChance3 = new class'X2Effect_WOTC_APA_Class_ConditionalHitModifier';
	CritChance3.AddEffectHitModifier(eHit_Crit, default.PRECISION_TARGETING_COVER_CRIT_BONUS_3, default.strPrecisionTargeting3Name);
	CritChance3.ToHitConditions.AddItem(BracedCondition);
	CritChance3.ToHitConditions.AddItem(CoverCondition);
	CritChance3.BuildPersistentEffect(1, true, false, false);
	CritChance3.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(CritChance3);


	// Setup effect reducing the chance to graze targets
	GrazeReduction1 = new class'X2Effect_WOTC_APA_Class_ConditionalHitModifier';
	GrazeReduction1.AddEffectHitModifier(eHit_Graze, -default.PRECISION_TARGETING_ENEMY_DODGE_NEGATED_1, default.strPrecisionTargeting1Name);
	GrazeReduction1.ToHitConditions.AddItem(BracedCondition);
	GrazeReduction1.BuildPersistentEffect(1, true, false, false);
	GrazeReduction1.TargetConditions.AddItem(RankCondition1);
	Template.AddTargetEffect(GrazeReduction1);

	GrazeReduction2 = new class'X2Effect_WOTC_APA_Class_ConditionalHitModifier';
	GrazeReduction2.AddEffectHitModifier(eHit_Graze, -default.PRECISION_TARGETING_ENEMY_DODGE_NEGATED_2, default.strPrecisionTargeting2Name);
	GrazeReduction2.ToHitConditions.AddItem(BracedCondition);
	GrazeReduction2.BuildPersistentEffect(1, true, false, false);
	GrazeReduction2.TargetConditions.AddItem(RankCondition2);
	Template.AddTargetEffect(GrazeReduction2);

	GrazeReduction3 = new class'X2Effect_WOTC_APA_Class_ConditionalHitModifier';
	GrazeReduction3.AddEffectHitModifier(eHit_Graze, -default.PRECISION_TARGETING_ENEMY_DODGE_NEGATED_3, default.strPrecisionTargeting3Name);
	GrazeReduction3.ToHitConditions.AddItem(BracedCondition);
	GrazeReduction3.BuildPersistentEffect(1, true, false, false);
	GrazeReduction3.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(GrazeReduction3);


	if (default.OVERRIDE_BRACE_REQUIREMENTS)
	{
		BraceOverrideEffect = new class'X2Effect_Persistent';
		BraceOverrideEffect.EffectName = 'WOTC_APA_Brace_BracedEffect';
		BraceOverrideEffect.BuildPersistentEffect(1, true, false, false);
		Template.AddTargetEffect(BraceOverrideEffect);
	}


	Template.AdditionalAbilities.AddItem('WOTC_APA_Brace');


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Brace - Passive: Collector ability that grants activation and triggered abilities for Brace. Activate to gain squadsight, a vision bonus, and access to sniping abilities - Canceled by movement
static function X2AbilityTemplate WOTC_APA_Brace()
{

	local X2AbilityTemplate										Template;


	Template = CreatePassiveAbility('WOTC_APA_Brace', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Brace");


	// Add the additional abilities
	Template.AdditionalAbilities.AddItem('WOTC_APA_ActivateBrace');
	Template.AdditionalAbilities.AddItem('WOTC_APA_ExecuteBrace');


	return Template;
}

// Brace Activation - Active: Activate to trigger Brace, gaining squadsight, a vision bonus, and access to sniping abilities - Canceled by movement
static function X2AbilityTemplate WOTC_APA_ActivateBrace()
{

	local X2AbilityTemplate										Template;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2Condition_WOTC_APA_Class_EffectRequirement			ApplyCondition;
	local X2Effect_TriggerEvent									TriggerEffect;
	
	
	Template = CreateSelfActiveAbility('WOTC_APA_ActivateBrace', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Brace");

	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SERGEANT_PRIORITY;
	Template.AbilityConfirmSound = "TacticalUI_Activate_Ability_Run_N_Gun";
	Template.ActivationSpeech = 'GainingElevation';
	Template.bShowActivation = false;
	Template.bSkipFireAction = true;


	// Set ability costs, cooldowns, and restrictions
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	//ActionPointCost.bConsumeAllPoints = true;
	//ActionPointCost.DoNotConsumeAllEffects.AddItem('WOTC_APA_QuickBrace');
	Template.AbilityCosts.AddItem(ActionPointCost);

	ApplyCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	ApplyCondition.ExcludingEffectNames.AddItem('WOTC_APA_Brace_BracedEffect');
	ApplyCondition.ExcludingErrorCode = 'AA_AlreadyBraced';
	ApplyCondition.bCheckSourceUnit = true;
	Template.AbilityShooterConditions.AddItem(ApplyCondition);


	// Trigger Brace Execute ability
	TriggerEffect = new class'X2Effect_TriggerEvent';
	TriggerEffect.TriggerEventName = default.BraceTriggeredName;
	Template.AddTargetEffect(TriggerEffect);


	return Template;
}

// Brace Execute - Triggered: When triggered (through active ability or event) Brace to gain squadsight, a vision bonus, and access to sniping abilities - Canceled by movement
static function X2AbilityTemplate WOTC_APA_ExecuteBrace()
{

	local X2AbilityTemplate										Template;
	local X2AbilityTrigger_EventListener						EventListener;
	local X2Condition_WOTC_APA_Class_EffectRequirement			ApplyCondition;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;
	local X2Effect_WOTC_APA_Braced								StatEffect, SniperSquadsight, HolotargeterSquadsight;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_ExecuteBrace');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_Brace";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bDisplayInUITooltip = false;
	Template.bCrossClassEligible = false;
	Template.bShowActivation = true;
	Template.bSkipFireAction = true;


	// This ability triggers after Brace successfully fires
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = default.BraceTriggeredName;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	Template.AbilityTriggers.AddItem(EventListener);


	// Unit must not already be Braced
	ApplyCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	ApplyCondition.ExcludingEffectNames.AddItem('WOTC_APA_Brace_BracedEffect');
	ApplyCondition.ExcludingErrorCode = 'AA_AlreadyBraced';
	ApplyCondition.bCheckSourceUnit = true;
	Template.AbilityShooterConditions.AddItem(ApplyCondition);


	// Apply Vision effect - this effect is also the trigger for other effects that require Bracing
	StatEffect = new class'X2Effect_WOTC_APA_Braced';
	StatEffect.EffectName = 'WOTC_APA_Brace_BracedEffect';
	//StatEffect.AddPersistentStatChange(eStat_Offense, default.BRACED_AIM_BONUS);
	StatEffect.AddPersistentStatChange(eStat_SightRadius, default.BRACED_RANGE_BONUS);
	StatEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage,,,Template.AbilitySourceName);
	StatEffect.BuildPersistentEffect(1, true, false, false);
	StatEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(StatEffect);


	// Apply secondary effect if a sniper rifle is equipped to allow Squadsight targeting
	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories.AddItem('sniper_rifle');
	WeaponCondition.bCheckSpecificSlot = true;
	WeaponCondition.SpecificSlot = eInvSlot_PrimaryWeapon;
	WeaponCondition.bSkipCanEverBeValidCheck = true;

	SniperSquadsight = new class'X2Effect_WOTC_APA_Braced';
	SniperSquadsight.EffectName = 'Squadsight';
	SniperSquadsight.BuildPersistentEffect(1, true, false, false);
	SniperSquadsight.DuplicateResponse = eDupe_Ignore;
	SniperSquadsight.TargetConditions.AddItem(WeaponCondition);
	Template.AddTargetEffect(SniperSquadsight);


	// Create a persistent effect that tells the Holotargeter abilities/effects to work at Squadsight ranges (needed when Sniper Rifle is not equipped).
	HolotargeterSquadsight = new class 'X2Effect_WOTC_APA_Braced';
	HolotargeterSquadsight.EffectName = 'Holotargeter_AllowSquadsightEffect';
	HolotargeterSquadsight.BuildPersistentEffect(1, true, false, false);
	HolotargeterSquadsight.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(HolotargeterSquadsight);


	Template.BuildNewGameStateFn = BraceAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;


	return Template;
}

//// Brace - Active: Activate to gain squadsight, an aim bonus, and access to sniping abilities - Canceled by movement
//static function X2AbilityTemplate WOTC_APA_Brace()
//{
//
	//local X2AbilityTemplate										Template;
	//local X2AbilityCost_ActionPoints							ActionPointCost;
	//local X2Condition_WOTC_APA_Class_EffectRequirement			ApplyCondition;
	//local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;
	//local X2Effect_WOTC_APA_Braced								StatEffect, SniperSquadsight, HolotargeterSquadsight;
	//
	//
	//Template = CreateSelfActiveAbility('WOTC_APA_Brace', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Brace");
//
	//Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SERGEANT_PRIORITY;
	//Template.AbilityConfirmSound = "TacticalUI_Activate_Ability_Run_N_Gun";
	////Template.ActivationSpeech = 'GainingElevation';
	////Template.CustomFireAnim = 'LL_HunkerDwn_Start';
	//Template.bSkipFireAction = true;
//
//
	//// Set ability costs, cooldowns, and restrictions
	//ActionPointCost = new class'X2AbilityCost_ActionPoints';
	//ActionPointCost.iNumPoints = 1;
	//ActionPointCost.bConsumeAllPoints = true;
	//ActionPointCost.DoNotConsumeAllEffects.AddItem('WOTC_APA_QuickBrace');
	//Template.AbilityCosts.AddItem(ActionPointCost);
//
	//ApplyCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	//ApplyCondition.ExcludingEffectNames.AddItem('WOTC_APA_Brace_BracedEffect');
	//ApplyCondition.ExcludingErrorCode = 'AA_AlreadyBraced';
	//ApplyCondition.bCheckSourceUnit = true;
	//Template.AbilityShooterConditions.AddItem(ApplyCondition);
//
//
	//// Apply Aim effect - this effect is also the trigger for other effects that require Bracing
	//StatEffect = new class'X2Effect_WOTC_APA_Braced';
	//StatEffect.EffectName = 'WOTC_APA_Brace_BracedEffect';
	////StatEffect.CustomIdleOverrideAnim = 'HL_HunkerDwn_Loop';
	////StatEffect.AddPersistentStatChange(eStat_Offense, default.BRACED_AIM_BONUS);
	//StatEffect.AddPersistentStatChange(eStat_SightRadius, default.BRACED_RANGE_BONUS);
	//StatEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage,,,Template.AbilitySourceName);
	//StatEffect.BuildPersistentEffect(1, true, false, false);
	//StatEffect.DuplicateResponse = eDupe_Ignore;
	//Template.AddTargetEffect(StatEffect);
//
//
	//// Apply secondary effect if a sniper rifle is equipped to allow Squadsight targeting
	//WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	//WeaponCondition.AllowedWeaponCategories.AddItem('sniper_rifle');
	//WeaponCondition.bCheckSpecificSlot = true;
	//WeaponCondition.SpecificSlot = eInvSlot_PrimaryWeapon;
	//WeaponCondition.bSkipCanEverBeValidCheck = true;
//
	//SniperSquadsight = new class'X2Effect_WOTC_APA_Braced';
	//SniperSquadsight.EffectName = 'Squadsight';
	//SniperSquadsight.BuildPersistentEffect(1, true, false, false);
	//SniperSquadsight.DuplicateResponse = eDupe_Ignore;
	//SniperSquadsight.TargetConditions.AddItem(WeaponCondition);
	//Template.AddTargetEffect(SniperSquadsight);
//
//
	//// Create a persistent effect that tells the Holotargeter abilities/effects to work at Squadsight ranges (needed when Sniper Rifle is not equipped).
	//HolotargeterSquadsight = new class 'X2Effect_WOTC_APA_Braced';
	//HolotargeterSquadsight.EffectName = 'Holotargeter_AllowSquadsightEffect';
	//HolotargeterSquadsight.BuildPersistentEffect(1, true, false, false);
	//HolotargeterSquadsight.DuplicateResponse = eDupe_Ignore;
	//Template.AddTargetEffect(HolotargeterSquadsight);
//
//
	//Template.BuildNewGameStateFn = BraceAbility_BuildGameState;
//
	//return Template;
//}

simulated function XComGameState BraceAbility_BuildGameState(XComGameStateContext Context)
{
	local XComGameState NewGameState;
	local XComGameState_Unit UnitState;
	local XComGameStateContext_Ability AbilityContext;
	local TTile UnitTile;

	NewGameState = TypicalAbility_BuildGameState(Context);
	AbilityContext = XComGameStateContext_Ability(NewGameState.GetContext());

	//NewGameState = `XCOMHISTORY.CreateNewGameState(true, Context);
	//AbilityContext = XComGameStateContext_Ability(Context);
	
	// Update Vis/FoW
	UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', AbilityContext.InputContext.SourceObject.ObjectID));
	UnitTile = UnitState.TileLocation;
	UnitState.SetVisibilityLocation(UnitTile);

	//Build the new game state and context
	NewGameState = TypicalAbility_BuildGameState(Context);
	
	return NewGameState;	
}


// Lead The Target - Active: Queue a shot on a target that will be taken on the enemy's turn with an increased chance to hit. Does not count as reaction fire.
static function X2AbilityTemplate WOTC_APA_LeadTheTarget()
{

	local X2AbilityTemplate										Template;
	local X2AbilityCooldown										Cooldown;
	local X2AbilityCost_Ammo									AmmoCost;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2Effect_ReserveActionPoints							ReservePointsEffect;
	local X2Condition_Visibility								TargetVisibilityCondition;
	local X2Effect_Persistent									MarkEffect;
	local X2Condition_WOTC_APA_Class_EffectRequirement			ApplyCondition, EnemyEffectCondition;
	

	`CREATE_X2ABILITY_TEMPLATE (Template, 'WOTC_APA_LeadTheTarget');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_LeadTheTarget";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_LIEUTENANT_PRIORITY;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.bShowPostActivation = true;
	Template.bSkipFireAction = true;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.bCrossClassEligible = false;

	// Set ability costs, cooldowns, and restrictions
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.LEAD_TARGET_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	AmmoCost.bFreeCost = true;
	Template.AbilityCosts.AddItem(AmmoCost);

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;   //  this will guarantee the unit has at least 1 action point
	ActionPointCost.bFreeCost = true;           //  ReserveActionPoints effect will take all action points away
	ActionPointCost.DoNotConsumeAllEffects.Length = 0;
	ActionPointCost.DoNotConsumeAllSoldierAbilities.Length = 0;
	ActionPointCost.AllowedTypes.RemoveItem(class'X2CharacterTemplateManager'.default.SkirmisherInterruptActionPoint);
	Template.AbilityCosts.AddItem(ActionPointCost);

	ReservePointsEffect = new class'X2Effect_ReserveActionPoints';
	ReservePointsEffect.ReserveType = default.LeadTheTargetReserveActionName;
	Template.AddShooterEffect(ReservePointsEffect);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	TargetVisibilityCondition.bAllowSquadsight = true;
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);
	Template.AbilityTargetConditions.AddItem(default.LivingHostileUnitOnlyProperty);


	// Create effect to identify the SourceUnit and facilitate charge counting post-mission and to show a passive icon in the tactical UI
	MarkEffect = new class'X2Effect_Persistent';
	MarkEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnEnd);
	MarkEffect.EffectName = default.LeadTheTargetMarkEffectName;
	MarkEffect.SetDisplayInfo(ePerkBuff_Penalty, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, true,, Template.AbilitySourceName);
	Template.AddTargetEffect(MarkEffect);


	// Require that the shooter be Braced or Temp Braced
	ApplyCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	ApplyCondition.RequiredEffectNames.AddItem('WOTC_APA_Brace_BracedEffect');
	ApplyCondition.RequiredEffectNames.AddItem('WOTC_APA_Brace_TempBracedEffect');
	ApplyCondition.RequiredErrorCode = 'AA_RequiresBraced';
	ApplyCondition.bCheckSourceUnit = true;
	ApplyCondition.bRequireAll = false;
	Template.AbilityShooterConditions.AddItem(ApplyCondition);


	Template.AdditionalAbilities.AddItem('WOTC_APA_LeadTheTargetShot');


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}

// Lead The Target Shot - Passive: Triggered Lead the Target shot fired at the enemy
static function X2AbilityTemplate WOTC_APA_LeadTheTargetShot()
{
	local X2AbilityTemplate										Template;
	local X2AbilityCost_Ammo									AmmoCost;
	local X2AbilityCost_ReserveActionPoints						ReserveActionPointCost;
	local X2AbilityToHitCalc_WOTC_APA_LeadTheTarget				AbilityAim;
	local X2AbilityTarget_Single								SingleTarget;
	local X2AbilityTrigger_EventListener						EventTrigger;
	local X2Condition_Visibility								TargetVisibilityCondition;
	local X2Condition_UnitEffectsWithAbilitySource				TargetEffectCondition;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_LeadTheTargetShot');

	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);

	ReserveActionPointCost = new class'X2AbilityCost_ReserveActionPoints';
	ReserveActionPointCost.iNumPoints = 1;
	ReserveActionPointCost.AllowedTypes.AddItem(default.LeadTheTargetReserveActionName);
	Template.AbilityCosts.AddItem(ReserveActionPointCost);

	AbilityAim = new class'X2AbilityToHitCalc_WOTC_APA_LeadTheTarget';
	AbilityAim.bAllowCrit = false;
	AbilityAim.bReactionFire = false;
	AbilityAim.BuiltInHitMod = default.LEAD_TARGET_AIM_BONUS;
	Template.AbilityToHitCalc = AbilityAim;
		
	TargetEffectCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	TargetEffectCondition.AddRequireEffect(default.LeadTheTargetMarkEffectName, 'AA_MissingRequiredEffect');
	Template.AbilityTargetConditions.AddItem(TargetEffectCondition);
	
	Template.AbilityTargetConditions.AddItem(default.LivingHostileUnitDisallowMindControlProperty);
	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	TargetVisibilityCondition.bDisablePeeksOnMovement = true;
	TargetVisibilityCondition.bAllowSquadsight = true;
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);
	//Template.AbilityTargetConditions.AddItem(class'X2Ability_DefaultAbilitySet'.static.OverwatchTargetEffectsCondition());

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.OnlyIncludeTargetsInsideWeaponRange = true;
	Template.AbilityTargetStyle = SingleTarget;

	//  Put holo target effect first because if the target dies from this shot, it will be too late to notify the effect.
	Template.AddTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.HoloTargetEffect());
	Template.AddTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect());

	Template.bAllowAmmoEffects = true;
	Template.bAllowBonusWeaponEffects = true;

	Template.AbilityTriggers.length = 0;
	EventTrigger = new class'X2AbilityTrigger_EventListener';
	EventTrigger.ListenerData.Filter = eFilter_None;
	EventTrigger.ListenerData.EventID = 'AbilityActivated';
	EventTrigger.ListenerData.EventFn = LeadTheTargetShotListener;
	EventTrigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	Template.AbilityTriggers.AddItem(EventTrigger);

	EventTrigger = new class'X2AbilityTrigger_EventListener';
	EventTrigger.ListenerData.Filter = eFilter_None;
	EventTrigger.ListenerData.EventID = 'ObjectMoved';
	//EventTrigger.ListenerData.EventFn = class'XComGameState_Ability'.static.TypicalOverwatchListener;
	EventTrigger.ListenerData.EventFn = class'XComGameState_Ability'.static.VoidRiftInsanityListener;
	EventTrigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	Template.AbilityTriggers.AddItem(EventTrigger);

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_overwatch";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_MAJOR_PRIORITY;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;

	Template.TargetingMethod = class'X2TargetingMethod_OverTheShoulder';
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_leadthetarget";
	Template.bUsesFiringCamera = true;
	Template.bShowActivation = true;
	Template.CinescriptCameraType = "StandardGunFiring";

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotChosenActivationIncreasePerUse;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;
	Template.bFrameEvenWhenUnitIsHidden = true;

	return Template;
}

static function EventListenerReturn LeadTheTargetShotListener(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
	local XComGameStateHistory					History;
	local StateObjectReference					AbilityRef;
	local XComGameStateContext_Ability			AbilityContext;
	local XComGameState_Ability					AttackAbilityState, ResponseAbilityState;
	local XComGameState_Effect					EffectState;
	local XComGameState_Unit					RespondingUnit;
	local int									TargetID, i;

	History = `XCOMHISTORY;

	// Get Response ability and UnitState
	ResponseAbilityState = XComGameState_Ability(CallbackData);
	if (ResponseAbilityState == none)
		return ELR_NoInterrupt;
	
	RespondingUnit = XComGameState_Unit(History.GetGameStateForObjectID(ResponseAbilityState.OwnerStateObject.ObjectID));
	if (RespondingUnit == none)
		return ELR_NoInterrupt;

	i = RespondingUnit.AppliedEffectNames.Find(default.LeadTheTargetMarkEffectName);
	EffectState = XComGameState_Effect(History.GetGameStateForObjectID(RespondingUnit.AppliedEffects[i].ObjectID));
	if (i == -1 || EffectState == none)
		return ELR_NoInterrupt;

	// Get incoming attack state and hostility
	AbilityContext = XComGameStateContext_Ability(GameState.GetContext());
	AttackAbilityState = XComGameState_Ability(EventData);
	if (AbilityContext == none || AttackAbilityState == none || AttackAbilityState.GetMyTemplate().Hostility != eHostility_Offensive)
		return ELR_NoInterrupt;

	// Get Target ID and ensure attack is not an interrupt against the responder
	TargetID = AbilityContext.InputContext.PrimaryTarget.ObjectID;
	if (TargetID == RespondingUnit.ObjectID && AbilityContext.InterruptionStatus == eInterruptionStatus_Interrupt)
		return ELR_NoInterrupt;

	// Attempt to have RespondingUnit interrupt and take the shot against the attacker
	class'XComGameStateContext_Ability'.static.ActivateAbilityByTemplateName(RespondingUnit.GetReference(), ResponseAbilityState.GetMyTemplateName(), AbilityContext.InputContext.SourceObject);

	return ELR_NoInterrupt;
}


// Advanced Weapon Handling - Passive: Grants +1 Critical Hit Damage for Vektor Rifles and adds Snapshot for Sniper Rifles.
static function X2AbilityTemplate WOTC_APA_WeaponHandling()
{

	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;
	local X2Effect_WOTC_APA_Class_BonusDamage					DamageEffect;
	//local X2Condition_WOTC_APA_Class_EffectRequirement		EffectCondition;
	//local X2Condition_WOTC_APA_Class_NumActionPoints			ActionPointCondition;
	//local X2Effect_WOTC_APA_Class_ConditionalHitModifier		AimEffect;


	Template = CreatePassiveAbility('WOTC_APA_WeaponHandling', "img:///UILibrary_WOTC_APA_Class_Pack.perk_WeaponHandling", 'WOTC_APA_WeaponHandlingIcon');


	// Create a persistent effect that increases damage on Critical Hits for Vektor Rifles
	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories.AddItem('vektor_rifle');
	WeaponCondition.bCheckSpecificSlot = true;
	WeaponCondition.SpecificSlot = eInvSlot_PrimaryWeapon;
	WeaponCondition.bSkipCanEverBeValidCheck = true;

	DamageEffect = new class'X2Effect_WOTC_APA_Class_BonusDamage';
	DamageEffect.BonusCritDmg = default.WEAPON_HANDLING_VEKTOR_CRIT_BONUS;
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, false,, Template.AbilitySourceName);
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.TargetConditions.AddItem(WeaponCondition);
	Template.AddTargetEffect(DamageEffect);


	//// Create an effect that grants an aim bonus when firing primary weapon with more than 1 action remaining and NOT Braced
	//EffectCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	//EffectCondition.ExcludingEffectNames.AddItem('WOTC_APA_Brace_BracedEffect');
	//EffectCondition.bCheckSourceUnit = true;
//
	//ActionPointCondition = new class'X2Condition_WOTC_APA_Class_NumActionPoints';
	//ActionPointCondition.ExpectedNumActionPoints = 2;
//
	//AimEffect = new class 'X2Effect_WOTC_APA_Class_ConditionalHitModifier';
	//AimEffect.EffectName = 'WOTC_APA_WeaponHandling_AimEffect';
	//AimEffect.AddEffectHitModifier(eHit_Success, default.WEAPON_HANDLING_AIM_BONUS, Template.LocFriendlyName);
	//AimEffect.ToHitConditions.AddItem(EffectCondition);
	//AimEffect.ToHitConditions.AddItem(ActionPointCondition);
	//AimEffect.BuildPersistentEffect(1, true, false, false);
	//AimEffect.DuplicateResponse = eDupe_Ignore;
	//Template.AddTargetEffect(AimEffect);


	// Add the additional abilities
	Template.AdditionalAbilities.AddItem('WOTC_APA_Snapshot');


	return Template;
}

// Snapshot - Active: Fire your Sniper Rifle with only one action, but lose access to aim bonuses from Bracing and cannot Crit
static function X2AbilityTemplate WOTC_APA_Snapshot()
{

	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;
	local X2AbilityToHitCalc_StandardAim						StandardAim;
	local X2AbilityCost_Ammo									AmmoCost;
	local X2AbilityCost_ActionPoints							ActionPointCost;


	Template = class'X2Ability_WeaponCommon'.static.Add_SniperStandardFire('WOTC_APA_Snapshot');
	
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_standard";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.STANDARD_SHOT_PRIORITY + 1;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideIfOtherAvailable;
	Template.HideIfAvailable = default.SNAPSHOT_HIDE_IF_AVAILABLE_ABILITIES;

	Template.DefaultSourceItemSlot = eInvSlot_PrimaryWeapon;

	// Require a Sniper Rifle to be equipped to add the ability to unit on spawn
	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories.AddItem('sniper_rifle');
	WeaponCondition.bSkipAbilitySourceWeaponCheck = true;
	Template.AbilityShooterConditions.AddItem(WeaponCondition);


	// Remove ability for shot to critically hit
	StandardAim = new class'X2AbilityToHitCalc_StandardAim';
	StandardAim.bAllowCrit = false;
	Template.AbilityToHitCalc = StandardAim;


	Template.AbilityCosts.Length=0;

	// Ammo and Action Point cost
	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);
	Template.bAllowAmmoEffects = true;

	ActionPointCost = new class 'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);


	Template.OverrideAbilities = default.SNAPSHOT_OVERRIDE_ABILITIES;


	return Template;
}


// Stalker - Passive: Grants the Stalk ability, and a bonus to Crit Chance against flanked or unaware enemies
static function X2AbilityTemplate WOTC_APA_Stalker()
{

	local X2AbilityTemplate										Template;
	local X2Effect_ToHitModifier								StatEffect;


	Template = CreatePassiveAbility('WOTC_APA_Stalker', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Stalker", 'WOTC_APA_StalkerIcon');


	// Add the bonuses to Crit Chance when flanking or undetected (either concealed or shooting from beyond target's vision)
	StatEffect = new class'X2Effect_ToHitModifier';
	StatEffect.EffectName = 'WOTC_APA_Stalker_CritEffect';
	StatEffect.DuplicateResponse = eDupe_Ignore;
	StatEffect.BuildPersistentEffect(1, true, false);
	StatEffect.AddEffectHitModifier(eHit_Crit, default.STALKER_CRIT_CHANCE_BONUS, Template.LocFriendlyName);
	StatEffect.ToHitConditions.AddItem(new class'X2Condition_WOTC_APA_FlankedOrConcealed');
	Template.AddTargetEffect(StatEffect);


	// Add the additional abilities
	Template.AdditionalAbilities.AddItem('WOTC_APA_StalkOn');
	Template.AdditionalAbilities.AddItem('WOTC_APA_StalkOff');


	return Template;
}

// Stalk (On) - Active: Togglable on ability to reduce detection radius and mobility
static function X2AbilityTemplate WOTC_APA_StalkOn()
{

	local X2AbilityTemplate										Template;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2Condition_WOTC_APA_Class_Concealment				ConcealedCondition;
	local X2Condition_WOTC_APA_Class_EffectRequirement			ApplyCondition;
	local X2Effect_WOTC_APA_Class_SetAbilityCooldown			SharedCooldown;
	local X2Effect_WOTC_APA_Stalk								StatEffect;
	
	
	Template = CreateSelfActiveAbility('WOTC_APA_StalkOn', "img:///UILibrary_WOTC_APA_Class_Pack.perk_StalkOn");

	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY;
	Template.AbilityConfirmSound = "TacticalUI_Activate_Ability_Run_N_Gun";
	Template.ActivationSpeech = 'RunAndGun';
	Template.bSkipFireAction = true;


	// Hide ability when concealment has been broken or other toggle is active
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
	Template.HideErrors.AddItem('AA_UnitAlreadySpotted');
	Template.HideErrors.AddItem('AA_HasAnExcludingEffect');
	Template.HideErrors.AddItem('AA_FailedActionPointCheck');
	Template.HideErrors.AddItem('AA_CoolingDown');
	
	ConcealedCondition = new class'X2Condition_WOTC_APA_Class_Concealment';
	Template.AbilityShooterConditions.AddItem(ConcealedCondition);

	ApplyCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	ApplyCondition.ExcludingEffectNames.AddItem('WOTC_APA_Stalk_StatEffect');
	ApplyCondition.bCheckSourceUnit = true;
	Template.AbilityShooterConditions.AddItem(ApplyCondition);


	// Set ability costs, cooldowns, and restrictions
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	SharedCooldown = new class'X2Effect_WOTC_APA_Class_SetAbilityCooldown';
	SharedCooldown.AbilitiesToSet.AddItem('WOTC_APA_StalkOn');
	SharedCooldown.AbilitiesToSet.AddItem('WOTC_APA_StalkOff');
	SharedCooldown.SetCooldownTo = 1;
	Template.AddTargetEffect(SharedCooldown);


	// Setup effect
	StatEffect = new class'X2Effect_WOTC_APA_Stalk';
	StatEffect.EffectName = 'WOTC_APA_Stalk_StatEffect';
	StatEffect.AddPersistentStatChange(eStat_Mobility, default.STALK_MOBILITY_MODIFIER, MODOP_Multiplication);
	StatEffect.AddPersistentStatChange(eStat_DetectionModifier, 1 - default.STALK_DETECTION_MODIFIER);
	StatEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage,,,Template.AbilitySourceName);
	StatEffect.SetDisplayInfo(ePerkBuff_Penalty, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage,,,Template.AbilitySourceName);
	StatEffect.BuildPersistentEffect(1, true, false, false);
	StatEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(StatEffect);


	return Template;
}

// Stalk (Off) - Active: Togglable off ability to reduce detection radius and mobility
static function X2AbilityTemplate WOTC_APA_StalkOff()
{

	local X2AbilityTemplate										Template;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2Condition_WOTC_APA_Class_Concealment				ConcealedCondition;
	local X2Condition_WOTC_APA_Class_EffectRequirement			RemoveCondition;
	local X2Effect_WOTC_APA_Class_SetAbilityCooldown			SharedCooldown;
	local X2Effect_RemoveEffects								RemoveEffect;
	
	
	Template = CreateSelfActiveAbility('WOTC_APA_StalkOff', "img:///UILibrary_WOTC_APA_Class_Pack.perk_StalkOff");

	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY;
	Template.AbilityConfirmSound = "TacticalUI_Activate_Ability_Run_N_Gun";
	Template.ActivationSpeech = 'RunAndGun';
	Template.bSkipFireAction = true;


	// Hide ability when concealment has been broken or other toggle is active
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
	Template.HideErrors.AddItem('AA_UnitAlreadySpotted');
	Template.HideErrors.AddItem('AA_MissingRequiredEffect');
	Template.HideErrors.AddItem('AA_FailedActionPointCheck');
	Template.HideErrors.AddItem('AA_CoolingDown');
	
	ConcealedCondition = new class'X2Condition_WOTC_APA_Class_Concealment';
	Template.AbilityShooterConditions.AddItem(ConcealedCondition);

	RemoveCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	RemoveCondition.RequiredEffectNames.AddItem('WOTC_APA_Stalk_StatEffect');
	RemoveCondition.bCheckSourceUnit = true;
	Template.AbilityShooterConditions.AddItem(RemoveCondition);


	// Set ability costs, cooldowns, and restrictions
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	SharedCooldown = new class'X2Effect_WOTC_APA_Class_SetAbilityCooldown';
	SharedCooldown.AbilitiesToSet.AddItem('WOTC_APA_StalkOn');
	SharedCooldown.AbilitiesToSet.AddItem('WOTC_APA_StalkOff');
	SharedCooldown.SetCooldownTo = 1;
	Template.AddTargetEffect(SharedCooldown);


	// Setup remove effect
	RemoveEffect = new class'X2Effect_RemoveEffects';
	RemoveEffect.EffectNamesToRemove.AddItem('WOTC_APA_Stalk_StatEffect');
	Template.AddTargetEffect(RemoveEffect);


	return Template;
}


// High Approach Angle - Passive: While braced, shots against targets at lower elevations ignore half of their defense from cover.
static function X2AbilityTemplate WOTC_APA_HighApproachAngle()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_HighApproachAngle					AimEffect;


	Template = CreatePassiveAbility('WOTC_APA_HighApproachAngle', "img:///UILibrary_WOTC_APA_Class_Pack.perk_HighApproachAngle", 'WOTC_APA_HighApproachAngleIcon');


	// Add Cover-compensating Aim bonus when braced with height advantage
	AimEffect = new class 'X2Effect_WOTC_APA_HighApproachAngle';
	AimEffect.fCoverDefenseMultiplier = default.HIGH_APPROACH_ANGLE_COVER_MULTIPLIER;
	AimEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false,, Template.AbilitySourceName);
	AimEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(AimEffect);


	return Template;
}


// Lightweight Optics - Passive: Grants Squadsight to the Holotargeter and Sniper Rifle without being Braced.
static function X2AbilityTemplate WOTC_APA_LightweightOptics()
{

	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;
	local X2Effect_Squadsight									SniperSquadsight;
	local X2Effect_Persistent									HolotargeterSquadsight;


	Template = CreatePassiveAbility('WOTC_APA_LightweightOptics', "img:///UILibrary_WOTC_APA_Class_Pack.perk_LightweightOptics", 'WOTC_APA_LightweightOpticsIcon');


	// Grant Squadsight if a sniper rifle is equipped
	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories.AddItem('sniper_rifle');
	WeaponCondition.bCheckSpecificSlot = true;
	WeaponCondition.SpecificSlot = eInvSlot_PrimaryWeapon;
	WeaponCondition.bSkipCanEverBeValidCheck = true;

	SniperSquadsight = new class'X2Effect_Squadsight';
	SniperSquadsight.EffectName = 'Squadsight';
	SniperSquadsight.BuildPersistentEffect(1, true, false, false);
	SniperSquadsight.DuplicateResponse = eDupe_Allow;
	SniperSquadsight.TargetConditions.AddItem(WeaponCondition);
	Template.AddTargetEffect(SniperSquadsight);


	// Create a persistent effect that tells the Holotargeter abilities/effects to work at Squadsight ranges (needed when Sniper Rifle is not equipped).
	HolotargeterSquadsight = new class 'X2Effect_Persistent';
	HolotargeterSquadsight.EffectName = 'Holotargeter_AllowSquadsightEffect';
	HolotargeterSquadsight.BuildPersistentEffect(1, true, false, false);
	HolotargeterSquadsight.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(HolotargeterSquadsight);


	return Template;
}


// Blindside - Passive: Grants Blindside active shot ability and sets damage multiplier.
static function X2AbilityTemplate WOTC_APA_Blindside()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_BonusDamage					DamageEffect;


	Template = CreatePassiveAbility('WOTC_APA_Blindside', "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_Needle");


	// Create a persistent effect that reduces damage
	DamageEffect = new class'X2Effect_WOTC_APA_Class_BonusDamage';
	DamageEffect.fBonusDmgMultiplier = default.BLINDSIDE_DAMAGE_MULTIPLIER;
	DamageEffect.fBonusCritDmgMultiplier = default.BLINDSIDE_CRIT_DAMAGE_MULTIPLIER;
	DamageEffect.bCritReplacesBonus = true;
	DamageEffect.ValidAbilities.AddItem('WOTC_APA_BlindsideShot');
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false,, Template.AbilitySourceName);
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(DamageEffect);


	Template.AdditionalAbilities.AddItem('WOTC_APA_BlindsideShot');


	return Template;
}

// Blindside Shot - Active:
static function X2AbilityTemplate WOTC_APA_BlindsideShot()
{

	local X2AbilityTemplate										Template;
	local X2Effect_Persistent									DisorientedEffect;
	local X2AbilityCooldown										Cooldown;
	local X2AbilityCost_Ammo									AmmoCost;
	local X2AbilityCost_ActionPoints							ActionPointCost;


	Template = class'X2Ability_WeaponCommon'.static.Add_StandardShot('WOTC_APA_BlindsideShot', false, false, false);
	
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_sting";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_CORPORAL_PRIORITY;
	Template.DefaultSourceItemSlot = eInvSlot_PrimaryWeapon;
	Template.bAllowFreeFireWeaponUpgrade = false;
	Template.ConcealmentRule = eConceal_Always;


	// Break squad concealment on shot
	Template.AddTargetEffect(new class'X2Effect_WOTC_APA_Class_BreakSquadConcealment');


	// Create the Disoriented effect on the target
	DisorientedEffect = class'X2StatusEffects'.static.CreateDisorientedStatusEffect(, , false);
	DisorientedEffect.bRemoveWhenSourceDies = false;
	Template.AddTargetEffect(DisorientedEffect);


	Template.AbilityCosts.Length=0;

	// Set ability costs, cooldowns, and restrictions
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.MUFFLED_SHOT_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);
	Template.bAllowAmmoEffects = true;

	ActionPointCost = new class 'X2AbilityCost_ActionPoints';
	ActionPointCost.bAddWeaponTypicalCost = true;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);


	return Template;
}


// Raptor's Perch - Passive: Once per turn, killing a target at a lower elevation while braced will refund one action.
static function X2AbilityTemplate WOTC_APA_RaptorsPerch()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_RaptorsPerch						RefundEffect;


	Template = CreatePassiveAbility('WOTC_APA_RaptorsPerch', "img:///UILibrary_WOTC_APA_Class_Pack.perk_RaptorsPerch", 'WOTC_APA_RaptorsPerchIcon');


	// Create a persistent effect that refunds an action after height-advantage kill while braced
	RefundEffect= new class 'X2Effect_WOTC_APA_RaptorsPerch';
	RefundEffect.EffectName = 'WOTC_APA_RaptorsPerchEffect';
	RefundEffect.RaptorsPerchActivations = default.RAPTORS_PERCH_ACTIVATIONS;
	RefundEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(RefundEffect);

	
	return Template;
}


// Efficient Targeting - Passive: Holotargeting no longer ends the turn and lasts for one additional turn.
static function X2AbilityTemplate WOTC_APA_EfficientTargeting()
{

	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;
	local X2Effect_Persistent									NameEffect;


	Template = CreatePassiveAbility('WOTC_APA_EfficientTargeting', "img:///UILibrary_LWSecondariesWOTC.LW_AbilityRapidTargeting", 'Holotargeter_DoNotConsumeAllActionsEffect');


	// A Holotargeter must be equipped
	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories = class'X2Ability_HolotargeterAbilitySet'.default.VALID_WEAPON_CATEGORIES_FOR_SKILLS;
	WeaponCondition.bSkipAbilitySourceWeaponCheck = true;
	Template.AbilityShooterConditions.AddItem(WeaponCondition);


	// Create a persistent effect that tells the Holotargeter abilities/effects to last for one additional turn.
	NameEffect = new class 'X2Effect_Persistent';
	NameEffect.EffectName = 'Holotargeter_ExtendedDurationEffect';
	NameEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(NameEffect);

	
	return Template;
}


// Quick-Set Bipod - Passive: Grants the Temporary Brace ability and makes the normal Brace ability no longer end the turn.
static function X2AbilityTemplate WOTC_APA_QuicksetBipod()
{

	local X2AbilityTemplate										Template;


	Template = CreatePassiveAbility('WOTC_APA_QuicksetBipod', "img:///UILibrary_WOTC_APA_Class_Pack.perk_QuicksetBipod", 'WOTC_APA_QuickBrace');


	//Template.AdditionalAbilities.AddItem('WOTC_APA_TempBrace');
	Template.AdditionalAbilities.AddItem('WOTC_APA_MoveBrace');
	Template.AdditionalAbilities.AddItem('WOTC_APA_Snapshot');


	return Template;
}

// Temporary Brace - Active: Free Action. Activate to gain squadsight and access to sniping abilities. Canceled by movement
static function X2AbilityTemplate WOTC_APA_TempBrace()
{

	local X2AbilityTemplate										Template;
	local X2AbilityCooldown										Cooldown;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2Condition_WOTC_APA_Class_EffectRequirement			ApplyCondition;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;
	local X2Effect_WOTC_APA_Braced								StatEffect, SniperSquadsight, HolotargeterSquadsight;
	
	
	Template = CreateSelfActiveAbility('WOTC_APA_TempBrace', "img:///UILibrary_WOTC_APA_Class_Pack.perk_QuicksetBipod");

	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SERGEANT_PRIORITY + 1;
	Template.AbilityConfirmSound = "TacticalUI_Activate_Ability_Run_N_Gun";
	Template.ActivationSpeech = 'RunAndGun';
	Template.bSkipFireAction = true;


	// Set ability costs, cooldowns, and restrictions
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.QUICK_BRACE_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	ApplyCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	ApplyCondition.ExcludingEffectNames.AddItem('WOTC_APA_Brace_BracedEffect');
	ApplyCondition.ExcludingEffectNames.AddItem('WOTC_APA_Brace_TempBracedEffect');
	ApplyCondition.ExcludingErrorCode = 'AA_AlreadyBraced';
	ApplyCondition.bCheckSourceUnit = true;
	Template.AbilityShooterConditions.AddItem(ApplyCondition);


	// This effect is the trigger for other effects that require Bracing
	StatEffect = new class'X2Effect_WOTC_APA_Braced';
	StatEffect.EffectName = 'WOTC_APA_Brace_TempBracedEffect';
	StatEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	StatEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(StatEffect);


	// Apply secondary effect if a sniper rifle is equipped to allow Squadsight targeting
	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories.AddItem('sniper_rifle');
	WeaponCondition.bCheckSpecificSlot = true;
	WeaponCondition.SpecificSlot = eInvSlot_PrimaryWeapon;
	WeaponCondition.bSkipCanEverBeValidCheck = true;

	SniperSquadsight = new class'X2Effect_WOTC_APA_Braced';
	SniperSquadsight.EffectName = 'Squadsight';
	SniperSquadsight.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	SniperSquadsight.DuplicateResponse = eDupe_Ignore;
	SniperSquadsight.TargetConditions.AddItem(WeaponCondition);
	Template.AddTargetEffect(SniperSquadsight);


	// Create a persistent effect that tells the Holotargeter abilities/effects to work at Squadsight ranges (needed when Sniper Rifle is not equipped).
	HolotargeterSquadsight = new class 'X2Effect_WOTC_APA_Braced';
	HolotargeterSquadsight.EffectName = 'Holotargeter_AllowSquadsightEffect';
	HolotargeterSquadsight.BuildPersistentEffect(1, true, false, false);
	HolotargeterSquadsight.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(HolotargeterSquadsight);


	return Template;
}

// Brace Move - Passive: Evaluates at the end of each turn and triggers the Brace ability if only movement actions were taken.
static function X2AbilityTemplate WOTC_APA_MoveBrace()
{

	local X2AbilityTemplate										Template;
	local X2Effect_Persistent									TriggerEffect;


	Template = CreatePassiveAbility('WOTC_APA_MoveBrace', "img:///UILibrary_WOTC_APA_Class_Pack.perk_QuicksetBipod",, False);
	Template.bShowActivation = false;
	Template.bSkipFireAction = true;


	// Persistent effect that evaluates conditions to trigger the Brace ability
	TriggerEffect = new class'X2Effect_Persistent';
	TriggerEffect.BuildPersistentEffect(1, true, false, false, eGameRule_PlayerTurnEnd);
	TriggerEffect.EffectTickedFn = MoveBraceEffectTicked;
	TriggerEffect.EffectName = 'WOTC_APA_MoveBraceEvaluate';
	TriggerEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(TriggerEffect);

	
	return Template;
}

function bool MoveBraceEffectTicked(X2Effect_Persistent PersistentEffect, const out EffectAppliedData ApplyEffectParameters, XComGameState_Effect kNewEffectState, XComGameState NewGameState, bool FirstApplication)
{
	local XComGameState_Unit									SourceUnit;
	local UnitValue												NonMoveActionsThisTurn;
	local bool													bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	if (SourceUnit != none)
	{
		/*»»»*/`LOG("WOTC_APA_QuicksetBipod - Brace After Movement Tick for" @ SourceUnit.GetFullName(), bLog);

		if (SourceUnit.IsImpaired() || SourceUnit.IsPanicked())
		{
			/*»»»*/`LOG("WOTC_APA_QuicksetBipod - Brace After Movement Tick - Unit is Impaired or Panicked", bLog);
			return false;
		}

		SourceUnit.GetUnitValue('NonMoveActionsThisTurn', NonMoveActionsThisTurn);

		/*»»»*/`LOG("WOTC_APA_QuicksetBipod - Brace After Movement Tick - Non-Movement Actions this turn:" @ int(NonMoveActionsThisTurn.fValue), bLog);

		if (NonMoveActionsThisTurn.fValue == 0)
		{
			/*»»»*/`LOG("WOTC_APA_QuicksetBipod - Brace After Movement Tick - Triggering Brace", bLog);
			`XEVENTMGR.TriggerEvent(default.BraceTriggeredName, SourceUnit, SourceUnit, NewGameState);
			//NewGameState.GetContext().PostBuildVisualizationFn.AddItem(BasicTargetFlyover_BuildVisualization);
	}	}

	return false;	// do not end the effect
}


// Weapon Specialist - Passive: All attacks with your primary and secondary weapons deal +1 damage.
static function X2AbilityTemplate WOTC_APA_WeaponSpecialist()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_BonusDamage					DamageEffect;


	Template = CreatePassiveAbility('WOTC_APA_WeaponSpecialist', "img:///UILibrary_WOTC_APA_Class_Pack.perk_WeaponSpecialist", 'WOTC_APA_WeaponSpecialistIcon');


	// Create a persistent effect that adds bonus damage to primary weapon
	DamageEffect = new class'X2Effect_WOTC_APA_Class_BonusDamage';
	DamageEffect.BonusDmg = default.WEAPON_SPECIALIST_DAMAGE_BONUS;
	DamageEffect.bApplyToPrimary = true;
	DamageEffect.bApplyToSecondary = true;
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false,, Template.AbilitySourceName);
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(DamageEffect);

	
	return Template;
}


// Vital Point Targeting - Passive: Holotargeting grants bonus damage and critical hit chance against its target
static function X2AbilityTemplate WOTC_APA_VitalPointTargeting()
{

	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;
	local X2Effect_Persistent									NameEffect;


	Template = CreatePassiveAbility('WOTC_APA_VitalPointTargeting', "img:///UILibrary_LWSecondariesWOTC.LW_AbilityIndependentTracking", 'Holotargeter_BonusCritChanceEffect');


	// A Holotargeter must be equipped
	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories = class'X2Ability_HolotargeterAbilitySet'.default.VALID_WEAPON_CATEGORIES_FOR_SKILLS;
	WeaponCondition.bSkipAbilitySourceWeaponCheck = true;
	Template.AbilityShooterConditions.AddItem(WeaponCondition);


	// Create a persistent effect that tells the Holotargeter abilities/effects to last for one additional turn.
	NameEffect = new class 'X2Effect_Persistent';
	NameEffect.EffectName = 'Holotargeter_BonusDamageEffect';
	NameEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(NameEffect);

	
	return Template;
}


// Opportunist - Passive: Attacks with your primary or secondary weapon deal +2 damage to targets that are flanked or exposed. Has no effect on enemies that cannot take cover.
static function X2AbilityTemplate WOTC_APA_Opportunist()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Opportunist							DamageEffect;


	Template = CreatePassiveAbility('WOTC_APA_Opportunist', "img:///UILibrary_PerkIcons.UIPerk_hunter", 'WOTC_APA_OpportunistIcon');
	//Template = CreatePassiveAbility('WOTC_APA_Opportunist', "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_improvisedsilencer", 'WOTC_APA_OpportunistIcon');


	// Create a persistent effect that adds bonus damage to shots against flanked targets
	DamageEffect = new class'X2Effect_WOTC_APA_Opportunist';
	DamageEffect.BonusDamage = default.OPPORTUNIST_DAMAGE_BONUS;
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false,, Template.AbilitySourceName);
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(DamageEffect);

	
	return Template;
}


// Precision Shot - Passive: Grants appropriate Shot active abilities and applies Damage modifiers
static function X2AbilityTemplate WOTC_APA_PrecisionShot()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_BonusDamage					DamageEffect;
	local X2Effect_WOTC_APA_Class_ConditionalHitModifier		HitModifierEffect;
	local array<name>											AbilityArrayNames;

	Template = CreatePassiveAbility('WOTC_APA_PrecisionShot', "img:///UILibrary_WOTC_APA_Class_Pack.perk_PrecisionShot",,false);


	// Create a persistent effect that increases damage
	DamageEffect = new class'X2Effect_WOTC_APA_Class_BonusDamage';
	DamageEffect.fBonusDmgMultiplier = default.PRECISION_SHOT_MULTIPLIER;
	DamageEffect.fBonusCritDmgMultiplier = default.PRECISION_SHOT_MULTIPLIER;
	DamageEffect.ValidAbilities.AddItem('WOTC_APA_PrecisionSpecialShot');
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false,, Template.AbilitySourceName);
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(DamageEffect);


	// Setup effect reducing the chance to graze targets
	AbilityArrayNames.AddItem('WOTC_APA_PrecisionSpecialShot');
	HitModifierEffect = new class'X2Effect_WOTC_APA_Class_ConditionalHitModifier';
	HitModifierEffect.AddEffectHitModifier(eHit_Graze, -999, Template.LocFriendlyName,,,,,,AbilityArrayNames);
	HitModifierEffect.AddEffectHitModifier(eHit_Crit, 100 * (default.PRECISION_SHOT_MULTIPLIER - 1), Template.LocFriendlyName,,,,,,AbilityArrayNames);
	HitModifierEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(HitModifierEffect);


	Template.AdditionalAbilities.AddItem('WOTC_APA_PrecisionSpecialShot');


	return Template;
}

// Precision Shot - Active:
static function X2AbilityTemplate WOTC_APA_PrecisionSpecialShot()
{

	local X2AbilityTemplate										Template;
	local X2AbilityCooldown										Cooldown;
	local X2AbilityCost_Ammo									AmmoCost;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2AbilityToHitCalc_StandardAim						StandardAim;
	local X2Condition_WOTC_APA_Class_EffectRequirement			ApplyCondition;


	Template = class'X2Ability_WeaponCommon'.static.Add_StandardShot('WOTC_APA_PrecisionSpecialShot', false, false, false);
	
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_PrecisionShot";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_CAPTAIN_PRIORITY;
	Template.DefaultSourceItemSlot = eInvSlot_PrimaryWeapon;
	Template.bAllowFreeFireWeaponUpgrade = false;


	Template.AbilityCosts.Length=0;

	// Set ability costs, cooldowns, and restrictions
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.PRECISION_SHOT_COOLDOWN;
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
	StandardAim.FinalMultiplier = 1 - default.PRECISION_SHOT_AIM_MULTIPLIER;
	Template.AbilityToHitCalc = StandardAim;


	// Add Stun effect
	Template.AddTargetEffect(class'X2StatusEffects'.static.CreateStunnedStatusEffect(default.PRECISION_SHOT_STUN_DURATION, 100, false));


	// Require that the shooter be Braced or Temp Braced
	ApplyCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	ApplyCondition.RequiredEffectNames.AddItem('WOTC_APA_Brace_BracedEffect');
	ApplyCondition.RequiredEffectNames.AddItem('WOTC_APA_Brace_TempBracedEffect');
	ApplyCondition.bRequireAll = false;
	ApplyCondition.RequiredErrorCode = 'AA_RequiresBraced';
	ApplyCondition.bCheckSourceUnit = true;
	Template.AbilityShooterConditions.AddItem(ApplyCondition);


	return Template;
}


// Ready For Anything - Passive: After taking a standard, turn-ending shot, enter overwatch if you have ammo remaining
static function X2AbilityTemplate WOTC_APA_ReadyForAnything()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_ReadyForAnything					OverwatchEffect;


	Template = CreatePassiveAbility('WOTC_APA_ReadyForAnything', "img:///UILibrary_WOTC_APA_Class_Pack.perk_ReadyForAnything");


	OverwatchEffect = new class 'X2Effect_WOTC_APA_ReadyForAnything';
	OverwatchEffect.EffectName = 'WOTC_APA_ReadyForAnythingEffect';
	OverwatchEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(OverwatchEffect);


	Template.AdditionalAbilities.AddItem('WOTC_APA_ReadyForAnythingFlyover');

	
	return Template;
}

// Ready For Anything Flyover - Passive: Plays a Flyover on the unit when Ready For Anything triggers
static function X2DataTemplate WOTC_APA_ReadyForAnythingFlyover()
{

	local X2AbilityTemplate					Template;
	local X2AbilityTrigger_EventListener	EventListener;

	`CREATE_X2ABILITY_TEMPLATE (Template, 'WOTC_APA_ReadyForAnythingFlyover');

	Template.Hostility = eHostility_Neutral;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bShowPostActivation = true;
	Template.bSkipFireAction = true;
	Template.bDontDisplayInAbilitySummary = true;

	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.EventID = 'WOTC_APA_ReadyForAnythingTriggered';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	Template.AbilityTriggers.AddItem(EventListener);

	Template.CinescriptCameraType = "Overwatch";

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}


// Ghost - Passive: 
static function X2AbilityTemplate WOTC_APA_Ghost()
{

	local X2AbilityTemplate										Template;
	local X2Effect_PersistentStatChange							MobilityEffect;
	local X2Effect_WOTC_APA_GhostMelee							MeleeDetectionEffect;


	Template = CreatePassiveAbility('WOTC_APA_Ghost', "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_executioner",, false);

	
	// Create a persistent stat change effect that adds [default: 2] mobility
	MobilityEffect = new class 'X2Effect_PersistentStatChange';
	MobilityEffect.EffectName = 'WOTC_APA_GhostEffect';
	MobilityEffect.BuildPersistentEffect(1, true, false, false);
	MobilityEffect.AddPersistentStatChange(eStat_Mobility, default.GHOST_MOBILITY_BONUS);
	MobilityEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(MobilityEffect);

	// Add UI stat markups corresponding to effect stat boosts
	Template.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, default.GHOST_MOBILITY_BONUS);


	// Setup passive effect that listens for moving melee abilities to trigger 
	MeleeDetectionEffect = new class'X2Effect_WOTC_APA_GhostMelee';
	MeleeDetectionEffect.EffectName = 'WOTC_APA_GhostMeleeDetectionEffect';
	MeleeDetectionEffect.BuildPersistentEffect(1, true, false, false);
	MeleeDetectionEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(MeleeDetectionEffect);

	Template.AdditionalAbilities.AddItem('WOTC_APA_GhostMeleeModifier');


	return Template;
}

static function X2AbilityTemplate WOTC_APA_GhostMeleeModifier()
{

	local X2AbilityTemplate										Template;
	local X2AbilityTrigger_EventListener						EventListener;
	local X2Effect_PersistentStatChange							StatEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_GhostMeleeModifier');
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.bCrossClassEligible = false;


	// This ability triggers after X2Effect_WOTC_APA_GhostMelee detects a moving melee ability activated
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = class'X2Effect_WOTC_APA_GhostMelee'.default.WOTC_APA_GhostMeleeDetectionModifier_TriggeredName;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.VoidRiftInsanityListener;
	Template.AbilityTriggers.AddItem(EventListener);


	// Setup effect decreasing enemy's detection radius against you
	StatEffect = new class'X2Effect_PersistentStatChange';
	StatEffect.EffectName = 'WOTC_APA_GhostMeleeModifierEffect';
	StatEffect.AddPersistentStatChange(eStat_DetectionRadius, 0.0, MODOP_Multiplication);
	StatEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	StatEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(StatEffect);
	

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;;
	return Template;
}


// Apex Predator - Passive: Grants +1 Critical Hit Damage and chance to panic or disorient targets on critical hits
static function X2AbilityTemplate WOTC_APA_ApexPredator()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_BonusDamage					DamageEffect;
	local X2Effect_WOTC_APA_ApexPredator						PanicTrigger;


	Template = CreatePassiveAbility('WOTC_APA_ApexPredator', "img:///UILibrary_WOTC_APA_Class_Pack.perk_ApexPredator");


	// Create a persistent effect that increases Crit damage
	DamageEffect = new class'X2Effect_WOTC_APA_Class_BonusDamage';
	DamageEffect.BonusCritDmg = default.APEX_PREDATOR_CRIT_DAMAGE_BONUS;
	DamageEffect.bApplyToPrimary = true;
	DamageEffect.bApplyToSecondary = true;
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, false,, Template.AbilitySourceName);
	Template.AddTargetEffect(DamageEffect);


	// Create a persistent effect that triggers status effects on Crit
	PanicTrigger = new class'X2Effect_WOTC_APA_ApexPredator';
	PanicTrigger.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(PanicTrigger);

	Template.AdditionalAbilities.AddItem('WOTC_APA_ApexPredatorPanic');


	return Template;
}

// Apex Predator Panic - Passive: Applies Panic to enemies on critical hits
static function X2AbilityTemplate WOTC_APA_ApexPredatorPanic()
{

	local X2AbilityTemplate										Template;	
	local X2AbilityTrigger_EventListener						EventListener;
	local X2AbilityMultiTarget_Radius							RadiusMultiTarget;
	local X2Condition_UnitProperty								UnitPropertyCondition;
	local X2Effect_Persistent									DisorientedEffect;
	local X2Effect_Persistent									PanickedEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_ApexPredatorPanic');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_ApexPredator";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.bCrossClassEligible = false;


	// This ability triggers after a Critical Hit
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = class'X2Effect_WOTC_APA_ApexPredator'.default.WOTC_APA_ApexPredator_TriggeredName;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.VoidRiftInsanityListener;
	Template.AbilityTriggers.AddItem(EventListener);


	// Setup Multitarget attributes
	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	//RadiusMultiTarget.bAddPrimaryTargetAsMultiTarget = true;
	RadiusMultiTarget.bIgnoreBlockingCover = true;
	RadiusMultiTarget.bAllowDeadMultiTargetUnits = false;
	RadiusMultiTarget.bExcludeSelfAsTargetIfWithinRadius = false;
	RadiusMultiTarget.bUseWeaponRadius = false;
	RadiusMultiTarget.fTargetRadius = 1.5 * (default.APEX_PREDATOR_PANIC_RADIUS + 0.1);
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;


	// Don't apply to allies
	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = true;
	UnitPropertyCondition.ExcludeHostileToSource = false;
	UnitPropertyCondition.ExcludeCivilian = true;
	UnitPropertyCondition.FailOnNonUnits = true;
	Template.AbilityMultiTargetConditions.AddItem(UnitPropertyCondition);

	// Create the Disoriented effect on the targets
	DisorientedEffect = class'X2StatusEffects'.static.CreateDisorientedStatusEffect(true, , false);
	DisorientedEffect.ApplyChanceFn = ApplyChance_ApexPredatorDisorient;
	Template.AddMultiTargetEffect(DisorientedEffect);
	Template.AddTargetEffect(DisorientedEffect);


	// Create the Panic effect on the targets
	PanickedEffect = class'X2StatusEffects'.static.CreatePanickedStatusEffect();
	PanickedEffect.ApplyChanceFn = ApplyChance_ApexPredatorPanic;
	Template.AddMultiTargetEffect(PanickedEffect);
	Template.AddTargetEffect(PanickedEffect);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}

// Apex Predator Disorient Chance Fn
static function name ApplyChance_ApexPredatorDisorient(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState)
{
	local int					RandRoll;
	local float					ApplyChance;
	local XComGameState_Unit	SourceUnit;
	local X2WeaponTemplate		WeaponTemplate;

	SourceUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	if (SourceUnit == none)
	{
		SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	}

	if (XComGameState_Unit(kNewTargetState).IsDead())
		return 'AA_UnitIsDead';

	if (XComGameState_Unit(kNewTargetState).IsStunned())
		return 'AA_UnitIsStunned';

	if (XComGameState_Unit(kNewTargetState).bInStasis)
		return 'AA_UnitIsInStasis';

	if (XComGameState_Unit(kNewTargetState).IsIncapacitated())
		return 'AA_UnitIsUnconscious';

	ApplyChance = default.APEX_PREDATOR_DISORIENT_CHANCE;

	WeaponTemplate = X2WeaponTemplate(SourceUnit.GetItemInSlot(eInvSlot_PrimaryWeapon).GetMyTemplate());
	if (WeaponTemplate.WeaponCat == 'sniper_rifle')
	{
		ApplyChance += default.APEX_PREDATOR_WEAPON_MODIFIER;
	}

	RandRoll = `SYNC_RAND_STATIC(100);
	if (RandRoll <= ApplyChance)
	{
		return 'AA_Success';
	}

	return 'AA_EffectChanceFailed';
}

// Apex Predator Panic Chance Fn
static function name ApplyChance_ApexPredatorPanic(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState)
{
	local int					RandRoll;
	local float					ApplyChance;
	local XComGameState_Unit	SourceUnit;
	local X2WeaponTemplate		WeaponTemplate;

	SourceUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	if (SourceUnit == none)
	{
		SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	}

	if (XComGameState_Unit(kNewTargetState).IsDead())
		return 'AA_UnitIsDead';

	if (XComGameState_Unit(kNewTargetState).IsStunned())
		return 'AA_UnitIsStunned';

	if (XComGameState_Unit(kNewTargetState).bInStasis)
		return 'AA_UnitIsInStasis';

	if (XComGameState_Unit(kNewTargetState).IsIncapacitated())
		return 'AA_UnitIsUnconscious';

	ApplyChance = default.APEX_PREDATOR_PANIC_CHANCE;

	WeaponTemplate = X2WeaponTemplate(SourceUnit.GetItemInSlot(eInvSlot_PrimaryWeapon).GetMyTemplate());
	if (WeaponTemplate.WeaponCat == 'vektor_rifle')
	{
		ApplyChance += default.APEX_PREDATOR_WEAPON_MODIFIER;
	}

	RandRoll = `SYNC_RAND_STATIC(100);
	if (RandRoll <= ApplyChance)
	{
		return 'AA_Success';
	}

	return 'AA_EffectChanceFailed';
}


// Sentry - Passive: 
static function X2AbilityTemplate WOTC_APA_Sentry()
{

	local X2AbilityTemplate										Template;
	//local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;
	//local X2Effect_WOTC_APA_Class_AddAbilitiesToTarget			AbilityEffect;


	Template = CreatePassiveAbility('WOTC_APA_Sentry', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Sentry",,false);


	//// Create effect to add Sentinel when equipped with a Vektor Rifle
	//WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	//WeaponCondition.AllowedWeaponCategories.AddItem('vektor_rifle');
	//WeaponCondition.bCheckSpecificSlot = true;
	//WeaponCondition.SpecificSlot = eInvSlot_PrimaryWeapon;
//
	//AbilityEffect = new class'X2Effect_WOTC_APA_Class_AddAbilitiesToTarget';
	//AbilityEffect.AddAbilities.AddItem('WOTC_APA_Sentinel');
	//AbilityEffect.ApplyToWeaponSlot = eInvSlot_PrimaryWeapon;
	//AbilityEffect.TargetConditions.AddItem(WeaponCondition);
	//Template.AddTargetEffect(AbilityEffect);


	Template.AdditionalAbilities.AddItem('CoolUnderPressure');
	Template.AdditionalAbilities.AddItem('CoveringFire');


	return Template;
}


// Harrier's Talon - Passive: 
static function X2AbilityTemplate WOTC_APA_HarriersTalon()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_BonusDamage					PierceEffect;


	Template = CreatePassiveAbility('WOTC_APA_HarriersTalon', "img:///UILibrary_WOTC_APA_Class_Pack.perk_HarriersTalon");


	// Create a persistent effect that adds armor piercing to shots while concealed
	PierceEffect = new class'X2Effect_WOTC_APA_Class_BonusDamage';
	PierceEffect.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_HarriersTalon";
	PierceEffect.ArmorPierce = default.HARRIERS_TALON_ARMOR_PIERCE;
	PierceEffect.bApplyToPrimary = true;
	PierceEffect.bApplyToSecondary = true;
	PierceEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false,, Template.AbilitySourceName);
	PierceEffect.BuildPersistentEffect(1, true, false, false);
	PierceEffect.TargetConditions.AddItem(new class'X2Condition_Stealth');
	Template.AddTargetEffect(PierceEffect);


	return Template;
}


// Concealing Smoke - Active: 
static function X2AbilityTemplate WOTC_APA_ConcealingSmoke()
{
	
	local X2AbilityTemplate						Template;
	local X2Effect_WOTC_APA_Class_BonusItems	ItemEffect;


	Template = CreatePassiveAbility('WOTC_APA_ConcealingSmoke', "img:///UILibrary_WOTC_APA_Class_Pack.perk_ConcealingSmoke",,false);


	ItemEffect = new class'X2Effect_WOTC_APA_Class_BonusItems';
	ItemEffect.BonusItems.AddItem('WOTC_APA_ConcealingSmokeGrenade');
	ItemEffect.FreeCharges = default.CONCEALING_SMOKE_CHARGES;
	ItemEffect.BuildPersistentEffect (1, true, false, false);
	Template.AddTargetEffect(ItemEffect);


	return Template;
}


// Recon - Passive: Gain a bonus to detection radius and vision range while concealed
static function X2AbilityTemplate WOTC_APA_Recon()
{

	local X2AbilityTemplate										Template;
	local X2Effect_PersistentStatChange							StatEffect;
	local XMBEffect_ConditionalStatChange						VisionEffect;
	local X2Condition_WOTC_APA_Class_EffectRequirement			ApplyCondition;
	

	Template = CreatePassiveAbility('WOTC_APA_Recon', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Recon");


	// Setup effect decreasing enemy's detection radius against you
	StatEffect = new class'X2Effect_PersistentStatChange';
	StatEffect.EffectName = 'WOTC_APA_ReconDetectionEffect';
	StatEffect.AddPersistentStatChange(eStat_DetectionModifier, 1 - default.RECON_DETECTION_MODIFIER);
	StatEffect.BuildPersistentEffect(1, true, false, false);
	StatEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(StatEffect);


	// Setup effect increasing Vision range when not Braced
	ApplyCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	ApplyCondition.ExcludingEffectNames.AddItem('WOTC_APA_Brace_BracedEffect');
	ApplyCondition.ExcludingErrorCode = 'AA_AlreadyBraced';
	ApplyCondition.bCheckSourceUnit = true;

	VisionEffect = new class'XMBEffect_ConditionalStatChange';
	VisionEffect.EffectName = 'WOTC_APA_ReconVisionEffect';
	VisionEffect.AddPersistentStatChange(eStat_SightRadius, default.RECON_VISION_RANGE_MODIFIER);
	VisionEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage,,,Template.AbilitySourceName);
	VisionEffect.BuildPersistentEffect(1, true, false, false);
	VisionEffect.Conditions.AddItem(ApplyCondition);
	VisionEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(VisionEffect);

	
	return Template;
}


// Bandolier - Passive: Gain a dedicated ammo inventory slot
static function X2AbilityTemplate WOTC_APA_Bandolier()
{

	local X2AbilityTemplate										Template;


	Template = CreatePassiveAbility('WOTC_APA_Bandolier', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Bandolier");


	return Template;
}


// High Caliber - Passive: 
static function X2AbilityTemplate WOTC_APA_HighCaliber()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_BonusDamage					DamageEffect;
	local X2Effect_WOTC_APA_Class_OverrideClipSize				AmmoEffect;


	Template = CreatePassiveAbility('WOTC_APA_HighCaliber', "img:///UILibrary_WOTC_APA_Class_Pack.perk_HighCaliber");


	// Create a persistent effect that adds bonus damage and armor piercing to shots from primary weapon
	DamageEffect = new class'X2Effect_WOTC_APA_Class_BonusDamage';
	DamageEffect.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_HighCaliber";
	DamageEffect.BonusDmg = default.HIGH_CALIBER_DAMAGE_BONUS;
	DamageEffect.ArmorPierce = default.HIGH_CALIBER_ARMOR_PIERCE;
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false,, Template.AbilitySourceName);
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.TargetConditions.AddItem(new class'X2Condition_WOTC_APA_HighCaliberAmmoCondition');
	Template.AddTargetEffect(DamageEffect);


	// Create a persistent effect that modifies the weapon's total ammo
	AmmoEffect = new class'X2Effect_WOTC_APA_Class_OverrideClipSize';
	AmmoEffect.iClipSizeModifier = default.HIGH_CALIBER_AMMO_MODIFIER;
	AmmoEffect.iMinWeaponAmmo = -default.HIGH_CALIBER_AMMO_MODIFIER + 1;
	AmmoEffect.BuildPersistentEffect(1, true, false, false);
	AmmoEffect.EffectName = 'WOTC_APA_HighCaliberAmmoEffect';
	Template.AddTargetEffect(AmmoEffect);


	return Template;
}


// Eagle-Eye - Passive: 
static function X2AbilityTemplate WOTC_APA_EagleEye()
{

	local X2AbilityTemplate										Template;


	Template = CreatePassiveAbility('WOTC_APA_EagleEye', "img:///UILibrary_WOTC_APA_Class_Pack.perk_PrepForEntry");


	Template.AdditionalAbilities.AddItem('WOTC_APA_EagleEyeTrigger');
	Template.AdditionalAbilities.AddItem('WOTC_APA_EagleEyeShot');


	return Template;
}

// Eagle-Eye Trigger - Passive:
static function X2AbilityTemplate WOTC_APA_EagleEyeTrigger()
{

	local X2AbilityTemplate										Template;	
	local X2AbilityTarget_Single								SingleTarget;
	local X2AbilityToHitCalc_EagleEye							TargetChance;
	local X2AbilityTrigger_Event								Trigger;
	local X2Condition_UnitProperty								TargetCondition;
	local X2Condition_Visibility								TargetVisibilityCondition;
	local X2Condition_WOTC_APA_Class_Concealment				ConcealedCondition;
	local X2Condition_UnitEffectsWithAbilitySource				EffectCondition;
	local X2Effect_Persistent									TargetEffect;


	`CREATE_X2ABILITY_TEMPLATE (Template, 'WOTC_APA_EagleEyeTrigger');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_PrepForEntry";
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.Hostility = eHostility_Neutral;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.DisplayTargetHitChance = false;
	Template.bShowActivation = true;
	Template.bCrossClassEligible = false;
	Template.bUniqueSource = true;
	

	// Setup trigger targeting
	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.OnlyIncludeTargetsInsideWeaponRange = true;
	Template.AbilityTargetStyle = SingleTarget;

	TargetChance = new class'X2AbilityToHitCalc_EagleEye';
	Template.AbilityToHitCalc = TargetChance;


	// Trigger on movement - interrupt the move
	Trigger = new class'X2AbilityTrigger_Event';
	Trigger.EventObserverClass = class'X2TacticalGameRuleset_MovementObserver';
	Trigger.MethodName = 'InterruptGameState';
	Template.AbilityTriggers.AddItem(Trigger);

	Template.PostActivationEvents.AddItem('WOTC_APA_EagleEyeTriggered');


	// Setup trigger conditions
	TargetCondition = new class'X2Condition_UnitProperty';
	TargetCondition.ExcludeAlive=false;
	TargetCondition.ExcludeDead=true;
	TargetCondition.ExcludeFriendlyToSource=true;
	TargetCondition.ExcludeHostileToSource=false;
	TargetCondition.TreatMindControlledSquadmateAsHostile=false;
	TargetCondition.FailOnNonUnits=true;
	TargetCondition.IsScampering=true;
	Template.AbilityTargetConditions.AddItem(TargetCondition);
	
	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	TargetVisibilityCondition.bRequireBasicVisibility = true;
	TargetVisibilityCondition.bDisablePeeksOnMovement = true; //Don't use peek tiles for over watch shots	
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);

	Template.AbilityTargetConditions.AddItem(new class'X2Condition_EverVigilant');
	Template.AbilityTargetConditions.AddItem(class'X2Ability_DefaultAbilitySet'.static.OverwatchTargetEffectsCondition());

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	ConcealedCondition = new class'X2Condition_WOTC_APA_Class_Concealment';
	ConcealedCondition.bExpectConcealment = false;
	Template.AbilityShooterConditions.AddItem(ConcealedCondition);

	//  Do not shoot targets that were already hit by this unit this turn with this ability
	EffectCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	EffectCondition.AddExcludeEffect('WOTC_APA_EagleEyeTarget', 'AA_UnitIsImmune');
	Template.AbilityTargetConditions.AddItem(EffectCondition);


	// Mark the target as rolled against already so it cannot be targeted again
	TargetEffect = new class'X2Effect_Persistent';
	TargetEffect.EffectName = 'WOTC_APA_EagleEyeTarget';
	TargetEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);

	// Mark them regardless of taking the shot or not (otherwise each tile would trigger a chance to hit)
	TargetEffect.SetupEffectOnShotContextResult(true, true);      
	Template.AddTargetEffect(TargetEffect);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;	
}

// Eagle-Eye Shot - Passive:
static function X2AbilityTemplate WOTC_APA_EagleEyeShot()
{

	local X2AbilityTemplate                 Template;
	local X2AbilityTrigger_EventListener    EventTrigger;
	local X2AbilityTarget_Single            SingleTarget;
	local X2AbilityToHitCalc_StandardAim    StandardAim;
	local X2AbilityCost_Ammo                AmmoCost;
	local X2Effect_Knockback				KnockbackEffect;


	`CREATE_X2ABILITY_TEMPLATE (Template, 'WOTC_APA_EagleEyeShot');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_PrepForEntry";
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.bDontDisplayInAbilitySummary = true;
	Template.DisplayTargetHitChance = false;


	// Setup shot's event trigger and target
	EventTrigger = new class'X2AbilityTrigger_EventListener';
	EventTrigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventTrigger.ListenerData.EventID = 'WOTC_APA_EagleEyeTriggered';
	EventTrigger.ListenerData.EventFn = class'XComGameState_Ability'.static.ChainShotListener; //  activates against the event's context's primary target if the roll succeeded
	EventTrigger.ListenerData.Filter = eFilter_Unit;
	Template.AbilityTriggers.AddItem(EventTrigger);

	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.OnlyIncludeTargetsInsideWeaponRange = true;
	Template.AbilityTargetStyle = SingleTarget;

	StandardAim = new class'X2AbilityToHitCalc_StandardAim';
	StandardAim.bReactionFire = true;
	Template.AbilityToHitCalc = StandardAim;
	Template.AbilityToHitOwnerOnMissCalc = StandardAim;


	// Setup shot's requirements
	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;	
	Template.AbilityCosts.AddItem(AmmoCost);

	Template.bAllowFreeFireWeaponUpgrade = false;	
	Template.bAllowAmmoEffects = true;
	
	Template.AbilityTargetConditions.AddItem(default.LivingHostileUnitDisallowMindControlProperty);
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);	
	
	
	// Setup shot effects
	Template.AssociatedPassives.AddItem('HoloTargeting');

	// Put holo target effect first because if the target dies from this shot, it will be too late to notify the effect.
	Template.AddTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.HoloTargetEffect());
	Template.AddTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect());
	Template.bAllowBonusWeaponEffects = true;
	
	Template.AddTargetEffect(default.WeaponUpgradeMissDamage);

	KnockbackEffect = new class'X2Effect_Knockback';
	KnockbackEffect.KnockbackDistance = 2;
	Template.AddTargetEffect(KnockbackEffect);
	

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = OverwatchShot_BuildVisualization;
	return Template;	
}


// Muffled Shot - Passive: Grants appropriate Muffled Shot active abilities depending on abilities/weapons present.
static function X2AbilityTemplate WOTC_APA_MuffledShot()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_BonusDamage					DamageEffect;


	Template = CreatePassiveAbility('WOTC_APA_MuffledShot', "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_Needle");


	// Create a persistent effect that reduces damage
	DamageEffect = new class'X2Effect_WOTC_APA_Class_BonusDamage';
	DamageEffect.fBonusDmgMultiplier = default.MUFFLED_SHOT_DAMAGE_MULTIPLIER;
	DamageEffect.fBonusCritDmgMultiplier = default.MUFFLED_SHOT_CRIT_DAMAGE_MULTIPLIER;
	DamageEffect.bCritReplacesBonus = true;
	DamageEffect.ValidAbilities.AddItem('WOTC_APA_MuffledStandardShot');
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false,, Template.AbilitySourceName);
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(DamageEffect);


	Template.AdditionalAbilities.AddItem('WOTC_APA_MuffledStandardShot');


	return Template;
}

// Muffled Shot - Active:
static function X2AbilityTemplate WOTC_APA_MuffledStandardShot()
{

	local X2AbilityTemplate										Template;
	local X2AbilityCooldown										Cooldown;
	local X2AbilityCost_Ammo									AmmoCost;
	local X2AbilityCost_ActionPoints							ActionPointCost;


	Template = class'X2Ability_WeaponCommon'.static.Add_StandardShot('WOTC_APA_MuffledStandardShot', false, false, false);
	
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_sting";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_CORPORAL_PRIORITY;
	Template.DefaultSourceItemSlot = eInvSlot_PrimaryWeapon;
	Template.bAllowFreeFireWeaponUpgrade = false;
	Template.ConcealmentRule = eConceal_Always;


	// Hide ability when concealment has been broken
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
	Template.HideErrors.AddItem('AA_UnitAlreadySpotted');
	Template.HideErrors.AddItem('AA_FailedActionPointCheck');

	Template.AbilityShooterConditions.AddItem(new class'X2Condition_WOTC_APA_Class_Concealment');


	// Break squad concealment on shot
	Template.AddTargetEffect(new class'X2Effect_WOTC_APA_Class_BreakSquadConcealment');


	Template.AbilityCosts.Length=0;

	// Set ability costs, cooldowns, and restrictions
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.MUFFLED_SHOT_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);
	Template.bAllowAmmoEffects = true;

	ActionPointCost = new class 'X2AbilityCost_ActionPoints';
	ActionPointCost.bAddWeaponTypicalCost = true;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);


	return Template;
}


// Sixth Sense - Passive: 
static function X2AbilityTemplate WOTC_APA_SixthSense()
{

	local X2AbilityTemplate										Template;
	local X2Effect_PersistentStatChange							StatEffect;


	Template = CreatePassiveAbility('WOTC_APA_SixthSense', "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_MountainMist");


	// Create a persistent stat change effect that adds [default: 10] dodge
	StatEffect = new class 'X2Effect_PersistentStatChange';
	StatEffect.EffectName = 'WOTC_APA_SixthSenseDodgeEffect';
	StatEffect.BuildPersistentEffect(1, true, false, false);
	StatEffect.AddPersistentStatChange(eStat_Dodge, default.SIXTH_SENSE_DODGE_BONUS);
	Template.AddTargetEffect(StatEffect);


	Template.AdditionalAbilities.AddItem('WOTC_APA_SixthSenseTrigger');
	Template.AdditionalAbilities.AddItem('WOTC_APA_SixthSenseSpawnTrigger');


	return Template;
}

static function X2AbilityTemplate WOTC_APA_SixthSenseTrigger()
{
	local X2AbilityTemplate             Template;
	local X2AbilityMultiTarget_Radius   RadiusMultiTarget;
	local X2Effect_WOTC_APA_RevealUnit     TrackingEffect;
	local X2Condition_UnitProperty      TargetProperty;
	local X2Condition_UnitEffects		EffectsCondition;
	local X2AbilityTrigger_EventListener	EventListener;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_SixthSenseTrigger');

	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_MountainMist";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	EffectsCondition = new class'X2Condition_UnitEffects';
	EffectsCondition.AddExcludeEffect(class'X2Effect_MindControl'.default.EffectName, 'AA_UnitIsNotPlayerControlled');
	Template.AbilityShooterConditions.AddItem(EffectsCondition);

	Template.AbilityTargetStyle = default.SelfTarget;

	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.fTargetRadius = default.SIXTH_SENSE_TILE_RADIUS;
	RadiusMultiTarget.bIgnoreBlockingCover = true;
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;

	TargetProperty = new class'X2Condition_UnitProperty';
	TargetProperty.ExcludeDead = true;
	TargetProperty.FailOnNonUnits = true;
	TargetProperty.ExcludeFriendlyToSource = false;
	Template.AbilityMultiTargetConditions.AddItem(TargetProperty);

	EffectsCondition = new class'X2Condition_UnitEffects';
	EffectsCondition.AddExcludeEffect(class'X2Effect_Burrowed'.default.EffectName, 'AA_UnitIsBurrowed');
	Template.AbilityMultiTargetConditions.AddItem(EffectsCondition);

	TrackingEffect = new class'X2Effect_WOTC_APA_RevealUnit';
	TrackingEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnEnd);
	Template.AddMultiTargetEffect(TrackingEffect);

	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = 'UnitMoveFinished';
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	EventListener.ListenerData.Filter = eFilter_Unit;
	Template.AbilityTriggers.AddItem(EventListener);

	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = 'PlayerTurnBegun';
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	EventListener.ListenerData.Filter = eFilter_Player;
	Template.AbilityTriggers.AddItem(EventListener);

	Template.bSkipFireAction = true;
	Template.bSkipPerkActivationActions = true;

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}

// This triggers whenever a unit is spawned within tracking radius. The most likely
// reason for this to happen is a Faceless transforming due to tracking being applied.
// The newly spawned Faceless unit won't have the tracking effect when this happens,
// so we apply it here.
static function X2AbilityTemplate WOTC_APA_SixthSenseSpawnTrigger()
{
	local X2AbilityTemplate             Template;
	local X2Effect_WOTC_APA_RevealUnit     TrackingEffect;
	local X2Condition_UnitProperty      TargetProperty;
	local X2AbilityTrigger_EventListener	EventListener;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_SixthSenseSpawnTrigger');

	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_MountainMist";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	Template.AbilityTargetStyle = default.SimpleSingleTarget;

	TargetProperty = new class'X2Condition_UnitProperty';
	TargetProperty.ExcludeDead = true;
	TargetProperty.FailOnNonUnits = true;
	TargetProperty.ExcludeFriendlyToSource = false;
	TargetProperty.RequireWithinRange = true;
	TargetProperty.WithinRange = default.SIXTH_SENSE_TILE_RADIUS * class'XComWorldData'.const.WORLD_METERS_TO_UNITS_MULTIPLIER;
	Template.AbilityTargetConditions.AddItem(TargetProperty);

	TrackingEffect = new class'X2Effect_WOTC_APA_RevealUnit';
	TrackingEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnEnd);
	Template.AddTargetEffect(TrackingEffect);

	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = 'UnitSpawned';
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.VoidRiftInsanityListener;
	EventListener.ListenerData.Filter = eFilter_None;
	Template.AbilityTriggers.AddItem(EventListener);

	Template.bSkipFireAction = true;
	Template.bSkipPerkActivationActions = true;

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}


// Steady Hands - Passive: Gain [default: +15] Crit Chance and [default: +1] Crit Damage if you did not move last turn. Bonus is lost on movement.
static function X2AbilityTemplate WOTC_APA_SteadyHands()
{

	local X2AbilityTemplate					Template;
	local X2Effect_Persistent				PersistentEffect;
	local X2Effect_WOTC_APA_SteadyHands		ToHitModEffect;
	local X2Condition_UnitValue				ValueCondition;
	local X2Condition_PlayerTurns			TurnsCondition;


	Template = CreatePassiveAbility('WOTC_APA_SteadyHands', "img:///UILibrary_WOTC_APA_Class_Pack.perk_SteadyHands",, false /*Helper passive Icon uses LocHelpText... we want LocLongDescription in this case*/);


	// This effect stays on the unit indefinitely
	PersistentEffect = new class'X2Effect_Persistent';
	PersistentEffect.EffectName = 'WOTC_APA_SteadyHandsEffect';
	PersistentEffect.BuildPersistentEffect(1, true, false, false, eGameRule_PlayerTurnBegin);
	PersistentEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage,,, Template.AbilitySourceName);

	// At the start of each turn, this effect is applied if conditions are met. Moving will remove the effect.
	ToHitModEffect = new class'X2Effect_WOTC_APA_SteadyHands';
	ToHitModEffect.EffectName = 'WOTC_APA_SteadyHandsBoost';
	ToHitModEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnBegin);
	ToHitModEffect.AddEffectHitModifier(eHit_Crit, default.STEADY_HANDS_CRIT_CHANCE_BONUS, Template.LocFriendlyName);
	ToHitModEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true);
	
	// This condition check that the unit did not move last turn before allowing the bonus to be applied
	ValueCondition = new class'X2Condition_UnitValue';
	ValueCondition.AddCheckValue('MovesThisTurn', 1, eCheck_LessThan);
	ToHitModEffect.TargetConditions.AddItem(ValueCondition);

	// This condition guarantees the player has started more than 1 turn. the first turn of the game does not count, as there was no "previous" turn.
	TurnsCondition = new class'X2Condition_PlayerTurns';
	TurnsCondition.NumTurnsCheck.CheckType = eCheck_GreaterThan;
	TurnsCondition.NumTurnsCheck.Value = 1;
	ToHitModEffect.TargetConditions.AddItem(TurnsCondition);

	PersistentEffect.ApplyOnTick.AddItem(ToHitModEffect);
	Template.AddShooterEffect(PersistentEffect);


	return Template;
}


// Death From Above - Passive: Once per turn, killing a target at a lower elevation will refund one action.
static function X2AbilityTemplate WOTC_APA_DeathFromAbove()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_DeathFromAbove						RefundEffect;


	Template = CreatePassiveAbility('WOTC_APA_DeathFromAbove', "img:///UILibrary_PerkIcons.UIPerk_DeathFromAbove");


	// Create a persistent effect that refunds an action after height-advantage kill while braced
	RefundEffect= new class 'X2Effect_WOTC_APA_DeathFromAbove';
	RefundEffect.EffectName = 'WOTC_APA_DeathFromAboveRefundEffect';
	RefundEffect.DeathFromAboveActivations = default.DEATH_FROM_ABOVE_ACTIVATIONS;
	RefundEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(RefundEffect);

	
	return Template;
}


// Hawk-Eye - Passive: Grants a bonus to Vision and Weapon Range
static function X2AbilityTemplate WOTC_APA_HawkEye()
{

	local X2AbilityTemplate											Template;
	local X2Effect_PersistentStatChange								Effect;


	Template = CreatePassiveAbility('WOTC_APA_HawkEye', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Hawkeye");


	// Create a persistent stat change effect that adds [default: 8] tiles of Vision/Weapon Range
	Effect = new class 'X2Effect_PersistentStatChange';
	Effect.EffectName = 'WOTC_APA_HawkeyeStatEffect';
	Effect.BuildPersistentEffect(1, true, false, false);
	Effect.AddPersistentStatChange(eStat_SightRadius, default.HAWKEYE_RANGE_BONUS);
	Template.AddTargetEffect(Effect);


	return Template;
}


defaultproperties
{
	BraceTriggeredName = "WOTC_APA_BraceTriggered";
	LeadTheTargetMarkEffectName = "WOTC_APA_LeadTheTargetMarked";
	LeadTheTargetReserveActionName = "WOTC_APA_LeadTheTargetAction";
}