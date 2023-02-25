class WOTC_APA_Class_Pack_ModifyTemplates extends X2StrategyElement config(WOTC_APA_Class_Pack);


var config array<name>	ADD_OVERWATCH_ABILITY_CONDITIONS;

var config array<name>	ADD_ARCTHROWER_ABILITY_EFFECTS;

var config array<name>	ADD_HACKING_VISIBILITY_CONDITIONS;

var config bool			CONCUSSION_GRENADES_DISORIENT_ALLIES;
var config array<name>	ADD_DISORIENT_TO_CONCUSSION_GRENADES;
var config array<name>	ADD_RUPTURE_TO_CONCENTRATED_CORROSIVES_GRENADES;
var config array<name>	ADD_SCATTER_PANIC_TO_BURN_OUT_GRENADES;
var config array<name>	ADD_STUN_TO_CHEMICAL_WARFARE_GRENADES;


static function UpdateTemplates()
{
	local name		AbilityName;
	local bool		bDebugLogging;

	bDebugLogging = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	// Update Ability Templates to set bCrossClassEligible to true (make eligible for the Training Center):
	// ****************************************************************************************************
	foreach class'X2DownloadableContentInfo_WOTC_APA_Class_Pack'.default.TRAINING_CENTER_XCOM_ABILITIES(AbilityName)
	{
		SetAbilityToCrossClassTrue(AbilityName, bDebugLogging);
	}

	// Update XPACK Weapon Templates to make them starting items and fix T1 Vektor Rifle:
	// **********************************************************************************
	UpdateStartingXPACKWeaponTemplates(bDebugLogging);

	// Update Rifle and Bullpup Weapon Templates to use Musashi's Full Auto animset for Burst Fire:
	// ********************************************************************************************
	UpdateWeaponTemplatesForBurstFire(bDebugLogging);

	// Update eAbilityIconBehaviorHUD and action point type of Sniper Rifle Overwatch:
	// *******************************************************************************
	UpdateSniperRifleOverwatchBehavior(bDebugLogging);
	UpdatePistolOverwatchBehavior(bDebugLogging);

	// Update the HitCalc type for Demolition to be guaranteed to hit:
	// ***************************************************************
	UpdateDemolitionHitCalc();

	// Update Ability Templates to accept different action point types:
	// ****************************************************************
	// Add FleetFootedFree action points to the available action point types for abilities that can be used with Emergency Aid and Rapid Deployment
	// This allows Emergency Aid / Rapid Deployment and Fleet-Footed abilities to work together when both are active for the following abilities:
	AddActionPointType('WOTC_APA_EmergencyAid', class'X2Effect_WOTC_APA_FleetFootedRapidDeploymentActionPoint'.default.FreeActionPointType, bDebugLogging);	// Allows Emergency Aid to be triggered by the Fleet-Footed Rapid Deployment action
	AddActionPointType('WOTC_APA_RapidDeployment', class'X2Effect_WOTC_APA_FleetFootedEmergencyAidActionPoint'.default.FreeActionPointType, bDebugLogging);	// Allows Rapid Deployment to be triggered by the Fleet-Footed Emergency Aid action
	
	foreach class'X2Effect_WOTC_APA_EmergencyAid'.default.EMERGENCY_AID_VALID_ABILITIES(AbilityName)
	{
		AddActionPointType(AbilityName, class'X2Effect_WOTC_APA_FleetFootedEmergencyAidActionPoint'.default.FreeActionPointType, bDebugLogging);
	}
	
	foreach class'X2Effect_WOTC_APA_RapidDeployment'.default.RAPID_DEPLOYMENT_VALID_ABILITIES(AbilityName)
	{
		AddActionPointType(AbilityName, class'X2Effect_WOTC_APA_FleetFootedRapidDeploymentActionPoint'.default.FreeActionPointType, bDebugLogging);
	}

	foreach class'X2Effect_WOTC_APA_RapidDeployment'.default.RAPID_DEPLOYMENT_VALID_GRENADE_ABILITIES(AbilityName)
	{
		AddActionPointType(AbilityName, class'X2Effect_WOTC_APA_FleetFootedRapidDeploymentActionPoint'.default.FreeActionPointType, bDebugLogging);
		AddFleetFootedRapidDeploymentGrenadeTypeCondition(AbilityName, bDebugLogging);
	}

	// Add Traverse Fire action points to the available action point types for valid abilities:
	foreach class'X2Effect_WOTC_APA_TraverseFire'.default.TRAVERSE_FIRE_VALID_ABILITIES(AbilityName)
	{
		AddActionPointType(AbilityName, class'X2Effect_WOTC_APA_TraverseFire'.default.TraverseFireActionPointType, bDebugLogging);
	}

	// Add Sustained Fire action points to the available action point types for valid abilities:
	foreach class'X2Effect_WOTC_APA_SustainedFire'.default.SUSTAINED_FIRE_VALID_ABILITIES(AbilityName)
	{
		AddActionPointType(AbilityName, class'X2Effect_WOTC_APA_SustainedFire'.default.SustainedFireActionPointType, bDebugLogging);
	}

	// Add Marauder to the DoNotConsumeAllSoldierAbilities for StandardShot:
	// **************************************************************************************
	AddDoNotConsumeAllActionsAbility('StandardShot', 'WOTC_APA_Marauder', bDebugLogging);
	AddDoNotConsumeAllActionsAbility('SniperStandardFire', 'WOTC_APA_Marauder', bDebugLogging);	

	// Add Quickdraw to the DoNotConsumeAllSoldierAbilities for PistolStandardShot:
	// ****************************************************************************
	AddDoNotConsumeAllActionsAbility('PistolStandardShot', 'WOTC_APA_Quickdraw', bDebugLogging);

	// Update StandardShot's ActionPointCost to add a DoNotConsumeAllEffects entry:
	// ****************************************************************************
	AddDoNotConsumeAllActionsEffect('StandardShot', 'WOTC_APA_RunAndGun_NonTurnEndingShots', bDebugLogging);

	// Add PistolStandardShot to the pistol item and set bUniqueSource to true:
	// ************************************************************************
	AddAbilityToItemCategory('PistolStandardShot', 'pistol', bDebugLogging);
	SetAbilityToUniqueForSource('PistolStandardShot', bDebugLogging);

	// Update Overwatch Ability Templates to add target limit and ToHit conditions:
	// ****************************************************************************
	foreach default.ADD_OVERWATCH_ABILITY_CONDITIONS(AbilityName)
	{
		AddOverwatchConditions(AbilityName, bDebugLogging);
	}

	// Update Arcthrower Ability Templates to add new effects for Sedate and Overcharged Capacitors:
	// *********************************************************************************************
	foreach default.ADD_ARCTHROWER_ABILITY_EFFECTS(AbilityName)
	{
		//AddArcthrowerEffects(AbilityName, bDebugLogging);
	}

	// Update Hacking Ability Templates to add squadsight visibility and associated conditions:
	// ***************************************************************************************
	foreach default.ADD_HACKING_VISIBILITY_CONDITIONS(AbilityName)
	{
		AddHackingVisibilityConditions(AbilityName, bDebugLogging);
	}

	// Update Haywire Protocol's ActionPointCost to add a DoNotConsumeAllEffects entry:
	// ********************************************************************************
	AddDoNotConsumeAllActionsEffect('FinalizeHaywire', 'WOTC_APA_ABCProtocols_DoNotConsumeAllActionsEffect', bDebugLogging);
	
	// Update Haywire Protocol to add the reduced action point effect from WOTC_APA_ElectronicWarfare:
	// ***********************************************************************************************
	AddElectronicWarfareEffectToHaywire(bDebugLogging);

	// Update Haywire Protocol to add a shared cooldown with Full Override:
	// ********************************************************************
	AddFullOverrideSharedCooldownToHaywire(bDebugLogging);

	// Update Robotic Character Templates to add the Full Override hacking rewards:
	// ****************************************************************************
	AddFullOverrideToRoboticCharacterTemplates(bDebugLogging);

	// Update Grenade abilities to support bonus ability radius from Air-Burst Grenades:
	// *********************************************************************************
	AddAbilityBonusRadius('ThrowGrenade', 'WOTC_APA_AirburstGrenades', class'X2Ability_WOTC_APA_SapperAbilitySet'.default.AIRBURST_GRENADES_BONUS_RADIUS, bDebugLogging);
	AddAbilityBonusRadius('LaunchGrenade', 'WOTC_APA_AirburstGrenades', class'X2Ability_WOTC_APA_SapperAbilitySet'.default.AIRBURST_GRENADES_BONUS_RADIUS, bDebugLogging);
	AddAbilityBonusRadius('ProximityMineDetonation', 'WOTC_APA_AirburstGrenades', class'X2Ability_WOTC_APA_SapperAbilitySet'.default.AIRBURST_GRENADES_BONUS_RADIUS, bDebugLogging);
	AddAbilityBonusRadius('ProximityMineM2Detonation', 'WOTC_APA_AirburstGrenades', class'X2Ability_WOTC_APA_SapperAbilitySet'.default.AIRBURST_GRENADES_BONUS_RADIUS, bDebugLogging);
	AddAbilityBonusRadius('IRI_FireRocket', 'WOTC_APA_AirburstGrenades', class'X2Ability_WOTC_APA_SapperAbilitySet'.default.AIRBURST_GRENADES_BONUS_RADIUS, bDebugLogging);
	AddAbilityBonusRadius('IRI_FireLockon', 'WOTC_APA_AirburstGrenades', class'X2Ability_WOTC_APA_SapperAbilitySet'.default.AIRBURST_GRENADES_BONUS_RADIUS, bDebugLogging);
	AddAbilityBonusRadius('IRI_Fire_PlasmaEjector', 'WOTC_APA_AirburstGrenades', class'X2Ability_WOTC_APA_SapperAbilitySet'.default.AIRBURST_GRENADES_BONUS_RADIUS, bDebugLogging);

	// Update Grenade Templates to add a disorient effect to targets in the initial explosion:
	// ***************************************************************************************
	foreach default.ADD_DISORIENT_TO_CONCUSSION_GRENADES(AbilityName)
	{
		AddDisorientToConcussionGrenadeTemplates(AbilityName ,bDebugLogging);
	}

	// Update Gas Grenade/Bomb Templates to add a one-action stun to targets in the initial explosion:
	// ***********************************************************************************************
	foreach default.ADD_STUN_TO_CHEMICAL_WARFARE_GRENADES(AbilityName)
	{
		AddStunToChemicalWarfareGrenadeTemplates(AbilityName ,bDebugLogging);
	}

	// Update Fire Grenade/Bomb Templates to add a chance to panic and/or fallback from current position:
	// **************************************************************************************************
	foreach default.ADD_SCATTER_PANIC_TO_BURN_OUT_GRENADES(AbilityName)
	{
		AddScatterPanicToBurnOutGrenadeTemplates(AbilityName ,bDebugLogging);
	}

	// Update Acid Grenade/Bomb Templates to add a rupture effect to targets in the initial explosion:
	// ***********************************************************************************************
	foreach default.ADD_RUPTURE_TO_CONCENTRATED_CORROSIVES_GRENADES(AbilityName)
	{
		AddRuptureToAcidGrenadeTemplates(AbilityName ,bDebugLogging);
	}
	
	// Update Battlescanners to apply bonus effects with the Upgraded Scanners ability:
	// ********************************************************************************
	AddUpgradedBattleScannersEffect(bDebugLogging);

	// Update visualization method for proximity mines (correct bugs with base-game visualization):
	// ********************************************************************************************
	UpdateProximityMineDetonationVisualization(bDebugLogging);
	
	// Adjust ShotHUD position and turn-ending ability status for Iridar's First Aid ability:
	// **************************************************************************************
	AddDoNotConsumeAllActionsAbility('IRI_FirstAid', 'WOTC_APA_AdvancedTraumaKits', bDebugLogging);
	UpdateAbilityShotHUDPriority('IRI_FirstAid', class'UIUtilities_Tactical'.const.STABILIZE_PRIORITY - 2, bDebugLogging);

	// Add this version of Sword Slice as an overridden ability for Shield Bash:
	// *************************************************************************
	AddAbilityOverride('ShieldBash', 'WOTC_APA_SwordSlice', bDebugLogging);
}


