
class X2Effect_WOTC_APA_Splinter extends X2Effect_Persistent;


function int GetExtraShredValue(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData)
{
	local XComGameState_Item				SourceWeapon;
	local X2Effect_ApplyWeaponDamage		DamageEffect;
	local X2WeaponTemplate					WeaponTemplate;

	// Only apply when the damage effect is applying the weapon's base damage
	DamageEffect = X2Effect_ApplyWeaponDamage(class'X2Effect'.static.GetX2Effect(AppliedData.EffectRef));
	if (DamageEffect == none || DamageEffect.bIgnoreBaseDamage)
		return 0;

	if (!class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult))
		return 0;

	SourceWeapon = AbilityState.GetSourceWeapon();
	if (SourceWeapon == none)
		return 0;

	if (AbilityState.SourceWeapon != Attacker.GetItemInSlot(eInvSlot_PrimaryWeapon).GetReference())
		return 0;

	WeaponTemplate = X2WeaponTemplate(SourceWeapon.GetMyTemplate());
	if (WeaponTemplate != none)
	{
		return class'X2Ability_WOTC_APA_MarineAbilitySet'.default.SPLINTER_ARMOR_SHRED;
	}
}