
class X2Effect_WOTC_APA_TacticalSense extends X2Effect_Persistent;


function GetToHitAsTargetModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{

    local ShotModifierInfo	ShotInfo;
	local int				Enemies;

	if (Target.IsImpaired(false) || Target.IsBurning() || Target.IsPanicked())
		return;

	Enemies = Target.GetNumVisibleEnemyUnits (true, false, false, -1, false, false, false);
	if (Enemies > 0)
	{
		ShotInfo.ModType = eHit_Success;
		ShotInfo.Reason = FriendlyName;
		ShotInfo.Value = -1 * (Clamp(Enemies * class'X2Ability_WOTC_APA_MarineAbilitySet'.default.TACTICAL_SENSE_DEFENSE_PER_ENEMY, 0, class'X2Ability_WOTC_APA_MarineAbilitySet'.default.TACTICAL_SENSE_DEFENSE_CAP));
		ShotModifiers.AddItem(ShotInfo);
	}
}


defaultproperties
{
    DuplicateResponse = eDupe_Ignore
    EffectName = "WOTC_APA_TacticalSenseDefense"
}