// Action Point Functions:
// ***********************

static function AddActionPointType(name AbilityName, name ActionPointType, bool bDebugLogging)
{
	local X2AbilityTemplateManager				AbilityTemplateMgr;
	local array<X2AbilityTemplate>				AbilityTemplateArray;
	local X2AbilityTemplate						AbilityTemplate;
	local X2AbilityCost_ActionPoints			ActionPointCost;
    local X2AbilityCost							Cost;

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties(AbilityName, AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		foreach AbilityTemplate.AbilityCosts(Cost)
		{
			ActionPointCost = X2AbilityCost_ActionPoints(Cost);
			if (ActionPointCost != none)
			{
				ActionPointCost.AllowedTypes.AddItem(ActionPointType);
				`Log("WOTC_APA_Class_Pack - Add Action Point Type: Add" @ ActionPointType @ "to" @ AbilityName, bDebugLogging);
}	}	}	}


static function AddDoNotConsumeAllActionsAbility(name AbilityName, name DoNotConsumeAllAbilityName, bool bDebugLogging)
{
	local X2AbilityTemplateManager				AbilityTemplateMgr;
	local array<X2AbilityTemplate>				AbilityTemplateArray;
	local X2AbilityTemplate						AbilityTemplate;
	local X2AbilityCost_ActionPoints			ActionPointCost;
    local X2AbilityCost							Cost;

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties(AbilityName, AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		foreach AbilityTemplate.AbilityCosts(Cost)
		{
			ActionPointCost = X2AbilityCost_ActionPoints(Cost);
			if (ActionPointCost != none)
			{
				ActionPointCost.DoNotConsumeAllSoldierAbilities.AddItem(DoNotConsumeAllAbilityName);
				`Log("WOTC_APA_Class_Pack - Add DoNotConsumeAllActions Ability: Add" @ DoNotConsumeAllAbilityName @ "to the ActionPointCost.DoNotConsumeAllSoldierAbilities for" @ AbilityName, bDebugLogging);
}	}	}	}


