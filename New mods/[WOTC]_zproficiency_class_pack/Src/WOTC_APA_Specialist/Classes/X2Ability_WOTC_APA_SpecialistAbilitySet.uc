
class X2Ability_WOTC_APA_SpecialistAbilitySet extends X2Ability_WOTC_APA_Utilities config(WOTC_APA_SpecialistSkills);

// Protocol Packages Proficiency Level Variables
var config int				PP_I_ABC_PROTOCOL_SHARED_COOLDOWN;
var config int				PP_III_ABC_PROTOCOL_RECHARGE_BONUS;
var config int				PP_III_ABC_PROTOCOL_CHARGE_BONUS;

var config int				ABC_PROTOCOL_COOLDOWN;
var config int				AID_PROTOCOL_INITIAL_CHARGES;
var config int				BLIND_PROTOCOL_INITIAL_CHARGES;
var config int				COMBAT_PROTOCOL_INITIAL_CHARGES;

var config int				AID_PROTOCOL_INITIAL_RECHARGE_TURNS;
var config int				BLIND_PROTOCOL_INITIAL_RECHARGE_TURNS;
var config int				COMBAT_PROTOCOL_INITIAL_RECHARGE_TURNS;

var name					AID_PROTOCOL_RECHARGE_NAME;
var name					BLIND_PROTOCOL_RECHARGE_NAME;
var name					COMBAT_PROTOCOL_RECHARGE_NAME;

var localized string		strProtocolPackages1Name;
var localized string		strProtocolPackages1Desc;
var localized string		strProtocolPackages2Name;
var localized string		strProtocolPackages2Desc;
var localized string		strProtocolPackages3Name;
var localized string		strProtocolPackages3Desc;

// Gremlin Tech Identification and Level Variables
var config array<name>		VALID_WEAPON_CATEGORIES_FOR_GREMLIN_SKILLS;
var config array<name>		VALID_T1_GREMLIN_TECH_NAMES;
var config array<name>		VALID_T2_GREMLIN_TECH_NAMES;
var config array<name>		VALID_T3_GREMLIN_TECH_NAMES;

var config float			AID_PROTOCOL_RADIUS_T1_BASE;
var config float			AID_PROTOCOL_RADIUS_T2_BONUS;
var config float			AID_PROTOCOL_RADIUS_T3_BONUS;

var config float			BLIND_PROTOCOL_RADIUS_T1_BASE;
var config float			BLIND_PROTOCOL_RADIUS_T2_BONUS;
var config float			BLIND_PROTOCOL_RADIUS_T3_BONUS;

var config float			COMBAT_PROTOCOL_RADIUS_T1_BASE;
var config float			COMBAT_PROTOCOL_RADIUS_T2_BONUS;
var config float			COMBAT_PROTOCOL_RADIUS_T3_BONUS;

var config int				COMBAT_PROTOCOL_DAMAGE_T1_BASE;
var config int				COMBAT_PROTOCOL_DAMAGE_T2_BONUS;
var config int				COMBAT_PROTOCOL_DAMAGE_T3_BONUS;

var config int				REMOTE_REPAIR_HP_T1_BASE;
var config int				REMOTE_REPAIR_HP_T2_BONUS;
var config int				REMOTE_REPAIR_HP_T3_BONUS;

// Ability Variables
var config int				FAILSAFE_HACK_BONUS;
var config int				REMOTE_REPAIR_INITIAL_CHARGES;
var config int				AID_PROTOCOL_SMOKE_DEFENSE;
var config int				AID_PROTOCOL_SMOKE_DURATION;
var config float			COMBAT_PROTOCOL_MECH_DAMAGE_MULTIPLIER;

var config int				ADAPTIVE_PLATING_ABLATIVE;
var config int				ADAPTIVE_PLATING_ARMOR;
var config int				SURVEILLANCE_FREE_BATTLESCANNERS;
var config int				SURVEILLANCE_BONUS_BATTLESCANNERS;
var config array<name>		SURVEILLANCE_BONUS_VALID_ITEMS;
var config float			OVERLOAD_MECH_DAMAGE_MULTIPLIER;
var config int				OVERLOAD_NON_MECH_DAMAGE_BONUS;
var config int				OVERLOAD_RECHARGE_TURN_PENALTY;
var config float			SILENT_MOTORS_DETECTION_BONUS;
var config float			SILENT_MOTORS_DETECTION_PENALTY;
var config int				DISRUPTION_FIELD_BONUS_DEFENSE;
var config int				DISRUPTION_FIELD_COOLDOWN;
var config int				PSIONIC_FEEDBACK_VULNERABLE_PANIC_CHANCE;
var config int				PSIONIC_FEEDBACK_NORMAL_PANIC_CHANCE;
var config int				PSIONIC_FEEDBACK_RESISTANT_PANIC_CHANCE;
var config float			PSIONIC_FEEDBACK_T2_GREMLIN_MULTIPLIER;
var config float			PSIONIC_FEEDBACK_T3_GREMLIN_MULTIPLIER;
var config float			PSIONIC_FEEDBACK_UNACTIVATED_MULTIPLIER;
var config array<name>		PSIONIC_FEEDBACK_VULNERABLE_ENEMY_TYPES;
var config array<name>		PSIONIC_FEEDBACK_NORMAL_ENEMY_TYPES;
var config array<name>		PSIONIC_FEEDBACK_RESISTANT_ENEMY_TYPES;
var config array<name>		PSIONIC_FEEDBACK_IMMUNE_ENEMY_TYPES;
var config float			NEUTRALIZING_AGENTS_BONUS_RADIUS;
var config int				NEUTRALIZING_AGENTS_IMMUNITY_DURATION;
var config int				ANTI_ARMOR_MECH_BONUS_CRIT;
var config int				ANTI_ARMOR_RIFLE_MOBILITY_PENALTY;
var config array<name>		ANTI_ARMOR_RIFLE_CATEGORIES;
var config int				ELECTRONIC_WARFARE_FREE_FAILSAFE;
var config int				ELECTRONIC_WARFARE_BONUS_HACKING;
var config int				TARGETING_UPLINK_COOLDOWN;
var config float			TARGETING_UPLINK_RANGE_PENALTY_NEGATED;
var config int				TARGETING_UPLINK_CRIT_BONUS_PER_TECH_LVL;
var config int				EMP_SHOCKWAVE_HACK_DEFENSE_REDUCTION;
var config int				EMP_SHOCKWAVE_SHUTDOWN_CHANCE;
var config int				ADVANCED_REPAIR_BONUS_REPAIR_CHARGES;
var config int				ADVANCED_REPAIR_ARMOR_RESTORED;
var config int				ADVANCED_REPAIR_CONTROL_TURNS_BONUS;
var config int				MINIATURIZED_MUNITIONS_BONUS_CHARGES;
var config float			MINIATURIZED_MUNITIONS_DAMAGE_MODIFIER;
var config int				ADVANCED_ROBOTICS_ABC_PROTOCOL_CHARGE_BONUS;
var config int				ADVANCED_ROBOTICS_ABC_PROTOCOL_RECHARGE_BONUS;
var config int				FULL_OVERRIDE_INITIAL_CHARGES;

var config int				SPRINT_COOLDOWN;
var config int				HOT_CHARGED_BATTERIES_CHARGE_BONUS;
var config int				HOT_CHARGED_BATTERIES_RECHARGE_PENALTY;
var config int				UPGRADED_SCANNERS_DURATION;
var config int				UPGRADED_SCANNERS_AIM_BONUS;
var config int				UPGRADED_SCANNERS_CRIT_BONUS;

var localized string		strProtocolSquadConcealmentBrokenFlyover;
var localized string		strAidProtocolDefenseEffectName;
var localized string		strAidProtocolDefenseEffectDesc;
var localized string		strNeutralizingAgentsEffectName;
var localized string		strNeutralizingAgentsEffectDesc;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	/**/`Log("WOTC_APA_Specialist - Begin Adding Templates");

	Templates.AddItem(WOTC_APA_ProtocolPackages());
	/*»»»*/	Templates.AddItem(WOTC_APA_AidProtocol());
	/*»»»*/	Templates.AddItem(WOTC_APA_BlindingProtocol());
	/*»»»*/	Templates.AddItem(WOTC_APA_CombatProtocol());
	/*»»»*/	Templates.AddItem(WOTC_APA_Failsafe());
	/*»»»*/	Templates.AddItem(WOTC_APA_T1GremlinIndicator());
	/*»»»*/	Templates.AddItem(WOTC_APA_T2GremlinIndicator());
	/*»»»*/	Templates.AddItem(WOTC_APA_T3GremlinIndicator());
	Templates.AddItem(WOTC_APA_RemoteRepair());

	Templates.AddItem(WOTC_APA_AdaptiveAlloyPlating());
	/*»»»*/	Templates.AddItem(WOTC_APA_AdaptiveAlloyPlatingRegen());
	Templates.AddItem(WOTC_APA_ElectronicSurveillance());
	// WOTC_APA_LowProfile:		Defined in MedicAbilitySet

	Templates.AddItem(WOTC_APA_Overload());
	Templates.AddItem(WOTC_APA_SilentMotors());
	/*»»»*/	Templates.AddItem(WOTC_APA_SilentMotorsApplyDetectionPenalty());
	Templates.AddItem(WOTC_APA_ExtendedRange());

	Templates.AddItem(WOTC_APA_DisruptionField());
	Templates.AddItem(WOTC_APA_PsionicFeedback());
	Templates.AddItem(WOTC_APA_NeutralizingAgents());

	Templates.AddItem(WOTC_APA_AntiArmor());
	/*»»»*/	Templates.AddItem(WOTC_APA_AntiArmorUpgunned());
	Templates.AddItem(WOTC_APA_ElectronicWarfare());
	Templates.AddItem(WOTC_APA_TargetingUplink());

	Templates.AddItem(WOTC_APA_Marauder());
	Templates.AddItem(WOTC_APA_EMPShockwave());
	Templates.AddItem(WOTC_APA_AdvancedRepair());

	Templates.AddItem(WOTC_APA_MiniaturizedMunitions());
	Templates.AddItem(WOTC_APA_AdvancedRobotics());
	Templates.AddItem(WOTC_APA_FullOverride());
	/*»»»*/	Templates.AddItem(WOTC_APA_CancelFullOverride());
	/*»»»*/	Templates.AddItem(WOTC_APA_FinalizeFullOverride());
	/*»»»*/	Templates.AddItem(HackRewardSelfDestruct_WOTC_APA_FullOverride());
	///*»»»*/	Templates.AddItem(HackRewardShutdownRobot_WOTC_APA_FullOverride_Kill());
	/*»»»*/	Templates.AddItem(HackRewardControlRobot_WOTC_APA_FullOverride());

	Templates.AddItem(WOTC_APA_Sprint());
	Templates.AddItem(WOTC_APA_HotChargedBatteries());
	Templates.AddItem(WOTC_APA_FailsafeOneFree());
	Templates.AddItem(WOTC_APA_UpgradedScanners());

	/**/`Log("WOTC_APA_Specialist - Finished Adding Templates");

	return Templates;
}


