
class X2AbilityToHitCalc_WOTC_APA_DisablingShot extends X2AbilityToHitCalc_StandardAim;

function RollForAbilityHit(XComGameState_Ability kAbility, AvailableTarget kTarget, out AbilityResultContext ResultContext)
{
	local XComGameStateHistory		History;
	local XComGameState_Unit		TargetUnit;
	local XComGameState_Effect		EffectState;
	local int						SourceUnitID, i;

	super.RollForAbilityHit(kAbility, kTarget, ResultContext);

	History = `XCOMHISTORY;

	SourceUnitID = kAbility.OwnerStateObject.ObjectID;
	TargetUnit = XComGameState_Unit(History.GetGameStateForObjectID(kTarget.PrimaryTarget.ObjectID));

	//i = TargetUnit.AppliedEffectNames.Find(class'X2Ability_WOTC_APA_GeneralAbilitySet'.default.SingularFocusMarkEffectName);
	i = TargetUnit.AppliedEffectNames.Find('WOTC_APA_SingularFocusMarked');
	EffectState = XComGameState_Effect(History.GetGameStateForObjectID(TargetUnit.AppliedEffects[i].ObjectID));
	if (i != -1 && EffectState != none)
	{
		if (EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID == SourceUnitID)
		{
			ResultContext.HitResult = eHit_Success;
			return;
	}	}

	if (ResultContext.HitResult != eHit_Miss)
	{
		ResultContext.HitResult = eHit_Graze;
	}
}