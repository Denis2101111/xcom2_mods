
class X2Effect_WOTC_APA_AppliedKnowledgeCritModifier extends X2Effect_Persistent;


// Add bonus chance to critically hit with the primary weapon
function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local ShotModifierInfo ModInfo;
	local XComGameState_Item SourceWeapon;

	SourceWeapon = AbilityState.GetSourceWeapon();
	//  Make sure the source weapon is the primary weapon
	if (SourceWeapon != none && SourceWeapon.InventorySlot == eInvSlot_PrimaryWeapon && AutopsyCondition(Target))
	{
		ModInfo.ModType = eHit_Crit;
		ModInfo.Reason = FriendlyName;
		ModInfo.Value = class'X2Ability_WOTC_APA_MedicAbilitySet'.default.APPLIED_KNOWLEDGE_CRIT_CHANCE_BONUS;
		ShotModifiers.AddItem(ModInfo);
	}

}


// Add bonus damage on critical hits against organic targets
function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	local XComGameState_Item SourceWeapon;
	local XComGameState_Unit TargetUnit;
	local X2Effect_ApplyWeaponDamage DamageEffect;

	// Only apply when the damage effect is applying the weapon's base damage
	if (NewGameState != none)
	{
		DamageEffect = X2Effect_ApplyWeaponDamage(class'X2Effect'.static.GetX2Effect(AppliedData.EffectRef));
		if (DamageEffect == none || DamageEffect.bIgnoreBaseDamage)
		{
			return 0;
	}	}

	//  Only add bonus damage on a crit
	if (AppliedData.AbilityResultContext.HitResult == eHit_Crit)
	{
		SourceWeapon = AbilityState.GetSourceWeapon();
		//  Make sure the source weapon is the primary weapon
		if (SourceWeapon != none && SourceWeapon.InventorySlot == eInvSlot_PrimaryWeapon)
		{
			//  Only provide bonus damage against organic units
			TargetUnit = XComGameState_Unit(TargetDamageable);
			if (TargetUnit != none && !TargetUnit.IsRobotic() && AutopsyCondition(TargetUnit))
			{
				return Round(CurrentDamage * (class'X2Ability_WOTC_APA_MedicAbilitySet'.default.APPLIED_KNOWLEDGE_CRIT_DAMAGE_BONUS / 100));
			}
		}
	}
	return 0;
}


function bool AutopsyCondition(XComGameState_Unit TargetUnit)
{ 
	local name AutopsyName, CharacterGroupName;

	CharacterGroupName = TargetUnit.GetMyTemplate().CharacterGroupName;

	// Search for Mod-added Captains that cannot be flagged as such (due to base-game bugs) and try to correct for the effect
	if (class'WOTC_APA_Class_Utilities_Effects'.default.MOD_ADDED_CAPTAINS_FLAGGED_AS_OTHERS.Find(TargetUnit.GetMyTemplateName()) != -1)
		CharacterGroupName = 'AdventCaptain';
	
	switch (CharacterGroupName)
	{
		case 'AdventCaptain':
		case 'AdventGeneral':
		case 'AssaultTrooperCaptn': // Advent Assault Troopers
		case 'AdventPathfinderCaptain': // Pathfinders
			AutopsyName = 'AutopsyAdventOfficer';
			break;
		case 'DarkXComSoldier': // MOCX Soldiers
		case 'AdventPathfinder': // Pathfinders
		case 'AssaultTrooperT1': // Advent Assault Troopers
		case 'AssaultTrooperT2': // Advent Assault Troopers
		case 'AssaultTrooperT3': // Advent Assault Troopers
			AutopsyName = 'AutopsyAdventTrooper';
			break;
		case 'AdventWarlock': // Advent Warlock
			AutopsyName = 'Autopsy_AshAdvWarlock';
			break;
		case 'Muton Harrier': // Muton Harriers
		case 'Muton Beleaguer': // Muton Harriers
		case 'Muton Devastator': // Muton Harriers
		case 'Muton Harrier Captain': // Muton Harriers
		case 'Muton Beleaguer Captain': // Muton Harriers
			AutopsyName = 'AutopsyMuton';
			break;
		case 'Riftkeeper': // LEB's Riftkeeper
			AutopsyName = 'AutopsyGatekeeper';
			break;
		case 'EUBerserker': // EU Berserker
		case 'BerserkerOmega': // Berserker Omega
			AutopsyName = 'AutopsyBerserker';
			break;
		default:
			AutopsyName = name("Autopsy" $ TargetUnit.GetMyTemplate().CharacterGroupName);
			break;
	}

	if (class'UIUtilities_Strategy'.static.GetXComHQ().IsTechResearched(AutopsyName))
	{
		return true;
	}

	return false;
}