
class X2Effect_WOTC_APA_DeathFromAbove extends X2Effect_Persistent;

var int		DeathFromAboveActivations;
var name	DeathFromAboveActivationsUnitName;

function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	local UnitValue					UnitValue;
	local XComGameState_Unit		TargetUnit, PrevTargetUnit;

	// Source must not have already triggered Death From Above this turn
	SourceUnit.GetUnitValue(DeathFromAboveActivationsUnitName, UnitValue);	
	if (UnitValue.fValue >= DeathFromAboveActivations)
		return false;

	// Require that the action be turn-ending
	if (SourceUnit.NumActionPoints() > 0) 
		return false;

	// Requite that the target was killed or bleading out
	TargetUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
	if (TargetUnit != None)
	{
		PrevTargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(TargetUnit.ObjectID));      //  get the most recent version from the history rather than our modified (attacked) version
		if ((TargetUnit.IsDead() || TargetUnit.bBleedingOut) && PrevTargetUnit != None && SourceUnit.HasHeightAdvantageOver(PrevTargetUnit, true))
		{
			UnitValue.fValue = UnitValue.fValue + 1;
			SourceUnit.SetUnitFloatValue(DeathFromAboveActivationsUnitName, UnitValue.fValue, eCleanup_BeginTurn);
			SourceUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);
	}	}	

	return false;
}




DefaultProperties
{
	DeathFromAboveActivationsUnitName="WOTC_APA_DeathFromAboveActivations"
}