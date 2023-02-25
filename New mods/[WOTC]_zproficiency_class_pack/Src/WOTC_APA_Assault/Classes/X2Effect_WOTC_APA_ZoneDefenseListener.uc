
class X2Effect_WOTC_APA_ZoneDefenseListener extends X2Effect_Persistent;

var name WOTC_APA_ZoneDefense_TriggeredName;


// Register for the AbilityActivated Event Trigger
function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager				EventManager;
	local Object						EffectObj, TargetObj;
	local XComGameState_Unit			SourceUnit, TargetUnit;
	local bool							bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	
	// Register for the Event Trigger
	EventManager = `XEVENTMGR;
	EffectObj = EffectGameState;
	TargetObj = TargetUnit;

	EventManager.RegisterForEvent(EffectObj, 'AbilityActivated', ZoneDefense_CheckForOverwatch, ELD_OnStateSubmitted,,,, TargetObj);
	`LOG("WOTC_APA_ZoneDefense - Registered Event Listener for" @ XComGameState_Unit(TargetObj).GetFullName(), bLog);
}


static function EventListenerReturn ZoneDefense_CheckForOverwatch(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Unit		TargetUnit, ExpectedTargetUnit;
	local XComGameState_Ability		AbilityState;
	local X2AbilityTemplate			AbilityTemplate;
	local bool						bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	// Check that the ability being activated is an overwatch ability
	AbilityState = XComGameState_Ability(EventData);
	AbilityTemplate = AbilityState.GetMyTemplate();
	if (AbilityTemplate.CinescriptCameraType != "Overwatch") // seems to cover all relevant cases...
	{
		return ELR_NoInterrupt;
	}	

	// Get the Expected TargetUnit
	ExpectedTargetUnit = XComGameState_Unit(CallbackData);

	// Get the Actual TargetUnit
	TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(XComGameStateContext_Ability(NewGameState.GetContext()).InputContext.PrimaryTarget.ObjectID));
	
	// Check that the TargetUnit is the Expected TargetUnit
	if (ExpectedTargetUnit.ObjectID != TargetUnit.ObjectID)
	{
		return ELR_NoInterrupt;
	}
		
	// Trigger the effect that enables Zone Defense shots for the turn
	`XEVENTMGR.TriggerEvent(default.WOTC_APA_ZoneDefense_TriggeredName, TargetUnit, TargetUnit, NewGameState);
	return ELR_NoInterrupt;
}


DefaultProperties
{
	WOTC_APA_ZoneDefense_TriggeredName = "WOTC_APA_ZoneDefense_Triggered"
}