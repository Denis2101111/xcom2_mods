
class X2Effect_WOTC_APA_GhostMelee extends X2Effect_Persistent;

var name WOTC_APA_GhostMeleeDetectionModifier_TriggeredName;

function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager EventMgr;
	local Object EffectObj;
	local XComGameState_BaseObject TargetUnit;

	EffectObj = EffectGameState;
	EventMgr = `XEVENTMGR;

	TargetUnit = `XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID);

	EventMgr.RegisterForEvent(EffectObj, 'AbilityActivated', ModifyMeleeDetection, ELD_Immediate,, TargetUnit,, TargetUnit);
}

static function EventListenerReturn ModifyMeleeDetection(Object EventData, Object EventSource, XComGameState GameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Unit					SourceUnit;
	local XComGameState_Unit					TargetUnit;
	local XComGameState_Ability					AbilityState;
	local X2AbilityTemplate						AbilityTemplate;
	local XComGameStateContext_Ability			AbilityContext;
	local bool									bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	// Expected source unit must still be concealed
	SourceUnit = XComGameState_Unit(EventSource);
	if (!SourceUnit.IsConcealed())
		return ELR_NoInterrupt;

	`LOG("Ghost Melee Detection - Source Unit" @ SourceUnit.GetFullName() @ "is Concealed", bLog);

	AbilityState = XComGameState_Ability(EventData);
	if (AbilityState != none)
	{
		AbilityTemplate = AbilityState.GetMyTemplate();
		if (AbilityTemplate.AbilityTargetStyle.IsA('X2AbilityTarget_MovingMelee'))
		{
			AbilityContext = XComGameStateContext_Ability(GameState.GetContext());
			TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));

			`LOG("Ghost Melee Detection - Attack is a moving Melee attack: Triggering modifier for" @ TargetUnit.GetFullName(), bLog);

			`XEVENTMGR.TriggerEvent(default.WOTC_APA_GhostMeleeDetectionModifier_TriggeredName, TargetUnit, SourceUnit, GameState);
	}	}

	return ELR_NoInterrupt;
}

defaultproperties
{
	WOTC_APA_GhostMeleeDetectionModifier_TriggeredName = "WOTC_APA_GhostMeleeDetectionModifier_Triggered"
}