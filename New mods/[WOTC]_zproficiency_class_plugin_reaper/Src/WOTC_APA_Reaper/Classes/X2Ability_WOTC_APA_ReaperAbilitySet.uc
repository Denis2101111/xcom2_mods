
class X2Ability_WOTC_APA_ReaperAbilitySet extends X2Ability config(WOTC_APA_ReaperSkills);


var config int				SHADOW_STACK_MAX_I;
var config int				SHADOW_STACK_MAX_II;
var config int				SHADOW_STACK_MAX_III;

var config int				SHADOW_STACK_START_I;
var config int				SHADOW_STACK_START_II;
var config int				SHADOW_STACK_START_III;

var config int				SHADOW_STACK_GAIN_PER_TURN;
var config int				SHADOW_STACK_GAIN_HUNKER;
var config int				SHADOW_STACK_PRIMARY_ATTACK_COST;
var config int				SHADOW_STACK_SECONDARY_ATTACK_COST;

var config float			SHADOW_STACK_STATIC_DETECTION_BONUS;
var config float			SHADOW_STACK_VARIABLE_DETECTION_BONUS;
var config int				SHADOW_STACK_CRIT_CHANCE_BONUS;

var name					SHADOW_STACK_CURRENT_NAME;
var name					SHADOW_STACK_MAX_NAME;

var localized string		strShadow1Name;
var localized string		strShadow1Desc;
var localized string		strShadow2Name;
var localized string		strShadow2Desc;
var localized string		strShadow3Name;
var localized string		strShadow3Desc;

var localized string		strShadowStackName;
var localized string		strShadowStackDesc;


var config array<name>		SILENT_KILLER_EXCLUDED_ABILITIES;
var config int				INFILTRATION_HACK_BONUS;
var config int				INFILTRATION_RECONCEAL_SHADOW_STACKS;
var config int				HAUNT_DAMAGE_BONUS;
var config int				HAUNT_PANIC_CHANCE;
var config int				HAUNT_PANIC_RANGE;
var config int				BEAST_HUNTER_DAMAGE_BONUS;
var config float			BEAST_HUNTER_SHADOW_CRIT_CHANCE_MOD;
var config array<name>		BEAST_HUNTER_ENEMY_TYPES;
var config int				SHADOW_VALUE_THRESHOLD_I;
var config int				SHADOW_VALUE_THRESHOLD_II;
var config int				SHADOW_VALUE_THRESHOLD_III;
var config int				WEAKPOINT_ARMOR_PIERCE_I;
var config int				WEAKPOINT_ARMOR_PIERCE_II;
var config int				WEAKPOINT_ARMOR_PIERCE_III;
var config int				HOUND_MOBILITY_BONUS_I;
var config int				HOUND_MOBILITY_BONUS_II;
var config int				HOUND_MOBILITY_BONUS_III;
var config int				PRECISE_STRIKE_COVER_AIM_BONUS_I;
var config int				PRECISE_STRIKE_COVER_AIM_BONUS_II;
var config int				PRECISE_STRIKE_COVER_AIM_BONUS_III;
var config int				UNDERMINE_RUPTURE_DAMAGE;
var config int				ANNIHILATION_CHARGE_BONUS;
var config int				ANNIHILATION_BANISH_COOLDOWN;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	/**/`Log("WOTC_APA_Reaper - Begin Adding Templates");

	Templates.AddItem(WOTC_APA_Shadow());
	/*»»»*/	Templates.AddItem(WOTC_APA_HunkerTracker());
	/*»»»*/	Templates.AddItem(WOTC_APA_ReaperHack());
	Templates.AddItem(WOTC_APA_Fade());
	Templates.AddItem(WOTC_APA_SilentKiller());
	// Ambush Toggle
	
	Templates.AddItem(WOTC_APA_Infiltration());
	Templates.AddItem(WOTC_APA_Phase());
	// Hawkeye

	// Quickdraw
	Templates.AddItem(WOTC_APA_Vanish());

	// Weapon Specialist
	Templates.AddItem(WOTC_APA_Haunt());
	/*»»»*/	Templates.AddItem(WOTC_APA_HauntPanic());
	Templates.AddItem(WOTC_APA_BeastHunter());

	Templates.AddItem(WOTC_APA_Weakpoint());
	Templates.AddItem(WOTC_APA_Hound());
	Templates.AddItem(WOTC_APA_PreciseStrike());
	
	// Faceoff
	// Banish
	// High Caliber

	Templates.AddItem(WOTC_APA_Undermine());
	Templates.AddItem(WOTC_APA_Annihilation());
	// Steady Hands

	
	/**/`Log("WOTC_APA_Reaper - Finished Adding Templates");

	return Templates;
}


