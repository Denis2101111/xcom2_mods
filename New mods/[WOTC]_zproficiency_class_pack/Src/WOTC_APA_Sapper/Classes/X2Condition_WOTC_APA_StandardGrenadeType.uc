
class X2Condition_WOTC_APA_StandardGrenadeType extends X2Condition;


event name CallAbilityMeetsCondition(XComGameState_Ability AbilityState, XComGameState_BaseObject kTarget)
{
	local XComGameState_Unit		UnitState;
	local XComGameState_Item		SourceAmmo, SourceWeapon;
	local X2GrenadeTemplate			SourceGrenade;
	local X2WeaponTemplate			WeaponTemplate;

	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
	if (UnitState.AffectedByEffectNames.Find('WOTC_APA_DestructiveNatureEffect') != -1)
	{
		SourceWeapon = AbilityState.GetSourceWeapon();
		WeaponTemplate = X2WeaponTemplate(SourceWeapon.GetMyTemplate());
		if (WeaponTemplate.WeaponCat == 'heavy')
		{
			return 'AA_Success';
	}	}

	SourceAmmo = AbilityState.GetSourceAmmo();
	if (SourceAmmo == none)
	{
		SourceAmmo = AbilityState.GetSourceWeapon();
		if (SourceAmmo == none)
		{
			return 'AA_WeaponIncompatible';
	}	}

	SourceGrenade = X2GrenadeTemplate(SourceAmmo.GetMyTemplate());
	if (SourceGrenade != none)
	{
		if (class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ORDNANCE_STANDARD_GRENADE_TYPES.Find(SourceGrenade.DataName) != -1)
		{
			return 'AA_Success';
	}	}

	return 'AA_WeaponIncompatible';
}
