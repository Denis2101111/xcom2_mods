class X2Effect_WOTC_APA_NeutralizingAgentsDamageImmunity extends X2Effect_DamageImmunity;

function bool ProvidesDamageImmunity(XComGameState_Effect EffectState, name DamageType)
{
	local XComGameState_Unit	TargetUnit;

	TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	if (TargetUnit == none)
		return false;

	if (TargetUnit.IsInWorldEffectTile(class'X2Effect_WOTC_APA_ApplyNeutralizingAgentsSmokeToWorld'.default.Class.Name))
	{
		return (ImmuneTypes.Find(DamageType) != INDEX_NONE);
	}

	return false;
}

function bool IsEffectCurrentlyRelevant(XComGameState_Effect EffectGameState, XComGameState_Unit TargetUnit)
{
	return TargetUnit.IsInWorldEffectTile(class'X2Effect_WOTC_APA_ApplyNeutralizingAgentsSmokeToWorld'.default.Class.Name);
}

DefaultProperties
{
	EffectName = "WOTC_APA_NeutralizingAgentsEffect"
	DuplicateResponse = eDupe_Refresh
}