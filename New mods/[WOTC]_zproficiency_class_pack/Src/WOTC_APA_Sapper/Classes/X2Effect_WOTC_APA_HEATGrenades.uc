
class X2Effect_WOTC_APA_HEATGrenades extends X2Effect_Persistent config(WOTC_APA_SapperSkills);

var int ArmorPierce;
var int BonusShred;


// Apply Armor Piercing
function int GetExtraArmorPiercing(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData)
{
    if (ValidateSourceWeapon(AbilityState))
	{
        return ArmorPierce;
    }

    return 0;
}


// Apply extra Armor Shred
function int GetExtraShredValue(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData)
{
    local XComGameState_Item		SourceWeapon;
    local X2WeaponTemplate			WeaponTemplate, SourceWeaponAmmoTemplate;

	if (ValidateSourceWeapon(AbilityState))
	{
		SourceWeapon = AbilityState.GetSourceWeapon();
		WeaponTemplate = X2WeaponTemplate(SourceWeapon.GetMyTemplate());
		SourceWeaponAmmoTemplate = X2WeaponTemplate(SourceWeapon.GetLoadedAmmoTemplate(AbilityState));
    
		if (WeaponTemplate.BaseDamage.Shred > 0 || SourceWeaponAmmoTemplate.BaseDamage.Shred > 0)
		{
			return BonusShred;
	}	}

    return 0;
}


// Make sure the grenade is a valid type (standard grenades)
function bool ValidateSourceWeapon(XComGameState_Ability AbilityState)
{
	local XComGameState_Item			SourceWeapon;
	local X2WeaponTemplate				SourceWeaponAmmoTemplate;
	local name							AbilityName;

	SourceWeapon = AbilityState.GetSourceWeapon();
	AbilityName = AbilityState.GetMyTemplateName();

	if (SourceWeapon == none)
		return false;
		
	if (class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ORDNANCE_STANDARD_GRENADE_TYPES.Find(SourceWeapon.GetMyTemplateName()) != -1)
	{
		return true;
	}

	SourceWeaponAmmoTemplate = X2WeaponTemplate(SourceWeapon.GetLoadedAmmoTemplate(AbilityState));
	if (SourceWeaponAmmoTemplate != none )
	{
		if (class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ORDNANCE_STANDARD_GRENADE_TYPES.Find(SourceWeaponAmmoTemplate.DataName) != -1)
		{
			return true;
	}	}

	return false;
}



DefaultProperties
{
    EffectName="WOTC_APA_HEATGrenadesEffect"
    DuplicateResponse = eDupe_Ignore
}
