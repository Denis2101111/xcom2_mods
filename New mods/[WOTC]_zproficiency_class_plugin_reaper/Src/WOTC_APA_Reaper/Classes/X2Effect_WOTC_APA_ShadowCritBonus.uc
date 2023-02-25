
class X2Effect_WOTC_APA_ShadowCritBonus extends X2Effect_Persistent;


function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local XComGameState_Item	SourceWeapon;
	local ShotModifierInfo		ShotInfo;
	local UnitValue				ShadowStacksValue;
	local int					BonusAmount;

	if (Target.IsImpaired(false) || Target.IsBurning() || Target.IsPanicked())
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


defaultproperties
{
    DuplicateResponse = eDupe_Ignore
    EffectName = "WOTC_APA_ShadowCritBonusEffect"
}