static function AddDoNotConsumeAllActionsEffect(name AbilityName, name DoNotConsumeAllEffectName, bool bDebugLogging)
{
	local X2AbilityTemplateManager				AbilityTemplateMgr;
	local array<X2AbilityTemplate>				AbilityTemplateArray;
	local X2AbilityTemplate						AbilityTemplate;
	local X2AbilityCost_ActionPoints			ActionPointCost;
    local X2AbilityCost							Cost;

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties(AbilityName, AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		foreach AbilityTemplate.AbilityCosts(Cost)
		{
			ActionPointCost = X2AbilityCost_ActionPoints(Cost);
			if (ActionPointCost != none)
			{
				ActionPointCost.DoNotConsumeAllEffects.AddItem(DoNotConsumeAllEffectName);
				`Log("WOTC_APA_Class_Pack - Add DoNotConsumeAllActions EffectName: Add" @ DoNotConsumeAllEffectName @ "to the ActionPointCost.DoNotConsumeAllEffects for" @ AbilityName, bDebugLogging);
}	}	}	}


// Effect and Condition Functions:
// *******************************

static function AddFleetFootedRapidDeploymentGrenadeTypeCondition(name AbilityName, bool bDebugLogging)
{
	local X2AbilityTemplateManager				AbilityTemplateMgr;
	local array<X2AbilityTemplate>				AbilityTemplateArray;
	local X2AbilityTemplate						AbilityTemplate;

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties(AbilityName, AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		AbilityTemplate.AbilityShooterConditions.AddItem(new class'X2Condition_WOTC_APA_FleetFootedRapidDeploymentGrenadeType');
		`Log("WOTC_APA_Class_Pack - Add FleetFootedRapidDeploymentGrenadeType Condition to:" @ AbilityName, bDebugLogging);
	}
}


static function AddOverwatchConditions(name AbilityName, bool bDebugLogging)
{
	local X2AbilityTemplateManager							AbilityTemplateMgr;
	local array<X2AbilityTemplate>							AbilityTemplateArray;
	local X2AbilityTemplate									AbilityTemplate;
	local X2Condition_WOTC_APA_Class_RequiredChanceToHit	HitChanceCondition;
	local X2Condition_WOTC_APA_Class_OverwatchTargetLimit	TargetLimitCondition;

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties(AbilityName, AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		HitChanceCondition = new class'X2Condition_WOTC_APA_Class_RequiredChanceToHit';
		TargetLimitCondition = new class'X2Condition_WOTC_APA_Class_OverwatchTargetLimit';

		AbilityTemplate.AbilityTargetConditions.AddItem(HitChanceCondition);
		AbilityTemplate.AbilityTargetConditions.AddItem(TargetLimitCondition);
		`Log("WOTC_APA_Class_Pack - Add Hit Chance and Target Limit Conditions to:" @ AbilityName, bDebugLogging);
	}
}


static function AddArcthrowerEffects(name AbilityName, bool bDebugLogging)
{
	local X2AbilityTemplateManager							AbilityTemplateMgr;
	local array<X2AbilityTemplate>							AbilityTemplateArray;
	local X2AbilityTemplate									AbilityTemplate;
	
	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties(AbilityName, AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		AbilityTemplate.AddTargetEffect(CreateClenseMindControlledAllyEffect());
		AbilityTemplate.AddTargetEffect(CreateDisorientAfterStunEffect());
		`Log("WOTC_APA_Class_Pack - Add additional Arcthrower effects to:" @ AbilityName, bDebugLogging);
	}
}

// Mind Control Clense: Passive effect that removes mind control from stunned allies - Gets added to Arcthrower Stun abilities
static function X2Effect_WOTC_APA_ArcthrowerRemoveMindControl CreateClenseMindControlledAllyEffect()
{
	local X2Effect_WOTC_APA_ArcthrowerRemoveMindControl			ClenseEffect;
	local X2Condition_UnitProperty								ClenseCondition;
	local X2Condition_WOTC_APA_Class_EffectRequirement			EffectCondition;

	// Add the listener effect
	ClenseEffect = new class'X2Effect_WOTC_APA_ArcthrowerRemoveMindControl';
	ClenseEffect.BuildPersistentEffect(1, true, false);

	// Require the Target to be an ally
	ClenseCondition = new class'X2Condition_UnitProperty';
	ClenseCondition.ExcludeFriendlyToSource = true;
	ClenseCondition.TreatMindControlledSquadmateAsHostile = false;
	ClenseEffect.TargetConditions.AddItem(ClenseCondition);
	
	// Require the Source to have the effect name that grants this sub-effect of the Arcthrower stun
	EffectCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	EffectCondition.bCheckSourceUnit = true;
	EffectCondition.RequiredEffectNames.AddItem('Arcthrower_ClenseMindControlledAllyEffect');
	EffectCondition.LogEffectName = "Arcthrower_ClenseMindControlledAllyEffect";
	ClenseEffect.TargetConditions.AddItem(EffectCondition);

	return ClenseEffect;
}

// Disorient After Stun: Passive effect that applies a Disorient effect after stun wears off
static function X2Effect_WOTC_APA_ArcthrowerDisorientAfterStun CreateDisorientAfterStunEffect()
{
	local X2Effect_WOTC_APA_ArcthrowerDisorientAfterStun		DisorientEffect;
	local X2Condition_WOTC_APA_Class_EffectRequirement			EffectCondition;

	// Add the listener effect
	DisorientEffect = new class'X2Effect_WOTC_APA_ArcthrowerDisorientAfterStun';
	DisorientEffect.BuildPersistentEffect(1, true, false);
	DisorientEffect.SetDisplayInfo(ePerkBuff_Penalty, "Overcharged Capacitors", "Disorient Unit after Stun wears off", "img:///UILibrary_LWSecondariesWOTC.LW_AbilityChainLightning", true,,);
	
	// Require the Source to have the effect name that grants this sub-effect of the Arcthrower stun
	EffectCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	EffectCondition.bCheckSourceUnit = true;
	EffectCondition.RequiredEffectNames.AddItem('Arcthrower_DisorientAfterStunEffect');
	EffectCondition.LogEffectName = "Arcthrower_DisorientAfterStunEffect";
	DisorientEffect.TargetConditions.AddItem(EffectCondition);

	return DisorientEffect;
}


static function AddHackingVisibilityConditions(name AbilityName, bool bDebugLogging)
{
	local X2AbilityTemplateManager							AbilityTemplateMgr;
	local array<X2AbilityTemplate>							AbilityTemplateArray;
	local X2AbilityTemplate									AbilityTemplate;
	
	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties(AbilityName, AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		AbilityTemplate.AbilityTargetConditions.AddItem(new class'X2Condition_WOTC_APA_ExtendedProtocolVisibility');
		`Log("WOTC_APA_Class_Pack - Add squadsite visibility support and ability conditions to:" @ AbilityName, bDebugLogging);
	}
}


static function AddElectronicWarfareEffectToHaywire(bool bDebugLogging)
{
	local X2AbilityTemplateManager							AbilityTemplateMgr;
	local array<X2AbilityTemplate>							AbilityTemplateArray;
	local X2AbilityTemplate									AbilityTemplate;
	
	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties('HaywireProtocol', AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		AbilityTemplate.AddTargetEffect(CreateElectronicWarfareActionPointEffect());
		`Log("WOTC_APA_Class_Pack - Add Electronic Warfare's action point effect to: HaywireProtocol", bDebugLogging);
	}
}

// Reduce Actions After Hack: Effect that leaves enemy units with only one action when recovering from a control hack
static function X2Effect_WOTC_APA_ReduceActionsAfterHack CreateElectronicWarfareActionPointEffect()
{
	local X2Effect_WOTC_APA_ReduceActionsAfterHack				ActionPointEffect;
	local X2Condition_WOTC_APA_Class_EffectRequirement			EffectCondition;

	// Add the listener effect
	ActionPointEffect = new class'X2Effect_WOTC_APA_ReduceActionsAfterHack';
	ActionPointEffect.BuildPersistentEffect(1, true, false);
	ActionPointEffect.bRemoveWhenTargetDies = true;
	
	// Require the Source to have the effect name that grants this sub-effect
	EffectCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	EffectCondition.bCheckSourceUnit = true;
	EffectCondition.RequiredEffectNames.AddItem('WOTC_APA_ReduceActionsAfterHackEffect');
	EffectCondition.LogEffectName = "WOTC_APA_ReduceActionsAfterHackEffect";
	ActionPointEffect.TargetConditions.AddItem(EffectCondition);

	return ActionPointEffect;
}


// Set Full Override's cooldown also when Haywire Protocol is used
static function AddFullOverrideSharedCooldownToHaywire(bool bDebugLogging)
{
	local X2AbilityTemplateManager							AbilityTemplateMgr;
	local array<X2AbilityTemplate>							AbilityTemplateArray;
	local X2AbilityTemplate									AbilityTemplate;
	
	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties('FinalizeHaywire', AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		AbilityTemplate.AddShooterEffect(new class'X2Effect_WOTC_APA_SetFullOverrideCooldown');
		`Log("WOTC_APA_Class_Pack - Add shared cooldown for Full Override to HaywireProtocol", bDebugLogging);
	}
}


// Add the hack rewards for Full Override to all Robotic, non-soldier character templates
static function AddFullOverrideToRoboticCharacterTemplates(bool bDebugLogging)
{
	local X2CharacterTemplateManager	CharacterTemplateManager;
    local X2CharacterTemplate			CharTemplate;
    local array<X2DataTemplate>			DataTemplates;
    local X2DataTemplate				Template, DiffTemplate;

    CharacterTemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

    foreach CharacterTemplateManager.IterateTemplates(Template, None)
    {
		CharacterTemplateManager.FindDataTemplateAllDifficulties(Template.DataName, DataTemplates);
		foreach DataTemplates(DiffTemplate)
		{
			CharTemplate = X2CharacterTemplate(DiffTemplate);
			if (CharTemplate.bIsRobotic && !CharTemplate.bIsSoldier)
			{
				`Log("WOTC_APA_Class_Pack - Add Full Override hack templates to:" @ CharTemplate.Name, bDebugLogging);
				CharTemplate.HackRewards.AddItem('BuffEnemy_WOTC_APA_FullOverride');
				CharTemplate.HackRewards.AddItem('SelfDestruct_WOTC_APA_FullOverride');
				CharTemplate.HackRewards.AddItem('ControlRobot_WOTC_APA_FullOverride');
}	}	}	}



