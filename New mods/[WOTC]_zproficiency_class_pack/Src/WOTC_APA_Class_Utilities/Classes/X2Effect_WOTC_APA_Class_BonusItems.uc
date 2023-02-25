
class X2Effect_WOTC_APA_Class_BonusItems extends X2Effect_Persistent;


// Variables to pass into the effect:
var array<name>	BonusItems;		//»» Apply to these items in the order they are added to the array. The first valid entry from the 
								//»» will get the free charges, so add the higher-tier items to the array first.
var int			FreeCharges;	//»» Number of free charges of the item to add.
var int			BonusCharges;	//»» Number of extra charges of the item to add for each item of that type already in the inventory.


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit				TargetUnit;
	local array<XComGameState_Item>			CurrentInventory;
	local X2ItemTemplateManager				ItemTemplateMgr;
	local X2ItemTemplate					ItemTemplate;
	local name								ItemName;
	local XComGameState_Item				InventoryItem, StoredInventoryItem, GrenadeLauncherItem;
	local bool								bFreeChargesApplied;
	local int								iBonusChargeMultiplier;
	local bool								bCreateFreeFromItem;
	local XComGameStateHistory				History;
	local XComGameState_HeadquartersXCom	XComHQ;
	local XComGameState_Tech				TechState;
	local name								TechName;
	local X2EquipmentTemplate				EquipmentTemplate;
	local X2GrenadeTemplate					GrenadeTemplate;
	local XGUnit							UnitVisualizer;
	local X2AbilityTemplateManager			AbilityTemplateMgr;
	local X2AbilityTemplate					AbilityTemplate, LaunchGrenadeTemplate;
	local name								AbilityName;
	local StateObjectReference				AbilityRef;

	// Skip initial mission setup effects if initiating a later stage of a multi-part mission
	if (class'WOTC_APA_Class_Utilities_Effects'.static.SkipSetupForMultiPartMission(ApplyEffectParameters))
		return;

	// Get Target's XComGameState_Unit and current inventory items to parse through
	TargetUnit = XComGameState_Unit(kNewTargetState);
	
	if (TargetUnit == none || BonusItems.Length == 0 || (FreeCharges < 1 && BonusCharges == 0))
		return;

	// Set bool to ignore trying to add free charges if none have been defined
	if (FreeCharges < 1)
		bFreeChargesApplied = true;
			
	CurrentInventory = TargetUnit.GetAllInventoryItems(NewGameState);
	ItemTemplateMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	// Cycle through target's inventory to add Bonus and Free charges
	foreach BonusItems(ItemName)
	{
		ItemTemplate = ItemTemplateMgr.FindItemTemplate(ItemName);

		// Check that a valid item was returned
		if (ItemTemplate == none)
			continue;

		// Reset the item counter for bonus charges
		iBonusChargeMultiplier = 0;

		// Loop through inventory looking for items from the upgraded ItemTemplate
		foreach CurrentInventory(InventoryItem)
		{
			if (InventoryItem != none && InventoryItem.GetMyTemplateName() ==  ItemTemplate.DataName)
			{
				// Item was found, increment the counter for bonus charges
				iBonusChargeMultiplier++;

				// If this is an item that has not been merged out, store the item for applying Bonus Charges and check if Free Charges should be applied
				if (!InventoryItem.bMergedOut)
				{
					StoredInventoryItem = InventoryItem;
					
					// Check that free charges have not already been applied (only apply once, not to each equipped item)
					if (!bFreeChargesApplied && FreeCharges > 0)
					{
						InventoryItem.Ammo += FreeCharges;
						bFreeChargesApplied = true;
			}	}	}

			// Flag whether the unit has a Grenade Launcher to apply any Grenade items to it
			if (X2WeaponTemplate(InventoryItem.GetMyTemplate()).WeaponCat ==  'grenade_launcher')
			{
				GrenadeLauncherItem = InventoryItem;
			}
		}

		// Add bonus charges, if applicable
		if (StoredInventoryItem != none && BonusCharges > 0)
		{
			StoredInventoryItem.Ammo += (BonusCharges * iBonusChargeMultiplier);
	}	}


	// If no equipped BonusItem was found, add the free item charges as a new item
	if (!bFreeChargesApplied && FreeCharges > 0)
	{
		foreach BonusItems(ItemName)
		{
			ItemTemplate = ItemTemplateMgr.FindItemTemplate(ItemName);
			// Check that a valid item was returned
			if (ItemTemplate == none)
				continue;

			// If the Bonus ItemTemplate is an infinite item and all required research is complete, use this item to add the free charges
			if (ItemTemplate.bInfiniteItem == true)
			{
				// Reset the flag tracking requirements
				bCreateFreeFromItem = true;

				// Skip looping through tech states if item has no required techs defined or is a starting item
				if (ItemTemplate.Requirements.RequiredTechs.length > 0 || !ItemTemplate.StartingItem)
				{
					History = `XCOMHISTORY;
					XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

					// Loop through all of the ItemTemplate's required techs to check status
					foreach ItemTemplate.Requirements.RequiredTechs(TechName)
					{
						// Loop through all techs to find status
						foreach History.IterateByClassType(class'XComGameState_Tech', TechState)
						{
							// Found a required tech
							if (TechState.GetMyTemplateName() == TechName)
							{
								// If it is not researched, flag bCreateFreeFromUpgrade as false and break from looping
								if (!XComHQ.TechIsResearched(TechState.GetReference()))
									bCreateFreeFromItem = false;

								break;
						}	}
					
						// If a previous tech requirement was found to be false, break from looping through any other required techs
						if (!bCreateFreeFromItem)
							break;
			}	}	}	
			
			if (bCreateFreeFromItem)
			{
				EquipmentTemplate = X2EquipmentTemplate(ItemTemplate);
				break;
	}	}	}


	// If all checks fail, try to add the free item charges to the first valid item, regardless of tech conditions
	if (!bFreeChargesApplied && FreeCharges > 0 && !bCreateFreeFromItem)
	{
		foreach BonusItems(ItemName)
		{
			ItemTemplate = ItemTemplateMgr.FindItemTemplate(ItemName);
			// Check that a valid item was returned
			if (ItemTemplate == none)
				continue;

			EquipmentTemplate = X2EquipmentTemplate(ItemTemplate);
			bCreateFreeFromItem = true;
	}	}


	// If an EquipmentTemplate was identified for the free charges
	if (bCreateFreeFromItem && FreeCharges > 0)
	{
		if (EquipmentTemplate != none)
		{
			// Create new XComGameState_Item from EquipmentTemplate
			InventoryItem = EquipmentTemplate.CreateInstanceFromTemplate(NewGameState);
			InventoryItem.Ammo = FreeCharges;
			InventoryItem.Quantity = 0;  // Flag as not a real item
			NewGameState.AddStateObject(InventoryItem);

			// Temporarily turn off equipment restrictions so we can add the item to the unit's inventory
			TargetUnit.bIgnoreItemEquipRestrictions = true;
			TargetUnit.AddItemToInventory(InventoryItem, eInvSlot_Utility, NewGameState);
			TargetUnit.bIgnoreItemEquipRestrictions = false;

			// Update the unit's visualizer to include the new item
			UnitVisualizer = XGUnit(TargetUnit.GetVisualizer());
			UnitVisualizer.ApplyLoadoutFromGameState(TargetUnit, NewGameState);

			NewEffectState.CreatedObjectReference = InventoryItem.GetReference();
			AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

			// Add grenade launcher abilities for grenades
			GrenadeTemplate = X2GrenadeTemplate(EquipmentTemplate);
			if (GrenadeTemplate != none && GrenadeTemplate.LaunchedGrenadeEffects.Length > 0 && GrenadeLauncherItem != none)
			{
				LaunchGrenadeTemplate = AbilityTemplateMgr.FindAbilityTemplate('LaunchGrenade');
				//AbilityRef = `TACTICALRULES.InitAbilityForUnit(LaunchGrenadeTemplate, TargetUnit, NewGameState, GrenadeLauncherItem.GetReference(), InventoryItem.GetReference());
				InitAbility(LaunchGrenadeTemplate, TargetUnit, NewGameState, GrenadeLauncherItem.GetReference(), InventoryItem.GetReference());
			}

			// Add abilities from the equipment item itself. Add these last in case they're overridden by soldier abilities.
			foreach EquipmentTemplate.Abilities(AbilityName)
			{
				// Skip the small item mobility penalty being applied when adding utility items in LW2
				if (AbilityName == 'SmallItemWeight')
					continue;
				
				AbilityTemplate = AbilityTemplateMgr.FindAbilityTemplate(AbilityName);
				InitAbility(AbilityTemplate, TargetUnit, NewGameState, InventoryItem.GetReference());
	}	}	}

	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
}


