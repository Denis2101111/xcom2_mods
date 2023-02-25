
class X2Effect_WOTC_APA_HighApproachAngle extends X2Effect_Persistent;

var float fCoverDefenseMultiplier;


function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local X2AbilityToHitCalc_StandardAim	StandardAim;
	local GameRulesCache_VisibilityInfo		VisInfo;
	local int								Modifier;
	local ShotModifierInfo					ShotMod;

	Modifier = 0;

	// Source must be Braced and have height advantage over the target
	if (Attacker.AffectedByEffectNames.Find('WOTC_APA_Brace_BracedEffect') != -1 || Attacker.AffectedByEffectNames.Find('WOTC_APA_Brace_TempBracedEffect') != -1)
	{
		if (Attacker.HasHeightAdvantageOver(Target, true))
		{
			StandardAim = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
			if (StandardAim != none && !StandardAim.bIgnoreCoverBonus)
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
								Modifier = Round(class'X2AbilityToHitCalc_StandardAim'.default.LOW_COVER_BONUS * fCoverDefenseMultiplier);
								break;
							case CT_Standing: //  full cover
								Modifier = Round(class'X2AbilityToHitCalc_StandardAim'.default.HIGH_COVER_BONUS * fCoverDefenseMultiplier);
								break;

							default:
								break;
		}	}	}	}	}
	
		if (Modifier > 0)
		{		
			ShotMod.ModType = eHit_Success;
			ShotMod.Value = Modifier;
			ShotMod.Reason = FriendlyName;
			ShotModifiers.AddItem(ShotMod);
		}
	}
}


