class X2AbilityToHitCalc_WOTC_APA_Class_AlwaysGraze extends X2AbilityToHitCalc;

function RollForAbilityHit(XComGameState_Ability kAbility, AvailableTarget kTarget, out AbilityResultContext ResultContext)
{
	local int MultiIndex;
	local ArmorMitigationResults NoArmor;

	//  DeadEye always hits
	ResultContext.HitResult = eHit_Graze;

	for (MultiIndex = 0; MultiIndex < kTarget.AdditionalTargets.Length; ++MultiIndex)
	{
		ResultContext.MultiTargetHitResults.AddItem(ResultContext.HitResult);		
		ResultContext.MultiTargetArmorMitigation.AddItem(NoArmor);
		ResultContext.MultiTargetStatContestResult.AddItem(0);
	}
}

protected function int GetHitChance(XComGameState_Ability kAbility, AvailableTarget kTarget, optional out ShotBreakdown m_ShotBreakdown, optional bool bDebugLog = false)
{
	return 100;
}

function int GetShotBreakdown(XComGameState_Ability kAbility, AvailableTarget kTarget, optional out ShotBreakdown m_ShotBreakdown, optional bool bDebugLog = false)
{
	m_ShotBreakdown.HideShotBreakdown = true;
	return 100;
}