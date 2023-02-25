
class X2Condition_WOTC_APA_HighCaliberAmmoCondition extends X2Condition;


event name CallAbilityMeetsCondition(XComGameState_Ability kAbility, XComGameState_BaseObject kTarget)
{
	local XComGameStateHistory	History;
	local XComGameState_Unit	SourceUnit;
	local XComGameState_Item	InventoryItem;
	local X2WeaponTemplate		WeaponTemplate;
	

	History = `XCOMHISTORY;
	SourceUnit = XComGameState_Unit(History.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));
	InventoryItem = XComGameState_Item(History.GetGameStateForObjectID(kAbility.SourceWeapon.ObjectID));
	
	if (InventoryItem == none)
		return 'AA_WeaponIncompatible';

	WeaponTemplate = X2WeaponTemplate(InventoryItem.GetMyTemplate());
	if (WeaponTemplate == none)
		return 'AA_WeaponIncompatible';
	
	if (WeaponTemplate.iClipSize <= -class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.HIGH_CALIBER_AMMO_MODIFIER)
		return 'AA_WeaponIncompatible';
	
	return 'AA_Success';
}