// Item and Ability Functions:
// ***************************

static function SetAbilityToCrossClassTrue(name AbilityName, bool bDebugLogging)
{
	local X2AbilityTemplateManager				AbilityTemplateMgr;
	local array<X2AbilityTemplate>				AbilityTemplateArray;
	local X2AbilityTemplate						AbilityTemplate;

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties(AbilityName, AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		AbilityTemplate.bCrossClassEligible = true;
		`Log("WOTC_APA_Class_Pack - bCrossClassEligible enabled for" @ AbilityName, bDebugLogging);
}	}


static function AddAbilityOverride(name AbilityName, name OverrideAbility, bool bDebugLogging)
{
	local X2AbilityTemplateManager				AbilityTemplateMgr;
	local array<X2AbilityTemplate>				AbilityTemplateArray;
	local X2AbilityTemplate						AbilityTemplate;

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties(AbilityName, AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		AbilityTemplate.OverrideAbilities.AddItem(OverrideAbility);
}	}


static function UpdateAbilityShotHUDPriority(name AbilityName, int ShotHUDPriority, bool bDebugLogging)
{
	local X2AbilityTemplateManager				AbilityTemplateMgr;
	local array<X2AbilityTemplate>				AbilityTemplateArray;
	local X2AbilityTemplate						AbilityTemplate;

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties(AbilityName, AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		AbilityTemplate.ShotHUDPriority = ShotHUDPriority;
		`Log("WOTC_APA_Class_Pack - ShotHUDPriority changed for" @ AbilityName @ "to:" @ ShotHUDPriority, bDebugLogging);
}	}


static function UpdateDemolitionHitCalc()
{
	local X2AbilityTemplateManager				AbilityTemplateMgr;
	local array<X2AbilityTemplate>				AbilityTemplateArray;
	local X2AbilityTemplate						AbilityTemplate;

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties('Demolition', AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		AbilityTemplate.AbilityToHitCalc = new class'X2AbilityToHitCalc_DeadEye';
}	}