// Shadow - Base Class Proficiency Ability
static function X2AbilityTemplate WOTC_APA_Shadow()
{
	
	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_TargetRankRequirement			RankCondition1, RankCondition2, RankCondition3;
	local X2Effect_SetUnitValue									SetMaxValue1, SetMaxValue2, SetMaxValue3;
	local X2Effect_SetUnitValue									SetStartValue1, SetStartValue2, SetStartValue3;
	local X2Effect_WOTC_APA_IncrementShadow						ShadowEffect;
	local X2Effect_WOTC_APA_ShadowConditionalBonuses			StatEffect1, StatEffect2, StatEffect3;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_Shadow');
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_shadow"; 
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;
	
	
	// Establish Rank conditions for each Proficiency Level effect:
	RankCondition1 = new class 'X2Condition_WOTC_APA_TargetRankRequirement';
	RankCondition1.iMinRank = -1;	// No minimum rank for level 1 bonuses
	RankCondition1.iMaxRank = 2;	// Max rank is 1 below minimum rank for level 2 bonuses
	RankCondition1.ExcludeProject = 'WOTC_APA_ReaperUnlock1';

	RankCondition2 = new class 'X2Condition_WOTC_APA_TargetRankRequirement';
	RankCondition2.iMinRank = 3;
	RankCondition2.iMaxRank = 5;
	RankCondition2.ExcludeProject = 'WOTC_APA_ReaperUnlock2';
	RankCondition2.GiveProject = 'WOTC_APA_ReaperUnlock1';
	
	RankCondition3 = new class 'X2Condition_WOTC_APA_TargetRankRequirement';
	RankCondition3.iMinRank = 6;
	RankCondition3.iMaxRank = -1;	// No max rank for level 3 bonuses
	RankCondition3.GiveProject = 'WOTC_APA_ReaperUnlock2';
	

	// Set Maximum Shadow Stacks according to rank conditions
	SetMaxValue1 = new class'X2Effect_SetUnitValue';
	SetMaxValue1.UnitName = default.SHADOW_STACK_MAX_NAME;
	SetMaxValue1.NewValueToSet = default.SHADOW_STACK_MAX_I;
	SetMaxValue1.CleanupType = eCleanup_BeginTactical;
	SetMaxValue1.TargetConditions.AddItem(RankCondition1);
	Template.AddTargetEffect(SetMaxValue1);

	SetMaxValue2 = new class'X2Effect_SetUnitValue';
	SetMaxValue2.UnitName = default.SHADOW_STACK_MAX_NAME;
	SetMaxValue2.NewValueToSet = default.SHADOW_STACK_MAX_II;
	SetMaxValue2.CleanupType = eCleanup_BeginTactical;
	SetMaxValue2.TargetConditions.AddItem(RankCondition2);
	Template.AddTargetEffect(SetMaxValue2);

	SetMaxValue3 = new class'X2Effect_SetUnitValue';
	SetMaxValue3.UnitName = default.SHADOW_STACK_MAX_NAME;
	SetMaxValue3.NewValueToSet = default.SHADOW_STACK_MAX_III;
	SetMaxValue3.CleanupType = eCleanup_BeginTactical;
	SetMaxValue3.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(SetMaxValue3);


	// Set Initial Shadow Stacks according to rank conditions
	SetStartValue1 = new class'X2Effect_SetUnitValue';
	SetStartValue1.UnitName = default.SHADOW_STACK_CURRENT_NAME;
	SetStartValue1.NewValueToSet = default.SHADOW_STACK_START_I - 1;
	SetStartValue1.CleanupType = eCleanup_BeginTactical;
	SetStartValue1.TargetConditions.AddItem(RankCondition1);
	Template.AddTargetEffect(SetStartValue1);

	SetStartValue2 = new class'X2Effect_SetUnitValue';
	SetStartValue2.UnitName = default.SHADOW_STACK_CURRENT_NAME;
	SetStartValue2.NewValueToSet = default.SHADOW_STACK_START_II - 1;
	SetStartValue2.CleanupType = eCleanup_BeginTactical;
	SetStartValue2.TargetConditions.AddItem(RankCondition2);
	Template.AddTargetEffect(SetStartValue2);

	SetStartValue3 = new class'X2Effect_SetUnitValue';
	SetStartValue3.UnitName = default.SHADOW_STACK_CURRENT_NAME;
	SetStartValue3.NewValueToSet = default.SHADOW_STACK_START_III - 1;
	SetStartValue3.CleanupType = eCleanup_BeginTactical;
	SetStartValue3.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(SetStartValue3);


	// Setup effect to handle conditional stat bonuses and passive icon
	StatEffect1 = new class'X2Effect_WOTC_APA_ShadowConditionalBonuses';
	StatEffect1.BuildPersistentEffect (1, true, false, false);
	//StatEffect1.AddPersistentStatChange(eStat_DetectionModifier, default.SHADOW_STACK_START_I * default.SHADOW_STACK_DETECTION_BONUS);
	StatEffect1.SetDisplayInfo(ePerkBuff_Passive, default.strShadow1Name, default.strShadow1Desc, "img:///UILibrary_WOTC_APA_Reaper.perk_Shadow1", true,, Template.AbilitySourceName);
	StatEffect1.TargetConditions.AddItem(RankCondition1);
	Template.AddTargetEffect(StatEffect1);

	StatEffect2 = new class'X2Effect_WOTC_APA_ShadowConditionalBonuses';
	StatEffect2.BuildPersistentEffect (1, true, false, false);
	//StatEffect2.AddPersistentStatChange(eStat_DetectionModifier, default.SHADOW_STACK_START_II * default.SHADOW_STACK_DETECTION_BONUS);
	StatEffect2.SetDisplayInfo(ePerkBuff_Passive, default.strShadow2Name, default.strShadow2Desc, "img:///UILibrary_WOTC_APA_Reaper.perk_Shadow2", true,, Template.AbilitySourceName);
	StatEffect2.TargetConditions.AddItem(RankCondition2);
	Template.AddTargetEffect(StatEffect2);

	StatEffect3 = new class'X2Effect_WOTC_APA_ShadowConditionalBonuses';
	StatEffect3.BuildPersistentEffect (1, true, false, false);
	//StatEffect3.AddPersistentStatChange(eStat_DetectionModifier, default.SHADOW_STACK_START_III * default.SHADOW_STACK_DETECTION_BONUS);
	StatEffect3.SetDisplayInfo(ePerkBuff_Passive, default.strShadow3Name, default.strShadow3Desc, "img:///UILibrary_WOTC_APA_Reaper.perk_Shadow3", true,, Template.AbilitySourceName);
	StatEffect3.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(StatEffect3);


	// Add effect to handle incrementing Shadow Stacks and Hunker Down tracker ability
	ShadowEffect = new class'X2Effect_WOTC_APA_IncrementShadow';
	ShadowEffect.BuildPersistentEffect(1, true, false, false, eGameRule_PlayerTurnBegin);
	ShadowEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false,, Template.AbilitySourceName);
	Template.AddTargetEffect(ShadowEffect);

	Template.AdditionalAbilities.AddItem('WOTC_APA_HunkerTracker');


	// Add effect to grant the Reaper's Advent Tower hack ability tied to their XPad
	Template.AddTargetEffect(new class'X2Effect_WOTC_APA_AddReaperHack');


	// Add Ambush abilities
	//Template.AdditionalAbilities.AddItem('WOTC_APA_AmbushOn');
	//Template.AdditionalAbilities.AddItem('WOTC_APA_AmbushOff');
	//Template.AdditionalAbilities.AddItem('WOTC_APA_AmbushShot');
	//Template.AdditionalAbilities.AddItem('WOTC_APA_AmbushPistolShot');
		

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

