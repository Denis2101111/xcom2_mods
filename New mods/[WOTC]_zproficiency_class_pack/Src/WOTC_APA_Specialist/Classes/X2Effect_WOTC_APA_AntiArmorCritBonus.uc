
class X2Effect_WOTC_APA_AntiArmorCritBonus extends X2Effect_Persistent;


// Add bonus chance to critically hit with the primary weapon
function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local ShotModifierInfo ModInfo;
	local XComGameState_Item SourceWeapon;

	SourceWeapon = AbilityState.GetSourceWeapon();
	//  Make sure the source weapon is the primary weapon and the target is mechanical
	if (SourceWeapon != none && SourceWeapon.InventorySlot == eInvSlot_PrimaryWeapon && Target.IsRobotic())
	{
		ModInfo.ModType = eHit_Crit;
		ModInfo.Reason = FriendlyName;
		ModInfo.Value = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.ANTI_ARMOR_MECH_BONUS_CRIT;
		ShotModifiers.AddItem(ModInfo);
	}

}