
class X2Effect_WOTC_APA_Class_BonusDamage extends X2Effect_Persistent;

var int		BonusDmg;
var float	fBonusDmgMultiplier;

var int		BonusCritDmg;
var float	fBonusCritDmgMultiplier;

var bool	bCritReplacesBonus;

var int		ArmorPierce;

var bool	bApplyToPrimary;
var bool	bApplyToSecondary;
var bool	bApplyToHeavyWeapon;
var bool	bApplyToOther;

var bool	bExcludeIndirect;
var bool	bOnlyIndirect;

var array<X2Condition>	BonusDamageConditions;
var array<name>			ValidAbilities;
var array<name>			ExcludedAbilities;


function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState) 
{
	local XComGameState_Item				SlotItem;
	local bool								bSourceIsSlotItem;
	local X2Effect_ApplyWeaponDamage		DamageEffect;
	local X2AbilityToHitCalc_StandardAim	StandardHit;
	local float								fBonusDamage;

	// Do not apply to actions dealing no damage
	if (!class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult) || CurrentDamage == 0)
		return 0;

	// Only apply when the damage effect is applying the weapon's base damage
	if (NewGameState != none)
	{
		DamageEffect = X2Effect_ApplyWeaponDamage(class'X2Effect'.static.GetX2Effect(AppliedData.EffectRef));
		if (DamageEffect == none || DamageEffect.bIgnoreBaseDamage)
		{
			return 0;
	}	}

	// Check Valid Abilities
	if (ValidAbilities.Length > 0)
	{
		if (ValidAbilities.Find(AbilityState.GetMyTemplateName()) == Index_None)
			return 0;
	}

	// Check Excluded Abilities
	if (ExcludedAbilities.Length > 0)
	{
		if (ExcludedAbilities.Find(AbilityState.GetMyTemplateName()) != Index_None)
			return 0;
	}

	// Check Primary Weapon
	SlotItem = Attacker.GetItemInSlot(eInvSlot_PrimaryWeapon);
	if (AbilityState.SourceWeapon == SlotItem.GetReference())
	{
		bSourceIsSlotItem = true;
		if (!bApplyToPrimary)
		{
			return 0;
	}	}

	// Check Secondary Weapon
	SlotItem = Attacker.GetItemInSlot(eInvSlot_SecondaryWeapon);
	if (AbilityState.SourceWeapon == SlotItem.GetReference())
	{
		bSourceIsSlotItem = true;
		if (!bApplyToSecondary)
		{
			return 0;
	}	}

	// Check Heavy Weapon
	SlotItem = Attacker.GetItemInSlot(eInvSlot_HeavyWeapon);
	if (AbilityState.SourceWeapon == SlotItem.GetReference())
	{
		bSourceIsSlotItem = true;
		if (!bApplyToHeavyWeapon)
		{
			return 0;
	}	}

	// Check Other Items
	if (!bSourceIsSlotItem && !bApplyToOther)
		return 0;

	// Check for Indirect Attacks
	StandardHit = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
	if (bExcludeIndirect && StandardHit.bIndirectFire)
		return 0;

	if (bOnlyIndirect && !StandardHit.bIndirectFire)
		return 0;

	// Evaluate any conditions
	if (!ValidateConditions(Attacker, XComGameState_BaseObject(TargetDamageable), AbilityState))
		return 0;


	if (BonusDmg != 0 || fBonusDmgMultiplier != 0)
	{
		if (AppliedData.AbilityResultContext.HitResult != eHit_Crit || !bCritReplacesBonus)
		{
			if (fBonusDmgMultiplier != 0)
				fBonusDamage = CurrentDamage * (fBonusDmgMultiplier - 1);

			if (BonusDmg != 0)
				fBonusDamage += BonusDmg;
	}	}

	if (BonusCritDmg != 0 || fBonusCritDmgMultiplier != 0)
	{
		if (AppliedData.AbilityResultContext.HitResult == eHit_Crit)
		{
			if (fBonusCritDmgMultiplier != 0)
			{
				if (fBonusDamage == 0)
				{
					fBonusDamage = CurrentDamage;
				}

				fBonusDamage = CurrentDamage * (fBonusCritDmgMultiplier - 1);
			}

			if (BonusCritDmg != 0)
				fBonusDamage += BonusCritDmg;
	}	}

	return round(fBonusDamage);
}


