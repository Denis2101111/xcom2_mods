
class X2Condition_WOTC_APA_ReaperHack extends X2Condition;


event name CallMeetsCondition(XComGameState_BaseObject kTarget)
{
	return 'AA_Success';
}

event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource)
{
	local XComGameState_Unit				SourceUnit;
	local XComGameState_InteractiveObject	TargetObject;
	local XComInteractiveLevelActor			TargetVisualizer;
	local GameRulesCache_VisibilityInfo		VisInfo;
	local bool bGoodTarget;
	local array<StateObjectReference> VisibleUnits;
	local array<XComInteractPoint> InteractionPoints;

	SourceUnit = XComGameState_Unit(kSource);
	TargetObject = XComGameState_InteractiveObject(kTarget);
	
	if (TargetObject != none && !TargetObject.IsDoor())
	{
		TargetVisualizer = XComInteractiveLevelActor(TargetObject.GetVisualizer());
		if (TargetVisualizer != none && TargetVisualizer.HackAbilityTemplateName != 'Hack')
			return 'AA_AbilityUnavailable';

		if (TargetObject.Health == 0)
			return 'AA_NoTargets';

		if (!TargetObject.CanInteractHack(SourceUnit))
			return 'AA_TargetHasNoLoot';

		// Check to see if we have an interaction point for the selected target
		InteractionPoints = class'X2Condition_UnitInteractions'.static.GetUnitInteractionPoints(SourceUnit, eInteractionType_Hack);
		if (InteractionPoints.Find('InteractiveActor', TargetVisualizer) == INDEX_NONE)
		{
			// No interaction point - check adjacency
			if (TargetTileDistance(SourceUnit, TargetObject) >= 2)
			{
				return 'AA_NoTargets';
		}	}

		return 'AA_Success';
	}

	return 'AA_NoTargets';
}


function int TargetTileDistance(XComGameState_Unit SourceUnit, XComGameState_InteractiveObject TargetObject)
{
	local XComWorldData WorldData;
	local vector UnitLoc, TargetLoc;
	local float Dist;
	local int Tiles;

	if (SourceUnit == none || TargetObject == none)
		return 0;

	WorldData = `XWORLD;
	UnitLoc = WorldData.GetPositionFromTileCoordinates(SourceUnit.TileLocation);
	TargetLoc = WorldData.GetPositionFromTileCoordinates(TargetObject.TileLocation);
	Dist = VSize(UnitLoc - TargetLoc);
	Tiles = Dist / WorldData.WORLD_StepSize;      //@TODO gameplay - surely there is a better check for finding the number of tiles between two points
	return Tiles;
}