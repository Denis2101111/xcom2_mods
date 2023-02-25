
class X2Effect_WOTC_APA_ShockAndMaul extends X2Effect_Persistent;


function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	local XComGameState_Item				SourceWeapon;
    local X2Effect_ApplyWeaponDamage		WeaponDamageEffect;
	local X2AbilityToHitCalc_StandardAim	StandardHit;
	local X2Effect_ApplyWeaponDamage		DamageEffect;
	local UnitValue							UnitValue;
	local XComGameState_Unit				TargetUnit;
	local int								iBonusDamage;
	
	// Only apply when the damage effect is applying the weapon's base damage
	if (NewGameState != none)
	{
		DamageEffect = X2Effect_ApplyWeaponDamage(class'X2Effect'.static.GetX2Effect(AppliedData.EffectRef));
		if (DamageEffect == none || DamageEffect.bIgnoreBaseDamage)
		{
			return 0;
	}	}

	// Attack must hit
	if (class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult))
	{
		// Attack must originate from Attacker's Primary or Secondary weapon (No grenades, heavy weapons, etc.)
		if (AbilityState.GetSourceWeapon().ObjectID != Attacker.GetItemInSlot(eInvSlot_PrimaryWeapon).ObjectID && AbilityState.GetSourceWeapon().ObjectID != Attacker.GetItemInSlot(eInvSlot_SecondaryWeapon).ObjectID)
		{
			return 0;
		}

		// Attack must use a weapon's standard attack damage
		WeaponDamageEffect = X2Effect_ApplyWeaponDamage(class'X2Effect'.static.GetX2Effect(AppliedData.EffectRef));
		if (WeaponDamageEffect != none)
		{			
			if (WeaponDamageEffect.bIgnoreBaseDamage)
			{	
				return 0;		
		}	}
		
		// Does not apply to Indirect Fire abilities
		StandardHit = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
		if(StandardHit != none && StandardHit.bIndirectFire) 
		{
			return 0;
		}

		// TargetUnit must be either disoriented or stunned
		TargetUnit = XComGameState_Unit(TargetDamageable);
		if (TargetUnit.AffectedByEffectNames.Find(class'X2AbilityTemplateManager'.default.DisorientedName) != -1 || TargetUnit.AffectedByEffectNames.Find(class'X2AbilityTemplateManager'.default.StunnedName) != -1)
		{
			iBonusDamage += class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.SHOCK_AND_MAUL_DAMAGE_BONUS;

			// If TargetUnit is within the Attacker's CQC range, add the additional conditional bonus damage
			if (Attacker.GetUnitValue(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_RADIUS_NAME, UnitValue))	
			{
				// Distance between Attacker and Target units must be less than the Source's CQC range
				if (Attacker.TileDistanceBetween(TargetUnit) <= UnitValue.fValue)
				{
					iBonusDamage += class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.SHOCK_AND_MAUL_CONDITIONAL_DAMAGE_BONUS;					
			}	}

			return iBonusDamage;
	}	}	
			
	return 0;
}


defaultproperties
{
	bDisplayInSpecialDamageMessageUI = true
}