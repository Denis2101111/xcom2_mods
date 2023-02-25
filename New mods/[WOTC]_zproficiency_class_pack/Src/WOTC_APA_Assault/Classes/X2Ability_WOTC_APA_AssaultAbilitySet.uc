
class X2Ability_WOTC_APA_AssaultAbilitySet extends X2Ability_WOTC_APA_Utilities config(WOTC_APA_AssaultSkills);

// CQB Dominance Proficiency Level Variables
var config float			CQB_DOMINANCE_I_BASE_RADIUS;
var config float			CQB_DOMINANCE_II_BONUS_RADIUS;
var config float			CQB_DOMINANCE_III_BONUS_RADIUS;
var config float			CQB_DOMINANCE_BULLPUP_BONUS_RADIUS;


var config int				CQB_DOMINANCE_I_STAT_BONUS;
var config int				CQB_DOMINANCE_II_STAT_BONUS;
var config int				CQB_DOMINANCE_III_STAT_BONUS;

var name					CQB_DOMINANCE_RADIUS_NAME;

var localized string		strCQBDominance1Name;
var localized string		strCQBDominance1Desc;
var localized string		strCQBDominance2Name;
var localized string		strCQBDominance2Desc;
var localized string		strCQBDominance3Name;
var localized string		strCQBDominance3Desc;
var localized string		strCQBDominanceRadius;

// Ability Variables
var config int				RUN_AND_GUN_BASE_COOLDOWN;
var name					RUN_AND_GUN_COOLDOWN_NAME;
var config int				RUN_AND_GUN_LIGHT_WEAPON_COOLDOWN_REDUCTION;
var config array<name>		RUN_AND_GUN_LIGHT_PRIMARY_WEAPONS;
var config array<name>		RUN_AND_GUN_LIGHT_SECONDARY_WEAPONS;

var localized string		strRunAndGunMobilityName;
var localized string		strRunAndGunMobilityDesc;
var localized string		strRunAndGunMobilityIcon;
var localized string		strRunAndGunArmorName;
var localized string		strRunAndGunArmorDesc;
var localized string		strRunAndGunArmorIcon;
var localized string		strRunAndGunDamageName;
var localized string		strRunAndGunDamageDesc;
var localized string		strRunAndGunDamageIcon;
var localized string		strRunAndGunActionName;
var localized string		strRunAndGunActionDesc;
var localized string		strRunAndGunActionIcon;


var config float			PREP_FOR_ENTRY_RANGE_MULTIPLIER;
var config int				PREP_FOR_ENTRY_COOLDOWN;
var config int				ZONE_CONTROL_AIM_PENALTY;
var config int				ZONE_CONTROL_MOBILITY_PENALTY;
var config int				ZONE_CONTROL_CQB_BONUS_RADIUS;
var config int				HONED_EDGE_BONUS_AIM;
var config int				HONED_EDGE_BONUS_CRIT;
var config float			LARGE_PARTIAL_MOVE_MOBILITY_MULTIPLIER;
var config float			SMALL_PARTIAL_MOVE_MOBILITY_MULTIPLIER;
var config int				DEEP_RESERVES_COOLDOWN_MODIFIER;
var config int				DEEP_RESERVES_MOBILITY_BONUS;
var config int				LIGHTNING_REFLEXES_REACTION_FIRE_DEFENSE;
var config int				BATTERING_RAM_ARMOR_BONUS;
var config int				BATTERING_RAM_CONDITIONAL_ARMOR_BONUS;
var config int				SHOCK_AND_MAUL_DAMAGE_BONUS;
var config int				SHOCK_AND_MAUL_CONDITIONAL_DAMAGE_BONUS;
var config int				KILLER_INSTINCT_DAMAGE_BONUS;
var config float			KILLER_INSTINCT_CRITICAL_DAMAGE_MULTIPLIER;
var config int				RUTHLESS_DAMAGE_BONUS;
var config int				RUTHLESS_CRIT_CHANCE;
var config int				CONCUSSION_GRENADES_CHARGE_BONUS;
var config array<name>		CONCUSSION_GRENADES_CHARGE_GRENADE_TYPES;
var config int				NON_MOVE_ACTION_ACTIVATION_LIMIT;

var name					SLIP_INTO_POSITION_BONUS_NAME;
var config float			SLIP_INTO_POSITION_DETECTION_RANGE_BONUS_1;
var config float			SLIP_INTO_POSITION_DETECTION_RANGE_BONUS_2;
var config int				EVASIVE_DODGE_BONUS_PER_TILE;
var config int				EVASIVE_DODGE_BONUS_TILE_CAP;
var config int				HIT_RUN_ACTIVATIONS_PER_TURN;
var config int				CLOSE_COMBAT_SPECIALIST_TILE_RADIUS;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	/**/`Log("WOTC_APA_Assault - Begin Adding Templates");

	Templates.AddItem(WOTC_APA_CQBDominance());
	/*»»»*/	Templates.AddItem(WOTC_APA_CQBDominanceBullpupBonus());
	///*»»»*/	Templates.AddItem(WOTC_APA_CQBDominanceShowRange());
	Templates.AddItem(WOTC_APA_RunAndGun());
	/*»»»*/	Templates.AddItem(WOTC_APA_RunAndGunActive());
	Templates.AddItem(WOTC_APA_SwordSlice());

	Templates.AddItem(WOTC_APA_PrepForEntry());
	Templates.AddItem(WOTC_APA_ZoneOfControl());
	/*»»»*/	Templates.AddItem(WOTC_APA_ZoneOfControlCQBRadius());
	Templates.AddItem(WOTC_APA_HonedEdge());

	Templates.AddItem(WOTC_APA_BreachingManeuver());
	Templates.AddItem(WOTC_APA_DeepReserves());
	Templates.AddItem(WOTC_APA_Breakthrough());
	/*»»»*/	Templates.AddItem(WOTC_APA_LargePartialMovementActionMobilityPenalty());
	/*»»»*/	Templates.AddItem(WOTC_APA_SmallPartialMovementActionMobilityPenalty());

	Templates.AddItem(WOTC_APA_LightningReflexes());
	Templates.AddItem(WOTC_APA_BatteringRam());
	// Combatives:			LW2 Secondaries Ability

	Templates.AddItem(WOTC_APA_ShockAndMaul());
	Templates.AddItem(WOTC_APA_KillerInstinct());
	Templates.AddItem(WOTC_APA_Ruthless());

	Templates.AddItem(WOTC_APA_ConcussionGrenades());
	Templates.AddItem(WOTC_APA_ZoneDefense());
	/*»»»*/	Templates.AddItem(WOTC_APA_ZoneDefenseTrigger());
	/*»»»*/	Templates.AddItem(WOTC_APA_ZoneDefenseAttack());
	// Untouchable:			Base-game Ability
	
	Templates.AddItem(WOTC_APA_SweepAndClear());
	Templates.AddItem(WOTC_APA_RovingWarrior());
	Templates.AddItem(WOTC_APA_Relentless());

	Templates.AddItem(WOTC_APA_TakeCover());
	/*»»»*/	Templates.AddItem(WOTC_APA_TakeCoverEVOverride());
	Templates.AddItem(WOTC_APA_EverVigilant());
	Templates.AddItem(WOTC_APA_SlipIntoPosition());
	Templates.AddItem(WOTC_APA_Evasive());
	Templates.AddItem(WOTC_APA_HitAndRun());
	Templates.AddItem(WOTC_APA_CloseCombatSpecialist());
	/*»»»*/	Templates.AddItem(WOTC_APA_CloseCombatSpecialistAttack());
	
	/**/`Log("WOTC_APA_Assault - Finished Adding Templates");

	return Templates;
}


