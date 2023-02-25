
class X2Condition_WOTC_APA_Class_InventoryCondition extends X2Condition;

// Variables to pass into the condition check:
var array<name>		RequiredItems;
var array<name>		ExcludingItems;


event name CallAbilityMeetsCondition(XComGameState_Ability kAbility, XComGameState_BaseObject kTarget)
{
	local XComGameStateHistory			History;
	local XComGameState_Unit			SourceUnit;
	local XComGameState_Item			InventoryItem;
	local array<XComGameState_Item>		CurrentInventory;
	local name							ItemName;
	local bool							bHasRequired;

	History = `XCOMHISTORY;
	SourceUnit = XComGameState_Unit(History.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));
	CurrentInventory = SourceUnit.GetAllInventoryItems(, true);
	foreach CurrentInventory(InventoryItem)
	{
		ItemName = InventoryItem.GetMyTemplateName();
		if (ExcludingItems.Length > 0 && ExcludingItems.find(ItemName) != INDEX_NONE)
			return 'AA_AbilityUnavailable';

		if (RequiredItems.Length > 0 && RequiredItems.find(ItemName) != INDEX_NONE)
			bHasRequired = true;
	}

	if (bHasRequired || RequiredItems.Length < 1)
		return 'AA_Success';
	
	return 'AA_AbilityUnavailable';
}