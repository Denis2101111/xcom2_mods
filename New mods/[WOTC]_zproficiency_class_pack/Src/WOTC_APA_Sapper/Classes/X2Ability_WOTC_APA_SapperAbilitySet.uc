
class X2Ability_WOTC_APA_SapperAbilitySet extends X2Ability_WOTC_APA_Utilities config(WOTC_APA_SapperSkills);

// Explosive Ordnance Proficiency Level Variables
var config int				EXPLOSIVE_ORDNANCE_BONUS_ENVIRONMENT_DAMAGE;

var config int				EXPLOSIVE_ORDNANCE_EXPLOSIVE_CRIT_CHANCE;
var config int				EXPLOSIVE_ORDNANCE_EXPLOSIVE_CRIT_DAMAGE;

var config int				EXPLOSIVE_ORDNANCE_BONUS_GRENADE_POCKET_CHARGE_2;
var config int				EXPLOSIVE_ORDNANCE_BONUS_GRENADE_POCKET_CHARGE_3;

var config int				EXPLOSIVE_ORDNANCE_STANDARD_EXPLOSIVE_ENVIRONMENT_DAMAGE;
var config int				EXPLOSIVE_ORDNANCE_STANDARD_EXPLOSIVE_BASE_DAMAGE;
var config int				EXPLOSIVE_ORDNANCE_STANDARD_EXPLOSIVE_CRIT_DAMAGE;

var config ARRAY<NAME>		EXPLOSIVE_ORDNANCE_STANDARD_GRENADE_TYPES;
var config ARRAY<NAME>		EXPLOSIVE_ORDNANCE_EXCLUDED_BONUS_GRENADE_TYPES;

var localized string		strExplosiveOrdnance1Name;
var localized string		strExplosiveOrdnance1Desc;
var localized string		strExplosiveOrdnance2Name;
var localized string		strExplosiveOrdnance2Desc;
var localized string		strExplosiveOrdnance3Name;
var localized string		strExplosiveOrdnance3Desc;


var config int				DEFENSIVE_MINE_CHARGES;
var config int				SKIRMISHER_MOBILITY_BONUS;
var config float			SKIRMISHER_CHANCE_PER_TILE;
var config int				SKIRMISHER_CHANCE_TILE_CAP;
var config int				ENTRENCHED_DAMAGE_REDUCTION;
var config int				RETURN_FIRE_ACTIVATIONS_PER_TURN;
var config float			AIRBURST_GRENADES_BONUS_RADIUS;
var config int				CHARGE_COOLDOWN;
var config int				CONCENTRATED_CORROSIVES_ORGANIC_RUPTURE;
var config int				CONCENTRATED_CORROSIVES_MECHANICAL_RUPTURE;
var config int				BURN_OUT_PANIC_CHANCE;
var config int				BURN_OUT_SCATTER_CHANCE;
var config int				HOLD_POSITION_COOLDOWN;

var config int				HEAT_WARHEADS_ARMOR_PIERCE;
var config int				HEAT_WARHEADS_ARMOR_SHRED;
var config int				MINEFIELD_BONUS_MINE_CHARGES;
var config int				REFLEX_ACTIVATIONS_PER_TURN;
var config int				EXPLOSIVE_ACTION_ACTIONS_LOSE;
var config int				EXPLOSIVE_ACTION_COOLDOWN;
var config int				REMOTE_START_COOLDOWN;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	/**/`Log("WOTC_APA_Sapper - Begin Adding Templates");

	Templates.AddItem(WOTC_APA_ExplosiveOrdnance());
	/*»»»*/	Templates.AddItem(WOTC_APA_ExplosiveOrdnanceRocketAccuracy1());
	/*»»»*/	Templates.AddItem(WOTC_APA_ExplosiveOrdnanceRocketAccuracy2());
	// Launch Grenade (Base Game)
	Templates.AddItem(WOTC_APA_DefensiveMine());
	/*»»»*/	Templates.AddItem(WOTC_APA_DefensiveMineAWC());
	/*»»»*/	Templates.AddItem(WOTC_APA_DefensiveMineDeploy());

	// Blast Padding (Base Game)
	Templates.AddItem(WOTC_APA_Skirmisher());
	/*»»»*/	Templates.AddItem(WOTC_APA_SkirmisherGraze());
	Templates.AddItem(WOTC_APA_Entrenched());

	// Demolition (Base Game)
	Templates.AddItem(WOTC_APA_ReturnFire());
	// WOTC_APA_FireSupport

	Templates.AddItem(WOTC_APA_AirburstGrenades());
	// Salvo (Base Game)
	Templates.AddItem(WOTC_APA_ConcussionGrenadesSapper());

	Templates.AddItem(WOTC_APA_Charge());
	// WOTC_APA_Reposition
	// WOTC_APA_RapidDeployment

	Templates.AddItem(WOTC_APA_ConcentratedCorrosives());
	Templates.AddItem(WOTC_APA_BurnOut());
	Templates.AddItem(WOTC_APA_ChemicalWarfare());
	/*»»»*/	Templates.AddItem(WOTC_APA_ChemicalWarfareDelayedStun());

	Templates.AddItem(WOTC_APA_DestructiveNature());
	// Shedder or Ever Vigilant (Base Game)
	Templates.AddItem(WOTC_APA_HoldPosition());
	/*»»»*/	Templates.AddItem(WOTC_APA_HoldPositionShot());
	/*»»»*/	Templates.AddItem(WOTC_APA_HoldPositionShotCF());

	Templates.AddItem(WOTC_APA_HEATGrenades());
	Templates.AddItem(WOTC_APA_Unbreakable());
	Templates.AddItem(WOTC_APA_Minefield());
	Templates.AddItem(WOTC_APA_Reflex());
	Templates.AddItem(WOTC_APA_HeavyHardpoints());
	Templates.AddItem(WOTC_APA_ExplosiveAction());
	Templates.AddItem(WOTC_APA_RemoteStart());
	Templates.AddItem(WOTC_APA_BombBelts());
	Templates.AddItem(WOTC_APA_SupportGrenadier());

	/**/`Log("WOTC_APA_Sapper - Finished Adding Templates");

	return Templates;
}


