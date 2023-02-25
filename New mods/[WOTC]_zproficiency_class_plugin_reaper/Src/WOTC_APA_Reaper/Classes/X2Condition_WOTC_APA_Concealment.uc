
class X2Condition_WOTC_APA_Concealment extends X2Condition;

// Variables to pass into the condition check:
var bool		bExpectConcealment;		//»» True (default) fails condition if the unit is NOT concealed, otherwise fails if unit IS concealed


event name CallMeetsCondition(XComGameState_BaseObject kTarget)
{
	local XComGameState_Unit TargetUnit;

	TargetUnit = XComGameState_Unit(kTarget);
	if (TargetUnit == none)
		return 'AA_NotAUnit';

	if (TargetUnit.IsConcealed() && !bExpectConcealment)
		return 'AA_UnitIsConcealed';

	if (!TargetUnit.IsConcealed() && bExpectConcealment)
		return 'AA_UnitAlreadySpotted';

	return 'AA_Success';
}


defaultproperties
{
	bExpectConcealment = true
}