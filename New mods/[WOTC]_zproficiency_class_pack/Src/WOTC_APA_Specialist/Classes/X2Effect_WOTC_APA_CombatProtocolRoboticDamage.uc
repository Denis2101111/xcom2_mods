class X2Effect_WOTC_APA_CombatProtocolRoboticDamage extends X2Effect_Persistent;

var int Gremlin_Tier;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState) 
{
	local int					BaseDmg;
	local float					Multiplier;			
	local XComGameState_Unit	TargetUnit;

	// Only applies to Combat Protocol and only applies against Robotic enemies
	if (AbilityState.GetMyTemplateName() != 'WOTC_APA_CombatProtocol')
		return 0;

	TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AppliedData.TargetStateObjectRef.ObjectID));
	if (!TargetUnit.IsRobotic())
		return 0;

	// Get base damage before multiplying
	BaseDmg = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_DAMAGE_T1_BASE;
	if (Gremlin_Tier == 2)
		BaseDmg = BaseDmg + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_DAMAGE_T2_BONUS;

	if (Gremlin_Tier > 2)
		BaseDmg = BaseDmg + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_DAMAGE_T3_BONUS;

	// Get Multiplier
	if (Attacker.HasSoldierAbility('WOTC_APA_Overload'))
		Multiplier = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.OVERLOAD_MECH_DAMAGE_MULTIPLIER;
	else
		Multiplier = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_MECH_DAMAGE_MULTIPLIER;

	return Round(BaseDmg * Multiplier);
}


defaultproperties
{
	bDisplayInSpecialDamageMessageUI = true
}