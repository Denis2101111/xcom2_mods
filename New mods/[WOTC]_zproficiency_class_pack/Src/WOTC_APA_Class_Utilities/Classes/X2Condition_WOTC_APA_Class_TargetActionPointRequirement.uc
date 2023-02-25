
class X2Condition_WOTC_APA_Class_TargetActionPointRequirement extends X2Condition;


// Variables to pass into the condition check:
var name	ActionPointType;	//»» Action Point Type to check for
var bool	bExcludeCondition;	//»» When True, the presence of the ActionPointType FAILS the condition


event name CallAbilityMeetsCondition(XComGameState_Ability kAbility, XComGameState_BaseObject kTarget)
{
	local XComGameState_Unit	TargetUnit;
	local bool					bLog, bHasActionPointType;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;
	
	// Get Target's XComGameState_Unit
	TargetUnit = XComGameState_Unit(kTarget);

	if (TargetUnit.ActionPoints.Find(ActionPointType) != -1)
	{
		bHasActionPointType = true;
		/**/`Log("WOTC_APA_Class - TargetActionPointRequirement: TargetUnit is" @ TargetUnit.GetFullName() @ "and has the action point type:" @ ActionPointType, bLog);
	}

	if (bHasActionPointType == bExcludeCondition)  { return 'AA_AbilityUnavailable'; }

	/**/`Log("WOTC_APA_Class - TargetActionPointRequirement: check successful", bLog);

	return 'AA_Success';
}