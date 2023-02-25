
class X2Effect_WOTC_APA_ReviveVisualization extends X2Effect_Persistent;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit	TargetUnit;

	TargetUnit = XComGameState_Unit(kNewTargetState);
	
	if (TargetUnit.bBleedingOut || TargetUnit.bUnconscious)
	{
		//NewGameState.GetContext().PostBuildVisualizationFn.AddItem(class'X2StatusEffects'.static.UnconsciousVisualizationRemoved);
		VisualizationFn = class'X2StatusEffects'.static.UnconsciousVisualizationRemoved;
	}
}