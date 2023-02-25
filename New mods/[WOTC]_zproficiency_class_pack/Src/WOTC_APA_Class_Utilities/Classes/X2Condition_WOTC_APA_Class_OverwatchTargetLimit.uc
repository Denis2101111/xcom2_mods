
class X2Condition_WOTC_APA_Class_OverwatchTargetLimit extends X2Condition;


event name CallAbilityMeetsCondition(XComGameState_Ability kAbility, XComGameState_BaseObject kTarget)
{
	local XComGameStateHistory	History;
	local XComGameState_Unit	AttackingUnit, TargetUnit;
	local name					OWShooterValueName;
	local UnitValue				OWShooterValue;

	History = `XCOMHISTORY;
	AttackingUnit = XComGameState_Unit(History.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));
	TargetUnit = XComGameState_Unit(kTarget);

	if (AttackingUnit != none && TargetUnit != none)
	{
		OWShooterValueName = name("OverwatchShot" $ TargetUnit.ObjectID);
		AttackingUnit.GetUnitValue(OWShooterValueName, OWShooterValue);
		if (OWShooterValue.fValue > 0.0)
			return 'AA_ValueCheckFailed';
	}
	return 'AA_Success';
}
