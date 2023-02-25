
class X2Effect_WOTC_APA_AdaptivePlatingRegen extends X2Effect;


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit		TargetUnit;
	local int						TargetArmor, TargetShredded;
	local bool									bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	TargetUnit = XComGameState_Unit(kNewTargetState);
	TargetArmor = TargetUnit.GetCurrentStat(eStat_ArmorMitigation);
	TargetShredded = TargetUnit.Shredded;

	/**/`Log("WOTC_APA_Specialist - AdaptivePlatingRegen: Target's (" $ TargetUnit.GetFullName() $ ") Total Armor is" @ TargetArmor, bLog);
	/**/`Log("WOTC_APA_Specialist - AdaptivePlatingRegen: Target has had" @ TargetShredded @ "Armor Shredded", bLog);

	if (TargetArmor - TargetShredded < class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.ADAPTIVE_PLATING_ARMOR)
	{
		/**/`Log("WOTC_APA_Specialist - AdaptivePlatingRegen: Total Armor (" $ TargetArmor $ ") - Shredded Armor (" $ TargetShredded $ ") is less than regen value (" $ class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.ADAPTIVE_PLATING_ARMOR $ ")... restoring one shredded armor", bLog);
		TargetUnit.AddShreddedValue(-1);
		NewGameState.GetContext().PostBuildVisualizationFn.AddItem(class'X2Ability_WOTC_APA_Utilities'.static.BasicSourceFlyover_BuildVisualization);
	}
}