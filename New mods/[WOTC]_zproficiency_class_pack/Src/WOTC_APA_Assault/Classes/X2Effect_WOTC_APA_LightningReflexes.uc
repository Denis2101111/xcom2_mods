class X2Effect_WOTC_APA_LightningReflexes extends X2Effect_Persistent;

var int HitMod;


function GetToHitAsTargetModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local X2AbilityToHitCalc_StandardAim	StandardAim;
	local ShotModifierInfo					ShotMod;

	StandardAim = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
	if (StandardAim != none && StandardAim.bReactionFire)
	{
		ShotMod.ModType = eHit_Success;
		ShotMod.Value = HitMod;
		ShotMod.Reason = FriendlyName;
		ShotModifiers.AddItem(ShotMod);
	}
}


function bool ReflexesEffectTicked(X2Effect_Persistent PersistentEffect, const out EffectAppliedData ApplyEffectParameters, XComGameState_Effect kNewEffectState, XComGameState NewGameState, bool FirstApplication)
{
	local XComGameState_Unit SourceUnit, NewSourceUnit;

	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	if (SourceUnit != none)
	{
		if (!SourceUnit.bLightningReflexes)
		{
			NewSourceUnit = XComGameState_Unit(NewGameState.ModifyStateObject(SourceUnit.Class, SourceUnit.ObjectID));
			NewSourceUnit.bLightningReflexes = true;
		}
	}

	return false;           //  do not end the effect
}



DefaultProperties
{
	DuplicateResponse = eDupe_Refresh
	EffectTickedFn = ReflexesEffectTicked
}