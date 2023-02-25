
class X2AbilityTarget_WOTC_APA_ZoneDefense extends X2AbilityTarget_Single;


simulated function name GetPrimaryTargetOptions(const XComGameState_Ability Ability, out array<AvailableTarget> Targets)
{
	local XComGameState_Unit	Attacker, TargetUnit;
	local UnitValue				UnitValue;
	local int					i;
	local name					ConditionCode;
		
	ConditionCode = 'AA_AbilityUnavailable';

	Attacker = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(Ability.OwnerStateObject.ObjectID));
	if (Attacker.GetUnitValue(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_RADIUS_NAME, UnitValue))
	{
		ConditionCode = Super.GetPrimaryTargetOptions(Ability,Targets);
		for (i = Targets.Length - 1; i >= 0; --i)
		{
			TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(Targets[i].PrimaryTarget.ObjectID));
			if (Attacker.TileDistanceBetween(TargetUnit) > UnitValue.fValue)
			{
				Targets.Remove(i,1);
			}
		}

		if ((ConditionCode == 'AA_Success') && (Targets.Length < 1))
		{
			return 'AA_NoTargets';
	}	}

	return ConditionCode;
}


simulated function bool ValidatePrimaryTargetOption(const XComGameState_Ability Ability, XComGameState_Unit SourceUnit, XComGameState_BaseObject TargetObject)
{
	local bool					bValidTarget;
	local XComGameState_Unit	TargetUnit;
	local UnitValue				UnitValue;
	
	bValidTarget = Super.ValidatePrimaryTargetOption(Ability, SourceUnit, TargetObject);
	TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(TargetObject.ObjectID));
	if (TargetUnit == none)
		return false;

	if (bValidTarget)
	{
		if (SourceUnit.GetUnitValue(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_RADIUS_NAME, UnitValue))
		{
			if (SourceUnit.TileDistanceBetween(TargetUnit) > UnitValue.fValue)
			{
				return false;
	}	}	}
	
	return bValidTarget;
}