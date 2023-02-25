
class X2Action_WOTC_APA_StartZoneSuppression extends X2Action;

var XGUnit					SourceUnit, TargetUnit;
var X2VisualizerInterface	PrimaryTarget;


function Init()
{
	local XComGameStateContext_Ability	AbilityContext;
	local Actor							TargetVisualizer;
	local int							PrimaryTargetID;

	super.Init();

	SourceUnit = XGUnit(Metadata.VisualizeActor);
	AbilityContext = XComGameStateContext_Ability(StateChangeContext);
	if (AbilityContext.InputContext.PrimaryTarget.ObjectID == 0)
	{
		PrimaryTargetID = AbilityContext.InputContext.MultiTargets[0].ObjectID;
		if (PrimaryTargetID > 0)
		{
			TargetVisualizer = `XCOMHISTORY.GetGameStateForObjectID(PrimaryTargetID).GetVisualizer();
			TargetUnit = XGUnit(TargetVisualizer);
			PrimaryTarget = X2VisualizerInterface(TargetVisualizer);
		}
	}
}

function bool CheckInterrupted()
{
	return false;
}

simulated state Executing
{
Begin:
	if (SourceUnit.IsMine())
		SourceUnit.UnitSpeak('Suppressing');
	else if (TargetUnit.IsMine())
		TargetUnit.UnitSpeak('Suppressed');

	if (TargetUnit != none)
	{
		SourceUnit.ConstantCombatSuppress(true, TargetUnit);
	}

	SourceUnit.ConstantCombatSuppressArea(false);
	SourceUnit.IdleStateMachine.CheckForStanceUpdate();

	CompleteAction();
}