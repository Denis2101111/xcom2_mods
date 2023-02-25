
class X2Effect_WOTC_APA_HitAndRun extends X2Effect_Persistent;

var int		HitAndRunActivations;
var name	HitAndRunActivationsUnitName;


function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	local XComGameState_Unit					TargetUnit;
	local X2AbilityTemplateManager				AbilityTemplateMgr;
	local X2AbilityTemplate						AbilityTemplate;
	local UnitValue								ActivationsUnitValue;

	
	// Get the triggering ability template
	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplate = AbilityTemplateMgr.FindAbilityTemplate(AbilityContext.InputContext.AbilityTemplateName);

	if (AbilityTemplate == none)
		return false;

	// Require the unit to have some action points before activating the ability (prevents triggering on overwatch or reaction attacks)
	if (PreCostActionPoints.Length == 0)
	{
		// Special consideration for the followup attacks that are triggered after Justice/Wrath as a separate ability
		if (AbilityContext.InputContext.AbilityTemplateName != 'SkirmisherPostAbilityMelee')
		{
			return false;
	}	}
	
	// Prevent triggering from Combatives or other melee counter attack abilities
	if (PreCostActionPoints.Length == 1 && PreCostActionPoints.Find(class'X2CharacterTemplateManager'.default.CounterattackActionPoint) != -1)
		return false;

	// Source cannot trigger Hit and Run above the activation limit
	SourceUnit.GetUnitValue(HitAndRunActivationsUnitName, ActivationsUnitValue);	
	if (ActivationsUnitValue.fValue >= HitAndRunActivations)
		return false;

	// Require that the action be turn-ending
	if (SourceUnit.NumActionPoints() > 0) 
		return false;

	// Get Target's XComGameState_Unit
	TargetUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));

	
	// Check that the attack was a melee attack that killed the target
	if (AbilityTemplate.IsMelee())
	{
		if (!TargetUnit.IsAlive() || TargetUnit.bBleedingOut)
		{
			ActivationsUnitValue.fValue += 1;
			SourceUnit.SetUnitFloatValue(HitAndRunActivationsUnitName, ActivationsUnitValue.fValue, eCleanup_BeginTurn);
			SourceUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.MoveActionPoint);
			NewGameState.GetContext().PostBuildVisualizationFn.AddItem(TriggerAbilityFlyoverVisualizationFn);
	}	}
	
	return false;
}


static simulated function TriggerAbilityFlyoverVisualizationFn(XComGameState VisualizeGameState)
{
	local XComGameState_Unit UnitState;
	local X2Action_PlaySoundAndFlyOver SoundAndFlyOver;
	local VisualizationActionMetadata ActionMetadata;
	local XComGameStateHistory History;
	local X2AbilityTemplate AbilityTemplate;

	History = `XCOMHISTORY;
	foreach VisualizeGameState.IterateByClassType(class'XComGameState_Unit', UnitState)
	{
		History.GetCurrentAndPreviousGameStatesForObjectID(UnitState.ObjectID, ActionMetadata.StateObject_OldState, ActionMetadata.StateObject_NewState, , VisualizeGameState.HistoryIndex);
		ActionMetadata.StateObject_NewState = UnitState;
		ActionMetadata.VisualizeActor = UnitState.GetVisualizer();

		AbilityTemplate = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().FindAbilityTemplate('WOTC_APA_HitAndRun');
		if (AbilityTemplate != none)
		{
			SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded));
			SoundAndFlyOver.SetSoundAndFlyOverParameters(None, AbilityTemplate.LocFlyOverText, '', eColor_Good, AbilityTemplate.IconImage);

		}
		break;
	}
}


defaultproperties
{
	HitAndRunActivationsUnitName = "WOTC_APA_HitAndRunActivations"
}