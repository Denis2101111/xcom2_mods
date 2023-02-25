
class X2Effect_WOTC_APA_Evasive extends X2Effect_PersistentStatChange;


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit	TargetUnit;
	local XComWorldData			WorldData;
	local vector				StartLoc, EndLoc;
	local float					Dist;
	local int					Modifier;

	TargetUnit = XComGameState_Unit(kNewTargetState);
	WorldData = `XWORLD;
	StartLoc = WorldData.GetPositionFromTileCoordinates(TargetUnit.TurnStartLocation);
	EndLoc = WorldData.GetPositionFromTileCoordinates(TargetUnit.TileLocation);
	Dist = VSize(StartLoc - EndLoc);
	Modifier = Min((Dist / WorldData.WORLD_StepSize), class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.EVASIVE_DODGE_BONUS_TILE_CAP);
	Modifier *= class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.EVASIVE_DODGE_BONUS_PER_TILE;

	if (Modifier > 0)
	{
		AddPersistentStatChange(eStat_Dodge, Modifier);
	}

	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
}