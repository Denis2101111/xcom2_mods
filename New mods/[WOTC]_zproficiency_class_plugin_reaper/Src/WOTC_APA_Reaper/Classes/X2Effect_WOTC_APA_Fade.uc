
class X2Effect_WOTC_APA_Fade extends X2Effect_Persistent;

var int		iInitialUnitValue;

function bool AttemptToReconceal(X2Effect_Persistent PersistentEffect, const out EffectAppliedData ApplyEffectParameters, XComGameState_Effect kNewEffectState, XComGameState NewGameState, bool FirstApplication)
{
	local XComGameState_Unit						OldTargetState, NewTargetState, Observer;
	local array<StateObjectReference>				UnitsWithVision;
	local array<GameRulesCache_VisibilityInfo>		VisInfos;
	local int										Idx;
	local bool										bRetainConcealment;
	
	OldTargetState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));

	// Do nothing if the unit is already concealed
	if (OldTargetState.IsConcealed())
		return false;

	class'X2TacticalVisibilityHelpers'.static.GetEnemyViewersOfTarget(OldTargetState.ObjectID, UnitsWithVision);
	bRetainConcealment = true;

	if (UnitsWithVision.Length > 0)
	{
		// Iterate through all units that can see the effect target
		for (Idx = 0; Idx < UnitsWithVision.Length; ++Idx)
		{
			Observer = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(UnitsWithVision[Idx].ObjectID));

			// Viewing unit must be an enemy of the effect target
			if (Observer != none && Observer.IsEnemyUnit(OldTargetState))
			{
				// Viewing unit cannot be dead, stunned, unconscious, bleeding out, or in stasis
				if (!Observer.IsDead() && !Observer.IsStunned() && !Observer.bUnconscious && !Observer.bBleedingOut && !Observer.bInStasis)
				{
					// Viewing unit prevents reconcealment
					bRetainConcealment = false;
					break;
	}	}	}	}

	//`TACTICALRULES.VisibilityMgr.GetAllViewersOfLocation(OldTargetState.TileLocation, VisInfos, class'XComGameState_Unit');
	//bRetainConcealment = true;
//
	//// Iterate through all units that can see the effect target's tile
	//for (Idx = 0; Idx < VisInfos.Length; ++Idx)
	//{
		//if (VisInfos[Idx].bVisibleBasic)
		//{
			//Observer = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(VisInfos[Idx].SourceID));
//
			//// Viewing unit must be an enemy of the effect target
			//if (Observer != none && Observer.IsEnemyUnit(OldTargetState))
			//{
				//// Viewing unit cannot be dead, stunned, unconscious, bleeding out, or in stasis
				//if (!Observer.IsDead() && !Observer.IsStunned() && !Observer.bUnconscious && !Observer.bBleedingOut && !Observer.bInStasis)
				//{
					//// Viewing unit prevents reconcealment
					//bRetainConcealment = false;
					//break;
	//}	}	}	}

	if (bRetainConcealment)
	{
		NewTargetState = XComGameState_Unit(NewGameState.ModifyStateObject(OldTargetState.Class, OldTargetState.ObjectID));
		NewTargetState.SetUnitFloatValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CURRENT_NAME, iInitialUnitValue, eCleanup_BeginTactical);
		`XEVENTMGR.TriggerEvent('EffectEnterUnitConcealment', NewTargetState, NewTargetState, NewGameState);
	}	

	return false;
}


defaultproperties
{
	EffectTickedFn = AttemptToReconceal
	iInitialUnitValue = 0
}