
class X2Effect_WOTC_APA_Class_StatChangeUntilMovement extends X2Effect_PersistentStatChange;

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

//Only one set of stat effects are allowed to apply to a target.
function bool UniqueToHitModifiers() { return true; }


// Remove the Braced effect when the unit moves (or falls)
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

	`LOG("UnitMoveFinished - Braced effect removed", bLog);

	return ELR_NoInterrupt;
}


defaultproperties
{
	bRemoveWhenSourceDies=true
}