static function UpdateSniperRifleOverwatchBehavior(bool bDebugLogging)
{
	local X2AbilityTemplateManager				AbilityTemplateMgr;
	local array<X2AbilityTemplate>				AbilityTemplateArray;
	local X2AbilityTemplate						AbilityTemplate;
	local X2AbilityCost_ActionPoints			ActionPointCost;
    local X2AbilityCost							AbilityCost;
	local int									i;

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties('SniperRifleOverwatch', AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		//AbilityTemplate.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
		AbilityTemplate.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideIfOtherAvailable;
		AbilityTemplate.HideIfAvailable.AddItem('LongWatch');

		for (i = 0; i < AbilityTemplate.AbilityCosts.Length; i++)
		{
			AbilityCost = AbilityTemplate.AbilityCosts[i];
			if (AbilityCost != none && class'XMBDownloadableContentInfo_XModBase'.static.UpdateAbilityCost(AbilityCost))
			{
				AbilityTemplate.AbilityCosts[i] = AbilityCost;
}	}	}	}

static function UpdatePistolOverwatchBehavior(bool bDebugLogging)
{
	local X2AbilityTemplateManager				AbilityTemplateMgr;
	local array<X2AbilityTemplate>				AbilityTemplateArray;
	local X2AbilityTemplate						AbilityTemplate;
	local X2AbilityCost_ActionPoints			ActionPointCost;
    local X2AbilityCost							AbilityCost;
	local int									i;

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties('PistolOverwatch', AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		for (i = 0; i < AbilityTemplate.AbilityCosts.Length; i++)
		{
			AbilityCost = AbilityTemplate.AbilityCosts[i];
			if (AbilityCost != none && class'XMBDownloadableContentInfo_XModBase'.static.UpdateAbilityCost(AbilityCost))
			{
				AbilityTemplate.AbilityCosts[i] = AbilityCost;
}	}	}	}


static function UpdateStartingXPACKWeaponTemplates(bool bDebugLogging)
{
	local X2ItemTemplateManager					ItemTemplateManager;
	local X2WeaponTemplate						WeaponTemplate;
	local X2SchematicTemplate					SchematicTemplate;
	local array<X2DataTemplate>					SchematicTemplates;
	local X2DataTemplate						DataTemplate;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	// Update Bullpup Items
	WeaponTemplate = X2WeaponTemplate(ItemTemplateManager.FindItemTemplate('Bullpup_CV'));
	WeaponTemplate.StartingItem = true;
	`Log("WOTC_APA_Class_Pack - Make Bullpups a starting item", bDebugLogging);

	ItemTemplateManager.FindDataTemplateAllDifficulties('Bullpup_MG_Schematic', SchematicTemplates);
	foreach SchematicTemplates(DataTemplate)
	{
		SchematicTemplate = X2SchematicTemplate(DataTemplate);
		if (SchematicTemplate != none)
		{
			SchematicTemplate.Requirements.RequiredSoldierClass = '';
	}	}

	ItemTemplateManager.FindDataTemplateAllDifficulties('Bullpup_BM_Schematic', SchematicTemplates);
	foreach SchematicTemplates(DataTemplate)
	{
		SchematicTemplate = X2SchematicTemplate(DataTemplate);
		if (SchematicTemplate != none)
		{
			SchematicTemplate.Requirements.RequiredSoldierClass = '';
	}	}

	// Update Vektor Rifle Items
	WeaponTemplate = X2WeaponTemplate(ItemTemplateManager.FindItemTemplate('VektorRifle_CV'));
	WeaponTemplate.StartingItem = true;
	WeaponTemplate.iTypicalActionCost = 1;
	`Log("WOTC_APA_Class_Pack - Make Vektor Rifles a starting item and fix T1 iTypicalActionCost value", bDebugLogging);
	
	ItemTemplateManager.FindDataTemplateAllDifficulties('VektorRifle_MG_Schematic', SchematicTemplates);
	foreach SchematicTemplates(DataTemplate)
	{
		SchematicTemplate = X2SchematicTemplate(DataTemplate);
		if (SchematicTemplate != none)
		{
			SchematicTemplate.Requirements.RequiredSoldierClass = '';
	}	}

	ItemTemplateManager.FindDataTemplateAllDifficulties('VektorRifle_BM_Schematic', SchematicTemplates);
	foreach SchematicTemplates(DataTemplate)
	{
		SchematicTemplate = X2SchematicTemplate(DataTemplate);
		if (SchematicTemplate != none)
		{
			SchematicTemplate.Requirements.RequiredSoldierClass = '';
	}	}
}


static function UpdateWeaponTemplatesForBurstFire(bool bDebugLogging)
{
	local X2ItemTemplateManager					ItemTemplateManager;
	local array<name>							TemplateNames;
	local array<X2DataTemplate>					DifficultyVariants;
	local name									TemplateName;
	local X2DataTemplate						ItemTemplate;
	local X2WeaponTemplate						WeaponTemplate;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplateManager.GetTemplateNames(TemplateNames);

	`Log("WOTC_APA_Class_Pack - Set AutoFire Animset to be used with the Burst Fire ability for Rifles/Bullpups.", bDebugLogging);

	foreach TemplateNames(TemplateName)
	{
		ItemTemplateManager.FindDataTemplateAllDifficulties(TemplateName, DifficultyVariants);
		// Iterate over all variants
		
		foreach DifficultyVariants(ItemTemplate)
		{
			WeaponTemplate = X2WeaponTemplate(ItemTemplate);
			if (WeaponTemplate != none)
			{
				if (WeaponTemplate.WeaponCat == 'rifle' || WeaponTemplate.WeaponCat == 'bullpup')
				{
					if (InStr(string(WeaponTemplate.DataName), "CV") != INDEX_NONE)
						WeaponTemplate.SetAnimationNameForAbility('WOTC_APA_BurstFire', 'FF_AutoFireConvA');
					if (InStr(string(WeaponTemplate.DataName), "MG") != INDEX_NONE)
						WeaponTemplate.SetAnimationNameForAbility('WOTC_APA_BurstFire', 'FF_AutoFireMagA');
					if (InStr(string(WeaponTemplate.DataName), "BM") != INDEX_NONE)
						WeaponTemplate.SetAnimationNameForAbility('WOTC_APA_BurstFire', 'FF_AutoFireBeamA');
}	}	}	}	}


static function AddAbilityToItemCategory(name AbilityName, name WeaponCategory, bool bDebugLogging)
{
	local X2ItemTemplateManager					ItemTemplateManager;
	local X2DataTemplate						ItemTemplate;
	local X2WeaponTemplate						WeaponTemplate;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	`Log("WOTC_APA_Class_Pack - Add Ability to Weapon Category: Add" @ AbilityName @ "to all items with a weapon category of" @ WeaponCategory, bDebugLogging);

	foreach ItemTemplateManager.IterateTemplates(ItemTemplate, None)
    {
		WeaponTemplate = X2WeaponTemplate(ItemTemplate);
		if (WeaponTemplate != none && WeaponTemplate.WeaponCat == WeaponCategory)
		{
			WeaponTemplate.Abilities.AddItem(AbilityName);
}	}	}