// Hunker Tracker - Passive: Ability to help track whether the unit Hunkered Down last turn or not
static function X2AbilityTemplate WOTC_APA_HunkerTracker()
{
	
	local X2AbilityTemplate						Template;
	local X2AbilityTrigger_OnAbilityActivated	ActivationTrigger;
	local X2Effect_Persistent					TrackerEffect;
	

	`CREATE_X2ABILITY_TEMPLATE (Template, 'WOTC_APA_HunkerTracker');
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bCrossClassEligible = false;
	Template.bUniqueSource = true;
	Template.bIsPassive = true;


	// Activate when this unit uses the HunkerDown ability (Includes when triggered via Deep Cover)
	ActivationTrigger = new class'X2AbilityTrigger_OnAbilityActivated';
	ActivationTrigger.SetListenerData('HunkerDown');
	Template.AbilityTriggers.AddItem(ActivationTrigger);


	// Create tracking persistent effects to tell other effects this unit previously Hunkered Down
	// Add two 1-turn duration effects that will cover all situations, no matter when Hunkering happens
	TrackerEffect = new class'X2Effect_Persistent';
	TrackerEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	TrackerEffect.EffectName = 'WOTC_APA_Shadow_HunkeredDownTracker';
	TrackerEffect.DuplicateResponse = eDupe_Allow;
	Template.AddTargetEffect(TrackerEffect);

	TrackerEffect = new class'X2Effect_Persistent';
	TrackerEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnEnd);
	TrackerEffect.EffectName = 'WOTC_APA_Shadow_HunkeredDownTracker';
	TrackerEffect.DuplicateResponse = eDupe_Allow;
	Template.AddTargetEffect(TrackerEffect);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Reaper Hack - Active: Allows the Reaper to hack Advent Towers when adjacent
static function X2AbilityTemplate WOTC_APA_ReaperHack()
{

	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_ReaperHack						HackCondition;


	Template = class'X2Ability_DefaultAbilitySet'.static.AddHackAbility('WOTC_APA_ReaperHack');


	// Remove existing ability target conditions
	Template.AbilityTargetConditions.Length = 0;

	// Define new hack targeting condition allowing Reaper to hack Advent towers when adjacent
	HackCondition = new class'X2Condition_WOTC_APA_ReaperHack';
	Template.AbilityTargetConditions.AddItem(HackCondition);


	return Template;
}


// Fade - Passive:
static function X2AbilityTemplate WOTC_APA_Fade()
{

	local X2AbilityTemplate			Template;
	local X2Effect_WOTC_APA_Fade	ConcealEffect;


	Template = CreatePassiveAbility('WOTC_APA_Fade', "img:///UILibrary_WOTC_APA_Reaper.perk_Fade");


	// Setup effect triggering reconceal events
	ConcealEffect = new class'X2Effect_WOTC_APA_Fade';
	ConcealEffect.BuildPersistentEffect(1, true, false, false, eGameRule_PlayerTurnBegin);
	Template.AddTargetEffect(ConcealEffect);


	return Template;
}


// Silent Killer - Passive:
static function X2AbilityTemplate WOTC_APA_SilentKiller()
{

	local X2AbilityTemplate			Template;

	Template = CreatePassiveAbility('WOTC_APA_SilentKiller', "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_shadowrising");

	// Effect is handled in X2EventListener_WOTC_APA_Reaper

	return Template;
}


// Infiltration - Passive:
static function X2AbilityTemplate WOTC_APA_Infiltration()
{

	local X2AbilityTemplate											Template;
	local X2Effect_PersistentStatChange								StatEffect;
	local X2Effect_WOTC_APA_ShadowReconceal							ReconcealEffect;


	Template = CreatePassiveAbility('WOTC_APA_Infiltration', "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_Infiltration");


	// Create a persistent stat change effect that adds [default: 30] to Hack skill
	StatEffect = new class 'X2Effect_PersistentStatChange';
	StatEffect.EffectName = 'WOTC_APA_InfiltrationStatEffect';
	StatEffect.BuildPersistentEffect(1, true, false, false);
	StatEffect.AddPersistentStatChange(eStat_Hacking, default.INFILTRATION_HACK_BONUS);
	Template.AddTargetEffect(StatEffect);

	Template.SetUIStatMarkup(class'XLocalizedData'.default.TechLabel, eStat_Hacking, default.INFILTRATION_HACK_BONUS);


	// Create a persistent effect that will add [default: 2] additional Shadow Stacks when reconcealing
	ReconcealEffect = new class'X2Effect_WOTC_APA_ShadowReconceal';
	ReconcealEffect.EffectName = 'WOTC_APA_InfiltrationReconcealEffect';
	ReconcealEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(ReconcealEffect);


	// Override original Infiltration ability incase used mid-campaign where the Reaper GTS has already been unlocked.
	Template.OverrideAbilities.AddItem('Infiltration');


	return Template;
}


// Phase - Passive:
static function X2AbilityTemplate WOTC_APA_Phase()
{

	local X2AbilityTemplate			Template;


	Template = CreatePassiveAbility('WOTC_APA_Phase', "img:///UILibrary_WOTC_APA_Reaper.perk_Phase",, false /*Don't show this icon in tactical*/);


	Template.AdditionalAbilities.AddItem('Shadowstep');
	Template.AdditionalAbilities.AddItem('WOTC_APA_Reposition');


	return Template;
}


// Vanish - Passive:
static function X2AbilityTemplate WOTC_APA_Vanish()
{

	local X2AbilityTemplate			Template;
	local X2Effect_WOTC_APA_Fade	ConcealEffect;


	Template = CreatePassiveAbility('WOTC_APA_Vanish', "img:///UILibrary_WOTC_APA_Reaper.perk_Vanish");


	// Setup effect triggering reconceal events
	ConcealEffect = new class'X2Effect_WOTC_APA_Fade';
	ConcealEffect.BuildPersistentEffect(1, true, false, false, eGameRule_PlayerTurnEnd);
	Template.AddTargetEffect(ConcealEffect);


	Template.AdditionalAbilities.AddItem('Stealth');


	return Template;
}


// Haunt - Passive: 
static function X2AbilityTemplate WOTC_APA_Haunt()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Haunt								DamageEffect;


	Template = CreatePassiveAbility('WOTC_APA_Haunt', "img:///UILibrary_WOTC_APA_Reaper.perk_Haunt");


	// Create a persistent effect that increases damage against enemies already wounded this turn
	DamageEffect = new class'X2Effect_WOTC_APA_Haunt';
	DamageEffect.BonusDamage = default.HAUNT_DAMAGE_BONUS;
	DamageEffect.EffectName = 'WOTC_APA_HauntDamageEffect';
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false, , Template.AbilitySourceName);
	Template.AddTargetEffect(DamageEffect);


	Template.AdditionalAbilities.AddItem('WOTC_APA_HauntPanic');

	
	return Template;
}

// Haunt Panic - Triggered: 
static function X2AbilityTemplate WOTC_APA_HauntPanic()
{

	local X2AbilityTemplate										Template;	
	local X2AbilityTrigger_EventListener						EventListener;
	local X2AbilityMultiTarget_Radius							RadiusMultiTarget;
	local X2Condition_UnitProperty								UnitPropertyCondition;
	local X2Effect_Persistent									PanickedEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_HauntPanic');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Reaper.perk_Haunt";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bDontDisplayInAbilitySummary = true;
	Template.bDisplayInUITooltip = false;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.bCrossClassEligible = false;


	// This ability fires when the unit is revealed
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = 'UnitConcealmentBroken';
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	EventListener.ListenerData.Filter = eFilter_Unit;
	Template.AbilityTriggers.AddItem(EventListener);


	// Setup Multitarget attributes
	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.bIgnoreBlockingCover = true;
	RadiusMultiTarget.bAllowDeadMultiTargetUnits = false;
	RadiusMultiTarget.bExcludeSelfAsTargetIfWithinRadius = false;
	RadiusMultiTarget.bUseWeaponRadius = false;
	RadiusMultiTarget.fTargetRadius = 1.5 * (default.HAUNT_PANIC_RANGE + 0.1);
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;


	// Don't apply to allies, robots, or civilians
	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeRobotic = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = true;
	UnitPropertyCondition.ExcludeHostileToSource = false;
	UnitPropertyCondition.ExcludeCivilian = true;
	UnitPropertyCondition.FailOnNonUnits = true;
	Template.AbilityMultiTargetConditions.AddItem(UnitPropertyCondition);


	// Create the Panic effect on the targets
	PanickedEffect = class'X2StatusEffects'.static.CreatePanickedStatusEffect();
	PanickedEffect.ApplyChanceFn = WOTC_APA_HauntPanicApplyChance;
	Template.AddMultiTargetEffect(PanickedEffect);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}

function name WOTC_APA_HauntPanicApplyChance(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState)
{
	local XComGameState_Unit TargetUnit;
	local name ImmuneName;
	local int RandRoll;

	TargetUnit = XComGameState_Unit(kNewTargetState);
	if (TargetUnit != none)
	{
		foreach class'X2AbilityToHitCalc_PanicCheck'.default.PanicImmunityAbilities(ImmuneName)
		{
			if (TargetUnit.FindAbility(ImmuneName).ObjectID != 0)
			{
				return 'AA_UnitIsImmune';
			}
		}

		RandRoll = `SYNC_RAND(100);
		if (RandRoll < default.HAUNT_PANIC_CHANCE)
		{
			return 'AA_Success';
		}
	}

	return 'AA_EffectChanceFailed';
}


