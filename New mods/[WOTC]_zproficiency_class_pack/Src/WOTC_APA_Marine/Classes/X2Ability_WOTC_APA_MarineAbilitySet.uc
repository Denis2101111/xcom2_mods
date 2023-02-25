
class X2Ability_WOTC_APA_MarineAbilitySet extends X2Ability_WOTC_APA_Utilities config(WOTC_APA_MarineSkills);

// Fire Discipline Proficiency Level Variables
var config int			FIRE_DISCIPLINE_REACTION_FIRE_AIM_BONUS_1;
var config int			FIRE_DISCIPLINE_REACTION_FIRE_AIM_BONUS_2;
var config int			FIRE_DISCIPLINE_REACTION_FIRE_AIM_BONUS_3;

var config int			FIRE_DISCIPLINE_AMMO_BONUS;

var	config array<name>	FIRE_DISCIPLINE_SUPPRESSION_ABILITIES;

var config int			FIRE_DISCIPLINE_REACTION_CHANCE_LIMIT_1;
var config int			FIRE_DISCIPLINE_REACTION_CHANCE_LIMIT_2;
var config int			FIRE_DISCIPLINE_REACTION_CHANCE_LIMIT_3;

var localized string	strFireDiscipline1Name;
var localized string	strFireDiscipline1Desc;
var localized string	strFireDiscipline2Name;
var localized string	strFireDiscipline2Desc;
var localized string	strFireDiscipline3Name;
var localized string	strFireDiscipline3Desc;

var config int			MARINE_CANNON_MOBILITY_PENALTY;
var config bool			REMOVE_BOTH_BARRELS;

// Ability Variables
var config int			STANDARD_SHOT_RECOIL_PENALTY;
var config int			REACTION_SHOT_RECOIL_PENALTY;
var config array<name>	SUPPRESSION_EXCLUDED_WEAPON_CATEGORIES;
var config int			SUPPRESSION_AMMO_COST;
var config int			ZONE_SUPPRESSION_AMMO_COST;
var config int			ZONE_SUPPRESSION_RIFLE_COOLDOWN;
var config int			ZONE_SUPPRESSION_CANNON_COOLDOWN;
var config int			ZONE_SUPPRESSION_CONE_WIDTH;
var config int			ZONE_SUPPRESSION_CONE_WIDTH_CANNON_BONUS;
var config int			LOCKEDON_AIM_BONUS;
var config int			LOCKEDON_CRIT_BONUS;
var config int			FLUSH_SHOT_COOLDOWN;
var config int			FLUSH_SHOT_AMMO_COST;
var config int			FLUSH_SHOT_AIM_BONUS;
var config float		FLUSH_SHOT_DAMAGE_MODIFIER;
var config int			DANGER_ZONE_WIDTH_BONUS;
var config int			DANGER_ZONE_WIDTH_CANNON_BONUS;
var config float		PIN_DOWN_MOBILITY_PENALTY;
//var config int		PIN_DOWN_DISORIENT_CHANCE;
var config int			SPLINTER_ARMOR_SHRED;
var config int			EMPLACED_AIM_BONUS;
var config int			EMPLACED_VISION_BONUS;
var config int			COMBAT_AWARENESS_DEFENSE_BONUS;
var config int			COMBAT_AWARENESS_ARMOR_BONUS;
var config int			BRINGEM_ON_CRIT_CHANCE_BONUS;
var config int			BRINGEM_ON_CRIT_DAMAGE_BONUS;
var config int			ON_TARGET_DODGE_REDUCTION;
var config int			ON_TARGET_TRIGGER_CHANCE;
var config int			WEAPONS_HOT_TRIGGER_CHANCE_CANNON;
var config int			WEAPONS_HOT_TRIGGER_CHANCE_RIFLE;
var config int			WITHERING_BARRAGE_TRIGGER_CHANCE;
var config int			TACTICAL_SENSE_DEFENSE_PER_ENEMY;
var config int			TACTICAL_SENSE_DEFENSE_CAP;
var config int			AGGRESSION_CRIT_CHANCE_PER_ENEMY;
var config int			AGGRESSION_CRIT_CHANCE_CAP;
var config int			ZEROED_IN_CHANCE_PER_ENEMY;
var config int			ZEROED_IN_CHANCE_CAP;

var config int			IMPRESSIVE_STRENGTH_HP_BONUS;
var config float		IMPRESSIVE_STRENGTH_THROW_RANGE_MODIFIER;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	/**/`Log("WOTC_APA_Marine - Begin Adding Templates");

	Templates.AddItem(WOTC_APA_FireDiscipline());
	/*»»»*/	Templates.AddItem(WOTC_APA_FireDisciplineToggle1());
	/*»»»*/	Templates.AddItem(WOTC_APA_FireDisciplineToggle2());
	/*»»»*/	Templates.AddItem(WOTC_APA_FireDisciplineToggle3());
	/*»»»*/	Templates.AddItem(WOTC_APA_CannonUpgunned());	
	Templates.AddItem(WOTC_APA_SustainedFire());
	Templates.AddItem(WOTC_APA_SuppressiveFire());
	/*»»»*/	Templates.AddItem(WOTC_APA_Suppression());
	/*»»»*/	Templates.AddItem(WOTC_APA_SuppressionShot());
	/*»»»*/	Templates.AddItem(WOTC_APA_SuppressionShotCF());
	/*»»»*/	Templates.AddItem(WOTC_APA_SuppressionZone());
	/*»»»*/	Templates.AddItem(WOTC_APA_SuppressionZoneShot());
	/*»»»*/	Templates.AddItem(WOTC_APA_SuppressionZoneShotCF());
	/*»»»*/	Templates.AddItem(WOTC_APA_SuppressionZoneCannonBonus());

	// Covering Fire (Base Game)
	Templates.AddItem(WOTC_APA_FlushEmOut());
	/*»»»*/	Templates.AddItem(WOTC_APA_FlushEmOutShot());
	Templates.AddItem(WOTC_APA_DangerZone());
	/*»»»*/	Templates.AddItem(WOTC_APA_DangerZoneCannonBonus());

	// Ever Vigilant (Base Game)
	Templates.AddItem(WOTC_APA_PinEmDown());
	/*»»»*/	Templates.AddItem(WOTC_APA_PinEmDownApplyDisorient());
	/*»»»*/	Templates.AddItem(WOTC_APA_PinEmDownApplyMobilityPenalty());
	Templates.AddItem(WOTC_APA_Splinter());

	// WOTC_APA_Sentinel
	Templates.AddItem(WOTC_APA_LightEmUp());
	Templates.AddItem(WOTC_APA_Emplaced());

	Templates.AddItem(WOTC_APA_CombatAwareness());
	Templates.AddItem(WOTC_APA_BringEmOn());
	Templates.AddItem(WOTC_APA_NoMansLand());
	/*»»»*/	Templates.AddItem(WOTC_APA_NoMansLandShot());

	Templates.AddItem(WOTC_APA_OnTarget());
	/*»»»*/	Templates.AddItem(WOTC_APA_OnTargetFlyover());
	Templates.AddItem(WOTC_APA_WeaponsHot());
	/*»»»*/	Templates.AddItem(WOTC_APA_WeaponsHotTriggerCannon());
	/*»»»*/	Templates.AddItem(WOTC_APA_WeaponsHotTriggerRifle());
	/*»»»*/	Templates.AddItem(WOTC_APA_WeaponsHotShot());
	Templates.AddItem(WOTC_APA_WitheringBarrage());
	/*»»»*/	Templates.AddItem(WOTC_APA_WitheringBarrageApply());

	Templates.AddItem(WOTC_APA_TacticalSense());
	Templates.AddItem(WOTC_APA_Aggression());
	Templates.AddItem(WOTC_APA_ZeroedIn());


	Templates.AddItem(WOTC_APA_ImpressiveStrength());
	Templates.AddItem(WOTC_APA_LockedOn());
	Templates.AddItem(WOTC_APA_TraverseFire());

	
	

	/**/`Log("WOTC_APA_Marine - Finished Adding Templates");

	return Templates;
}


