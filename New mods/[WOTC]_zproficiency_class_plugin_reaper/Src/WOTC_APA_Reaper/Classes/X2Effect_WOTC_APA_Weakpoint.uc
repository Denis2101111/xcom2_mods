
class X2Effect_WOTC_APA_Weakpoint extends X2Effect_Persistent;


function int GetExtraArmorPiercing(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData)
{
	local XComGameState_Item				SlotItem;
	local bool								bSourceIsSlotItem;
	local X2AbilityToHitCalc_StandardAim	StandardHit;
	local UnitValue							ShadowStacksValue;


	// Ability source weapon must match effect source weapon
	if (AbilityState.SourceWeapon != EffectState.ApplyEffectParameters.ItemStateObjectRef)
		return 0;

	// Exclude indirect attacks
	StandardHit = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
	if (StandardHit.bIndirectFire)
		return 0;

	Attacker.GetUnitValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CURRENT_NAME, ShadowStacksValue);

	if (ShadowStacksValue.fValue >= class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_VALUE_THRESHOLD_III)
		return class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.WEAKPOINT_ARMOR_PIERCE_III;

	if (ShadowStacksValue.fValue >= class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_VALUE_THRESHOLD_II)
		return class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.WEAKPOINT_ARMOR_PIERCE_II;

	if (ShadowStacksValue.fValue >= class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_VALUE_THRESHOLD_I)
		return class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.WEAKPOINT_ARMOR_PIERCE_I;
		
	return 0;
}