static function SetAbilityToUniqueForSource(name AbilityName, bool bDebugLogging)
{
	local X2AbilityTemplateManager				AbilityTemplateMgr;
	local array<X2AbilityTemplate>				AbilityTemplateArray;
	local X2AbilityTemplate						AbilityTemplate;

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties(AbilityName, AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		AbilityTemplate.bUniqueSource = true;
		`Log("WOTC_APA_Class_Pack - Set Ability to Unique for Source: Set bUniqueSource = true for" @ AbilityName, bDebugLogging);
}	}


static function AddAbilityBonusRadius(name AbilityName, name BonusAbility, float BonusAmount, bool bDebugLogging)
{
	local X2AbilityTemplateManager				AbilityTemplateMgr;
	local array<X2AbilityTemplate>				AbilityTemplateArray;
	local X2AbilityTemplate						AbilityTemplate;

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties(AbilityName, AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		X2AbilityMultiTarget_Radius(AbilityTemplate.AbilityMultiTargetStyle).AddAbilityBonusRadius(BonusAbility, BonusAmount);
}	}


static function AddDisorientToConcussionGrenadeTemplates(name ItemName, bool bDebugLogging)
{
	local X2ItemTemplateManager					ItemTemplateManager;
	local X2GrenadeTemplate						GrenadeTemplate;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	GrenadeTemplate = X2GrenadeTemplate(ItemTemplateManager.FindItemTemplate(ItemName));
	if (GrenadeTemplate != none)
	{
		GrenadeTemplate.ThrownGrenadeEffects.AddItem(CreateConcussionGrenadeDisorientEffect());
		GrenadeTemplate.LaunchedGrenadeEffects.AddItem(CreateConcussionGrenadeDisorientEffect());
		`Log("WOTC_APA_Class_Pack - Add a disorient effect to" @ GrenadeTemplate.GetItemFriendlyName() @ "when the source has the WOTC_APA_ConcussionGrenades ability", bDebugLogging);
}	}

// Concussion Grenade Disorient: Adds a disorient effect to grenade explosions when the source has the Concussion Grenade ability
static function X2Effect_Persistent CreateConcussionGrenadeDisorientEffect()
{
	local X2Effect_Persistent               					DisorientEffect;
	local X2Condition_WOTC_APA_Class_EffectRequirement			EffectCondition;
	local X2Condition_UnitProperty								TargetProperty;

	// Add the stun effect
	DisorientEffect = class'X2StatusEffects'.static.CreateDisorientedStatusEffect(, , false);
	
	// Require the Source to have the Concussion Grenade effect
	EffectCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	EffectCondition.RequiredEffectNames.AddItem('WOTC_APA_ConcussionGrenadesEffect');
	EffectCondition.LogEffectName = "WOTC_APA_ConcussionGrenades_DisorientEffect";
	EffectCondition.bCheckSourceUnit = true;
	DisorientEffect.TargetConditions.AddItem(EffectCondition);

	// Exclude/Include allies per config
	TargetProperty = new class'X2Condition_UnitProperty';
	TargetProperty.ExcludeDead = true;
	TargetProperty.ExcludeHostileToSource = false;
	TargetProperty.ExcludeFriendlyToSource = !default.CONCUSSION_GRENADES_DISORIENT_ALLIES;
	DisorientEffect.TargetConditions.AddItem(TargetProperty);

	return DisorientEffect;
}


static function AddStunToChemicalWarfareGrenadeTemplates(name ItemName, bool bDebugLogging)
{
	local X2ItemTemplateManager					ItemTemplateManager;
	local X2GrenadeTemplate						GrenadeTemplate;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	GrenadeTemplate = X2GrenadeTemplate(ItemTemplateManager.FindItemTemplate(ItemName));
	if (GrenadeTemplate != none)
	{
		GrenadeTemplate.ThrownGrenadeEffects.AddItem(CreateChemicalWarfareStunEffect());
		//GrenadeTemplate.ThrownGrenadeEffects.AddItem(CreateDelayedChemicalWarfareStunEffect());
		GrenadeTemplate.LaunchedGrenadeEffects.AddItem(CreateChemicalWarfareStunEffect());
		//GrenadeTemplate.LaunchedGrenadeEffects.AddItem(CreateDelayedChemicalWarfareStunEffect());
		`Log("WOTC_APA_Class_Pack - Add 1-action stun effect to" @ GrenadeTemplate.GetItemFriendlyName() @ "when the source has the WOTC_APA_ChemicalWarfare ability", bDebugLogging);
}	}

// Chemical Warfare Stun: Adds a 1-action stun effect to gas grenade explosions when the source has the Chemical Warfare ability
static function X2Effect_Persistent CreateChemicalWarfareStunEffect()
{
	local X2Effect_Persistent									StunEffect;
	local X2Condition_WOTC_APA_Class_AbilityRequirement			AbilityCondition;
	local X2Condition_UnitImmunities							ImmunityCondition;
	local X2Condition_WOTC_APA_TargetUnactivated				AlertCondition;

	// Add the stun effect
	StunEffect = class'X2StatusEffects'.static.CreateStunnedStatusEffect(1, 100, false);
	StunEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	
	// Require the Source to have the Chemical Warfare ability
	AbilityCondition = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
	AbilityCondition.RequiredAbilityNames.AddItem('WOTC_APA_ChemicalWarfare');
	AbilityCondition.LogEffectName = "WOTC_APA_ChemicalWarfare_StunEffect";
	AbilityCondition.bCheckSourceUnit = true;
	StunEffect.TargetConditions.AddItem(AbilityCondition);

	// Exclude targets immune to poison
	ImmunityCondition = new class'X2Condition_UnitImmunities';
	ImmunityCondition.AddExcludeDamageType('Poison');
	StunEffect.TargetConditions.AddItem(ImmunityCondition);

	// Exclude targets that are unactivated (They will be effected by a delayed stun that will trigger after scamper)
	AlertCondition = new class'X2Condition_WOTC_APA_TargetUnactivated';
	//StunEffect.TargetConditions.AddItem(AlertCondition);

	return StunEffect;
}

// Chemical Warfare Delayed Stun: Adds an effect that triggers a 1-action stun after scamper to gas grenade explosions when the source has the Chemical Warfare ability
static function X2Effect_WOTC_APA_ChemicalWarfare CreateDelayedChemicalWarfareStunEffect()
{
	local X2Effect_WOTC_APA_ChemicalWarfare						StunEffect;
	local X2Condition_WOTC_APA_Class_AbilityRequirement			AbilityCondition;
	local X2Condition_UnitImmunities							ImmunityCondition;

	// Add the delayed stun effect that will trigger after scamper
	StunEffect = new class'X2Effect_WOTC_APA_ChemicalWarfare';
	StunEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	
	// Require the Source to have the Chemical Warfare ability
	AbilityCondition = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
	AbilityCondition.RequiredAbilityNames.AddItem('WOTC_APA_ChemicalWarfare');
	AbilityCondition.LogEffectName = "WOTC_APA_ChemicalWarfare_StunEffect";
	AbilityCondition.bCheckSourceUnit = true;
	StunEffect.TargetConditions.AddItem(AbilityCondition);

	// Exclude targets immune to poison
	ImmunityCondition = new class'X2Condition_UnitImmunities';
	ImmunityCondition.AddExcludeDamageType('Poison');
	StunEffect.TargetConditions.AddItem(ImmunityCondition);

	return StunEffect;
}


static function AddScatterPanicToBurnOutGrenadeTemplates(name ItemName, bool bDebugLogging)
{
	local X2ItemTemplateManager					ItemTemplateManager;
	local X2GrenadeTemplate						GrenadeTemplate;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	GrenadeTemplate = X2GrenadeTemplate(ItemTemplateManager.FindItemTemplate(ItemName));
	if (GrenadeTemplate != none)
	{
		GrenadeTemplate.ThrownGrenadeEffects.AddItem(CreateBurnOutPanicEffect());
		GrenadeTemplate.ThrownGrenadeEffects.AddItem(CreateBurnOutScatterEffect());
		GrenadeTemplate.LaunchedGrenadeEffects.AddItem(CreateBurnOutPanicEffect());
		GrenadeTemplate.LaunchedGrenadeEffects.AddItem(CreateBurnOutScatterEffect());
		`Log("WOTC_APA_Class_Pack - Add chance to scatter or panic to" @ GrenadeTemplate.GetItemFriendlyName() @ "when the source has the WOTC_APA_BurnOut ability", bDebugLogging);
}	}

