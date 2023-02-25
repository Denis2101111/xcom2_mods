class X2Effect_WOTC_APA_ApplyWeaponDamage extends X2Effect_ApplyWeaponDamage;

simulated function GetDamagePreview(StateObjectReference TargetRef, XComGameState_Ability AbilityState, bool bAsPrimaryTarget, out WeaponDamageValue MinDamagePreview, out WeaponDamageValue MaxDamagePreview, out int AllowsShield)
{
	local XComGameStateHistory History;
	local XComGameState_Unit TargetUnit, SourceUnit;
	local XComGameState_Item SourceWeapon, LoadedAmmo;
	local WeaponDamageValue UpgradeTemplateBonusDamage, BaseDamageValue, ExtraDamageValue, AmmoDamageValue, BonusEffectDamageValue, UpgradeDamageValue;
	local X2Condition ConditionIter;
	local name AvailableCode;
	local X2AmmoTemplate AmmoTemplate;
	local StateObjectReference EffectRef;
	local XComGameState_Effect EffectState;
	local X2Effect_Persistent EffectTemplate;
	local X2Effect_BonusWeaponDamage BonusEffectTemplate;
	local int EffectDmg, UnconditionalShred, BaseEffectDmgModMin, BaseEffectDmgModMax;
	local EffectAppliedData TestEffectParams;
	local name DamageType;
	local array<X2WeaponUpgradeTemplate> WeaponUpgradeTemplates;
	local X2WeaponUpgradeTemplate WeaponUpgradeTemplate;
	local array<Name> AppliedDamageTypes;
	local bool bDoesDamageIgnoreShields;
	local DamageModifierInfo DamageModInfo;

	MinDamagePreview = UpgradeTemplateBonusDamage;
	MaxDamagePreview = UpgradeTemplateBonusDamage;
	bDoesDamageIgnoreShields = bBypassShields;

	if (!bApplyOnHit)
		return;

	History = `XCOMHISTORY;

	if (AbilityState.SourceAmmo.ObjectID > 0)
		SourceWeapon = AbilityState.GetSourceAmmo();
	else
		SourceWeapon = AbilityState.GetSourceWeapon();

	TargetUnit = XComGameState_Unit(History.GetGameStateForObjectID(TargetRef.ObjectID));
	SourceUnit = XComGameState_Unit(History.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));

	if (TargetUnit != None)
	{
		foreach TargetConditions(ConditionIter)
		{
			AvailableCode = ConditionIter.AbilityMeetsCondition(AbilityState, TargetUnit);
			if (AvailableCode != 'AA_Success')
				return;
			AvailableCode = ConditionIter.MeetsCondition(TargetUnit);
			if (AvailableCode != 'AA_Success')
				return;
			AvailableCode = ConditionIter.MeetsConditionWithSource(TargetUnit, SourceUnit);
			if (AvailableCode != 'AA_Success')
				return;
		}
		foreach DamageTypes(DamageType)
		{
			if (TargetUnit.IsImmuneToDamage(DamageType))
				return;
		}
	}
	
	if (bAlwaysKillsCivilians && TargetUnit != None && TargetUnit.GetTeam() == eTeam_Neutral)
	{
		MinDamagePreview.Damage = TargetUnit.GetCurrentStat(eStat_HP) + TargetUnit.GetCurrentStat(eStat_ShieldHP);
		MaxDamagePreview = MinDamagePreview;
		return;
	}
	if (SourceWeapon != None)
	{
		if (!bIgnoreBaseDamage)
		{
			SourceWeapon.GetBaseWeaponDamageValue(TargetUnit, BaseDamageValue);
			ModifyDamageValue(BaseDamageValue, TargetUnit, AppliedDamageTypes);
		}
		if (DamageTag != '')
		{
			SourceWeapon.GetWeaponDamageValue(TargetUnit, DamageTag, ExtraDamageValue);
			ModifyDamageValue(ExtraDamageValue, TargetUnit, AppliedDamageTypes);
		}
		if (SourceWeapon.HasLoadedAmmo() && !bIgnoreBaseDamage)
		{
			LoadedAmmo = XComGameState_Item(History.GetGameStateForObjectID(SourceWeapon.LoadedAmmo.ObjectID));
			AmmoTemplate = X2AmmoTemplate(LoadedAmmo.GetMyTemplate()); 
			if (AmmoTemplate != None)
			{
				AmmoTemplate.GetTotalDamageModifier(LoadedAmmo, SourceUnit, TargetUnit, AmmoDamageValue);
				bDoesDamageIgnoreShields = AmmoTemplate.bBypassShields || bDoesDamageIgnoreShields;
			}
			else
			{
				LoadedAmmo.GetBaseWeaponDamageValue(TargetUnit, AmmoDamageValue);
			}
			ModifyDamageValue(AmmoDamageValue, TargetUnit, AppliedDamageTypes);
		}
		if (bAllowWeaponUpgrade)
		{
			WeaponUpgradeTemplates = SourceWeapon.GetMyWeaponUpgradeTemplates();
			foreach WeaponUpgradeTemplates(WeaponUpgradeTemplate)
			{
				if (WeaponUpgradeTemplate.BonusDamage.Tag == DamageTag)
				{
					UpgradeTemplateBonusDamage = WeaponUpgradeTemplate.BonusDamage;

					ModifyDamageValue(UpgradeTemplateBonusDamage, TargetUnit, AppliedDamageTypes);

					UpgradeDamageValue.Damage += UpgradeTemplateBonusDamage.Damage;
					UpgradeDamageValue.Spread += UpgradeTemplateBonusDamage.Spread;
					UpgradeDamageValue.Crit += UpgradeTemplateBonusDamage.Crit;
					UpgradeDamageValue.Pierce += UpgradeTemplateBonusDamage.Pierce;
					UpgradeDamageValue.Rupture += UpgradeTemplateBonusDamage.Rupture;
					UpgradeDamageValue.Shred += UpgradeTemplateBonusDamage.Shred;
					//  ignores PlusOne as there is no good way to add them up
				}
			}
		}
	}
	BonusEffectDamageValue = GetBonusEffectDamageValue(AbilityState, SourceUnit, SourceWeapon, TargetRef);
	ModifyDamageValue(BonusEffectDamageValue, TargetUnit, AppliedDamageTypes);

	MinDamagePreview.Damage = BaseDamageValue.Damage + ExtraDamageValue.Damage + AmmoDamageValue.Damage + BonusEffectDamageValue.Damage + UpgradeDamageValue.Damage -
							  BaseDamageValue.Spread - ExtraDamageValue.Spread - AmmoDamageValue.Spread - BonusEffectDamageValue.Spread - UpgradeDamageValue.Spread;

	MaxDamagePreview.Damage = BaseDamageValue.Damage + ExtraDamageValue.Damage + AmmoDamageValue.Damage + BonusEffectDamageValue.Damage + UpgradeDamageValue.Damage +
							  BaseDamageValue.Spread + ExtraDamageValue.Spread + AmmoDamageValue.Spread + BonusEffectDamageValue.Spread + UpgradeDamageValue.Spread;

	MinDamagePreview.Pierce = BaseDamageValue.Pierce + ExtraDamageValue.Pierce + AmmoDamageValue.Pierce + BonusEffectDamageValue.Pierce + UpgradeDamageValue.Pierce;
	MaxDamagePreview.Pierce = MinDamagePreview.Pierce;
	
	MinDamagePreview.Shred = BaseDamageValue.Shred + ExtraDamageValue.Shred + AmmoDamageValue.Shred + BonusEffectDamageValue.Shred + UpgradeDamageValue.Shred;
	MaxDamagePreview.Shred = MinDamagePreview.Shred;

	MinDamagePreview.Rupture = BaseDamageValue.Rupture + ExtraDamageValue.Rupture + AmmoDamageValue.Rupture + BonusEffectDamageValue.Rupture + UpgradeDamageValue.Rupture;
	MaxDamagePreview.Rupture = MinDamagePreview.Rupture;

	if (BaseDamageValue.PlusOne > 0)
		MaxDamagePreview.Damage++;
	if (ExtraDamageValue.PlusOne > 0)
		MaxDamagePreview.Damage++;
	if (AmmoDamageValue.PlusOne > 0)
		MaxDamagePreview.Damage++;
	if (BonusEffectDamageValue.PlusOne > 0)
		MaxDamagePreview.Damage++;

	TestEffectParams.AbilityInputContext.AbilityRef = AbilityState.GetReference();
	TestEffectParams.AbilityInputContext.AbilityTemplateName = AbilityState.GetMyTemplateName();
	TestEffectParams.ItemStateObjectRef = AbilityState.SourceWeapon;
	TestEffectParams.AbilityStateObjectRef = AbilityState.GetReference();
	TestEffectParams.SourceStateObjectRef = SourceUnit.GetReference();
	TestEffectParams.PlayerStateObjectRef = SourceUnit.ControllingPlayer;
	TestEffectParams.TargetStateObjectRef = TargetRef;
	if (bAsPrimaryTarget)
		TestEffectParams.AbilityInputContext.PrimaryTarget = TargetRef;

	if (TargetUnit != none)
	{
		foreach TargetUnit.AffectedByEffects(EffectRef)
		{
			EffectState = XComGameState_Effect(History.GetGameStateForObjectID(EffectRef.ObjectID));
			EffectTemplate = EffectState.GetX2Effect();
			EffectDmg = EffectTemplate.GetBaseDefendingDamageModifier(EffectState, SourceUnit, Damageable(TargetUnit), AbilityState, TestEffectParams, MinDamagePreview.Damage, self);
			BaseEffectDmgModMin += EffectDmg;
			if (EffectDmg != 0)
			{
				DamageModInfo.SourceEffectRef = EffectState.ApplyEffectParameters.EffectRef;
				DamageModInfo.Value = EffectDmg;
				MinDamagePreview.BonusDamageInfo.AddItem(DamageModInfo);
			}
			EffectDmg = EffectTemplate.GetBaseDefendingDamageModifier(EffectState, SourceUnit, Damageable(TargetUnit), AbilityState, TestEffectParams, MaxDamagePreview.Damage, self);
			BaseEffectDmgModMax += EffectDmg;
			if (EffectDmg != 0)
			{
				DamageModInfo.SourceEffectRef = EffectState.ApplyEffectParameters.EffectRef;
				DamageModInfo.Value = EffectDmg;
				MaxDamagePreview.BonusDamageInfo.AddItem(DamageModInfo);
			}
		}
		MinDamagePreview.Damage += BaseEffectDmgModMin;
		MaxDamagePreview.Damage += BaseEffectDmgModMax;
	}

	foreach SourceUnit.AffectedByEffects(EffectRef)
	{
		EffectState = XComGameState_Effect(History.GetGameStateForObjectID(EffectRef.ObjectID));
		EffectTemplate = EffectState.GetX2Effect();
		BonusEffectTemplate = X2Effect_BonusWeaponDamage(EffectState.GetX2Effect());

		if (!bIgnoreBaseDamage || BonusEffectTemplate == none)
		{
			EffectDmg = EffectTemplate.GetAttackingDamageModifier(EffectState, SourceUnit, Damageable(TargetUnit), AbilityState, TestEffectParams, MinDamagePreview.Damage);
			MinDamagePreview.Damage += EffectDmg;
			if( EffectDmg != 0 )
			{
				DamageModInfo.SourceEffectRef = EffectState.ApplyEffectParameters.EffectRef;
				DamageModInfo.Value = EffectDmg;
				MinDamagePreview.BonusDamageInfo.AddItem(DamageModInfo);
			}
			EffectDmg = EffectTemplate.GetAttackingDamageModifier(EffectState, SourceUnit, Damageable(TargetUnit), AbilityState, TestEffectParams, MaxDamagePreview.Damage);
			MaxDamagePreview.Damage += EffectDmg;
			if( EffectDmg != 0 )
			{
				DamageModInfo.SourceEffectRef = EffectState.ApplyEffectParameters.EffectRef;
				DamageModInfo.Value = EffectDmg;
				MaxDamagePreview.BonusDamageInfo.AddItem(DamageModInfo);
			}

			EffectDmg = EffectTemplate.GetExtraArmorPiercing(EffectState, SourceUnit, Damageable(TargetUnit), AbilityState, TestEffectParams);
			MinDamagePreview.Pierce += EffectDmg;
			MaxDamagePreview.Pierce += EffectDmg;

			EffectDmg = EffectTemplate.GetExtraShredValue(EffectState, SourceUnit, Damageable(TargetUnit), AbilityState, TestEffectParams);
			MinDamagePreview.Shred += EffectDmg;
			MaxDamagePreview.Shred += EffectDmg;
		}
	}

	// run through the effects again for any conditional shred.  A second loop as it is possibly dependent on shred outcome of the unconditional first loop.
	UnconditionalShred = MinDamagePreview.Shred;
	foreach SourceUnit.AffectedByEffects(EffectRef)
	{
		EffectState = XComGameState_Effect(History.GetGameStateForObjectID(EffectRef.ObjectID));
		EffectTemplate = EffectState.GetX2Effect();

		EffectDmg = EffectTemplate.GetConditionalExtraShredValue(UnconditionalShred, EffectState, SourceUnit, Damageable(TargetUnit), AbilityState, TestEffectParams);
		MinDamagePreview.Shred += EffectDmg;
		MaxDamagePreview.Shred += EffectDmg;
	}

	if (TargetUnit != none)
	{
		foreach TargetUnit.AffectedByEffects(EffectRef)
		{
			EffectState = XComGameState_Effect(History.GetGameStateForObjectID(EffectRef.ObjectID));
			EffectTemplate = EffectState.GetX2Effect();
			EffectDmg = EffectTemplate.GetDefendingDamageModifier(EffectState, SourceUnit, Damageable(TargetUnit), AbilityState, TestEffectParams, MinDamagePreview.Damage, self);
			MinDamagePreview.Damage += EffectDmg;
			if( EffectDmg != 0 )
			{
				DamageModInfo.SourceEffectRef = EffectState.ApplyEffectParameters.EffectRef;
				DamageModInfo.Value = EffectDmg;
				MinDamagePreview.BonusDamageInfo.AddItem(DamageModInfo);
			}
			EffectDmg = EffectTemplate.GetDefendingDamageModifier(EffectState, SourceUnit, Damageable(TargetUnit), AbilityState, TestEffectParams, MaxDamagePreview.Damage, self);
			MaxDamagePreview.Damage += EffectDmg;
			if (EffectDmg != 0)
			{
				DamageModInfo.SourceEffectRef = EffectState.ApplyEffectParameters.EffectRef;
				DamageModInfo.Value = EffectDmg;
				MaxDamagePreview.BonusDamageInfo.AddItem(DamageModInfo);
			}
		}
	}
	if (!bDoesDamageIgnoreShields)
		AllowsShield += MaxDamagePreview.Damage;
}