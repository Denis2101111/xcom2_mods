class X2Effect_WOTC_APA_LockedOn extends X2Effect_Persistent;


function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager EventMgr;
	local Object EffectObj;

	EventMgr = `XEVENTMGR;
	EffectObj = EffectGameState;
	EventMgr.RegisterForEvent(EffectObj, 'AbilityActivated', EffectGameState.ZeroInListener, ELD_OnStateSubmitted, , `XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
}


function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local XComGameState_Item SourceWeapon;
	local ShotModifierInfo ShotMod;
	local UnitValue ShotsValue, TargetValue;

	SourceWeapon = AbilityState.GetSourceWeapon();
	if (SourceWeapon != none && !bIndirectFire)
	{
		Attacker.GetUnitValue('ZeroInShots', ShotsValue);
		Attacker.GetUnitValue('ZeroInTarget', TargetValue);
		
		if (ShotsValue.fValue > 0 && TargetValue.fValue == Target.ObjectID)
		{
			ShotMod.ModType = eHit_Success;
			ShotMod.Reason = FriendlyName;
			ShotMod.Value = class'X2Ability_WOTC_APA_MarineAbilitySet'.default.LOCKEDON_AIM_BONUS;
			ShotModifiers.AddItem(ShotMod);

			ShotMod.ModType = eHit_Crit;
			ShotMod.Reason = FriendlyName;
			ShotMod.Value = class'X2Ability_WOTC_APA_MarineAbilitySet'.default.LOCKEDON_CRIT_BONUS;
			ShotModifiers.AddItem(ShotMod);
		}
	}
}

defaultproperties
{
    DuplicateResponse=eDupe_Ignore
}

