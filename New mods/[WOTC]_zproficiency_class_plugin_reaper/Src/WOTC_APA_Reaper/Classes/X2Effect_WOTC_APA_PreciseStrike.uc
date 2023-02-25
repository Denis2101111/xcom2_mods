
class X2Effect_WOTC_APA_PreciseStrike extends X2Effect_Persistent;


function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local X2AbilityToHitCalc_StandardAim	StandardAim;
	local GameRulesCache_VisibilityInfo		VisInfo;
	local int								Modifier;
	local UnitValue							ShadowStacksValue;
	local ShotModifierInfo					ShotMod;

	if (!Attacker.IsConcealed())
		return;

	Modifier = 0;

	StandardAim = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
	if (StandardAim != none && !StandardAim.bIgnoreCoverBonus && !StandardAim.bIndirectFire)
	{
		if (`TACTICALRULES.VisibilityMgr.GetVisibilityInfo(Attacker.ObjectID, Target.ObjectID, VisInfo))
		{
			if (Target.CanTakeCover())
			{
				switch (VisInfo.TargetCover)
				{
					case CT_None: // no cover
						break;
					case CT_MidLevel: //  half cover
						Modifier = class'X2AbilityToHitCalc_StandardAim'.default.LOW_COVER_BONUS;
						break;
					case CT_Standing: //  full cover
						Modifier = class'X2AbilityToHitCalc_StandardAim'.default.HIGH_COVER_BONUS;
						break;

					default:
						break;
	}	}	}	}
	
	if (Modifier > 0)
	{
		Attacker.GetUnitValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CURRENT_NAME, ShadowStacksValue);

		if (ShadowStacksValue.fValue >= class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_VALUE_THRESHOLD_III)
			Modifier = class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.PRECISE_STRIKE_COVER_AIM_BONUS_III;
		else if (ShadowStacksValue.fValue >= class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_VALUE_THRESHOLD_II)
			Modifier = class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.PRECISE_STRIKE_COVER_AIM_BONUS_II;
		else if (ShadowStacksValue.fValue >= class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_VALUE_THRESHOLD_I)
			Modifier = class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.PRECISE_STRIKE_COVER_AIM_BONUS_I;

		ShotMod.ModType = eHit_Success;
		ShotMod.Value = Modifier;
		ShotMod.Reason = FriendlyName;
		ShotModifiers.AddItem(ShotMod);

		ShotMod.ModType = eHit_Crit;
		ShotMod.Value = Modifier;
		ShotMod.Reason = FriendlyName;
		ShotModifiers.AddItem(ShotMod);
	}
}