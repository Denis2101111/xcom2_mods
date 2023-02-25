class X2Condition_WOTC_APA_Class_InWorldEffectTile extends X2Condition;

var array<name> TileEffectNames;

event name CallMeetsCondition(XComGameState_BaseObject kTarget)
{
	local XComGameState_Unit	UnitState;
	local name					TileEffectName;

	UnitState = XComGameState_Unit(kTarget);
	foreach TileEffectNames(TileEffectName)
	{
		if (UnitState.IsInWorldEffectTile(TileEffectName))
		{
			return 'AA_Success';
	}	}

	return 'AA_NotInRange';
}