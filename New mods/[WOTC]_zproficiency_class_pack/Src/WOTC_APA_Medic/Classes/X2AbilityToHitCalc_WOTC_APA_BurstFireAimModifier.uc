
class X2AbilityToHitCalc_WOTC_APA_BurstFireAimModifier extends X2AbilityToHitCalc_StandardAim;


protected function int GetHitChance(XComGameState_Ability kAbility, AvailableTarget kTarget, optional out ShotBreakdown m_ShotBreakdown, optional bool bDebugLog = false)
{
	local XComGameState_Unit				SourceUnit;
	local int								iCheck;

	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));

	// Set checker variable to initial number of action points required for the Steadied Burst Fire (no aim penalty)
	iCheck = 2;

	// Search for invalid action point types being present. Increment checker value by 1 for each invalid action point type found.
	// Keeps check vs total # action points looking for that initial number of valid action points. Assumes that only 1 of an invalid action point type would ever be present.
	if (SourceUnit.ActionPoints.Find('FleetFootedEmergencyAid') != -1)
		iCheck += 1;

	if (SourceUnit.ActionPoints.Find('FleetFootedRapidDeployment') != -1)
		iCheck += 1;

	// Check number of action points present vs checker variable to see if an aim penalty should be applied or not.
	if (SourceUnit.ActionPoints.length < iCheck)
		BuiltInHitMod = class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BURST_FIRE_AIM_PENALTY;
	else
		BuiltInHitMod = 0;

	return super.GetHitChance(kAbility, kTarget, m_ShotBreakdown, bDebugLog);
}