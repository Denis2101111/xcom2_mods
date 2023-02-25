
class X2Condition_WOTC_APA_EquippedGremlinTech extends X2Condition;

// Variables to pass into the condition check:
var array<name>		AllowedWeaponCategories;
var array<name>		AllowedWeaponTechNames;


function bool CanEverBeValid(XComGameState_Unit SourceUnit, bool bStrategyCheck)
{
	local array<XComGameState_Item>		CurrentInventory;
	local XComGameState_Item			InventoryItem;
	local X2WeaponTemplate				WeaponTemplate;
	local name							WeaponCategory;
	local name							WeaponTechName;


	CurrentInventory = SourceUnit.GetAllInventoryItems(, true);
	foreach CurrentInventory(InventoryItem)
	{
		WeaponTemplate = X2WeaponTemplate(InventoryItem.GetMyTemplate());
		WeaponCategory = WeaponTemplate.WeaponCat;
		WeaponTechName = WeaponTemplate.WeaponTech;
	
		if (AllowedWeaponCategories.find(WeaponCategory) != INDEX_NONE && AllowedWeaponTechNames.find(WeaponTechName) != INDEX_NONE)
			return true;
	}
	
	// No valid weapon was found - do not add ability to SourceUnit for this tactical battle.
	return false;
}