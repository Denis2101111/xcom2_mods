class X2Effect_WOTC_APA_SetFullOverrideCooldown extends X2Effect;


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameStateHistory		History;
	local XComGameState_Unit		TargetUnit;
	local XComGameState_Ability		AbilityState;
	local bool						bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	History = `XCOMHISTORY;
	TargetUnit = XComGameState_Unit(kNewTargetState);

	if (!TargetUnit.HasSoldierAbility('WOTC_APA_FullOverride'))
		return;

	// Locate the target's abilitystates that match the AbilitiesToSet array
	foreach History.IterateByClassType(class'XComGameState_Ability', AbilityState)
	{
		if (AbilityState.OwnerStateObject.ObjectID == TargetUnit.ObjectID)
		{
			if (AbilityState.GetMyTemplateName() == 'WOTC_APA_FullOverride')
			{
				if (AbilityState.iCharges > 0)
				{
					AbilityState = XComGameState_Ability(NewGameState.CreateStateObject(class'XComGameState_Ability', AbilityState.ObjectID));
					NewGameState.AddStateObject(AbilityState);
					AbilityState.iCooldown = class'X2Ability_SpecialistAbilitySet'.default.HAYWIRE_PROTOCOL_COOLDOWN;
}	}	}	}	}