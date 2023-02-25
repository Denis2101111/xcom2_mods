
class X2Ability_WOTC_APA_Utilities extends X2Ability;


// ------------------------------------------------------------------------------
// --------------------  QUICK REFERENCE FOR MY POOR MEMORY  --------------------
// ------------------------------------------------------------------------------

/*
BuildPersistentEffect
(
	int _iNumTurns,
	optional bool _bInfiniteDuration=false,
	optional bool _bRemoveWhenSourceDies=true,
	optional bool _bIgnorePlayerCheckOnTick=false,
	optional GameRuleStateChange _WatchRule=eGameRule_TacticalGameStart
)

RegisterForEvent
(	ref Object SourceObj,
	Name EventID,
	delegate<OnEventDelegate> NewDelegate,
	optional EventListenerDeferral Deferral=ELD_Immediate,
	optional int Priority=50,
	optional Object PreFilterObject,
	optional bool bPersistent,
	optional Object CallbackData
)

TriggerEvent
(
	Name EventID,
	optional Object EventData,
	optional Object EventSource,
	optional XComGameState EventGameState
)

Template.AssociatedPlayTiming = SequencePlayTiming
	enum SequencePlayTiming
	{
		SPT_None,                // Play according to the standard scoring placement of this vis block
		SPT_AfterParallel,        // Play after the instigating event, in parallel with other visualizations following that event
		SPT_AfterSequential,    // Play after the instigating event, in sequence before other visualizations following that event
		SPT_BeforeParallel,        // Play at the same time as the instigating event, in parallel with that event
		SPT_BeforeSequential,    // Play before the instigating event, in sequence before that event begins
	};
*/

// ---------------------------------------------------------------------------------
// --------------------  ABILITY  FRAMEWORK  HELPER  FUNCTIONS  --------------------
// ---------------------------------------------------------------------------------


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(WOTC_APA_AcademyAbility());
	Templates.AddItem(WOTC_APA_AcademyObjective());

	return Templates;
}

// Dummy/filler ability for academy/AWC unlocks
static function X2AbilityTemplate WOTC_APA_AcademyAbility()
{
	local X2AbilityTemplate				Template;

	Template = CreatePassiveAbility('WOTC_APA_AcademyAbility',,,false);
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.bDontDisplayInAbilitySummary = true;

	return Template;
}

static function X2DataTemplate WOTC_APA_AcademyObjective()
{
	local X2ObjectiveTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ObjectiveTemplate', Template, 'WOTC_APA_AcademyObjective');
	Template.bMainObjective = false;
	Template.bNeverShowObjective = true;

	Template.CompletionRequirements.SpecialRequirementsFn = IsUnavailable;

	return Template;
}

static function bool IsUnavailable()
{
	return false;
}


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


