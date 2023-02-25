
class X2Effect_WOTC_APA_FireSupportBonus extends X2Effect_Persistent;


function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
    local XComGameState_Item	SourceWeapon;
    local ShotModifierInfo		ShotInfo;
	local int					iShotBonus;					

	if(AbilityState.GetMyTemplateName() == 'WOTC_APA_SuppressionShot')
	{
		SourceWeapon = AbilityState.GetSourceWeapon();    
		if (SourceWeapon != none && Target != none)
		{
			// Divide the expected aim modifier by the reaction shot modifier - this will cancel out when shot gets multiplied by the reaction shot modifier
			iShotBonus = ROUND(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.FIRE_SUPPORT_AIM_BONUS / (1 - class'X2AbilityToHitCalc_StandardAim'.default.REACTION_FINALMOD));
			/**/`Log("WOTC_APA_Medic - FireSupportBonus: Suppression shot aim bonus = " $ iShotBonus);
	
			ShotInfo.ModType = eHit_Success;
			ShotInfo.Reason = FriendlyName;
			ShotInfo.Value = iShotBonus;
			ShotModifiers.AddItem(ShotInfo);
		}
    }    
}
