
class X2Effect_WOTC_APA_SlipIntoPosition extends X2Effect_PersistentStatChange;


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit	TargetUnit;
	local XComGameState_Item	InventoryItem;
	local X2WeaponTemplate		WeaponTemplate;
	local name					WeaponCategory;
	local int					iBonusLevel;

	m_aStatChanges.length = 0;

	TargetUnit = XComGameState_Unit(kNewTargetState);

	InventoryItem = TargetUnit.GetItemInSlot(eInvSlot_PrimaryWeapon);
	WeaponTemplate = X2WeaponTemplate(InventoryItem.GetMyTemplate());
	WeaponCategory = WeaponTemplate.WeaponCat;
	if (class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.RUN_AND_GUN_LIGHT_PRIMARY_WEAPONS.Find(WeaponCategory) != -1)
		iBonusLevel++;

	InventoryItem = TargetUnit.GetItemInSlot(eInvSlot_SecondaryWeapon);
	WeaponTemplate = X2WeaponTemplate(InventoryItem.GetMyTemplate());
	WeaponCategory = WeaponTemplate.WeaponCat;
	if (class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.RUN_AND_GUN_LIGHT_SECONDARY_WEAPONS.Find(WeaponCategory) != -1)
		iBonusLevel++;

	if (iBonusLevel > 0)
	{
		if (iBonusLevel == 1)
		{
			AddPersistentStatChange(eStat_DetectionModifier, class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.SLIP_INTO_POSITION_DETECTION_RANGE_BONUS_1, MODOP_Addition);
			TargetUnit.SetUnitFloatValue(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.SLIP_INTO_POSITION_BONUS_NAME, (class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.SLIP_INTO_POSITION_DETECTION_RANGE_BONUS_1), eCleanup_BeginTactical);
		}
		else
		{
			AddPersistentStatChange(eStat_DetectionModifier, class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.SLIP_INTO_POSITION_DETECTION_RANGE_BONUS_2, MODOP_Addition);
			TargetUnit.SetUnitFloatValue(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.SLIP_INTO_POSITION_BONUS_NAME, (class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.SLIP_INTO_POSITION_DETECTION_RANGE_BONUS_2), eCleanup_BeginTactical);
		}
	}

	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
}