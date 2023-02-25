
class X2Effect_WOTC_APA_FleetFootedRapidDeploymentActionPoint extends X2Effect_Persistent;

// Variables to pass into the effect:
var name FreeActionPointType; //»» Name of the type of action point to grant


function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	// If the Rapid Deployment effect has already been consumed, always return false
	if (SourceUnit.AffectedByEffectNames.Find('SupportGrenade_FreeAction') == -1)
		return false;

	/**/`Log("WOTC_APA_Medic - Fleet-Footed Rapid Deployment: PostAbilityCostPaid check for " $ SourceUnit.GetFullName());
	/**/`Log("WOTC_APA_Medic - Fleet-Footed Rapid Deployment: Number of Action Points = " $ SourceUnit.NumActionPoints());
	/**/`Log("WOTC_APA_Medic - Fleet-Footed Rapid Deployment: PostAbility = " $ kAbility.GetMyTemplateName());

	// Require that the action be a turn-ending standard movement action
	if (SourceUnit.NumActionPoints() == 0)
		if (kAbility.GetMyTemplateName() == 'StandardMove')
		{
			// Add the FleetFooted Free action point so that the unit may use the configured free abilities and remove this listening effect
			SourceUnit.ActionPoints.AddItem(FreeActionPointType);
			EffectState.RemoveEffect(NewGameState, NewGameState);

			// Also add the other FleetFooted Free action point at this time if conditions apply
			if (SourceUnit.AffectedByEffectNames.Find('Medikit_FreeAction') != -1 && SourceUnit.ActionPoints.Find('FleetFootedEmergencyAid') == -1)
				SourceUnit.ActionPoints.AddItem('FleetFootedEmergencyAid');

			// visualization function
			NewGameState.GetContext().PostBuildVisualizationFn.AddItem(FleetFooted_BuildVisualization);

			return true;
		}

	// Allow the effect to apply if the Rapid Deployment Fleet-Footed free action point is present with no normal actions remaining
	// (Allows activating Emergency Aid with the Fleet-Footed Rapid Deployment action point and getting the appropriate actions)
	if (SourceUnit.ActionPoints.Find('FleetFootedEmergencyAid') != -1 && SourceUnit.ActionPoints.Find(class'X2CharacterTemplateManager'.default.StandardActionPoint) == -1) 
	{
		// Add the FleetFooted Free action point so that the unit may use the configured free abilities and remove this listening effect
		SourceUnit.ActionPoints.AddItem(FreeActionPointType);
		EffectState.RemoveEffect(NewGameState, NewGameState);
		return true;
	}

	return false;
}


// Plays a Flyover message on the Healer with the strFlyoverMessage to indicate why this heal is being modified
static function FleetFooted_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory					History;
	local XComGameStateContext_Ability			AbilityContext;
	local X2AbilityTemplateManager				AbilityTemplateManager;
	local X2AbilityTemplate						AbilityTemplate;
	local StateObjectReference					SourceUnitRef;
	local VisualizationActionMetadata			ActionMetadata;
	local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;
	
	History = `XCOMHISTORY;

	AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	SourceUnitRef = AbilityContext.InputContext.SourceObject;
	AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('WOTC_APA_FleetFooted');
	
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(SourceUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(SourceUnitRef.ObjectID);
	if (ActionMetadata.StateObject_NewState == none)
		ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
	ActionMetadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(SourceUnitRef.ObjectID);
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, AbilityTemplate.LocFlyOverText, '', eColor_Good, AbilityTemplate.IconImage, `DEFAULTFLYOVERLOOKATTIME);
}


DefaultProperties
{
	FreeActionPointType = "FleetFootedRapidDeployment"
	EffectName = "FleetFootedRapidDeployment"
	DuplicateResponse = eDupe_Ignore
}