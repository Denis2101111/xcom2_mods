class X2AbilityCost_WOTC_APA_ZoneSuppressionActionPoints extends XMBAbilityCost_ActionPoints;


simulated function int GetPointCost(XComGameState_Ability AbilityState, XComGameState_Unit AbilityOwner)
{
	local XComGameState_Item			InventoryItem;
	local X2WeaponTemplate				WeaponTemplate;
	local name							WeaponCategory;
	
	
	// If NOT under the Emplaced effect, require 2 action points if ability is being applied from a cannon/machinegun
	if (AbilityOwner.AffectedByEffectNames.Find('WOTC_APA_EmplacedBoost') == -1)
	{
		InventoryItem = AbilityOwner.GetItemInSlot(eInvSlot_PrimaryWeapon);
		WeaponTemplate = X2WeaponTemplate(InventoryItem.GetMyTemplate());	
		WeaponCategory = WeaponTemplate.WeaponCat;

		if (WeaponCategory == 'cannon')
		{
			return 2;
		}
	}

	// Otherwise process as normal:
	return super.GetPointCost(AbilityState, AbilityOwner);
}