// Protocol Package - Base Class Proficiency Ability
static function X2AbilityTemplate WOTC_APA_ProtocolPackages()
{
	
	local X2AbilityTemplate									Template;
	local X2Condition_WOTC_APA_Class_TargetRankRequirement	RankCondition1, RankCondition2, RankCondition2AndUp, RankCondition3;
	local X2Effect_WOTC_APA_SetProtocolRechargeCooldown		SetProtocolRecharge;
	local X2Effect_SetUnitValue								SetUnitValueA, SetUnitValueB, SetUnitValueC;
	local X2Effect_IncrementUnitValue						ModifyUnitValueA, ModifyUnitValueB, ModifyUnitValueC;
	local X2Effect_WOTC_APA_Class_ModifyAbilityCharges		ABCChargeBonus1, ABCChargeBonus2, ABCChargeBonus3;
	local X2Effect_WOTC_APA_Class_AddAbilitiesToTarget		AbilityEffect;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_ProtocolPackages');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_ProtocolPackages"; 
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
	RankCondition1.LogEffectName = "Protocol Packages 1";	// EffectName to use in logs
	RankCondition1.ExcludeProject = 'WOTC_APA_SpecialistUnlock1';

	RankCondition2 = new class 'X2Condition_WOTC_APA_Class_TargetRankRequirement';
	RankCondition2.iMinRank = 3;
	RankCondition2.iMaxRank = 5;
	RankCondition2.LogEffectName = "Protocol Packages 2";
	RankCondition2.ExcludeProject = 'WOTC_APA_SpecialistUnlock2';
	RankCondition2.GiveProject = 'WOTC_APA_SpecialistUnlock1';

	RankCondition2AndUp = new class 'X2Condition_WOTC_APA_Class_TargetRankRequirement';
	RankCondition2AndUp.iMinRank = 3;
	RankCondition2AndUp.iMaxRank = -1;
	RankCondition2AndUp.LogEffectName = "Protocol Packages 2+";
	RankCondition2AndUp.GiveProject = 'WOTC_APA_SpecialistUnlock1';

	RankCondition3 = new class 'X2Condition_WOTC_APA_Class_TargetRankRequirement';
	RankCondition3.iMinRank = 6;
	RankCondition3.iMaxRank = -1;	// No max rank for level 3 bonuses
	RankCondition3.LogEffectName = "Protocol Packages 3";
	RankCondition3.GiveProject = 'WOTC_APA_SpecialistUnlock2';


	// Setup ABC Protocol recharge effect and initial cooldowns
	SetProtocolRecharge = new class'X2Effect_WOTC_APA_SetProtocolRechargeCooldown';
	SetProtocolRecharge.BuildPersistentEffect (1, true, false, false);
	SetProtocolRecharge.AddAbilityRechargeEntry('WOTC_APA_AidProtocol', default.AID_PROTOCOL_RECHARGE_NAME);
	SetProtocolRecharge.AddAbilityRechargeEntry('WOTC_APA_BlindingProtocol', default.BLIND_PROTOCOL_RECHARGE_NAME);
	SetProtocolRecharge.AddAbilityRechargeEntry('WOTC_APA_CombatProtocol', default.COMBAT_PROTOCOL_RECHARGE_NAME);
	Template.AddTargetEffect(SetProtocolRecharge);

	SetUnitValueA = new class'X2Effect_SetUnitValue';
	SetUnitValueA.UnitName = default.AID_PROTOCOL_RECHARGE_NAME;
	SetUnitValueA.NewValueToSet = default.AID_PROTOCOL_INITIAL_RECHARGE_TURNS;
	SetUnitValueA.CleanupType = eCleanup_BeginTactical;
	Template.AddTargetEffect(SetUnitValueA);

	SetUnitValueB = new class'X2Effect_SetUnitValue';
	SetUnitValueB.UnitName = default.BLIND_PROTOCOL_RECHARGE_NAME;
	SetUnitValueB.NewValueToSet = default.BLIND_PROTOCOL_INITIAL_RECHARGE_TURNS;
	SetUnitValueB.CleanupType = eCleanup_BeginTactical;
	Template.AddTargetEffect(SetUnitValueB);

	SetUnitValueC = new class'X2Effect_SetUnitValue';
	SetUnitValueC.UnitName = default.COMBAT_PROTOCOL_RECHARGE_NAME;
	SetUnitValueC.NewValueToSet = default.COMBAT_PROTOCOL_INITIAL_RECHARGE_TURNS;
	SetUnitValueC.CleanupType = eCleanup_BeginTactical;
	Template.AddTargetEffect(SetUnitValueC);


	// Setup decreased ABC Protocol recharge cooldowns
	ModifyUnitValueA = new class'X2Effect_IncrementUnitValue';
	ModifyUnitValueA.UnitName = default.AID_PROTOCOL_RECHARGE_NAME;
	ModifyUnitValueA.NewValueToSet = -(default.PP_III_ABC_PROTOCOL_RECHARGE_BONUS);
	ModifyUnitValueA.CleanupType = eCleanup_BeginTactical;
	ModifyUnitValueA.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(ModifyUnitValueA);

	ModifyUnitValueB = new class'X2Effect_IncrementUnitValue';
	ModifyUnitValueB.UnitName = default.BLIND_PROTOCOL_RECHARGE_NAME;
	ModifyUnitValueB.NewValueToSet = -(default.PP_III_ABC_PROTOCOL_RECHARGE_BONUS);
	ModifyUnitValueB.CleanupType = eCleanup_BeginTactical;
	ModifyUnitValueB.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(ModifyUnitValueB);

	ModifyUnitValueC = new class'X2Effect_IncrementUnitValue';
	ModifyUnitValueC.UnitName = default.COMBAT_PROTOCOL_RECHARGE_NAME;
	ModifyUnitValueC.NewValueToSet = -(default.PP_III_ABC_PROTOCOL_RECHARGE_BONUS);
	ModifyUnitValueC.CleanupType = eCleanup_BeginTactical;
	ModifyUnitValueC.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(ModifyUnitValueC);


	// Setup additional Protocol charge bonuses and the correct passive icon/description for each proficiency level
	ABCChargeBonus1 = new class 'X2Effect_WOTC_APA_Class_ModifyAbilityCharges';
	ABCChargeBonus1.BuildPersistentEffect (1, true, false, false);
	ABCChargeBonus1.SetDisplayInfo(ePerkBuff_Passive, default.strProtocolPackages1Name, default.strProtocolPackages1Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_ProtocolPackages1", true,, Template.AbilitySourceName);
	ABCChargeBonus1.TargetConditions.AddItem(RankCondition1);
	Template.AddTargetEffect(ABCChargeBonus1);

	ABCChargeBonus2 = new class 'X2Effect_WOTC_APA_Class_ModifyAbilityCharges';
	ABCChargeBonus2.BuildPersistentEffect (1, true, false, false);
	ABCChargeBonus2.SetDisplayInfo(ePerkBuff_Passive, default.strProtocolPackages2Name, default.strProtocolPackages2Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_ProtocolPackages2", true,, Template.AbilitySourceName);
	ABCChargeBonus2.TargetConditions.AddItem(RankCondition2);
	Template.AddTargetEffect(ABCChargeBonus2);

	ABCChargeBonus3 = new class 'X2Effect_WOTC_APA_Class_ModifyAbilityCharges';
	ABCChargeBonus3.AbilitiesToModify.AddItem('WOTC_APA_AidProtocol');
	ABCChargeBonus3.AbilitiesToModify.AddItem('WOTC_APA_BlindingProtocol');
	ABCChargeBonus3.AbilitiesToModify.AddItem('WOTC_APA_CombatProtocol');
	ABCChargeBonus3.iChargeModifier = default.PP_III_ABC_PROTOCOL_CHARGE_BONUS;
	ABCChargeBonus3.BuildPersistentEffect (1, true, false, false);
	ABCChargeBonus3.SetDisplayInfo(ePerkBuff_Passive, default.strProtocolPackages3Name, default.strProtocolPackages3Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_ProtocolPackages3", true,, Template.AbilitySourceName);
	ABCChargeBonus3.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(ABCChargeBonus3);


	// Setup additional abilities to add at the correct proficiency levels
	AbilityEffect = new class'X2Effect_WOTC_APA_Class_AddAbilitiesToTarget';
	AbilityEffect.AddAbilities.AddItem('HaywireProtocol');
	AbilityEffect.AddAbilities.AddItem('WOTC_APA_RemoteRepair');
	AbilityEffect.ApplyToWeaponSlot = eInvSlot_SecondaryWeapon;
	AbilityEffect.EffectName = 'WOTC_APA_ABCProtocols_DoNotConsumeAllActionsEffect';
	AbilityEffect.TargetConditions.AddItem(RankCondition2AndUp);
	Template.AddTargetEffect(AbilityEffect);


	// Add the abilities that manage Gremlin Tech bonuses
	Template.AdditionalAbilities.AddItem('WOTC_APA_T1GremlinIndicator');
	Template.AdditionalAbilities.AddItem('WOTC_APA_T2GremlinIndicator');
	Template.AdditionalAbilities.AddItem('WOTC_APA_T3GremlinIndicator');


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}



// Aid Protocol - Deploy a defensive smoke screen on a targeted ally
static function X2AbilityTemplate WOTC_APA_AidProtocol()
{
	
	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;
	local X2Condition_Visibility								VisCondition;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2AbilityCharges										Charges;
	local X2AbilityCost_Charges									ChargeCost;
	local X2AbilityCooldown										Cooldown;
	local X2Condition_WOTC_APA_Class_EffectRequirement			CooldownCondition;
	local X2Effect_WOTC_APA_ProtocolSharedCooldown				SharedCooldown;
	local X2Condition_UnitProperty								TargetProperty;
	local X2AbilityTarget_Single								PrimaryTarget;
	local X2AbilityMultiTarget_Radius							RadiusMultiTarget;
	local X2Effect_ApplySmokeGrenadeToWorld						SmokeEffect;
	//local X2Effect_WOTC_APA_AidProtocolSmoke					SmokeEffect;
	local X2Condition_WOTC_APA_Class_AbilityRequirement			HasBonusAbility;
	//local X2Condition_WOTC_APA_Class_SourceAbilityRequirement	NoBonusAbility;
	//local X2Effect_WOTC_APA_ApplyAidProtocolSmokeToWorld		SmokeEffect;
	//local X2Effect_WOTC_APA_ApplyNeutralizingAgentsSmokeToWorld	SmokeEffectPlus;
	//local X2Effect_WOTC_APA_AidProtocolDefense					DefenseEffect;
	//local X2Effect_WOTC_APA_NeutralizingAgentsDamageImmunity	DamageImmunity;
	local X2Effect_DamageImmunity								DamageImmunity;
	local X2Effect_RemoveEffectsByDamageType					ClenseEffect;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_AidProtocol');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_AidProtocol"; 
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY + 1;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Defensive;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.bLimitTargetIcons = true;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.bStationaryWeapon = true;
	Template.CustomSelfFireAnim = 'NO_SmokescreenProtocol';
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.bCrossClassEligible = false;


	// Costs, Conditions, and Requirements:
	// A Gremlin must be equipped in the inventory slot the ability is assigned to
	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories.AddItem('gremlin');
	Template.AbilityShooterConditions.AddItem(WeaponCondition);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	// Target must be a living ally
	TargetProperty = new class'X2Condition_UnitProperty';
	TargetProperty.ExcludeDead = true;
	TargetProperty.ExcludeHostileToSource = true;
	TargetProperty.ExcludeFriendlyToSource = false;
	TargetProperty.RequireSquadmates = true;
	Template.AbilityTargetConditions.AddItem(TargetProperty);

	// Visibility/Range restrictions and Targeting
	VisCondition = new class'X2Condition_Visibility';
	VisCondition.bRequireGameplayVisible = true;
	VisCondition.bActAsSquadsight = true;
	Template.AbilityTargetConditions.AddItem(VisCondition);

	Template.AbilityTargetConditions.AddItem(new class'X2Condition_WOTC_APA_ExtendedProtocolVisibility');

	PrimaryTarget = new class'X2AbilityTarget_Single';
	PrimaryTarget.OnlyIncludeTargetsInsideWeaponRange = false;
	PrimaryTarget.bAllowInteractiveObjects = false;
	PrimaryTarget.bAllowDestructibleObjects = false;
	PrimaryTarget.bIncludeSelf = true;
	PrimaryTarget.bShowAOE = true;
	Template.AbilityTargetSTyle = PrimaryTarget;

	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	//RadiusMultiTarget.bAddPrimaryTargetAsMultiTarget = true;
	RadiusMultiTarget.bIgnoreBlockingCover = true;
	RadiusMultiTarget.bAllowDeadMultiTargetUnits = false;
	RadiusMultiTarget.bExcludeSelfAsTargetIfWithinRadius = false;
	RadiusMultiTarget.bUseWeaponRadius = false;
	RadiusMultiTarget.fTargetRadius = 1.5 * (default.AID_PROTOCOL_RADIUS_T1_BASE + 0.1);
	RadiusMultiTarget.AddAbilityBonusRadius('WOTC_APA_T2GremlinIndicator', 1.5 * default.AID_PROTOCOL_RADIUS_T2_BONUS);
	RadiusMultiTarget.AddAbilityBonusRadius('WOTC_APA_T3GremlinIndicator', 1.5 * default.AID_PROTOCOL_RADIUS_T3_BONUS);
	RadiusMultiTarget.AddAbilityBonusRadius('WOTC_APA_NeutralizingAgents', 1.5 * default.NEUTRALIZING_AGENTS_BONUS_RADIUS);
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;

	Template.TargetingMethod = class'X2TargetingMethod_HomingMine';


	// Ability's Action Point cost and Cooldown
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.DoNotConsumeAllEffects.AddItem('WOTC_APA_ABCProtocols_DoNotConsumeAllActionsEffect');
	Template.AbilityCosts.AddItem(ActionPointCost);	

	Charges = new class 'X2AbilityCharges';
	Charges.InitialCharges = default.AID_PROTOCOL_INITIAL_CHARGES;
	Template.AbilityCharges = Charges;

	ChargeCost = new class'X2AbilityCost_Charges';
	ChargeCost.NumCharges = 1;
	Template.AbilityCosts.AddItem(ChargeCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.ABC_PROTOCOL_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	CooldownCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	CooldownCondition.bCheckSourceUnit = true;
	CooldownCondition.ExcludingEffectNames.AddItem('WOTC_APA_ABCProtocols_NoSharedCooldownEffect');

	SharedCooldown = new class'X2Effect_WOTC_APA_ProtocolSharedCooldown';
	SharedCooldown.AbilitiesToSet.AddItem('WOTC_APA_BlindingProtocol');
	SharedCooldown.AbilitiesToSet.AddItem('WOTC_APA_CombatProtocol');
	SharedCooldown.SetCooldownTo = default.ABC_PROTOCOL_COOLDOWN;
	SharedCooldown.TargetConditions.AddItem(CooldownCondition);
	Template.AddShooterEffect(SharedCooldown);


	// Setup defense and clensing effects - either a basic or improved set of effects will be used, depending on the presense of Neutralizing Agents
	//SmokeEffect = new class'X2Effect_WOTC_APA_AidProtocolSmoke';
	//SmokeEffect.SmokeParticleSystemFill_Name = "PerkFX_WOTC_APA_Class_Pack.P_Aid_Protocol_Smoke_Fill";
	//SmokeEffect.Duration = default.AID_PROTOCOL_SMOKE_DURATION;
	//SmokeEffect.TargetConditions.AddItem(NoBonusAbility);
	SmokeEffect = new class'X2Effect_ApplySmokeGrenadeToWorld';
	SmokeEffect.SmokeParticleSystemFill_Name = "PerkFX_WOTC_APA_Class_Pack.P_Aid_Protocol_Smoke_Fill2";
	Template.AddMultiTargetEffect(SmokeEffect);

	Template.AddTargetEffect(class'X2Item_DefaultGrenades'.static.SmokeGrenadeEffect());
	Template.AddMultiTargetEffect(class'X2Item_DefaultGrenades'.static.SmokeGrenadeEffect());

	HasBonusAbility = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
	HasBonusAbility.bCheckSourceUnit = true;
	HasBonusAbility.RequiredAbilityNames.AddItem('WOTC_APA_NeutralizingAgents');
	HasBonusAbility.LogEffectName = "WOTC_APA_AidProtocol - Add Bonuses from Neutralizing Agents";

	//NoBonusAbility = new class'X2Condition_WOTC_APA_Class_SourceAbilityRequirement';
	//NoBonusAbility.ExcludingAbilityNames.AddItem('WOTC_APA_NeutralizingAgents');
	//NoBonusAbility.LogEffectName = "WOTC_APA_AidProtocol - Add Bonuses from Neutralizing Agents";

	//SmokeEffect = new class'X2Effect_WOTC_APA_ApplyAidProtocolSmokeToWorld';
	//SmokeEffect.SmokeParticleSystemFill_Name = "PerkFX_WOTC_APA_Class_Pack.P_Aid_Protocol_Smoke_Fill";
	//SmokeEffect.SmokeParticleSystemFill_Name = "FX_Smoke_Grenade.P_Smoke_Grenade_Fill";
	//SmokeEffect.Duration = default.AID_PROTOCOL_SMOKE_DURATION;
	//SmokeEffect.TargetConditions.AddItem(NoBonusAbility);
	//Template.AddMultiTargetEffect(SmokeEffect);

	//SmokeEffectPlus = new class'X2Effect_WOTC_APA_ApplyNeutralizingAgentsSmokeToWorld';
	//SmokeEffectPlus.TargetConditions.AddItem(HasBonusAbility);
	//Template.AddMultiTargetEffect(SmokeEffectPlus);

	//DefenseEffect = new class'X2Effect_WOTC_APA_AidProtocolDefense';
	//DefenseEffect.BuildPersistentEffect(default.AID_PROTOCOL_SMOKE_DURATION + 1, false, false, false, eGameRule_PlayerTurnBegin);
	//DefenseEffect.SetDisplayInfo(ePerkBuff_Bonus, default.strAidProtocolDefenseEffectName, default.strAidProtocolDefenseEffectDesc, "img:///UILibrary_PerkIcons.UIPerk_smokebomb");
	//Template.AddMultiTargetEffect(DefenseEffect);
	//Template.AddTargetEffect(DefenseEffect);

	//DamageImmunity = new class'X2Effect_WOTC_APA_NeutralizingAgentsDamageImmunity';
	DamageImmunity = new class'X2Effect_DamageImmunity';
	DamageImmunity.BuildPersistentEffect(default.NEUTRALIZING_AGENTS_IMMUNITY_DURATION, false, false, false, eGameRule_PlayerTurnBegin);
	DamageImmunity.SetDisplayInfo(ePerkBuff_Bonus, default.strNeutralizingAgentsEffectName, default.strNeutralizingAgentsEffectDesc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_NeutralizingAgents");
	DamageImmunity.ImmuneTypes.AddItem('Fire');
	DamageImmunity.ImmuneTypes.AddItem('Acid');
	DamageImmunity.ImmuneTypes.AddItem('Poison');
	DamageImmunity.TargetConditions.AddItem(HasBonusAbility);
	Template.AddMultiTargetEffect(DamageImmunity);
	Template.AddTargetEffect(DamageImmunity);

	ClenseEffect = new class'X2Effect_RemoveEffectsByDamageType';
	ClenseEffect.DamageTypesToRemove.AddItem('Fire');
	ClenseEffect.DamageTypesToRemove.AddItem('Acid');
	ClenseEffect.DamageTypesToRemove.AddItem('Poison');
	ClenseEffect.TargetConditions.AddItem(HasBonusAbility);
	Template.AddMultiTargetEffect(ClenseEffect);
	Template.AddTargetEffect(ClenseEffect);


	Template.ConcealmentRule = eConceal_Always;
	Template.AddShooterEffect(new class'X2Effect_WOTC_APA_ProtocolBreakConcealment');
	

	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.NonAggressiveChosenActivationIncreasePerUse;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;


	Template.BuildVisualizationFn = ProtocolSingleTargetB_BuildVisualization;
	Template.BuildNewGameStateFn = class'X2Ability_SpecialistAbilitySet'.static.AttachGremlinToTarget_BuildGameState;
	//Template.BuildVisualizationFn = class'X2Ability_SpecialistAbilitySet'.static.GremlinScanningProtocol_BuildVisualization;
	//Template.BuildVisualizationFn = class'X2Ability_SpecialistAbilitySet'.static.GremlinSingleTarget_BuildVisualization;
	Template.PostActivationEvents.AddItem('ItemRecalled');
	return Template;
}



// Blinding Protocol
static function X2AbilityTemplate WOTC_APA_BlindingProtocol()
{
	
	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;
	local X2Condition_Visibility								VisCondition;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2AbilityCharges										Charges;
	local X2AbilityCost_Charges									ChargeCost;
	local X2AbilityCooldown										Cooldown;
	local X2Condition_WOTC_APA_Class_EffectRequirement			CooldownCondition;
	local X2Effect_WOTC_APA_ProtocolSharedCooldown				SharedCooldown;
	local X2Condition_UnitProperty								TargetProperty;
	local X2AbilityTarget_Single								PrimaryTarget;
	local X2AbilityMultiTarget_Radius							RadiusMultiTarget;
	local X2Effect_Panicked										PanickedEffect;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_BlindingProtocol');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_BlindingProtocol"; 
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY + 2;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.bLimitTargetIcons = true;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.bStationaryWeapon = true;
	Template.CustomSelfFireAnim = 'NO_BlindingProtocol';
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.bCrossClassEligible = false;
	

	// Costs, Conditions, and Requirements:
	// A Gremlin must be equipped in the inventory slot the ability is assigned to
	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories.AddItem('gremlin');
	Template.AbilityShooterConditions.AddItem(WeaponCondition);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	// Target must be a non-robotic enemy
	TargetProperty = new class'X2Condition_UnitProperty';
	TargetProperty.ExcludeDead = true;
	TargetProperty.ExcludeHostileToSource = false;
	TargetProperty.ExcludeFriendlyToSource = true;
	TargetProperty.ExcludeRobotic = true;
	Template.AbilityTargetConditions.AddItem(TargetProperty);

	// Visibility/Range restrictions and Targeting
	VisCondition = new class'X2Condition_Visibility';
	VisCondition.bRequireGameplayVisible = true;
	VisCondition.bActAsSquadsight = true;
	Template.AbilityTargetConditions.AddItem(VisCondition);

	Template.AbilityTargetConditions.AddItem(new class'X2Condition_WOTC_APA_ExtendedProtocolVisibility');

	PrimaryTarget = new class'X2AbilityTarget_Single';
	PrimaryTarget.OnlyIncludeTargetsInsideWeaponRange = false;
	PrimaryTarget.bAllowInteractiveObjects = false;
	PrimaryTarget.bAllowDestructibleObjects = false;
	PrimaryTarget.bIncludeSelf = false;
	PrimaryTarget.bShowAOE = true;
	Template.AbilityTargetSTyle = PrimaryTarget;

	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.bIgnoreBlockingCover = true;
	RadiusMultiTarget.bAllowDeadMultiTargetUnits = false;
	RadiusMultiTarget.bUseWeaponRadius = false;
	RadiusMultiTarget.fTargetRadius = 1.5 * default.BLIND_PROTOCOL_RADIUS_T1_BASE;
	RadiusMultiTarget.AddAbilityBonusRadius('WOTC_APA_T2GremlinIndicator', 1.5 * default.BLIND_PROTOCOL_RADIUS_T2_BONUS);
	RadiusMultiTarget.AddAbilityBonusRadius('WOTC_APA_T3GremlinIndicator', 1.5 * default.BLIND_PROTOCOL_RADIUS_T3_BONUS);
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;

	Template.AbilityMultiTargetConditions.AddItem(TargetProperty);
	Template.TargetingMethod = class'X2TargetingMethod_HomingMine';


	// Ability's Action Point cost and Cooldown
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.DoNotConsumeAllEffects.AddItem('WOTC_APA_ABCProtocols_DoNotConsumeAllActionsEffect');
	Template.AbilityCosts.AddItem(ActionPointCost);

	Charges = new class 'X2AbilityCharges';
	Charges.InitialCharges = default.BLIND_PROTOCOL_INITIAL_CHARGES;
	Template.AbilityCharges = Charges;

	ChargeCost = new class'X2AbilityCost_Charges';
	ChargeCost.NumCharges = 1;
	Template.AbilityCosts.AddItem(ChargeCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.ABC_PROTOCOL_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	CooldownCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	CooldownCondition.bCheckSourceUnit = true;
	CooldownCondition.ExcludingEffectNames.AddItem('WOTC_APA_ABCProtocols_NoSharedCooldownEffect');

	SharedCooldown = new class'X2Effect_WOTC_APA_ProtocolSharedCooldown';
	SharedCooldown.AbilitiesToSet.AddItem('WOTC_APA_AidProtocol');
	SharedCooldown.AbilitiesToSet.AddItem('WOTC_APA_CombatProtocol');
	SharedCooldown.SetCooldownTo = default.ABC_PROTOCOL_COOLDOWN;
	SharedCooldown.TargetConditions.AddItem(CooldownCondition);
	Template.AddShooterEffect(SharedCooldown);


	// Apply the Disoriented effect to valid targets
	Template.AddMultiTargetEffect(class'X2StatusEffects'.static.CreateDisorientedStatusEffect(, , false));
	Template.AddTargetEffect(class'X2StatusEffects'.static.CreateDisorientedStatusEffect(, , false));


	// Apply the Panic effect chance if the source has Psionic Feedback
	PanickedEffect = class'X2StatusEffects'.static.CreatePanickedStatusEffect();
	PanickedEffect.ApplyChanceFn = PsionicFeedbackApplyChance;
	Template.AddMultiTargetEffect(PanickedEffect);
	Template.AddTargetEffect(PanickedEffect);


	Template.ConcealmentRule = eConceal_Always;
	Template.AddShooterEffect(new class'X2Effect_WOTC_APA_ProtocolBreakConcealment');

	
	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotChosenActivationIncreasePerUse;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;


	Template.BuildNewGameStateFn = class'X2Ability_SpecialistAbilitySet'.static.AttachGremlinToTarget_BuildGameState;
	Template.BuildVisualizationFn = ProtocolSingleTargetB_BuildVisualization;
	//Template.BuildVisualizationFn = class'X2Ability_SpecialistAbilitySet'.static.GremlinSingleTarget_BuildVisualization;
	Template.PostActivationEvents.AddItem('ItemRecalled');
	return Template;
}

// Function to handle the chance to apply panicked effects from Psionic Feedback
function name PsionicFeedbackApplyChance(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState)
{
	local XComGameState_Unit		SourceUnit, TargetUnit;
	local name						CharacterGroupName;
	local float						fPanicChance, fGremlinMod, RandRoll;
	local bool						bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	TargetUnit = XComGameState_Unit(kNewTargetState);
	if (TargetUnit != none && SourceUnit != none)
	{
		/**/`Log("WOTC_APA_Specialist - Blinding Protocol: Checking for Psionic Feedback Panick (SourceUnit is" @ SourceUnit.GetFullName() $ ")", bLog);

		// SourceUnit must have the Psionic Feedback ability
		if (!SourceUnit.HasSoldierAbility('WOTC_APA_PsionicFeedback'))
		{
			/**/`Log("WOTC_APA_Specialist - Psionic Feedback: SourceUnit does not have the Psionic Feedback ability - stopping.", bLog);
			return 'AA_MissingRequiredEffect';
		}

		// Exclude Robotic enemies
		if (TargetUnit.GetMyTemplate().bIsRobotic)
			return 'AA_UnitIsImmune';

		// Exclude enemies that are immune to mental effects
		if (TargetUnit.GetMyTemplate().ImmuneTypes.Find('Mental') != -1)
			return 'AA_UnitIsImmune';

		/**/`Log("WOTC_APA_Specialist - Psionic Feedback: TargetUnit is not robotic or immune.", bLog);
		fGremlinMod = 1;
		
		// Get Gremlin Tech level modifier (SourceUnit should only ever have one of these abilities at a time)
		if (SourceUnit.HasSoldierAbility('WOTC_APA_T2GremlinIndicator'))
			fGremlinMod = default.PSIONIC_FEEDBACK_T2_GREMLIN_MULTIPLIER;
		
		if (SourceUnit.HasSoldierAbility('WOTC_APA_T3GremlinIndicator'))
			fGremlinMod = default.PSIONIC_FEEDBACK_T3_GREMLIN_MULTIPLIER;

		/**/`Log("WOTC_APA_Specialist - Psionic Feedback: Panick chance multiplier from Gremlin Tech level is" @ fGremlinMod, bLog);

		// Get TargetUnit's CharacterGroupName and determine their vulnerability to the effect
		CharacterGroupName = TargetUnit.GetMyTemplate().CharacterGroupName;

		// Search for Mod-added Captains that cannot be flagged as such (due to base-game bugs) and try to correct for the effect
		if (class'WOTC_APA_Class_Utilities_Effects'.default.MOD_ADDED_CAPTAINS_FLAGGED_AS_OTHERS.Find(TargetUnit.GetMyTemplateName()) != -1)
			CharacterGroupName = 'AdventCaptain';

		/**/`Log("WOTC_APA_Specialist - Psionic Feedback: TargetUnit's CharacterGroupName is" @ CharacterGroupName, bLog);

		if (default.PSIONIC_FEEDBACK_IMMUNE_ENEMY_TYPES.Find(CharacterGroupName) != -1)
			return 'AA_UnitIsImmune';
		
		/**/`Log("WOTC_APA_Specialist - Psionic Feedback: TargetUnit's CharacterGroupName is not configured as immune.", bLog);

		// Default to NORMAL chance for any unhandled enemy types and scale up based on config arrays
		fPanicChance = default.PSIONIC_FEEDBACK_NORMAL_PANIC_CHANCE;
		if (default.PSIONIC_FEEDBACK_RESISTANT_ENEMY_TYPES.Find(CharacterGroupName) != -1)
		{
			fPanicChance = default.PSIONIC_FEEDBACK_RESISTANT_PANIC_CHANCE;
			/**/`Log("WOTC_APA_Specialist - Psionic Feedback: TargetUnit's CharacterGroupName is configured as Resistant.", bLog);
		}

		if (default.PSIONIC_FEEDBACK_NORMAL_ENEMY_TYPES.Find(CharacterGroupName) != -1)
		{
			fPanicChance = default.PSIONIC_FEEDBACK_NORMAL_PANIC_CHANCE;
			/**/`Log("WOTC_APA_Specialist - Psionic Feedback: TargetUnit's CharacterGroupName is configured as Normal.", bLog);
		}

		if (default.PSIONIC_FEEDBACK_VULNERABLE_ENEMY_TYPES.Find(CharacterGroupName) != -1)
		{
			fPanicChance = default.PSIONIC_FEEDBACK_VULNERABLE_PANIC_CHANCE;
			/**/`Log("WOTC_APA_Specialist - Psionic Feedback: TargetUnit's CharacterGroupName is configured as Vulnerable.", bLog);
		}

		// Multiply Panic Chance by Gremlin Tech Multiplier and roll for effect application
		fPanicChance = fPanicChance * fGremlinMod;

		// Multiply Panic Chance by the Unactivated Enemy Multiplier for unactivated enemies (balancing tuner)
		if (TargetUnit.GetCurrentStat(eStat_AlertLevel) < 2)
		{
			fPanicChance = fPanicChance * default.PSIONIC_FEEDBACK_UNACTIVATED_MULTIPLIER;
			/**/`Log("WOTC_APA_Specialist - Psionic Feedback: Enemy unit is unactivated - modifying chance by" @ default.PSIONIC_FEEDBACK_UNACTIVATED_MULTIPLIER, bLog);
		}

		/**/`Log("WOTC_APA_Specialist - Psionic Feedback: Panick chance is" @ fPanicChance, bLog);

		RandRoll = `SYNC_RAND(100);
		/**/`Log("WOTC_APA_Specialist - Psionic Feedback: Panick roll is" @ RandRoll, bLog);

		if (RandRoll < fPanicChance)
			return 'AA_Success';

		return 'AA_EffectChanceFailed';
	}

	return 'AA_NotAUnit';
}


// 
static function X2AbilityTemplate WOTC_APA_CombatProtocol()
{

	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;
	local X2Condition_Visibility								VisCondition;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2AbilityCharges										Charges;
	local X2AbilityCost_Charges									ChargeCost;
	local X2AbilityCooldown										Cooldown;
	local X2Condition_WOTC_APA_Class_EffectRequirement			CooldownCondition;
	local X2Effect_WOTC_APA_ProtocolSharedCooldown				SharedCooldown;
	local X2Condition_UnitProperty								TargetProperty;
	local X2AbilityTarget_Single								PrimaryTarget;
	local X2Effect_WOTC_APA_ApplyWeaponDamage					BaseDmg;
	local X2Condition_WOTC_APA_Class_AbilityRequirement			HasBonusAbility;
	local X2Condition_UnitProperty								RoboticTarget;
	local X2Effect_PersistentStatChange							HackDefenseReductionEffect;
	local X2Effect_WOTC_APA_EMPShockwave						RemoveShieldEffect;
	local X2Effect_Stunned										ShutdownEffect;
	

	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_CombatProtocol');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_CombatProtocol";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY + 3;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Offensive;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.bLimitTargetIcons = true;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.bStationaryWeapon = true;
	Template.CustomSelfFireAnim = 'NO_CombatProtocol';
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.bCrossClassEligible = false;


	// Costs, Conditions, and Requirements:
	// A Gremlin must be equipped in the inventory slot the ability is assigned to
	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories.AddItem('gremlin');
	Template.AbilityShooterConditions.AddItem(WeaponCondition);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	// Target must be an enemy
	TargetProperty = new class'X2Condition_UnitProperty';
	TargetProperty.ExcludeDead = true;
	TargetProperty.ExcludeHostileToSource = false;
	TargetProperty.ExcludeFriendlyToSource = true;
	TargetProperty.TreatMindControlledSquadmateAsHostile = true;
	Template.AbilityTargetConditions.AddItem(TargetProperty);

	// Visibility/Range restrictions and Targeting
	VisCondition = new class'X2Condition_Visibility';
	VisCondition.bRequireGameplayVisible = true;
	VisCondition.bActAsSquadsight = true;
	Template.AbilityTargetConditions.AddItem(VisCondition);

	Template.AbilityTargetConditions.AddItem(new class'X2Condition_WOTC_APA_ExtendedProtocolVisibility');

	PrimaryTarget = new class'X2AbilityTarget_Single';
	PrimaryTarget.OnlyIncludeTargetsInsideWeaponRange = false;
	PrimaryTarget.bAllowInteractiveObjects = false;
	PrimaryTarget.bAllowDestructibleObjects = false;
	PrimaryTarget.bIncludeSelf = false;
	PrimaryTarget.bShowAOE = true;
	Template.AbilityTargetSTyle = PrimaryTarget;
	
	Template.TargetingMethod = class'X2TargetingMethod_HomingMine';


	// Ability's Action Point cost and Cooldown
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.DoNotConsumeAllEffects.AddItem('WOTC_APA_ABCProtocols_DoNotConsumeAllActionsEffect');
	Template.AbilityCosts.AddItem(ActionPointCost);

	Charges = new class 'X2AbilityCharges';
	Charges.InitialCharges = default.COMBAT_PROTOCOL_INITIAL_CHARGES;
	Template.AbilityCharges = Charges;

	ChargeCost = new class'X2AbilityCost_Charges';
	ChargeCost.NumCharges = 1;
	Template.AbilityCosts.AddItem(ChargeCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.ABC_PROTOCOL_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	CooldownCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	CooldownCondition.bCheckSourceUnit = true;
	CooldownCondition.ExcludingEffectNames.AddItem('WOTC_APA_ABCProtocols_NoSharedCooldownEffect');

	SharedCooldown = new class'X2Effect_WOTC_APA_ProtocolSharedCooldown';
	SharedCooldown.AbilitiesToSet.AddItem('WOTC_APA_AidProtocol');
	SharedCooldown.AbilitiesToSet.AddItem('WOTC_APA_BlindingProtocol');
	SharedCooldown.SetCooldownTo = default.ABC_PROTOCOL_COOLDOWN;
	SharedCooldown.TargetConditions.AddItem(CooldownCondition);
	Template.AddShooterEffect(SharedCooldown);


	// Apply the base damage effect to valid targets - Combat Protocol damage bypasses all shields and armor
	BaseDmg = new class'X2Effect_WOTC_APA_ApplyWeaponDamage';
	//BaseDmg.DamageTag = 'WOTC_APA_CombatProtocol_Base';		// Bonus damage based on Gremlin tech level is handled in the Gremlin Tier Indicator abilities
	BaseDmg.EffectDamageValue.Damage = default.COMBAT_PROTOCOL_DAMAGE_T1_BASE;
	BaseDmg.EffectDamageValue.Pierce = 999;
	BaseDmg.EffectDamageValue.DamageType = 'Electrical';
	BaseDmg.bIgnoreBaseDamage = true;
	BaseDmg.bBypassShields = true;
	BaseDmg.bIgnoreArmor = true;
	Template.AddTargetEffect(BaseDmg);


	HasBonusAbility = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
	HasBonusAbility.bCheckSourceUnit = true;
	HasBonusAbility.RequiredAbilityNames.AddItem('WOTC_APA_EMPShockwave');
	HasBonusAbility.LogEffectName = "WOTC_APA_CombatProtocol - Add Bonuses from EMP Shockwave";

	// Target must be a non-robotic enemy
	RoboticTarget = new class'X2Condition_UnitProperty';
	RoboticTarget.ExcludeOrganic = true;

	HackDefenseReductionEffect = class'X2StatusEffects'.static.CreateHackDefenseChangeStatusEffect(default.EMP_SHOCKWAVE_HACK_DEFENSE_REDUCTION, HasBonusAbility);
	HackDefenseReductionEffect.TargetConditions.AddItem(RoboticTarget);
	Template.AddTargetEffect(HackDefenseReductionEffect);

	RemoveShieldEffect = new class'X2Effect_WOTC_APA_EMPShockwave';
	RemoveShieldEffect.TargetConditions.AddItem(HasBonusAbility);
	Template.AddTargetEffect(RemoveShieldEffect);

	ShutdownEffect = class'X2StatusEffects'.static.CreateStunnedStatusEffect(2, default.EMP_SHOCKWAVE_SHUTDOWN_CHANCE, false);
	ShutdownEffect.TargetConditions.AddItem(HasBonusAbility);
	Template.AddTargetEffect(ShutdownEffect);


	Template.ConcealmentRule = eConceal_Always;
	Template.AddShooterEffect(new class'X2Effect_WOTC_APA_ProtocolBreakConcealment');


	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotChosenActivationIncreasePerUse;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;

	
	Template.BuildNewGameStateFn = class'X2Ability_SpecialistAbilitySet'.static.AttachGremlinToTarget_BuildGameState;
	Template.BuildVisualizationFn = ProtocolSingleTarget_BuildVisualization;
	//Template.BuildVisualizationFn = class'X2Ability_SpecialistAbilitySet'.static.GremlinSingleTarget_BuildVisualization;
	Template.PostActivationEvents.AddItem('ItemRecalled');
	return Template;
}



static simulated function ProtocolSingleTarget_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory History;
	local XComGameStateContext_Ability  Context;
	local X2AbilityTemplate             AbilityTemplate, ThreatTemplate;
	local StateObjectReference          InteractingUnitRef;
	local XComGameState_Item			GremlinItem;
	local XComGameState_Unit			TargetUnitState;
	local XComGameState_Unit			AttachedUnitState;
	local XComGameState_Unit			GremlinUnitState, ActivatingUnitState;
	local array<PathPoint> Path;
	local TTile							TargetTile;
	local TTile							StartTile;

	local VisualizationActionMetadata	EmptyTrack;
	local VisualizationActionMetadata	ActionMetadata;
	local X2Action_WaitForAbilityEffect DelayAction;
	local X2Action_AbilityPerkStart		PerkStartAction;
	local X2Action_CameraLookAt			CameraAction;

	local X2Action_PlaySoundAndFlyOver SoundAndFlyOver;
	local int							EffectIndex, i, j;
	local PathingInputData              PathData;
	local PathingResultData				ResultData;
	local X2Action_PlayAnimation		PlayAnimation;

	local X2VisualizerInterface			TargetVisualizerInterface;
	local string						FlyOverText, FlyOverIcon;
	local X2AbilityTag					AbilityTag;

	local X2Action_CameraLookAt			TargetCameraAction;
	local Actor							TargetVisualizer;

	History = `XCOMHISTORY;

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	AbilityTemplate = class'XComGameState_Ability'.static.GetMyTemplateManager().FindAbilityTemplate(Context.InputContext.AbilityTemplateName);

	TargetUnitState = XComGameState_Unit( VisualizeGameState.GetGameStateForObjectID( Context.InputContext.PrimaryTarget.ObjectID ) );

	GremlinItem = XComGameState_Item( History.GetGameStateForObjectID( Context.InputContext.ItemObject.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1 ) );
	if( GremlinItem == none )
	{
		`RedScreen("Attempting GremlinSingleTarget_BuildVisualization with a GremlinItem of none");
		return;
	}

	GremlinUnitState = XComGameState_Unit( History.GetGameStateForObjectID( GremlinItem.CosmeticUnitRef.ObjectID ) );
	if( GremlinUnitState == none )
	{
		`RedScreen("Attempting GremlinSingleTarget_BuildVisualization with a GremlinUnitState of none");
		return;
	}

	AttachedUnitState = XComGameState_Unit( History.GetGameStateForObjectID( GremlinItem.AttachedUnitRef.ObjectID ) );
	ActivatingUnitState = XComGameState_Unit( History.GetGameStateForObjectID( Context.InputContext.SourceObject.ObjectID) );
	
	//Configure the visualization track for the shooter
	//****************************************************************************************

	//****************************************************************************************
	InteractingUnitRef = Context.InputContext.SourceObject;
	ActionMetadata = EmptyTrack;
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID( InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1 );
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID( InteractingUnitRef.ObjectID );
	ActionMetadata.VisualizeActor = History.GetVisualizer( InteractingUnitRef.ObjectID );

	CameraAction = X2Action_CameraLookAt(class'X2Action_CameraLookAt'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
	CameraAction.LookAtActor = ActionMetadata.VisualizeActor;
	CameraAction.BlockUntilActorOnScreen = true;

	class'X2Action_IntrusionProtocolSoldier'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);

	if (AbilityTemplate.ActivationSpeech != '')
	{
		SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
		SoundAndFlyOver.SetSoundAndFlyOverParameters(None, "", AbilityTemplate.ActivationSpeech, eColor_Good);
	}

	// make sure he waits for the gremlin to come back, so that the cinescript camera doesn't pop until then
	X2Action_WaitForAbilityEffect(class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded)).SetCustomTimeOutSeconds(30);

	//Configure the visualization track for the gremlin
	//****************************************************************************************

	InteractingUnitRef = GremlinUnitState.GetReference( );

	ActionMetadata = EmptyTrack;
	History.GetCurrentAndPreviousGameStatesForObjectID(GremlinUnitState.ObjectID, ActionMetadata.StateObject_OldState, ActionMetadata.StateObject_NewState, , VisualizeGameState.HistoryIndex);
	ActionMetadata.VisualizeActor = GremlinUnitState.GetVisualizer();
	TargetVisualizer = History.GetVisualizer(Context.InputContext.PrimaryTarget.ObjectID);

	class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);

	if (AttachedUnitState.TileLocation != TargetUnitState.TileLocation)
	{
		// Given the target location, we want to generate the movement data.  

		//Handle tall units.
		TargetTile = TargetUnitState.GetDesiredTileForAttachedCosmeticUnit();
		StartTile = AttachedUnitState.GetDesiredTileForAttachedCosmeticUnit();

		class'X2PathSolver'.static.BuildPath(GremlinUnitState, StartTile, TargetTile, PathData.MovementTiles);
		class'X2PathSolver'.static.GetPathPointsFromPath( GremlinUnitState, PathData.MovementTiles, Path );
		class'XComPath'.static.PerformStringPulling(XGUnitNativeBase(ActionMetadata.VisualizeActor), Path);

		PathData.MovingUnitRef = GremlinUnitState.GetReference();
		PathData.MovementData = Path;
		Context.InputContext.MovementPaths.AddItem(PathData);

		class'X2TacticalVisibilityHelpers'.static.FillPathTileData(PathData.MovingUnitRef.ObjectID,	PathData.MovementTiles,	ResultData.PathTileData);
		Context.ResultContext.PathResults.AddItem(ResultData);

		class'X2VisualizerHelpers'.static.ParsePath( Context, ActionMetadata);

		if( TargetVisualizer != none )
		{
			TargetCameraAction = X2Action_CameraLookAt(class'X2Action_CameraLookAt'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
			TargetCameraAction.LookAtActor = TargetVisualizer;
			TargetCameraAction.BlockUntilActorOnScreen = true;
			TargetCameraAction.LookAtDuration = 10.0f;		// longer than we need - camera will be removed by tag below
			TargetCameraAction.CameraTag = 'TargetFocusCamera';
			TargetCameraAction.bRemoveTaggedCamera = false;
		}
	}

	PerkStartAction = X2Action_AbilityPerkStart(class'X2Action_AbilityPerkStart'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
	PerkStartAction.NotifyTargetTracks = true;

	PlayAnimation = X2Action_PlayAnimation(class'X2Action_PlayAnimation'.static.AddToVisualizationTree( ActionMetadata, Context ));
	if( AbilityTemplate.CustomSelfFireAnim != '' )
	{
		PlayAnimation.Params.AnimName = AbilityTemplate.CustomSelfFireAnim;
	}
	else
	{
		PlayAnimation.Params.AnimName = 'NO_CombatProtocol';
	}

	class'X2Action_AbilityPerkEnd'.static.AddToVisualizationTree( ActionMetadata, Context );

	//****************************************************************************************
	//Configure the visualization track for the targets
	//****************************************************************************************
	for (i = 0; i < Context.InputContext.MultiTargets.Length; ++i)
	{
		InteractingUnitRef = Context.InputContext.MultiTargets[i];
		ActionMetadata = EmptyTrack;
		ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
		ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
		ActionMetadata.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

		class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree( ActionMetadata, Context );

		for( j = 0; j < Context.ResultContext.MultiTargetEffectResults[i].Effects.Length; ++j )
		{
			Context.ResultContext.MultiTargetEffectResults[i].Effects[j].AddX2ActionsForVisualization(VisualizeGameState, ActionMetadata, Context.ResultContext.MultiTargetEffectResults[i].ApplyResults[j]);
		}

		TargetVisualizerInterface = X2VisualizerInterface(ActionMetadata.VisualizeActor);
		if( TargetVisualizerInterface != none )
		{
			//Allow the visualizer to do any custom processing based on the new game state. For example, units will create a death action when they reach 0 HP.
			TargetVisualizerInterface.BuildAbilityEffectsVisualization(VisualizeGameState, ActionMetadata);
		}
	}
	//****************************************************************************************

	//Configure the visualization track for the target
	//****************************************************************************************
	InteractingUnitRef = Context.InputContext.PrimaryTarget;
	ActionMetadata = EmptyTrack;
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	ActionMetadata.VisualizeActor = TargetVisualizer;

	DelayAction = X2Action_WaitForAbilityEffect( class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree( ActionMetadata, Context ) );
	DelayAction.ChangeTimeoutLength( class'X2Ability_SpecialistAbilitySet'.default.GREMLIN_ARRIVAL_TIMEOUT );       //  give the gremlin plenty of time to show up
	
	for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityTargetEffects.Length; ++EffectIndex)
	{
		AbilityTemplate.AbilityTargetEffects[ EffectIndex ].AddX2ActionsForVisualization( VisualizeGameState, ActionMetadata, Context.FindTargetEffectApplyResult( AbilityTemplate.AbilityTargetEffects[ EffectIndex ] ) );
	}

	TargetVisualizerInterface = X2VisualizerInterface(ActionMetadata.VisualizeActor);
	if (TargetVisualizerInterface != none)
	{
		//Allow the visualizer to do any custom processing based on the new game state. For example, units will create a death action when they reach 0 HP.
		TargetVisualizerInterface.BuildAbilityEffectsVisualization(VisualizeGameState, ActionMetadata);
	}

	if( TargetCameraAction != none )
	{
		TargetCameraAction = X2Action_CameraLookAt(class'X2Action_CameraLookAt'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
		TargetCameraAction.CameraTag = 'TargetFocusCamera';
		TargetCameraAction.bRemoveTaggedCamera = true;
	}

	//****************************************************************************************
}


static simulated function ProtocolSingleTargetB_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory History;
	local XComGameStateContext_Ability  Context;
	local X2AbilityTemplate             AbilityTemplate, ThreatTemplate;
	local StateObjectReference          InteractingUnitRef;
	local XComGameState_Item			GremlinItem;
	local XComGameState_Unit			TargetUnitState;
	local XComGameState_Unit			AttachedUnitState;
	local XComGameState_Unit			GremlinUnitState, ActivatingUnitState;
	local XComGameState_WorldEffectTileData WorldDataUpdate;

	local array<PathPoint> Path;
	local TTile							TargetTile;
	local TTile							StartTile;

	local VisualizationActionMetadata	EmptyTrack;
	local VisualizationActionMetadata	ActionMetadata;
	local X2Action_WaitForAbilityEffect DelayAction;
	local X2Action_AbilityPerkStart		PerkStartAction;
	local X2Action_CameraLookAt			CameraAction;

	local X2Action_PlaySoundAndFlyOver SoundAndFlyOver;
	local int							EffectIndex, i, j;
	local PathingInputData              PathData;
	local PathingResultData				ResultData;
	local X2Action_PlayAnimation		PlayAnimation;

	local X2VisualizerInterface			TargetVisualizerInterface;
	local string						FlyOverText, FlyOverIcon;
	local X2AbilityTag					AbilityTag;

	local X2Action_CameraLookAt			TargetCameraAction;
	local Actor							TargetVisualizer;

	History = `XCOMHISTORY;

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	AbilityTemplate = class'XComGameState_Ability'.static.GetMyTemplateManager().FindAbilityTemplate(Context.InputContext.AbilityTemplateName);

	TargetUnitState = XComGameState_Unit( VisualizeGameState.GetGameStateForObjectID( Context.InputContext.PrimaryTarget.ObjectID ) );

	GremlinItem = XComGameState_Item( History.GetGameStateForObjectID( Context.InputContext.ItemObject.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1 ) );
	if( GremlinItem == none )
	{
		`RedScreen("Attempting GremlinSingleTarget_BuildVisualization with a GremlinItem of none");
		return;
	}

	GremlinUnitState = XComGameState_Unit( History.GetGameStateForObjectID( GremlinItem.CosmeticUnitRef.ObjectID ) );
	if( GremlinUnitState == none )
	{
		`RedScreen("Attempting GremlinSingleTarget_BuildVisualization with a GremlinUnitState of none");
		return;
	}

	AttachedUnitState = XComGameState_Unit( History.GetGameStateForObjectID( GremlinItem.AttachedUnitRef.ObjectID ) );
	ActivatingUnitState = XComGameState_Unit( History.GetGameStateForObjectID( Context.InputContext.SourceObject.ObjectID) );
	

	//Configure the visualization track for the shooter
	//****************************************************************************************

	//****************************************************************************************
	InteractingUnitRef = Context.InputContext.SourceObject;
	ActionMetadata = EmptyTrack;
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID( InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1 );
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID( InteractingUnitRef.ObjectID );
	ActionMetadata.VisualizeActor = History.GetVisualizer( InteractingUnitRef.ObjectID );

	CameraAction = X2Action_CameraLookAt(class'X2Action_CameraLookAt'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
	CameraAction.LookAtActor = ActionMetadata.VisualizeActor;
	CameraAction.BlockUntilActorOnScreen = true;

	class'X2Action_IntrusionProtocolSoldier'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);

	if (AbilityTemplate.ActivationSpeech != '')
	{
		SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
		SoundAndFlyOver.SetSoundAndFlyOverParameters(None, "", AbilityTemplate.ActivationSpeech, eColor_Good);
	}


	// make sure he waits for the gremlin to come back, so that the cinescript camera doesn't pop until then
	X2Action_WaitForAbilityEffect(class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded)).SetCustomTimeOutSeconds(30);

	//Configure the visualization track for the gremlin
	//****************************************************************************************

	InteractingUnitRef = GremlinUnitState.GetReference( );

	ActionMetadata = EmptyTrack;
	History.GetCurrentAndPreviousGameStatesForObjectID(GremlinUnitState.ObjectID, ActionMetadata.StateObject_OldState, ActionMetadata.StateObject_NewState, , VisualizeGameState.HistoryIndex);
	ActionMetadata.VisualizeActor = GremlinUnitState.GetVisualizer();
	TargetVisualizer = History.GetVisualizer(Context.InputContext.PrimaryTarget.ObjectID);

	class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);

	if (AttachedUnitState.TileLocation != TargetUnitState.TileLocation)
	{
		// Given the target location, we want to generate the movement data.  

		//Handle tall units.
		TargetTile = TargetUnitState.GetDesiredTileForAttachedCosmeticUnit();
		StartTile = AttachedUnitState.GetDesiredTileForAttachedCosmeticUnit();

		class'X2PathSolver'.static.BuildPath(GremlinUnitState, StartTile, TargetTile, PathData.MovementTiles);
		class'X2PathSolver'.static.GetPathPointsFromPath( GremlinUnitState, PathData.MovementTiles, Path );
		class'XComPath'.static.PerformStringPulling(XGUnitNativeBase(ActionMetadata.VisualizeActor), Path);

		PathData.MovingUnitRef = GremlinUnitState.GetReference();
		PathData.MovementData = Path;
		Context.InputContext.MovementPaths.AddItem(PathData);

		class'X2TacticalVisibilityHelpers'.static.FillPathTileData(PathData.MovingUnitRef.ObjectID,	PathData.MovementTiles,	ResultData.PathTileData);
		Context.ResultContext.PathResults.AddItem(ResultData);

		class'X2VisualizerHelpers'.static.ParsePath( Context, ActionMetadata);

		if( TargetVisualizer != none )
		{
			TargetCameraAction = X2Action_CameraLookAt(class'X2Action_CameraLookAt'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
			TargetCameraAction.LookAtActor = TargetVisualizer;
			TargetCameraAction.BlockUntilActorOnScreen = true;
			TargetCameraAction.LookAtDuration = 10.0f;		// longer than we need - camera will be removed by tag below
			TargetCameraAction.CameraTag = 'TargetFocusCamera';
			TargetCameraAction.bRemoveTaggedCamera = false;
		}
	}

	PerkStartAction = X2Action_AbilityPerkStart(class'X2Action_AbilityPerkStart'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
	PerkStartAction.NotifyTargetTracks = true;

	PlayAnimation = X2Action_PlayAnimation(class'X2Action_PlayAnimation'.static.AddToVisualizationTree( ActionMetadata, Context ));
	if( AbilityTemplate.CustomSelfFireAnim != '' )
	{
		PlayAnimation.Params.AnimName = AbilityTemplate.CustomSelfFireAnim;
	}
	else
	{
		PlayAnimation.Params.AnimName = 'NO_CombatProtocol';
	}

	class'X2Action_AbilityPerkEnd'.static.AddToVisualizationTree( ActionMetadata, Context );

	//****************************************************************************************
	// lago - mr nice's fixed visualisation code for Aid Protocol world smoke
	//****************************************************************************************

    foreach VisualizeGameState.IterateByClassType(class'XComGameState_WorldEffectTileData', WorldDataUpdate)
    {
        ActionMetadata = EmptyTrack;
        ActionMetadata.VisualizeActor = none;
        ActionMetadata.StateObject_NewState = WorldDataUpdate;
        ActionMetadata.StateObject_OldState = WorldDataUpdate;

        for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityShooterEffects.Length; ++EffectIndex)
        {
            AbilityTemplate.AbilityShooterEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, ActionMetadata, 'AA_Success');        
        }

        for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityTargetEffects.Length; ++EffectIndex)
        {
            AbilityTemplate.AbilityTargetEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, ActionMetadata, 'AA_Success');
        }

        for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityMultiTargetEffects.Length; ++EffectIndex)
        {
            AbilityTemplate.AbilityMultiTargetEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, ActionMetadata, 'AA_Success');    
        }
    }

	//****************************************************************************************
	//Configure the visualization track for the targets
	//****************************************************************************************
	for (i = 0; i < Context.InputContext.MultiTargets.Length; ++i)
	{
		InteractingUnitRef = Context.InputContext.MultiTargets[i];
		ActionMetadata = EmptyTrack;
		ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
		ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
		ActionMetadata.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

		class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree( ActionMetadata, Context );

		for( j = 0; j < Context.ResultContext.MultiTargetEffectResults[i].Effects.Length; ++j )
		{
			Context.ResultContext.MultiTargetEffectResults[i].Effects[j].AddX2ActionsForVisualization(VisualizeGameState, ActionMetadata, Context.ResultContext.MultiTargetEffectResults[i].ApplyResults[j]);
		}

		TargetVisualizerInterface = X2VisualizerInterface(ActionMetadata.VisualizeActor);
		if( TargetVisualizerInterface != none )
		{
			//Allow the visualizer to do any custom processing based on the new game state. For example, units will create a death action when they reach 0 HP.
			TargetVisualizerInterface.BuildAbilityEffectsVisualization(VisualizeGameState, ActionMetadata);
		}
	}
	//****************************************************************************************

	//Configure the visualization track for the target
	//****************************************************************************************
	InteractingUnitRef = Context.InputContext.PrimaryTarget;
	ActionMetadata = EmptyTrack;
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	ActionMetadata.VisualizeActor = TargetVisualizer;

	DelayAction = X2Action_WaitForAbilityEffect( class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree( ActionMetadata, Context ) );
	DelayAction.ChangeTimeoutLength( class'X2Ability_SpecialistAbilitySet'.default.GREMLIN_ARRIVAL_TIMEOUT );       //  give the gremlin plenty of time to show up
	
	for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityTargetEffects.Length; ++EffectIndex)
	{
		AbilityTemplate.AbilityTargetEffects[ EffectIndex ].AddX2ActionsForVisualization( VisualizeGameState, ActionMetadata, Context.FindTargetEffectApplyResult( AbilityTemplate.AbilityTargetEffects[ EffectIndex ] ) );
	}

	TargetVisualizerInterface = X2VisualizerInterface(ActionMetadata.VisualizeActor);
	if (TargetVisualizerInterface != none)
	{
		//Allow the visualizer to do any custom processing based on the new game state. For example, units will create a death action when they reach 0 HP.
		TargetVisualizerInterface.BuildAbilityEffectsVisualization(VisualizeGameState, ActionMetadata);
	}

	if( TargetCameraAction != none )
	{
		TargetCameraAction = X2Action_CameraLookAt(class'X2Action_CameraLookAt'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
		TargetCameraAction.CameraTag = 'TargetFocusCamera';
		TargetCameraAction.bRemoveTaggedCamera = true;
	}
}


// Failsafe - Activate to negate the negative effects from failing hacks this turn.
static function X2AbilityTemplate WOTC_APA_Failsafe()
{
	
	local X2AbilityTemplate										Template;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2AbilityCooldown										Cooldown;
	local X2Effect_WOTC_APA_Failsafe							FailsafeEffect;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_Failsafe');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_Failsafe";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SERGEANT_PRIORITY - 2;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.bSkipFireAction = true;
	//Template.CustomSelfFireAnim = 'HL_HackStartA';
	Template.bShowActivation = true;
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.bCrossClassEligible = false;
	

	// Costs, Conditions, and Requirements:
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = false;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = 1;		// activating more than once in the same turn would be pointless - prevent it
	Template.AbilityCooldown = Cooldown;


	// Create the effect that implements Failsafe
	FailsafeEffect = new class'X2Effect_WOTC_APA_Failsafe';
	FailsafeEffect.AddPersistentStatChange(eStat_Hacking, default.FAILSAFE_HACK_BONUS);
	FailsafeEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage,,,Template.AbilitySourceName);
	FailsafeEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnEnd);
	FailsafeEffect.EffectName = 'WOTC_APA_FailsafeEffect';
	FailsafeEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(FailsafeEffect);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}



// T1 Gremlin Indicator - Ability that gets added to the unit when they have a T2 Gremlin equipped. Used to trigger Gremlin tech bonuses for some abilities
static function X2AbilityTemplate WOTC_APA_T1GremlinIndicator()
{

	local X2AbilityTemplate								Template;
	local X2Condition_WOTC_APA_EquippedGremlinTech		WeaponCondition;
	local X2Effect_WOTC_APA_CombatProtocolBonusDamage	BonusDamageEffect;
	local X2Effect_WOTC_APA_CombatProtocolRoboticDamage	RoboticDamageEffect;
	

	`CREATE_X2ABILITY_TEMPLATE (Template, 'WOTC_APA_T1GremlinIndicator');
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;
	Template.DefaultSourceItemSlot = eInvSlot_SecondaryWeapon;
	Template.bDontDisplayInAbilitySummary = true;
	Template.bUniqueSource = true;

	WeaponCondition = new class'X2Condition_WOTC_APA_EquippedGremlinTech';
	WeaponCondition.AllowedWeaponCategories = default.VALID_WEAPON_CATEGORIES_FOR_GREMLIN_SKILLS;
	WeaponCondition.AllowedWeaponTechNames = default.VALID_T1_GREMLIN_TECH_NAMES;
	Template.AbilityShooterConditions.AddItem(WeaponCondition);

	// Persistent effect to indicate a T1 Gremlin is equipped for cases where an effect is referenced rather than the ability
	BonusDamageEffect = new class'X2Effect_WOTC_APA_CombatProtocolBonusDamage';
	BonusDamageEffect.BuildPersistentEffect(1, true, false);
	BonusDamageEffect.EffectName = 'WOTC_APA_T1GremlinIndicatorEffect';
	BonusDamageEffect.Gremlin_Tier = 1;
	Template.AddTargetEffect(BonusDamageEffect);

	// Bonus damage against Robotic enemies for Combat Protocol (separate for display in the HUD shot wings)
	RoboticDamageEffect = new class'X2Effect_WOTC_APA_CombatProtocolRoboticDamage';
	RoboticDamageEffect.BuildPersistentEffect(1, true, false);
	RoboticDamageEffect.Gremlin_Tier = 1;
	Template.AddTargetEffect(RoboticDamageEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}



// T2 Gremlin Indicator - Ability that gets added to the unit when they have a T2 Gremlin equipped. Used to trigger Gremlin tech bonuses for some abilities
static function X2AbilityTemplate WOTC_APA_T2GremlinIndicator()
{

	local X2AbilityTemplate								Template;
	local X2Condition_WOTC_APA_EquippedGremlinTech		WeaponCondition;
	local X2Effect_WOTC_APA_CombatProtocolBonusDamage	BonusDamageEffect;
	local X2Effect_WOTC_APA_CombatProtocolRoboticDamage	RoboticDamageEffect;
	

	`CREATE_X2ABILITY_TEMPLATE (Template, 'WOTC_APA_T2GremlinIndicator');
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;
	Template.DefaultSourceItemSlot = eInvSlot_SecondaryWeapon;
	Template.bDontDisplayInAbilitySummary = true;
	Template.bUniqueSource = true;

	WeaponCondition = new class'X2Condition_WOTC_APA_EquippedGremlinTech';
	WeaponCondition.AllowedWeaponCategories = default.VALID_WEAPON_CATEGORIES_FOR_GREMLIN_SKILLS;
	WeaponCondition.AllowedWeaponTechNames = default.VALID_T2_GREMLIN_TECH_NAMES;
	Template.AbilityShooterConditions.AddItem(WeaponCondition);

	// Persistent effect to indicate a T2 Gremlin is equipped for cases where an effect is referenced rather than the ability
	BonusDamageEffect = new class'X2Effect_WOTC_APA_CombatProtocolBonusDamage';
	BonusDamageEffect.BuildPersistentEffect(1, true, false);
	BonusDamageEffect.EffectName = 'WOTC_APA_T2GremlinIndicatorEffect';
	BonusDamageEffect.Gremlin_Tier = 2;
	Template.AddTargetEffect(BonusDamageEffect);

	// Bonus damage against Robotic enemies for Combat Protocol (separate for display in the HUD shot wings)
	RoboticDamageEffect = new class'X2Effect_WOTC_APA_CombatProtocolRoboticDamage';
	RoboticDamageEffect.BuildPersistentEffect(1, true, false);
	RoboticDamageEffect.Gremlin_Tier = 2;
	Template.AddTargetEffect(RoboticDamageEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}



// T3 Gremlin Indicator - Ability that gets added to the unit when they have a T3 Gremlin equipped. Used to trigger Gremlin tech bonuses for some abilities
static function X2AbilityTemplate WOTC_APA_T3GremlinIndicator()
{

	local X2AbilityTemplate								Template;
	local X2Condition_WOTC_APA_EquippedGremlinTech		WeaponCondition;
	local X2Effect_WOTC_APA_CombatProtocolBonusDamage	BonusDamageEffect;
	local X2Effect_WOTC_APA_CombatProtocolRoboticDamage	RoboticDamageEffect;
	

	`CREATE_X2ABILITY_TEMPLATE (Template, 'WOTC_APA_T3GremlinIndicator');
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;
	Template.DefaultSourceItemSlot = eInvSlot_SecondaryWeapon;
	Template.bDontDisplayInAbilitySummary = true;
	Template.bUniqueSource = true;

	WeaponCondition = new class'X2Condition_WOTC_APA_EquippedGremlinTech';
	WeaponCondition.AllowedWeaponCategories = default.VALID_WEAPON_CATEGORIES_FOR_GREMLIN_SKILLS;
	WeaponCondition.AllowedWeaponTechNames = default.VALID_T3_GREMLIN_TECH_NAMES;
	Template.AbilityShooterConditions.AddItem(WeaponCondition);

	// Persistent effect to indicate a T2 Gremlin is equipped for cases where an effect is referenced rather than the ability
	BonusDamageEffect = new class'X2Effect_WOTC_APA_CombatProtocolBonusDamage';
	BonusDamageEffect.BuildPersistentEffect(1, true, false);
	BonusDamageEffect.EffectName = 'WOTC_APA_T3GremlinIndicatorEffect';
	BonusDamageEffect.Gremlin_Tier = 3;
	Template.AddTargetEffect(BonusDamageEffect);

	// Bonus damage against Robotic enemies for Combat Protocol (separate for display in the HUD shot wings)
	RoboticDamageEffect = new class'X2Effect_WOTC_APA_CombatProtocolRoboticDamage';
	RoboticDamageEffect.BuildPersistentEffect(1, true, false);
	RoboticDamageEffect.Gremlin_Tier = 3;
	Template.AddTargetEffect(RoboticDamageEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}



// 
static function X2AbilityTemplate WOTC_APA_RemoteRepair()
{
	
	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;
	local X2Condition_Visibility								VisCondition;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2AbilityCharges										Charges;
	local X2AbilityCost_Charges									ChargeCost;
	local X2Condition_UnitProperty								TargetProperty;
	local X2AbilityTarget_Single								PrimaryTarget;
	local X2Condition_WOTC_APA_Class_AbilityRequirement			AbilityCondition;
	local X2Effect_WOTC_APA_AdvancedArmorRepair					ArmorRepairEffect;
	local X2Effect_RemoveEffects								RemoveEffects;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_RemoteRepair');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_RemoteRepair";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.MEDIKIT_HEAL_PRIORITY + 10;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Defensive;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.bLimitTargetIcons = true;
	Template.bSkipPerkActivationActions = true;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.bStationaryWeapon = true;
	Template.CustomSelfFireAnim = 'NO_Repair';
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.bCrossClassEligible = false;


	// Costs, Conditions, and Requirements:
	// A Gremlin must be equipped in the inventory slot the ability is assigned to
	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories.AddItem('gremlin');
	Template.AbilityShooterConditions.AddItem(WeaponCondition);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	// Target must be a living ally
	TargetProperty = new class'X2Condition_UnitProperty';
	TargetProperty.ExcludeDead = true;
	TargetProperty.ExcludeHostileToSource = true;
	TargetProperty.ExcludeFriendlyToSource = false;
	TargetProperty.ExcludeFullHealth = true;
	TargetProperty.ExcludeOrganic = true;
	Template.AbilityTargetConditions.AddItem(TargetProperty);

	// Visibility/Range restrictions and targeting
	VisCondition = new class'X2Condition_Visibility';
	VisCondition.bRequireGameplayVisible = true;
	VisCondition.bActAsSquadsight = true;
	Template.AbilityTargetConditions.AddItem(VisCondition);

	Template.AbilityTargetConditions.AddItem(new class'X2Condition_WOTC_APA_ExtendedProtocolVisibility');

	PrimaryTarget = new class'X2AbilityTarget_Single';
	PrimaryTarget.OnlyIncludeTargetsInsideWeaponRange = false;
	PrimaryTarget.bAllowInteractiveObjects = false;
	PrimaryTarget.bAllowDestructibleObjects = false;
	PrimaryTarget.bIncludeSelf = true;
	PrimaryTarget.bShowAOE = true;
	Template.AbilityTargetSTyle = PrimaryTarget;


	// Ability's Action Point cost
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.DoNotConsumeAllEffects.AddItem('WOTC_APA_ABCProtocols_DoNotConsumeAllActionsEffect');
	Template.AbilityCosts.AddItem(ActionPointCost);	

	Charges = new class 'X2AbilityCharges';
	Charges.InitialCharges = default.REMOTE_REPAIR_INITIAL_CHARGES;;
	Template.AbilityCharges = Charges;

	ChargeCost = new class'X2AbilityCost_Charges';
	ChargeCost.NumCharges = 1;
	Template.AbilityCosts.AddItem(ChargeCost);


	// Setup Repair effects
	Template.AddTargetEffect(new class'X2Effect_WOTC_APA_RemoteRepair');

	AbilityCondition = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
	AbilityCondition.bCheckSourceUnit = true;
	AbilityCondition.RequiredAbilityNames.AddItem('WOTC_APA_AdvancedRepair');

	ArmorRepairEffect = new class'X2Effect_WOTC_APA_AdvancedArmorRepair';
	ArmorRepairEffect.TargetConditions.AddItem(AbilityCondition);	
	Template.AddTargetEffect(ArmorRepairEffect);

	// Clense Stuns/Shutdowns
	RemoveEffects = new class'X2Effect_RemoveEffects';
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.StunnedName);
	RemoveEffects.bDoNotVisualize = true;
	Template.AddTargetEffect(RemoveEffects);
		

	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.NonAggressiveChosenActivationIncreasePerUse;

	//Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.BuildNewGameStateFn = class'X2Ability_SpecialistAbilitySet'.static.AttachGremlinToTarget_BuildGameState;
	Template.BuildVisualizationFn = class'X2Ability_SpecialistAbilitySet'.static.GremlinSingleTarget_BuildVisualization;
	Template.PostActivationEvents.AddItem('ItemRecalled');
	return Template;	
}



// Adaptive Alloy Plating - Provides Ablative and Regenerating Armor
static function X2AbilityTemplate WOTC_APA_AdaptiveAlloyPlating()
{

	local X2AbilityTemplate					Template;
	local X2Effect_PersistentStatChange		Effect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_AdaptiveAlloyPlating');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_AdaptiveAlloyPlating";
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
	Effect.EffectName = 'WOTC_APA_AdaptiveAlloyPlating';
	Effect.BuildPersistentEffect(1, true, false, false);
	Effect.AddPersistentStatChange(eStat_ArmorMitigation, default.ADAPTIVE_PLATING_ARMOR);
	//Effect.AddPersistentStatChange(eStat_ShieldHP, default.ADAPTIVE_PLATING_ABLATIVE);
	Effect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(Effect);


	// Add UI stat markups corresponding to effect stat boosts
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ArmorLabel, eStat_ArmorMitigation, default.ADAPTIVE_PLATING_ARMOR);


	// Add the additional ability that regens Armor at the beginning of every turn
	Template.AdditionalAbilities.AddItem('WOTC_APA_AdaptiveAlloyPlatingRegen');


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

// Adaptive Alloy Plating - Regen Trigger: Triggers the Armor regen effect at the start of every turn
static function X2AbilityTemplate WOTC_APA_AdaptiveAlloyPlatingRegen()
{

	local X2AbilityTemplate							Template;
	local X2Effect_WOTC_APA_AdaptivePlatingRegen	ArmorEffect;
	local X2AbilityTrigger_EventListener			EventListener;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_AdaptiveAlloyPlatingRegen');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_AdaptiveAlloyPlating";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bSkipFireAction = true;
	Template.bShowActivation = false;
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.bCrossClassEligible = false;


	// This ability triggers at the start of each turn
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = 'PlayerTurnBegun';
	EventListener.ListenerData.Filter = eFilter_Player;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	Template.AbilityTriggers.AddItem(EventListener);


	// Regenerate armor effect
	ArmorEffect = new class'X2Effect_WOTC_APA_AdaptivePlatingRegen';
	Template.AddTargetEffect(ArmorEffect);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}



// Electronic Surveillance - Provides free and bonuses to equipped Battlescanners
static function X2AbilityTemplate WOTC_APA_ElectronicSurveillance()
{

	local X2AbilityTemplate									Template;
	local X2Effect_WOTC_APA_Class_BonusItems				ItemEffect;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_ElectronicSurveillance');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_ElectronicSurveillance";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;


	// Create effect to add bonus charges to Battlescanners
	ItemEffect = new class'X2Effect_WOTC_APA_Class_BonusItems';
	ItemEffect.BonusItems = default.SURVEILLANCE_BONUS_VALID_ITEMS;
	ItemEffect.FreeCharges = default.SURVEILLANCE_FREE_BATTLESCANNERS;
	ItemEffect.BonusCharges = default.SURVEILLANCE_BONUS_BATTLESCANNERS;
	ItemEffect.BuildPersistentEffect (1, true, false, false);
	ItemEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(ItemEffect);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}



// 
static function X2AbilityTemplate WOTC_APA_Overload()
{
	
	local X2AbilityTemplate							Template;
	local X2Effect_Persistent						IconEffect;
	local X2Effect_IncrementUnitValue				ModifyUnitValueC;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_Overload');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_Overload";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	Template.bCrossClassEligible = false;


	// Create a persistent effect to display the passive icon (function is handled in WOTC_APA_CombatProtocol ability itself)
	IconEffect = new class 'X2Effect_Persistent';
	IconEffect.EffectName = 'WOTC_APA_OverloadEffect';
	IconEffect.BuildPersistentEffect(1, true, false, false);
	IconEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(IconEffect);


	// Create effect that increases the recharge cooldown timer for Combat Protocol
	ModifyUnitValueC = new class'X2Effect_IncrementUnitValue';
	ModifyUnitValueC.UnitName = default.COMBAT_PROTOCOL_RECHARGE_NAME;
	ModifyUnitValueC.NewValueToSet = default.OVERLOAD_RECHARGE_TURN_PENALTY;
	ModifyUnitValueC.CleanupType = eCleanup_BeginTactical;
	Template.AddTargetEffect(ModifyUnitValueC);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;

}



// 
static function X2AbilityTemplate WOTC_APA_SilentMotors()
{
	
	local X2AbilityTemplate					Template;
	local X2Effect_Persistent				ConcealEffect;
	local X2Effect_PersistentStatChange		StatEffect;
	

	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_SilentMotors');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_SilentMotors";
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
	ConcealEffect.EffectName = 'WOTC_APA_ABCProtocols_RetainIndividualConcealmentEffect';
	ConcealEffect.SetDisplayInfo (ePerkBuff_Passive,Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, true,, Template.AbilitySourceName); 
	Template.AddTargetEffect(ConcealEffect);


	// Setup effect decreasing enemy's detection radius against you
	StatEffect = new class'X2Effect_PersistentStatChange';
	StatEffect.EffectName = 'WOTC_APA_SilentMotorsDetectionEffect';
	StatEffect.AddPersistentStatChange(eStat_DetectionModifier, default.SILENT_MOTORS_DETECTION_BONUS);
	StatEffect.BuildPersistentEffect(1, true, false, false);
	StatEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(StatEffect);


	// Add the additional ability that applies the Detection radius penalty
	Template.AdditionalAbilities.AddItem('WOTC_APA_SilentMotorsApplyDetectionPenalty');


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

// 
static function X2AbilityTemplate WOTC_APA_SilentMotorsApplyDetectionPenalty()
{

	local X2AbilityTemplate								Template;
	local X2Effect_WOTC_APA_ProtocolDetectionPenalty	DetectionRadiusPenalty;
	local X2AbilityTrigger_EventListener				EventListener;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_SilentMotorsApplyDetectionPenalty');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_SilentMotors";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.bCrossClassEligible = false;


	// This ability triggers after X2Effect_WOTC_APA_ProtocolBreakConcealment prevents breaking unit concealment
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = class'X2Effect_WOTC_APA_ProtocolBreakConcealment'.default.WOTC_APA_ProtocolRetainIndividualConcealment_TriggeredName;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	Template.AbilityTriggers.AddItem(EventListener);


	// Create a stat change effect to increase the detection radius against the unit
	DetectionRadiusPenalty = new class'X2Effect_WOTC_APA_ProtocolDetectionPenalty';
	DetectionRadiusPenalty.BuildPersistentEffect(1, true, true, false, eGameRule_TacticalGameEnd);
	DetectionRadiusPenalty.SetDisplayInfo(ePerkBuff_Penalty, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage);
	DetectionRadiusPenalty.AddPersistentStatChange(eStat_DetectionModifier, -default.SILENT_MOTORS_DETECTION_PENALTY);
	DetectionRadiusPenalty.DuplicateResponse = eDupe_Allow;
	Template.AddTargetEffect(DetectionRadiusPenalty);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;;
	return Template;
}



// Extended Range - Allows Tech Specialist Protocols to be used with squadsite
static function X2AbilityTemplate WOTC_APA_ExtendedRange()
{
	
	local X2AbilityTemplate										Template;
	local X2Effect_Persistent									IconEffect;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;
	local X2Effect_Squadsight									SniperSquadsight;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_ExtendedRange');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_ExtendedRange";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	Template.bCrossClassEligible = false;


	// Create a persistent effect that tells the Protocols they can use squadsite range
	IconEffect = new class 'X2Effect_Persistent';
	IconEffect.EffectName = 'WOTC_APA_GremlinSquadsiteEffect';
	IconEffect.BuildPersistentEffect(1, true, false, false);
	IconEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(IconEffect);


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


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}



// Disruption Field
static function X2AbilityTemplate WOTC_APA_DisruptionField()
{

	local X2AbilityTemplate						Template;
	local X2AbilityCooldown						Cooldown;
	local X2Effect_PersistentStatChange			DefenseEffect;
	local X2Effect_WOTC_APA_DisruptionField		ReactionEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_DisruptionField');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_DisruptionField";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.STASIS_LANCE_PRIORITY;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.bIsPassive = false;
	Template.AbilityConfirmSound = "TacticalUI_Activate_Ability_Wraith_Armor";	//"TacticalUI_ActivateAbility";
	Template.bShowActivation = true;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();
	Template.ConcealmentRule = eConceal_Never;
	Template.bCrossClassEligible = false;


	// Set ability cooldown and costs
	Cooldown = new class'X2AbilityCooldown';
    Cooldown.iNumTurns = default.DISRUPTION_FIELD_COOLDOWN;
    Template.AbilityCooldown = Cooldown;

	Template.AbilityCosts.AddItem(default.FreeActionCost);
	

	// Add the general Defense effect
	DefenseEffect = new class'X2Effect_PersistentStatChange';
	DefenseEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnBegin);
	DefenseEffect.EffectName = 'WOTC_APA_DisruptionFieldGeneralDefense';
	DefenseEffect.AddPersistentStatChange(eStat_Defense, default.DISRUPTION_FIELD_BONUS_DEFENSE);
	DefenseEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect (DefenseEffect);


	// Add the reaction fire Defense effect
	ReactionEffect = new class'X2Effect_WOTC_APA_DisruptionField';
	ReactionEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnBegin);
	ReactionEffect.bApplyAsTarget = true;
	ReactionEffect.EffectName = 'WOTC_APA_DisruptionFieldReactionDefense';
	Template.AddTargetEffect(ReactionEffect);
	

	Template.CustomFireAnim = 'HL_FlinchA';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}



// 
static function X2AbilityTemplate WOTC_APA_PsionicFeedback()
{

	local X2AbilityTemplate				Template;
	local X2Effect_Persistent			IconEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_PsionicFeedback');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_PsionicFeedback";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	Template.bCrossClassEligible = false;


	IconEffect = new class 'X2Effect_Persistent';
	IconEffect.BuildPersistentEffect(1, true, false, false);
	IconEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(IconEffect);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}



// 
static function X2AbilityTemplate WOTC_APA_NeutralizingAgents()
{

	local X2AbilityTemplate				Template;
	local X2Effect_Persistent			IconEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_NeutralizingAgents');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_NeutralizingAgents";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	Template.bCrossClassEligible = false;


	IconEffect = new class 'X2Effect_Persistent';
	IconEffect.BuildPersistentEffect(1, true, false, false);
	IconEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(IconEffect);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}



// Anti-Armor: Allows equipping Assault Rifles, grants Shredder, and +Crit against Mechanical enemies with your primary weapon
static function X2AbilityTemplate WOTC_APA_AntiArmor()
{
	local X2AbilityTemplate							Template;
	local X2Effect_WOTC_APA_AntiArmorCritBonus		CritEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_AntiArmor');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_AntiArmor";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;
	Template.bIsPassive = true;

	
	// Create the effect that modifies crit chance against mechanical enemies
	CritEffect = new class'X2Effect_WOTC_APA_AntiArmorCritBonus';
	CritEffect.BuildPersistentEffect(1, true, false);
	CritEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(CritEffect);


	// Add the Shredder ability
	Template.AdditionalAbilities.AddItem('Shredder');
	//Template.AdditionalAbilities.AddItem('WOTC_APA_AntiArmorUpgunned');

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

// Anti-Armor: Upgunned - gives a mobility penalty when equipping Assault Rifles rather than the Bullpup
static function X2AbilityTemplate WOTC_APA_AntiArmorUpgunned()
{

	local X2AbilityTemplate									Template;
	local X2Effect_PersistentStatChange						MobilityEffect;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory	ValidWeaponCondition;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_AntiArmorUpgunned');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_AntiArmorUpgunned";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	Template.bCrossClassEligible = false;


	// Create a persistent stat change effect that adds the mobility penalty for upgunning
	MobilityEffect = new class 'X2Effect_PersistentStatChange';
	MobilityEffect.BuildPersistentEffect(1, true, false, false);
	MobilityEffect.AddPersistentStatChange(eStat_Mobility, -default.ANTI_ARMOR_RIFLE_MOBILITY_PENALTY);
	MobilityEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFlyOverText, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(MobilityEffect);

	ValidWeaponCondition = new class 'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	ValidWeaponCondition.AllowedWeaponCategories = default.ANTI_ARMOR_RIFLE_CATEGORIES;
	Template.AbilityShooterConditions.AddItem(ValidWeaponCondition);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}



// 
static function X2AbilityTemplate WOTC_APA_ElectronicWarfare()
{

	local X2AbilityTemplate							Template;
	local X2Effect_SetUnitValue						SetUnitValEffect;
	local X2Effect_WOTC_APA_ElectronicWarfare		FreeFailsafeEffect;
	local X2Effect_PersistentStatChange				HackingStatEffect;
	local X2Effect_WOTC_APA_ExtendedShutdownTurns	ExtendedShutdownEffect;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_ElectronicWarfare');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_ElectronicWarfare";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;


	// Setup UnitValue to monitor the number of free Failsafe activations granted
	SetUnitValEffect = new class'X2Effect_SetUnitValue';
	SetUnitValEffect.UnitName = class'X2Effect_WOTC_APA_ElectronicWarfare'.default.FreeFailsafeActivationsUnitName;
	SetUnitValEffect.NewValueToSet = default.ELECTRONIC_WARFARE_FREE_FAILSAFE + 0.1;
	SetUnitValEffect.CleanupType = eCleanup_BeginTactical;
	SetUnitValEffect.bApplyOnHit = true;
	SetUnitValEffect.bApplyOnMiss = true;
	Template.AddTargetEffect(SetUnitValEffect);


	// Setup effect allowing Failsafe to be activated for free
	FreeFailsafeEffect = new class 'X2Effect_WOTC_APA_ElectronicWarfare';
	FreeFailsafeEffect.BuildPersistentEffect (1, true, false, false);
	Template.AddTargetEffect(FreeFailsafeEffect);


	// Create a persistent stat change effect that adds the bonus to the Hacking skill
	HackingStatEffect = new class 'X2Effect_PersistentStatChange';
	HackingStatEffect.BuildPersistentEffect(1, true, false, false);
	HackingStatEffect.EffectName = 'WOTC_APA_ReduceActionsAfterHackEffect';
	HackingStatEffect.AddPersistentStatChange(eStat_Hacking, default.ELECTRONIC_WARFARE_BONUS_HACKING);
	HackingStatEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(HackingStatEffect);

	// Add UI stat markups corresponding to effect stat boosts
	Template.SetUIStatMarkup(class'XLocalizedData'.default.TechLabel, eStat_Hacking, default.ELECTRONIC_WARFARE_BONUS_HACKING);


	// Create effect that listens for stuns/shutdowns applied by this unit and triggers a duration extention
	ExtendedShutdownEffect = new class'X2Effect_WOTC_APA_ExtendedShutdownTurns';
	ExtendedShutdownEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(ExtendedShutdownEffect);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}



// 
static function X2AbilityTemplate WOTC_APA_TargetingUplink()
{
	
	
	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;
	local X2Condition_Visibility								VisCondition;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2AbilityCooldown										Cooldown;
	local X2Condition_UnitProperty								TargetProperty;
	local X2AbilityTarget_Single								PrimaryTarget;
	local X2Effect_WOTC_APA_Class_NegateRangePenalty			UplinkEffect;
	local X2Effect_PersistentStatChange							CritEffect1, CritEffect2, CritEffect3;
	local X2Condition_WOTC_APA_Class_EffectRequirement			CritCondition1, CritCondition2, CritCondition3;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_TargetingUplink');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_TargetingUplink";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.MEDIKIT_HEAL_PRIORITY + 11;
	Template.Hostility = eHostility_Defensive;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.bLimitTargetIcons = true;
	//Template.bSkipPerkActivationActions = true;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.bStationaryWeapon = true;
	Template.CustomSelfFireAnim = 'NO_Repair';
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.bCrossClassEligible = false;


	// Costs, Conditions, and Requirements:
	// A Gremlin must be equipped in the inventory slot the ability is assigned to
	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories.AddItem('gremlin');
	Template.AbilityShooterConditions.AddItem(WeaponCondition);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	// Target must be a living ally
	TargetProperty = new class'X2Condition_UnitProperty';
	TargetProperty.ExcludeDead = true;
	TargetProperty.ExcludeHostileToSource = true;
	TargetProperty.ExcludeFriendlyToSource = false;
	TargetProperty.ExcludeOrganic = true;
	Template.AbilityTargetConditions.AddItem(TargetProperty);

	// Visibility/Range restrictions and targeting
	VisCondition = new class'X2Condition_Visibility';
	VisCondition.bRequireGameplayVisible = true;
	VisCondition.bActAsSquadsight = true;
	Template.AbilityTargetConditions.AddItem(VisCondition);

	Template.AbilityTargetConditions.AddItem(new class'X2Condition_WOTC_APA_ExtendedProtocolVisibility');

	PrimaryTarget = new class'X2AbilityTarget_Single';
	PrimaryTarget.OnlyIncludeTargetsInsideWeaponRange = false;
	PrimaryTarget.bAllowInteractiveObjects = false;
	PrimaryTarget.bAllowDestructibleObjects = false;
	PrimaryTarget.bIncludeSelf = true;
	PrimaryTarget.bShowAOE = true;
	Template.AbilityTargetSTyle = PrimaryTarget;


	// Ability's Action Point cost
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	//ActionPointCost.DoNotConsumeAllEffects.AddItem('WOTC_APA_ABCProtocols_DoNotConsumeAllActionsEffect');
	Template.AbilityCosts.AddItem(ActionPointCost);	

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.TARGETING_UPLINK_COOLDOWN;
	Template.AbilityCooldown = Cooldown;


	// Setup squadsite and range penalty modifying effects
	UplinkEffect = new class'X2Effect_WOTC_APA_Class_NegateRangePenalty';
	UplinkEffect.EffectName = 'Squadsight';
	UplinkEffect.RangePenaltyPercentNegated = default.TARGETING_UPLINK_RANGE_PENALTY_NEGATED;
	UplinkEffect.DuplicateResponse = eDupe_Ignore;
	UplinkEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnEnd);
	UplinkEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage,,,Template.AbilitySourceName);
	Template.AddTargetEffect(UplinkEffect);
		

	// Setup effects granting bonus Critical Hit chance
	CritCondition1 = new class 'X2Condition_WOTC_APA_Class_EffectRequirement';
	CritCondition1.RequiredEffectNames.AddItem('WOTC_APA_T1GremlinIndicatorEffect');
	CritCondition1.bCheckSourceUnit = true;

	CritCondition2 = new class 'X2Condition_WOTC_APA_Class_EffectRequirement';
	CritCondition2.RequiredEffectNames.AddItem('WOTC_APA_T2GremlinIndicatorEffect');
	CritCondition2.bCheckSourceUnit = true;

	CritCondition3 = new class 'X2Condition_WOTC_APA_Class_EffectRequirement';
	CritCondition3.RequiredEffectNames.AddItem('WOTC_APA_T3GremlinIndicatorEffect');
	CritCondition3.bCheckSourceUnit = true;


	CritEffect1 = new class'X2Effect_PersistentStatChange';
	CritEffect1.EffectName = 'WOTC_APA_TargetingUplinkCritEffect';
	CritEffect1.DuplicateResponse = eDupe_Ignore;
	CritEffect1.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnEnd);
	CritEffect1.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, false,,Template.AbilitySourceName);
	CritEffect1.AddPersistentStatChange(eStat_CritChance, default.TARGETING_UPLINK_CRIT_BONUS_PER_TECH_LVL);
	CritEffect1.TargetConditions.AddItem(CritCondition1);
	Template.AddTargetEffect(CritEffect1);

	CritEffect2 = new class'X2Effect_PersistentStatChange';
	CritEffect2.EffectName = 'WOTC_APA_TargetingUplinkCritEffect';
	CritEffect2.DuplicateResponse = eDupe_Ignore;
	CritEffect2.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnEnd);
	CritEffect2.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, false,,Template.AbilitySourceName);
	CritEffect2.AddPersistentStatChange(eStat_CritChance, default.TARGETING_UPLINK_CRIT_BONUS_PER_TECH_LVL * 2);
	CritEffect2.TargetConditions.AddItem(CritCondition2);
	Template.AddTargetEffect(CritEffect2);

	CritEffect3 = new class'X2Effect_PersistentStatChange';
	CritEffect3.EffectName = 'WOTC_APA_TargetingUplinkCritEffect';
	CritEffect3.DuplicateResponse = eDupe_Ignore;
	CritEffect3.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnEnd);
	CritEffect3.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, false,,Template.AbilitySourceName);
	CritEffect3.AddPersistentStatChange(eStat_CritChance, default.TARGETING_UPLINK_CRIT_BONUS_PER_TECH_LVL * 3);
	CritEffect3.TargetConditions.AddItem(CritCondition3);
	Template.AddTargetEffect(CritEffect3);


	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.NonAggressiveChosenActivationIncreasePerUse;


	//Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.BuildNewGameStateFn = class'X2Ability_SpecialistAbilitySet'.static.AttachGremlinToTarget_BuildGameState;
	Template.BuildVisualizationFn = class'X2Ability_SpecialistAbilitySet'.static.GremlinSingleTarget_BuildVisualization;
	//Template.PostActivationEvents.AddItem('ItemRecalled');
	return Template;
}



