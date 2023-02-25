
class X2Effect_WOTC_APA_Skirmisher extends X2Effect_Persistent;


function bool ChangeHitResultForTarget(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit TargetUnit, XComGameState_Ability AbilityState, bool bIsPrimaryTarget, const EAbilityHitResult CurrentResult, out EAbilityHitResult NewHitResult)
{
	local XComWorldData			WorldData;
	local vector				StartLoc, EndLoc;
	local float					Dist, Chance, RandRoll;
	local bool					bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	// Only apply to standard attacks
	if (X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc) == none)
		return false;

		// TO ADD - Attacker and Target must not be same team and enable IndirectFire attacks to also graze...

	// Only apply to a standard hit
	if (CurrentResult == eHit_Success)
	{
		WorldData = `XWORLD;
		StartLoc = WorldData.GetPositionFromTileCoordinates(TargetUnit.TurnStartLocation);
		EndLoc = WorldData.GetPositionFromTileCoordinates(TargetUnit.TileLocation);
		Dist = VSize(StartLoc - EndLoc);
		Chance = Min((Dist / WorldData.WORLD_StepSize), class'X2Ability_WOTC_APA_SapperAbilitySet'.default.SKIRMISHER_CHANCE_TILE_CAP);
		Chance *= class'X2Ability_WOTC_APA_SapperAbilitySet'.default.SKIRMISHER_CHANCE_PER_TILE;
	
		RandRoll = `SYNC_RAND(100);
		if (RandRoll <= Chance)
		{
			`LOG("WOTC_APA_Skirmisher - Standard Hit converted to Graze (chance was" @ Chance $ "%)", bLog);
			NewHitResult = eHit_Graze;
			return true;
		}
	}
	return false;
}