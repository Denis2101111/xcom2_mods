
class X2Effect_WOTC_APA_Haunt extends X2Effect_Persistent;

var() int BonusDamage;
var name WOTC_APA_HauntPanic_TriggeredName;


// Register for the UnitConcealmentBroken Event Trigger
function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager						EventManager;
	local Object								EffectObj;
	local XComGameState_Unit					SourceUnit;

	EventManager = `XEVENTMGR;
	EffectObj = EffectGameState;
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));

	EventManager.RegisterForEvent(EffectObj, 'UnitConcealmentBroken', TriggerPanicOnReveal, ELD_Immediate,, SourceUnit,, EffectObj);
}

static function EventListenerReturn TriggerPanicOnReveal(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
	`XEVENTMGR.TriggerEvent(default.WOTC_APA_HauntPanic_TriggeredName, EventData, EventData, GameState);

	return ELR_NoInterrupt;
}


function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	local XComGameState_Unit TargetUnit;
	local UnitValue DamageUnitValue;
	local X2AbilityToHitCalc_StandardAim StandardHit;
	local X2Effect_ApplyWeaponDamage		DamageEffect;

	// Only apply when the damage effect is applying the weapon's base damage
	if (NewGameState != none)
	{
		DamageEffect = X2Effect_ApplyWeaponDamage(class'X2Effect'.static.GetX2Effect(AppliedData.EffectRef));
		if (DamageEffect == none || DamageEffect.bIgnoreBaseDamage)
		{
			return 0;
	}	}

	// Do not apply to actions dealing no damage
	if (!class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult) || CurrentDamage == 0)
		return 0;

	StandardHit = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
	if (StandardHit == none || StandardHit.bIndirectFire)
	{
		return 0;
	}

	if (class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult) && AbilityState.IsAbilityInputTriggered())
	{
		TargetUnit = XComGameState_Unit(TargetDamageable);
		if (TargetUnit != none)
		{
			TargetUnit.GetUnitValue('DamageThisTurn', DamageUnitValue);
			if (DamageUnitValue.fValue > 0)
			{
				return BonusDamage;
	}	}	}
	
	return 0;
}

DefaultProperties
{
	DuplicateResponse = eDupe_Ignore
	bDisplayInSpecialDamageMessageUI = true
	WOTC_APA_HauntPanic_TriggeredName = "WOTC_APA_HauntPanic_Triggered"
}
