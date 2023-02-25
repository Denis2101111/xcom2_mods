
class X2Effect_WOTC_APA_Opportunist extends X2Effect_Persistent;

var int BonusDamage;
var int BonusCritChance;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	local XComGameState_Unit				TargetUnit;
	local GameRulesCache_VisibilityInfo		VisInfo;
	local X2Effect_ApplyWeaponDamage		DamageEffect;
	local X2AbilityToHitCalc_StandardAim	StandardHit;

	// Only apply when the damage effect is applying the weapon's base damage
	if (NewGameState != none)
	{
		DamageEffect = X2Effect_ApplyWeaponDamage(class'X2Effect'.static.GetX2Effect(AppliedData.EffectRef));
		if (DamageEffect == none || DamageEffect.bIgnoreBaseDamage)
		{
			return 0;
	}	}

	// Does not apply to Indirect Fire abilities
	StandardHit = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
	if(StandardHit != none && StandardHit.bIndirectFire) 
	{
		return 0;
	}

	TargetUnit = XComGameState_Unit(TargetDamageable);
	if (!AbilityState.IsMeleeAbility() && TargetUnit != None && class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult))
	{
		if (AbilityState.GetSourceWeapon().InventorySlot == eInvSlot_PrimaryWeapon || AbilityState.GetSourceWeapon().InventorySlot == eInvSlot_SecondaryWeapon)
		{
			if (`TACTICALRULES.VisibilityMgr.GetVisibilityInfo(Attacker.ObjectID, TargetUnit.ObjectID, VisInfo))
			{
				if (Attacker.CanFlank() && TargetUnit.GetMyTemplate().bCanTakeCover && VisInfo.TargetCover == CT_None)
				{
					return BonusDamage;
				}
			}
		}
	}
	return 0;
}

function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local ShotModifierInfo ShotMod;

	if (AbilityState.IsMeleeAbility() && Target != none)
	{
		ShotMod.ModType = eHit_Crit;
		ShotMod.Reason = FriendlyName;
		ShotMod.Value = BonusCritChance;
		ShotModifiers.AddItem(ShotMod);
	}
}

DefaultProperties
{
	DuplicateResponse = eDupe_Ignore
	bDisplayInSpecialDamageMessageUI = true
}
