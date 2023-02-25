
class X2Condition_WOTC_APA_WithinCQBRange extends X2Condition;

var bool	bLimitToActivatedTargets;

event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource)
{
	local XComGameState_Unit	SourceUnit, TargetUnit;
	local UnitValue				UnitValue;

	TargetUnit = XComGameState_Unit(kTarget);
	if (TargetUnit == none)
		return 'AA_NotAUnit';

	SourceUnit = XComGameState_Unit(kSource);
	if (SourceUnit == none)
		return 'AA_NotAUnit';

	// Fail on unactivated targets, if specified
	if (bLimitToActivatedTargets && TargetUnit.GetCurrentStat(eStat_AlertLevel) < 2)
		return 'AA_AlertStatusInvalid';


	// TargetUnit must be withing CQB Dominance range of the SourceUnit
	if (SourceUnit.GetUnitValue(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_RADIUS_NAME, UnitValue))	
	{
		if (SourceUnit.TileDistanceBetween(TargetUnit) <= UnitValue.fValue)
		{
			return 'AA_Success';
	}	}

	return 'AA_NotInRange';
}