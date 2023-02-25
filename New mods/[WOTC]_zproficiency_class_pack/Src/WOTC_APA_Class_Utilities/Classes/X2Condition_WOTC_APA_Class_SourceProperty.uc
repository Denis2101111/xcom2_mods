
class X2Condition_WOTC_APA_Class_SourceProperty extends X2Condition;

// Variables to pass into the condition check:
var bool bExcludeBleedingOut;
var bool bExcludeUnconscious;

event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource)
{
	local XComGameState_Unit SourceUnit, TargetUnit;

	TargetUnit = XComGameState_Unit(kTarget);
	if (TargetUnit == none)
		return 'AA_NotAUnit';

	SourceUnit = XComGameState_Unit(kSource);
	if (SourceUnit == none)
		return 'AA_NotAUnit';

	if (bExcludeBleedingOut)
		if (SourceUnit.bBleedingOut)
			return 'AA_AbilityUnavailable';

	if (bExcludeUnconscious)
		if (SourceUnit.bUnconscious)
			return 'AA_AbilityUnavailable';

	return 'AA_Success';
}


DefaultProperties
{
	bExcludeBleedingOut = true;
	bExcludeUnconscious = true;
}