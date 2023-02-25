
class X2Condition_WOTC_APA_TargetInCover extends X2Condition;

// Variables to pass into the condition check:
var bool bApplyToTargetsNotUsingCover;

event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource)
{
	local XComGameState_Unit				SourceUnit, TargetUnit;
	local GameRulesCache_VisibilityInfo		VisInfo;

	TargetUnit = XComGameState_Unit(kTarget);
	if (TargetUnit == none)
		return 'AA_NotAUnit';

	SourceUnit = XComGameState_Unit(kSource);
	if (SourceUnit == none)
		return 'AA_NotAUnit';

	if (!TargetUnit.CanTakeCover())
	{
		if (bApplyToTargetsNotUsingCover && TargetUnit.GetCurrentStat(eStat_AlertLevel) == 2)
		{
			return 'AA_Success';
	}	}

	if (`TACTICALRULES.VisibilityMgr.GetVisibilityInfo(SourceUnit.ObjectID, TargetUnit.ObjectID, VisInfo))
	{
		if (TargetUnit.CanTakeCover() && VisInfo.TargetCover != CT_None)
		{
			return 'AA_Success';
	}	}

	return 'AA_UnitIsNotInCover';
}