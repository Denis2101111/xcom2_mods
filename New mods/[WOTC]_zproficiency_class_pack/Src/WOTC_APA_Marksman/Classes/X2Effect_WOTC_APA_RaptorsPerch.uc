
class X2Effect_WOTC_APA_RaptorsPerch extends X2Effect_Persistent;

var int		RaptorsPerchActivations;
var name	RaptorsPerchActivationsUnitName;

function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	local UnitValue					UnitValue;
	local XComGameStateHistory		History;
	local XComGameState_Unit		TargetUnit, PrevTargetUnit;

	// Source must not have already triggered Raptor's Perch this turn
	SourceUnit.GetUnitValue(RaptorsPerchActivationsUnitName, UnitValue);	
	if (UnitValue.fValue >= RaptorsPerchActivations)
		return false;

	// Require that the action be turn-ending
	if (SourceUnit.NumActionPoints() > 0) 
		return false;

	// Source must be Braced and have height advantage over a target that was killed
	if (SourceUnit.AffectedByEffectNames.Find('WOTC_APA_Brace_BracedEffect') != -1 || SourceUnit.AffectedByEffectNames.Find('WOTC_APA_Brace_TempBracedEffect') != -1)
	{
		History = `XCOMHISTORY;
		TargetUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
		if (TargetUnit != None)
		{
			PrevTargetUnit = XComGameState_Unit(History.GetGameStateForObjectID(TargetUnit.ObjectID));      //  get the most recent version from the history rather than our modified (attacked) version
			if ((TargetUnit.IsDead() || TargetUnit.bBleedingOut) && PrevTargetUnit != None && SourceUnit.HasHeightAdvantageOver(PrevTargetUnit, true))
			{
				UnitValue.fValue = UnitValue.fValue + 1;
				SourceUnit.SetUnitFloatValue(RaptorsPerchActivationsUnitName, UnitValue.fValue, eCleanup_BeginTurn);
				SourceUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);
	}	}	}

	return false;
}




DefaultProperties
{
	RaptorsPerchActivationsUnitName="WOTC_APA_RaptorsPerchActivations"
}