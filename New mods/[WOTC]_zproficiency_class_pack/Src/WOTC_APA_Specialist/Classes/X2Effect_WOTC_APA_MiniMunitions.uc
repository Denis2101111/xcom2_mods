class X2Effect_WOTC_APA_MiniMunitions extends X2Effect_Persistent;

var int BonusCharges;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit		TargetUnit; 
	local XComGameState_Item		ItemState, UpdatedItemState;

	TargetUnit = XComGameState_Unit(kNewTargetState);
	ItemState = TargetUnit.GetItemInSlot(eInvSlot_HeavyWeapon);

	if (ItemState == none)
		return;

	UpdatedItemState = XComGameState_Item(NewGameState.CreateStateObject(class'XComGameState_Item', ItemState.ObjectID));
	UpdatedItemState.Ammo += BonusCharges;
	NewGameState.AddStateObject(UpdatedItemState);

	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
}