function int GetExtraArmorPiercing(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData)
{
	local XComGameState_Item				SlotItem;
	local bool								bSourceIsSlotItem;
	local X2Effect_ApplyWeaponDamage		DamageEffect;
	local X2AbilityToHitCalc_StandardAim	StandardHit;

	// Exit if no ArmorPierce set
	if (ArmorPierce == 0)
		return 0;
	
	// Only apply when the damage effect is applying the weapon's base damage
	DamageEffect = X2Effect_ApplyWeaponDamage(class'X2Effect'.static.GetX2Effect(AppliedData.EffectRef));
	if (DamageEffect == none || DamageEffect.bIgnoreBaseDamage)
		return 0;

	// Check Valid Abilities
	if (ValidAbilities.Length > 0)
	{
		if (ValidAbilities.Find(AbilityState.GetMyTemplateName()) == Index_None)
			return 0;
	}

	// Check Excluded Abilities
	if (ExcludedAbilities.Length > 0)
	{
		if (ExcludedAbilities.Find(AbilityState.GetMyTemplateName()) != Index_None)
			return 0;
	}

	// Check Primary Weapon
	SlotItem = Attacker.GetItemInSlot(eInvSlot_PrimaryWeapon);
	if (AbilityState.SourceWeapon == SlotItem.GetReference())
	{
		bSourceIsSlotItem = true;
		if (!bApplyToPrimary)
		{
			return 0;
	}	}

	// Check Secondary Weapon
	SlotItem = Attacker.GetItemInSlot(eInvSlot_SecondaryWeapon);
	if (AbilityState.SourceWeapon == SlotItem.GetReference())
	{
		bSourceIsSlotItem = true;
		if (!bApplyToSecondary)
		{
			return 0;
	}	}

	// Check Heavy Weapon
	SlotItem = Attacker.GetItemInSlot(eInvSlot_HeavyWeapon);
	if (AbilityState.SourceWeapon == SlotItem.GetReference())
	{
		bSourceIsSlotItem = true;
		if (!bApplyToHeavyWeapon)
		{
			return 0;
	}	}

	// Check Other Items
	if (!bSourceIsSlotItem && !bApplyToOther)
		return 0;

	// Check for Indirect Attacks
	StandardHit = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
	if (bExcludeIndirect && StandardHit.bIndirectFire)
		return 0;

	if (bOnlyIndirect && !StandardHit.bIndirectFire)
		return 0;

	// Evaluate any conditions
	if (!ValidateConditions(Attacker, XComGameState_BaseObject(TargetDamageable), AbilityState))
		return 0;

	return ArmorPierce;
}


private function bool ValidateConditions(XComGameState_Unit Attacker, XComGameState_BaseObject TargetObject, XComGameState_Ability AbilityState)
{
	local int	Index;
	local name	AvailableCode;

	if (BonusDamageConditions.Length > 0)
	{
		for (Index = 0; Index < BonusDamageConditions.Length; ++Index)
		{
			AvailableCode = BonusDamageConditions[Index].MeetsCondition(TargetObject);
			if (AvailableCode != 'AA_Success')
				return false;

			AvailableCode = BonusDamageConditions[Index].MeetsConditionWithSource(TargetObject, Attacker);
			if (AvailableCode != 'AA_Success')
				return false;

			AvailableCode = BonusDamageConditions[Index].AbilityMeetsCondition(AbilityState, TargetObject);
			if (AvailableCode != 'AA_Success')
				return false;
	}	}

	return true;
}



defaultproperties
{
	bApplyToPrimary = true
	bDisplayInSpecialDamageMessageUI = true
}