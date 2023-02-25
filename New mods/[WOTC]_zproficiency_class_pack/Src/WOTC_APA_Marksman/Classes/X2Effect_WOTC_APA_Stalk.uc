
class X2Effect_WOTC_APA_Stalk extends X2Effect_PersistentStatChange;

// Register for the UnitConcealmentBroken Event Trigger
function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager						EventManager;
	local Object								EffectObj, TargetObj;
	local bool									bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	EventManager = `XEVENTMGR;
	EffectObj = EffectGameState;
	TargetObj = `XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID);

	EventManager.RegisterForEvent(EffectObj, 'UnitConcealmentBroken', RemoveEffectOnReveal, ELD_OnStateSubmitted,,,, EffectObj);
	`LOG("On Lose Concealment - Registered Event Listener for" @ XComGameState_Unit(TargetObj).GetFullName(), bLog);
}


// Remove this Detection Modifier when unit concealment is lost (so it is reset if the unit regains concealment)
static function EventListenerReturn RemoveEffectOnReveal(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Unit					SourceUnit, ExpectedSourceUnit;
	local XComGameState_Effect					EffectState;
	local bool									bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	`LOG("UnitConcealmentBroken - Event Fired", bLog);

	// Get the Expected SourceUnit
	EffectState = XComGameState_Effect(CallbackData);
	ExpectedSourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	`LOG("WOTC_APA_Marksman - RemoveStalkEffectOnReveal: Expected(CallbackData) Source Unit" @ ExpectedSourceUnit.GetFullName(), bLog);

	// Get the Source Units for the Event
	SourceUnit = XComGameState_Unit(EventSource);
	`LOG("WOTC_APA_Marksman - RemoveStalkEffectOnReveal: (EventSource)Source Unit" @ SourceUnit.GetFullName(), bLog);

	// Check that the SourceUnit is the Expected SourceUnit
	if (ExpectedSourceUnit.ObjectID != SourceUnit.ObjectID)
	{
		`LOG("WOTC_APA_Marksman - RemoveStalkEffectOnReveal: Event does not originate from Expected SourceUnit.", bLog);
		return ELR_NoInterrupt;
	}
	`LOG("WOTC_APA_Marksman - RemoveStalkEffectOnReveal: Expected SourceUnit found.", bLog);
	
	// Remove the Detection Modifier penalty effect
	EffectState.RemoveEffect(NewGameState, NewGameState);

	return ELR_NoInterrupt;
}


defaultproperties
{
	bRemoveWhenSourceDies=true
}