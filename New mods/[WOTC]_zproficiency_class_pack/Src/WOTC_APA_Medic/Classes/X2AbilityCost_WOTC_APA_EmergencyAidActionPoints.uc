class X2AbilityCost_WOTC_APA_EmergencyAidActionPoints extends XMBAbilityCost_ActionPoints;


simulated function int GetPointCost(XComGameState_Ability AbilityState, XComGameState_Unit AbilityOwner)
{
	// Allows Emergency Aid to be activated without any actions when Rapid Deployment is also active and the soldier has Fleet-Footed
	if (AbilityOwner.IsUnitAffectedByEffectName('Medikit_FreeActivation'))
	{
		if (AbilityOwner.IsUnitAffectedByEffectName('WOTC_APA_RapidDeploymentActive'))
		{
			return 0;
		}
	}

	// Otherwise process as normal:
	return super.GetPointCost(AbilityState, AbilityOwner);
}