// Beast Hunter (Xenovore) - Passive:
static function X2AbilityTemplate WOTC_APA_BeastHunter()
{

	local X2AbilityTemplate					Template;
	local X2Effect_WOTC_APA_BeastHunter		DamageEffect;


	Template = CreatePassiveAbility('WOTC_APA_BeastHunter', "img:///UILibrary_WOTC_APA_Reaper.perk_BeastHunter");


	// Create a persistent effect that increases [default: pistol] armor pierce based on current shadow stacks
	DamageEffect = new class'X2Effect_WOTC_APA_BeastHunter';
	DamageEffect.EffectName = 'WOTC_APA_BeastHunterDamageEffect';
	DamageEffect.BonusDamage = default.BEAST_HUNTER_DAMAGE_BONUS;
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false, , Template.AbilitySourceName);
	Template.AddTargetEffect(DamageEffect);


	return Template;
}


// Weakpoint - Passive: 
static function X2AbilityTemplate WOTC_APA_Weakpoint()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Weakpoint							PierceEffect;


	Template = CreatePassiveAbility('WOTC_APA_Weakpoint', "img:///UILibrary_WOTC_APA_Reaper.perk_Weakpoint");


	// Create a persistent effect that increases [default: pistol] armor pierce based on current shadow stacks
	PierceEffect = new class'X2Effect_WOTC_APA_Weakpoint';
	PierceEffect.EffectName = 'WOTC_APA_WeakpointPierceEffect';
	PierceEffect.BuildPersistentEffect(1, true, false, false);
	PierceEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false, , Template.AbilitySourceName);
	Template.AddTargetEffect(PierceEffect);

	
	return Template;
}