// Marauder - Standard shots no longer end the turn (same as Skirmisher ability - separate for different loc text)
static function X2AbilityTemplate WOTC_APA_Marauder()
{

	local X2AbilityTemplate			Template;

	Template = PurePassive('WOTC_APA_Marauder', "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_strike");

	Template.OverrideAbilities.AddItem('WOTC_APA_SustainedFire');
	Template.OverrideAbilities.AddItem('WOTC_APA_TraverseFire');

	return Template;
}



// 
static function X2AbilityTemplate WOTC_APA_EMPShockwave()
{

	local X2AbilityTemplate				Template;
	local X2Effect_Persistent			IconEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_EMPShockwave');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_EMPShockwave"; 
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	Template.bCrossClassEligible = false;


	IconEffect = new class 'X2Effect_Persistent';
	IconEffect.BuildPersistentEffect(1, true, false, false);
	IconEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(IconEffect);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}



// Advance Repair - Adds +1 Repair charge and allows repairs to restore some shredded armor (armor restore effect handled inside WOTC_APA_RemoteRepair)
static function X2AbilityTemplate WOTC_APA_AdvancedRepair()
{

	local X2AbilityTemplate									Template;
	local X2Effect_WOTC_APA_Class_ModifyAbilityCharges		RepairChargeBonus;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_AdvancedRepair');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_AdvancedRepair";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;


	// Setup Remote Repair charge bonus
	RepairChargeBonus = new class 'X2Effect_WOTC_APA_Class_ModifyAbilityCharges';
	RepairChargeBonus.AbilitiesToModify.AddItem('WOTC_APA_RemoteRepair');
	RepairChargeBonus.iChargeModifier = default.ADVANCED_REPAIR_BONUS_REPAIR_CHARGES;
	RepairChargeBonus.EffectName = 'WOTC_APA_AdvancedRepairEffect';
	RepairChargeBonus.BuildPersistentEffect (1, true, false, false);
	RepairChargeBonus.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(RepairChargeBonus);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}