simulated function InitAbility(X2AbilityTemplate AbilityTemplate, XComGameState_Unit NewUnit, XComGameState NewGameState, optional StateObjectReference ItemRef, optional StateObjectReference AmmoRef)
{
	local XComGameState_Ability OtherAbility;
	local StateObjectReference AbilityRef;
	local XComGameStateHistory History;
	local X2AbilityTemplateManager AbilityTemplateMan;
	local name AdditionalAbility;

	History = `XCOMHISTORY;
	AbilityTemplateMan = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	// Check for ability overrides
	foreach NewUnit.Abilities(AbilityRef)
	{
		OtherAbility = XComGameState_Ability(History.GetGameStateForObjectID(AbilityRef.ObjectID));

		if (OtherAbility.GetMyTemplate().OverrideAbilities.Find(AbilityTemplate.DataName) != INDEX_NONE)
			return;
	}

	AbilityRef = `TACTICALRULES.InitAbilityForUnit(AbilityTemplate, NewUnit, NewGameState, ItemRef, AmmoRef);

	// Add additional abilities
	foreach AbilityTemplate.AdditionalAbilities(AdditionalAbility)
	{
		AbilityTemplate = AbilityTemplateMan.FindAbilityTemplate(AdditionalAbility);

		// Check for overrides of the additional abilities
		foreach NewUnit.Abilities(AbilityRef)
		{
			OtherAbility = XComGameState_Ability(History.GetGameStateForObjectID(AbilityRef.ObjectID));

			if (OtherAbility.GetMyTemplate().OverrideAbilities.Find(AbilityTemplate.DataName) != INDEX_NONE)
				return;
		}

		AbilityRef = `TACTICALRULES.InitAbilityForUnit(AbilityTemplate, NewUnit, NewGameState, ItemRef, AmmoRef);
	}
}

//simulated function InitAbility(X2AbilityTemplate AbilityTemplate, XComGameState_Unit NewUnit, XComGameState NewGameState, optional StateObjectReference ItemRef, optional StateObjectReference AmmoRef)
//{
	//local XComGameState_Ability NewAbility, OtherAbility;
	//local StateObjectReference AbilityRef;
	//local XComGameStateHistory History;
	//local X2AbilityTemplateManager AbilityTemplateMan;
	//local name AdditionalAbility;
//
	//History = `XCOMHISTORY;
	//AbilityTemplateMan = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
//
	//// Check for ability overrides
	//foreach NewUnit.Abilities(AbilityRef)
	//{
		//OtherAbility = XComGameState_Ability(History.GetGameStateForObjectID(AbilityRef.ObjectID));
//
		//if (OtherAbility.GetMyTemplate().OverrideAbilities.Find(AbilityTemplate.DataName) != INDEX_NONE)
			//return;
	//}
//
	//AbilityRef = `TACTICALRULES.InitAbilityForUnit(AbilityTemplate, NewUnit, NewGameState, ItemRef, AmmoRef);
	//NewAbility = XComGameState_Ability(NewGameState.GetGameStateForObjectID(AbilityRef.ObjectID));
	//NewAbility.CheckForPostBeginPlayActivation(NewGameState);
//
	//// Add additional abilities
	//foreach AbilityTemplate.AdditionalAbilities(AdditionalAbility)
	//{
		//AbilityTemplate = AbilityTemplateMan.FindAbilityTemplate(AdditionalAbility);
//
		//// Check for overrides of the additional abilities
		//foreach NewUnit.Abilities(AbilityRef)
		//{
			//OtherAbility = XComGameState_Ability(History.GetGameStateForObjectID(AbilityRef.ObjectID));
//
			//if (OtherAbility.GetMyTemplate().OverrideAbilities.Find(AbilityTemplate.DataName) != INDEX_NONE)
				//return;
		//}
//
		//AbilityRef = `TACTICALRULES.InitAbilityForUnit(AbilityTemplate, NewUnit, NewGameState, ItemRef, AmmoRef);
		//NewAbility = XComGameState_Ability(NewGameState.GetGameStateForObjectID(AbilityRef.ObjectID));
		//NewAbility.CheckForPostBeginPlayActivation(NewGameState);
//}	}


simulated function OnEffectRemoved(const out EffectAppliedData ApplyEffectParameters, XComGameState NewGameState, bool bCleansed, XComGameState_Effect RemovedEffectState)
{
	if (RemovedEffectState.CreatedObjectReference.ObjectID > 0)
		NewGameState.RemoveStateObject(RemovedEffectState.CreatedObjectReference.ObjectID);
}

function UnitEndedTacticalPlay(XComGameState_Effect EffectState, XComGameState_Unit UnitState)
{
	local XComGameState NewGameState;

	NewGameState = UnitState.GetParentGameState();

	if (EffectState.CreatedObjectReference.ObjectID > 0)
		NewGameState.RemoveStateObject(EffectState.CreatedObjectReference.ObjectID);
}