// Hound - Passive:
static function X2AbilityTemplate WOTC_APA_Hound()
{

	local X2AbilityTemplate			Template;

	Template = CreatePassiveAbility('WOTC_APA_Hound', "img:///UILibrary_WOTC_APA_Reaper.perk_Hound");

	// Effect is handled in X2Effect_WOTC_APA_ShadowConditionalBonuses

	return Template;
}


// Precise Strike - Passive: 
static function X2AbilityTemplate WOTC_APA_PreciseStrike()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_PreciseStrike						AimEffect;


	Template = CreatePassiveAbility('WOTC_APA_PreciseStrike', "img:///UILibrary_WOTC_APA_Reaper.perk_UnsuspectingPrey");


	// Create a persistent effect that decreases targets' chance to dodge based on current shadow stacks
	AimEffect = new class'X2Effect_WOTC_APA_PreciseStrike';
	AimEffect.EffectName = 'WOTC_APA_PreciseStrikeEffect';
	AimEffect.BuildPersistentEffect(1, true, false, false);
	AimEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false, , Template.AbilitySourceName);
	Template.AddTargetEffect(AimEffect);

	
	return Template;
}


// Undermine - Passive: 
static function X2AbilityTemplate WOTC_APA_Undermine()
{

	local X2AbilityTemplate										Template;


	Template = CreatePassiveAbility('WOTC_APA_Undermine', "img:///UILibrary_WOTC_APA_Reaper.perk_Undermine");

	
	return Template;
}