// Helper function to setup basic framework for simple single-targeted activatible abilities
static function X2AbilityTemplate CreateSingleTargetAbility(name AbilityName, optional string IconString, optional bool bLimitWhenImpaired = true, optional array<name> SkipExclusions)
{
	
	local X2AbilityTemplate					Template;
	

	`CREATE_X2ABILITY_TEMPLATE (Template, AbilityName);
	Template.IconImage = IconString;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
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


// Helper function to setup ability reaction shots
static function X2AbilityTemplate CreateAbilityReactionShot(
	name AbilityName /*1*/, optional string IconString = "img:///UILibrary_PerkIcons.UIPerk_standard" /*2*/,
	optional eInventorySlot DefaultItemSlot = eInvSlot_Unknown /*3*/, optional bool bAllowSquadsight = false /*4*/,
	optional bool bReactToMovement = true /*5*/, optional bool bReactToHostileActions = false /*6*/,
	optional bool bRequireCoveringFirePresent = false /*7*/, optional bool bRequireCoveringFireAbsent = false /*8*/,
	optional bool bLimitWhenImpaired = true /*9*/, optional array<name> SkipExclusions /*10*/
){

	local X2AbilityTemplate											Template;
	local X2AbilityTrigger_EventListener							Trigger1, Trigger2;
	local X2AbilityToHitCalc_StandardAim							StandardAim;
	local X2Condition_WOTC_APA_Class_AbilityRequirement				AbilityCondition;
	local X2Condition_Visibility									TargetVisibilityCondition;
	local X2Condition_UnitEffects									EffectConditions;
	local X2Effect													ShotEffect;


	`CREATE_X2ABILITY_TEMPLATE(Template, AbilityName);
	Template.IconImage = IconString;
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.bDontDisplayInAbilitySummary = true;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.bCrossClassEligible = false;
	Template.bAllowAmmoEffects = true;
	Template.bShowActivation = true;
	Template.bUniqueSource = true;

	if (DefaultItemSlot != eInvSlot_Unknown)
	{
		Template.DefaultSourceItemSlot = DefaultItemSlot;
	}


	// Set ability shooter conditions based on the presence or absence of the Covering Fire ability
	if (bRequireCoveringFirePresent || bRequireCoveringFireAbsent)
	{
		AbilityCondition = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
		AbilityCondition.bCheckSourceUnit = true;
		if		(bRequireCoveringFirePresent)	{ AbilityCondition.RequiredAbilityNames.AddItem('CoveringFire'); }
		else if	(bRequireCoveringFireAbsent)	{ AbilityCondition.ExcludingAbilityNames.AddItem('CoveringFire'); }
		Template.AbilityShooterConditions.AddItem(AbilityCondition);
	}


	// Establish the events that the Reaction Shot will trigger on
	if (bReactToMovement)
	{
		// Trigger on movement - interrupt the move
		Trigger1 = new class'X2AbilityTrigger_EventListener';
		Trigger1.ListenerData.EventID = 'ObjectMoved';
		Trigger1.ListenerData.Deferral = ELD_OnStateSubmitted;
		Trigger1.ListenerData.Filter = eFilter_None;
		Trigger1.ListenerData.EventFn = class'XComGameState_Ability'.static.TypicalOverwatchListener;
		Template.AbilityTriggers.AddItem(Trigger1);
	}

	if (bReactToHostileActions)
	{
		// Trigger on a hostile attack (Covering Fire, etc.)
		Trigger2 = new class'X2AbilityTrigger_EventListener';
		Trigger2.ListenerData.EventID = 'AbilityActivated';
		Trigger2.ListenerData.Deferral = ELD_OnStateSubmitted;
		Trigger2.ListenerData.Filter = eFilter_None;
		Trigger2.ListenerData.EventFn = class'XComGameState_Ability'.static.TypicalAttackListener;
		Template.AbilityTriggers.AddItem(Trigger2);
	}	


	// Establish Ability Costs in individual ability templates
	// to handle different action point types, ammo costs, etc.


	// Define Aim (easily overriden)
	StandardAim = new class'X2AbilityToHitCalc_StandardAim';
	StandardAim.BuiltInHitMod = 0;
	StandardAim.bReactionFire = true;

	Template.AbilityToHitCalc = StandardAim;
	Template.AbilityToHitOwnerOnMissCalc = StandardAim;

	
	// Define Visibility Conditions
	TargetVisibilityCondition = new class'X2Condition_Visibility';	
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	TargetVisibilityCondition.bAllowSquadsight = bAllowSquadsight;
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);


	// Unit cannot be impaired (disoriented, confused, dazed, stunned, burning, bound, or carrying a unit) or panicked
	if (bLimitWhenImpaired)
	{
		Template.AddShooterEffectExclusions(SkipExclusions);

		EffectConditions = new class'X2Condition_UnitEffects';
		if (SkipExclusions.Find(class'X2AbilityTemplateManager'.default.PanickedName) == -1)
			EffectConditions.AddExcludeEffect(class'X2AbilityTemplateManager'.default.PanickedName, 'AA_UnitIsPanicked');
		if (SkipExclusions.Find(class'X2AbilityTemplateManager'.default.BerserkName) == -1)
			EffectConditions.AddExcludeEffect(class'X2AbilityTemplateManager'.default.BerserkName, 'AA_UnitIsPanicked');
		if (SkipExclusions.Find(class'X2AbilityTemplateManager'.default.ObsessedName) == -1)
			EffectConditions.AddExcludeEffect(class'X2AbilityTemplateManager'.default.ObsessedName, 'AA_UnitIsPanicked');
		if (SkipExclusions.Find(class'X2AbilityTemplateManager'.default.ShatteredName) == -1)
			EffectConditions.AddExcludeEffect(class'X2AbilityTemplateManager'.default.ShatteredName, 'AA_UnitIsPanicked');

		Template.AbilityShooterConditions.AddItem(EffectConditions);
	}
		
			
	// Put holo target effect first because if the target dies from this shot, it will be too late to notify the effect.
	ShotEffect = class'X2Ability_GrenadierAbilitySet'.static.HoloTargetEffect();
	ShotEffect.TargetConditions.AddItem(class'X2Ability_DefaultAbilitySet'.static.OverwatchTargetEffectsCondition());
	Template.AddTargetEffect(ShotEffect);


	// Add Weapon Stock damage on misses
	Template.AddTargetEffect(default.WeaponUpgradeMissDamage);


	// Various Soldier ability specific effects - effects check for the ability before applying	
	ShotEffect = class'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect();
	ShotEffect.TargetConditions.AddItem(class'X2Ability_DefaultAbilitySet'.static.OverwatchTargetEffectsCondition());
	Template.AddTargetEffect(ShotEffect);

	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;

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

