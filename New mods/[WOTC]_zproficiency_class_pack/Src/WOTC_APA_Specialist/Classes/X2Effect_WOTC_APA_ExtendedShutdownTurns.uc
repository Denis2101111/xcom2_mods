
class X2Effect_WOTC_APA_ExtendedShutdownTurns extends X2Effect_Persistent;

var localized string strExtendedShutdownTurnsFlyover;


// Register for the UnitChangedTeam Event Trigger
function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager				EventManager;
	local Object						EffectObj, TargetObj;
	local XComGameState_Unit			SourceUnit, TargetUnit;
	local bool							bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));

	EventManager = `XEVENTMGR;
	EffectObj = EffectGameState;
	TargetObj = TargetUnit;

	EventManager.RegisterForEvent(EffectObj, 'UnitStunned', ExtendedShutdown, ELD_OnStateSubmitted,,,, EffectObj);
	`LOG("Electronic Warfare - Extend Shutdown Turns: Registered Event Listener for" @ XComGameState_Unit(TargetObj).GetFullName(), bLog);
}


// Extend shutdown stuns on mechanical enemies
static function EventListenerReturn ExtendedShutdown(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Unit				TargetUnit, SourceUnit, ExpectedSourceUnit;
	local XComGameState_Effect				EffectState;
	local XComGameState_Ability				AbilityState;
	local XComGameStateContext_Ability		AbilityContext;
	local name								TriggeringAbilityName;
	local bool								bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	`LOG("Electronic Warfare - Extend Shutdown Turns: Event Fired", bLog);

	AbilityContext = XComGameStateContext_Ability(NewGameState.GetContext());
	TriggeringAbilityName = AbilityContext.InputContext.AbilityTemplateName;

	// Ignore if the stun was applied by the Full Override hack reward that is going to kill the unit
	if (TriggeringAbilityName == 'HackRewardSelfDestruct_WOTC_APA_FullOverride')
	{
		`LOG("Electronic Warfare - Extend Shutdown Turns: effect does not apply to this ability:" @ TriggeringAbilityName, bLog);
		return ELR_NoInterrupt;
	}


	// Get the Expected SourceUnit
	EffectState = XComGameState_Effect(CallbackData);
	AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
	ExpectedSourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	`LOG("Electronic Warfare - Extend Shutdown Turns: Expected(CallbackData) SourceUnit" @ ExpectedSourceUnit.GetFullName() @ "(" $ ExpectedSourceUnit.ObjectID $ ")", bLog);


	// Get the Source and Target Unit that actually triggered the event (yes, Firaxis' use of EventData and EventSource seems wierd in this situation...)
	SourceUnit = XComGameState_Unit(EventData);
	`LOG("Electronic Warfare - Extend Shutdown Turns: (EventData) Source Unit" @ SourceUnit.GetFullName(), bLog);

	TargetUnit = XComGameState_Unit(EventSource);
	`LOG("Electronic Warfare - Extend Shutdown Turns: (EventSource) Target Unit" @ TargetUnit.GetFullName() @ "(" $ TargetUnit.ObjectID $ ")", bLog);

	// Check that the SourceUnit is the Expected SourceUnit
	if (ExpectedSourceUnit.ObjectID != SourceUnit.ObjectID)
	{
		`LOG("Electronic Warfare - Extend Shutdown Turns: event does not originate from Expected SourceUnit.", bLog);
		return ELR_NoInterrupt;
	}

	// TargetUnit must be Robotic
	if (!TargetUnit.IsRobotic())
	{
		`LOG("Electronic Warfare - Extend Shutdown Turns: TargetUnit is not a mechanical unit.", bLog);
		return ELR_NoInterrupt;
	}

	// Trigger effect that will apply the additional stun effect
	`LOG("Electronic Warfare - Extend Shutdown Turns: Triggering extended stun effect.", bLog);
	TargetUnit.StunnedActionPoints++;
	NewGameState.GetContext().PostBuildVisualizationFn.AddItem(ExtendedShutdown_BuildVisualization);

	return ELR_NoInterrupt;
}

simulated function ExtendedShutdown_BuildVisualization(XComGameState VisualizeGameState)
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
	AbilityTemplate = AbilityTemplateMgr.FindAbilityTemplate('WOTC_APA_ElectronicWarfare');
	AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	TargetUnitRef = AbilityContext.InputContext.PrimaryTarget;

	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(TargetUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(TargetUnitRef.ObjectID);
	if (ActionMetadata.StateObject_NewState == none)
		ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
	ActionMetadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(TargetUnitRef.ObjectID);
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, default.strExtendedShutdownTurnsFlyover, '', eColor_Good, AbilityTemplate.IconImage, `DEFAULTFLYOVERLOOKATTIME);
}


DefaultProperties
{
	DuplicateResponse=eDupe_Ignore
	EffectName = "WOTC_APA_ExtendedShutdownEffect"
}