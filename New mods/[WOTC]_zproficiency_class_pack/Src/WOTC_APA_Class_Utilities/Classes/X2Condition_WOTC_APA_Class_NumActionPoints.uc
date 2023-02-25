
class X2Condition_WOTC_APA_Class_NumActionPoints extends X2Condition;

// Variables to pass into the condition check:
var int				ExpectedNumActionPoints;


event name CallAbilityMeetsCondition(XComGameState_Ability kAbility, XComGameState_BaseObject kTarget)
{
	local XComGameState_Unit	SourceUnit;

	// Get Source's XComGameState_Unit
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));
	

	if (SourceUnit.ActionPoints.Length >= ExpectedNumActionPoints)
		return 'AA_Success';

	return 'AA_FailedActionPointCheck';
}