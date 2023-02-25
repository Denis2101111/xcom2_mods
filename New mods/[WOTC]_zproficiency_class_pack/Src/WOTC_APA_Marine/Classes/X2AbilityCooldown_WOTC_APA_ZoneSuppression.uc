
class X2AbilityCooldown_WOTC_APA_ZoneSuppression extends X2AbilityCooldown;


simulated function int GetNumTurns(XComGameState_Ability kAbility, XComGameState_BaseObject AffectState, XComGameState_Item AffectWeapon, XComGameState NewGameState)
{
	local X2WeaponTemplate				WeaponTemplate;
	local name							WeaponCategory;

	WeaponTemplate = X2WeaponTemplate(AffectWeapon.GetMyTemplate());	
	WeaponCategory = WeaponTemplate.WeaponCat;

	if (WeaponCategory == 'cannon')
	{
		return class'X2Ability_WOTC_APA_MarineAbilitySet'.default.ZONE_SUPPRESSION_CANNON_COOLDOWN;
	}

	return class'X2Ability_WOTC_APA_MarineAbilitySet'.default.ZONE_SUPPRESSION_RIFLE_COOLDOWN;
}