// Fire Discipline - Base Class Proficiency Ability
static function X2AbilityTemplate WOTC_APA_FireDiscipline()
{
	
	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_TargetRankRequirement		RankCondition1, RankCondition2, RankCondition3;
	local X2Effect_WOTC_APA_FireDisciplineReactionModifier		ReactionEffect1, ReactionEffect2, ReactionEffect3;
	local X2Effect_WOTC_APA_Class_OverrideClipSize				AmmoEffect;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_FireDiscipline');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_FireDiscipline"; 
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
	RankCondition1.LogEffectName = "Fire Discipline 1";	// EffectName to use in logs
	RankCondition1.ExcludeProject = 'WOTC_APA_MarineUnlock1';
	
	RankCondition2 = new class 'X2Condition_WOTC_APA_Class_TargetRankRequirement';
	RankCondition2.iMinRank = 3;
	RankCondition2.iMaxRank = 5;
	RankCondition2.LogEffectName = "Fire Discipline 2";
	RankCondition2.ExcludeProject = 'WOTC_APA_MarineUnlock2';
	RankCondition2.GiveProject = 'WOTC_APA_MarineUnlock1';
	
	RankCondition3 = new class 'X2Condition_WOTC_APA_Class_TargetRankRequirement';
	RankCondition3.iMinRank = 6;
	RankCondition3.iMaxRank = -1;	// No max rank for level 3 bonuses
	RankCondition3.LogEffectName = "Fire Discipline 3";
	RankCondition3.GiveProject = 'WOTC_APA_MarineUnlock2';
	

	// Setup effect that modifies Reaction Shot Crit and Aim
	ReactionEffect1 = new class'X2Effect_WOTC_APA_FireDisciplineReactionModifier';
	ReactionEffect1.ReactionModifier = default.FIRE_DISCIPLINE_REACTION_FIRE_AIM_BONUS_1;
	ReactionEffect1.bCanCrit = true;
	ReactionEffect1.SetDisplayInfo(ePerkBuff_Passive, default.strFireDiscipline1Name, default.strFireDiscipline1Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_FireDiscipline1", true,, Template.AbilitySourceName);
	ReactionEffect1.TargetConditions.AddItem(RankCondition1);
	Template.AddTargetEffect(ReactionEffect1);

	ReactionEffect2 = new class'X2Effect_WOTC_APA_FireDisciplineReactionModifier';
	ReactionEffect2.ReactionModifier = default.FIRE_DISCIPLINE_REACTION_FIRE_AIM_BONUS_2;
	ReactionEffect2.bCanCrit = true;
	ReactionEffect2.SetDisplayInfo(ePerkBuff_Passive, default.strFireDiscipline2Name, default.strFireDiscipline2Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_FireDiscipline2", true,, Template.AbilitySourceName);
	ReactionEffect2.TargetConditions.AddItem(RankCondition2);
	Template.AddTargetEffect(ReactionEffect2);

	ReactionEffect3 = new class'X2Effect_WOTC_APA_FireDisciplineReactionModifier';
	ReactionEffect3.ReactionModifier = default.FIRE_DISCIPLINE_REACTION_FIRE_AIM_BONUS_3;
	ReactionEffect3.bCanCrit = true;
	ReactionEffect3.SetDisplayInfo(ePerkBuff_Passive, default.strFireDiscipline3Name, default.strFireDiscipline3Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_FireDiscipline3", true,, Template.AbilitySourceName);
	ReactionEffect3.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(ReactionEffect3);


	// Grant bonus rounds of ammunition based on weapons equipped
	AmmoEffect = new class'X2Effect_WOTC_APA_Class_OverrideClipSize';
	AmmoEffect.iClipSizeModifier = default.FIRE_DISCIPLINE_AMMO_BONUS;
	AmmoEffect.BuildPersistentEffect(1, true, false, false);
	AmmoEffect.iMinWeaponAmmo = 2;
	AmmoEffect.EffectName = 'WOTC_APA_FireDisciplineAmmoEffect';
	AmmoEffect.TargetConditions.AddItem(RankCondition2);
	Template.AddTargetEffect(AmmoEffect);

	AmmoEffect = new class'X2Effect_WOTC_APA_Class_OverrideClipSize';
	AmmoEffect.iClipSizeModifier = default.FIRE_DISCIPLINE_AMMO_BONUS;
	AmmoEffect.BuildPersistentEffect(1, true, false, false);
	AmmoEffect.iMinWeaponAmmo = 2;
	AmmoEffect.EffectName = 'WOTC_APA_FireDisciplineAmmoEffect';
	AmmoEffect.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(AmmoEffect);

	
	Template.AdditionalAbilities.AddItem('WOTC_APA_FireDisciplineToggle1');
	Template.AdditionalAbilities.AddItem('WOTC_APA_FireDisciplineToggle2');
	Template.AdditionalAbilities.AddItem('WOTC_APA_FireDisciplineToggle3');


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

// Fire Discipline Toggle - Active:
static function X2AbilityTemplate WOTC_APA_FireDisciplineToggle1()
{

	local X2AbilityTemplate									Template;
	local X2AbilityCost_ActionPoints						ActionPointCost;
	local X2Condition_UnitValue								UnitValue;


	Template = CreateSelfActiveAbility('WOTC_APA_FireDisciplineToggle1', "img:///UILibrary_WOTC_APA_Class_Pack.perk_FireDisciplineToggle1", false);
	
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_ShowIfAvailable;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.OVERWATCH_PRIORITY + 1;
	Template.bNoConfirmationWithHotKey = true;
	Template.bBypassAbilityConfirm = true;
	Template.bDontDisplayInAbilitySummary = true;
	Template.bDisplayInUITacticalText = false;
	Template.bDisplayInUITooltip = false;
	Template.bShowActivation = false;


	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	
	UnitValue = new class'X2Condition_UnitValue';
	UnitValue.AddCheckValue(class'X2Effect_WOTC_APA_FireDisciplineToggle'.default.FireDisciplineToggleName, 0, eCheck_Exact);
	Template.AbilityShooterConditions.AddItem(UnitValue);


	Template.AddTargetEffect(new class'X2Effect_WOTC_APA_FireDisciplineToggle');
	

	Template.BuildVisualizationFn = BasicSourceFlyover_BuildVisualization;
	return Template;
}

static function X2AbilityTemplate WOTC_APA_FireDisciplineToggle2()
{

	local X2AbilityTemplate									Template;
	local X2AbilityCost_ActionPoints						ActionPointCost;
	local X2Condition_UnitValue								UnitValue;


	Template = CreateSelfActiveAbility('WOTC_APA_FireDisciplineToggle2', "img:///UILibrary_WOTC_APA_Class_Pack.perk_FireDisciplineToggle2", false);
	
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_ShowIfAvailable;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.OVERWATCH_PRIORITY + 1;
	Template.bNoConfirmationWithHotKey = true;
	Template.bBypassAbilityConfirm = true;
	Template.bDontDisplayInAbilitySummary = true;
	Template.bDisplayInUITacticalText = false;
	Template.bDisplayInUITooltip = false;
	Template.bShowActivation = false;
	

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	
	UnitValue = new class'X2Condition_UnitValue';
	UnitValue.AddCheckValue(class'X2Effect_WOTC_APA_FireDisciplineToggle'.default.FireDisciplineToggleName, 1, eCheck_Exact);
	Template.AbilityShooterConditions.AddItem(UnitValue);


	Template.AddTargetEffect(new class'X2Effect_WOTC_APA_FireDisciplineToggle');
	

	Template.BuildVisualizationFn = BasicSourceFlyover_BuildVisualization;
	return Template;
}

static function X2AbilityTemplate WOTC_APA_FireDisciplineToggle3()
{

	local X2AbilityTemplate									Template;
	local X2AbilityCost_ActionPoints						ActionPointCost;
	local X2Condition_UnitValue								UnitValue;


	Template = CreateSelfActiveAbility('WOTC_APA_FireDisciplineToggle3', "img:///UILibrary_WOTC_APA_Class_Pack.perk_FireDisciplineToggle3", false);
	
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_ShowIfAvailable;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.OVERWATCH_PRIORITY + 1;
	Template.bNoConfirmationWithHotKey = true;
	Template.bBypassAbilityConfirm = true;
	Template.bDontDisplayInAbilitySummary = true;
	Template.bDisplayInUITacticalText = false;
	Template.bDisplayInUITooltip = false;
	Template.bShowActivation = false;
	

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	
	UnitValue = new class'X2Condition_UnitValue';
	UnitValue.AddCheckValue(class'X2Effect_WOTC_APA_FireDisciplineToggle'.default.FireDisciplineToggleName, 2, eCheck_Exact);
	Template.AbilityShooterConditions.AddItem(UnitValue);


	Template.AddTargetEffect(new class'X2Effect_WOTC_APA_FireDisciplineToggle');
	

	Template.BuildVisualizationFn = BasicSourceFlyover_BuildVisualization;
	return Template;
}


// Cannon: Upgunned - gives a mobility penalty when equipping Cannons/Machineguns rather than the Rifle
static function X2AbilityTemplate WOTC_APA_CannonUpgunned()
{

	local X2AbilityTemplate									Template;
	local X2Effect_PersistentStatChange						MobilityEffect;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory	ValidWeaponCondition;


	Template = CreatePassiveAbility('WOTC_APA_CannonUpgunned', "img:///UILibrary_WOTC_APA_Class_Pack.perk_CannonUpgunned",, false);


	// Create a persistent stat change effect that adds the mobility penalty for upgunning
	MobilityEffect = new class 'X2Effect_PersistentStatChange';
	MobilityEffect.BuildPersistentEffect(1, true, false, false);
	MobilityEffect.EffectName = 'WOTC_APA_CannonUpgunnedEffect';
	MobilityEffect.AddPersistentStatChange(eStat_Mobility, -default.MARINE_CANNON_MOBILITY_PENALTY);
	MobilityEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFlyoverText, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(MobilityEffect);

	ValidWeaponCondition = new class 'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	ValidWeaponCondition.AllowedWeaponCategories.AddItem('cannon');
	Template.AbilityShooterConditions.AddItem(ValidWeaponCondition);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Sustained Fire - Passive: Standard shots no longer end the turn, but remaining actions may only be used for reaction shots or to reload
static function X2AbilityTemplate WOTC_APA_SustainedFire()
{

	local X2AbilityTemplate								Template;
	local X2Effect_WOTC_APA_SustainedFire				ActionEffect;


	Template = CreatePassiveAbility('WOTC_APA_SustainedFire', "img:///UILibrary_WOTC_APA_Class_Pack.perk_SustainedFire");


	ActionEffect = new class'X2Effect_WOTC_APA_SustainedFire';
	ActionEffect.BuildPersistentEffect(1,true,false);
	Template.AddTargetEffect(ActionEffect);

	
	return Template;
}


// Suppressive Fire - Passive: Grants Suppression and Suppression Zone abilities
static function X2AbilityTemplate WOTC_APA_SuppressiveFire()
{

	local X2AbilityTemplate								Template;


	Template = CreatePassiveAbility('WOTC_APA_SuppressiveFire', "img:///UILibrary_WOTC_APA_Class_Pack.perk_SuppressiveFire",, false);

	
	Template.AdditionalAbilities.AddItem('WOTC_APA_Suppression');
	Template.AdditionalAbilities.AddItem('WOTC_APA_SuppressionShot');
	Template.AdditionalAbilities.AddItem('WOTC_APA_SuppressionShotCF');
	Template.AdditionalAbilities.AddItem('WOTC_APA_SuppressionZone');
	Template.AdditionalAbilities.AddItem('WOTC_APA_SuppressionZoneShot');
	Template.AdditionalAbilities.AddItem('WOTC_APA_SuppressionZoneShotCF');
	Template.AdditionalAbilities.AddItem('WOTC_APA_SuppressionZoneCannonBonus');


	return Template;
}

// Suppresion Targetable Ability
static function X2AbilityTemplate WOTC_APA_Suppression()
{

	local X2AbilityTemplate											Template;	
	local X2AbilityCost_Ammo										AmmoCost;
	local X2AbilityCost_ActionPoints								ActionPointCost;
	local X2Effect_ReserveActionPoints								ReserveActionPointsEffect;
	local X2Condition_UnitInventory									UnitInventoryCondition;
	local X2Condition_UnitEffects									UnitEffectCondition;
	local X2Effect_WOTC_APA_Class_Suppression						SuppressionEffect;
	local name														WeaponCat;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_Suppression');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_supression";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_MAJOR_PRIORITY;
	Template.bDisplayInUITooltip = false;
	Template.Hostility = eHostility_Offensive;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);
	Template.AbilityTargetConditions.AddItem(default.LivingHostileUnitDisallowMindControlProperty);
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.DefaultSourceItemSlot = eInvSlot_PrimaryWeapon;
	Template.bIsASuppressionEffect = true;
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.ActivationSpeech='Suppressing';
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.CinescriptCameraType = "StandardSuppression";
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();
	Template.bCrossClassEligible = false;


	// Set ability ammo and action point costs
	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = default.SUPPRESSION_AMMO_COST;
	Template.AbilityCosts.AddItem(AmmoCost);
	
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.bConsumeAllPoints = true;   //	this will guarantee the unit has at least 1 action point
	ActionPointCost.bFreeCost = true;           //  ReserveActionPoints effect will take all action points away
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	ReserveActionPointsEffect = new class'X2Effect_ReserveActionPoints';
	ReserveActionPointsEffect.ReserveType = 'Suppression';
	Template.AddShooterEffect(ReserveActionPointsEffect);


	// Exclude ability from being applied by excluded weapons
	foreach default.SUPPRESSION_EXCLUDED_WEAPON_CATEGORIES(WeaponCat)
	{
		UnitInventoryCondition = new class'X2Condition_UnitInventory';
		UnitInventoryCondition.RelevantSlot = eInvSlot_PrimaryWeapon;
		UnitInventoryCondition.ExcludeWeaponCategory = WeaponCat;
		Template.AbilityShooterConditions.AddItem(UnitInventoryCondition);
	}
	

	// Exclude ability from being applied if shooter is affected by any of these effects
	UnitEffectCondition = new class'X2Condition_UnitEffects';
	UnitEffectCondition.AddExcludeEffect('Suppression', 'AA_UnitIsSuppressed');
	UnitEffectCondition.AddExcludeEffect('AreaSuppression', 'AA_UnitIsSuppressed');
	Template.AbilityShooterConditions.AddItem(UnitEffectCondition);

	
	// Create Suppression effect
	SuppressionEffect = new class'X2Effect_WOTC_APA_Class_Suppression';
	SuppressionEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnBegin);
	SuppressionEffect.bRemoveWhenTargetDies = true;
	SuppressionEffect.bRemoveWhenSourceDamaged = true;
	SuppressionEffect.bBringRemoveVisualizationForward = true;
	SuppressionEffect.SetDisplayInfo(ePerkBuff_Penalty, Template.LocFriendlyName, class'X2Ability_GrenadierAbilitySet'.default.SuppressionTargetEffectDesc, Template.IconImage);
	SuppressionEffect.SetSourceDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, class'X2Ability_GrenadierAbilitySet'.default.SuppressionSourceEffectDesc, Template.IconImage);
	Template.AddTargetEffect(SuppressionEffect);
	
	Template.AddTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.HoloTargetEffect());
	Template.AssociatedPassives.AddItem('HoloTargeting');


	Template.AdditionalAbilities.AddItem('WOTC_APA_SuppressionShot');
	Template.AdditionalAbilities.AddItem('WOTC_APA_SuppressionShotCF');

	
	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotChosenActivationIncreasePerUse;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = class'X2Ability_GrenadierAbilitySet'.static.SuppressionBuildVisualization;
	Template.BuildAppliedVisualizationSyncFn = class'X2Ability_GrenadierAbilitySet'.static.SuppressionBuildVisualizationSync;
	return Template;	
}

// Suppression Shot Ability - 
static function X2AbilityTemplate WOTC_APA_SuppressionShot()
{

	local X2AbilityTemplate											Template;	
	local X2AbilityCost_ReserveActionPoints							ReserveActionPointCost;
	local X2Condition_UnitEffectsWithAbilitySource					TargetEffectCondition;
	local X2Effect_RemoveEffects									RemoveSuppression;


	Template = CreateAbilityReactionShot('WOTC_APA_SuppressionShot', "img:///UILibrary_PerkIcons.UIPerk_supression", eInvSlot_PrimaryWeapon,,,,, true /*require the absence of Covering Fire*/);
	Template.bSkipExitCoverWhenFiring = true; // don't want to exit cover, we are already in suppression/alert mode.
	

	// Define Ability Costs and Cooldown (Action Points, Ammo, etc.)
	ReserveActionPointCost = new class'X2AbilityCost_ReserveActionPoints';
	ReserveActionPointCost.iNumPoints = 1;
	ReserveActionPointCost.AllowedTypes.AddItem('Suppression');
	Template.AbilityCosts.AddItem(ReserveActionPointCost);

	// No ammo cost for single target suppression

	
	// Target must be suppressed by this unit
	TargetEffectCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	TargetEffectCondition.AddRequireEffect(class'X2Effect_Suppression'.default.EffectName, 'AA_UnitIsNotSuppressed');
	Template.AbilityTargetConditions.AddItem(TargetEffectCondition);

	
	// Remove Suppression Effect After Shot
	RemoveSuppression = new class'X2Effect_RemoveEffects';
	RemoveSuppression.EffectNamesToRemove.AddItem(class'X2Effect_Suppression'.default.EffectName);
	RemoveSuppression.bCheckSource = true;
	RemoveSuppression.SetupEffectOnShotContextResult(true, true);
	Template.AddTargetEffect(RemoveSuppression);


	return Template;	
}

// Suppression Shot Ability - 
static function X2AbilityTemplate WOTC_APA_SuppressionShotCF()
{

	local X2AbilityTemplate											Template;	
	local X2AbilityCost_ReserveActionPoints							ReserveActionPointCost;
	local X2Condition_UnitEffectsWithAbilitySource					TargetEffectCondition;
	local X2Effect_RemoveEffects									RemoveSuppression;
	local X2Effect_WOTC_APA_Class_SuppressionAimPenalty				AimPenaltyEffect;


	Template = CreateAbilityReactionShot('WOTC_APA_SuppressionShotCF', "img:///UILibrary_PerkIcons.UIPerk_supression", eInvSlot_PrimaryWeapon,,, true /*trigger on hostile actions*/, true /*require the presence of Covering Fire*/);
	Template.bSkipExitCoverWhenFiring = true; // don't want to exit cover, we are already in suppression/alert mode.
	

	// Define Ability Costs and Cooldown (Action Points, Ammo, etc.)
	ReserveActionPointCost = new class'X2AbilityCost_ReserveActionPoints';
	ReserveActionPointCost.iNumPoints = 1;
	ReserveActionPointCost.AllowedTypes.AddItem('Suppression');
	Template.AbilityCosts.AddItem(ReserveActionPointCost);

	// No ammo cost for single target suppression

	
	// Target must be suppressed by this unit
	TargetEffectCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	TargetEffectCondition.AddRequireEffect(class'X2Effect_Suppression'.default.EffectName, 'AA_UnitIsNotSuppressed');
	Template.AbilityTargetConditions.AddItem(TargetEffectCondition);

	
	// Remove Suppression Effect After Shot
	RemoveSuppression = new class'X2Effect_RemoveEffects';
	RemoveSuppression.EffectNamesToRemove.AddItem(class'X2Effect_Suppression'.default.EffectName);
	RemoveSuppression.bCheckSource = true;
	RemoveSuppression.SetupEffectOnShotContextResult(true, true);
	Template.AddTargetEffect(RemoveSuppression);


	// Reapply the Suppression Aim Penalty on the target until the end of their turn so their subsequent shot still suffers the penalty (with Covering Fire)
	AimPenaltyEffect = new class'X2Effect_WOTC_APA_Class_SuppressionAimPenalty';
	AimPenaltyEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnEnd);
	AimPenaltyEffect.bApplyOnMiss = true;
	AimPenaltyEffect.SetDisplayInfo(ePerkBuff_Penalty, class'X2Effect_WOTC_APA_Class_Suppression'.default.strSuppressionAimPenaltyName, class'X2Ability_GrenadierAbilitySet'.default.SuppressionTargetEffectDesc, Template.IconImage);
	Template.AddTargetEffect(AimPenaltyEffect);


	return Template;	
}

