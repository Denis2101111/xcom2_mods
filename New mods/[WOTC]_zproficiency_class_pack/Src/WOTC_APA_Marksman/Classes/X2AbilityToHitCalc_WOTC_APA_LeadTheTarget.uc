
class X2AbilityToHitCalc_WOTC_APA_LeadTheTarget extends X2AbilityToHitCalc_StandardAim config(GameCore);


function RollForAbilityHit(XComGameState_Ability kAbility, AvailableTarget kTarget, out AbilityResultContext ResultContext)
{
	local XComGameState_Unit Shooter;

	super.RollForAbilityHit(kAbility, kTarget, ResultContext);

	// Focus reaction shot ignores Lightning Reflexes
	if (ResultContext.HitResult == eHit_LightningReflexes)
	{
		ResultContext.HitResult = eHit_Success;
	}
}