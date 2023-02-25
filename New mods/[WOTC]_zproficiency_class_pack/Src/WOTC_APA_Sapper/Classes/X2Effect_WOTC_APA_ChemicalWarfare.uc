
class X2Effect_WOTC_APA_ChemicalWarfare extends X2Effect_Persistent;

//var localized string		strChemicalWarfareFlyover;
var name			WOTC_APA_ChemicalWarfare_TriggeredName;


// Register for the ScamperEnd Event Trigger
function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager				EventManager;
	local Object						EffectObj, SourceObj, TargetObj;
	local XComGameState_Unit			SourceUnit, TargetUnit;
	local bool							bShouldApply, bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));

	EventManager = `XEVENTMGR;
	EffectObj = EffectGameState;
	SourceObj = SourceUnit;
	TargetObj = TargetUnit;

	EventManager.RegisterForEvent(EffectObj, 'ScamperEnd', TriggerDelayedStun, ELD_OnStateSubmitted,, TargetObj,, EffectObj);
}


static function EventListenerReturn TriggerDelayedStun(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Unit					TargetUnit, SourceUnit, ExpectedSourceUnit;
	local XComGameState_Effect					EffectState;
	local XComGameStateContext_Ability			AbilityContext;
	local X2Effect_WOTC_APA_ModifyHealAmount	Effect;
	local bool									bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	`LOG("Chemical Warfare Delayed Stun - Event Fired", bLog);

	// Get the SourceUnit
	EffectState = XComGameState_Effect(CallbackData);
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	`LOG("Chemical Warfare Delayed Stun - Source Unit" @ ExpectedSourceUnit.GetFullName(), bLog);

	// Get the TargetUnit
	TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	`LOG("Chemical Warfare Delayed Stun - Target Unit" @ TargetUnit.GetFullName(), bLog);

	// Get the Source and Target Units for the Event
	//SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(CallbackData.ObjectID));
	//AbilityContext = XComGameStateContext_Ability(NewGameState.GetContext());
	//SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID));
	//`LOG("Chemical Warfare Delayed Stun - Source Unit" @ SourceUnit.GetFullName(), bLog);
//
	//TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
	//`LOG("Chemical Warfare Delayed Stun - AbilityContext(NewGameState) Target Unit" @ TargetUnit.GetFullName(), bLog);
//
	//// Check that the SourceUnit is the Expected SourceUnit
	//if (ExpectedSourceUnit.ObjectID != SourceUnit.ObjectID)
	//{
		//`LOG("Chemical Warfare Delayed Stun - Effect does not originate from Expected SourceUnit.", bLog);
		//return ELR_NoInterrupt;
	//}
	//`LOG("Chemical Warfare Delayed Stun - Expected SourceUnit found.", bLog);
	
	// Apply effect to stun the TargetUnit
	`XEVENTMGR.TriggerEvent(default.WOTC_APA_ChemicalWarfare_TriggeredName, TargetUnit, SourceUnit, NewGameState);

	return ELR_NoInterrupt;
}

defaultproperties
{
	WOTC_APA_ChemicalWarfare_TriggeredName = "WOTC_APA_ChemicalWarfare_Triggered"
}