// Zone Suppression - Active: Suppress all targets in a cone.
static function X2AbilityTemplate WOTC_APA_SuppressionZone()
{

	local X2AbilityTemplate											Template;
	local X2AbilityCooldown_WOTC_APA_ZoneSuppression				Cooldown;
	local X2AbilityCost_Ammo										AmmoCost;
	local X2AbilityCost_ActionPoints								ActionPointCost;
	//local X2AbilityCost_WOTC_APA_ZoneSuppressionActionPoints		ActionPointCost;
	local X2AbilityTarget_Cursor									CursorTarget;
	local X2AbilityMultiTarget_Cone									ConeMultiTarget;
	local X2Effect_ReserveActionPoints								ReservePointsEffect;
	local X2Effect_Persistent										MarkUnitsEffect, EndEnterCoverEffect;
	local X2Effect_MarkValidActivationTiles							MarkTilesEffect;
	local X2Condition_UnitEffects									SuppressedCondition;
	local X2Condition_UnitProperty									ConcealedCondition;
	local X2Condition_UnitInventory									UnitInventoryCondition;
	local X2Condition_Visibility									TargetVisibilityCondition;
	local X2Effect_WOTC_APA_Class_Suppression						SuppressionEffect;
	local name														WeaponCat;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_SuppressionZone');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_ZoneSuppression";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_AlwaysShow;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_MAJOR_PRIORITY + 1;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.Hostility = eHostility_Offensive;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.AbilityConfirmSound = "Unreal2DSounds_OverWatch";
	Template.ActivationSpeech = 'Suppressing';
	Template.bCrossClassEligible = false;
	Template.bUniqueSource = true;
	Template.bShowActivation = true;
	Template.bSkipFireAction = true;
	Template.bFriendlyFireWarning = false;
	Template.bIsASuppressionEffect = true;
	Template.bOverrideAim = true;
	Template.CinescriptCameraType = "Grenadier_SaturationFire";


	// Ability Targeting setup
	CursorTarget = new class'X2AbilityTarget_Cursor';
	CursorTarget.bRestrictToWeaponRange = true;
	Template.AbilityTargetStyle = CursorTarget;

	ConeMultiTarget = new class'X2AbilityMultiTarget_Cone';
	ConeMultiTarget.bUseWeaponRadius = false;
	ConeMultiTarget.bUseWeaponRangeForLength = true;
	ConeMultiTarget.bExcludeSelfAsTargetIfWithinRadius = true;
	ConeMultiTarget.bIgnoreBlockingCover = true;
	ConeMultiTarget.fTargetRadius = 99;
	ConeMultiTarget.ConeEndDiameter = default.ZONE_SUPPRESSION_CONE_WIDTH * class'XComWorldData'.const.WORLD_StepSize;
	ConeMultiTarget.AddBonusConeSize('WOTC_APA_SuppressionZoneCannonBonus', default.ZONE_SUPPRESSION_CONE_WIDTH_CANNON_BONUS, 0);
	ConeMultiTarget.AddBonusConeSize('WOTC_APA_DangerZone', default.DANGER_ZONE_WIDTH_BONUS, 0);
	ConeMultiTarget.AddBonusConeSize('WOTC_APA_DangerZoneCannonBonus', default.DANGER_ZONE_WIDTH_CANNON_BONUS, 0);
	Template.AbilityMultiTargetStyle = ConeMultiTarget;

	// Prevents marking targets in the cone that the source does not have visiblity to:
	//Template.TargetingMethod = class'X2TargetingMethod_WOTC_APA_ZoneSuppression';

	Template.TargetingMethod = class'X2TargetingMethod_Cone';
	

	// Define ammo, actionpoint, and cooldown costs
	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = default.ZONE_SUPPRESSION_AMMO_COST;
	Template.AbilityCosts.AddItem(AmmoCost);

	Cooldown = new class'X2AbilityCooldown_WOTC_APA_ZoneSuppression';
	Template.AbilityCooldown = Cooldown;

	//ActionPointCost = new class'X2AbilityCost_WOTC_APA_ZoneSuppressionActionPoints';
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.bAddWeaponTypicalCost = true;
	ActionPointCost.bConsumeAllPoints = true;   //  this will guarantee the unit has at least 1 action point
	ActionPointCost.bFreeCost = true;           //  ReserveActionPoints effect will take all action points away
	ActionPointCost.DoNotConsumeAllEffects.Length = 0;
	ActionPointCost.DoNotConsumeAllSoldierAbilities.Length = 0;
	ActionPointCost.AllowedTypes.RemoveItem(class'X2CharacterTemplateManager'.default.SkirmisherInterruptActionPoint);
	Template.AbilityCosts.AddItem(ActionPointCost);

	ReservePointsEffect = new class'X2Effect_ReserveActionPoints';
	ReservePointsEffect.ReserveType = 'ZoneSuppression';
	Template.AddShooterEffect(ReservePointsEffect);


	// Define activation conditions
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();
	SuppressedCondition = new class'X2Condition_UnitEffects';
	SuppressedCondition.AddExcludeEffect(class'X2Effect_Suppression'.default.EffectName, 'AA_UnitIsSuppressed');
	SuppressedCondition.AddExcludeEffect(class'X2Effect_SkirmisherInterrupt'.default.EffectName, 'AA_AbilityUnavailable');
	Template.AbilityShooterConditions.AddItem(SuppressedCondition);

	// Cannot use from concealment
	ConcealedCondition = new class'X2Condition_UnitProperty';
	ConcealedCondition.ExcludeFriendlyToSource = false;
	ConcealedCondition.ExcludeConcealed = true;
	Template.AbilityShooterConditions.AddItem(ConcealedCondition);


	// Exclude ability from being applied by excluded weapons
	foreach default.SUPPRESSION_EXCLUDED_WEAPON_CATEGORIES(WeaponCat)
	{
		UnitInventoryCondition = new class'X2Condition_UnitInventory';
		UnitInventoryCondition.RelevantSlot = eInvSlot_PrimaryWeapon;
		UnitInventoryCondition.ExcludeWeaponCategory = WeaponCat;
		Template.AbilityShooterConditions.AddItem(UnitInventoryCondition);
	}


	// Create the Suppression effect on targets
	SuppressionEffect = new class'X2Effect_WOTC_APA_Class_Suppression';
	SuppressionEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnBegin);
	SuppressionEffect.bMultiTargetAbility = true;
	SuppressionEffect.bRemoveWhenTargetDies = true;
	SuppressionEffect.bRemoveWhenSourceDamaged = true;
	SuppressionEffect.bBringRemoveVisualizationForward = true;
	SuppressionEffect.SetDisplayInfo(ePerkBuff_Penalty, Template.LocFriendlyName, class'X2Ability_GrenadierAbilitySet'.default.SuppressionTargetEffectDesc, Template.IconImage);
	SuppressionEffect.SetSourceDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, class'X2Ability_GrenadierAbilitySet'.default.SuppressionSourceEffectDesc, Template.IconImage);
	

	// Only hostile targets in the area that the source can see actually get suppressed
	TargetVisibilityCondition = new class'X2Condition_Visibility';	
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	SuppressionEffect.TargetConditions.AddItem(TargetVisibilityCondition);
	SuppressionEffect.TargetConditions.AddItem(default.LivingHostileTargetProperty);
	Template.AddMultiTargetEffect(SuppressionEffect);


	// Mark units that get suppression applied with an effect that will not be removed so they are excluded from triggering No-Man's Land shots
	MarkUnitsEffect = new class'X2Effect_Persistent';
	MarkUnitsEffect.EffectName = 'ZoneSuppressionKillZoneExclude';
	MarkUnitsEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnBegin);
	MarkUnitsEffect.TargetConditions.AddItem(TargetVisibilityCondition);
	MarkUnitsEffect.TargetConditions.AddItem(default.LivingHostileTargetProperty);
	Template.AddMultiTargetEffect(MarkUnitsEffect);

	// Mark tiles for No-Man's Land shots to trigger on enemies entering the area
	MarkTilesEffect = new class'X2Effect_MarkValidActivationTiles';
	MarkTilesEffect.AbilityToMark = 'WOTC_APA_NoMansLandShot';
	Template.AddShooterEffect(MarkTilesEffect);


	// Create a passive effect on the shooter that will force them to re-enter cover once Zone Suppression is over
	EndEnterCoverEffect = new class'X2Effect_Persistent';
	EndEnterCoverEffect.EffectName = 'ZoneSuppressionEndEnterCoverEffect';
	EndEnterCoverEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnBegin);
	EndEnterCoverEffect.EffectRemovedVisualizationFn = SuppressionZoneEndVisualization_RemovedVisualizationFn;
	Template.AddShooterEffect(EndEnterCoverEffect);


	Template.AdditionalAbilities.AddItem('WOTC_APA_SuppressionZoneShot');


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = SuppressionZoneBuildVisualization;
	Template.BuildAppliedVisualizationSyncFn = SuppressionZoneBuildVisualizationSync;
	
	
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.NonAggressiveChosenActivationIncreasePerUse;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;
	Template.bFrameEvenWhenUnitIsHidden = true;
	

	return Template;
}

