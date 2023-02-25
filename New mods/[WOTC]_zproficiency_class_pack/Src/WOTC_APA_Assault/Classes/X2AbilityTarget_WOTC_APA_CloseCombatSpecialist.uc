
class X2AbilityTarget_WOTC_APA_CloseCombatSpecialist extends X2AbilityTarget_Single;


simulated function name GetPrimaryTargetOptions(const XComGameState_Ability Ability, out array<AvailableTarget> Targets)
{
	local XComGameState_Unit	Attacker, TargetUnit;
	local int					i;
	local name					ConditionCode;
		
	ConditionCode = Super.GetPrimaryTargetOptions(Ability,Targets);
	Attacker = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(Ability.OwnerStateObject.ObjectID));
	for (i = Targets.Length - 1; i >= 0; --i)
	{
		TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(Targets[i].PrimaryTarget.ObjectID));

		// Out of range
		if (Attacker.TileDistanceBetween(TargetUnit) > class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CLOSE_COMBAT_SPECIALIST_TILE_RADIUS)
		{
			Targets.Remove(i,1);
		}

		// In range of Retribution or Bladestorm instead
		if (Attacker.HasSoldierAbility('Retribution') || Attacker.HasSoldierAbility('Bladestorm'))
		{
			if (Attacker.TileDistanceBetween(TargetUnit) < 2)
			{
				Targets.Remove(i,1);
	}	}	}

	if ((ConditionCode == 'AA_Success') && (Targets.Length < 1))
	{
		return 'AA_NoTargets';
	}

	return ConditionCode;
}


simulated function bool ValidatePrimaryTargetOption(const XComGameState_Ability Ability, XComGameState_Unit SourceUnit, XComGameState_BaseObject TargetObject)
{
	local bool					bValidTarget;
	local XComGameState_Unit	TargetUnit;
	
	bValidTarget = Super.ValidatePrimaryTargetOption(Ability, SourceUnit, TargetObject);
	TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(TargetObject.ObjectID));
	if (TargetUnit == none)
		return false;

	if (bValidTarget)
	{
		// Out of range
		if (SourceUnit.TileDistanceBetween(TargetUnit) > class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CLOSE_COMBAT_SPECIALIST_TILE_RADIUS)
		{
			return false;
		}

		// In range of Retribution instead
		if (SourceUnit.HasSoldierAbility('Retribution') || SourceUnit.HasSoldierAbility('Bladestorm'))
		{
			if (SourceUnit.TileDistanceBetween(TargetUnit) < 2)
			{
				return false;
	}	}	}
	
	return bValidTarget;
}