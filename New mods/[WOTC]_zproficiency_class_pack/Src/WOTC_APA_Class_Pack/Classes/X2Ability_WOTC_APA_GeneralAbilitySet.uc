class X2Ability_WOTC_APA_GeneralAbilitySet extends X2Ability_WOTC_APA_Utilities config(WOTC_APA_GeneralSkills);

// Ability Variables
var config int				FREE_MEDKIT_BONUS_CHARGES;
var config float			FARSEER_SQUADSIGHT_RANGE_PENALTY_MULTIPLIER;
var config array<name>		FARSEER_VALID_HUNTER_RIFLES;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	/**/`Log("WOTC_APA_General - Begin Adding Templates");

	Templates.AddItem(WOTC_APA_NaturalLeader());
	Templates.AddItem(WOTC_APA_AmbushToggle());
	/*»»»*/	Templates.AddItem(WOTC_APA_AmbushOn());
	/*»»»*/	Templates.AddItem(WOTC_APA_AmbushOff());
	/*»»»*/	Templates.AddItem(WOTC_APA_AmbushShot());
	/*»»»*/	Templates.AddItem(WOTC_APA_AmbushPistolShot());
	Templates.AddItem(WOTC_APA_Gunslinger());
	/*»»»*/	Templates.AddItem(WOTC_APA_Gunslinger_PistolShot());

	Templates.AddItem(WOTC_APA_FreeMedkit());
	Templates.AddItem(WOTC_APA_Farseer());
	
	/**/`Log("WOTC_APA_General - Finished Adding Templates");

	return Templates;
}


// Natural Leader - Ensures when the soldier is created or promoted with this ability, their Combat Intelligence is increased up to Gifted, if below.
static function X2AbilityTemplate WOTC_APA_NaturalLeader()
{

	local X2AbilityTemplate									Template;
	local X2Effect_WOTC_APA_NaturalLeader					ListenerEffect;

	Template = CreatePassiveAbility('WOTC_APA_NaturalLeader', "img:///UILibrary_WOTC_APA_Class_Pack.perk_NaturalLeader",, false);

	ListenerEffect = new class'X2Effect_WOTC_APA_NaturalLeader';
	ListenerEffect.BuildPersistentEffect(1, true, false);
	Template.AddTargetEffect(ListenerEffect);

	return Template;
}