// Zone Suppression Shot Ability - Triggers on target movement or, with Covering Fire, ability activation
static function X2AbilityTemplate WOTC_APA_SuppressionZoneShot()
{
	
	local X2AbilityTemplate											Template;	
	local X2AbilityCost_ReserveActionPoints							ReserveActionPointCost;
	local X2AbilityCost_Ammo										AmmoCost;
	local X2Condition_UnitEffectsWithAbilitySource					TargetEffectCondition;
	local X2Effect_WOTC_APA_RemoveAreaSuppression					RemoveSuppression;


	Template = CreateAbilityReactionShot('WOTC_APA_SuppressionZoneShot', "img:///UILibrary_PerkIcons.UIPerk_supression", eInvSlot_PrimaryWeapon,,,,, true /*require the absence of Covering Fire*/);
	Template.bSkipExitCoverWhenFiring = true; // don't want to exit cover, we are already in suppression/alert mode.
	

	// Define Ability Costs and Cooldown (Action Points, Ammo, etc.)
	ReserveActionPointCost = new class'X2AbilityCost_ReserveActionPoints';
	ReserveActionPointCost.iNumPoints = 1;
	ReserveActionPointCost.bFreeCost = true;
	ReserveActionPointCost.AllowedTypes.AddItem('ZoneSuppression');
	Template.AbilityCosts.AddItem(ReserveActionPointCost);

	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);

	
	// Target must be suppressed by this unit
	TargetEffectCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	TargetEffectCondition.AddRequireEffect(class'X2Effect_Suppression'.default.EffectName, 'AA_UnitIsNotSuppressed');
	Template.AbilityTargetConditions.AddItem(TargetEffectCondition);


	// Remove Suppression Effect After Shot
	RemoveSuppression = new class'X2Effect_WOTC_APA_RemoveAreaSuppression';
	RemoveSuppression.EffectNamesToRemove.AddItem(class'X2Effect_Suppression'.default.EffectName);
	RemoveSuppression.bCheckSource = true;
	RemoveSuppression.SetupEffectOnShotContextResult(true, true);
	Template.AddTargetEffect(RemoveSuppression);


	return Template;
}

