
class X2Condition_WOTC_APA_ChemicalWarfare extends X2Condition;


event name CallMeetsCondition(XComGameState_BaseObject kTarget)
{
	local XComGameState_Unit			TargetUnit;

	TargetUnit = XComGameState_Unit(kTarget);

	if (TargetUnit.GetCurrentStat(eStat_AlertLevel) < 2)
		return 'AA_UnitIsImmune';

	return 'AA_Success';
}