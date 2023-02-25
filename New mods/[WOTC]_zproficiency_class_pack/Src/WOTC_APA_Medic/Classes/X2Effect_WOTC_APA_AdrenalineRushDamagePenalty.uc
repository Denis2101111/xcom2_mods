
class X2Effect_WOTC_APA_AdrenalineRushDamagePenalty extends X2Effect_Persistent;


function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	if (CurrentDamage > 0)
		return (-1 * CurrentDamage * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.ADRENALINE_RUSH_DAMAGE_PENALTY);
}


DefaultProperties
{
	EffectName = "WOTC_APA_AdrenalineRushDamagePenalty"
	DuplicateResponse = eDupe_Ignore
}