// Miniaturized Munitions - Grants Heavy Weapon slot, regardless of Armor worn, and adds +1 charge to equipped Heavy Weapons
static function X2AbilityTemplate WOTC_APA_MiniaturizedMunitions()
{

	local X2AbilityTemplate						Template;
	local X2Effect_WOTC_APA_MiniMunitions		ChargeBonus;
	local X2Effect_WOTC_APA_Class_BonusDamage	DamageEffect;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_MiniaturizedMunitions');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_MiniaturizedMunitions";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;


	// Setup bonus Heavy Weapon charges
	ChargeBonus = new class 'X2Effect_WOTC_APA_MiniMunitions';
	ChargeBonus.BonusCharges = default.MINIATURIZED_MUNITIONS_BONUS_CHARGES;
	ChargeBonus.BuildPersistentEffect (1, true, false, false);
	ChargeBonus.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(ChargeBonus);


	// Setup effect reducing base damage for Heavy Weapons
	DamageEffect = new class'X2Effect_WOTC_APA_Class_BonusDamage';
	DamageEffect.fBonusDmgMultiplier = default.MINIATURIZED_MUNITIONS_DAMAGE_MODIFIER;
	DamageEffect.EffectName = 'WOTC_APA_MiniMunitionsDamageEffect';
	DamageEffect.bApplyToPrimary = false;
	DamageEffect.bApplyToHeavyWeapon = true;
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(DamageEffect);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}