// Zone Suppression Shot Ability - Triggers on target movement or, with Covering Fire, ability activation
static function X2AbilityTemplate WOTC_APA_SuppressionZoneShotCF()
{
	
	local X2AbilityTemplate											Template;	
	local X2AbilityCost_ReserveActionPoints							ReserveActionPointCost;
	local X2AbilityCost_Ammo										AmmoCost;
	local X2Condition_UnitEffectsWithAbilitySource					TargetEffectCondition;
	local X2Effect_WOTC_APA_RemoveAreaSuppression					RemoveSuppression;
	local X2Effect_WOTC_APA_Class_SuppressionAimPenalty				AimPenaltyEffect;


	Template = CreateAbilityReactionShot('WOTC_APA_SuppressionZoneShotCF', "img:///UILibrary_PerkIcons.UIPerk_supression", eInvSlot_PrimaryWeapon,,, true /*trigger on hostile actions*/, true /*require the presence of Covering Fire*/);
	Template.bSkipExitCoverWhenFiring = true; // don't want to exit cover, we are already in suppression/alert mode.
	

	// Define Ability Costs and Cooldown (Action Points, Ammo, etc.)
	ReserveActionPointCost = new class'X2AbilityCost_ReserveActionPoints';
	ReserveActionPointCost.iNumPoints = 1;
	ReserveActionPointCost.bFreeCost = true;
	ReserveActionPointCost.AllowedTypes.AddItem('ZoneSuppression');
	Template.AbilityCosts.AddItem(ReserveActionPointCost);

	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);

	
	// Target must be suppressed by this unit
	TargetEffectCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	TargetEffectCondition.AddRequireEffect(class'X2Effect_Suppression'.default.EffectName, 'AA_UnitIsNotSuppressed');
	Template.AbilityTargetConditions.AddItem(TargetEffectCondition);


	// Remove Suppression Effect After Shot
	RemoveSuppression = new class'X2Effect_WOTC_APA_RemoveAreaSuppression';
	RemoveSuppression.EffectNamesToRemove.AddItem(class'X2Effect_Suppression'.default.EffectName);
	RemoveSuppression.bCheckSource = true;
	RemoveSuppression.SetupEffectOnShotContextResult(true, true);
	Template.AddTargetEffect(RemoveSuppression);


	// Reapply the Suppression Aim Penalty on the target until the end of their turn so their subsequent shot still suffers the penalty (with Covering Fire)
	AimPenaltyEffect = new class'X2Effect_WOTC_APA_Class_SuppressionAimPenalty';
	AimPenaltyEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnEnd);
	AimPenaltyEffect.bApplyOnMiss = true;
	AimPenaltyEffect.SetDisplayInfo(ePerkBuff_Penalty, class'X2Effect_WOTC_APA_Class_Suppression'.default.strSuppressionAimPenaltyName, class'X2Ability_GrenadierAbilitySet'.default.SuppressionTargetEffectDesc, Template.IconImage);
	Template.AddTargetEffect(AimPenaltyEffect);


	return Template;
}

static function X2AbilityTemplate WOTC_APA_SuppressionZoneCannonBonus()
{

	local X2AbilityTemplate									Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory	WeaponCondition;


	Template = CreatePassiveAbility('WOTC_APA_SuppressionZoneCannonBonus', "img:///UILibrary_WOTC_APA_Class_Pack.perk_SuppressiveFire",, false);


	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories.AddItem('cannon');
	WeaponCondition.bSkipAbilitySourceWeaponCheck = true;
	Template.AbilityShooterConditions.AddItem(WeaponCondition);

	
	return Template;
}

