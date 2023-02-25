
class X2Effect_WOTC_APA_GrenadeCriticals extends X2Effect_BiggestBooms;


function bool AllowCritOverride() { return true; }

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	local X2AbilityToHitCalc_StandardAim StandardHit;

	if (AppliedData.AbilityResultContext.HitResult == eHit_Crit && ValidateSourceWeapon(AbilityState))
	{
		StandardHit = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
		if (StandardHit != none && StandardHit.bIndirectFire)
		{
			return default.CRIT_DAMAGE_BONUS;
		}
	}
}

function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local ShotModifierInfo BoomInfo;

	if (bIndirectFire && ValidateSourceWeapon(AbilityState))
	{
		BoomInfo.ModType = eHit_Crit;
		BoomInfo.Value = default.CRIT_CHANCE_BONUS;
		BoomInfo.Reason = FriendlyName;
		ShotModifiers.AddItem(BoomInfo);
	}
}


// Make sure the weapon is a damaging grenade or heavy weapon, with Destructive Nature
function bool ValidateSourceWeapon(XComGameState_Ability AbilityState)
{
	local XComGameState_Unit		UnitState;
	local XComGameState_Item		SourceAmmo, SourceWeapon;
	local X2GrenadeTemplate			SourceGrenade;
	local X2WeaponTemplate			WeaponTemplate;

	SourceWeapon = AbilityState.GetSourceWeapon();
	if (SourceWeapon == none)
		return false;

	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
	if (UnitState.AffectedByEffectNames.Find('WOTC_APA_DestructiveNatureEffect') != -1)
	{
		WeaponTemplate = X2WeaponTemplate(SourceWeapon.GetMyTemplate());
		if (WeaponTemplate.WeaponCat == 'heavy')
		{
			return true;
	}	}
	
	SourceAmmo = AbilityState.GetSourceAmmo();
	if (SourceAmmo == none)
	{
		SourceAmmo = AbilityState.GetSourceWeapon();
		if (SourceAmmo == none)
		{
			return false;
	}	}

	SourceGrenade = X2GrenadeTemplate(SourceAmmo.GetMyTemplate());
	if (SourceGrenade != none)
	{
		if (SourceGrenade.BaseDamage.Damage > 0)
		{
			return true;
	}	}

	return false;
}


defaultproperties
{
	bDisplayInSpecialDamageMessageUI=true
}