// Advanced Robotics - Adds +1 charge to ABC Protocols and removes the shared cooldown, more than one ABC Protocol to be used within a single turn
static function X2AbilityTemplate WOTC_APA_AdvancedRobotics()
{

	local X2AbilityTemplate									Template;
	local X2Effect_WOTC_APA_Class_ModifyAbilityCharges		ChargeBonus;
	local X2Effect_IncrementUnitValue						ModifyUnitValueA, ModifyUnitValueB, ModifyUnitValueC;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_AdvancedRobotics');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_AdvancedRobotics"; 
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;


	// Setup bonus ABC Protocol charges
	ChargeBonus = new class 'X2Effect_WOTC_APA_Class_ModifyAbilityCharges';
	ChargeBonus.AbilitiesToModify.AddItem('WOTC_APA_AidProtocol');
	ChargeBonus.AbilitiesToModify.AddItem('WOTC_APA_BlindingProtocol');
	ChargeBonus.AbilitiesToModify.AddItem('WOTC_APA_CombatProtocol');
	ChargeBonus.iChargeModifier = default.ADVANCED_ROBOTICS_ABC_PROTOCOL_CHARGE_BONUS;
	ChargeBonus.BuildPersistentEffect (1, true, false, false);
	ChargeBonus.EffectName = 'WOTC_APA_ABCProtocols_NoSharedCooldownEffect';
	ChargeBonus.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(ChargeBonus);


	// Setup decreased ABC Protocol recharge cooldowns
	ModifyUnitValueA = new class'X2Effect_IncrementUnitValue';
	ModifyUnitValueA.UnitName = default.AID_PROTOCOL_RECHARGE_NAME;
	ModifyUnitValueA.NewValueToSet = -default.ADVANCED_ROBOTICS_ABC_PROTOCOL_RECHARGE_BONUS;
	ModifyUnitValueA.CleanupType = eCleanup_BeginTactical;
	Template.AddTargetEffect(ModifyUnitValueA);

	ModifyUnitValueB = new class'X2Effect_IncrementUnitValue';
	ModifyUnitValueB.UnitName = default.BLIND_PROTOCOL_RECHARGE_NAME;
	ModifyUnitValueB.NewValueToSet = -default.ADVANCED_ROBOTICS_ABC_PROTOCOL_RECHARGE_BONUS;
	ModifyUnitValueB.CleanupType = eCleanup_BeginTactical;
	Template.AddTargetEffect(ModifyUnitValueB);

	ModifyUnitValueC = new class'X2Effect_IncrementUnitValue';
	ModifyUnitValueC.UnitName = default.COMBAT_PROTOCOL_RECHARGE_NAME;
	ModifyUnitValueC.NewValueToSet = -default.ADVANCED_ROBOTICS_ABC_PROTOCOL_RECHARGE_BONUS;
	ModifyUnitValueC.CleanupType = eCleanup_BeginTactical;
	Template.AddTargetEffect(ModifyUnitValueC);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}



