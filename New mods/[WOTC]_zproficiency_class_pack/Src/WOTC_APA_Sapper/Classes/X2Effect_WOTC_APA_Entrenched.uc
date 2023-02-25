
class X2Effect_WOTC_APA_Entrenched extends X2Effect_Persistent;


// Crit immunity when shot through full cover
function bool ChangeHitResultForTarget(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit TargetUnit, XComGameState_Ability AbilityState, bool bIsPrimaryTarget, const EAbilityHitResult CurrentResult, out EAbilityHitResult NewHitResult)
{
	local GameRulesCache_VisibilityInfo		VisInfo;

	if (`TACTICALRULES.VisibilityMgr.GetVisibilityInfo(Attacker.ObjectID, TargetUnit.ObjectID, VisInfo))
	{
		if (VisInfo.TargetCover == CT_Standing && CurrentResult == eHit_Crit)
		{
			NewHitResult = eHit_Success;
			return true;
		}
	}

	return false;
}


// Damage Reduction when shot through full cover
function int GetDefendingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, X2Effect_ApplyWeaponDamage WeaponDamageEffect, optional XComGameState NewGameState)
{
	local XComGameState_Unit				TargetUnit;
	local GameRulesCache_VisibilityInfo		VisInfo;

	if (CurrentDamage > 0)
	{
		TargetUnit = XComGameState_Unit(TargetDamageable);
		if (`TACTICALRULES.VisibilityMgr.GetVisibilityInfo(Attacker.ObjectID, TargetUnit.ObjectID, VisInfo))
		{
			if (VisInfo.TargetCover == CT_Standing)
			{
				if (CurrentDamage < -class'X2Ability_WOTC_APA_SapperAbilitySet'.default.ENTRENCHED_DAMAGE_REDUCTION)
					return -CurrentDamage;
				else
					return class'X2Ability_WOTC_APA_SapperAbilitySet'.default.ENTRENCHED_DAMAGE_REDUCTION;
	}	}	}

	return 0;
}





DefaultProperties
{
	DuplicateResponse = eDupe_Ignore
	bDisplayInSpecialDamageMessageUI = true
}