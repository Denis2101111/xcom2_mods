
class X2Condition_WOTC_APA_FarseerWeaponCondition extends X2Condition;

var array<name> ValidHunterRifles;

event name CallAbilityMeetsCondition(XComGameState_Ability kAbility, XComGameState_BaseObject kTarget)
{
	local XComGameStateHistory	History;
	local XComGameState_Item	InventoryItem;
	local EInventorySlot		InventorySlot;
	local X2WeaponTemplate		WeaponTemplate;
	local name					WeaponCategory;
	local name					TemplateName;

	History = `XCOMHISTORY;
	InventoryItem = XComGameState_Item(History.GetGameStateForObjectID(kAbility.SourceWeapon.ObjectID));
	if (InventoryItem == none)
		return 'AA_WeaponIncompatible';

	WeaponTemplate = X2WeaponTemplate(InventoryItem.GetMyTemplate());
	if (WeaponTemplate == none)
		return 'AA_WeaponIncompatible';
	
	WeaponCategory = WeaponTemplate.WeaponCat;
	TemplateName = WeaponTemplate.DataName;
	
	// Applying penalty fails if a valid weapon is present
	if (WeaponCategory == 'sniper_rifle' || ValidHunterRifles.Find(TemplateName) != -1)
		return 'AA_WeaponIncompatible';

	return 'AA_Success';
}