// Full Override: Attempt a hack that will shutdown or control a mechanical enemy for the duration of the mission
static function X2AbilityTemplate WOTC_APA_FullOverride()
{

	local X2AbilityTemplate				Template;
	local X2AbilityCharges				Charges;
	local X2AbilityCost_Charges			ChargeCost;
	local X2AbilityCooldown             Cooldown;


	Template = class'X2Ability_SpecialistAbilitySet'.static.ConstructIntrusionProtocol('WOTC_APA_FullOverride', , true);
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_FullOverride"; 
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.HideErrors.AddItem('AA_CannotAfford_Charges');
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SERGEANT_PRIORITY + 2;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.ActivationSpeech = 'HaywireProtocol';
	Template.bDontDisplayInAbilitySummary = false;


	// Charges and Cost
	Charges = new class'X2AbilityCharges';
	Charges.InitialCharges = default.FULL_OVERRIDE_INITIAL_CHARGES;
	Template.AbilityCharges = Charges;

	ChargeCost = new class'X2AbilityCost_Charges';
	ChargeCost.NumCharges = 1;
	ChargeCost.bOnlyOnHit = true;
	Template.AbilityCosts.AddItem(ChargeCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = class'X2Ability_SpecialistAbilitySet'.default.HAYWIRE_PROTOCOL_COOLDOWN;
	Template.AbilityCooldown = Cooldown;


	Template.CancelAbilityName = 'WOTC_APA_CancelFullOverride';
	Template.FinalizeAbilityName = 'WOTC_APA_FinalizeFullOverride';

	Template.AdditionalAbilities.AddItem('WOTC_APA_CancelFullOverride');
	Template.AdditionalAbilities.AddItem('WOTC_APA_FinalizeFullOverride');

	return Template;
}

// Full Override - Cancel: Refund charges and actions when the hack is canceled
static function X2AbilityTemplate WOTC_APA_CancelFullOverride()
{
	local X2AbilityTemplate				Template;

	Template = class'X2Ability_SpecialistAbilitySet'.static.CancelIntrusion('WOTC_APA_CancelFullOverride');
	Template.BuildNewGameStateFn = WOTC_APA_CancelFullOverride_BuildGameState;

	return Template;
}

// Player has aborted a full override: Refund the chage.
function XComGameState WOTC_APA_CancelFullOverride_BuildGameState(XComGameStateContext Context)
{
	local XComGameStateContext_Ability	AbilityContext;
	local XComGameState					NewGameState;
	local XComGameState_Ability			AbilityState;
	local XComGameStateHistory			History;

	History = `XCOMHISTORY;
	AbilityContext = XComGameStateContext_Ability(Context);
	NewGameState = TypicalAbility_BuildGameState(Context);
	
	foreach History.IterateByClassType(class'XComGameState_Ability', AbilityState)
	{
		if (AbilityState.OwnerStateObject.ObjectID == AbilityContext.InputContext.SourceObject.ObjectID && AbilityState.GetMyTemplateName() == 'WOTC_APA_FullOverride')
		{
			AbilityState = XComGameState_Ability(NewGameState.CreateStateObject(class'XComGameState_Ability', AbilityState.ObjectID));
			++AbilityState.iCharges;
			AbilityState.iCooldown = 0;
			break;
		}
	}

	return NewGameState;
}

// Full Override - Finalize: Process effects after Full Override hack has been attempted
static function X2AbilityTemplate WOTC_APA_FinalizeFullOverride()
{

	local X2AbilityTemplate								Template;
	local X2AbilityCost_ActionPoints					ActionPointCost;
	local X2AbilityTarget_Single						SingleTarget;
	local X2Effect_WOTC_APA_Class_SetAbilityCooldown	SharedCooldown;


	Template = class'X2Ability_SpecialistAbilitySet'.static.FinalizeIntrusion('WOTC_APA_FinalizeFullOverride', true);
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SERGEANT_PRIORITY - 1;


	// Clear AbilityCosts and re-add ActionPointCost
	Template.AbilityCosts.Length=0;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.DoNotConsumeAllEffects.AddItem('WOTC_APA_ABCProtocols_DoNotConsumeAllActionsEffect');
	Template.AbilityCosts.AddItem(ActionPointCost);


	SharedCooldown = new class'X2Effect_WOTC_APA_Class_SetAbilityCooldown';
	SharedCooldown.AbilitiesToSet.AddItem('HaywireProtocol');
	SharedCooldown.SetCooldownTo = class'X2Ability_SpecialistAbilitySet'.default.HAYWIRE_PROTOCOL_COOLDOWN;
	Template.AddShooterEffect(SharedCooldown);


	Template.BuildNewGameStateFn = WOTC_APA_FinalizeFullOverride_BuildGameState;
	Template.BuildVisualizationFn = class'X2Ability_DefaultAbilitySet'.static.FinalizeHackAbility_BuildVisualization;
	Template.MergeVisualizationFn = class'X2Ability_DefaultAbilitySet'.static.FinalizeHackAbility_MergeVisualization;
	//Template.PostActivationEvents.AddItem('ItemRecalled');

	return Template;
}

// Player has attempted a full override: Perform the normal hack finalization, but in addition
// we need to check if the hack has failed. If so, refund the charge.
simulated function XComGameState WOTC_APA_FinalizeFullOverride_BuildGameState(XComGameStateContext Context)
{
    local XComGameStateContext_Ability	AbilityContext;
	local XComGameState_Ability			AbilityState;
    local XComGameState_BaseObject		TargetState;
	local XComGameStateHistory			History;
    local XComGameState_Unit			TargetUnit;
    local XComGameState					NewGameState;

    // First perform the standard hack finalization.
	NewGameState = FinalizeHackAbility_BuildGameState_Internal(Context);
	AbilityContext = XComGameStateContext_Ability(Context);

	// Check if we have succesfully hacked the target. If not, refund the charge, if yes, refund the cooldown (to make the icon disappear immediatly)
	History = `XCOMHISTORY;
	TargetState = NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID);
	TargetUnit = XComGameState_Unit(TargetState);
	if (TargetUnit != none)
	{
		foreach History.IterateByClassType(class'XComGameState_Ability', AbilityState)
		{
			if( AbilityState.OwnerStateObject.ObjectID == AbilityContext.InputContext.SourceObject.ObjectID && AbilityState.GetMyTemplateName() == 'WOTC_APA_FullOverride' )
			{
				AbilityState = XComGameState_Ability(NewGameState.CreateStateObject(class'XComGameState_Ability', AbilityState.ObjectID));
				if (!TargetUnit.bHasBeenHacked)
				{
					++AbilityState.iCharges;
				}
				else
				{
					if (AbilityState.iCharges == 0)
					{
						AbilityState.iCooldown = 0;
				}	}
				break;
	}	}	}

	return NewGameState; 
}

