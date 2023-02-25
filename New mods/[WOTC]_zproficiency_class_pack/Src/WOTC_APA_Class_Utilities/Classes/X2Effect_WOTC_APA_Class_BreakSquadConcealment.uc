
class X2Effect_WOTC_APA_Class_BreakSquadConcealment extends X2Effect;


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit SourceUnit, NewUnitState, UnitState;
	local XComGameState_Player PlayerState;
	local XComGameStateHistory History;
	local XComGameState_Effect EffectState;
	local StateObjectReference EffectRef;
	local bool bRetainConcealment;

	History = `XCOMHISTORY;

	// break squad concealment
	SourceUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	PlayerState = XComGameState_Player(History.GetGameStateForObjectID(SourceUnit.ControllingPlayer.ObjectID));
	if( PlayerState.bSquadIsConcealed )
	{
		if( NewGameState.GetContext().PostBuildVisualizationFn.Find(BuildVisualizationForConcealment_Broken_Individual) == INDEX_NONE ) // we only need to visualize this once
		{
			NewGameState.GetContext().PostBuildVisualizationFn.AddItem(BuildVisualizationForConcealment_Broken_Individual);
		}

		PlayerState = XComGameState_Player(NewGameState.ModifyStateObject(class'XComGameState_Player', PlayerState.ObjectID));
		PlayerState.bSquadIsConcealed = false;

		`XEVENTMGR.TriggerEvent('SquadConcealmentBroken', PlayerState, PlayerState, NewGameState);

		// break concealment on each other squad member
		foreach History.IterateByClassType(class'XComGameState_Unit', UnitState)
		{
			if( UnitState.ControllingPlayer.ObjectID == PlayerState.ObjectID )
			{
				bRetainConcealment = false;

				if( UnitState.IsIndividuallyConcealed() )
				{
					foreach UnitState.AffectedByEffects(EffectRef)
					{
						EffectState = XComGameState_Effect(History.GetGameStateForObjectID(EffectRef.ObjectID));
						if( EffectState != none )
						{
							if( EffectState.GetX2Effect().RetainIndividualConcealment(EffectState, UnitState) )
							{
								bRetainConcealment = true;
								break;
							}
						}
					}
				}

				if( !bRetainConcealment )
				{
					NewUnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', UnitState.ObjectID));
					NewUnitState.SetIndividualConcealment(false, NewGameState);
				}
			}
		}
	}
}


private function BuildVisualizationForConcealment_Broken_Individual(XComGameState VisualizeGameState)
{	class'XComGameState_Unit'.static.BuildVisualizationForConcealmentChanged(VisualizeGameState, false);	}