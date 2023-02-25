
class X2Effect_WOTC_APA_Class_AddAbilitiesToTarget extends X2Effect_Persistent;

// Variables to pass into the effect:
var array<name>		AddAbilities; //»» List of Abilities to add to Target
var eInventorySlot	ApplyToWeaponSlot; //»» Apply Abilities to InventorySlot (i.e., eInvSlot_Primary, eInvSlot_Secondary, etc.)
var name			ApplyToWeaponCat; //»» Apply Abilities to an item of a particular Weapon Category (e.g., utility slot pistols, etc.) - Only use if ApplyToWeaponSlot is not defined
var name			ApplyToItem; //»» Apply Abilities to specific item template or its upgrade - Only use if ApplyToWeaponSlot AND ApplyToWeaponCat are not defined

// ^^ NOTE: Only ONE of the ApplyTo... variables above should need to be defined in most (all?) situations - Defining more than one will probably lead to the wrong or no Source Item Reference


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit		TargetUnit;
	local X2ItemTemplateManager		ItemTemplateMgr;
	local X2ItemTemplate			ItemTemplate, UpgradeItemTemplate;
	local X2WeaponTemplate			WeaponTemplate;
	local array<XComGameState_Item> CurrentInventory;
	local XComGameState_Item		InventoryItem;
	local StateObjectReference		SourceItemRef;
	local bool						bSourceItemRefFound;
	local X2AbilityTemplateManager	AbilityTemplateMgr;
	local X2AbilityTemplate			AbilityTemplate;
	local name						AbilityName;

	// Skip initial mission setup effects if initiating a later stage of a multi-part mission
	if (class'WOTC_APA_Class_Utilities_Effects'.static.SkipSetupForMultiPartMission(ApplyEffectParameters))
		return;

	// Get Target's XComGameState_Unit
	TargetUnit = XComGameState_Unit(kNewTargetState);
	
	if (TargetUnit == none || AddAbilities.Length == 0)
		return;


	// If components to assign a source weapon are defined for the effect, attempt to find the item reference to use when initiating the abilities (used for visualizations, ammo costs, etc.)
	if (ApplyToWeaponSlot != eInvSlot_Unknown || ApplyToWeaponCat != '' || ApplyToItem != '')
	{
		// Get Target's current inventory items to parse through
		CurrentInventory = TargetUnit.GetAllInventoryItems(NewGameState);

		// Find the item reference in a defined eInventorySlot, if specified, to assign as the abilities source weapon (e.g., the primary weapon equipped in the eInvSlot_Primary slot)
		if (ApplyToWeaponSlot != eInvSlot_Unknown)
		{
			foreach CurrentInventory(InventoryItem)
			{
				if (InventoryItem.bMergedOut)
					continue;

				if (InventoryItem.InventorySlot == ApplyToWeaponSlot)
				{
					SourceItemRef = InventoryItem.GetReference();
					bSourceItemRefFound = true;
					break;
				}
			}
		}

		// If a source item reference was not found in an eInventorySlot and a WeaponCat has been defined, search for an item with a matching WeaponCat (used for utility items like medikits, etc.)
		if (bSourceItemRefFound == false && ApplyToWeaponCat != '')
		{
			foreach CurrentInventory(InventoryItem)
			{
				WeaponTemplate = X2WeaponTemplate(InventoryItem.GetMyTemplate());
				if (WeaponTemplate != none && WeaponTemplate.WeaponCat == ApplyToWeaponCat)
				{
					SourceItemRef = InventoryItem.GetReference();
					bSourceItemRefFound = true;
					break;
				}
			}
		}

		// If a source item reference was not found in an eInventorySlot or WeaponCat and an item name has been defined, search for the item or its upgrade (used for utility items like medikits, etc.)
		if (bSourceItemRefFound == false && ApplyToItem != '')
		{
			ItemTemplateMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
			ItemTemplate = ItemTemplateMgr.FindItemTemplate(ApplyToItem);

			// Check that a valid item was defined before looping
			if (ItemTemplate != none)
			{
				// Get the item's upgraded item template, if applicable
				if (ItemTemplate.UpgradeItem != '')
					UpgradeItemTemplate = ItemTemplateMgr.FindItemTemplate(ItemTemplate.UpgradeItem);

				foreach CurrentInventory(InventoryItem)
				{
					// TODO - I don't know what this is doing!?
					if (InventoryItem.bMergedOut)
						continue;

					if (InventoryItem.GetMyTemplateName() == ItemTemplate.DataName || InventoryItem.GetMyTemplateName() == UpgradeItemTemplate.DataName)
					{
						SourceItemRef = InventoryItem.GetReference();
						break;
	}	}	}	}	}
	

	// Call function to initiate each added ability
	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	foreach AddAbilities(AbilityName)
	{		
		AbilityTemplate = AbilityTemplateMgr.FindAbilityTemplate(AbilityName);

		if (AbilityTemplate != none)
			InitAbility(AbilityTemplate, TargetUnit, NewGameState, SourceItemRef);
	}
	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
}


simulated function InitAbility(X2AbilityTemplate AbilityTemplate, XComGameState_Unit NewUnit, XComGameState NewGameState, optional StateObjectReference ItemRef, optional StateObjectReference AmmoRef)
{
	local XComGameState_Ability NewAbility, OtherAbility;
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
	NewAbility = XComGameState_Ability(NewGameState.GetGameStateForObjectID(AbilityRef.ObjectID));
	NewAbility.CheckForPostBeginPlayActivation(NewGameState);

	// Add additional abilities
	foreach AbilityTemplate.AdditionalAbilities(AdditionalAbility)
	{
		AbilityTemplate = AbilityTemplateMan.FindAbilityTemplate(AdditionalAbility);

		// Check for bUniqueSource and skip if already present
		if (AbilityTemplate.bUniqueSource && NewUnit.HasSoldierAbility(AdditionalAbility))
			continue;

		// Check for overrides of the additional abilities
		foreach NewUnit.Abilities(AbilityRef)
		{
			OtherAbility = XComGameState_Ability(History.GetGameStateForObjectID(AbilityRef.ObjectID));

			if (OtherAbility.GetMyTemplate().OverrideAbilities.Find(AbilityTemplate.DataName) != INDEX_NONE)
				return;
		}

		AbilityRef = `TACTICALRULES.InitAbilityForUnit(AbilityTemplate, NewUnit, NewGameState, ItemRef, AmmoRef);
		NewAbility = XComGameState_Ability(NewGameState.GetGameStateForObjectID(AbilityRef.ObjectID));
		NewAbility.CheckForPostBeginPlayActivation(NewGameState);
	}
}


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


defaultproperties
{
	ApplyToWeaponSlot = eInvSlot_Unknown;
}