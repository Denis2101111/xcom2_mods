
class X2Effect_WOTC_APA_Aggression extends X2Effect_Persistent;


function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local XComGameState_Item	SourceWeapon;
	local ShotModifierInfo		ShotInfo;
	local int					Enemies;

	if (Target.IsImpaired(false) || Target.IsBurning() || Target.IsPanicked())
		return;

	SourceWeapon = AbilityState.GetSourceWeapon();
	if (SourceWeapon != none && SourceWeapon.InventorySlot == eInvSlot_PrimaryWeapon && !bIndirectFire)
	{		
		Enemies = Target.GetNumVisibleEnemyUnits (true, false, false, -1, false, false, false);
		if (Enemies > 0)
		{
			ShotInfo.ModType = eHit_Crit;
			ShotInfo.Reason = FriendlyName;
			ShotInfo.Value = Clamp(Enemies * class'X2Ability_WOTC_APA_MarineAbilitySet'.default.AGGRESSION_CRIT_CHANCE_PER_ENEMY, 0, class'X2Ability_WOTC_APA_MarineAbilitySet'.default.AGGRESSION_CRIT_CHANCE_CAP);
			ShotModifiers.AddItem(ShotInfo);
		}
	}
}


defaultproperties
{
    DuplicateResponse = eDupe_Ignore
    EffectName = "WOTC_APA_AggressionOnEffect"
}