// CQB Dominance - Base Class Proficiency Ability
static function X2AbilityTemplate WOTC_APA_CQBDominance()
{
	
	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_TargetRankRequirement		RankCondition1, RankCondition2, RankCondition3;
	local X2Effect_SetUnitValue									SetUnitValue1, SetUnitValue2, SetUnitValue3;
	local X2Effect_WOTC_APA_CQBDominance						StatBoost1, StatBoost2, StatBoost3;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_CQBDominance');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_CQBDominance"; 
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
	RankCondition1.LogEffectName = "CQB Dominance 1";	// EffectName to use in logs
	RankCondition1.ExcludeProject = 'WOTC_APA_AssaultUnlock1';

	RankCondition2 = new class 'X2Condition_WOTC_APA_Class_TargetRankRequirement';
	RankCondition2.iMinRank = 3;
	RankCondition2.iMaxRank = 5;
	RankCondition2.LogEffectName = "CQB Dominance 2";
	RankCondition2.ExcludeProject = 'WOTC_APA_AssaultUnlock2';
	RankCondition2.GiveProject = 'WOTC_APA_AssaultUnlock1';
	
	RankCondition3 = new class 'X2Condition_WOTC_APA_Class_TargetRankRequirement';
	RankCondition3.iMinRank = 6;
	RankCondition3.iMaxRank = -1;	// No max rank for level 3 bonuses
	RankCondition3.LogEffectName = "CQB Dominance 3";
	RankCondition3.GiveProject = 'WOTC_APA_AssaultUnlock2';
	

	// Set CQB Range according to rank conditions
	SetUnitValue1 = new class'X2Effect_SetUnitValue';
	SetUnitValue1.UnitName = default.CQB_DOMINANCE_RADIUS_NAME;
	SetUnitValue1.NewValueToSet = default.CQB_DOMINANCE_I_BASE_RADIUS;
	SetUnitValue1.CleanupType = eCleanup_BeginTactical;
	SetUnitValue1.TargetConditions.AddItem(RankCondition1);
	Template.AddTargetEffect(SetUnitValue1);

	SetUnitValue2 = new class'X2Effect_SetUnitValue';
	SetUnitValue2.UnitName = default.CQB_DOMINANCE_RADIUS_NAME;
	SetUnitValue2.NewValueToSet = default.CQB_DOMINANCE_I_BASE_RADIUS + default.CQB_DOMINANCE_II_BONUS_RADIUS;
	SetUnitValue2.CleanupType = eCleanup_BeginTactical;
	SetUnitValue2.TargetConditions.AddItem(RankCondition2);
	Template.AddTargetEffect(SetUnitValue2);

	SetUnitValue3 = new class'X2Effect_SetUnitValue';
	SetUnitValue3.UnitName = default.CQB_DOMINANCE_RADIUS_NAME;
	SetUnitValue3.NewValueToSet = default.CQB_DOMINANCE_I_BASE_RADIUS + default.CQB_DOMINANCE_II_BONUS_RADIUS + default.CQB_DOMINANCE_III_BONUS_RADIUS;
	SetUnitValue3.CleanupType = eCleanup_BeginTactical;
	SetUnitValue3.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(SetUnitValue3);


	// Add the stat bonuses within CQB Range and setup the passive icons for each rank
	StatBoost1 = new class'X2Effect_WOTC_APA_CQBDominance';
	StatBoost1.BonusAmount = default.CQB_DOMINANCE_I_STAT_BONUS;
	StatBoost1.BuildPersistentEffect (1, true, false, false);
	StatBoost1.SetDisplayInfo(ePerkBuff_Passive, default.strCQBDominance1Name, default.strCQBDominance1Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_CQBDominance1", true,, Template.AbilitySourceName);
	StatBoost1.TargetConditions.AddItem(RankCondition1);
	Template.AddTargetEffect(StatBoost1);

	StatBoost2 = new class'X2Effect_WOTC_APA_CQBDominance';
	StatBoost2.BonusAmount = default.CQB_DOMINANCE_I_STAT_BONUS + default.CQB_DOMINANCE_II_STAT_BONUS;
	StatBoost2.BuildPersistentEffect (1, true, false, false);
	StatBoost2.SetDisplayInfo(ePerkBuff_Passive, default.strCQBDominance2Name, default.strCQBDominance2Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_CQBDominance2", true,, Template.AbilitySourceName);
	StatBoost2.TargetConditions.AddItem(RankCondition2);
	Template.AddTargetEffect(StatBoost2);

	StatBoost3 = new class'X2Effect_WOTC_APA_CQBDominance';
	StatBoost3.BonusAmount = default.CQB_DOMINANCE_I_STAT_BONUS + default.CQB_DOMINANCE_II_STAT_BONUS + default.CQB_DOMINANCE_III_STAT_BONUS;
	StatBoost3.BuildPersistentEffect (1, true, false, false);
	StatBoost3.SetDisplayInfo(ePerkBuff_Passive, default.strCQBDominance3Name, default.strCQBDominance3Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_CQBDominance3", true,, Template.AbilitySourceName);
	StatBoost3.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(StatBoost3);


	Template.AdditionalAbilities.AddItem('WOTC_APA_CQBDominanceBullpupBonus');
	//Template.AdditionalAbilities.AddItem('WOTC_APA_CQBDominanceShowRange');


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

// CQB Dominance - Bullpup Bonus Radius: CQB Dominance radius is increased by [default: +3] tiles when equipping the Bullpup
static function X2AbilityTemplate WOTC_APA_CQBDominanceBullpupBonus()
{

	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;
	local X2Effect_IncrementUnitValue							IncrementUnitValue;
	

	Template = CreatePassiveAbility('WOTC_APA_CQBDominanceBullpupBonus', "img:///UILibrary_WOTC_APA_Class_Pack.perk_CQBDominance", 'WOTC_APA_CQBDominanceBullpupBonus_Icon', false);


	// Require a bullpup to grant the bonus
	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories.AddItem('bullpup');
	WeaponCondition.bCheckSpecificSlot = true;
	WeaponCondition.SpecificSlot = eInvSlot_PrimaryWeapon;


	IncrementUnitValue = new class'X2Effect_IncrementUnitValue';
	IncrementUnitValue.UnitName = default.CQB_DOMINANCE_RADIUS_NAME;
	IncrementUnitValue.NewValueToSet = default.CQB_DOMINANCE_BULLPUP_BONUS_RADIUS;
	IncrementUnitValue.CleanupType = eCleanup_BeginTactical;
	IncrementUnitValue.TargetConditions.AddItem(WeaponCondition);
	Template.AddTargetEffect(IncrementUnitValue);


	return Template;
}

// CQB Dominance - Show Range: Active ability the does nothing, but will show the 
static function X2AbilityTemplate WOTC_APA_CQBDominanceShowRange()
{

	local X2AbilityTemplate										Template;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2AbilityMultiTarget_WOTC_APA_CQBRadius				RadiusMultiTarget;
	

	Template = CreateSelfActiveAbility('WOTC_APA_CQBDominanceShowRange', "img:///UILibrary_WOTC_APA_Class_Pack.perk_CQBDominance", false);
	Template.ShotHUDPriority = 1900;


	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	RadiusMultiTarget = new class'X2AbilityMultiTarget_WOTC_APA_CQBRadius';
	RadiusMultiTarget.bIgnoreBlockingCover = true;
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;


	Template.BuildNewGameStateFn = none;
	Template.BuildVisualizationFn = none;
	return Template;
}


// Run and Gun -  Passive: Grants Run and Gun and sets up the passive effects
static function X2AbilityTemplate WOTC_APA_RunAndGun()
{

	local X2AbilityTemplate										Template;
	local X2Effect_SetUnitValue									SetUnitValue;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition1, WeaponCondition2;
	local X2Effect_IncrementUnitValue							ModifyUnitValue1, ModifyUnitValue2;


	Template = CreatePassiveAbility('WOTC_APA_RunAndGun', "img:///UILibrary_PerkIcons.UIPerk_runandgun",, false);
	

	// Set the base Cooldown UnitVale
	SetUnitValue = new class'X2Effect_SetUnitValue';
	SetUnitValue.UnitName = default.RUN_AND_GUN_COOLDOWN_NAME;
	SetUnitValue.NewValueToSet = default.RUN_AND_GUN_BASE_COOLDOWN;
	SetUnitValue.CleanupType = eCleanup_BeginTactical;
	Template.AddTargetEffect(SetUnitValue);


	// Setup Cooldown reductions for light weapons
	WeaponCondition1 = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition1.AllowedWeaponCategories = default.RUN_AND_GUN_LIGHT_PRIMARY_WEAPONS;
	WeaponCondition1.bCheckSpecificSlot = true;
	WeaponCondition1.SpecificSlot = eInvSlot_PrimaryWeapon;

	ModifyUnitValue1 = new class'X2Effect_IncrementUnitValue';
	ModifyUnitValue1.UnitName = default.RUN_AND_GUN_COOLDOWN_NAME;
	ModifyUnitValue1.NewValueToSet = -default.RUN_AND_GUN_LIGHT_WEAPON_COOLDOWN_REDUCTION;
	ModifyUnitValue1.CleanupType = eCleanup_BeginTactical;
	ModifyUnitValue1.TargetConditions.AddItem(WeaponCondition1);
	Template.AddTargetEffect(ModifyUnitValue1);

	WeaponCondition2 = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition2.AllowedWeaponCategories = default.RUN_AND_GUN_LIGHT_SECONDARY_WEAPONS;
	WeaponCondition2.bCheckSpecificSlot = true;
	WeaponCondition2.SpecificSlot = eInvSlot_SecondaryWeapon;

	ModifyUnitValue2 = new class'X2Effect_IncrementUnitValue';
	ModifyUnitValue2.UnitName = default.RUN_AND_GUN_COOLDOWN_NAME;
	ModifyUnitValue2.NewValueToSet = -default.RUN_AND_GUN_LIGHT_WEAPON_COOLDOWN_REDUCTION;
	ModifyUnitValue2.CleanupType = eCleanup_BeginTactical;
	ModifyUnitValue2.TargetConditions.AddItem(WeaponCondition2);
	Template.AddTargetEffect(ModifyUnitValue2);


	// Add the Activatible Run and Gun ability
	Template.AdditionalAbilities.AddItem('WOTC_APA_RunAndGunActive');


	return Template;
}

// Run and Gun - Active: Activate to gain an additional non-movement action
static function X2AbilityTemplate WOTC_APA_RunAndGunActive()
{

	local X2AbilityTemplate										Template;
	local X2AbilityCooldown_WOTC_APA_Class_UnitValue			Cooldown;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2Effect_GrantActionPoints							ActionPointEffect;
	local X2Condition_WOTC_APA_Class_AbilityRequirement			MobilityCondition, ArmorCondition, DamageCondition, ShotCondition;
	local X2Effect_PersistentStatChange							MobilityEffect, ArmorEffect;
	local X2Effect_WOTC_APA_Class_BonusDamage					DamageEffect;
	local X2Effect_Persistent									ShotEffect;
	
	
	Template = CreateSelfActiveAbility('WOTC_APA_RunAndGunActive', "img:///UILibrary_PerkIcons.UIPerk_runandgun");

	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_LIEUTENANT_PRIORITY;
	Template.AbilityConfirmSound = "TacticalUI_Activate_Ability_Run_N_Gun";
	Template.ActivationSpeech = 'RunAndGun';
	Template.ConcealmentRule = eConceal_Never;
	Template.bSkipFireAction = true;


	// Set ability costs, cooldowns, and restrictions
	Cooldown = new class'X2AbilityCooldown_WOTC_APA_Class_UnitValue';
	Cooldown.UnitName = default.RUN_AND_GUN_COOLDOWN_NAME;
	Cooldown.iNumTurns = default.RUN_AND_GUN_BASE_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	Template.AbilityCosts.AddItem(ActionPointCost);


	// Add the additional action point to the target
	ActionPointEffect = new class'X2Effect_GrantActionPoints';
	ActionPointEffect.NumActionPoints = 1;
	ActionPointEffect.PointType = class'X2CharacterTemplateManager'.default.RunAndGunActionPoint;
	Template.AddTargetEffect(ActionPointEffect);


	// Add the bonus to Mobility if Deep Reserves is present
	MobilityCondition = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
	MobilityCondition.RequiredAbilityNames.AddItem('WOTC_APA_DeepReserves');

	MobilityEffect = new class'X2Effect_PersistentStatChange';
	MobilityEffect.EffectName = 'WOTC_APA_DeepReserves_ConditionalMobility';
	MobilityEffect.AddPersistentStatChange(eStat_Mobility, default.DEEP_RESERVES_MOBILITY_BONUS);
	MobilityEffect.SetDisplayInfo(ePerkBuff_Bonus, default.strRunAndGunMobilityName, default.strRunAndGunMobilityDesc, default.strRunAndGunMobilityIcon);
	MobilityEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	MobilityEffect.DuplicateResponse = eDupe_Ignore;
	MobilityEffect.TargetConditions.AddItem(MobilityCondition);
	Template.AddTargetEffect(MobilityEffect);


	// Add the bonus point of Armor if Battering Ram is present
	ArmorCondition = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
	ArmorCondition.RequiredAbilityNames.AddItem('WOTC_APA_BatteringRam');

	ArmorEffect = new class'X2Effect_PersistentStatChange';
	ArmorEffect.EffectName = 'WOTC_APA_BatteringRam_ConditionalArmor';
	ArmorEffect.AddPersistentStatChange(eStat_ArmorMitigation, default.BATTERING_RAM_CONDITIONAL_ARMOR_BONUS);
	ArmorEffect.SetDisplayInfo(ePerkBuff_Bonus, default.strRunAndGunArmorName, default.strRunAndGunArmorDesc, default.strRunAndGunArmorIcon);
	ArmorEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	ArmorEffect.DuplicateResponse = eDupe_Ignore;
	ArmorEffect.TargetConditions.AddItem(ArmorCondition);
	Template.AddTargetEffect(ArmorEffect);


	// Add the bonus damage if Killer Instinct is present
	DamageCondition = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
	DamageCondition.RequiredAbilityNames.AddItem('WOTC_APA_KillerInstinct');

	DamageEffect = new class'X2Effect_WOTC_APA_Class_BonusDamage';
	DamageEffect.EffectName = 'WOTC_APA_KillerInstinct_ConditionalDamage';
	DamageEffect.BonusDmg = default.KILLER_INSTINCT_DAMAGE_BONUS;
	DamageEffect.fBonusCritDmgMultiplier = default.KILLER_INSTINCT_CRITICAL_DAMAGE_MULTIPLIER;
	DamageEffect.bApplyToPrimary = true;
	DamageEffect.bApplyToSecondary = true;
	DamageEffect.SetDisplayInfo(ePerkBuff_Bonus, default.strRunAndGunDamageName, default.strRunAndGunDamageDesc, default.strRunAndGunDamageIcon);
	DamageEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	DamageEffect.DuplicateResponse = eDupe_Ignore;
	DamageEffect.TargetConditions.AddItem(DamageCondition);
	Template.AddTargetEffect(DamageEffect);


	// Add the effect making standard shots no longer end the turn if Roving Warrior is present
	ShotCondition = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
	ShotCondition.RequiredAbilityNames.AddItem('WOTC_APA_RovingWarrior');

	ShotEffect = new class'X2Effect_Persistent';
	ShotEffect.EffectName = 'WOTC_APA_RunAndGun_NonTurnEndingShots';
	ShotEffect.SetDisplayInfo(ePerkBuff_Bonus, default.strRunAndGunActionName, default.strRunAndGunActionDesc, default.strRunAndGunActionIcon);
	ShotEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	ShotEffect.DuplicateResponse = eDupe_Ignore;
	ShotEffect.TargetConditions.AddItem(ShotCondition);
	Template.AddTargetEffect(ShotEffect);


	return Template;
}


// Sword Slice: Ranger's Sword Slice with different icon and descriptions
static function X2AbilityTemplate WOTC_APA_SwordSlice()
{

	local X2AbilityTemplate										Template;
	
	Template = class'X2Ability_RangerAbilitySet'.static.AddSwordSliceAbility('WOTC_APA_SwordSlice');
	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_EndOfMove');

	Template.OverrideAbilities.AddItem('SwordSlice');
	
	return Template;
}


// Prep For Entry: Activate to throw a grenade for free, but with reduced throw range
static function X2AbilityTemplate WOTC_APA_PrepForEntry()
{

	local X2AbilityTemplate										Template;
	local X2AbilityCooldown										Cooldown;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2Effect_WOTC_APA_PrepForEntry						FreeActionEffect;
	
	
	Template = CreateSelfActiveAbility('WOTC_APA_PrepForEntry', "img:///UILibrary_WOTC_APA_Class_Pack.perk_PrepForEntry");

	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.STANDARD_GRENADE_PRIORITY - 1;
	Template.AbilityConfirmSound = "TacticalUI_Activate_Ability_Run_N_Gun";
	Template.ActivationSpeech = 'PrimeGrenade';
	Template.bSkipFireAction = true;


	// Set ability costs, cooldowns, and restrictions
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.PREP_FOR_ENTRY_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	Template.AbilityCosts.AddItem(ActionPointCost);


	// Add the effects altering range and cost for grenade abilities
	FreeActionEffect = new class'X2Effect_WOTC_APA_PrepForEntry';
	FreeActionEffect.EffectName = 'WOTC_APA_PrepForEntryEffect';
	FreeActionEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnEnd);
	Template.AddTargetEffect(FreeActionEffect);


	return Template;
}


// Zone of Control:
static function X2AbilityTemplate WOTC_APA_ZoneOfControl()
{

	local X2AbilityTemplate										Template;
	local X2Effect_IncrementUnitValue							IncrementUnitValue;

	


	Template = CreatePassiveAbility('WOTC_APA_ZoneOfControl', "img:///UILibrary_WOTC_APA_Class_Pack.perk_ZoneOfControl");
	

	// Increase CQB Dominance Radius by [default: 1 Tile]
	IncrementUnitValue = new class'X2Effect_IncrementUnitValue';
	IncrementUnitValue.UnitName = default.CQB_DOMINANCE_RADIUS_NAME;
	IncrementUnitValue.NewValueToSet = default.ZONE_CONTROL_CQB_BONUS_RADIUS;
	IncrementUnitValue.CleanupType = eCleanup_BeginTactical;
	Template.AddTargetEffect(IncrementUnitValue);
	
	
	Template.AdditionalAbilities.AddItem('WOTC_APA_ZoneOfControlCQBRadius');


	return Template;
}

static function X2AbilityTemplate WOTC_APA_ZoneOfControlCQBRadius()
{

	local X2AbilityTemplate										Template;
	local X2AbilityTrigger_EventListener						EventListener;
	local X2Condition_UnitProperty								TargetProperty;
	local X2Condition_WOTC_APA_WithinCQBRange					RangeCondition;
	local XMBEffect_ConditionalStatChange						ZOCEffect;
	

	Template = CreatePassiveAbility('WOTC_APA_ZoneOfControlCQBRadius',,, false);


	// Add player turn trigger to pick up reinforcements/spawns/etc.
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	EventListener = new class'X2AbilityTrigger_EventListener';
    EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
    EventListener.ListenerData.EventID = 'PlayerTurnBegun';
    EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
    EventListener.ListenerData.Filter = eFilter_Player;
    Template.AbilityTriggers.AddItem(EventListener);


	// Setup MultiTarget and conditions
	Template.AbilityMultiTargetStyle = new class'X2AbilityMultiTarget_AllUnits';

	TargetProperty = new class'X2Condition_UnitProperty';
	TargetProperty.ExcludeDead = true;
	TargetProperty.ExcludeHostileToSource = false;
	TargetProperty.ExcludeFriendlyToSource = true;
	TargetProperty.ExcludeSquadmates = true;

	RangeCondition = new class'X2Condition_WOTC_APA_WithinCQBRange';
	RangeCondition.bLimitToActivatedTargets = true;

	
	// Create the Zone of Control effect
	ZOCEffect = new class'XMBEffect_ConditionalStatChange';
	ZOCEffect.EffectName = 'WOTC_APA_ZoneOfControlEffect';
	ZOCEffect.AddPersistentStatChange(eStat_Mobility, default.ZONE_CONTROL_MOBILITY_PENALTY);
	ZOCEffect.AddPersistentStatChange(eStat_Offense, default.ZONE_CONTROL_AIM_PENALTY);
	ZOCEffect.SetDisplayInfo(ePerkBuff_Penalty, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	ZOCEffect.DuplicateResponse = eDupe_Refresh;
	ZOCEffect.Conditions.AddItem(RangeCondition);
	ZOCEffect.TargetConditions.AddItem(TargetProperty);
	Template.AddMultiTargetEffect(ZOCEffect);


	return Template;
}


// Honed Edge: Add +15% Aim and Crit Chance to all melee attacks
static function X2AbilityTemplate WOTC_APA_HonedEdge()
{

	local X2AbilityTemplate										Template;
	local X2Effect_ToHitModifier								ModifierEffect;
	

	Template = CreatePassiveAbility('WOTC_APA_HonedEdge', "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_ceramicblade");
	//Template = CreatePassiveAbility('WOTC_APA_HonedEdge', "img:///UILibrary_WOTC_APA_Class_Pack.perk_HonedEdge");


	ModifierEffect = new class'X2Effect_ToHitModifier';
	ModifierEffect.BuildPersistentEffect(1, true, false);
	ModifierEffect.AddEffectHitModifier(eHit_Success, default.HONED_EDGE_BONUS_AIM, Template.LocFriendlyName,, true, false, true, true);
	ModifierEffect.AddEffectHitModifier(eHit_Crit, default.HONED_EDGE_BONUS_CRIT, Template.LocFriendlyName,, true, false, true, true);
	Template.AddTargetEffect(ModifierEffect);


	return Template;
}


// Breaching Maneuver: Get a partial movement action refunded after attacking a stunned or disoriented target within CQB range
static function X2AbilityTemplate WOTC_APA_BreachingManeuver()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_AssaultActionRefunds				HalfMoveEffect;
	

	Template = CreatePassiveAbility('WOTC_APA_BreachingManeuver', "img:///UILibrary_WOTC_APA_Class_Pack.perk_BreachingManeuver");


	HalfMoveEffect = new class'X2Effect_WOTC_APA_AssaultActionRefunds';
	HalfMoveEffect.EffectName = 'WOTC_APA_AssaultActionRefundsEffect';
	HalfMoveEffect.DuplicateResponse = eDupe_Ignore;
	HalfMoveEffect.BuildPersistentEffect(1, true, false);
	Template.AddTargetEffect(HalfMoveEffect);


	// Add the additional ability that creates the Mobility penalty
	Template.AdditionalAbilities.AddItem('WOTC_APA_LargePartialMovementActionMobilityPenalty');
	Template.AdditionalAbilities.AddItem('WOTC_APA_SmallPartialMovementActionMobilityPenalty');


	return Template;
}


// Deep Reserves: Reduce the cooldown for Run-And-Gun and gain extra Mobility when Run-And-Gun is activated (handled in the Run-And-Gun ability)
static function X2AbilityTemplate WOTC_APA_DeepReserves()
{
	
	local X2AbilityTemplate										Template;
	local X2Effect_IncrementUnitValue							ModifyUnitValue;
	

	Template = CreatePassiveAbility('WOTC_APA_DeepReserves', "img:///UILibrary_WOTC_APA_Class_Pack.perk_DeepReserves");


	// Setup Run and Gun Cooldown reductions
	ModifyUnitValue = new class'X2Effect_IncrementUnitValue';
	ModifyUnitValue.UnitName = default.RUN_AND_GUN_COOLDOWN_NAME;
	ModifyUnitValue.NewValueToSet = default.DEEP_RESERVES_COOLDOWN_MODIFIER;
	ModifyUnitValue.CleanupType = eCleanup_BeginTactical;
	Template.AddTargetEffect(ModifyUnitValue);


	return Template;
}


// Breakthrough: Get a partial movement action refunded after melee attacking a target
static function X2AbilityTemplate WOTC_APA_Breakthrough()
{
	
	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_AssaultActionRefunds				HalfMoveEffect;
	

	Template = CreatePassiveAbility('WOTC_APA_Breakthrough', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Breakthrough");


	HalfMoveEffect = new class'X2Effect_WOTC_APA_AssaultActionRefunds';
	HalfMoveEffect.EffectName = 'WOTC_APA_AssaultActionRefundsEffect';
	HalfMoveEffect.DuplicateResponse = eDupe_Ignore;
	HalfMoveEffect.BuildPersistentEffect(1, true, false);
	Template.AddTargetEffect(HalfMoveEffect);


	// Add the additional ability that creates the Mobility penalty
	Template.AdditionalAbilities.AddItem('WOTC_APA_LargePartialMovementActionMobilityPenalty');
	Template.AdditionalAbilities.AddItem('WOTC_APA_SmallPartialMovementActionMobilityPenalty');


	return Template;
}

// Partial Movement Action Mobility Penalty: Implements the mobility penalty for half actions from Breaching Maneuver / Lithe Motion
static function X2AbilityTemplate WOTC_APA_LargePartialMovementActionMobilityPenalty()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_PartialMovementMobilityPenalty		MobilityPenaltyEffect;
	local X2AbilityTrigger_EventListener						EventListener;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_LargePartialMovementActionMobilityPenalty');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_Reposition";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bDontDisplayInAbilitySummary = true;
	Template.bDisplayInUITooltip = false;
	Template.bCrossClassEligible = false;
	Template.ActivationSpeech = 'RunAndGun';
	Template.bSkipFireAction = true;
	Template.bUniqueSource = true;


	// This ability triggers after X2Effect_WOTC_APA_Reposition successfully fires
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = class'X2Effect_WOTC_APA_AssaultActionRefunds'.default.WOTC_APA_AssaultLargePartialMovementAction_TriggeredName;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	Template.AbilityTriggers.AddItem(EventListener);


	// Create a stat change effect lasting through the end of the player's turn that multiplies the unit's mobility by [default: 0.25] 
	MobilityPenaltyEffect = new class'X2Effect_WOTC_APA_PartialMovementMobilityPenalty';
	MobilityPenaltyEffect.EffectName = 'WOTC_APA_AssaultPartialMovementActionMobilityPenalty';
	MobilityPenaltyEffect.fModifier = default.LARGE_PARTIAL_MOVE_MOBILITY_MULTIPLIER;
	MobilityPenaltyEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnEnd);
	MobilityPenaltyEffect.SetDisplayInfo(ePerkBuff_Penalty, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage);
	MobilityPenaltyEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(MobilityPenaltyEffect);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}

// Partial Movement Action Mobility Penalty: Implements the mobility penalty for half actions from Breaching Maneuver / Lithe Motion
static function X2AbilityTemplate WOTC_APA_SmallPartialMovementActionMobilityPenalty()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_PartialMovementMobilityPenalty		MobilityPenaltyEffect;
	local X2AbilityTrigger_EventListener						EventListener;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_SmallPartialMovementActionMobilityPenalty');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_Reposition";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bDontDisplayInAbilitySummary = true;
	Template.bDisplayInUITooltip = false;
	Template.bCrossClassEligible = false;
	Template.ActivationSpeech = 'RunAndGun';
	Template.bSkipFireAction = true;
	Template.bUniqueSource = true;


	// This ability triggers after X2Effect_WOTC_APA_Reposition successfully fires
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = class'X2Effect_WOTC_APA_AssaultActionRefunds'.default.WOTC_APA_AssaultSmallPartialMovementAction_TriggeredName;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	Template.AbilityTriggers.AddItem(EventListener);


	// Create a stat change effect lasting through the end of the player's turn that multiplies the unit's mobility by [default: 0.5] 
	MobilityPenaltyEffect = new class'X2Effect_WOTC_APA_PartialMovementMobilityPenalty';
	MobilityPenaltyEffect.EffectName = 'WOTC_APA_AssaultPartialMovementActionMobilityPenalty';
	MobilityPenaltyEffect.fModifier = default.SMALL_PARTIAL_MOVE_MOBILITY_MULTIPLIER;
	MobilityPenaltyEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnEnd);
	MobilityPenaltyEffect.SetDisplayInfo(ePerkBuff_Penalty, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage);
	MobilityPenaltyEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(MobilityPenaltyEffect);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}


