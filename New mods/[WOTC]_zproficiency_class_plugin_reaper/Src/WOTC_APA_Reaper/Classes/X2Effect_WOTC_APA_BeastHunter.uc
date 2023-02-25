class X2Effect_WOTC_APA_BeastHunter extends X2Effect_Persistent;

var() int BonusDamage;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	local XComGameState_Unit TargetUnit;
	local UnitValue DamageUnitValue;
	local X2AbilityToHitCalc_StandardAim StandardHit;
	local X2Effect_ApplyWeaponDamage		DamageEffect;

	// Only apply when the damage effect is applying the weapon's base damage
	if (NewGameState != none)
	{
		DamageEffect = X2Effect_ApplyWeaponDamage(class'X2Effect'.static.GetX2Effect(AppliedData.EffectRef));
		if (DamageEffect == none || DamageEffect.bIgnoreBaseDamage)
		{
			return 0;
	}	}

	// Do not apply to actions dealing no damage
	if (!class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult) || CurrentDamage == 0)
		return 0;

	StandardHit = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
	if (StandardHit == none || StandardHit.bIndirectFire)
	{
		return 0;
	}

	if (class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult))
	{
		TargetUnit = XComGameState_Unit(TargetDamageable);
		if (TargetUnit != none)
		{
			if (class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.BEAST_HUNTER_ENEMY_TYPES.Find(TargetUnit.GetMyTemplate().CharacterGroupName) != -1)
			{
				return BonusDamage;
	}	}	}
	
	return 0;
}


function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local XComGameState_Item	SourceWeapon;
	local ShotModifierInfo		ShotInfo;
	local UnitValue				ShadowStacksValue;
	local int					BonusAmount;

	SourceWeapon = AbilityState.GetSourceWeapon();
	if (SourceWeapon != none && !bIndirectFire && Target != none)
	{
		if (class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.BEAST_HUNTER_ENEMY_TYPES.Find(Target.GetMyTemplate().CharacterGroupName) != -1)
		{
			Attacker.GetUnitValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CURRENT_NAME, ShadowStacksValue);
			BonusAmount = class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CRIT_CHANCE_BONUS * ShadowStacksValue.fValue;
			BonusAmount = Round(BonusAmount * (class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.BEAST_HUNTER_SHADOW_CRIT_CHANCE_MOD - 1));

			if (BonusAmount > 0)
			{
				ShotInfo.ModType = eHit_Crit;
				ShotInfo.Reason = FriendlyName;
				ShotInfo.Value = BonusAmount;
				ShotModifiers.AddItem(ShotInfo);
	}	}	}
}



DefaultProperties
{
	DuplicateResponse = eDupe_Ignore
	bDisplayInSpecialDamageMessageUI = true
}
