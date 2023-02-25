
class X2Effect_WOTC_APA_ShadowConditionalBonuses extends X2Effect_PersistentStatChange;


function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local XComGameState_Unit UnitState;
	local X2EventManager EventMgr;
	local Object ListenerObj;

	EventMgr = `XEVENTMGR;

	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));

	ListenerObj = EffectGameState;

	// Register to tick after EVERY action.
	//EventMgr.RegisterForEvent(ListenerObj, 'EffectEnterUnitConcealment', UpdateEffects, ELD_OnStateSubmitted, 20, UnitState,, EffectGameState);
	EventMgr.RegisterForEvent(ListenerObj, 'AbilityActivated', UpdateEffects, ELD_OnStateSubmitted, 20, UnitState,, EffectGameState);
	EventMgr.RegisterForEvent(ListenerObj, 'WOTC_APA_IncrementShadowTick', UpdateEffects, ELD_OnStateSubmitted, 20, UnitState,, EffectGameState);
	EventMgr.RegisterForEvent(ListenerObj, 'UnitConcealmentEntered', UpdateEffects, ELD_OnStateSubmitted, 20, UnitState,, EffectGameState);
	EventMgr.RegisterForEvent(ListenerObj, 'UnitConcealmentBroken', RemoveEffects, ELD_OnStateSubmitted, 20, UnitState,, EffectGameState);
}


static function EventListenerReturn UpdateEffects(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameState_Unit			UnitState, PreviousUnitState, NewUnitState;
	local XComGameState_Effect			EffectState, NewEffectState;
	local XComGameState					NewGameState;
	local StatChange					NewStatChange;
	local UnitValue						ShadowStacksValue, PreviousShadowStacksValue;
	local float							fValue;
	local int							iValue;

	EffectState = XComGameState_Effect(CallbackData);
	if (EffectState == none)
		return ELR_NoInterrupt;

	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));

	if (!UnitState.IsConcealed())
		return ELR_NoInterrupt;

	PreviousUnitState = XComGameState_Unit(`XCOMHISTORY.GetPreviousGameStateForObject(UnitState));
	UnitState.GetUnitValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CURRENT_NAME, ShadowStacksValue);
	PreviousUnitState.GetUnitValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CURRENT_NAME, PreviousShadowStacksValue);
	
	if (ShadowStacksValue.fValue == PreviousShadowStacksValue.fValue && UnitState.IsConcealed() == PreviousUnitState.IsConcealed())
		return ELR_NoInterrupt;

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Conditional Stat Change");
	NewUnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', UnitState.ObjectID));
	NewUnitState.UnApplyEffectFromStats(EffectState, NewGameState);

	EffectState.StatChanges.Length = 0;
	NewEffectState = XComGameState_Effect(NewGameState.ModifyStateObject(class'XComGameState_Effect', EffectState.ObjectID));

	NewStatChange.StatType = eStat_DetectionModifier;
	NewStatChange.StatAmount = (ShadowStacksValue.fValue * class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_VARIABLE_DETECTION_BONUS);
	NewStatChange.ModOp = MODOP_Addition;
	NewEffectState.StatChanges.AddItem(NewStatChange);

	if (UnitState.AffectedByEffectNames.Find('WOTC_APA_Hound') != -1)
	{
		if (ShadowStacksValue.fValue >= class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_VALUE_THRESHOLD_I)
			iValue = class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.HOUND_MOBILITY_BONUS_I;

		if (ShadowStacksValue.fValue >= class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_VALUE_THRESHOLD_II)
			iValue = class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.HOUND_MOBILITY_BONUS_II;

		if (ShadowStacksValue.fValue >= class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_VALUE_THRESHOLD_III)
			iValue = class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.HOUND_MOBILITY_BONUS_III;

		NewStatChange.StatType = eStat_Mobility;
		NewStatChange.StatAmount = iValue;
		NewStatChange.ModOp = MODOP_Addition;
		NewEffectState.StatChanges.AddItem(NewStatChange);
	}

	NewUnitState.ApplyEffectToStats(NewEffectState, NewGameState);
	`GAMERULES.SubmitGameState(NewGameState);
	
	return ELR_NoInterrupt;
}


static function EventListenerReturn RemoveEffects(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameState_Unit			UnitState, NewUnitState;
	local XComGameState_Effect			EffectState, NewEffectState;
	local XComGameState					NewGameState;

	EffectState = XComGameState_Effect(CallbackData);
	if (EffectState == none)
		return ELR_NoInterrupt;
		
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Conditional Stat Change");
	NewUnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', UnitState.ObjectID));
	
	NewUnitState.UnApplyEffectFromStats(EffectState, NewGameState);
	`GAMERULES.SubmitGameState(NewGameState);
	
	return ELR_NoInterrupt;
}


function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local XComGameState_Item	SourceWeapon;
	local ShotModifierInfo		ShotInfo;
	local UnitValue				ShadowStacksValue;
	local int					BonusAmount;

	if (Attacker.IsImpaired(false) || Attacker.IsBurning() || Attacker.IsPanicked())
		return;

	SourceWeapon = AbilityState.GetSourceWeapon();
	if (SourceWeapon != none && !bIndirectFire)
	{
		Attacker.GetUnitValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CURRENT_NAME, ShadowStacksValue);
		BonusAmount = class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CRIT_CHANCE_BONUS * ShadowStacksValue.fValue;

		if (BonusAmount > 0)
		{
			ShotInfo.ModType = eHit_Crit;
			ShotInfo.Reason = FriendlyName;
			ShotInfo.Value = BonusAmount;
			ShotModifiers.AddItem(ShotInfo);
		}
	}
}