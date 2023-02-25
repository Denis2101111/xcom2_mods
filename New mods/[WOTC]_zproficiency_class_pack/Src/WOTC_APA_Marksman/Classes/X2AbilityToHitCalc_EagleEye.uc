
class X2AbilityToHitCalc_EagleEye extends X2AbilityToHitCalc;


function RollForAbilityHit(XComGameState_Ability kAbility, AvailableTarget kTarget, out AbilityResultContext ResultContext)
{
   local int MultiIndex, RandRoll, PercentToHit;
   local ArmorMitigationResults NoArmor;

   PercentToHit = GetHitChance(kAbility, kTarget);

   RandRoll = `SYNC_RAND_TYPED(100, ESyncRandType_Generic);
   ResultContext.HitResult = RandRoll <= PercentToHit ? eHit_Success : eHit_Miss;
   ResultContext.ArmorMitigation = NoArmor;
   ResultContext.CalculatedHitChance = PercentToHit;

   //for (MultiIndex = 0; MultiIndex < kTarget.AdditionalTargets.Length; ++MultiIndex)
  // {
     // RandRoll = `SYNC_RAND_TYPED(100, ESyncRandType_Generic);
     // ResultContext.MultiTargetHitResults.AddItem(RandRoll < PercentToHit ? eHit_Success : eHit_Miss);
     // ResultContext.MultiTargetArmorMitigation.AddItem(NoArmor);
     // ResultContext.MultiTargetStatContestResult.AddItem(0);
   //}
}


protected function int GetHitChance(XComGameState_Ability kAbility, AvailableTarget kTarget, optional out ShotBreakdown m_ShotBreakdown, optional bool bDebugLog = false)
{
	local XComGameState_Unit	SourceUnit;
	local int					Chance;
	
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));

	if (SourceUnit.AffectedByEffectNames.Find('WOTC_APA_Brace_BracedEffect') != -1 || SourceUnit.AffectedByEffectNames.Find('WOTC_APA_Brace_TempBracedEffect') != -1)
		Chance = class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.EAGLE_EYE_SHOT_CHANCE_BRACED;
	else
		Chance =  class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.EAGLE_EYE_SHOT_CHANCE;

	if (SourceUnit.GetItemInSlot(eInvSlot_PrimaryWeapon).GetWeaponCategory() == 'vektor_rifle')
		Chance += class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.EAGLE_EYE_SHOT_CHANCE_VEKTOR_BONUS;

	return Chance;
}	