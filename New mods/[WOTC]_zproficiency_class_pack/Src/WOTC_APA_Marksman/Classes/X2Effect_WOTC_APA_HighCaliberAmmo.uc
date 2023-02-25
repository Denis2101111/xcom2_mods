
class X2Effect_WOTC_APA_HighCaliberAmmo extends X2Effect_Persistent;


function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager EventMgr;
	local Object EffectObj;
	local XComGameState_Unit EffectTargetUnit;
	local XComGameState_Item EffectTargetItem;

	EventMgr = `XEVENTMGR;
	EffectObj = EffectGameState;
	EffectTargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	EffectTargetItem = EffectTargetUnit.GetPrimaryWeapon();

	EventMgr.RegisterForEvent(EffectObj, 'OverrideClipsize', OnOverrideClipsize, ELD_Immediate,,,, EffectTargetItem);
}


// EventListenerReturn function to modify weapon ammo count each time GetClipSize() is called (reloads, etc.)
static function EventListenerReturn OnOverrideClipsize(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComLWTuple			OverrideTuple;
	local bool					bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	OverrideTuple = XComLWTuple(EventData);
	if (OverrideTuple == none)
		return ELR_NoInterrupt;

	if (OverrideTuple.Id != 'OverrideClipSize')
		return ELR_NoInterrupt;

	if (EventSource != CallbackData)
		return ELR_NoInterrupt;

	/**/`Log("WOTC_APA_Class - HighCaliber: Event Triggered", bLog);
	/**/`Log("WOTC_APA_Class - HighCaliber: EventSource (Item) ID" @ XComGameState_Item(EventSource).ObjectID, bLog);
	/**/`Log("WOTC_APA_Class - HighCaliber: CallbackData (Item) ID" @ XComGameState_Item(CallbackData).ObjectID, bLog);
	/**/`Log("WOTC_APA_Class - HighCaliber: Current Clipsize is" @ OverrideTuple.Data[0].i, bLog);

	OverrideTuple.Data[0].i += class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.HIGH_CALIBER_AMMO_MODIFIER;

	/**/`Log("WOTC_APA_Class - HighCaliber: Modified Clipsize is" @ OverrideTuple.Data[0].i, bLog);

	return ELR_NoInterrupt;
}


defaultproperties
{
	bRemoveWhenSourceDies = true
	bRemoveWhenTargetDies = true
	DuplicateResponse = eDupe_Allow
}