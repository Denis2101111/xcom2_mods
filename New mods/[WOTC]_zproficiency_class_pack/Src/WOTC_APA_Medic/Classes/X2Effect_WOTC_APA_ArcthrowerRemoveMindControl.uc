
class X2Effect_WOTC_APA_ArcthrowerRemoveMindControl extends X2Effect_Persistent;

var name WOTC_APA_ArcthrowerRemoveMindControl_TriggeredName;

// Play a flyover when the effect is added to the target (by an Arcthrower stun)
simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	if (XComGameState_Unit(kNewTargetState).IsMindControlled())
	{
		NewGameState.GetContext().PostBuildVisualizationFn.AddItem(Sedate_BuildVisualization);
}	}

simulated function Sedate_BuildVisualization(XComGameState VisualizeGameState)
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
	AbilityTemplate = AbilityTemplateMgr.FindAbilityTemplate('WOTC_APA_Sedate');
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


// Register for the UnitStunnedRemoved Event Trigger
function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager						EventManager;
	local Object								EffectObj, TargetObj;
	local bool									bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	EventManager = `XEVENTMGR;
	EffectObj = EffectGameState;
	TargetObj = `XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID);

	if (XComGameState_Unit(TargetObj).IsMindControlled())
	{
		EventManager.RegisterForEvent(EffectObj, 'UnitStunnedRemoved', ApplyRemoveEffects, ELD_Immediate,,,, EffectObj);
		`LOG("Arcthrower Remove Mind Control - Registered Event Listener for" @ XComGameState_Unit(TargetObj).GetFullName(), bLog);
}	}


// This is triggered when a stun is removed
static function EventListenerReturn ApplyRemoveEffects(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Unit					TargetUnit, SourceUnit, ExpectedTargetUnit;
	local XComGameState_Effect					EffectState;
	local bool									bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	`LOG("Arcthrower Remove Mind Control - Event Fired (Stunned status was removed from something)", bLog);

	// Get the Expected TargetUnit
	EffectState = XComGameState_Effect(CallbackData);
	ExpectedTargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	`LOG("Arcthrower Remove Mind Control - Expected(CallbackData) Target Unit" @ ExpectedTargetUnit.GetFullName() @ "(" $ ExpectedTargetUnit.ObjectID $ ")", bLog);

	// Get the Target Unit that actually triggered the UnitStunnedRemoved event
	SourceUnit = XComGameState_Unit(EventSource);
	`LOG("Arcthrower Remove Mind Control - AbilityContext(NewGameState) Source Unit" @ SourceUnit.GetFullName(), bLog);

	TargetUnit = XComGameState_Unit(EventData);
	`LOG("Arcthrower Remove Mind Control - AbilityContext(NewGameState) Target Unit" @ TargetUnit.GetFullName() @ "(" $ TargetUnit.ObjectID $ ")", bLog);

	// Check that the TargetUnit is the Expected TargetUnit
	if (ExpectedTargetUnit.ObjectID != TargetUnit.ObjectID)
	{
		`LOG("Arcthrower Remove Mind Control - event does not originate from Expected TargetUnit.", bLog);
		return ELR_NoInterrupt;
	}
		
	// Apply effect to remove Mind Control effects to the TargetUnit
	`LOG("Arcthrower Arcthrower Remove Mind Control - Expected Target found, triggering disorient effect.", bLog);
	`XEVENTMGR.TriggerEvent(default.WOTC_APA_ArcthrowerRemoveMindControl_TriggeredName, TargetUnit, SourceUnit, NewGameState);

	// Remove this effect once it has completed
	EffectState.RemoveEffect(NewGameState, NewGameState);

	return ELR_NoInterrupt;
}


DefaultProperties
{
	DuplicateResponse=eDupe_Ignore
	EffectName = "ArcthrowerRemoveMindControl"
	WOTC_APA_ArcthrowerRemoveMindControl_TriggeredName = "ArcthrowerRemoveMindControl_Triggered"
}