// Ambush Toggle - Passive: Collector ability that grants the On and Off Ambush toggle abilities
static function X2AbilityTemplate WOTC_APA_AmbushToggle()
{

	local X2AbilityTemplate			Template;


	Template = CreatePassiveAbility('WOTC_APA_AmbushToggle', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Ambush",, false /*Don't show this icon in tactical*/);


	Template.AdditionalAbilities.AddItem('WOTC_APA_AmbushOn');
	Template.AdditionalAbilities.AddItem('WOTC_APA_AmbushOff');
	Template.AdditionalAbilities.AddItem('WOTC_APA_AmbushShot');
	Template.AdditionalAbilities.AddItem('WOTC_APA_AmbushPistolShot');


	return Template;
}

//
static function X2AbilityTemplate WOTC_APA_AmbushOn()
{

	local X2AbilityTemplate									Template;
	local X2AbilityCost_ActionPoints						ActionPointCost;
	//local X2Condition_WOTC_APA_Concealment					ConcealedCondition;
	local X2Condition_WOTC_APA_Class_EffectRequirement		ApplyCondition;
	local X2Effect_Persistent								ToggleEffect;


	Template = CreateSelfActiveAbility('WOTC_APA_AmbushOn', "img:///UILibrary_WOTC_APA_Class_Pack.perk_AmbushOff", false);
	
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY - 2;
	Template.bNoConfirmationWithHotKey = true;
	Template.bBypassAbilityConfirm = true;
	Template.bDontDisplayInAbilitySummary = true;
	Template.bDisplayInUITacticalText = false;
	Template.bDisplayInUITooltip = false;
	Template.bShowActivation = false;
	
	// Hide ability when concealment has been broken or other toggle is active
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
	//Template.HideErrors.AddItem('AA_UnitAlreadySpotted');
	Template.HideErrors.AddItem('AA_HasAnExcludingEffect');
	
	//ConcealedCondition = new class'X2Condition_WOTC_APA_Class_Concealment';
	//Template.AbilityShooterConditions.AddItem(ConcealedCondition);

	ApplyCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	ApplyCondition.ExcludingEffectNames.AddItem('WOTC_APA_AmbushEffect');
	ApplyCondition.bCheckSourceUnit = true;
	Template.AbilityShooterConditions.AddItem(ApplyCondition);


	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	ActionPointCost.AllowedTypes.AddItem(class'X2CharacterTemplateManager'.default.MoveActionPoint);
	Template.AbilityCosts.AddItem(ActionPointCost);

	
	ToggleEffect = new class'X2Effect_Persistent';
	ToggleEffect.EffectName = 'WOTC_APA_AmbushEffect';
	ToggleEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(ToggleEffect);
	

	Template.BuildVisualizationFn = BasicSourceFlyover_BuildVisualization;
	return Template;
}

//
static function X2AbilityTemplate WOTC_APA_AmbushOff()
{

	local X2AbilityTemplate									Template;
	local X2AbilityCost_ActionPoints						ActionPointCost;
	//local X2Condition_WOTC_APA_Class_Concealment					ConcealedCondition;
	local X2Condition_WOTC_APA_Class_EffectRequirement		ApplyCondition;
	local X2Effect_RemoveEffects							RemoveEffect;


	Template = CreateSelfActiveAbility('WOTC_APA_AmbushOff', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Ambush", false);
	
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_COLONEL_PRIORITY - 1;
	Template.bNoConfirmationWithHotKey = true;
	Template.bBypassAbilityConfirm = true;
	Template.bDontDisplayInAbilitySummary = true;
	Template.bDisplayInUITacticalText = false;
	Template.bDisplayInUITooltip = false;
	Template.bShowActivation = false;

	// Hide ability when concealment has been broken or other toggle is active
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
	//Template.HideErrors.AddItem('AA_UnitAlreadySpotted');
	Template.HideErrors.AddItem('AA_MissingRequiredEffect');
	
	//ConcealedCondition = new class'X2Condition_WOTC_APA_Class_Concealment';
	//Template.AbilityShooterConditions.AddItem(ConcealedCondition);

	ApplyCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	ApplyCondition.RequiredEffectNames.AddItem('WOTC_APA_AmbushEffect');
	ApplyCondition.bCheckSourceUnit = true;
	Template.AbilityShooterConditions.AddItem(ApplyCondition);
	

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	ActionPointCost.AllowedTypes.AddItem(class'X2CharacterTemplateManager'.default.MoveActionPoint);
	Template.AbilityCosts.AddItem(ActionPointCost);

	
	// Remove Effect
	RemoveEffect = new class'X2Effect_RemoveEffects';
	RemoveEffect.EffectNamesToRemove.AddItem('WOTC_APA_AmbushEffect');
	RemoveEffect.bCheckSource = true;
	Template.AddTargetEffect(RemoveEffect);
	

	Template.BuildVisualizationFn = BasicSourceFlyover_BuildVisualization;
	return Template;
}

// Ambush Overwatch Shot - Triggered:
static function X2AbilityTemplate WOTC_APA_AmbushShot()
{

	local X2AbilityTemplate                 Template;	
	local X2AbilityCost_Ammo                AmmoCost;
	local X2AbilityCost_ReserveActionPoints ReserveActionPointCost;
	local X2AbilityToHitCalc_StandardAim    StandardAim;
	local X2AbilityTarget_Single            SingleTarget;
	local X2AbilityTrigger_EventListener	Trigger;
	local X2Effect_Knockback				KnockbackEffect;
	local X2Condition_Visibility			TargetVisibilityCondition;
	local array<name>                       SkipExclusions;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_AmbushShot');
	
	Template.bDontDisplayInAbilitySummary = true;
	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;	
	Template.AbilityCosts.AddItem(AmmoCost);
	
	ReserveActionPointCost = new class'X2AbilityCost_ReserveActionPoints';
	ReserveActionPointCost.iNumPoints = 1;
	ReserveActionPointCost.AllowedTypes.AddItem(class'X2CharacterTemplateManager'.default.OverwatchReserveActionPoint);
	Template.AbilityCosts.AddItem(ReserveActionPointCost);
	
	StandardAim = new class'X2AbilityToHitCalc_StandardAim';
	StandardAim.bReactionFire = true;
	Template.AbilityToHitCalc = StandardAim;
	Template.AbilityToHitOwnerOnMissCalc = StandardAim;

	Template.AbilityTargetConditions.AddItem(default.LivingHostileUnitDisallowMindControlProperty);
	
	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	TargetVisibilityCondition.bRequireBasicVisibility = true;
	TargetVisibilityCondition.bDisablePeeksOnMovement = true; //Don't use peek tiles for over watch shots	
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);

	Template.AbilityTargetConditions.AddItem(new class'X2Condition_EverVigilant');
	Template.AbilityTargetConditions.AddItem(class'X2Ability_DefaultAbilitySet'.static.OverwatchTargetEffectsCondition());

	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	Template.AddShooterEffectExclusions(SkipExclusions);
	
	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.OnlyIncludeTargetsInsideWeaponRange = true;
	Template.AbilityTargetStyle = SingleTarget;

	//Trigger on movement - interrupt the move
	Trigger = new class'X2AbilityTrigger_EventListener';
	Trigger.ListenerData.EventID = 'ObjectMoved';
	Trigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	Trigger.ListenerData.Filter = eFilter_None;
	Trigger.ListenerData.EventFn = class'XComGameState_Ability'.static.TypicalOverwatchListener;
	Template.AbilityTriggers.AddItem(Trigger);
	
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_overwatch";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.OVERWATCH_PRIORITY;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.DisplayTargetHitChance = false;

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = OverwatchShot_BuildVisualization;
	Template.bAllowFreeFireWeaponUpgrade = false;	
	Template.bAllowAmmoEffects = true;
	Template.AssociatedPassives.AddItem('HoloTargeting');

	//  Put holo target effect first because if the target dies from this shot, it will be too late to notify the effect.
	Template.AddTargetEffect(class'X2Ability_Chosen'.static.HoloTargetEffect());
	Template.AddTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.HoloTargetEffect());
	Template.AddTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect());
	Template.bAllowBonusWeaponEffects = true;

	// Damage Effect
	Template.AddTargetEffect(default.WeaponUpgradeMissDamage);

	KnockbackEffect = new class'X2Effect_Knockback';
	KnockbackEffect.KnockbackDistance = 2;
	Template.AddTargetEffect(KnockbackEffect);

	class'X2StrategyElement_XpackDarkEvents'.static.AddStilettoRoundsEffect(Template);

	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;
	Template.bFrameEvenWhenUnitIsHidden = true;

	Template.AbilityShooterConditions.AddItem(new class'X2Condition_WOTC_APA_Class_AmbushCondition');
	//Template.DefaultSourceItemSlot = eInvSlot_PrimaryWeapon;
	Template.OverrideAbilities.AddItem('OverwatchShot');
	Template.bUniqueSource = true;
	
	return Template;	
}