// Lightning Reflexes: The first reaction fire is garaunteed to miss and subsequent shots suffer a [default: 25%] penalty to hit
static function X2AbilityTemplate WOTC_APA_LightningReflexes()
{
	
	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_LightningReflexes					ReflexesEffect;
	

	Template = CreatePassiveAbility('WOTC_APA_LightningReflexes', "img:///UILibrary_PerkIcons.UIPerk_lightningreflexes");


	// Setup reaction fire defense and reflex effect
	ReflexesEffect = new class'X2Effect_WOTC_APA_LightningReflexes';
	ReflexesEffect.BuildPersistentEffect(1, true, false, false, eGameRule_PlayerTurnBegin);
	ReflexesEffect.EffectName = 'WOTC_APA_LightningReflexesEffect';
	ReflexesEffect.HitMod = -default.LIGHTNING_REFLEXES_REACTION_FIRE_DEFENSE;
	Template.AddTargetEffect(ReflexesEffect);


	return Template;
}


// Battering Ram: Gain +1 Armor and another +1 Armor when Run-And-Gun is activated (handled in the Run-And-Gun ability)
static function X2AbilityTemplate WOTC_APA_BatteringRam()
{

	local X2AbilityTemplate										Template;
	local X2Effect_PersistentStatChange							ArmorEffect;


	Template = CreatePassiveAbility('WOTC_APA_BatteringRam', "img:///UILibrary_WOTC_APA_Class_Pack.perk_BatteringRam");


	// Create a persistent stat change effect that adds [default: 1] point of armor
	ArmorEffect = new class 'X2Effect_PersistentStatChange';
	ArmorEffect.BuildPersistentEffect(1, true, false, false);
	ArmorEffect.AddPersistentStatChange(eStat_ArmorMitigation, default.BATTERING_RAM_ARMOR_BONUS);
	Template.AddTargetEffect(ArmorEffect);


	// Add UI stat markups corresponding to effect stat boosts
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ArmorLabel, eStat_ArmorMitigation, default.BATTERING_RAM_ARMOR_BONUS);


	return Template;
}


