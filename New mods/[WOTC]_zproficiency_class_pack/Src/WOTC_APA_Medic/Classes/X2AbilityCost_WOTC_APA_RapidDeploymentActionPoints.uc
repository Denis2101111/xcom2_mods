class X2AbilityCost_WOTC_APA_RapidDeploymentActionPoints extends XMBAbilityCost_ActionPoints;


simulated function int GetPointCost(XComGameState_Ability AbilityState, XComGameState_Unit AbilityOwner)
{
	// Allows Rapid Deployment to be activated without any actions when Emergency Aid is also active and the soldier has Fleet-Footed
	if (AbilityOwner.IsUnitAffectedByEffectName('SupportGrenade_FreeActivation'))
	{
		if (AbilityOwner.IsUnitAffectedByEffectName('WOTC_APA_EmergencyAidActive'))
		{
			return 0;
		}
	}

	// Otherwise process as normal:
	return super.GetPointCost(AbilityState, AbilityOwner);
}