// Burn Out Panic: Adds a chance to fire grenade explosions to Panic the target when the source has the Burn Out ability
static function X2Effect_Panicked CreateBurnOutPanicEffect()
{
	local X2Effect_Panicked										PanickedEffect;
	local X2Condition_WOTC_APA_Class_AbilityRequirement			AbilityCondition;
	local X2Condition_UnitImmunities							ImmunityCondition;

	// Add the stun effect
	PanickedEffect = class'X2StatusEffects'.static.CreatePanickedStatusEffect();
	PanickedEffect.ApplyChance = class'X2Ability_WOTC_APA_SapperAbilitySet'.default.BURN_OUT_PANIC_CHANCE;
	
	// Require the Source to have the Burn Out ability
	AbilityCondition = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
	AbilityCondition.RequiredAbilityNames.AddItem('WOTC_APA_BurnOut');
	AbilityCondition.LogEffectName = "WOTC_APA_BurnOut_ScatterEffect";
	AbilityCondition.bCheckSourceUnit = true;
	PanickedEffect.TargetConditions.AddItem(AbilityCondition);

	// Exclude targets immune to poison
	ImmunityCondition = new class'X2Condition_UnitImmunities';
	ImmunityCondition.AddExcludeDamageType('Fire');
	PanickedEffect.TargetConditions.AddItem(ImmunityCondition);

	return PanickedEffect;
}

// Burn Out Scatter: Adds a chance to fire grenade explosions to scatter the target when the source has the Burn Out ability
static function X2Effect_WOTC_APA_Class_Fallback CreateBurnOutScatterEffect()
{
	local X2Effect_WOTC_APA_Class_Fallback						ScatterEffect;
	local X2Condition_UnitProperty								PanicCondition;
	local X2Condition_WOTC_APA_Class_AbilityRequirement			AbilityCondition;
	local X2Condition_UnitImmunities							ImmunityCondition;

	// Add the scatter effect
	ScatterEffect = new class'X2Effect_WOTC_APA_Class_Fallback';
	ScatterEffect.ChanceToApply = class'X2Ability_WOTC_APA_SapperAbilitySet'.default.BURN_OUT_SCATTER_CHANCE;
	
	// Only apply if the Panic effect didnt get applied
	PanicCondition = new class'X2Condition_UnitProperty';
	PanicCondition.ExcludePanicked = true;
	ScatterEffect.TargetConditions.AddItem(PanicCondition);

	// Require the Source to have the BurN Out ability
	AbilityCondition = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
	AbilityCondition.RequiredAbilityNames.AddItem('WOTC_APA_BurnOut');
	AbilityCondition.LogEffectName = "WOTC_APA_BurnOut_ScatterEffect";
	AbilityCondition.bCheckSourceUnit = true;
	ScatterEffect.TargetConditions.AddItem(AbilityCondition);

	// Exclude targets immune to poison
	ImmunityCondition = new class'X2Condition_UnitImmunities';
	ImmunityCondition.AddExcludeDamageType('Fire');
	ScatterEffect.TargetConditions.AddItem(ImmunityCondition);

	return ScatterEffect;
}