// Shock and Maul: Grant +1 Damage against disoriented or stunned enemies and an additional +1 Damage if they are within CQB range
static function X2AbilityTemplate WOTC_APA_ShockAndMaul()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_ShockAndMaul						DamageEffect;


	Template = CreatePassiveAbility('WOTC_APA_ShockAndMaul', "img:///UILibrary_WOTC_APA_Class_Pack.perk_ShockAndMaul");


	// Create a persistent effect that grants bonus damage against disoriented or stunned targets
	DamageEffect = new class 'X2Effect_WOTC_APA_ShockAndMaul';
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.FriendlyName = Template.LocFriendlyName;
	Template.AddTargetEffect(DamageEffect);


	// Add UI stat markups corresponding to effect stat boosts
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ArmorLabel, eStat_ArmorMitigation, default.BATTERING_RAM_ARMOR_BONUS);


	return Template;
}


// Killer Instinct: Gain +1 Damage and +25% Crit Damage when Run-And-Gun is activated (handled in the Run-And-Gun ability)
static function X2AbilityTemplate WOTC_APA_KillerInstinct()
{

	local X2AbilityTemplate										Template;
	
	Template = CreatePassiveAbility('WOTC_APA_KillerInstinct', "img:///UILibrary_WOTC_APA_Class_Pack.perk_KillerInstinct");
	
	return Template;
}