// Zone Suppresion Build Visualization
simulated function SuppressionZoneBuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory History;
	local XComGameStateContext_Ability  Context;
	local StateObjectReference          InteractingUnitRef;

	local VisualizationActionMetadata        EmptyTrack;
	local VisualizationActionMetadata        ActionMetadata;

	local X2Action_ExitCover			ExitCoverAction;
	local XComGameState_Ability         Ability;
	local X2Action_PlaySoundAndFlyOver SoundAndFlyOver;
	local int i, j;

	History = `XCOMHISTORY;

	TypicalAbility_BuildVisualization(VisualizeGameState);

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	InteractingUnitRef = Context.InputContext.SourceObject;

	//for (i = 0; i < Context.InputContext.MultiTargets.Length; i++)
	//{
		//// Assign the first valid multi-target as the primary target for suppression
		//if (Context.InputContext.PrimaryTarget.ObjectID == 0)
		//{
			//if (Context.InputContext.MultiTargets[i].ObjectID != 0)
			//{
				//Context.InputContext.PrimaryTarget = Context.InputContext.MultiTargets[i];
	//}	}	}

	
	// Configure the visualization track for the shooter
	// ****************************************************************************************
	ActionMetadata = EmptyTrack;
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	ActionMetadata.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);
	
	//ExitCoverAction = X2Action_ExitCover(class'X2Action_ExitCover'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
	//ExitCoverAction.bIsForSuppression = true;
	class'X2Action_ExitCover'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);
	class'X2Action_Fire_SaturationFire'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);
	class'X2Action_Fire_SaturationFire'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);
	//class'X2Action_WOTC_APA_FireZoneSuppressionSweep'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);
	//class'X2Action_WOTC_APA_StartZoneSuppression'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);
	
	// ****************************************************************************************
	// Configure the visualization track for the targets
	for (i = 0; i < Context.InputContext.MultiTargets.Length; i++)
	{
		InteractingUnitRef = Context.InputContext.MultiTargets[i];
		if (Context.ResultContext.MultiTargetHitResults[i] == eHit_Success)
		{
			Ability = XComGameState_Ability(History.GetGameStateForObjectID(Context.InputContext.AbilityRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1));
			ActionMetadata = EmptyTrack;
			ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
			ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
			ActionMetadata.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

			// Overwatch Removed flyover on appropriate targets
			if (XComGameState_Unit(ActionMetadata.StateObject_OldState).ReserveActionPoints.Length != 0 && XComGameState_Unit(ActionMetadata.StateObject_NewState).ReserveActionPoints.Length == 0)
			{
				SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
				SoundAndFlyOver.SetSoundAndFlyOverParameters(none, class'XLocalizedData'.default.OverwatchRemovedMsg, '', eColor_Good);
	}	}	}
}

simulated function SuppressionZoneBuildVisualizationSync(name EffectName, XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata)
{
	local X2Action_ExitCover ExitCover;

	if (EffectName == class'X2Effect_Suppression'.default.EffectName)
	{
		ExitCover = X2Action_ExitCover(class'X2Action_ExitCover'.static.AddToVisualizationTree( ActionMetadata, VisualizeGameState.GetContext() ));
		ExitCover.bIsForSuppression = true;

		class'X2Action_StartSuppression'.static.AddToVisualizationTree( ActionMetadata, VisualizeGameState.GetContext() );
	}
}

simulated function SuppressionZoneEndVisualization_RemovedVisualizationFn(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	local XComGameState_Unit UnitState;

	UnitState = XComGameState_Unit(ActionMetadata.StateObject_NewState);

	//Don't visualize if the unit is dead or incapacitated.
	if( UnitState == none || UnitState.IsDead() || UnitState.IsIncapacitated() || UnitState.bRemovedFromPlay )
		return;

	class'X2Action_EnterCover'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded);
}


// Locked On - Passive: Gain [default: +10] Aim and [default: +10%] chance to Crit on successive shot at the same target
static function X2AbilityTemplate WOTC_APA_LockedOn()
{

	local X2AbilityTemplate								Template;
	local X2Effect_WOTC_APA_LockedOn					ShotEffect;


	Template = CreatePassiveAbility('WOTC_APA_LockedOn', "img:///UILibrary_WOTC_APA_Class_Pack.perk_LockedOn");


	ShotEffect = new class'X2Effect_WOTC_APA_LockedOn';
	ShotEffect.EffectName = 'WOTC_APA_LockedOnEffect';
	ShotEffect.BuildPersistentEffect(1,true,false);
	ShotEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, false,,Template.AbilitySourceName);
	Template.AddTargetEffect(ShotEffect);

	
	return Template;
}


// Flush'em Out - Passive: 
static function X2AbilityTemplate WOTC_APA_FlushEmOut()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_BonusDamage					DamageEffect;
	local X2Effect_WOTC_APA_Class_ConditionalHitModifier		DodgeEffect;
	local array<name>											AbilityArrayNames;


	Template = CreatePassiveAbility('WOTC_APA_FlushEmOut', "img:///UILibrary_WOTC_APA_Class_Pack.perk_FlushEmOut",, false);


	// Create a persistent effect that reduces damage
	DamageEffect = new class'X2Effect_WOTC_APA_Class_BonusDamage';
	DamageEffect.fBonusDmgMultiplier = default.FLUSH_SHOT_DAMAGE_MODIFIER;
	DamageEffect.ValidAbilities.AddItem('WOTC_APA_FlushEmOutShot');
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false,, Template.AbilitySourceName);
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(DamageEffect);


	// Setup effect reducing the chance to graze targets
	AbilityArrayNames.AddItem('WOTC_APA_FlushEmOutShot');
	DodgeEffect = new class'X2Effect_WOTC_APA_Class_ConditionalHitModifier';
	DodgeEffect.AddEffectHitModifier(eHit_Graze, -200, Template.LocFriendlyName,,,,,,AbilityArrayNames);
	DodgeEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(DodgeEffect);


	Template.AdditionalAbilities.AddItem('WOTC_APA_FlushEmOutShot');
	

	return Template;
}

// Flush'em Out Shot - Active:
static function X2AbilityTemplate WOTC_APA_FlushEmOutShot()
{

	local X2AbilityTemplate										Template;
	local X2AbilityCooldown										Cooldown;
	local X2AbilityCost_Ammo									AmmoCost;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2AbilityToHitCalc_StandardAim						ToHitCalc;
	local X2Effect_WOTC_APA_Class_Fallback						ScatterEffect;


	Template = class'X2Ability_WeaponCommon'.static.Add_StandardShot('WOTC_APA_FlushEmOutShot', false, false, false);
	
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_FlushEmOut";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY - 1;
	Template.DefaultSourceItemSlot = eInvSlot_PrimaryWeapon;
	Template.bAllowFreeFireWeaponUpgrade = false;
	

	Template.AbilityCosts.Length=0;

	// Set ability costs, cooldowns, and restrictions
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.FLUSH_SHOT_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = default.FLUSH_SHOT_AMMO_COST;
	Template.AbilityCosts.AddItem(AmmoCost);
	Template.bAllowAmmoEffects = true;

	ActionPointCost = new class 'X2AbilityCost_ActionPoints';
	ActionPointCost.bAddWeaponTypicalCost = true;
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.DoNotConsumeAllSoldierAbilities.AddItem('WOTC_APA_Marauder');
	Template.AbilityCosts.AddItem(ActionPointCost);


	// Disallow crits and add an aim bonus
	ToHitCalc = new class'X2AbilityToHitCalc_StandardAim';
	ToHitCalc.BuiltInHitMod = default.FLUSH_SHOT_AIM_BONUS;
	ToHitCalc.bAllowCrit = false;
	Template.AbilityToHitCalc = ToHitCalc;
	Template.AbilityToHitOwnerOnMissCalc = ToHitCalc;


	// Add fallback effect
	ScatterEffect = new class'X2Effect_WOTC_APA_Class_Fallback';
	//ScatterEffect.BehaviorTree = 'GenericScamperRoot';
	ScatterEffect.BehaviorTree = 'WOTC_APA_FallbackLowerCover';
	Template.AddTargetEffect(ScatterEffect);


	return Template;
}


// Danger Zone - Passive: Increased Suppression Zone angle
static function X2AbilityTemplate WOTC_APA_DangerZone()
{

	local X2AbilityTemplate			Template;


	Template = CreatePassiveAbility('WOTC_APA_DangerZone', "img:///UILibrary_WOTC_APA_Class_Pack.perk_DangerZone");


	//Template.AdditionalAbilities.AddItem('WOTC_APA_DangerZoneCannonBonus');


	return Template;
}

static function X2AbilityTemplate WOTC_APA_DangerZoneCannonBonus()
{

	local X2AbilityTemplate									Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory	WeaponCondition;


	Template = CreatePassiveAbility('WOTC_APA_DangerZoneCannonBonus', "img:///UILibrary_WOTC_APA_Class_Pack.perk_DangerZone",, false);


	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories.AddItem('cannon');
	WeaponCondition.bSkipAbilitySourceWeaponCheck = true;
	Template.AbilityShooterConditions.AddItem(WeaponCondition);

	
	return Template;
}


// Pin'em Down - Passive: Suppression abilities apply a [default: 33%] mobility penalty to targets and has a [default: 33%] chance to disorient (the mobility penalty does not stack with Disorient)
static function X2AbilityTemplate WOTC_APA_PinEmDown()
{

	local X2AbilityTemplate			Template;


	Template = CreatePassiveAbility('WOTC_APA_PinEmDown', "img:///UILibrary_WOTC_APA_Class_Pack.perk_PinEmDown");


	//Template.AdditionalAbilities.AddItem('WOTC_APA_PinEmDownApplyDisorient');
	Template.AdditionalAbilities.AddItem('WOTC_APA_PinEmDownApplyMobilityPenalty');


	return Template;
}

// Pin'em Down Application - Passive: Applies the Disorient/Mobility penalty when Suppression is applied
static function X2AbilityTemplate WOTC_APA_PinEmDownApplyDisorient()
{

	local X2AbilityTemplate											Template;
	local X2Effect_PersistentStatChange								StatChangeEffect;
	local X2AbilityTrigger_EventListener							EventListener;
	local X2Effect_Persistent										DisorientedEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_PinEmDownApplyDisorient');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_PinEmDown";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.bSkipFireAction = true;
	//Template.bShowActivation = true;
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.bCrossClassEligible = false;


	// This ability triggers when Suppression is applied
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = class'X2Effect_WOTC_APA_Class_Suppression'.default.WOTC_APA_Supression_SingleTarget_TriggeredName;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.VoidRiftInsanityListener;
	Template.AbilityTriggers.AddItem(EventListener);


	// Apply the Disorient effect
	DisorientedEffect = class'X2StatusEffects'.static.CreateDisorientedStatusEffect(, , false);
	DisorientedEffect.bRemoveWhenSourceDies = false;
	//DisorientedEffect.ApplyChance = default.PIN_DOWN_DISORIENT_CHANCE;
	Template.AddTargetEffect(DisorientedEffect);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}

static function X2AbilityTemplate WOTC_APA_PinEmDownApplyMobilityPenalty()
{

	local X2AbilityTemplate											Template;
	local X2Effect_Persistent										DisorientedEffect;
	local X2Effect_PersistentStatChange								StatChangeEffect;
	local X2Condition_UnitEffects									EffectCondition;
	local X2AbilityTrigger_EventListener							EventListener;	


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_PinEmDownApplyMobilityPenalty');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_PinEmDown";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.bSkipFireAction = true;
	//Template.bShowActivation = true;
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.bCrossClassEligible = false;


	// This ability triggers when Suppression is applied
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = class'X2Effect_WOTC_APA_Class_Suppression'.default.WOTC_APA_Supression_TriggeredName;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.VoidRiftInsanityListener;
	Template.AbilityTriggers.AddItem(EventListener);
		

	// Apply the Disorient effect
	DisorientedEffect = class'X2StatusEffects'.static.CreateDisorientedStatusEffect(, , false);
	DisorientedEffect.bRemoveWhenSourceDies = false;
	Template.AddTargetEffect(DisorientedEffect);


	// Apply the Mobility penalty if the target is not disoriented
	EffectCondition = new class'X2Condition_UnitEffects';
	EffectCondition.AddExcludeEffect(class'X2AbilityTemplateManager'.default.DisorientedName, 'AA_UnitIsDisoriented');

	StatChangeEffect = new class'X2Effect_PersistentStatChange';
	StatChangeEffect.EffectName = 'WOTC_APA_PinemDownMobilityPenalty';
	StatChangeEffect.DuplicateResponse = eDupe_Ignore;
	StatChangeEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	StatChangeEffect.AddPersistentStatChange(eStat_Mobility, default.PIN_DOWN_MOBILITY_PENALTY, MODOP_Multiplication);
	StatChangeEffect.SetDisplayInfo(ePerkBuff_Penalty, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true);
	StatChangeEffect.TargetConditions.AddItem(EffectCondition);
	Template.AddTargetEffect(StatChangeEffect);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//Template.BuildVisualizationFn = BasicTargetFlyover_BuildVisualization;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}


// Splinter Armor - Passive: Rifles shred 1 armor. Cannons shred 2 armor.
static function X2AbilityTemplate WOTC_APA_Splinter()
{

	local X2AbilityTemplate				Template;
	local X2Effect_WOTC_APA_Splinter	ShredEffect;


	Template = CreatePassiveAbility('WOTC_APA_Splinter', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Splinter", 'WOTC_APA_Splinter_Icon');


	// Create a persistent effect that increases armor shred dependant on weapon category
	ShredEffect = new class'X2Effect_WOTC_APA_Splinter';
	ShredEffect.BuildPersistentEffect(1, true, false, false);
	ShredEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(ShredEffect);


	return Template;
}


// Light 'em Up - Passive: Standard shots no longer end the turn (no restrictions)
static function X2AbilityTemplate WOTC_APA_LightEmUp()
{

	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		RifleCondition, CannonCondition;
	local X2Effect_WOTC_APA_Class_AddAbilitiesToTarget			RifleAbilityEffect, CannonAbilityEffect;


	Template = CreatePassiveAbility('WOTC_APA_LightEmUp', "img:///UILibrary_WOTC_APA_Class_Pack.perk_LightEmUp",, false);


	// Create effect to add Marauder when equipped with a Rifle
	RifleCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	RifleCondition.AllowedWeaponCategories.AddItem('rifle');
	RifleCondition.bCheckSpecificSlot = true;
	RifleCondition.SpecificSlot = eInvSlot_PrimaryWeapon;

	RifleAbilityEffect = new class'X2Effect_WOTC_APA_Class_AddAbilitiesToTarget';
	RifleAbilityEffect.AddAbilities.AddItem('WOTC_APA_Marauder');
	RifleAbilityEffect.ApplyToWeaponSlot = eInvSlot_PrimaryWeapon;
	RifleAbilityEffect.TargetConditions.AddItem(RifleCondition);
	Template.AddTargetEffect(RifleAbilityEffect);


	// Create effect to add Traverse Fire when equipped with a Cannon
	CannonCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	CannonCondition.AllowedWeaponCategories.AddItem('cannon');
	CannonCondition.bCheckSpecificSlot = true;
	CannonCondition.SpecificSlot = eInvSlot_PrimaryWeapon;

	CannonAbilityEffect = new class'X2Effect_WOTC_APA_Class_AddAbilitiesToTarget';
	CannonAbilityEffect.AddAbilities.AddItem('WOTC_APA_TraverseFire');
	CannonAbilityEffect.ApplyToWeaponSlot = eInvSlot_PrimaryWeapon;
	CannonAbilityEffect.TargetConditions.AddItem(CannonCondition);
	Template.AddTargetEffect(CannonAbilityEffect);


	return Template;
}


// Emplaced - Passive: Gain [default: +10] Aim and [default: +5] weapon range if you did not move last turn. Bonus is lost on movement.
static function X2AbilityTemplate WOTC_APA_Emplaced()
{

	local X2AbilityTemplate				Template;
	local X2Effect_Persistent			PersistentEffect;
	local X2Effect_WOTC_APA_Braced		StatChangeEffect;
	local X2Condition_UnitValue			ValueCondition;
	local X2Condition_PlayerTurns		TurnsCondition;


	Template = CreatePassiveAbility('WOTC_APA_Emplaced', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Emplaced",, false /*Helper passive Icon uses LocHelpText... we want LocLongDescription in this case*/);


	// This effect stays on the unit indefinitely
	PersistentEffect = new class'X2Effect_Persistent';
	PersistentEffect.EffectName = 'EmplacedEffect';
	PersistentEffect.BuildPersistentEffect(1, true, false, false, eGameRule_PlayerTurnBegin);
	PersistentEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage,,, Template.AbilitySourceName);

	// At the start of each turn, this effect is applied if conditions are met. Moving will remove the effect.
	StatChangeEffect = new class'X2Effect_WOTC_APA_Braced';
	StatChangeEffect.EffectName = 'WOTC_APA_EmplacedBoost';
	StatChangeEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnBegin);
	StatChangeEffect.AddPersistentStatChange(eStat_Offense, default.EMPLACED_AIM_BONUS);
	StatChangeEffect.AddPersistentStatChange(eStat_SightRadius, default.EMPLACED_VISION_BONUS);
	StatChangeEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true);
	
	// This condition check that the unit did not move last turn before allowing the bonus to be applied
	ValueCondition = new class'X2Condition_UnitValue';
	ValueCondition.AddCheckValue('MovesThisTurn', 1, eCheck_LessThan);
	StatChangeEffect.TargetConditions.AddItem(ValueCondition);

	// This condition guarantees the player has started more than 1 turn. the first turn of the game does not count, as there was no "previous" turn.
	TurnsCondition = new class'X2Condition_PlayerTurns';
	TurnsCondition.NumTurnsCheck.CheckType = eCheck_GreaterThan;
	TurnsCondition.NumTurnsCheck.Value = 1;
	StatChangeEffect.TargetConditions.AddItem(TurnsCondition);

	PersistentEffect.ApplyOnTick.AddItem(StatChangeEffect);
	Template.AddShooterEffect(PersistentEffect);


	return Template;
}


// Combat Awareness - Passive: Grants defense and armor when in overwatch
static function X2AbilityTemplate WOTC_APA_CombatAwareness()
{

	local X2AbilityTemplate							Template;
	local X2Effect_WOTC_APA_CombatAwareness			DefenseEffect;


	`CREATE_X2ABILITY_TEMPLATE (Template, 'WOTC_APA_CombatAwareness');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_CombatAwareness";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;	
	Template.AbilityToHitCalc = default.DeadEye;
    Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bDisplayInUITooltip = true;
	Template.bDisplayInUITacticalText = true;
	Template.bSkipFireAction = true;
	Template.bCrossClassEligible = false;


	// Create the defense effect whenever the target has reserve action points
	DefenseEffect = new class'X2Effect_WOTC_APA_CombatAwareness';
	DefenseEffect.BuildPersistentEffect(1,true,false);
	DefenseEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(DefenseEffect);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;		
	return Template;
}


