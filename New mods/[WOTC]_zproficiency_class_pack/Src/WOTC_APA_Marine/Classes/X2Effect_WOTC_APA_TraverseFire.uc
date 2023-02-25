
class X2Effect_WOTC_APA_TraverseFire extends X2Effect_Persistent implements(XMBEffectInterface) config (WOTC_APA_MarineSkills);


var config array<name>	TRAVERSE_FIRE_TRIGGER_ABILITIES;
var config array<name>	TRAVERSE_FIRE_VALID_ABILITIES;

var name TraverseFireActionPointType;


function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	local name												ActionPointType;
	local int												i, RefundActions;

		
	// Require the ability be a valid standard shot as defined by the configurable TRAVERSE_FIRE_TRIGGER_ABILITIES array variable
	if (default.TRAVERSE_FIRE_TRIGGER_ABILITIES.Find(kAbility.GetMyTemplateName()) == -1)	
		return false;

	// Unit must have more than one actionpoint at activation for Traverse Fire to convert any remaining actions
	if (PreCostActionPoints.Length < 2)
		return false;

	// Don't trigger on free actions
	if (SourceUnit.ActionPoints.Length != PreCostActionPoints.Length)
	{		
		foreach SourceUnit.ActionPoints(ActionPointType)
		{
			// Count the number of standard, RunAndGun, and Traverse Fire actions that can be refunded with a Traverse Fire action point
			if (ActionPointType == class'X2CharacterTemplateManager'.default.StandardActionPoint || ActionPointType == class'X2CharacterTemplateManager'.default.RunAndGunActionPoint || ActionPointType == TraverseFireActionPointType)
			{
				RefundActions += 1;
			}
		}

		if (RefundActions < 1)
			return false;

		// Remove all Action Points prior to adding Traverse Fire actions back
		SourceUnit.ActionPoints.Length = 0;

		// Add Traverse Fire action points refunded back to the SourceUnit
		for (i = 0; i < RefundActions; ++i)
		{
			SourceUnit.ActionPoints.AddItem(TraverseFireActionPointType);
		}

		// visualization function
		NewGameState.GetContext().PostBuildVisualizationFn.AddItem(TraverseFire_BuildVisualization);
	}
	return false;
}


// Plays a Flyover message
static function TraverseFire_BuildVisualization(XComGameState VisualizeGameState)
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
	AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('WOTC_APA_TraverseFire');
	
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(SourceUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(SourceUnitRef.ObjectID);
	if (ActionMetadata.StateObject_NewState == none)
		ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
	ActionMetadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(SourceUnitRef.ObjectID);
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, AbilityTemplate.LocFlyOverText, '', eColor_Good, AbilityTemplate.IconImage, `DEFAULTFLYOVERLOOKATTIME);
}


// XMB Action Point Interface


function bool GetTagValue(name Tag, XComGameState_Ability AbilityState, out string TagValue);
function bool GetExtModifiers(name Type, XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, optional ShotBreakdown ShotBreakdown, optional out array<ShotModifierInfo> ShotModifiers);

function bool GetExtValue(LWTuple Data)
{
	local XComGameState_Unit			SourceUnit;
	local XComGameState_Ability			AbilityState;
	local XComGameState_Effect			EffectState;
	local X2AbilityCost_ActionPoints	ActionPointCost;
	local X2AbilityCost					Cost;
	local name							Type;

	if (Data.Id == 'GetConsumeAllPoints')
	{
		SourceUnit = XComGameState_Unit(Data.Data[0].o);
		AbilityState = XComGameState_Ability(Data.Data[1].o);
		EffectState = XComGameState_Effect(Data.Data[2].o);

		if (default.TRAVERSE_FIRE_TRIGGER_ABILITIES.Find(AbilityState.GetMyTemplateName()) != -1)
		{
			Data.Data[3].i = 0;
			return true;
	}	}

	return false;
}


defaultproperties
{
    TraverseFireActionPointType = "WOTC_APA_TraverseFireAction"
}