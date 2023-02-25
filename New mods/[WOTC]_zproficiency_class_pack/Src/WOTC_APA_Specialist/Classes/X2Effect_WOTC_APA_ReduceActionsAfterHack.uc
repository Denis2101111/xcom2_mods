
class X2Effect_WOTC_APA_ReduceActionsAfterHack extends X2Effect_Persistent;

var localized string	strReduceActionsAfterHackFlyover;


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

	EventManager.RegisterForEvent(EffectObj, 'UnitChangedTeam', RemoveAction, ELD_OnStateSubmitted,,,, EffectObj);
	`LOG("Electronic Warfare - Reduce Actions After Hack: Registered Event Listener for" @ XComGameState_Unit(TargetObj).GetFullName(), bLog);
}


// Remvoe action point from enemies after a control hack wears off and grant a movement-only action they turn the source gains control
static function EventListenerReturn RemoveAction(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Unit		TargetUnit, SourceUnit, ExpectedTargetUnit;
	local XComGameState_Effect		EffectState;
	local XComGameState				ModifiedGameState;
	local bool						bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	`LOG("Electronic Warfare - Reduce Actions After Hack - Event Fired", bLog);

	// Get the Expected TargetUnit
	EffectState = XComGameState_Effect(CallbackData);
	ExpectedTargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	`LOG("Electronic Warfare - Reduce Actions After Hack: Expected(CallbackData) Target Unit" @ ExpectedTargetUnit.GetFullName() @ "(" $ ExpectedTargetUnit.ObjectID $ ")", bLog);

	// Get the Target Unit that actually triggered the event
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	`LOG("Electronic Warfare - Reduce Actions After Hack: AbilityContext(NewGameState) Source Unit" @ SourceUnit.GetFullName(), bLog);

	TargetUnit = XComGameState_Unit(EventData);
	`LOG("Electronic Warfare - Reduce Actions After Hack: AbilityContext(NewGameState) Target Unit" @ TargetUnit.GetFullName() @ "(" $ TargetUnit.ObjectID $ ")", bLog);

	// Check that the TargetUnit is the Expected TargetUnit
	if (ExpectedTargetUnit.ObjectID != TargetUnit.ObjectID)
	{
		`LOG("Electronic Warfare - Reduce Actions After Hack: event does not originate from Expected TargetUnit.", bLog);
		return ELR_NoInterrupt;
	}

	// SourceUnit must have the Electronic Warfare effect
	if (SourceUnit.AffectedByEffectNames.Find('WOTC_APA_ReduceActionsAfterHackEffect') == -1)
	{
		`LOG("Electronic Warfare - Reduce Actions After Hack: SourceUnit does not have the appropriate effect.", bLog);
		return ELR_NoInterrupt;
	}

	// Change actionpoints for controlling hacks start and finish
	if (SourceUnit.ControllingPlayer.ObjectID == TargetUnit.ControllingPlayer.ObjectID)
	{
		`LOG("Electronic Warfare - Reduce Actions After Hack: Do not apply to initial team transfer.", bLog);
		return ELR_NoInterrupt;
	}

	`LOG("Electronic Warfare - Reduce Actions After Hack: Expected Target found, Modifying Action Points.", bLog);
	//ModifiedGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Electronic Warfare - Reduce Actions After Hack");
	//TargetUnit = XComGameState_Unit(ModifiedGameState.ModifyStateObject(class'XComGameState_Unit', TargetUnit.ObjectID));
	TargetUnit.ActionPoints.Length = 0;
	TargetUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);
	//XComGameStateContext_ChangeContainer(ModifiedGameState.GetContext()).PostBuildVisualizationFn.AddItem(ReducedActions_BuildVisualization);
	//`TACTICALRULES.SubmitGameState(ModifiedGameState);

	// Remove this effect once the hack has completed
	EffectState.RemoveEffect(NewGameState, NewGameState);

	return ELR_NoInterrupt;
}


simulated function ReducedActions_BuildVisualization(XComGameState VisualizeGameState)
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
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, default.strReduceActionsAfterHackFlyover, '', eColor_Good, AbilityTemplate.IconImage, `DEFAULTFLYOVERLOOKATTIME);
}


DefaultProperties
{
	DuplicateResponse=eDupe_Ignore
	EffectName = "WOTC_APA_ElectronicWarfareActionPointEffect"
}