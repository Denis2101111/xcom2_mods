
class X2Effect_WOTC_APA_SteadyHands extends X2Effect_ToHitModifier;


// Register for the UnitMovedFinished Event Trigger
function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager						EventManager;
	local Object								EffectObj, TargetObj;

	EventManager = `XEVENTMGR;
	EffectObj = EffectGameState;
	TargetObj = `XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID);

	EventManager.RegisterForEvent(EffectObj, 'UnitMoveFinished', RemoveEffectOnMove, ELD_OnStateSubmitted,,TargetObj,, EffectObj);
}


function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState) 
{
	local XComGameState_Item				SlotItem1, SlotItem2;
	local bool								bSourceIsSlotItem;
	local X2AbilityToHitCalc_StandardAim	StandardHit;
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

	// Attack must be a Critical Hit
	if (AppliedData.AbilityResultContext.HitResult == eHit_Crit)
	{
		// Attack must come from Primary or Secondary weapons
		SlotItem1 = Attacker.GetItemInSlot(eInvSlot_PrimaryWeapon);
		SlotItem2 = Attacker.GetItemInSlot(eInvSlot_SecondaryWeapon);
		if (AbilityState.SourceWeapon == SlotItem1.GetReference() || AbilityState.SourceWeapon == SlotItem2.GetReference())
		{
			return class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.STEADY_HANDS_CRIT_DAMAGE_BONUS;
	}	}

	return 0;
}


// Only one set of stat effects are allowed to apply to a target.
function bool UniqueToHitModifiers() { return true; }


// Remove the effect when the unit moves (or falls)
static function EventListenerReturn RemoveEffectOnMove(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Effect					EffectState;
	local XComGameStateContext_EffectRemoved	EffectRemovedContext;
	local XComGameState							EffectRemovedGameState;
	
	EffectState = XComGameState_Effect(CallbackData);

	EffectRemovedContext = class'XComGameStateContext_EffectRemoved'.static.CreateEffectRemovedContext(EffectState);	
	EffectRemovedGameState = `XCOMHISTORY.CreateNewGameState(true, EffectRemovedContext);
	EffectState.RemoveEffect(EffectRemovedGameState, EffectRemovedGameState);
	`TACTICALRULES.SubmitGameState(EffectRemovedGameState);

	return ELR_NoInterrupt;
}





defaultproperties
{
	bRemoveWhenSourceDies=true
}