static function AddRuptureToAcidGrenadeTemplates(name ItemName, bool bDebugLogging)
{
	local X2ItemTemplateManager					ItemTemplateManager;
	local X2GrenadeTemplate						GrenadeTemplate;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	GrenadeTemplate = X2GrenadeTemplate(ItemTemplateManager.FindItemTemplate(ItemName));
	if (GrenadeTemplate != none)
	{
		//GrenadeTemplate.ThrownGrenadeEffects.AddItem(CreateCorrosiveOrganicRuptureEffect());
		GrenadeTemplate.ThrownGrenadeEffects.AddItem(CreateCorrosiveMechanicalRuptureEffect());
		//GrenadeTemplate.LaunchedGrenadeEffects.AddItem(CreateCorrosiveOrganicRuptureEffect());
		GrenadeTemplate.LaunchedGrenadeEffects.AddItem(CreateCorrosiveMechanicalRuptureEffect());
		`Log("WOTC_APA_Class_Pack - Add a rupture effect to" @ GrenadeTemplate.GetItemFriendlyName() @ "when the source has the WOTC_APA_ConcentratedCorrosives ability", bDebugLogging);
}	}

// Concentrated Corrosives Rupture: Adds a rupture effect to organic targets hit by acid grenade explosions when the source has the Concentrated Corrosives ability
static function X2Effect_ApplyWeaponDamage CreateCorrosiveOrganicRuptureEffect()
{
	local X2Effect_ApplyWeaponDamage							WeaponDamageEffect;
	local X2Condition_WOTC_APA_Class_AbilityRequirement			AbilityCondition;
	local X2Condition_UnitProperty								TargetProperty;
	local X2Condition_UnitImmunities							ImmunityCondition;

	// Add the Rupture effect
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bIgnoreBaseDamage = true;
	WeaponDamageEffect.EffectDamageValue.Rupture = class'X2Ability_WOTC_APA_SapperAbilitySet'.default.CONCENTRATED_CORROSIVES_ORGANIC_RUPTURE;
	
	// Require the Source to have the Concentrated Corrosives ability
	AbilityCondition = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
	AbilityCondition.RequiredAbilityNames.AddItem('WOTC_APA_ConcentratedCorrosives');
	AbilityCondition.LogEffectName = "WOTC_APA_ConcentratedCorrosives_OrganicRuptureEffect";
	AbilityCondition.bCheckSourceUnit = true;
	WeaponDamageEffect.TargetConditions.AddItem(AbilityCondition);

	// Exclude/Include allies per config
	TargetProperty = new class'X2Condition_UnitProperty';
	TargetProperty.ExcludeDead = true;
	TargetProperty.ExcludeHostileToSource = false;
	TargetProperty.ExcludeOrganic = false;
	TargetProperty.ExcludeRobotic = true;
	WeaponDamageEffect.TargetConditions.AddItem(TargetProperty);

	// Exclude targets immune to acid
	ImmunityCondition = new class'X2Condition_UnitImmunities';
	ImmunityCondition.AddExcludeDamageType('Acid');
	WeaponDamageEffect.TargetConditions.AddItem(ImmunityCondition);
	
	return WeaponDamageEffect;
}

// Concentrated Corrosives Rupture: Adds a rupture effect to mechanical targets hit by acid grenade explosions when the source has the Concentrated Corrosives ability
static function X2Effect_ApplyWeaponDamage CreateCorrosiveMechanicalRuptureEffect()
{
	local X2Effect_ApplyWeaponDamage							WeaponDamageEffect;
	local X2Condition_WOTC_APA_Class_AbilityRequirement			AbilityCondition;
	local X2Condition_UnitProperty								TargetProperty;
	local X2Condition_UnitImmunities							ImmunityCondition;

	// Add the Rupture effect
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bIgnoreBaseDamage = true;
	WeaponDamageEffect.EffectDamageValue.Rupture = class'X2Ability_WOTC_APA_SapperAbilitySet'.default.CONCENTRATED_CORROSIVES_MECHANICAL_RUPTURE;
	
	// Require the Source to have the Concentrated Corrosives ability
	AbilityCondition = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
	AbilityCondition.RequiredAbilityNames.AddItem('WOTC_APA_ConcentratedCorrosives');
	AbilityCondition.LogEffectName = "WOTC_APA_ConcentratedCorrosives_MechanicalRuptureEffect";
	AbilityCondition.bCheckSourceUnit = true;
	WeaponDamageEffect.TargetConditions.AddItem(AbilityCondition);

	// Exclude/Include allies per config
	TargetProperty = new class'X2Condition_UnitProperty';
	TargetProperty.ExcludeDead = true;
	TargetProperty.ExcludeHostileToSource = false;
	TargetProperty.ExcludeOrganic = true;
	TargetProperty.ExcludeRobotic = false;
	WeaponDamageEffect.TargetConditions.AddItem(TargetProperty);

	// Exclude targets immune to acid
	ImmunityCondition = new class'X2Condition_UnitImmunities';
	ImmunityCondition.AddExcludeDamageType('Acid');
	WeaponDamageEffect.TargetConditions.AddItem(ImmunityCondition);

	return WeaponDamageEffect;
}

static function AddUpgradedBattleScannersEffect(bool bDebugLogging)
{
	local X2AbilityTemplateManager							AbilityTemplateMgr;
	local array<X2AbilityTemplate>							AbilityTemplateArray;
	local X2AbilityTemplate									AbilityTemplate, UpgradeTemplate;
	
	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	UpgradeTemplate = AbilityTemplateMgr.FindAbilityTemplate('WOTC_APA_UpgradedScanners');
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties('BattleScanner', AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		AbilityTemplate.AddMultiTargetEffect(CreateUpgradedBattleScannersEffect(UpgradeTemplate));
		`Log("WOTC_APA_Class_Pack - Add additional effects to Battlescanners for the Upgraded Scanners ability", bDebugLogging);
	}
}

static function X2Effect_WOTC_APA_UpgradedScanners CreateUpgradedBattleScannersEffect(X2AbilityTemplate UpgradeTemplate)
{
	local X2Effect_WOTC_APA_UpgradedScanners				StatEffect;
	local X2Condition_WOTC_APA_Class_EffectRequirement		EffectCondition;
	local X2Condition_UnitProperty							EnemyCondition;

	// Add the hit/crit modifier effect
	StatEffect = new class'X2Effect_WOTC_APA_UpgradedScanners';
	StatEffect.HitMod = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.UPGRADED_SCANNERS_AIM_BONUS;
	StatEffect.CritMod = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.UPGRADED_SCANNERS_CRIT_BONUS;
	StatEffect.BuildPersistentEffect(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.UPGRADED_SCANNERS_DURATION, false, false);
	StatEffect.SetDisplayInfo(ePerkBuff_Penalty, UpgradeTemplate.LocFriendlyName, UpgradeTemplate.GetMyHelpText(), UpgradeTemplate.IconImage);
	StatEffect.EffectName = 'WOTC_APA_UpgradedScannerEffect';

	// Require the Source to have the effect name that grants this sub-effect
	EffectCondition = new class'X2Condition_WOTC_APA_Class_EffectRequirement';
	EffectCondition.bCheckSourceUnit = true;
	EffectCondition.RequiredEffectNames.AddItem('WOTC_APA_UpgradedScanners');
	EffectCondition.LogEffectName = "WOTC_APA_UpgradedScanners";

	// Require the target to be a living enemy
	EnemyCondition = new class'X2Condition_UnitProperty';
	EnemyCondition.ExcludeAlive=false;
	EnemyCondition.ExcludeDead=true;
	EnemyCondition.ExcludeFriendlyToSource=true;
	EnemyCondition.ExcludeHostileToSource=false;
	EnemyCondition.TreatMindControlledSquadmateAsHostile=false;
	EnemyCondition.FailOnNonUnits=true;

	StatEffect.TargetConditions.AddItem(EnemyCondition);
	StatEffect.TargetConditions.AddItem(EffectCondition);

	return StatEffect;
}


static function UpdateProximityMineDetonationVisualization(bool bDebugLogging)
{
	local X2AbilityTemplateManager							AbilityTemplateMgr;
	local array<X2AbilityTemplate>							AbilityTemplateArray;
	local X2AbilityTemplate									AbilityTemplate;

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties('ProximityMineDetonation', AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{
		AbilityTemplate.BuildVisualizationFn = class'X2Ability_WOTC_APA_SapperAbilitySet'.static.UpdatedProximityMineDetonation_BuildVisualization;
	}
}