// Ambush Pistol Overwatch Shot - Triggered:
static function X2AbilityTemplate WOTC_APA_AmbushPistolShot()
{
	
	local X2AbilityTemplate                 Template;
	local X2AbilityCost_ReserveActionPoints ReserveActionPointCost;
	local X2AbilityToHitCalc_StandardAim    StandardAim;
	local X2Effect_ApplyWeaponDamage        WeaponDamageEffect;
	local X2AbilityTarget_Single            SingleTarget;
	local X2AbilityTrigger_EventListener	Trigger;
	local X2Effect_Knockback				KnockbackEffect;
	local array<name>                       SkipExclusions;
	local X2Condition_Visibility            TargetVisibilityCondition;
	local X2AbilityCost_Ammo				AmmoCost;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_AmbushPistolShot');

	Template.bDontDisplayInAbilitySummary = true;
	ReserveActionPointCost = new class'X2AbilityCost_ReserveActionPoints';
	ReserveActionPointCost.iNumPoints = 1;
	ReserveActionPointCost.AllowedTypes.AddItem(class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint);
	ReserveActionPointCost.AllowedTypes.AddItem(class'X2CharacterTemplateManager'.default.ReturnFireActionPoint);
	Template.AbilityCosts.AddItem(ReserveActionPointCost);

	//	pistols are typically infinite ammo weapons which will bypass the ammo cost automatically.
	//  but if this ability is attached to a weapon that DOES use ammo, it should use it.
	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);
	
	StandardAim = new class'X2AbilityToHitCalc_StandardAim';
	StandardAim.bReactionFire = true;
	Template.AbilityToHitCalc = StandardAim;
	Template.AbilityToHitOwnerOnMissCalc = StandardAim;

	Template.AbilityTargetConditions.AddItem(default.LivingHostileUnitDisallowMindControlProperty);	
	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	TargetVisibilityCondition.bRequireBasicVisibility = true;
	TargetVisibilityCondition.bDisablePeeksOnMovement = true; //Don't use peek tiles for over watch shots	
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);

	Template.AbilityTargetConditions.AddItem(new class'X2Condition_EverVigilant');
	Template.AbilityTargetConditions.AddItem(class'X2Ability_DefaultAbilitySet'.static.OverwatchTargetEffectsCondition());

	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	Template.AddShooterEffectExclusions(SkipExclusions);
	
	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.OnlyIncludeTargetsInsideWeaponRange = true;
	Template.AbilityTargetStyle = SingleTarget;

	//Trigger on movement - interrupt the move
	Trigger = new class'X2AbilityTrigger_EventListener';
	Trigger.ListenerData.EventID = 'ObjectMoved';
	Trigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	Trigger.ListenerData.Filter = eFilter_None;
	Trigger.ListenerData.EventFn = class'XComGameState_Ability'.static.TypicalOverwatchListener;
	Template.AbilityTriggers.AddItem(Trigger);

	Template.CinescriptCameraType = "StandardGunFiring";	
	
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_overwatch";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.PISTOL_OVERWATCH_PRIORITY;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.DisplayTargetHitChance = false;

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.bAllowFreeFireWeaponUpgrade = false;	
	Template.bAllowAmmoEffects = true;

	// Damage Effect
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	Template.AddTargetEffect(WeaponDamageEffect);
	Template.bAllowBonusWeaponEffects = true;
	
	KnockbackEffect = new class'X2Effect_Knockback';
	KnockbackEffect.KnockbackDistance = 2;
	Template.AddTargetEffect(KnockbackEffect);

	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;
	Template.bFrameEvenWhenUnitIsHidden = true;

	Template.AbilityShooterConditions.AddItem(new class'X2Condition_WOTC_APA_Class_AmbushCondition');
	Template.OverrideAbilities.AddItem('PistolOverwatchShot');
	Template.bUniqueSource = true;

	return Template;
}