// Ruthless: Melee attacks with secondary weapons deal [default: +1] damage and are [default: 20%] more likely to critically hit
static function X2AbilityTemplate WOTC_APA_Ruthless()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_BonusDamage					DamageEffect;
	local X2Effect_ToHitModifier								ModifierEffect;
	

	Template = CreatePassiveAbility('WOTC_APA_Ruthless', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Ruthless");


	DamageEffect = new class'X2Effect_WOTC_APA_Class_BonusDamage';
	DamageEffect.EffectName = 'WOTC_APA_Ruthless_ConditionalDamage';
	DamageEffect.BonusDmg = default.RUTHLESS_DAMAGE_BONUS;
	DamageEffect.bApplyToPrimary = false;
	DamageEffect.bApplyToSecondary = true;
	DamageEffect.BuildPersistentEffect (1, true, false, false);
	DamageEffect.FriendlyName = Template.LocFriendlyName;
	DamageEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(DamageEffect);


	ModifierEffect = new class'X2Effect_ToHitModifier';
	ModifierEffect.BuildPersistentEffect(1, true, false);
	ModifierEffect.AddEffectHitModifier(eHit_Crit, default.RUTHLESS_CRIT_CHANCE, Template.LocFriendlyName,, true, false, true, true);
	Template.AddTargetEffect(ModifierEffect);


	return Template;
}


// Concussion Grenades: Grants +1 charges to equipped flashbangs, grants a grenade pocket, and adds disorient to most grenade explosions
static function X2AbilityTemplate WOTC_APA_ConcussionGrenades()
{
	
	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_BonusItems					ItemEffect;
	

	Template = CreatePassiveAbility('WOTC_APA_ConcussionGrenades', "img:///UILibrary_WOTC_APA_Class_Pack.perk_ConcussionGrenades");


	// Create an effect that adds [default: 1] additional charges to equipped flashbangs
	ItemEffect = new class'X2Effect_WOTC_APA_Class_BonusItems';
	ItemEffect.EffectName = 'WOTC_APA_ConcussionGrenadesEffect';
	ItemEffect.BonusItems = default.CONCUSSION_GRENADES_CHARGE_GRENADE_TYPES;
	ItemEffect.BonusCharges = default.CONCUSSION_GRENADES_CHARGE_BONUS;
	ItemEffect.BuildPersistentEffect (1, true, false, false);
	Template.AddTargetEffect(ItemEffect);


	return Template;
}


// Zone Defense:
static function X2AbilityTemplate WOTC_APA_ZoneDefense()
{
	
	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_ZoneDefenseListener					ListenerEffect;

	
	Template = CreatePassiveAbility('WOTC_APA_ZoneDefense', "img:///UILibrary_WOTC_APA_Class_Pack.perk_ZoneDefense");

	
	// Create the passive listener effect that sets off the trigger when the unit enters overwatch
	ListenerEffect = new class'X2Effect_WOTC_APA_ZoneDefenseListener';
	ListenerEffect.EffectName = 'WOTC_APA_ZoneDefenseListenerEffect';
	ListenerEffect.BuildPersistentEffect(1, true, false);
	ListenerEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(ListenerEffect);


	// Add the additional abilities required
	Template.AdditionalAbilities.AddItem('WOTC_APA_ZoneDefenseTrigger');
	Template.AdditionalAbilities.AddItem('WOTC_APA_ZoneDefenseAttack');


	return Template;
}

static function X2AbilityTemplate WOTC_APA_ZoneDefenseTrigger()
{
	
	local X2AbilityTemplate					Template;
	local X2AbilityTrigger_EventListener	EventListener;
	local X2Effect_Persistent				ActiveEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_ZoneDefenseTrigger');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_ZoneDefense";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bDisplayInUITooltip = false;
	Template.bCrossClassEligible = false;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;


	// This ability triggers after the unit enters overwatch
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = class'X2Effect_WOTC_APA_ZoneDefenseListener'.default.WOTC_APA_ZoneDefense_TriggeredName;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	Template.AbilityTriggers.AddItem(EventListener);


	// Create a passive effect used to enable Zone Defense's attack ability to pass condition checks for one turn
	ActiveEffect = new class'X2Effect_Persistent';
	ActiveEffect.EffectName = 'WOTC_APA_ZoneDefenseActive';
	ActiveEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	ActiveEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, true,, Template.AbilitySourceName);
	ActiveEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(ActiveEffect);

		
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}