static function XComGameState FinalizeHackAbility_BuildGameState_Internal(XComGameStateContext Context)
{
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState_Ability AbilityState;
	local XComGameState_BaseObject TargetState;
	local XComGameState_Unit UnitState, TargetUnit;
	local XComGameState_InteractiveObject ObjectState;
	local XComGameState_Item SourceWeaponState;
	local XComGameState_BattleData BattleData;
	local X2AbilityTemplate AbilityTemplate;
	local array<XComInteractPoint> InteractionPoints;
	local X2EventManager EventManager;
	local bool bHackSuccess;
	local array<int> HackRollMods;
	local Hackable HackableObject;
	local UIHackingScreen HackingScreen;
	local int UserSelectedReward;

	EventManager = `XEVENTMGR;
	History = `XCOMHISTORY;

	//Build the new game state frame
	NewGameState = TypicalAbility_BuildGameState(Context);	

	AbilityContext = XComGameStateContext_Ability(Context);	
	AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID, eReturnType_Reference));	
	AbilityTemplate = AbilityState.GetMyTemplate();
	UnitState = XComGameState_Unit(History.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID));
	SourceWeaponState = XComGameState_Item(History.GetGameStateForObjectID(AbilityContext.InputContext.ItemObject.ObjectID));
	InteractionPoints = class'X2Condition_UnitInteractions'.static.GetUnitInteractionPoints(UnitState, eInteractionType_Hack);

	// add a copy of the unit and update apply the costs of the ability to him
	UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(UnitState.Class, UnitState.ObjectID));
	if (SourceWeaponState != none)
		SourceWeaponState = XComGameState_Item(NewGameState.ModifyStateObject(SourceWeaponState.Class, SourceWeaponState.ObjectID));

	TargetState = History.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID);
	TargetState = NewGameState.ModifyStateObject(TargetState.Class, TargetState.ObjectID);

	HackableObject = Hackable(TargetState);

	ObjectState = XComGameState_InteractiveObject(TargetState);
	if (ObjectState == none)
		TargetUnit = XComGameState_Unit(TargetState);

	`assert(ObjectState != none || TargetUnit != none);     //  if we don't have an interactive object or a unit, what is going on?

	HackingScreen = UIHackingScreen(`SCREENSTACK.GetScreen(class'UIHackingScreen'));

	// The bottom values of 0 and 100.0f are for when the HackingScreen is not available.
	// When this is the case, the hack should always succeed and award the lowest valued reward, index 0.
	bHackSuccess = class'X2HackRewardTemplateManager'.static.AcquireHackRewards(
		HackingScreen,
		UnitState, 
		TargetState, 
		AbilityContext.ResultContext.StatContestResult, 
		NewGameState, 
		AbilityTemplate.DataName,
		UserSelectedReward,
		0,
		100.0f);

	if( ObjectState != none )
	{
		ObjectState.bHasBeenHacked = bHackSuccess;
		ObjectState.UserSelectedHackReward = UserSelectedReward;
		if( ObjectState.bHasBeenHacked )
		{
			// award all loot on the hacked object to the hacker
			ObjectState.MakeAvailableLoot(NewGameState);
			class'Helpers'.static.AcquireAllLoot(ObjectState, AbilityContext.InputContext.SourceObject, NewGameState);

			EventManager.TriggerEvent('ObjectHacked', UnitState, ObjectState, NewGameState);
			`TRIGGERXP('XpSuccessfulHack', UnitState.GetReference(), ObjectState.GetReference(), NewGameState);

			// automatically interact with the hacked object as well
			if( InteractionPoints.Length > 0 )
				ObjectState.Interacted(UnitState, NewGameState, InteractionPoints[0].InteractSocketName);
		}

		if( ObjectState.bOffersTacticalHackRewards )
		{
			BattleData = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
			BattleData = XComGameState_BattleData(NewGameState.ModifyStateObject(class'XComGameState_BattleData', BattleData.ObjectID));
			BattleData.bTacticalHackCompleted = true;
		}
	}
	else if( TargetUnit != none )
	{
		TargetUnit.bHasBeenHacked = bHackSuccess;
		TargetUnit.UserSelectedHackReward = UserSelectedReward;
		if( TargetUnit.bHasBeenHacked )
		{
			`TRIGGERXP('XpSuccessfulHack', UnitState.GetReference(), TargetUnit.GetReference(), NewGameState);

		}
	}

	HackableObject.SetHackRewardRollMods(HackRollMods);

	//Return the game state we have created
	return NewGameState;
}