// Explosive Ordnance - Base Class Proficiency Ability
static function X2AbilityTemplate WOTC_APA_ExplosiveOrdnance()
{
	
	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_Class_TargetRankRequirement		RankCondition1, RankCondition2, RankCondition2AndUp, RankCondition3;
	local X2Effect_Persistent									EnvironmentalDamage1, EnvironmentalDamage3;
	local X2Effect_WOTC_APA_GrenadeCriticals					CritDamageEffect;
	local X2Effect_WOTC_APA_Class_BonusDamage					StandardDamageEffect;
	local X2Effect_Persistent									IconEffect1, IconEffect2;
	local X2Effect_WOTC_APA_Class_AddAbilitiesToTarget			RocketAccuracyEffect1, RocketAccuracyEffect2;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_ExplosiveOrdnance');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_ExplosiveOrdnance"; 
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
	RankCondition1.LogEffectName = "Explosive Ordnance 1";	// EffectName to use in logs
	RankCondition1.ExcludeProject = 'WOTC_APA_SapperUnlock1';
	
	RankCondition2 = new class 'X2Condition_WOTC_APA_Class_TargetRankRequirement';
	RankCondition2.iMinRank = 3;
	RankCondition2.iMaxRank = 5;
	RankCondition2.LogEffectName = "Explosive Ordnance 2";
	RankCondition2.ExcludeProject = 'WOTC_APA_SapperUnlock2';
	RankCondition2.GiveProject = 'WOTC_APA_SapperUnlock1';

	RankCondition2AndUp = new class 'X2Condition_WOTC_APA_Class_TargetRankRequirement';
	RankCondition2AndUp.iMinRank = 3;
	RankCondition2AndUp.iMaxRank = -1;	// No max rank for level 3 bonuses
	RankCondition2AndUp.LogEffectName = "Explosive Ordnance 2";
	RankCondition2AndUp.GiveProject = 'WOTC_APA_SapperUnlock1';
	
	RankCondition3 = new class 'X2Condition_WOTC_APA_Class_TargetRankRequirement';
	RankCondition3.iMinRank = 6;
	RankCondition3.iMaxRank = -1;	// No max rank for level 3 bonuses
	RankCondition3.LogEffectName = "Explosive Ordnance 3";
	RankCondition3.GiveProject = 'WOTC_APA_SapperUnlock2';
	

	// Setup effects triggering bonus environmental damage (handled by event listeners)
	EnvironmentalDamage1 = new class'X2Effect_Persistent';
	EnvironmentalDamage1.EffectName = 'WOTC_APA_ExplosiveOrdnanceSapperEffect';
	EnvironmentalDamage1.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(EnvironmentalDamage1);

	EnvironmentalDamage3 = new class'X2Effect_Persistent';
	EnvironmentalDamage3.EffectName = 'WOTC_APA_ExplosiveOrdnanceEnhancedSapperEffect';
	EnvironmentalDamage3.BuildPersistentEffect(1, true, false, false);
	EnvironmentalDamage3.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(EnvironmentalDamage3);


	// Setup effect granting chance to crit and deal bonus damage with explosive attacks
	CritDamageEffect = new class'X2Effect_WOTC_APA_GrenadeCriticals';
	CritDamageEffect.CRIT_CHANCE_BONUS = default.EXPLOSIVE_ORDNANCE_EXPLOSIVE_CRIT_CHANCE;
	CritDamageEffect.CRIT_DAMAGE_BONUS = default.EXPLOSIVE_ORDNANCE_EXPLOSIVE_CRIT_DAMAGE;
	CritDamageEffect.BuildPersistentEffect(1, true, false, false);
	CritDamageEffect.TargetConditions.AddItem(RankCondition2AndUp);
	Template.AddTargetEffect(CritDamageEffect);


	// Setup effect granting bonus base and crit damage to "standard" grenade types
	StandardDamageEffect = new class'X2Effect_WOTC_APA_Class_BonusDamage';
	StandardDamageEffect.BonusDmg = default.EXPLOSIVE_ORDNANCE_STANDARD_EXPLOSIVE_BASE_DAMAGE;
	StandardDamageEffect.BonusCritDmg = default.EXPLOSIVE_ORDNANCE_STANDARD_EXPLOSIVE_CRIT_DAMAGE;
	StandardDamageEffect.bApplyToSecondary = true;
	StandardDamageEffect.bApplyToHeavyWeapon = true;
	StandardDamageEffect.bApplyToOther = true;
	StandardDamageEffect.bOnlyIndirect = true;
	StandardDamageEffect.BonusDamageConditions.AddItem(new class'X2Condition_WOTC_APA_StandardGrenadeType');
	StandardDamageEffect.SetDisplayInfo(ePerkBuff_Passive, default.strExplosiveOrdnance3Name, default.strExplosiveOrdnance3Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_ExplosiveOrdnance3", true,, Template.AbilitySourceName);
	StandardDamageEffect.BuildPersistentEffect(1, true, false, false);
	StandardDamageEffect.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(StandardDamageEffect);


	// Setup passive ability icons for ranks 1 and 2 (rank 3 is handled in the effect above)
	IconEffect1 = new class'X2Effect_Persistent';
	IconEffect1.SetDisplayInfo(ePerkBuff_Passive, default.strExplosiveOrdnance1Name, default.strExplosiveOrdnance1Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_ExplosiveOrdnance1", true,, Template.AbilitySourceName);
	IconEffect1.BuildPersistentEffect(1, true, false, false);
	IconEffect1.TargetConditions.AddItem(RankCondition1);
	Template.AddTargetEffect(IconEffect1);

	IconEffect2 = new class'X2Effect_Persistent';
	IconEffect2.SetDisplayInfo(ePerkBuff_Passive, default.strExplosiveOrdnance2Name, default.strExplosiveOrdnance2Desc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_ExplosiveOrdnance2", true,, Template.AbilitySourceName);
	IconEffect2.BuildPersistentEffect(1, true, false, false);
	IconEffect2.TargetConditions.AddItem(RankCondition2);
	Template.AddTargetEffect(IconEffect2);


	// Setup function granting bonus charges to grenades in the grenade pocket
	Template.GetBonusWeaponAmmoFn = ExplosiveOrdnance_BonusWeaponAmmo;


	// Add abilities to control reduced Rocket scatter
	RocketAccuracyEffect1 = new class'X2Effect_WOTC_APA_Class_AddAbilitiesToTarget';
	RocketAccuracyEffect1.AddAbilities.AddItem('WOTC_APA_ExplosiveOrdnanceRocketAccuracy1');
	RocketAccuracyEffect1.TargetConditions.AddItem(RankCondition2AndUp);
	Template.AddTargetEffect(RocketAccuracyEffect1);

	RocketAccuracyEffect2 = new class'X2Effect_WOTC_APA_Class_AddAbilitiesToTarget';
	RocketAccuracyEffect2.AddAbilities.AddItem('WOTC_APA_ExplosiveOrdnanceRocketAccuracy2');
	RocketAccuracyEffect2.TargetConditions.AddItem(RankCondition3);
	Template.AddTargetEffect(RocketAccuracyEffect2);


	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

function int ExplosiveOrdnance_BonusWeaponAmmo(XComGameState_Unit UnitState, XComGameState_Item ItemState)
{
	local XComGameState_Player				PlayerState;
	local X2WeaponTemplate					WeaponTemplate;
	local bool								bUnlock1, bUnlock2;
	local int								ChargeBonus;
	
	// Exclude items not in the Grenade Pocket
	if (ItemState.InventorySlot != eInvSlot_GrenadePocket)
		return 0;

	// Exclude rockets from bonus charges
	WeaponTemplate = X2WeaponTemplate(ItemState.GetMyTemplate());
	if (WeaponTemplate == none || WeaponTemplate.WeaponCat == 'rocket')
		return 0;

	// Exclude Frost Bombs and other unique grenades from bonus charges
	if (default.EXPLOSIVE_ORDNANCE_EXCLUDED_BONUS_GRENADE_TYPES.Find(ItemState.GetMyTemplateName()) != -1)
		return 0;

	// Check for Player Strategy Projects (AWC Unlocks) that should supercede rank checks
	PlayerState = XComGameState_Player(`XCOMHISTORY.GetGameStateForObjectID(UnitState.ControllingPlayer.ObjectID));
	if (PlayerState != none && PlayerState.SoldierUnlockTemplates.Length > 0)
	{
		if (PlayerState.SoldierUnlockTemplates.Find('WOTC_APA_SapperUnlock1') != -1) { bUnlock1 = true; }
		if (PlayerState.SoldierUnlockTemplates.Find('WOTC_APA_SapperUnlock2') != -1) { bUnlock2 = true; }
	}

	if (UnitState.GetSoldierRank() >= 3 || bUnlock1)
		ChargeBonus += default.EXPLOSIVE_ORDNANCE_BONUS_GRENADE_POCKET_CHARGE_2;
	
	if (UnitState.GetSoldierRank() >= 6 || bUnlock2)
		ChargeBonus += default.EXPLOSIVE_ORDNANCE_BONUS_GRENADE_POCKET_CHARGE_3;

	return ChargeBonus;
}

// Empty abilities used to trigger the rocket scatter reduction
static function X2AbilityTemplate WOTC_APA_ExplosiveOrdnanceRocketAccuracy1()
{
	local X2AbilityTemplate										Template;
	
	Template = CreatePassiveAbility('WOTC_APA_ExplosiveOrdnanceRocketAccuracy1', "img:///UILibrary_WOTC_APA_Class_Pack.perk_ExplosiveOrdnance2",, false);

	return Template;
}

static function X2AbilityTemplate WOTC_APA_ExplosiveOrdnanceRocketAccuracy2()
{
	local X2AbilityTemplate										Template;
	
	Template = CreatePassiveAbility('WOTC_APA_ExplosiveOrdnanceRocketAccuracy2', "img:///UILibrary_WOTC_APA_Class_Pack.perk_ExplosiveOrdnance3",, false);

	return Template;
}


// Defensive Mine - Passive:
static function X2AbilityTemplate WOTC_APA_DefensiveMine()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_BonusItems					ItemEffect;


	Template = CreatePassiveAbility('WOTC_APA_DefensiveMine', "img:///UILibrary_PerkIcons.UIPerk_grenade_proximitymine",, false /*Don't show icon in tactical*/);
	

	// Create an effect that adds [default: 1] free Defensive Mine
	ItemEffect = new class'X2Effect_WOTC_APA_Class_BonusItems';
	ItemEffect.BonusItems.AddItem('WOTC_APA_DefensiveMineItem');
	ItemEffect.FreeCharges = default.DEFENSIVE_MINE_CHARGES;
	ItemEffect.BuildPersistentEffect (1, true, false, false);
	Template.AddTargetEffect(ItemEffect);


	return Template;
}

// Defensive Mine - Passive:
static function X2AbilityTemplate WOTC_APA_DefensiveMineAWC()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_BonusItems					ItemEffect;


	Template = CreatePassiveAbility('WOTC_APA_DefensiveMineAWC', "img:///UILibrary_PerkIcons.UIPerk_grenade_proximitymine",, false /*Don't show icon in tactical*/);
	

	// Create an effect that adds [default: 1] free Defensive Mine
	ItemEffect = new class'X2Effect_WOTC_APA_Class_BonusItems';
	ItemEffect.BonusItems.AddItem('WOTC_APA_DefensiveMineItem');
	ItemEffect.FreeCharges = default.DEFENSIVE_MINE_CHARGES;
	ItemEffect.BuildPersistentEffect (1, true, false, false);
	Template.AddTargetEffect(ItemEffect);


	return Template;
}

// Defensive Mine Deploy - Active:
static function X2AbilityTemplate WOTC_APA_DefensiveMineDeploy()
{

	local X2AbilityTemplate						Template;	
	local X2AbilityCost_ActionPoints			ActionPointCost;
	local X2AbilityTarget_Cursor				CursorTarget;
	local X2AbilityMultiTarget_Radius			RadiusMultiTarget;
	local X2Effect_ProximityMine				ProximityMineEffect;
	local X2AbilityCharges						Charges;
	local X2AbilityCost_Charges					ChargeCost;
	local X2AbilityCooldown						Cooldown;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_DefensiveMineDeploy');	
	
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	ChargeCost = new class'X2AbilityCost_Charges';
	Template.AbilityCosts.AddItem(ChargeCost);

	Charges = new class'X2AbilityCharges';
	Charges.InitialCharges = default.DEFENSIVE_MINE_CHARGES;
	Charges.AddBonusCharge('WOTC_APA_Minefield', default.MINEFIELD_BONUS_MINE_CHARGES);
	Template.AbilityCharges = Charges;

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = 1;
	Template.AbilityCooldown = Cooldown;
	
	Template.AbilityToHitCalc = default.DeadEye;
	
	CursorTarget = new class'X2AbilityTarget_Cursor';
	CursorTarget.bRestrictToWeaponRange = true;
	Template.AbilityTargetStyle = CursorTarget;

	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.bUseWeaponRadius = true;
	RadiusMultiTarget.fTargetRadius = 1.5;
	RadiusMultiTarget.bIgnoreBlockingCover = true;
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	ProximityMineEffect = new class'X2Effect_ProximityMine';
	ProximityMineEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddShooterEffect(ProximityMineEffect);
	
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.STANDARD_GRENADE_PRIORITY - 2;
	
	Template.HideErrors.AddItem('AA_CannotAfford_Charges');

	Template.ConcealmentRule = eConceal_Always;

	Template.bShowActivation = true;
	Template.CustomFireAnim = 'HL_LootBodyStart';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.TargetingMethod = class'X2TargetingMethod_DefensiveMine';
	Template.DamagePreviewFn = GrenadeDamagePreview;
	Template.CinescriptCameraType = "StandardGrenadeFiring";

	Template.Hostility = eHostility_Neutral;

	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_Mine";
	Template.ActivationSpeech = 'ProximityMine';

	Template.bRecordValidTiles = true;
	
	return Template;	
}

static simulated function UpdatedProximityMineDetonation_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateContext_Ability AbilityContext;
	local VisualizationActionMetadata VisTrack;
	local int ShooterTrackIdx;
	local X2Action_PlayEffect EffectAction;	
	local X2Action_CameraLookAt LookAtAction;
	local X2Action_Delay DelayAction;
	local X2Action_StartStopSound SoundAction;

	ShooterTrackIdx = INDEX_NONE;
	AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());

	VisTrack.StateObjectRef = AbilityContext.InputContext.SourceObject;
	class'X2Ability_Grenades'.static.TypicalAbility_BuildVisualization(VisualizeGameState);
		
	`assert(ShooterTrackIdx != INDEX_NONE);

	//Camera comes first
	//LookAtAction = X2Action_CameraLookAt(class'X2Action_CameraLookAt'.static.CreateVisualizationAction(AbilityContext));
	LookAtAction = X2Action_CameraLookAt(class'X2Action_CameraLookAt'.static.AddToVisualizationTree(VisTrack, AbilityContext, false));
	LookAtAction.LookAtLocation = AbilityContext.InputContext.TargetLocations[0];
	LookAtAction.BlockUntilFinished = true;
	LookAtAction.LookAtDuration = 1.5f;
	
	//Do the detonation
	EffectAction = X2Action_PlayEffect(class'X2Action_PlayEffect'.static.AddToVisualizationTree(VisTrack, AbilityContext, false));
	EffectAction.EffectName = class'X2Ability_Grenades'.default.ProximityMineExplosion;
	EffectAction.EffectLocation = AbilityContext.InputContext.TargetLocations[0];
	EffectAction.EffectRotation = Rotator(vect(0, 0, 1));
	EffectAction.bWaitForCompletion = false;
	EffectAction.bWaitForCameraCompletion = false;

	SoundAction = X2Action_StartStopSound(class'X2Action_StartStopSound'.static.AddToVisualizationTree(VisTrack, AbilityContext, false));
	SoundAction.Sound = new class'SoundCue';
	SoundAction.Sound.AkEventOverride = AkEvent'SoundMagneticWeapons.Turret_TakeDamage';
	SoundAction.bIsPositional = true;
	SoundAction.vWorldPosition = AbilityContext.InputContext.TargetLocations[0];
	
	//Keep the camera there after things blow up
	DelayAction = X2Action_Delay(class'X2Action_Delay'.static.AddToVisualizationTree(VisTrack, AbilityContext, false));
	DelayAction.Duration = 0.5;	
}

// Special handling for defensive proximity mine damage as they do not deal damage until they explode and therefore don't have damage effects to show during deployment
function bool GrenadeDamagePreview(XComGameState_Ability AbilityState, StateObjectReference TargetRef, out WeaponDamageValue MinDamagePreview, out WeaponDamageValue MaxDamagePreview, out int AllowsShield)
{
	local XComGameState_Item ItemState;
	local X2GrenadeTemplate GrenadeTemplate;
	local XComGameState_Ability DetonationAbility;
	local XComGameState_Unit SourceUnit;
	local XComGameStateHistory History;
	local StateObjectReference AbilityRef;

	ItemState = AbilityState.GetSourceAmmo();
	if (ItemState == none)
		ItemState = AbilityState.GetSourceWeapon();

	if (ItemState == none)
		return false;

	GrenadeTemplate = X2GrenadeTemplate(ItemState.GetMyTemplate());
	if (GrenadeTemplate == none)
		return false;

	if (GrenadeTemplate.DataName != 'WOTC_APA_DefensiveMineItem')
		return false;

	History = `XCOMHISTORY;
	SourceUnit = XComGameState_Unit(History.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
	AbilityRef = SourceUnit.FindAbility(class'X2Ability_Grenades'.default.ProximityMineDetonationAbilityName);
	DetonationAbility = XComGameState_Ability(History.GetGameStateForObjectID(AbilityRef.ObjectID));
	if (DetonationAbility == none)
		return false;

	DetonationAbility.GetDamagePreview(TargetRef, MinDamagePreview, MaxDamagePreview, AllowsShield);
	return true;
}


// Skirmisher - Passive: Gain +3 Mobility and, at the end of the turn, +3% chance per tile moved (up to a max of 30%) to convert a standard hit received down to a graze.
static function X2AbilityTemplate WOTC_APA_Skirmisher()
{

	local X2AbilityTemplate											Template;
	local X2Effect_PersistentStatChange								StatEffect;


	Template = CreatePassiveAbility('WOTC_APA_Skirmisher', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Skirmisher");


	// Create a persistent stat change effect that adds [default: +3] mobility
	StatEffect = new class 'X2Effect_PersistentStatChange';
	StatEffect.EffectName = 'WOTC_APA_SkirmisherMobility';
	StatEffect.BuildPersistentEffect(1, true, false, false);
	StatEffect.AddPersistentStatChange(eStat_Mobility, default.SKIRMISHER_MOBILITY_BONUS);
	Template.AddTargetEffect(StatEffect);

	// Add UI stat markup corresponding to effect stat boosts
	Template.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, default.SKIRMISHER_MOBILITY_BONUS);


	// Add the additional ability that converts hits to grazes based on movement each turn
	Template.AdditionalAbilities.AddItem('WOTC_APA_SkirmisherGraze');


	return Template;
}

// Skirmisher - Passive: At the end of the turn, gain +3% chance per tile moved (up to a max of 30%) to convert a received standard hit down to a graze.
static function X2AbilityTemplate WOTC_APA_SkirmisherGraze()
{

	local X2AbilityTemplate										Template;
	local X2AbilityTrigger_EventListener						EventListener;
	local X2Effect_WOTC_APA_Skirmisher							GrazeEffect;
	

	Template = CreatePassiveAbility('WOTC_APA_SkirmisherGraze', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Evasive",, false /*Don't show icon in tactical*/);
	Template.AbilityTriggers.Length = 0;


	// This ability triggers at the end of each turn
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = 'PlayerTurnEnd';
	EventListener.ListenerData.Filter = eFilter_Player;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	Template.AbilityTriggers.AddItem(EventListener);


	// Create effect to add dodge based on distance between starting and ending tiles
	GrazeEffect = new class'X2Effect_WOTC_APA_Skirmisher';
	GrazeEffect.EffectName = 'WOTC_APA_SkirmisherGrazeEffect';
	GrazeEffect.DuplicateResponse = eDupe_Ignore;
	GrazeEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	Template.AddTargetEffect(GrazeEffect);


	return Template;
}


// Entrenched - Passive: Gain 1 Damage Reduction and immunity to Critical Hits when attacked through Full Cover
static function X2AbilityTemplate WOTC_APA_Entrenched()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Entrenched							DefensiveEffect;


	Template = CreatePassiveAbility('WOTC_APA_Entrenched', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Entrenched");
	

	// Create a persistent effect that adds damage reduction and crit immunity when shot through full cover
	DefensiveEffect = new class'X2Effect_WOTC_APA_Entrenched';
	DefensiveEffect.EffectName = 'WOTC_APA_EntrenchedEffect';
	DefensiveEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false,, Template.AbilitySourceName);
	DefensiveEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(DefensiveEffect);


	return Template;
}


// Return Fire - Passive:
static function X2AbilityTemplate WOTC_APA_ReturnFire()
{

	local X2AbilityTemplate						Template;
	local X2AbilityTargetStyle                  TargetStyle;
	local X2AbilityTrigger						Trigger;
	local X2Effect_ReturnFire					FireEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_ReturnFire');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_ReturnFire";

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AddShooterEffectExclusions();

	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);

	FireEffect = new class'X2Effect_ReturnFire';
	FireEffect.BuildPersistentEffect(1, true, false, false, eGameRule_PlayerTurnBegin);
	FireEffect.EffectName = 'WOTC_APA_ReturnFireEffect';
	FireEffect.MaxPointsPerTurn = default.RETURN_FIRE_ACTIVATIONS_PER_TURN;
	FireEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage,,,Template.AbilitySourceName);
	Template.AddTargetEffect(FireEffect);

	Template.AdditionalAbilities.AddItem('PistolReturnFire');

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Air-Burst Grenades - Passive: Grenades gain +1 explosive radius
static function X2AbilityTemplate WOTC_APA_AirburstGrenades()
{

	local X2AbilityTemplate										Template;


	Template = CreatePassiveAbility('WOTC_APA_AirburstGrenades', "img:///UILibrary_WOTC_APA_Class_Pack.perk_AirburstGrenades");

	
	return Template;
}


// Concussion Grenades: Grants +1 charges to equipped flashbangs and adds disorient to most grenade explosions
static function X2AbilityTemplate WOTC_APA_ConcussionGrenadesSapper()
{
	
	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Class_BonusItems					ItemEffect;
	

	Template = CreatePassiveAbility('WOTC_APA_ConcussionGrenadesSapper', "img:///UILibrary_WOTC_APA_Class_Pack.perk_ConcussionGrenades");


	// Create an effect that adds [default: 1] additional charges to equipped flashbangs
	ItemEffect = new class'X2Effect_WOTC_APA_Class_BonusItems';
	ItemEffect.EffectName = 'WOTC_APA_ConcussionGrenadesEffect';
	ItemEffect.BonusItems = class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CONCUSSION_GRENADES_CHARGE_GRENADE_TYPES;
	ItemEffect.BonusCharges = class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CONCUSSION_GRENADES_CHARGE_BONUS;
	ItemEffect.BuildPersistentEffect (1, true, false, false);
	Template.AddTargetEffect(ItemEffect);


	return Template;
}


// Charge! - Active: Dashing attack that ends with a point-blank primary weapon attack
static function X2AbilityTemplate WOTC_APA_Charge() 
{
	local X2AbilityTemplate										Template;
	local X2AbilityCost_Ammo									AmmoCost;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2AbilityCooldown										Cooldown;
	//local X2AbilityToHitCalc_StandardMelee						StandardMelee;
	local X2Effect_ApplyWeaponDamage							WeaponDamageEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_Charge');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_Charge"; 
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_AlwaysShow;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_CAPTAIN_PRIORITY;
	Template.Hostility = eHostility_Offensive;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.bCrossClassEligible = false;


	// Define action point and ammo costs
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);


	// Define targeting conditions and cooldown
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);
	Template.AbilityTargetConditions.AddItem(default.MeleeVisibilityCondition);
	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_EndOfMove');
	Template.AbilityTargetStyle = new class'X2AbilityTarget_MovingMelee';
	Template.TargetingMethod = class'X2TargetingMethod_MeleePath';

	//Template.AbilityToHitCalc = default.SimpleStandardAim;
	//Template.AbilityToHitOwnerOnMissCalc = default.SimpleStandardAim;
	Template.AbilityToHitCalc = default.DeadEye;

	//StandardMelee = new class'X2AbilityToHitCalc_StandardMelee';
	//StandardMelee.BuiltInHitMod = 25;
	//Template.AbilityToHitCalc = StandardMelee;

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.CHARGE_COOLDOWN;
	Template.AbilityCooldown = Cooldown;


	// Create weapon attack effect
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	Template.AddTargetEffect(WeaponDamageEffect);

	Template.bAllowBonusWeaponEffects = true;
	Template.bSkipMoveStop = true;
	

	Template.BuildNewGameStateFn = TypicalMoveEndAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.BuildInterruptGameStateFn = TypicalMoveEndAbility_BuildInterruptGameState;	
	Template.CinescriptCameraType = "Ranger_Reaper";


	return Template;
}


// Concentrated Corrosives - Passive: 
static function X2AbilityTemplate WOTC_APA_ConcentratedCorrosives()
{

	local X2AbilityTemplate										Template;


	Template = CreatePassiveAbility('WOTC_APA_ConcentratedCorrosives', "img:///UILibrary_WOTC_APA_Class_Pack.perk_ConcentratedCorrosives");
	

	return Template;
}


// Burn Out - Passive: 
static function X2AbilityTemplate WOTC_APA_BurnOut()
{

	local X2AbilityTemplate										Template;


	Template = CreatePassiveAbility('WOTC_APA_BurnOut', "img:///UILibrary_WOTC_APA_Class_Pack.perk_BurnOut");
	

	return Template;
}


// Chemical Warfare - Passive: 
static function X2AbilityTemplate WOTC_APA_ChemicalWarfare()
{

	local X2AbilityTemplate										Template;


	Template = CreatePassiveAbility('WOTC_APA_ChemicalWarfare', "img:///UILibrary_WOTC_APA_Class_Pack.perk_ChemicalWarfare");
	

	// Add the additional ability that creates the delayed stun effect, when applicable
	//Template.AdditionalAbilities.AddItem('WOTC_APA_ChemicalWarfareDelayedStun');


	return Template;
}

// Chemical Warfare Delayed Stun - Triggered: - Applies the delayed stun from Chemical Warfare after targets have finished their scamper moves
static function X2AbilityTemplate WOTC_APA_ChemicalWarfareDelayedStun()
{

	local X2AbilityTemplate					Template;
	local X2Effect_Persistent               StunEffect;
	local X2AbilityTrigger_EventListener	EventListener;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_ChemicalWarfareDelayedStun');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_ChemicalWarfare";
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
	EventListener.ListenerData.EventID = class'X2Effect_WOTC_APA_ChemicalWarfare'.default.WOTC_APA_ChemicalWarfare_TriggeredName;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.VoidRiftInsanityListener;
	Template.AbilityTriggers.AddItem(EventListener);


	// Create the Disoriented effect on the target
	StunEffect = class'X2StatusEffects'.static.CreateStunnedStatusEffect(1, 100, false);
	StunEffect.bRemoveWhenSourceDies = false;
	Template.AddTargetEffect(StunEffect);

	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}


// Destructive Nature - Passive: Equipped Heavy Weapons now receive all benefits from Explosive Ordnance
static function X2AbilityTemplate WOTC_APA_DestructiveNature()
{

	local X2AbilityTemplate										Template;


	Template = CreatePassiveAbility('WOTC_APA_DestructiveNature', "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_Hammerfall",'WOTC_APA_DestructiveNatureEffect');

	
	return Template;
}


// Hold Position - Active:
static function X2AbilityTemplate WOTC_APA_HoldPosition()
{
	local X2AbilityTemplate										Template;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2AbilityCooldown										Cooldown;
	local XMBCondition_CoverType								CoverCondition;
	local X2Condition_UnitProperty								ConcealedCondition;
	local X2Effect_ReserveActionPoints							ReservePointsEffect;
	local X2Condition_UnitEffects								SuppressedCondition;
	
	
	Template = CreateSelfActiveAbility('WOTC_APA_HoldPosition', "img:///UILibrary_WOTC_APA_Class_Pack.perk_HoldPosition");

	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.OVERWATCH_PRIORITY + 2;
	Template.AbilityConfirmSound = "Unreal2DSounds_OverWatch";
	Template.Hostility = eHostility_Defensive;
	Template.ActivationSpeech = 'KillZone';
	Template.ConcealmentRule = eConceal_Never;
	Template.bSkipFireAction = true;


	// Set ability costs, cooldowns, and restrictions
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.HOLD_POSITION_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	CoverCondition = new class'XMBCondition_CoverType';
	CoverCondition.AllowedCoverTypes.AddItem(CT_Standing);
	CoverCondition.bCheckRelativeToSource = false;
	Template.AbilityShooterConditions.AddItem(CoverCondition);

	//Template.AbilityShooterConditions.AddItem(new class'X2Condition_Stealth');

	ConcealedCondition = new class'X2Condition_UnitProperty';
	ConcealedCondition.ExcludeFriendlyToSource = false;
	ConcealedCondition.ExcludeConcealed = true;
	//ConcealedCondition.IsConcealed = true;
	Template.AbilityShooterConditions.AddItem(ConcealedCondition);

	Template.AddShooterEffectExclusions();
	SuppressedCondition = new class'X2Condition_UnitEffects';
	SuppressedCondition.AddExcludeEffect(class'X2Effect_Suppression'.default.EffectName, 'AA_UnitIsSuppressed');
	Template.AbilityShooterConditions.AddItem(SuppressedCondition);

	ReservePointsEffect = new class'X2Effect_ReserveActionPoints';
	ReservePointsEffect.ReserveType = 'WOTC_APA_HoldPosition';
	Template.AddShooterEffect(ReservePointsEffect);

	Template.AdditionalAbilities.AddItem('WOTC_APA_HoldPositionShot');
	Template.AdditionalAbilities.AddItem('WOTC_APA_HoldPositionShotCF');

	Template.BuildNewGameStateFn = HoldPosition_BuildGameState;
	Template.BuildVisualizationFn = HoldPosition_BuildVisualization;

	return Template;
}

simulated function XComGameState HoldPosition_BuildGameState(XComGameStateContext Context)
{
	local XComGameState NewGameState;
	local XComGameState_Unit UnitState;
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState_Ability AbilityState;
	local XComGameState_Item WeaponState, NewWeaponState;
	local bool bFreeReload;
	local int i;

	NewGameState = `XCOMHISTORY.CreateNewGameState(true, Context);
	AbilityContext = XComGameStateContext_Ability(Context);	
	AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID( AbilityContext.InputContext.AbilityRef.ObjectID ));

	//Build the new game state and context
	NewGameState = TypicalAbility_BuildGameState(Context);

	WeaponState = AbilityState.GetSourceWeapon();
	NewWeaponState = XComGameState_Item(NewGameState.ModifyStateObject(class'XComGameState_Item', WeaponState.ObjectID));

	UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', AbilityContext.InputContext.SourceObject.ObjectID));	
	AbilityState.GetMyTemplate().ApplyCost(AbilityContext, AbilityState, UnitState, NewWeaponState, NewGameState);

	//  refill the weapon's ammo	
	NewWeaponState.Ammo = NewWeaponState.GetClipSize();
	
	return NewGameState;	
}

simulated function HoldPosition_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory History;
	local XComGameStateContext_Ability  Context;
	local StateObjectReference          ShootingUnitRef;	
	local X2Action_PlayAnimation		PlayAnimation;

	local VisualizationActionMetadata        EmptyTrack;
	local VisualizationActionMetadata        ActionMetadata;

	local XComGameState_Ability Ability;
	local X2Action_PlaySoundAndFlyOver SoundAndFlyover;

	History = `XCOMHISTORY;

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	ShootingUnitRef = Context.InputContext.SourceObject;

	//Configure the visualization track for the shooter
	//****************************************************************************************
	ActionMetadata = EmptyTrack;
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(ShootingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(ShootingUnitRef.ObjectID);
	ActionMetadata.VisualizeActor = History.GetVisualizer(ShootingUnitRef.ObjectID);
					
	PlayAnimation = X2Action_PlayAnimation(class'X2Action_PlayAnimation'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
	PlayAnimation.Params.AnimName = 'HL_Reload';

	Ability = XComGameState_Ability(History.GetGameStateForObjectID(Context.InputContext.AbilityRef.ObjectID));
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, "", Ability.GetMyTemplate().ActivationSpeech, eColor_Good);
	//****************************************************************************************
}

// Hold Position Shot - Triggered: 
static function X2AbilityTemplate WOTC_APA_HoldPositionShot()
{

	local X2AbilityTemplate											Template;
	local X2AbilityCost_Ammo										AmmoCost;
	local X2AbilityCost_ReserveActionPoints							ReserveActionPointCost;
	local X2Effect_Persistent										HoldPositionShotEffect;
	local X2Condition_UnitEffectsWithAbilitySource					HoldPositionShotCondition;
	local X2Condition_UnitProperty									ShooterCondition;


	Template = CreateAbilityReactionShot('WOTC_APA_HoldPositionShot', "img:///UILibrary_WOTC_APA_Class_Pack.perk_HoldPosition", eInvSlot_PrimaryWeapon,,,,, true /*require the absence of Covering Fire*/);
	

	// Define Ability Costs and Cooldown (Action Points, Ammo, etc.)
	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);

	ReserveActionPointCost = new class'X2AbilityCost_ReserveActionPoints';
	ReserveActionPointCost.iNumPoints = 1;
	ReserveActionPointCost.bFreeCost = true;
	ReserveActionPointCost.AllowedTypes.AddItem('WOTC_APA_HoldPosition');
	Template.AbilityCosts.AddItem(ReserveActionPointCost);

	
	//  Do not shoot targets that were already hit by this unit this turn with this ability
	HoldPositionShotCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	HoldPositionShotCondition.AddExcludeEffect('WOTC_APA_HoldPositionTarget', 'AA_UnitIsImmune');
	Template.AbilityTargetConditions.AddItem(HoldPositionShotCondition);
	//  Mark the target as shot by this unit so it cannot be shot again this turn
	HoldPositionShotEffect = new class'X2Effect_Persistent';
	HoldPositionShotEffect.EffectName = 'WOTC_APA_HoldPositionTarget';
	HoldPositionShotEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	HoldPositionShotEffect.SetupEffectOnShotContextResult(true, true);      //  mark them regardless of whether the shot hit or missed
	Template.AddTargetEffect(HoldPositionShotEffect);

	ShooterCondition = new class'X2Condition_UnitProperty';
	ShooterCondition.ExcludeConcealed = true;
	Template.AbilityShooterConditions.AddItem(ShooterCondition);


	return Template;	
}

// Hold Position Shot - Triggered: 
static function X2AbilityTemplate WOTC_APA_HoldPositionShotCF()
{

	local X2AbilityTemplate											Template;
	local X2AbilityCost_Ammo										AmmoCost;
	local X2AbilityCost_ReserveActionPoints							ReserveActionPointCost;
	local X2Effect_Persistent										HoldPositionShotEffect;
	local X2Condition_UnitEffectsWithAbilitySource					HoldPositionShotCondition;
	local X2Condition_UnitProperty									ShooterCondition;


	Template = CreateAbilityReactionShot('WOTC_APA_HoldPositionShotCF', "img:///UILibrary_WOTC_APA_Class_Pack.perk_HoldPosition", eInvSlot_PrimaryWeapon,,, true /*trigger on hostile actions*/, true /*require the presence of Covering Fire*/);
	

	// Define Ability Costs and Cooldown (Action Points, Ammo, etc.)
	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);

	ReserveActionPointCost = new class'X2AbilityCost_ReserveActionPoints';
	ReserveActionPointCost.iNumPoints = 1;
	ReserveActionPointCost.bFreeCost = true;
	ReserveActionPointCost.AllowedTypes.AddItem('WOTC_APA_HoldPosition');
	Template.AbilityCosts.AddItem(ReserveActionPointCost);

	
	//  Do not shoot targets that were already hit by this unit this turn with this ability
	HoldPositionShotCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	HoldPositionShotCondition.AddExcludeEffect('WOTC_APA_HoldPositionTarget', 'AA_UnitIsImmune');
	Template.AbilityTargetConditions.AddItem(HoldPositionShotCondition);
	//  Mark the target as shot by this unit so it cannot be shot again this turn
	HoldPositionShotEffect = new class'X2Effect_Persistent';
	HoldPositionShotEffect.EffectName = 'WOTC_APA_HoldPositionTarget';
	HoldPositionShotEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
	HoldPositionShotEffect.SetupEffectOnShotContextResult(true, true);      //  mark them regardless of whether the shot hit or missed
	Template.AddTargetEffect(HoldPositionShotEffect);

	ShooterCondition = new class'X2Condition_UnitProperty';
	ShooterCondition.ExcludeConcealed = true;
	Template.AbilityShooterConditions.AddItem(ShooterCondition);


	return Template;	
}


// HEAT Warheads - Passive: Standard grenades shred 1 additional armor and pierce 2 armor
static function X2AbilityTemplate WOTC_APA_HEATGrenades()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_HEATGrenades						ShredEffect;


	Template = CreatePassiveAbility('WOTC_APA_HEATGrenades', "img:///UILibrary_WOTC_APA_Class_Pack.perk_HEATGrenades");


	ShredEffect = new class'X2Effect_WOTC_APA_HEATGrenades';
	ShredEffect.ArmorPierce = default.HEAT_WARHEADS_ARMOR_PIERCE;
	ShredEffect.BonusShred = default.HEAT_WARHEADS_ARMOR_SHRED;
	ShredEffect.BuildPersistentEffect (1, true, false, false);
	Template.AddTargetEffect(ShredEffect);
	

	return Template;
}


// Unbreakable - Passive: Grants immunity to panic and being stunned or mind-controlled
static function X2AbilityTemplate WOTC_APA_Unbreakable()
{

	local X2AbilityTemplate										Template;
	local X2Effect_DamageImmunity								ImmunityEffect;


	Template = CreatePassiveAbility('WOTC_APA_Unbreakable', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Unbreakable");


	// Build the immunities
	ImmunityEffect = new class'X2Effect_DamageImmunity';
	ImmunityEffect.BuildPersistentEffect(1, true, false, false);
	ImmunityEffect.ImmuneTypes.AddItem('Stun');
	ImmunityEffect.ImmuneTypes.AddItem('Panic');
	ImmunityEffect.ImmuneTypes.AddItem('Mental');
	Template.AddTargetEffect(ImmunityEffect);
	

	return Template;
}


// Minefield - Passive: 
static function X2AbilityTemplate WOTC_APA_Minefield()
{

	local X2AbilityTemplate										Template;


	Template = CreatePassiveAbility('WOTC_APA_Minefield', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Minefield");
	

	return Template;
}


// Reflex - Passive: If the source was attacked (direct target attack), gain an additional movement-only action on the following turn.
static function X2AbilityTemplate WOTC_APA_Reflex()
{

	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_Reflex								ReflexEffect;


	Template = CreatePassiveAbility('WOTC_APA_Reflex', "img:///UILibrary_WOTC_APA_Class_Pack.perk_Reflex");
	

	// Persistent effect that grants the move action
	ReflexEffect = new class'X2Effect_WOTC_APA_Reflex';
	ReflexEffect.BuildPersistentEffect(1, true, false, false);
	ReflexEffect.EffectName = 'WOTC_APA_ReflexActionEffect';
	ReflexEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(ReflexEffect);


	return Template;
}


// Heavy Hardpoints - Passive: Allows the source to equip heavy weapons and gives a grenade pocket to equip an additional grenade.
static function X2AbilityTemplate WOTC_APA_HeavyHardpoints()
{

	local X2AbilityTemplate			Template;

	Template = CreatePassiveAbility('WOTC_APA_HeavyHardpoints', "img:///UILibrary_WOTC_APA_Class_Pack.perk_HeavyHardpoints");
	
	return Template;
}


// Explosive Action - Active: 
static function X2AbilityTemplate WOTC_APA_ExplosiveAction()
{

	local X2AbilityTemplate										Template;
	local X2AbilityCooldown										Cooldown;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2Effect_WOTC_APA_ExplosiveAction						ActionEffect;


	Template = CreateSelfActiveAbility('WOTC_APA_ExplosiveAction', "img:///UILibrary_WOTC_APA_Class_Pack.perk_ExplosiveAction");
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_CORPORAL_PRIORITY - 1;
	Template.bSkipFireAction = true;


	// Set ability costs, cooldowns, and restrictions
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.EXPLOSIVE_ACTION_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	ActionPointCost.AllowedTypes.AddItem(class'X2CharacterTemplateManager'.default.MoveActionPoint);
	Template.AbilityCosts.AddItem(ActionPointCost);
	

	// Add the effects altering action points now and at the start of the next turn
	ActionEffect = new class'X2Effect_WOTC_APA_ExplosiveAction';
	ActionEffect.EffectName = 'X2Effect_WOTC_APA_ExplosiveActionEffect';
	ActionEffect.BuildPersistentEffect(2, false, false, false, eGameRule_PlayerTurnEnd);
	Template.AddTargetEffect(ActionEffect);


	return Template;
}


// Remote Start - Active: 
static function X2AbilityTemplate WOTC_APA_RemoteStart()
{
	
	local X2AbilityTemplate										Template;
	local X2AbilityCost_ActionPoints							ActionPointCost;
	local X2AbilityCost_Ammo									AmmoCost;
	local X2AbilityCooldown										Cooldown;
	local X2Effect_RemoteStart									RemoteStartEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, 'WOTC_APA_RemoteStart');
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_remotestart";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_CORPORAL_PRIORITY + 1;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Offensive;
	Template.ConcealmentRule = eConceal_Always;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = new class'X2AbilityTarget_RemoteStart';
	Template.TargetingMethod = class'X2TargetingMethod_RemoteStart';
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.ActivationSpeech = 'RemoteStart';
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.bLimitTargetIcons = true;
	Template.bCrossClassEligible = false;


	// Setup costs and conditions
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);
	Template.AddShooterEffectExclusions();

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);
	Template.bAllowAmmoEffects = true;

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.REMOTE_START_COOLDOWN;
	Template.AbilityCooldown = Cooldown;


	// Setup Remote Start effect
	RemoteStartEffect = new class'X2Effect_RemoteStart';
	RemoteStartEffect.UnitDamageMultiplier = 1.0f;
	RemoteStartEffect.DamageRadiusMultiplier = 2.0f;
	Template.AddTargetEffect(RemoteStartEffect);


	// Break squad concealment on shot
	Template.AddTargetEffect(new class'X2Effect_WOTC_APA_Class_BreakSquadConcealment');


	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotChosenActivationIncreasePerUse;
	Template.DamagePreviewFn = RemoteStartDamagePreview;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;


	return Template;
}

function bool RemoteStartDamagePreview(XComGameState_Ability AbilityState, StateObjectReference TargetRef, out WeaponDamageValue MinDamagePreview, out WeaponDamageValue MaxDamagePreview, out int AllowsShield)
{
	local XComDestructibleActor DestructibleActor;
	local XComDestructibleActor_Action_RadialDamage DamageAction;
	local int i;

	DestructibleActor = XComDestructibleActor(`XCOMHISTORY.GetVisualizer(TargetRef.ObjectID));
	if (DestructibleActor != none)
	{
		for (i = 0; i < DestructibleActor.DestroyedEvents.Length; ++i)
		{
			if (DestructibleActor.DestroyedEvents[i].Action != None)
			{
				DamageAction = XComDestructibleActor_Action_RadialDamage(DestructibleActor.DestroyedEvents[i].Action);
				if (DamageAction != none)
				{
					MinDamagePreview.Damage += DamageAction.UnitDamage;
					MaxDamagePreview.Damage += DamageAction.UnitDamage;
				}
			}
		}
	}

	return true;
}


// Bomb Belts - Passive:
static function X2AbilityTemplate WOTC_APA_BombBelts()
{
	local X2AbilityTemplate			Template;

	Template = CreatePassiveAbility('WOTC_APA_BombBelts', "img:///UILibrary_WOTC_APA_Class_Pack.perk_BombBelts");
	
	return Template;
}


// Support Grenadier - Passive:
static function X2AbilityTemplate WOTC_APA_SupportGrenadier()
{
	local X2AbilityTemplate										Template;
	local X2Effect_WOTC_APA_SupportGrenadier					ActionEffect;

	Template = CreatePassiveAbility('WOTC_APA_SupportGrenadier', "img:///UILibrary_WOTC_APA_Class_Pack.perk_SupportGrenadier");
	
	ActionEffect = new class'X2Effect_WOTC_APA_SupportGrenadier';
	ActionEffect.EffectName = 'WOTC_APA_SupportGrenadierEffect';
	ActionEffect.DuplicateResponse = eDupe_Ignore;
	ActionEffect.BuildPersistentEffect(1, true, false);
	Template.AddTargetEffect(ActionEffect);

	return Template;
}