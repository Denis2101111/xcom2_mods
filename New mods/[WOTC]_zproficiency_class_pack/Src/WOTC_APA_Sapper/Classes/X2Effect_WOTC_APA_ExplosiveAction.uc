
class X2Effect_WOTC_APA_ExplosiveAction extends X2Effect_Persistent;


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit TargetUnit;

	TargetUnit = XComGameState_Unit(kNewTargetState);
	if (TargetUnit != none)
		TargetUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);
}


function ModifyTurnStartActionPoints(XComGameState_Unit UnitState, out array<name> ActionPoints, XComGameState_Effect EffectState)
{
	local int i, APIndex;

	for (i = 0; i < class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ACTION_ACTIONS_LOSE; ++i)
	{
		// Prioritze removing movement-only action points, if possible
		APIndex = ActionPoints.Find(class'X2CharacterTemplateManager'.default.MoveActionPoint);
		if (APIndex != INDEX_NONE)
		{
			ActionPoints.Remove(APIndex, 1);
			continue;
		}

		// Remove standard actions if no movement-only actions were present
		APIndex = ActionPoints.Find(class'X2CharacterTemplateManager'.default.StandardActionPoint);
		if (APIndex != INDEX_NONE)
		{
			ActionPoints.Remove(APIndex, 1);
		}
	}
}