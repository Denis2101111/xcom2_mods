
class X2Effect_WOTC_APA_NaturalLeader extends X2Effect_Persistent;


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit		UnitState;
	local ECombatIntelligence		CurrentComInt;
	local int						ComIntIncreases, Idx;

	UnitState = XComGameState_Unit(kNewTargetState);
	if (UnitState != none)
	{
		CurrentComInt = UnitState.ComInt;
		if (CurrentComInt < eComInt_Gifted)
		{
			ComIntIncreases = eComInt_Gifted - CurrentComInt;
			for(Idx = 0; Idx < ComIntIncreases; Idx++)
			{
				UnitState.ImproveCombatIntelligence();
	}	}	}

	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
}


defaultproperties
{
	EffectName="WOTC_APA_NaturalLeaderEffect"
	DuplicateResponse=eDupe_Ignore
}