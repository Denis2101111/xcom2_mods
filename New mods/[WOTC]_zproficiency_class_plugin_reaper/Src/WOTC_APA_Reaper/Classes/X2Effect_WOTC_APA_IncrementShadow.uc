
class X2Effect_WOTC_APA_IncrementShadow extends X2Effect_Persistent;

// Register for the UnitConcealmentBroken Event Trigger
function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager						EventManager;
	local Object								EffectObj;
	local XComGameState_Unit					SourceUnit;

	EventManager = `XEVENTMGR;
	EffectObj = EffectGameState;
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));

	EventManager.RegisterForEvent(EffectObj, 'UnitConcealmentBroken', RemoveCurrentStacksOnReveal, ELD_OnStateSubmitted,, SourceUnit,, EffectObj);
}

static function EventListenerReturn RemoveCurrentStacksOnReveal(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
	local XComGameState_Unit TargetUnitState;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;

	TargetUnitState = XComGameState_Unit(History.GetGameStateForObjectID(XComGameState_Effect(CallbackData).ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	if (TargetUnitState != none && !TargetUnitState.IsConcealed())
	{
		TargetUnitState.SetUnitFloatValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CURRENT_NAME, 0, eCleanup_BeginTactical);
	}

	return ELR_NoInterrupt;
}


function bool IncrementShadowStacks(X2Effect_Persistent PersistentEffect, const out EffectAppliedData ApplyEffectParameters, XComGameState_Effect kNewEffectState, XComGameState NewGameState, bool FirstApplication)
{
	local XComGameState_Unit						OldTargetState, NewTargetState;
	local UnitValue									ShadowStacksValue;
	local int										CurrentStacks, MaxStacks;
	local bool										bValueChanged;
	
	OldTargetState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));

	// Do nothing if the unit is not concealed
	if (!OldTargetState.IsConcealed())
		return false;

	// Get current/max Shadow Stack unit values
	OldTargetState.GetUnitValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_MAX_NAME, ShadowStacksValue);
	MaxStacks = ShadowStacksValue.fValue;

	OldTargetState.GetUnitValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CURRENT_NAME, ShadowStacksValue);
	CurrentStacks = ShadowStacksValue.fValue;	

	// Increment Shadow Stacks value by per-turn gain and bonus from Hunkering
	if (CurrentStacks < MaxStacks)
	{
		CurrentStacks += class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_GAIN_PER_TURN;
		bValueChanged = true;

		if (OldTargetState.AffectedByEffectNames.Find('WOTC_APA_Shadow_HunkeredDownTracker') != -1)
		{
			CurrentStacks += class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_GAIN_HUNKER;
	}	}

	// Cap Shadow Stacks back down to max if we somehow exceeded it
	if (CurrentStacks > MaxStacks)
	{
		CurrentStacks = MaxStacks;
		bValueChanged = true;
	}

	if (bValueChanged)
	{
		ShadowStacksValue.fValue = CurrentStacks;
		NewTargetState = XComGameState_Unit(NewGameState.ModifyStateObject(OldTargetState.Class, OldTargetState.ObjectID));
		NewTargetState.SetUnitFloatValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CURRENT_NAME, ShadowStacksValue.fValue, eCleanup_BeginTactical);
		`XEVENTMGR.TriggerEvent('WOTC_APA_IncrementShadowTick', NewTargetState, NewTargetState, NewGameState);
	}	

	return false;
}


function bool RetainIndividualConcealment(XComGameState_Effect EffectState, XComGameState_Unit UnitState)
{
	return true;
}



defaultproperties
{
	EffectTickedFn = IncrementShadowStacks
}