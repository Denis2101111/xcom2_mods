class X2Effect_WOTC_APA_FireDisciplineReactionModifier extends X2Effect_Persistent;

var int		ReactionModifier;
var bool	bCanCrit;

function bool AllowReactionFireCrit(XComGameState_Unit UnitState, XComGameState_Unit TargetState) 
{ 
	return bCanCrit; 
}

function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
    local XComGameState_Item				SourceWeapon;
	local X2WeaponTemplate					WeaponTemplate;
	local X2AbilityToHitCalc_StandardAim	AimCalc;
    local ShotModifierInfo					ShotInfo;
	local bool								bApplyBonus;
	local int								iShotBonus;					

	SourceWeapon = AbilityState.GetSourceWeapon();
	WeaponTemplate = X2WeaponTemplate(SourceWeapon.GetMyTemplate());
	AimCalc = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
	if (SourceWeapon != none && Target != none && AimCalc.bReactionFire == true)
	{
		bApplyBonus = true;

		// Must be a valid Suppression ability if equipped with the cannon and not Emplaced
		if (Attacker.AffectedByEffectNames.Find('WOTC_APA_EmplacedBoost') == -1)
		{
			if (WeaponTemplate.WeaponCat == 'cannon')
			{
				if (class'X2Ability_WOTC_APA_MarineAbilitySet'.default.FIRE_DISCIPLINE_SUPPRESSION_ABILITIES.Find(AbilityState.GetMyTemplateName()) == -1)
				{
					bApplyBonus = false;
	}	}	}	}


	if (bApplyBonus)
	{
		// Divide the expected aim modifier by the reaction shot modifier - this will cancel out when shot gets multiplied by the reaction shot modifier
		iShotBonus = ROUND(ReactionModifier / (1 - class'X2AbilityToHitCalc_StandardAim'.default.REACTION_FINALMOD));
		/**/`Log("WOTC_APA_Marine - FireDisciplineReactionBonus:" @ iShotBonus);

		ShotInfo.ModType = eHit_Success;
		ShotInfo.Reason = FriendlyName;
		ShotInfo.Value = iShotBonus;
		ShotModifiers.AddItem(ShotInfo);
	}
}