// Annihilation - Passive: 
static function X2AbilityTemplate WOTC_APA_Annihilation()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_ModifyAbilityCharges				BanishChargeBonus;


	Template = CreatePassiveAbility('WOTC_APA_Annihilation', "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_SoulHarvester",, false /*Don't show this icon in tactical*/);


	// Create an effect that increases the charges for Banish (SoulHarvester)
	BanishChargeBonus = new class 'X2Effect_WOTC_APA_ModifyAbilityCharges';
	BanishChargeBonus.AbilitiesToModify.AddItem('SoulHarvester');
	BanishChargeBonus.iChargeModifier = default.ANNIHILATION_CHARGE_BONUS;
	BanishChargeBonus.BuildPersistentEffect (1, true, false, false);
	Template.AddTargetEffect(BanishChargeBonus);


	Template.AdditionalAbilities.AddItem('SoulHarvester');
	Template.PrerequisiteAbilities.AddItem('SoulReaper');

	
	return Template;
}



// ---------------------------------------------------------------------------------
// --------------------  ABILITY  FRAMEWORK  HELPER  FUNCTIONS  --------------------
// ---------------------------------------------------------------------------------


// Helper function to setup basic framework for passive abilities
static function X2AbilityTemplate CreatePassiveAbility(name AbilityName, optional string IconString, optional name IconEffectName = AbilityName, optional bool bDisplayIcon = true)
{
	
	local X2AbilityTemplate					Template;
	local X2Effect_Persistent				IconEffect;
	

	`CREATE_X2ABILITY_TEMPLATE (Template, AbilityName);
	Template.IconImage = IconString;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;
	Template.bUniqueSource = true;
	Template.bIsPassive = true;

	// Dummy effect to show a passive icon in the tactical UI for the SourceUnit
	IconEffect = new class'X2Effect_Persistent';
	IconEffect.BuildPersistentEffect(1, true, false);
	IconEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, bDisplayIcon,, Template.AbilitySourceName);
	IconEffect.EffectName = IconEffectName;
	Template.AddTargetEffect(IconEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Helper function to setup basic framework for self-targeted activatible abilities
static function X2AbilityTemplate CreateSelfActiveAbility(name AbilityName, optional string IconString, optional bool bLimitWhenImpaired = true, optional array<name> SkipExclusions)
{
	
	local X2AbilityTemplate					Template;
	

	`CREATE_X2ABILITY_TEMPLATE (Template, AbilityName);
	Template.IconImage = IconString;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.DisplayTargetHitChance = false;
	Template.bLimitTargetIcons = true;
	Template.bShowActivation = true;
	Template.bCrossClassEligible = false;
	Template.bUniqueSource = true;

	// Unit cannot be disoriented, confused, dazed, stunned, burning, bound, or carrying a unit
	if (bLimitWhenImpaired)
	{
		Template.AddShooterEffectExclusions(SkipExclusions);
	}

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}



