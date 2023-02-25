
class X2Condition_WOTC_APA_ReviveTargetConditions extends X2Condition;


// Check source and target units are player units and that target is suffering from some status effect
event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource)
{
	local XComGameState_Unit			SourceUnit, TargetUnit;

	SourceUnit = XComGameState_Unit(kSource);
	TargetUnit = XComGameState_Unit(kTarget);

	if (SourceUnit == none || TargetUnit == none)
		return 'AA_NotAUnit';

	if (SourceUnit.ControllingPlayer != TargetUnit.ControllingPlayer)
		return 'AA_UnitIsHostile';

	if (TargetUnit.IsRobotic())
		return 'AA_UnitIsImmune';

	if (TargetUnit.IsPanicked() || TargetUnit.IsUnconscious() || TargetUnit.IsDisoriented() || TargetUnit.IsStunned() || TargetUnit.IsBleedingOut())
		return 'AA_Success';

	return 'AA_UnitIsNotImpaired';
}