// Bring'em On - Passive:
static function X2AbilityTemplate WOTC_APA_BringEmOn()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_ConditionalHitModifier		CritChance;
	local X2Effect_WOTC_APA_Class_BonusDamage					DamageEffect;


	Template = CreatePassiveAbility('WOTC_APA_BringEmOn', "img:///UILibrary_WOTC_APA_Class_Pack.perk_BringEmOn");


	// Create a persistent effect that increases Critical Hit Chance for Suppression shot abilities
	CritChance = new class'X2Effect_WOTC_APA_Class_ConditionalHitModifier';
	CritChance.AddEffectHitModifier(eHit_Crit, default.BRINGEM_ON_CRIT_CHANCE_BONUS, Template.LocFriendlyName,,,,,,default.FIRE_DISCIPLINE_SUPPRESSION_ABILITIES);
	CritChance.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(CritChance);


	// Create a persistent effect that increases damage on Critical Hits for Suppression shot abilities
	DamageEffect = new class'X2Effect_WOTC_APA_Class_BonusDamage';
	DamageEffect.BonusCritDmg = default.BRINGEM_ON_CRIT_DAMAGE_BONUS;
	DamageEffect.ValidAbilities = default.FIRE_DISCIPLINE_SUPPRESSION_ABILITIES;
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false,, Template.AbilitySourceName);
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(DamageEffect);
	

	return Template;
}


// No Man's Land - Passive:
static function X2AbilityTemplate WOTC_APA_NoMansLand()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_BonusDamage					DamageEffect;


	Template = CreatePassiveAbility('WOTC_APA_NoMansLand', "img:///UILibrary_WOTC_APA_Class_Pack.perk_NoMansLand");


	// Create a persistent effect that forces a flyover
	DamageEffect = new class'X2Effect_WOTC_APA_Class_BonusDamage';
	DamageEffect.BonusDmg = -1;
	DamageEffect.ValidAbilities.AddItem('WOTC_APA_NoMansLandShot');
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false,, Template.AbilitySourceName);
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(DamageEffect);

	
	Template.AdditionalAbilities.AddItem('WOTC_APA_NoMansLandShot');


	return Template;
}

// Zone Suppression No-Man's Land Shot - Passive: Triggers on other targets moving into or through the Zone Suppression area
static function X2AbilityTemplate WOTC_APA_NoMansLandShot()
{
	
	local X2AbilityTemplate											Template;	
	local X2AbilityCost_ReserveActionPoints							ReserveActionPointCost;
	local X2AbilityCost_Ammo										AmmoCost;
	local X2AbilityToHitCalc_StandardAim							StandardAim;
	local X2Condition_UnitEffectsWithAbilitySource					TargetEffectCondition;
	local X2Condition_AbilityProperty								AbilityCondition;
	local X2Effect_Persistent										MarkUnitsEffect;


	Template = CreateAbilityReactionShot('WOTC_APA_NoMansLandShot', "img:///UILibrary_WOTC_APA_Class_Pack.perk_NoMansLand", eInvSlot_PrimaryWeapon);
	Template.bSkipExitCoverWhenFiring = true; // don't want to exit cover, we are already in suppression/alert mode.
	

	// Define Ability Costs and Cooldown (Action Points, Ammo, etc.)
	ReserveActionPointCost = new class'X2AbilityCost_ReserveActionPoints';
	ReserveActionPointCost.iNumPoints = 1;
	ReserveActionPointCost.bFreeCost = true;
	ReserveActionPointCost.AllowedTypes.AddItem('ZoneSuppression');
	Template.AbilityCosts.AddItem(ReserveActionPointCost);

	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);


	//// Define Aim (can't Crit)
	//StandardAim = new class'X2AbilityToHitCalc_StandardAim';
	//StandardAim.BuiltInHitMod = 0;
	//StandardAim.bReactionFire = true;
	//StandardAim.bAllowCrit = false;

	//Template.AbilityToHitCalc = StandardAim;
	//Template.AbilityToHitOwnerOnMissCalc = StandardAim;

	
	// Target must NOT have already been attacked this turn or an initial Zone Suppression target of this unit
	TargetEffectCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	TargetEffectCondition.AddExcludeEffect('ZoneSuppressionKillZoneExclude', 'AA_UnitIsNotSuppressed');
	Template.AbilityTargetConditions.AddItem(TargetEffectCondition);

	// Target must be in valid marked tiles for this ability
	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.TargetMustBeInValidTiles = true;
	Template.AbilityTargetConditions.AddItem(AbilityCondition);
	
	// Mark units that are shot to prevent additional shots being taken
	MarkUnitsEffect = new class'X2Effect_Persistent';
	MarkUnitsEffect.EffectName = 'ZoneSuppressionKillZoneExclude';
	MarkUnitsEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnBegin);
	MarkUnitsEffect.SetupEffectOnShotContextResult(true, true);
	Template.AddTargetEffect(MarkUnitsEffect);

	
	Template.BuildVisualizationFn = AddTargetFlyover_BuildVisualization;
	return Template;
}


// On Target - Passive:
static function X2AbilityTemplate WOTC_APA_OnTarget()
{

	local X2AbilityTemplate			Template;
	local X2Effect_ToHitModifier	GrazeReduction;


	Template = CreatePassiveAbility('WOTC_APA_OnTarget', "img:///UILibrary_WOTC_APA_Class_Pack.perk_OnTarget");


	Template.AddTargetEffect(new class'X2Effect_WOTC_APA_OnTarget');


	// Setup effect reducing the chance to graze targets
	GrazeReduction = new class'X2Effect_ToHitModifier';
	GrazeReduction.AddEffectHitModifier(eHit_Graze, -default.ON_TARGET_DODGE_REDUCTION, Template.LocFriendlyName);
	GrazeReduction.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(GrazeReduction);


	//Template.AdditionalAbilities.AddItem('WOTC_APA_OnTargetFlyover');


	return Template;
}

// On-Target Flyover - Triggered:
static function X2AbilityTemplate WOTC_APA_OnTargetFlyover()
{

	local X2AbilityTemplate											Template;
	local X2AbilityTrigger_EventListener							EventListener;
	local X2Effect_ApplyWeaponDamage								MissDamage;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_OnTargetFlyover');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_OnTarget";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bDisplayInUITacticalText = false;
	Template.bDisplayInUITooltip = false;
	Template.bCrossClassEligible = false;


	// This ability triggers after X2Effect_WOTC_APA_OnTarget successfully converts a miss to a graze
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = class'X2Effect_WOTC_APA_OnTarget'.default.WOTC_APA_OnTarget_TriggeredName;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.VoidRiftInsanityListener;
	Template.AbilityTriggers.AddItem(EventListener);


	// Add Weapon Stock damage on misses
	MissDamage = new class'X2Effect_ApplyWeaponDamage';
	MissDamage.bIgnoreBaseDamage = true;
	MissDamage.DamageTag = 'Miss';
	MissDamage.bAllowWeaponUpgrade = true;
	MissDamage.bAllowFreeKill = false;
	Template.AddTargetEffect(MissDamage);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = BasicTargetFlyover_BuildVisualization;
	return Template;
}


// Weapons Hot - Passive:
static function X2AbilityTemplate WOTC_APA_WeaponsHot()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_BonusDamage					DamageEffect;


	Template = CreatePassiveAbility('WOTC_APA_WeaponsHot', "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_Interrupt");


	// Create a persistent effect that forces a flyover
	DamageEffect = new class'X2Effect_WOTC_APA_Class_BonusDamage';
	DamageEffect.BonusDmg = -1;
	DamageEffect.ValidAbilities.AddItem('WOTC_APA_WeaponsHotShot');
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false,, Template.AbilitySourceName);
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(DamageEffect);


	Template.AdditionalAbilities.AddItem('WOTC_APA_WeaponsHotTriggerCannon');
	Template.AdditionalAbilities.AddItem('WOTC_APA_WeaponsHotTriggerRifle');
	Template.AdditionalAbilities.AddItem('WOTC_APA_WeaponsHotShot');


	return Template;
}

// Weapons Hot Trigger Cannon - Passive:
static function X2AbilityTemplate WOTC_APA_WeaponsHotTriggerCannon()
{

	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;


	Template = WOTC_APA_CreateWeaponsHotTrigger('WOTC_APA_WeaponsHotTriggerCannon', default.WEAPONS_HOT_TRIGGER_CHANCE_CANNON);


	// Exclude when equipped with Rifle
	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.ExcludedWeaponCategories.AddItem('rifle');
	WeaponCondition.bCheckSpecificSlot = true;
	WeaponCondition.SpecificSlot = eInvSlot_PrimaryWeapon;
	Template.AbilityShooterConditions.AddItem(WeaponCondition);


	return Template;
}

// Weapons Hot Trigger Rifle - Passive:
static function X2AbilityTemplate WOTC_APA_WeaponsHotTriggerRifle()
{

	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_ValidWeaponCategory		WeaponCondition;


	Template = WOTC_APA_CreateWeaponsHotTrigger('WOTC_APA_WeaponsHotTriggerRifle', default.WEAPONS_HOT_TRIGGER_CHANCE_RIFLE);


	// Require equipped with Rifle
	WeaponCondition = new class'X2Condition_WOTC_APA_Class_ValidWeaponCategory';
	WeaponCondition.AllowedWeaponCategories.AddItem('rifle');
	WeaponCondition.bCheckSpecificSlot = true;
	WeaponCondition.SpecificSlot = eInvSlot_PrimaryWeapon;
	Template.AbilityShooterConditions.AddItem(WeaponCondition);


	return Template;
}