// Gunslinger - Allows a soldier to overwatch with or fire a pistol with movement or momentum action points
static function X2AbilityTemplate WOTC_APA_Gunslinger()
{

	local X2AbilityTemplate									Template;
	local X2Effect_WOTC_APA_Gunslinger						ActionEffect;

	Template = CreatePassiveAbility('WOTC_APA_Gunslinger', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Gunslinger");

	// Allows PistolOverwatch to be activated with Movement or Momentum action points
	ActionEffect = new class'X2Effect_WOTC_APA_Gunslinger';
	ActionEffect.BuildPersistentEffect(1, true, false);
	ActionEffect.EffectName = 'WOTC_APA_Gunslinger_ActionEffect';
	Template.AddTargetEffect(ActionEffect);

	Template.AdditionalAbilities.AddItem('WOTC_APA_Gunslinger_PistolShot');

	return Template;
}

// Gunslinger PistolShot - Overrides regular pistol shot allowing additional action point types
static function X2AbilityTemplate WOTC_APA_Gunslinger_PistolShot()
{

	local X2AbilityTemplate									Template;
	local X2AbilityCost_ActionPoints						ActionPointCost;
	local X2AbilityCost_Ammo								AmmoCost;
	
	Template = class'X2Ability_WeaponCommon'.static.Add_PistolStandardShot('WOTC_APA_Gunslinger_PistolShot');

	// Clear and recreate template AbilityCosts
	Template.AbilityCosts.Length = 0;

	// Action Point
	ActionPointCost = new class'X2AbilityCost_QuickdrawActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.DoNotConsumeAllSoldierAbilities.AddItem('WOTC_APA_Quickdraw');
	ActionPointCost.AllowedTypes.AddItem(class'X2CharacterTemplateManager'.default.MoveActionPoint);
	ActionPointCost.AllowedTypes.AddItem(class'X2CharacterTemplateManager'.default.MomentumActionPoint);
	Template.AbilityCosts.AddItem(ActionPointCost);	

	// Ammo
	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);
	Template.bAllowAmmoEffects = true; // 	
	Template.bAllowBonusWeaponEffects = true;

	Template.OverrideAbilities.AddItem('PistolStandardShot');

	return Template;
}