static function X2AbilityTemplate WOTC_APA_ZoneDefenseAttack()
{
	
	local X2AbilityTemplate								Template;
	local X2AbilityTarget_WOTC_APA_ZoneDefense			ShotTarget;
	local X2AbilityToHitCalc_StandardAim				ToHitCalc;
	local X2Condition_UnitEffectsOnSource				TriggerCondition;
	local X2Condition_UnitProperty						ConcealmentCondition;
	local X2Condition_Visibility						TargetVisibilityCondition;
	local X2AbilityCost_Ammo							AmmoCost;
	local X2AbilityTrigger_Event						Trigger;
	local X2AbilityTrigger_EventListener				EventListener;
	local X2Effect_Persistent							TrackerEffect;
	local X2Condition_UnitEffectsWithAbilitySource		TrackerCondition;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_ZoneDefenseAttack');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_ZoneDefense";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITooltip = false;
	Template.bCrossClassEligible = false;
	Template.bShowActivation = true;


	// Target style, hitcalc, and conditions
	ShotTarget = new class 'X2AbilityTarget_WOTC_APA_ZoneDefense';
	Template.AbilityTargetStyle = ShotTarget;

	ToHitCalc = new class'X2AbilityToHitCalc_StandardAim';
	ToHitCalc.bReactionFire = true;
	Template.AbilityToHitCalc = ToHitCalc;

	Template.AbilityTargetConditions.AddItem(default.LivingHostileUnitDisallowMindControlProperty);
	Template.AbilityTargetConditions.AddItem(class'X2Ability_DefaultAbilitySet'.static.OverwatchTargetEffectsCondition());
	Template.AbilityTargetConditions.AddItem(new class'X2Condition_WOTC_APA_WithinCQBRange');
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);	
	Template.AddShooterEffectExclusions();

	// Require the Active effect triggered by entering Overwatch
	TriggerCondition = new class'X2Condition_UnitEffectsOnSource';
	TriggerCondition.AddRequireEffect('WOTC_APA_ZoneDefenseActive', 'AA_MissingRequiredEffect');
	Template.AbilityTargetConditions.AddItem(TriggerCondition);

	// Don't trigger when the source is concealed
	ConcealmentCondition = new class'X2Condition_UnitProperty';
	ConcealmentCondition.ExcludeConcealed = true;
	Template.AbilityShooterConditions.AddItem(ConcealmentCondition);

	// Require normal visibility
	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	TargetVisibilityCondition.bRequireBasicVisibility = true;
	TargetVisibilityCondition.bDisablePeeksOnMovement = true; //Don't use peek tiles for over watch shots	
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);
	
	// Ammo cost and effects
	AmmoCost = new class 'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);

	Template.bAllowAmmoEffects = true;
	Template.bAllowBonusWeaponEffects = true;
	Template.AddTargetEffect(class 'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect());
	

	// Trigger on movement
	Trigger = new class'X2AbilityTrigger_Event';
	Trigger.EventObserverClass = class'X2TacticalGameRuleset_MovementObserver';
	Trigger.MethodName = 'InterruptGameState';
	Template.AbilityTriggers.AddItem(Trigger);
	Trigger = new class'X2AbilityTrigger_Event';
	Trigger.EventObserverClass = class'X2TacticalGameRuleset_MovementObserver';
	Trigger.MethodName = 'PostBuildGameState';
	Template.AbilityTriggers.AddItem(Trigger);

	// Trigger on an attack
	Trigger = new class'X2AbilityTrigger_Event';
	Trigger.EventObserverClass = class'X2TacticalGameRuleset_AttackObserver';
	Trigger.MethodName = 'InterruptGameState';
	Template.AbilityTriggers.AddItem(Trigger);

	// It may be the case that enemy movement caused a concealment break, which made a reaction shot applicable - attempt to trigger afterwards
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = 'UnitConcealmentBroken';
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = ZoneDefenseConcealmentListener;
	EventListener.ListenerData.Priority = 55;
	Template.AbilityTriggers.AddItem(EventListener);
	

	// Prevent Zone Defense shots from triggering more than once per target
	TrackerEffect = new class'X2Effect_Persistent';
	TrackerEffect.BuildPersistentEffect(1, false, true, true, eGameRule_PlayerTurnEnd);
	TrackerEffect.EffectName = 'WOTC_APA_ZoneDefenseTarget';
	TrackerEffect.bApplyOnMiss = true;
	Template.AddTargetEffect(TrackerEffect);

	TrackerCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	TrackerCondition.AddExcludeEffect('WOTC_APA_ZoneDefenseTarget', 'AA_DuplicateEffectIgnored');
	Template.AbilityTargetConditions.AddItem(TrackerCondition);


	// Standard interactions with Shadow, Chosen, and the Lost
	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotChosenActivationIncreasePerUse;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;
	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}

static function EventListenerReturn ZoneDefenseConcealmentListener(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState_Unit ConcealmentBrokenUnit;
	local StateObjectReference CloseCombatSpecialistRef;
	local XComGameState_Ability CloseCombatSpecialistState;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;

	ConcealmentBrokenUnit = XComGameState_Unit(EventSource);	
	if (ConcealmentBrokenUnit == None)
		return ELR_NoInterrupt;

	//Do not trigger if the CloseCombatSpecialist soldier himself moved to cause the concealment break - only when an enemy moved and caused it.
	AbilityContext = XComGameStateContext_Ability(GameState.GetContext().GetFirstStateInEventChain().GetContext());
	if (AbilityContext != None && AbilityContext.InputContext.SourceObject != ConcealmentBrokenUnit.ConcealmentBrokenByUnitRef)
		return ELR_NoInterrupt;

	CloseCombatSpecialistRef = ConcealmentBrokenUnit.FindAbility('LW2WotC_CloseCombatSpecialistAttack');
	if (CloseCombatSpecialistRef.ObjectID == 0)
		return ELR_NoInterrupt;

	CloseCombatSpecialistState = XComGameState_Ability(History.GetGameStateForObjectID(CloseCombatSpecialistRef.ObjectID));
	if (CloseCombatSpecialistState == None)
		return ELR_NoInterrupt;
	
	CloseCombatSpecialistState.AbilityTriggerAgainstSingleTarget(ConcealmentBrokenUnit.ConcealmentBrokenByUnitRef, false);
	return ELR_NoInterrupt;
}


// Sweep and Clear: [default: Once] per turn, get one non-movement (RunAndGunActionPoint) action refunded after killing a stunned or disoriented enemy within CQB range
static function X2AbilityTemplate WOTC_APA_SweepAndClear()
{
	
	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_AssaultActionRefunds				ActionEffect;
	

	Template = CreatePassiveAbility('WOTC_APA_SweepAndClear', "img:///UILibrary_WOTC_APA_Class_Pack.perk_SweepAndClear");


	ActionEffect = new class'X2Effect_WOTC_APA_AssaultActionRefunds';
	ActionEffect.EffectName = 'WOTC_APA_AssaultActionRefundsEffect';
	ActionEffect.DuplicateResponse = eDupe_Ignore;
	ActionEffect.BuildPersistentEffect(1, true, false);
	Template.AddTargetEffect(ActionEffect);


	return Template;
}


// Roving Warrior: Standard shots no longer end the turn when Run-And-Gun is activated (handled in the Run-And-Gun ability)
static function X2AbilityTemplate WOTC_APA_RovingWarrior()
{

	local X2AbilityTemplate										Template;
	
	Template = CreatePassiveAbility('WOTC_APA_RovingWarrior', "img:///UILibrary_WOTC_APA_Class_Pack.perk_RovingWarrior");
	
	return Template;
}