// Weapons Hot Trigger Create Function
static function X2AbilityTemplate WOTC_APA_CreateWeaponsHotTrigger(name AbilityName, int TriggerChance)
{

	local X2AbilityTemplate										Template;	
	local X2AbilityTarget_Single								SingleTarget;
	local X2AbilityToHitCalc_PercentChance						TargetChance;
	local X2AbilityTrigger_EventListener						Trigger;
	local X2Condition_UnitProperty								TargetCondition;
	local X2Condition_Visibility								TargetVisibilityCondition;
	local X2Condition_WOTC_APA_Class_Concealment				ConcealedCondition;
	local X2Condition_UnitEffects								PanicCondition;
	local X2Condition_UnitEffectsWithAbilitySource				EffectCondition;
	local X2Effect_Persistent									TargetEffect;


	`CREATE_X2ABILITY_TEMPLATE (Template, AbilityName);
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_Interrupt";
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.Hostility = eHostility_Neutral;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.DisplayTargetHitChance = false;
	Template.bCrossClassEligible = false;
	Template.bUniqueSource = true;
	

	// Setup trigger targeting
	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.OnlyIncludeTargetsInsideWeaponRange = true;
	Template.AbilityTargetStyle = SingleTarget;

	TargetChance = new class'X2AbilityToHitCalc_PercentChance';
	TargetChance.PercentToHit = TriggerChance;
	Template.AbilityToHitCalc = TargetChance;


	// Trigger on movement - interrupt the move
	Trigger = new class'X2AbilityTrigger_EventListener';
	Trigger.ListenerData.EventID = 'ObjectMoved';
	Trigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	Trigger.ListenerData.Filter = eFilter_None;
	Trigger.ListenerData.EventFn = class'XComGameState_Ability'.static.TypicalOverwatchListener;
	Template.AbilityTriggers.AddItem(Trigger);

	Template.PostActivationEvents.AddItem('WOTC_APA_WeaponsHotTriggered');


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
	
	Template.AddShooterEffectExclusions();

	PanicCondition = new class'X2Condition_UnitEffects';
	PanicCondition.AddExcludeEffect(class'X2AbilityTemplateManager'.default.PanickedName, 'AA_UnitIsPanicked');
	PanicCondition.AddExcludeEffect(class'X2AbilityTemplateManager'.default.BerserkName, 'AA_UnitIsPanicked');
	PanicCondition.AddExcludeEffect(class'X2AbilityTemplateManager'.default.ObsessedName, 'AA_UnitIsPanicked');
	PanicCondition.AddExcludeEffect(class'X2AbilityTemplateManager'.default.ShatteredName, 'AA_UnitIsPanicked');
	Template.AbilityShooterConditions.AddItem(PanicCondition);

	ConcealedCondition = new class'X2Condition_WOTC_APA_Class_Concealment';
	ConcealedCondition.bExpectConcealment = false;
	Template.AbilityShooterConditions.AddItem(ConcealedCondition);

	//  Do not shoot targets that were already hit by this unit this turn with this ability
	EffectCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	EffectCondition.AddExcludeEffect('WOTC_APA_WeaponsHotTarget', 'AA_UnitIsImmune');
	Template.AbilityTargetConditions.AddItem(EffectCondition);


	// Mark the target as rolled against already so it cannot be targeted again
	TargetEffect = new class'X2Effect_Persistent';
	TargetEffect.EffectName = 'WOTC_APA_WeaponsHotTarget';
	TargetEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);

	// Mark them regardless of taking the shot or not (otherwise each tile would trigger a chance to hit)
	TargetEffect.SetupEffectOnShotContextResult(true, true);      
	Template.AddTargetEffect(TargetEffect);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;	
}

// Weapons Hot Shot - Triggered:
static function X2AbilityTemplate WOTC_APA_WeaponsHotShot()
{

	local X2AbilityTemplate                 Template;
	local X2AbilityTrigger_EventListener    EventTrigger;
	local X2AbilityTarget_Single            SingleTarget;
	local X2AbilityToHitCalc_StandardAim    StandardAim;
	local X2AbilityCost_Ammo                AmmoCost;
	local X2Effect_Knockback				KnockbackEffect;


	`CREATE_X2ABILITY_TEMPLATE (Template, 'WOTC_APA_WeaponsHotShot');
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_Interrupt";
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.bDontDisplayInAbilitySummary = true;
	Template.DisplayTargetHitChance = false;
	Template.bFrameEvenWhenUnitIsHidden = true;	
	Template.bShowActivation = true;


	// Setup shot's event trigger and target
	EventTrigger = new class'X2AbilityTrigger_EventListener';
	EventTrigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventTrigger.ListenerData.EventID = 'WOTC_APA_WeaponsHotTriggered';
	EventTrigger.ListenerData.EventFn = class'XComGameState_Ability'.static.ChainShotListener; //  activates against the event's context's primary target if the roll succeeded
	EventTrigger.ListenerData.Filter = eFilter_Unit;
	Template.AbilityTriggers.AddItem(EventTrigger);

	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.OnlyIncludeTargetsInsideWeaponRange = true;
	Template.AbilityTargetStyle = SingleTarget;

	StandardAim = new class'X2AbilityToHitCalc_StandardAim';
	StandardAim.bReactionFire = true;
	StandardAim.bAllowCrit = false;
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


// Withering Barrage - Passive:
static function X2AbilityTemplate WOTC_APA_WitheringBarrage()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_BonusDamage					DamageEffect;


	Template = CreatePassiveAbility('WOTC_APA_WitheringBarrage', "img:///UILibrary_WOTC_APA_Class_Pack.perk_WitheringBarrage");
	

	// Create a persistent effect that forces a flyover
	DamageEffect = new class'X2Effect_WOTC_APA_Class_BonusDamage';
	DamageEffect.BonusDmg = -1;
	DamageEffect.ValidAbilities.AddItem('WOTC_APA_WitheringBarrageApply');
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false,, Template.AbilitySourceName);
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(DamageEffect);


	Template.AdditionalAbilities.AddItem('WOTC_APA_WitheringBarrageApply');


	return Template;
}

// Withering Barrage Application - Passive: Applies grazing damage to Suppression targets on application if chance roll passes
static function X2AbilityTemplate WOTC_APA_WitheringBarrageApply()
{

	local X2AbilityTemplate											Template;
	local X2AbilityTrigger_EventListener							EventListener;
	local X2Effect_ApplyWeaponDamage								WeaponDamageEffect;



	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_WitheringBarrageApply');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_WitheringBarrage";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.DefaultSourceItemSlot = eInvSlot_PrimaryWeapon;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.bCrossClassEligible = false;


	// This ability triggers when Suppression is applied
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = class'X2Effect_WOTC_APA_Class_Suppression'.default.WOTC_APA_Supression_TriggeredName;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.VoidRiftInsanityListener;
	Template.AbilityTriggers.AddItem(EventListener);

	
	// Apply grazing weapon damage to target
	Template.AbilityToHitCalc = new class'X2AbilityToHitCalc_WOTC_APA_SuppressionGraze';
	//Template.AbilityToHitOwnerOnMissCalc = new class'X2AbilityToHitCalc_WOTC_APA_SuppressionGraze';

	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	Template.AddTargetEffect(WeaponDamageEffect);
	//Template.bAllowBonusWeaponEffects = true;
	//Template.bAllowAmmoEffects = true;
	//Template.AbilityToHitCalc = default.DeadEye;

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = AddTargetFlyover_BuildVisualization;
	//Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}


// Tactical Sense - Passive:
static function X2AbilityTemplate WOTC_APA_TacticalSense()
{

	local X2AbilityTemplate					Template;


	Template = CreatePassiveAbility('WOTC_APA_TacticalSense', "img:///UILibrary_WOTC_APA_Class_Pack.perk_TacticalSense");


	Template.AddTargetEffect(new class'X2Effect_WOTC_APA_TacticalSense');


	return Template;
}


// Aggression - Passive:
static function X2AbilityTemplate WOTC_APA_Aggression()
{

	local X2AbilityTemplate			Template;


	Template = CreatePassiveAbility('WOTC_APA_Aggression', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Aggression");


	Template.AddTargetEffect(new class'X2Effect_WOTC_APA_Aggression');
	

	return Template;
}


// Zeroed In - Passive:
static function X2AbilityTemplate WOTC_APA_ZeroedIn()
{

	local X2AbilityTemplate			Template;


	Template = CreatePassiveAbility('WOTC_APA_ZeroedIn', "img:///UILibrary_WOTC_APA_Class_Pack.perk_ZeroedIn");
	Template.PrerequisiteAbilities.AddItem('WOTC_APA_WitheringBarrage');
	

	return Template;
}


// Impressive Strength - Passive:
static function X2AbilityTemplate WOTC_APA_ImpressiveStrength()
{

	local X2AbilityTemplate											Template;
	local X2Effect_PersistentStatChange								Effect;


	Template = CreatePassiveAbility('WOTC_APA_ImpressiveStrength', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Strong");
	

	// Create a persistent stat change effect that adds [default: 2] HP
	Effect = new class 'X2Effect_PersistentStatChange';
	Effect.EffectName = 'WOTC_APA_ImpressiveStrength';
	Effect.BuildPersistentEffect(1, true, false, false);
	Effect.AddPersistentStatChange(eStat_HP, default.IMPRESSIVE_STRENGTH_HP_BONUS);
	Template.AddTargetEffect(Effect);


	// Add UI stat markups corresponding to effect stat boosts
	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, default.IMPRESSIVE_STRENGTH_HP_BONUS);


	return Template;
}


// Traverse Fire - Passive: Standard shots no longer end the turn, but remaining actions may only be used to fire or reload
static function X2AbilityTemplate WOTC_APA_TraverseFire()
{

	local X2AbilityTemplate								Template;
	local X2Effect_WOTC_APA_TraverseFire				ActionEffect;


	Template = CreatePassiveAbility('WOTC_APA_TraverseFire', "img:///UILibrary_WOTC_APA_Class_Pack.perk_TraverseFire");


	ActionEffect = new class'X2Effect_WOTC_APA_TraverseFire';
	ActionEffect.BuildPersistentEffect(1,true,false);
	Template.AddTargetEffect(ActionEffect);


	Template.OverrideAbilities.AddItem('WOTC_APA_SustainedFire');

	
	return Template;
}