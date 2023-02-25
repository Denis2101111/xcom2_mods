
class X2AbilityToHitCalc_WOTC_APA_SuppressionGraze extends X2AbilityToHitCalc_PercentChance config(GameCore);


function bool NoGameStateOnMiss() { return true; }

protected function int GetPercentToHit(XComGameState_Ability kAbility, AvailableTarget kTarget)
{
	local XComGameState_Unit	SourceUnit;
	local int					Enemies, ChanceToHit;
	local bool					bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));

	ChanceToHit = class'X2Ability_WOTC_APA_MarineAbilitySet'.default.WITHERING_BARRAGE_TRIGGER_CHANCE;

	/**/`Log("WOTC_APA_Class - Suppression Graze: Base chance is:" @ ChanceToHit, bLog);

	if (SourceUnit.HasSoldierAbility('WOTC_APA_ZeroedIn'))
	{
		/**/`Log("WOTC_APA_Class - Suppression Graze - Zeroed In: SourceUnit (" $ SourceUnit.GetFullName() $ ") has Zeroed In Ability", bLog);
		Enemies = SourceUnit.GetNumVisibleEnemyUnits (true, false, false, -1, false, false, false);
		if (Enemies > 0)
		{
			ChanceToHit += Clamp(Enemies * class'X2Ability_WOTC_APA_MarineAbilitySet'.default.ZEROED_IN_CHANCE_PER_ENEMY, 0, class'X2Ability_WOTC_APA_MarineAbilitySet'.default.ZEROED_IN_CHANCE_CAP);
			/**/`Log("WOTC_APA_Class - Suppression Graze - Zeroed In: Number of enemies in range is" @ Enemies @ "and adjusted chance is now" @ ChanceToHit, bLog);
	}	}
	
	return ChanceToHit;
}

function RollForAbilityHit(XComGameState_Ability kAbility, AvailableTarget kTarget, out AbilityResultContext ResultContext)
{
	local int MultiIndex, RandRoll;
	local ArmorMitigationResults NoArmor;
	local int LocalPercentToHit;

	LocalPercentToHit = GetPercentToHit(kAbility, kTarget);

	RandRoll = `SYNC_RAND_TYPED(100, ESyncRandType_Generic);
	ResultContext.HitResult = RandRoll < LocalPercentToHit ? eHit_Graze : eHit_Miss;
	ResultContext.ArmorMitigation = NoArmor;
	ResultContext.CalculatedHitChance = LocalPercentToHit;

	for (MultiIndex = 0; MultiIndex < kTarget.AdditionalTargets.Length; ++MultiIndex)
	{
		RandRoll = `SYNC_RAND_TYPED(100, ESyncRandType_Generic);
		ResultContext.MultiTargetHitResults.AddItem(RandRoll < LocalPercentToHit ? eHit_Graze : eHit_Miss);
		ResultContext.MultiTargetArmorMitigation.AddItem(NoArmor);
		ResultContext.MultiTargetStatContestResult.AddItem(0);
	}
}

protected function int GetHitChance(XComGameState_Ability kAbility, AvailableTarget kTarget, optional out ShotBreakdown m_ShotBreakdown, optional bool bDebugLog = false)
{
	return GetPercentToHit(kAbility, kTarget);
}

function int GetShotBreakdown(XComGameState_Ability kAbility, AvailableTarget kTarget, optional out ShotBreakdown m_ShotBreakdown, optional bool bDebugLog = false)
{
	//m_ShotBreakdown.HideShotBreakdown = true;
	//m_ShotBreakdown.FinalHitChance = GetPercentToHit(kAbility, kTarget);
	//return m_ShotBreakdown.FinalHitChance;
}