// Relentless: [default: Once] per turn, get one non-movement (RunAndGunActionPoint) action refunded after killing an enemy with a melee attack
static function X2AbilityTemplate WOTC_APA_Relentless()
{
	
	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_AssaultActionRefunds				ActionEffect;
	

	Template = CreatePassiveAbility('WOTC_APA_Relentless', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Relentless");


	ActionEffect = new class'X2Effect_WOTC_APA_AssaultActionRefunds';
	ActionEffect.EffectName = 'WOTC_APA_AssaultActionRefundsEffect';
	ActionEffect.DuplicateResponse = eDupe_Ignore;
	ActionEffect.BuildPersistentEffect(1, true, false);
	Template.AddTargetEffect(ActionEffect);


	return Template;
}


// Take Cover - Passive: Unit may now Hunker Down with movement-only action points and will automatically Hunker Down at the end of the turn if only movement actions were used.
static function X2AbilityTemplate WOTC_APA_TakeCover()
{
	
	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_TakeCover							ActionEffect;
	local X2Effect_Persistent									TriggerEffect;
	

	Template = CreatePassiveAbility('WOTC_APA_TakeCover', "img:///UILibrary_WOTC_APA_Class_Pack.perk_TakeCover");


	// Effect that holds the ELR registers/functions and handles enabling the conditional action point type
	ActionEffect = new class'X2Effect_WOTC_APA_TakeCover';
	ActionEffect.EffectName = 'WOTC_APA_TakeCoverEffect';
	ActionEffect.DuplicateResponse = eDupe_Ignore;
	ActionEffect.BuildPersistentEffect(1, true, false);
	Template.AddTargetEffect(ActionEffect);


	// Persistent effect that evaluates conditions to trigger the HunkerDown ability
	TriggerEffect = new class'X2Effect_Persistent';
	TriggerEffect.BuildPersistentEffect(1, true, false, false, eGameRule_PlayerTurnEnd);
	TriggerEffect.EffectTickedFn = NonMoveActionsThisTurn_EffectTicked;
	TriggerEffect.EffectName = 'WOTC_APA_NonMoveActionsThisTurn_Evaluate';
	TriggerEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(TriggerEffect);


	Template.AdditionalAbilities.AddItem('WOTC_APA_TakeCoverEVOverride');


	return Template;
}

// TakeCoverEVOverride - Passive: Overrides Ever-Vigilant, when present, so that Take Cover can properly trigger both effects
static function X2AbilityTemplate WOTC_APA_TakeCoverEVOverride()
{

	local X2AbilityTemplate							Template;
	local X2Effect_Persistent						VigilantEffect;


	Template = CreatePassiveAbility('WOTC_APA_TakeCoverEVOverride', "img:///UILibrary_WOTC_APA_Class_Pack.perk_TakeCover",, False);


	Template.OverrideAbilities.AddItem('EverVigilantTrigger');


	return Template;
}


// Ever Vigilant - Passive: Unit will automatically enter Overwatch at the end of the turn if only movement actions were used.
static function X2AbilityTemplate WOTC_APA_EverVigilant()
{
	
	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_TakeCover							ActionEffect;
	local X2Effect_Persistent									TriggerEffect;
	

	Template = CreatePassiveAbility('WOTC_APA_EverVigilant', "img:///UILibrary_PerkIcons.UIPerk_evervigilant");


	// Effect that holds the ELR registers/functions and handles enabling the conditional action point type
	ActionEffect = new class'X2Effect_WOTC_APA_TakeCover';
	ActionEffect.EffectName = 'WOTC_APA_TakeCoverEffect';
	ActionEffect.DuplicateResponse = eDupe_Ignore;
	ActionEffect.BuildPersistentEffect(1, true, false);
	Template.AddTargetEffect(ActionEffect);


	// Persistent effect that evaluates conditions to trigger the HunkerDown ability
	TriggerEffect = new class'X2Effect_Persistent';
	TriggerEffect.BuildPersistentEffect(1, true, false, false, eGameRule_PlayerTurnEnd);
	TriggerEffect.EffectTickedFn = NonMoveActionsThisTurn_EffectTicked;
	TriggerEffect.EffectName = 'WOTC_APA_NonMoveActionsThisTurn_Evaluate';
	TriggerEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(TriggerEffect);


	//// Effect that holds the ELR registers/functions
	//ActionEffect = new class'X2Effect_WOTC_APA_EverVigilant';
	//ActionEffect.EffectName = 'WOTC_APA_EverVigilantEffect';
	//ActionEffect.DuplicateResponse = eDupe_Ignore;
	//ActionEffect.BuildPersistentEffect(1, true, false);
	//Template.AddTargetEffect(ActionEffect);


	//// Persistent effect that evaluates conditions to trigger the Overwatch ability
	//TriggerEffect = new class'X2Effect_Persistent';
	//TriggerEffect.BuildPersistentEffect(1, true, false, false, eGameRule_PlayerTurnEnd);
	//TriggerEffect.EffectTickedFn = EverVigilantEffectTicked;
	//TriggerEffect.EffectName = 'WOTC_APA_EverVigilantEvaluate';
	//TriggerEffect.DuplicateResponse = eDupe_Ignore;
	//Template.AddTargetEffect(TriggerEffect);


	return Template;
}

function bool NonMoveActionsThisTurn_EffectTicked(X2Effect_Persistent PersistentEffect, const out EffectAppliedData ApplyEffectParameters, XComGameState_Effect kNewEffectState, XComGameState NewGameState, bool FirstApplication)
{
	local XComGameState_Unit									SourceUnit;
	local UnitValue												NonMoveActionsThisTurn;
	local bool													bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;
	
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	if (SourceUnit != none)
	{
		/*»»»*/`LOG("WOTC_APA_NonMoveActionsThisTurn - End Turn Tick for" @ SourceUnit.GetFullName(), bLog);

		if (SourceUnit.IsImpaired() || SourceUnit.IsPanicked())
		{
			/*»»»*/`LOG("WOTC_APA_NonMoveActionsThisTurn - End Turn Tick - Unit is Impaired or Panicked", bLog);
			return false;
		}

		SourceUnit.GetUnitValue('NonMoveActionsThisTurn', NonMoveActionsThisTurn);
		/*»»»*/`LOG("WOTC_APA_NonMoveActionsThisTurn - End Turn Tick - Non-Movement Actions this turn:" @ int(NonMoveActionsThisTurn.fValue), bLog);

		if (NonMoveActionsThisTurn.fValue == 0)
		{
			// Trigger Take Cover, if present
			if (SourceUnit.HasSoldierAbility('WOTC_APA_TakeCover'))
			{
				/*»»»*/`LOG("WOTC_APA_NonMoveActionsThisTurn - Take Cover! Tick - Unit has Take Cover!... attempting to trigger HunkerDown", bLog);
				`XEVENTMGR.TriggerEvent('WOTC_APA_TakeCoverHunkerTriggered', SourceUnit, SourceUnit, NewGameState);
			}

			// Trigger Ever Vigilant, if present
			if (SourceUnit.HasSoldierAbility('EverVigilant') || SourceUnit.HasSoldierAbility('WOTC_APA_EverVigilant'))
			{
				/*»»»*/`LOG("WOTC_APA_NonMoveActionsThisTurn - Ever Vigilant Tick - Unit has Ever Vigilant... attempting to trigger Overwatch", bLog);
				`XEVENTMGR.TriggerEvent('WOTC_APA_EverVigilantOverwatchTriggered', SourceUnit, SourceUnit, NewGameState);
			}
	}	}
	
	return false;	// do not end the effect
}

//function bool EverVigilantEffectTicked(X2Effect_Persistent PersistentEffect, const out EffectAppliedData ApplyEffectParameters, XComGameState_Effect kNewEffectState, XComGameState NewGameState, bool FirstApplication)
//{
	//local XComGameState_Unit									SourceUnit;
	//local UnitValue												NonMoveActionsThisTurn;
	//local bool													bLog;
//
	//bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;
//
	//if (FirstApplication)
		//return false;
//
	//SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	//if (SourceUnit != none)
	//{
		///*»»»*/`LOG("WOTC_APA_EverVigilant Tick for" @ SourceUnit.GetFullName(), bLog);
//
		//if (SourceUnit.HasSoldierAbility('WOTC_APA_TakeCover'))
		//{
			///*»»»*/`LOG("WOTC_APA_EverVigilant Tick - Unit has the Take Cover! ability - Letting it handle triggering the effect", bLog);
			//return false;
		//}
//
		//if (SourceUnit.IsImpaired() || SourceUnit.IsPanicked())
		//{
			///*»»»*/`LOG("WOTC_APA_EverVigilant Tick - Unit is Impaired or Panicked", bLog);
			//return false;
		//}
//
		//SourceUnit.GetUnitValue('NonMoveActionsThisTurn', NonMoveActionsThisTurn);
		///*»»»*/`LOG("WOTC_APA_EverVigilant Tick - Non-Movement Actions this turn:" @ int(NonMoveActionsThisTurn.fValue), bLog);
//
		//if (NonMoveActionsThisTurn.fValue == 0)
		//{
			///*»»»*/`LOG("WOTC_APA_EverVigilant Tick - attempting to trigger Overwatch", bLog);
			//`XEVENTMGR.TriggerEvent('WOTC_APA_EverVigilantTriggered', SourceUnit, SourceUnit, NewGameState);
	//}	}
	//
	//return false;	// do not end the effect
//}


// Slip Into Position: Grants Phantom and a conditional detection radius reduction
static function X2AbilityTemplate WOTC_APA_SlipIntoPosition()
{
	
	local X2AbilityTemplate										Template;
	local X2Effect_Persistent									ConcealEffect;
	local X2Effect_WOTC_APA_SlipIntoPosition					BonusEffect;
	

	Template = CreatePassiveAbility('WOTC_APA_SlipIntoPosition', "img:///UILibrary_WOTC_APA_Class_Pack.perk_SlipIntoPosition");


	// Create effect to keep target unit concealed
	ConcealEffect = new class'X2Effect_StayConcealed';
	ConcealEffect.BuildPersistentEffect(1, true, false);
	ConcealEffect.EffectName = 'WOTC_APA_SlipIntoPosition_RetainIndividualConcealmentEffect';
	Template.AddTargetEffect(ConcealEffect);


	// Create effect to conditionally reduce enemy's detection radius
	BonusEffect = new class'X2Effect_WOTC_APA_SlipIntoPosition';
	BonusEffect.EffectName = 'WOTC_APA_SlipIntoPositionEffect';
	BonusEffect.DuplicateResponse = eDupe_Ignore;
	BonusEffect.BuildPersistentEffect(1, true, false);
	Template.AddTargetEffect(BonusEffect);


	return Template;
}


// Evasive: Gain a bonus to Dodge based on the number of tiles moved each turn
static function X2AbilityTemplate WOTC_APA_Evasive()
{

	local X2AbilityTemplate										Template;
	local X2AbilityTrigger_EventListener						EventListener;
	local X2Effect_WOTC_APA_Evasive								DodgeEffect;
	

	Template = CreatePassiveAbility('WOTC_APA_Evasive', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Evasive");
	Template.AbilityTriggers.Length = 0;


	// This ability triggers at the end of each turn
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = 'PlayerTurnEnd';
	EventListener.ListenerData.Filter = eFilter_Player;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	Template.AbilityTriggers.AddItem(EventListener);


	// Create effect to add dodge based on distance between starting and ending tiles
	DodgeEffect = new class'X2Effect_WOTC_APA_Evasive';
	DodgeEffect.EffectName = 'WOTC_APA_EvasiveEffect';
	DodgeEffect.DuplicateResponse = eDupe_Ignore;
	DodgeEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	Template.AddTargetEffect(DodgeEffect);


	return Template;
}


// Hit and Run - Passive: [default: Once] per turn, get a movement-only action refunded after a turn-ending melee attack that kills the target.
static function X2AbilityTemplate WOTC_APA_HitAndRun()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_HitAndRun							ActionEffect;


	Template = CreatePassiveAbility('WOTC_APA_HitAndRun', "img:///UILibrary_WOTC_APA_Class_Pack.perk_HitAndRun");
	

	ActionEffect = new class'X2Effect_WOTC_APA_HitAndRun';
	ActionEffect.HitAndRunActivations = default.HIT_RUN_ACTIVATIONS_PER_TURN;
	ActionEffect.BuildPersistentEffect(1, true, false, false);
	ActionEffect.EffectName = 'WOTC_APA_HitAndRunActionEffect';
	ActionEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(ActionEffect);


	return Template;
}


// Close Combat Specialist:
static function X2AbilityTemplate WOTC_APA_CloseCombatSpecialist()
{
	
	local X2AbilityTemplate										Template;
		
	Template = CreatePassiveAbility('WOTC_APA_CloseCombatSpecialist', "img:///UILibrary_WOTC_APA_Class_Pack.perk_CloseCombatSpecialist");

	// Add the additional abilities required
	Template.AdditionalAbilities.AddItem('WOTC_APA_CloseCombatSpecialistAttack');

	return Template;
}

static function X2AbilityTemplate WOTC_APA_CloseCombatSpecialistAttack()
{
	
	local X2AbilityTemplate									Template;
	local X2AbilityTarget_WOTC_APA_CloseCombatSpecialist	ShotTarget;
	local X2AbilityToHitCalc_StandardAim					ToHitCalc;
	local X2Condition_Visibility							TargetVisibilityCondition;
	local X2AbilityCost_Ammo								AmmoCost;
	local X2AbilityTrigger_EventListener					Trigger;
	//local X2AbilityTrigger_Event							Trigger;
	local X2AbilityTrigger_EventListener					EventListener;
	local X2Effect_Persistent								TrackerEffect;
	local X2Condition_UnitEffectsWithAbilitySource			TrackerCondition;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_CloseCombatSpecialistAttack');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_CloseCombatSpecialist";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.ConcealmentRule = eConceal_Never;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITooltip = false;
	Template.bCrossClassEligible = false;
	Template.bShowActivation = true;


	// Target style, hitcalc, and conditions
	ShotTarget = new class 'X2AbilityTarget_WOTC_APA_CloseCombatSpecialist';
	Template.AbilityTargetStyle = ShotTarget;

	ToHitCalc = new class'X2AbilityToHitCalc_StandardAim';
	ToHitCalc.bReactionFire = true;
	Template.AbilityToHitCalc = ToHitCalc;

	Template.AbilityTargetConditions.AddItem(default.LivingHostileUnitDisallowMindControlProperty);
	Template.AbilityTargetConditions.AddItem(class'X2Ability_DefaultAbilitySet'.static.OverwatchTargetEffectsCondition());
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);	
	Template.AddShooterEffectExclusions();
	
	// Don't trigger when the source is concealed, unless Ambushing
	Template.AbilityShooterConditions.AddItem(new class'X2Condition_WOTC_APA_Class_AmbushCondition');

	// Require normal visibility
	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	TargetVisibilityCondition.bRequireBasicVisibility = true;
	TargetVisibilityCondition.bDisablePeeksOnMovement = true; //Don't use peek tiles for over watch shots	
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);
	
	// Ammo cost and effects
	AmmoCost = new class 'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);

	Template.bAllowAmmoEffects = true;
	Template.bAllowBonusWeaponEffects = true;
	Template.AddTargetEffect(class 'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect());
	

	//  trigger on movement
	Trigger = new class'X2AbilityTrigger_EventListener';
	Trigger.ListenerData.EventID = 'ObjectMoved';
	Trigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	Trigger.ListenerData.Filter = eFilter_None;
	Trigger.ListenerData.EventFn = class'XComGameState_Ability'.static.TypicalOverwatchListener;
	Template.AbilityTriggers.AddItem(Trigger);
	//  trigger on an attack
	Trigger = new class'X2AbilityTrigger_EventListener';
	Trigger.ListenerData.EventID = 'AbilityActivated';
	Trigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	Trigger.ListenerData.Filter = eFilter_None;
	Trigger.ListenerData.EventFn = class'XComGameState_Ability'.static.TypicalAttackListener;
	Template.AbilityTriggers.AddItem(Trigger);

	//// Trigger on movement
	//Trigger = new class'X2AbilityTrigger_Event';
	//Trigger.EventObserverClass = class'X2TacticalGameRuleset_MovementObserver';
	//Trigger.MethodName = 'InterruptGameState';
	//Template.AbilityTriggers.AddItem(Trigger);
	//Trigger = new class'X2AbilityTrigger_Event';
	//Trigger.EventObserverClass = class'X2TacticalGameRuleset_MovementObserver';
	//Trigger.MethodName = 'PostBuildGameState';
	//Template.AbilityTriggers.AddItem(Trigger);
	//
	//// Trigger on an attack
	//Trigger = new class'X2AbilityTrigger_Event';
	//Trigger.EventObserverClass = class'X2TacticalGameRuleset_AttackObserver';
	//Trigger.MethodName = 'InterruptGameState';
	//Template.AbilityTriggers.AddItem(Trigger);

	// It may be the case that enemy movement caused a concealment break, which made a reaction shot applicable - attempt to trigger afterwards
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = 'UnitConcealmentBroken';
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = CloseCombatSpecialistConcealmentListener;
	EventListener.ListenerData.Priority = 55;
	Template.AbilityTriggers.AddItem(EventListener);
	

	// Prevent Close Combat Specialist / Retribution attacks from triggering more than once per target
	TrackerEffect = new class'X2Effect_Persistent';
	TrackerEffect.BuildPersistentEffect(1, false, true, true, eGameRule_PlayerTurnEnd);
	TrackerEffect.EffectName = 'BladestormTarget';
	TrackerEffect.bApplyOnMiss = true;
	Template.AddTargetEffect(TrackerEffect);

	TrackerCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	TrackerCondition.AddExcludeEffect('BladestormTarget', 'AA_DuplicateEffectIgnored');
	Template.AbilityTargetConditions.AddItem(TrackerCondition);


	// Standard interactions with Shadow, Chosen, and the Lost
	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotChosenActivationIncreasePerUse;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;
	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}


static function EventListenerReturn CloseCombatSpecialistConcealmentListener(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState_Unit ConcealmentBrokenUnit;
	local StateObjectReference CloseCombatSpecialistRef;
	local XComGameState_Ability CloseCombatSpecialistState;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;

	ConcealmentBrokenUnit = XComGameState_Unit(EventSource);	
	if (ConcealmentBrokenUnit == None)
		return ELR_NoInterrupt;

	//Do not trigger if the CloseCombatSpecialist soldier himself moved to cause the concealment break - only when an enemy moved and caused it.
	AbilityContext = XComGameStateContext_Ability(GameState.GetContext().GetFirstStateInEventChain().GetContext());
	if (AbilityContext != None && AbilityContext.InputContext.SourceObject != ConcealmentBrokenUnit.ConcealmentBrokenByUnitRef)
		return ELR_NoInterrupt;

	CloseCombatSpecialistRef = ConcealmentBrokenUnit.FindAbility('LW2WotC_CloseCombatSpecialistAttack');
	if (CloseCombatSpecialistRef.ObjectID == 0)
		return ELR_NoInterrupt;

	CloseCombatSpecialistState = XComGameState_Ability(History.GetGameStateForObjectID(CloseCombatSpecialistRef.ObjectID));
	if (CloseCombatSpecialistState == None)
		return ELR_NoInterrupt;
	
	CloseCombatSpecialistState.AbilityTriggerAgainstSingleTarget(ConcealmentBrokenUnit.ConcealmentBrokenByUnitRef, false);
	return ELR_NoInterrupt;
}


DefaultProperties
{
	CQB_DOMINANCE_RADIUS_NAME = "WOTC_APA_CQBDominanceRadius"
	RUN_AND_GUN_COOLDOWN_NAME = "WOTC_APA_RunAndGunCooldown"
	SLIP_INTO_POSITION_BONUS_NAME = "WOTC_APA_SlipIntoPositionBonus"
}