// Plays flyover message on the SourceUnit with ability's LocFlyOverText when the ability is activated in addition to the standard visualization
simulated function AddSourceFlyover_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory					History;
	local XComGameStateContext_Ability			AbilityContext;
	local XComGameState_Ability					AbilityState;
	local X2AbilityTemplate						AbilityTemplate;
	local StateObjectReference					SourceUnitRef;
	local VisualizationActionMetadata			ActionMetadata;
	local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;
	
	History = `XCOMHISTORY;

	TypicalAbility_BuildVisualization(VisualizeGameState);

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


// Plays flyover message on the TargetUnit with ability's LocFlyOverText when the ability is activated
simulated function BasicTargetFlyover_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory					History;
	local XComGameStateContext_Ability			AbilityContext;
	local XComGameState_Ability					AbilityState;
	local X2AbilityTemplate						AbilityTemplate;
	local StateObjectReference					TargetUnitRef;
	local VisualizationActionMetadata			ActionMetadata;
	local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;
	
	History = `XCOMHISTORY;

	AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	TargetUnitRef = AbilityContext.InputContext.PrimaryTarget;
	AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID));
	AbilityTemplate = AbilityState.GetMyTemplate();
	
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(TargetUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(TargetUnitRef.ObjectID);
	if (ActionMetadata.StateObject_NewState == none)
		ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
	ActionMetadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(TargetUnitRef.ObjectID);
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, AbilityTemplate.LocFlyOverText, '', eColor_Good, AbilityTemplate.IconImage, `DEFAULTFLYOVERLOOKATTIME);
}


// Plays flyover message on the TargetUnit with ability's LocFlyOverText when the ability is activated in addition to the standard visualization
simulated function AddTargetFlyover_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory					History;
	local XComGameStateContext_Ability			AbilityContext;
	local XComGameState_Ability					AbilityState;
	local X2AbilityTemplate						AbilityTemplate;
	local StateObjectReference					TargetUnitRef;
	local VisualizationActionMetadata			ActionMetadata;
	local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;
	
	History = `XCOMHISTORY;

	TypicalAbility_BuildVisualization(VisualizeGameState);

	AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	TargetUnitRef = AbilityContext.InputContext.PrimaryTarget;
	AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID));
	AbilityTemplate = AbilityState.GetMyTemplate();
	
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(TargetUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(TargetUnitRef.ObjectID);
	if (ActionMetadata.StateObject_NewState == none)
		ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
	ActionMetadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(TargetUnitRef.ObjectID);
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, AbilityTemplate.LocFlyOverText, '', eColor_Good, AbilityTemplate.IconImage, `DEFAULTFLYOVERLOOKATTIME);
}