// Full Override - Self-Destruct Hack Reward:
static function X2AbilityTemplate HackRewardSelfDestruct_WOTC_APA_FullOverride()
{
	local X2AbilityTemplate                 Template;
	local X2AbilityTrigger_EventListener    Listener;
	local X2Effect_Stunned                  StunEffect;
	local X2Effect_KillUnit					KillEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'HackRewardSelfDestruct_WOTC_APA_FullOverride');

	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;

	Listener = new class'X2AbilityTrigger_EventListener';
	Listener.ListenerData.Deferral = ELD_OnStateSubmitted;
	Listener.ListenerData.EventFn = class'XComGameState_Ability'.static.HackTriggerTargetListener;
	Listener.ListenerData.EventID = class'X2HackRewardTemplateManager'.default.HackAbilityEventName;
	Listener.ListenerData.Filter = eFilter_None;
	Template.AbilityTriggers.AddItem(Listener);

	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	
	StunEffect = class'X2StatusEffects'.static.CreateStunnedStatusEffect(2, 100, false);
	StunEffect.VisualizationFn = none;
	Template.AddTargetEffect(StunEffect);
	
	KillEffect = new class'X2Effect_KillUnit';
	KillEffect.bHideDeathWorldMessage = true;
	Template.AddTargetEffect(KillEffect);
	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;

	return Template;
}

//// Full Override - Shutdown Hack Reward Kill:
//static function X2AbilityTemplate HackRewardShutdownRobot_WOTC_APA_FullOverride_Kill()
//{
//
	//local X2AbilityTemplate							Template;
	//local X2AbilityTrigger_EventListener			Trigger;
	//local X2Effect_KillUnit							KillEffect;
//
	//`CREATE_X2ABILITY_TEMPLATE(Template, 'HackRewardShutdownRobot_WOTC_APA_FullOverride_Kill');
	//Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	//Template.Hostility = eHostility_Neutral;
	//Template.AbilityToHitCalc = default.DeadEye;
	//Template.AbilityTargetStyle = default.SimpleSingleTarget;
	//Template.ConcealmentRule = eConceal_Always;
//
	//Trigger = new class'X2AbilityTrigger_EventListener';
	//Trigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	//Trigger.ListenerData.EventID = 'HackRewardShutdownRobot_WOTC_APA_FullOverride_Kill';
	//Trigger.ListenerData.Filter = eFilter_Unit;
	//Trigger.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_OriginalTarget;
	//Template.AbilityTriggers.AddItem(Trigger);
//
	//KillEffect = new class'X2Effect_KillUnit';
	//KillEffect.bHideDeathWorldMessage = true;
	//KillEffect.DeathActionClass = class'X2Action_WOTC_APA_StartRagdoll';
	//Template.AddTargetEffect(KillEffect);
//
	//Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	//return Template;
//}

// Full Override - Control Hack Reward:
static function X2AbilityTemplate HackRewardControlRobot_WOTC_APA_FullOverride()
{
	local X2AbilityTemplate					Template;
	local X2AbilityTrigger_EventListener	Listener;
	local X2Effect_MindControl				ControlEffect;
	local X2Effect_RemoveEffects			RemoveEffects;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'HackRewardControlRobot_WOTC_APA_FullOverride');

	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;

	Listener = new class'X2AbilityTrigger_EventListener';
	Listener.ListenerData.Deferral = ELD_OnStateSubmitted;
	Listener.ListenerData.EventFn = class'XComGameState_Ability'.static.HackTriggerTargetListener;
	Listener.ListenerData.EventID = class'X2HackRewardTemplateManager'.default.HackAbilityEventName;
	Listener.ListenerData.Filter = eFilter_None;
	Template.AbilityTriggers.AddItem(Listener);

	Template.AbilityTargetStyle = default.SimpleSingleTarget;

	ControlEffect = class'X2StatusEffects'.static.CreateMindControlStatusEffect(1, true, true);
	Template.AddTargetEffect(ControlEffect);

	// Remove any pre-existing disorient.
	Template.AddTargetEffect(class'X2StatusEffects'.static.CreateMindControlRemoveEffects());
	Template.AddTargetEffect(class'X2StatusEffects'.static.CreateStunRecoverEffect());

	RemoveEffects = new class'X2Effect_RemoveEffects';
	RemoveEffects.EffectNamesToRemove.AddItem('HackRewardBuffEnemy0');
	RemoveEffects.EffectNamesToRemove.AddItem('HackRewardBuffEnemy1');
	Template.AddTargetEffect(RemoveEffects);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;

	return Template;
}


// Sprint: Activate to gain an additional movement-only action.
static function X2AbilityTemplate WOTC_APA_Sprint()
{
	
	local X2AbilityTemplate								Template;
	local X2AbilityCooldown								Cooldown;
	local X2AbilityCost_ActionPoints					ActionPointCost;
	local X2Effect_GrantActionPoints					ActionPointEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_Sprint');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_Sprint";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.STABILIZE_PRIORITY - 2;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.bCrossClassEligible = false;
	

	// Costs, Conditions, and Requirements:
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.SPRINT_COOLDOWN;
	Template.AbilityCooldown = Cooldown;


	// Create the effect granting a movement-only action point
	ActionPointEffect = new class'X2Effect_GrantActionPoints';
	ActionPointEffect.NumActionPoints = 1;
	ActionPointEffect.PointType = class'X2CharacterTemplateManager'.default.MoveActionPoint;
	Template.AddTargetEffect(ActionPointEffect);


	class'X2Ability_RangerAbilitySet'.static.SuperKillRestrictions(Template, 'RunAndGun_SuperKillCheck');


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}



// Hot-Charged Batteries: Initial ABC Protocol charges are reduced by 1, but recharge turns are reduced by 2.
static function X2AbilityTemplate WOTC_APA_HotChargedBatteries()
{
	
	local X2AbilityTemplate									Template;
	local X2Effect_WOTC_APA_Class_ModifyAbilityCharges		ChargeBonus;
	local X2Effect_IncrementUnitValue						ModifyUnitValueA, ModifyUnitValueB, ModifyUnitValueC;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_HotChargedBatteries');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_HotChargedBatteries";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;


	// Setup bonus ABC Protocol charges
	ChargeBonus = new class 'X2Effect_WOTC_APA_Class_ModifyAbilityCharges';
	ChargeBonus.AbilitiesToModify.AddItem('WOTC_APA_AidProtocol');
	ChargeBonus.AbilitiesToModify.AddItem('WOTC_APA_BlindingProtocol');
	ChargeBonus.AbilitiesToModify.AddItem('WOTC_APA_CombatProtocol');
	ChargeBonus.iChargeModifier = default.HOT_CHARGED_BATTERIES_CHARGE_BONUS;
	ChargeBonus.BuildPersistentEffect (1, true, false, false);
	ChargeBonus.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(ChargeBonus);


	// Setup increased ABC Protocol recharge cooldowns
	ModifyUnitValueA = new class'X2Effect_IncrementUnitValue';
	ModifyUnitValueA.UnitName = default.AID_PROTOCOL_RECHARGE_NAME;
	ModifyUnitValueA.NewValueToSet = default.HOT_CHARGED_BATTERIES_RECHARGE_PENALTY;
	ModifyUnitValueA.CleanupType = eCleanup_BeginTactical;
	Template.AddTargetEffect(ModifyUnitValueA);

	ModifyUnitValueB = new class'X2Effect_IncrementUnitValue';
	ModifyUnitValueB.UnitName = default.BLIND_PROTOCOL_RECHARGE_NAME;
	ModifyUnitValueB.NewValueToSet = default.HOT_CHARGED_BATTERIES_RECHARGE_PENALTY;
	ModifyUnitValueB.CleanupType = eCleanup_BeginTactical;
	Template.AddTargetEffect(ModifyUnitValueB);

	ModifyUnitValueC = new class'X2Effect_IncrementUnitValue';
	ModifyUnitValueC.UnitName = default.COMBAT_PROTOCOL_RECHARGE_NAME;
	ModifyUnitValueC.NewValueToSet = default.HOT_CHARGED_BATTERIES_RECHARGE_PENALTY;
	ModifyUnitValueC.CleanupType = eCleanup_BeginTactical;
	Template.AddTargetEffect(ModifyUnitValueC);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// 
static function X2AbilityTemplate WOTC_APA_FailsafeOneFree()
{

	local X2AbilityTemplate							Template;
	local X2Effect_SetUnitValue						SetUnitValEffect;
	local X2Effect_WOTC_APA_ElectronicWarfare		FreeFailsafeEffect;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_FailsafeOneFree');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_Failsafe";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;


	// Setup UnitValue to monitor the number of free Failsafe activations granted
	SetUnitValEffect = new class'X2Effect_SetUnitValue';
	SetUnitValEffect.UnitName = class'X2Effect_WOTC_APA_ElectronicWarfare'.default.FreeFailsafeActivationsUnitName;
	SetUnitValEffect.NewValueToSet = 1 + 0.1;
	SetUnitValEffect.CleanupType = eCleanup_BeginTactical;
	SetUnitValEffect.bApplyOnHit = true;
	SetUnitValEffect.bApplyOnMiss = true;
	Template.AddTargetEffect(SetUnitValEffect);


	// Setup effect allowing Failsafe to be activated for free
	FreeFailsafeEffect = new class 'X2Effect_WOTC_APA_ElectronicWarfare';
	FreeFailsafeEffect.BuildPersistentEffect (1, true, false, false);
	Template.AddTargetEffect(FreeFailsafeEffect);


	Template.AdditionalAbilities.AddItem('WOTC_APA_Failsafe');


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Upgraded Scanners - Passive:
static function X2AbilityTemplate WOTC_APA_UpgradedScanners()
{
	local X2AbilityTemplate										Template;

	Template = CreatePassiveAbility('WOTC_APA_UpgradedScanners', "img:///UILibrary_WOTC_APA_Class_Pack.perk_UpgradedScanners");

	return Template;
}



DefaultProperties
{
	AID_PROTOCOL_RECHARGE_NAME = "WOTC_APA_AidProtocolRecharge"
	BLIND_PROTOCOL_RECHARGE_NAME = "WOTC_APA_BlindingProtocolRecharge"
	COMBAT_PROTOCOL_RECHARGE_NAME = "WOTC_APA_CombatProtocolRecharge"
}