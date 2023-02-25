
class X2Effect_WOTC_APA_ShadowReconceal extends X2Effect_PersistentStatChange;


function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local XComGameState_Unit UnitState;
	local X2EventManager EventMgr;
	local Object ListenerObj;

	EventMgr = `XEVENTMGR;

	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));

	ListenerObj = EffectGameState;

	EventMgr.RegisterForEvent(ListenerObj, 'EffectEnterUnitConcealment', EventHandler, ELD_OnStateSubmitted, 25, UnitState,, EffectGameState);
}

static function EventListenerReturn EventHandler(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameState_Unit			UnitState, NewUnitState;
	local XComGameState_Effect			NewEffectState;
	local XComGameState					NewGameState;
	local XComGameState_Effect			EffectState;
	local StatChange					NewStatChange;
	local UnitValue						ShadowStacksValue, ShadowStacksMax;
	local int							iValue;

	EffectState = XComGameState_Effect(CallbackData);
	if (EffectState == none)
		return ELR_NoInterrupt;

	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	UnitState.GetUnitValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CURRENT_NAME, ShadowStacksValue);
	UnitState.GetUnitValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_MAX_NAME, ShadowStacksMax);

	iValue = Min(ShadowStacksMax.fValue, ShadowStacksValue.fValue + class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.INFILTRATION_RECONCEAL_SHADOW_STACKS);
	
	//UnitState.SetUnitFloatValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CURRENT_NAME, iValue, eCleanup_BeginTactical);

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Add Reconceal Shadow Stacks");
	NewUnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', UnitState.ObjectID));
	NewUnitState.SetUnitFloatValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CURRENT_NAME, iValue, eCleanup_BeginTactical);
	
	`GAMERULES.SubmitGameState(NewGameState);	
	return ELR_NoInterrupt;
}