// ------------------------------------------------------------------------------
// --------------------  ABILITY  EFFECT  HELPER  FUNCTIONS  --------------------
// ------------------------------------------------------------------------------


// Breaks squad concealment for abilities/effects that retain individual concealment
static function BreakSquadConcealment(XComGameState_Player PlayerState, XComGameState NewGameState)
{
	local XComGameState_Unit NewUnitState, UnitState;
	local XComGameState_Effect EffectState;
	local StateObjectReference EffectRef;
	local bool bRetainConcealment;

	// break squad concealment
	if (PlayerState.bSquadIsConcealed)
	{
		if (NewGameState.GetContext().PostBuildVisualizationFn.Find(BuildVisualizationForConcealment_Broken_Individual) == INDEX_NONE) // we only need to visualize this once
		{
			NewGameState.GetContext().PostBuildVisualizationFn.AddItem(BuildVisualizationForConcealment_Broken_Individual);
		}

		PlayerState = XComGameState_Player(NewGameState.ModifyStateObject(class'XComGameState_Player', PlayerState.ObjectID));
		PlayerState.bSquadIsConcealed = false;

		`XEVENTMGR.TriggerEvent('SquadConcealmentBroken', PlayerState, PlayerState, NewGameState);

		// break concealment on each other squad member
		foreach `XCOMHISTORY.IterateByClassType(class'XComGameState_Unit', UnitState)
		{
			if (UnitState.ControllingPlayer.ObjectID == PlayerState.ObjectID)
			{
				bRetainConcealment = false;

				if (UnitState.IsIndividuallyConcealed())
				{
					foreach UnitState.AffectedByEffects(EffectRef)
					{
						EffectState = XComGameState_Effect(`XCOMHISTORY.GetGameStateForObjectID(EffectRef.ObjectID));
						if (EffectState != none)
						{
							if (EffectState.GetX2Effect().RetainIndividualConcealment(EffectState, UnitState))
							{
								bRetainConcealment = true;
								break;
							}
						}
					}
				}

				if (!bRetainConcealment)
				{
					NewUnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', UnitState.ObjectID));
					NewUnitState.SetIndividualConcealment(false, NewGameState);
	}	}	}	}
}

private function BuildVisualizationForConcealment_Broken_Individual(XComGameState VisualizeGameState)
{ class'XComGameState_Unit'.static.BuildVisualizationForConcealmentChanged(VisualizeGameState, false); }



// -------------------------------------------------------------------------------------
// --------------------  ABILITY  VISUALIZATION  HELPER  FUNCTIONS  --------------------
// -------------------------------------------------------------------------------------


// Plays flyover message on the SourceUnit with ability's LocFlyOverText when the ability is activated
simulated function BasicSourceFlyover_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory					History;
	local XComGameStateContext_Ability			AbilityContext;
	local XComGameState_Ability					AbilityState;
	local X2AbilityTemplate						AbilityTemplate;
	local StateObjectReference					SourceUnitRef;
	local VisualizationActionMetadata			ActionMetadata;
	local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;
	
	History = `XCOMHISTORY;

	AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	SourceUnitRef = AbilityContext.InputContext.SourceObject;
	AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID));
	AbilityTemplate = AbilityState.GetMyTemplate();
	
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(SourceUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(SourceUnitRef.ObjectID);
	if (ActionMetadata.StateObject_NewState == none)
		ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
	ActionMetadata.VisualizeActor = History.GetVisualizer(SourceUnitRef.ObjectID);
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, AbilityTemplate.LocFlyOverText, '', eColor_Good, AbilityTemplate.IconImage, `DEFAULTFLYOVERLOOKATTIME * 2);
}





DefaultProperties
{
	SHADOW_STACK_CURRENT_NAME = "WOTC_APA_Reaper_CurrentShadowStacks"
	SHADOW_STACK_MAX_NAME = "WOTC_APA_Reaper_MaxShadowStacks"
}