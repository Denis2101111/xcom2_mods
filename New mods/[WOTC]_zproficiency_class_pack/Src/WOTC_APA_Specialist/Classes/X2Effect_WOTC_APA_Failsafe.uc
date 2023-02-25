
class X2Effect_WOTC_APA_Failsafe extends X2Effect_PersistentStatChange;

var localized string strFailsafeTriggeredFlyover;

// Register for the AbilityActivated Event Trigger
function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager						EventManager;
	local Object								EffectObj, TargetObj;

	EventManager = `XEVENTMGR;
	EffectObj = EffectGameState;
	TargetObj = `XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID);

	EventManager.RegisterForEvent(EffectObj, 'WOTC_APA_FailsafeTriggered', OnFailsafeTriggered, ELD_OnStateSubmitted,, XComGameState_Unit(TargetObj),, TargetObj);
}

static function EventListenerReturn OnFailsafeTriggered(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	NewGameState.GetContext().PostBuildVisualizationFn.AddItem(Failsafe_BuildVisualization);	
	return ELR_NoInterrupt;
}

simulated function Failsafe_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory					History;
	local XComGameStateContext_Ability			AbilityContext;
	local XComGameState_Ability					AbilityState;
	local StateObjectReference					TargetUnitRef, SourceUnitRef;
	local VisualizationActionMetadata			ActionMetadata;
	local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;
	
	History = `XCOMHISTORY;

	AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID));
	
	TargetUnitRef = AbilityContext.InputContext.PrimaryTarget;
	
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(TargetUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(TargetUnitRef.ObjectID);
	if (ActionMetadata.StateObject_NewState == none)
		ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
	ActionMetadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(TargetUnitRef.ObjectID);
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(SoundCue'SoundParticleObjects.ShieldHitCue', default.strFailsafeTriggeredFlyover, '', eColor_Good, "img:///UILibrary_WOTC_APA_Class_Pack.perk_Failsafe", `DEFAULTFLYOVERLOOKATTIME);


	SourceUnitRef = AbilityContext.InputContext.SourceObject;
	
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(SourceUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(SourceUnitRef.ObjectID);
	if (ActionMetadata.StateObject_NewState == none)
		ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
	ActionMetadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(SourceUnitRef.ObjectID);
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(SoundCue'SoundParticleObjects.ShieldHitCue', default.strFailsafeTriggeredFlyover, '', eColor_Good, "img:///UILibrary_WOTC_APA_Class_Pack.perk_Failsafe", `DEFAULTFLYOVERLOOKATTIME);

}

defaultproperties
{
    DuplicateResponse=eDupe_Ignore
	bRemoveWhenSourceDies=true;
}