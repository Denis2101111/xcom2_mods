
class X2Effect_WOTC_APA_CombatAwareness extends X2Effect_BonusArmor;


function int GetArmorChance(XComGameState_Effect EffectState, XComGameState_Unit UnitState)
{
	if (UnitState.ReserveActionPoints.Length > 0)
	{
		return 100;
	}
	return 0;
}

function int GetArmorMitigation(XComGameState_Effect EffectState, XComGameState_Unit UnitState)
{
	if (UnitState.ReserveActionPoints.Length > 0)
	{
		return class'X2Ability_WOTC_APA_MarineAbilitySet'.default.COMBAT_AWARENESS_ARMOR_BONUS;
	}
	return 0;
}
	
function GetToHitAsTargetModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
    local ShotModifierInfo ShotInfo;

	if (Target.IsImpaired(false) || Target.IsBurning() || Target.IsPanicked())
		return;
	
	if (Target.ReserveActionPoints.Length > 0)
	{
		ShotInfo.ModType = eHit_Success;
		ShotInfo.Reason = FriendlyName;
		ShotInfo.Value = -class'X2Ability_WOTC_APA_MarineAbilitySet'.default.COMBAT_AWARENESS_DEFENSE_BONUS;
		ShotModifiers.AddItem(ShotInfo);
	}
}

defaultproperties
{
    DuplicateResponse=eDupe_Ignore
    EffectName="WOTC_APA_CombatAwareness"
}