// Free Medkit - Passive: Grants [default: 1] free medkit charge
static function X2AbilityTemplate WOTC_APA_FreeMedkit()
{

	local X2AbilityTemplate									Template;
	local X2Effect_WOTC_APA_Class_BonusItems				MedkitEffect;
	
	Template = CreatePassiveAbility('WOTC_APA_FreeMedkit',,, false);

	MedkitEffect = new class'X2Effect_WOTC_APA_Class_BonusItems';
	MedkitEffect.BonusItems = class'X2Ability_WOTC_APA_MedicAbilitySet'.default.MED_BONUS_MEDKITS_VALID_ITEMS;
	MedkitEffect.FreeCharges = default.FREE_MEDKIT_BONUS_CHARGES;
	MedkitEffect.BuildPersistentEffect (1, true, false, false);

	return Template;
}


// Farseer - Passive: Allow the unit to equip sniper rifles and, when equipped, gain the Squadsight & Longwatch ability
static function X2AbilityTemplate WOTC_APA_Farseer()
{
	
	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_AddAbilitiesToTarget			WeaponAbilityEffect;
	local X2Condition_WOTC_APA_FarseerWeaponCondition			WeaponCondition;
	local X2Effect_WOTC_APA_Class_NegateRangePenalty			PenaltyEffect;


	Template = CreatePassiveAbility('WOTC_APA_Farseer', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Farseer",, false);


	// Create effect to add Squadsight & Longwatch
	WeaponAbilityEffect = new class'X2Effect_WOTC_APA_Class_AddAbilitiesToTarget';
	WeaponAbilityEffect.AddAbilities.AddItem('Longwatch');
	WeaponAbilityEffect.AddAbilities.AddItem('Squadsight');
	WeaponAbilityEffect.ApplyToWeaponSlot = eInvSlot_PrimaryWeapon;
	Template.AddTargetEffect(WeaponAbilityEffect);


	// Create effect to double squadsight penalties when a Sniper Rifle is not equipped
	WeaponCondition = new class'X2Condition_WOTC_APA_FarseerWeaponCondition';
	WeaponCondition.ValidHunterRifles = default.FARSEER_VALID_HUNTER_RIFLES;

	PenaltyEffect = new class'X2Effect_WOTC_APA_Class_NegateRangePenalty';
	PenaltyEffect.RangePenaltyPercentNegated = -default.FARSEER_SQUADSIGHT_RANGE_PENALTY_MULTIPLIER;
	PenaltyEffect.BuildPersistentEffect(1, true, true);
	PenaltyEffect.EffectName = 'WOTC_APA_FarseerSquadsightPenaltyEffect';
	PenaltyEffect.DuplicateResponse = eDupe_Ignore;
	PenaltyEffect.bSkipWeaponRangeModifier = true;
	PenaltyEffect.bLimitToSquadSightRange = true;
	PenaltyEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage,,,Template.AbilitySourceName);
	PenaltyEffect.TargetConditions.AddItem(WeaponCondition);
	Template.AddTargetEffect(PenaltyEffect);


	return Template;
}



defaultproperties
{
	
}