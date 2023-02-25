
class X2Effect_WOTC_APA_Class_FallBack extends X2Effect;

var name	BehaviorTree;
var int		ChanceToApply;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit		UnitState;
	local Name						FallBackBehaviorTree;
	local bool						bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;
	
	UnitState = XComGameState_Unit(kNewTargetState);
	if (UnitState == none)
		return;

	if (UnitState.IsStunned())
		return;

	// Roll for chance to apply - exit on failure
	if (ChanceToApply < 100)
	{
		if (`SYNC_RAND_STATIC(100) > ChanceToApply)
		{
			return;
	}	}


	// Add one standard action point for fallback actions.
	if (UnitState.ActionPoints.Length == 0)
	{
		UnitState.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.MoveActionPoint);
	}
	else
	{
		UnitState.ActionPoints[0] = class'X2CharacterTemplateManager'.default.MoveActionPoint;
	}


	// Fallback removes overwatch
	UnitState.ReserveActionPoints.Length = 0;


	// Kick off fallback behavior tree.
	FallBackBehaviorTree = BehaviorTree;
	UnitState.AutoRunBehaviorTree(FallBackBehaviorTree, 1, `XCOMHISTORY.GetCurrentHistoryIndex() + 1, true);
	
	return;
}


DefaultProperties
{
	BehaviorTree = 'WOTC_APA_FallbackUnsafe'
	ChanceToApply = 100
}