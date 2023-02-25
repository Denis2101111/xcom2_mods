
class X2Condition_WOTC_APA_LimitedSquadsightVisibility extends X2Condition config(WOTC_APA_MarksmanSkills);


event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource)
{
	local XComGameState_Unit				SourceUnit, TargetUnit;
	local int								TargetID;
	local GameRulesCache_VisibilityInfo		VisInfo;

	SourceUnit = XComGameState_Unit(kSource);
	TargetUnit = XComGameState_Unit(kTarget);
	if (TargetUnit != none)
		TargetID = TargetUnit.ObjectID;
	else
		TargetID = XComGameState_InteractiveObject(kTarget).ObjectID;
	
	// If Source has the standard squadsite effect, succeed
	if (SourceUnit.AffectedByEffectNames.Find('Squadsight') != -1)
		return 'AA_Success';

	// If Source has a Braced effect, succeed
	if (SourceUnit.AffectedByEffectNames.Find('WOTC_APA_Brace_BracedEffect') != -1 || SourceUnit.AppliedEffectNames.Find('WOTC_APA_Brace_TempBracedEffect') != -1)
		return 'AA_Success';

	// If Source has the limited squadsite effect, check tile distance
	if (SourceUnit.AffectedByEffectNames.Find('Squadsight') != -1)
		return 'AA_Success';

	return 'AA_Success';	
}