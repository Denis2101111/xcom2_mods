
class X2Effect_WOTC_APA_AddReaperHack extends X2Effect_Persistent;


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit		TargetUnit;
	local array<XComGameState_Item> CurrentInventory;
	local XComGameState_Item		InventoryItem;
	local StateObjectReference		SourceItemRef;
	local X2AbilityTemplateManager	AbilityTemplateMgr;
	local X2AbilityTemplate			AbilityTemplate;
	local name						AbilityName;

	// Get Target's XComGameState_Unit
	TargetUnit = XComGameState_Unit(kNewTargetState);
	if (TargetUnit == none)
		return;

	// Get Target's current inventory items to parse through
	CurrentInventory = TargetUnit.GetAllInventoryItems(NewGameState);
	foreach CurrentInventory(InventoryItem)
	{
		if (InventoryItem.GetMyTemplateName() == 'XPad')
		{
			SourceItemRef = InventoryItem.GetReference();
			break;
	}	}
	

	// Call function to initiate each added ability
	if (SourceItemRef.ObjectID > 0)
	{
		AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();	
		AbilityTemplate = AbilityTemplateMgr.FindAbilityTemplate('WOTC_APA_ReaperHack');
		if (AbilityTemplate != none)
		{
			InitAbility(AbilityTemplate, TargetUnit, NewGameState, SourceItemRef);
	}	}

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