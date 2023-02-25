
class X2Condition_WOTC_APA_Class_AmbushCondition extends X2Condition;


event name CallMeetsCondition(XComGameState_BaseObject kTarget)
{
	local XComGameState_Unit				SourceUnit;

	SourceUnit = XComGameState_Unit(kTarget);
	if (SourceUnit.IsConcealed() && SourceUnit.AffectedByEffectNames.Find('WOTC_APA_AmbushEffect') == -1)
	{
		return 'AA_UnitIsConcealed';
	}

	return 'AA_Success';
}