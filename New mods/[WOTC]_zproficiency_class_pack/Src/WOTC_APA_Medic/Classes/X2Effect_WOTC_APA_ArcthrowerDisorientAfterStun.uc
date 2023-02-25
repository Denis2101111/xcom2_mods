
class X2Effect_WOTC_APA_ArcthrowerDisorientAfterStun extends X2Effect_Persistent;

var name WOTC_APA_ArcthrowerDisorientAfterStun_TriggeredName;

// Play a flyover when the effect is added to the target (by an Arcthrower stun)
simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit	TargetUnit, SourceUnit;
	local bool					bShouldApply, bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	TargetUnit = XComGameState_Unit(kNewTargetState);
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.SourceStateObjectRef.ObjectID));

	bShouldApply = ShouldEffectApply(SourceUnit, TargetUnit);

	if (bShouldApply)
	{	// Add flyover visualization to the TargetUnit
		NewGameState.GetContext().PostBuildVisualizationFn.AddItem(OverchargedCapacitors_BuildVisualization);
	}
	else
	{	// Remove effect
		`LOG("Arcthrower Disorient After Stun - Effect should not be applied to ally... Removing", bLog);
		NewEffectState.RemoveEffect(NewGameState, NewGameState);
	}
}

simulated function OverchargedCapacitors_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory					History;
	local X2AbilityTemplateManager				AbilityTemplateMgr;
	local X2AbilityTemplate						AbilityTemplate;
	local XComGameStateContext_Ability			AbilityContext;
	local StateObjectReference					TargetUnitRef;
	local VisualizationActionMetadata			ActionMetadata;
	local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;

	History = `XCOMHISTORY;

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplate = AbilityTemplateMgr.FindAbilityTemplate('WOTC_APA_OverchargedCapacitors');
	AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	TargetUnitRef = AbilityContext.InputContext.PrimaryTarget;

	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(TargetUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(TargetUnitRef.ObjectID);
	if (ActionMetadata.StateObject_NewState == none)
		ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
	ActionMetadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(TargetUnitRef.ObjectID);
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, AbilityTemplate.LocFlyOverText, '', eColor_Good, AbilityTemplate.IconImage, `DEFAULTFLYOVERLOOKATTIME);
}


// Conditional check to prevent effects when the SourceUnit has the 'Arcthrower_PreventNegativeEffectsOnAlliesEffect' effect and is targeting an ally
function bool ShouldEffectApply(XComGameState_Unit SourceUnit, XComGameState_Unit TargetUnit)
{
	// Prevent effect from applying to mechanical targets, which are immune to the disorient effect (otherwise plays the flyover, but doesn't do anything...)
	if (TargetUnit.IsRobotic())
		return false;

	// If the Source unit does NOT have the required effect that may prevent this effect from applying, stop checking and return true
	if (SourceUnit.AffectedByEffectNames.Find('Arcthrower_PreventNegativeEffectsOnAlliesEffect') == -1)
		return true;

	// If the Source unit DOES have the effect that prevents this effect from applying to allies, check to see if the Target unit is a Mind Controlled ally
	if (SourceUnit.ControllingPlayer != TargetUnit.ControllingPlayer && !TargetUnit.IsMindControlled())
		return true;

	// Still allow effect to apply when shooting aliens that have been mind controlled to your side
	if (SourceUnit.ControllingPlayer == TargetUnit.ControllingPlayer && TargetUnit.IsMindControlled())
		return true;

	return false;
}


// Register for the UnitStunnedRemoved Event Trigger
function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager				EventManager;
	local Object						EffectObj, TargetObj;
	local XComGameState_Unit			SourceUnit, TargetUnit;
	local bool							bShouldApply, bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));

	bShouldApply = ShouldEffectApply(SourceUnit, TargetUnit);

	// Register for the Event Trigger if the effect should be applied to the target
	if (bShouldApply)
	{
		EventManager = `XEVENTMGR;
		EffectObj = EffectGameState;
		TargetObj = TargetUnit;

		EventManager.RegisterForEvent(EffectObj, 'UnitStunnedRemoved', ApplyDisorientEffect, ELD_OnStateSubmitted,,,, EffectObj);
		`LOG("Arcthrower Disorient After Stun - Registered Event Listener for" @ XComGameState_Unit(TargetObj).GetFullName(), bLog);
	}	
}

// This is triggered when a stun is removed
static function EventListenerReturn ApplyDisorientEffect(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Unit		TargetUnit, SourceUnit, ExpectedTargetUnit;
	local XComGameState_Effect		EffectState;
	//local XComGameState_Ability		AbilityState;
	local bool						bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	`LOG("Arcthrower Disorient After Stun - Event Fired (Stunned status was removed from something)", bLog);

	// Get the Expected TargetUnit
	EffectState = XComGameState_Effect(CallbackData);
	//AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
	ExpectedTargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	`LOG("Arcthrower Disorient After Stun - Expected(CallbackData) Target Unit" @ ExpectedTargetUnit.GetFullName() @ "(" $ ExpectedTargetUnit.ObjectID $ ")", bLog);

	// Get the Target Unit that actually triggered the UnitStunnedRemoved event
	SourceUnit = XComGameState_Unit(EventSource);
	`LOG("Arcthrower Disorient After Stun - AbilityContext(NewGameState) Source Unit" @ SourceUnit.GetFullName(), bLog);

	TargetUnit = XComGameState_Unit(EventData);
	`LOG("Arcthrower Disorient After Stun - AbilityContext(NewGameState) Target Unit" @ TargetUnit.GetFullName() @ "(" $ TargetUnit.ObjectID $ ")", bLog);

	// Check that the TargetUnit is the Expected TargetUnit
	if (ExpectedTargetUnit.ObjectID != TargetUnit.ObjectID)
	{
		`LOG("Arcthrower Disorient After Stun - event does not originate from Expected TargetUnit.", bLog);
		return ELR_NoInterrupt;
	}
		
	// Apply effect to Disorient the TargetUnit
	`LOG("Arcthrower Disorient After Stun - Expected Target found, triggering disorient effect.", bLog);
	`XEVENTMGR.TriggerEvent(default.WOTC_APA_ArcthrowerDisorientAfterStun_TriggeredName, TargetUnit, SourceUnit, NewGameState);

	// Remove this effect once it has completed
	EffectState.RemoveEffect(NewGameState, NewGameState);

	return ELR_NoInterrupt;
}


DefaultProperties
{
	DuplicateResponse=eDupe_Ignore
	EffectName = "ArcthrowerDisorientAfterStun"
	WOTC_APA_ArcthrowerDisorientAfterStun_TriggeredName = "ArcthrowerDisorientAfterStun_Triggered"
}