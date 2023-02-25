
class X2Effect_WOTC_APA_PartialMovementMobilityPenalty extends X2Effect_PersistentStatChange;

var float fModifier;

// Register for the UnitMovedFinished Event Trigger
function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager						EventManager;
	local Object								EffectObj, TargetObj;
	local bool									bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	EventManager = `XEVENTMGR;
	EffectObj = EffectGameState;
	TargetObj = `XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID);

	EventManager.RegisterForEvent(EffectObj, 'UnitMoveFinished', RemoveEffectOnMove, ELD_OnStateSubmitted,,TargetObj,, EffectObj);
	`LOG("On Move Finished - Registered Event Listener for" @ XComGameState_Unit(TargetObj).GetFullName(), bLog);
}

// Remove the effect when the unit moves
static function EventListenerReturn RemoveEffectOnMove(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Effect					EffectState;
	local XComGameStateContext_EffectRemoved	EffectRemovedContext;
	local XComGameState							EffectRemovedGameState;
	local bool									bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	`LOG("UnitMoveFinished - Event Fired", bLog);

	EffectState = XComGameState_Effect(CallbackData);

	EffectRemovedContext = class'XComGameStateContext_EffectRemoved'.static.CreateEffectRemovedContext(EffectState);	
	EffectRemovedGameState = `XCOMHISTORY.CreateNewGameState(true, EffectRemovedContext);
	EffectState.RemoveEffect(EffectRemovedGameState, EffectRemovedGameState);		
	`TACTICALRULES.SubmitGameState(EffectRemovedGameState);	

	`LOG("UnitMoveFinished - Mobility Penalty effect removed", bLog);

	return ELR_NoInterrupt;
}

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit	TargetUnit;
	local int					MobilityModifier;

	m_aStatChanges.length = 0;

	TargetUnit = XComGameState_Unit(kNewTargetState);
	MobilityModifier = TargetUnit.GetCurrentStat(eStat_Mobility) * fModifier;
	
	if (MobilityModifier > 0)
	{
		AddPersistentStatChange(eStat_Mobility, -MobilityModifier);
	}

	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
}