
class X2Effect_WOTC_APA_Class_Suppression extends X2Effect_Suppression;


var name	WOTC_APA_Supression_TriggeredName;
var name	WOTC_APA_Supression_SingleTarget_TriggeredName;
var bool	bMultiTargetAbility;

var localized string	strSuppressionAimPenaltyName;


function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager EventMgr;
	local XComGameState_Unit SourceUnitState;
	local XComGameStateHistory History;
	local Object EffectObj, TargetObj;

	History = `XCOMHISTORY;
	EventMgr = `XEVENTMGR;

	EffectObj = EffectGameState;
	TargetObj = `XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID);
	SourceUnitState = XComGameState_Unit(History.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));

	// Register for the events to remove the effect from the target if the source becomes impaired or after the target moves
	EventMgr.RegisterForEvent(EffectObj, 'ImpairingEffect', EffectGameState.OnSourceBecameImpaired, ELD_OnStateSubmitted,, SourceUnitState);
	EventMgr.RegisterForEvent(EffectObj, 'UnitMoveFinished', RemoveEffectOnMove, ELD_OnStateSubmitted,,TargetObj,, EffectObj);
}

// Remove the effect after the target moves (prevents enemies with Shadowstep from keeping the suppression aim penalty, etc.)
static function EventListenerReturn RemoveEffectOnMove(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Effect					EffectState;
	local XComGameStateContext_EffectRemoved	EffectRemovedContext;
	local XComGameState							EffectRemovedGameState;

	EffectState = XComGameState_Effect(CallbackData);

	EffectRemovedContext = class'XComGameStateContext_EffectRemoved'.static.CreateEffectRemovedContext(EffectState);	
	EffectRemovedGameState = `XCOMHISTORY.CreateNewGameState(true, EffectRemovedContext);
	EffectState.RemoveEffect(EffectRemovedGameState, EffectRemovedGameState);		
	`TACTICALRULES.SubmitGameState(EffectRemovedGameState);

	return ELR_NoInterrupt;
}



simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit			SourceState, TargetState;
	local XGUnit						SourceUnit, TargetUnit;
	local XComGameStateContext_Ability	Context;
	local bool							bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;
	
	// Trigger events allowing other bonus abilities to tie-in to suppression's application
	TargetState = XComGameState_Unit(NewGameState.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	SourceState = XComGameState_Unit(NewGameState.GetGameStateForObjectID(ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	
	// Trigger Single-Target suppression event first (more powerful effects may want to apply to single target suppression vs area suppression
	if (!bMultiTargetAbility)
	{
		`XEVENTMGR.TriggerEvent(default.WOTC_APA_Supression_SingleTarget_TriggeredName, TargetState, SourceState, NewGameState);
	}

	// Trigger suppression event that applies to any (single or multitarget) suppression application
	`XEVENTMGR.TriggerEvent(default.WOTC_APA_Supression_TriggeredName, TargetState, SourceState, NewGameState);

	/**/`Log("WOTC_APA_Class - Suppression Triggered Event: TargetState is" @ TargetState.GetFullName() @ "and SourceState is" @ SourceState.GetFullName(), bLog);

	// Force target into red alert if not already - fix for suppression from outside visual range (from Emplaced, etc.)
	if (TargetState.GetCurrentStat(eStat_AlertLevel) != `ALERT_LEVEL_RED)
	{
		TargetState.SetCurrentStat(eStat_AlertLevel, `ALERT_LEVEL_RED);
	}
	
	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
}


simulated function AddX2ActionsForVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, name EffectApplyResult)
{
	local X2Action_PlaySoundAndFlyOver SoundAndFlyOver;
	
	if (EffectApplyResult == 'AA_Success' && ActionMetadata.StateObject_NewState.IsA('XComGameState_Unit'))
	{
		SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded));
		SoundAndFlyOver.SetSoundAndFlyOverParameters(None, strSuppressionAimPenaltyName, '', eColor_Good);
	}
}


// Handle switching the suppression target if there are other remaining suppression targets for a MultiTarget ability
simulated function OnEffectRemoved(const out EffectAppliedData ApplyEffectParameters, XComGameState NewGameState, bool bCleansed, XComGameState_Effect RemovedEffectState)
{
	local XComGameState_Unit SourceState, TargetState;
	local StateObjectReference NullRef;

	if (bMultiTargetAbility)
	{
		TargetState = FindNewAreaSuppressionTarget(NewGameState, RemovedEffectState, true, SourceState);
		if (TargetState != none && SourceState != none)
		{
			SourceState.m_MultiTurnTargetRef = TargetState.GetReference();
		}
		else
		{
			SourceState.m_MultiTurnTargetRef = NullRef;
	}	}

	super(X2Effect_Persistent).OnEffectRemoved(ApplyEffectParameters, NewGameState, bCleansed, RemovedEffectState);
}


// Helper function to figure out a new primary suppression target to switch to
simulated function XComGameState_Unit FindNewAreaSuppressionTarget(XComGameState NewGameState, XComGameState_Effect SuppressionEffect, bool bRemovingEffect, out XComGameState_Unit SourceState)
{
	local XComGameStateHistory History;
	local XComGameState_Unit TargetState;
	local name TestEffectName;
	local int count;
	local XComGameState_Effect EffectState;
	local bool bCheck;

	History = `XCOMHISTORY;

	SourceState = XComGameState_Unit(NewGameState.GetGameStateForObjectID(SuppressionEffect.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	if(SourceState == none)
	{
		SourceState = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', SuppressionEffect.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
		NewGameState.AddStateObject(SourceState);
	}
	if (ShouldRemoveAreaSuppression(SourceState, NewGameState))
		return none;

	if(SourceState != none)
	{
		foreach SourceState.AppliedEffectNames(TestEffectName, count)
		{
			if(TestEffectName == default.EffectName)
			{
				EffectState = XComGameState_Effect(History.GetGameStateForObjectID( SourceState.AppliedEffects[ count ].ObjectID ) );
				if (bRemovingEffect && EffectState.ObjectID != SuppressionEffect.ObjectID)
				{
					bCheck = true;
				}
				else if (EffectState.ObjectID == SuppressionEffect.ObjectID)
				{
					bCheck = true;
				}

				if (bCheck)
				{
					TargetState = XComGameState_Unit(NewGameState.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
					if(TargetState == none)
					{
						TargetState = XComGameState_Unit(History.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
					}

					if(TargetState != none && TargetState.IsAlive())
					{
						return TargetState;
					}
				}
			}
		}
	}
	return none;
}

simulated function bool UpdateVisualizedSuppressionTarget(XComGameState NewGameState, XComGameState_Effect SuppressionEffect, bool bRemovingEffect)
{
	local XComGameState_Unit SourceState, TargetState;
	local XGUnit SourceUnit, TargetUnit;

	TargetState = FindNewAreaSuppressionTarget(NewGameState, SuppressionEffect, bRemovingEffect, SourceState);
	if (TargetState != none && SourceState != none)
	{
		SourceUnit = XGUnit(SourceState.GetVisualizer());
		if(SourceUnit.m_kForceConstantCombatTarget != none)
		{
			// remove the marking on the old target, so it doesn't disable the suppression state in the XGUnit.OnDeath
			SourceUnit.m_kForceConstantCombatTarget.m_kConstantCombatUnitTargetingMe = none;
		}
		TargetUnit = XGUnit(TargetState.GetVisualizer());
					
		SourceUnit.ConstantCombatSuppressArea(false);
		SourceUnit.ConstantCombatSuppress(true, TargetUnit);
		SourceUnit.IdleStateMachine.CheckForStanceUpdate();
		return true;
	}
	else
	{
		return false;
	}
}

// add check to attempt to switch visualiation targets instead of just ending suppression
simulated function AddX2ActionsForVisualization_RemovedSource(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult, XComGameState_Effect RemovedEffect)
{
	if (bMultiTargetAbility)
	{
		if(UpdateVisualizedSuppressionTarget(VisualizeGameState, RemovedEffect, true))
			return;
	}

	super.AddX2ActionsForVisualization_RemovedSource(VisualizeGameState, ActionMetadata, EffectApplyResult, RemovedEffect);
}

// add check to attempt to switch visualiation targets instead of just ending suppression
simulated function CleansedAreaSuppressionVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult, XComGameState_Effect RemovedEffect)
{
	local XComGameStateHistory History;
	local X2Action_EnterCover Action;
	local XComGameState_Unit UnitState;
	local XComGameState SuppressionGameState;

	if(UpdateVisualizedSuppressionTarget(VisualizeGameState, RemovedEffect, true))
		return;

	History = `XCOMHISTORY;

	UnitState = XComGameState_Unit(History.GetGameStateForObjectID(RemovedEffect.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	ActionMetadata.VisualizeActor = History.GetVisualizer(RemovedEffect.ApplyEffectParameters.SourceStateObjectRef.ObjectID);
	History.GetCurrentAndPreviousGameStatesForObjectID(RemovedEffect.ApplyEffectParameters.SourceStateObjectRef.ObjectID, ActionMetadata.StateObject_OldState, ActionMetadata.StateObject_NewState, eReturnType_Reference, VisualizeGameState.HistoryIndex);
	if (ActionMetadata.StateObject_NewState == none)
		ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;

	class'X2Action_StopSuppression'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded);
	Action = X2Action_EnterCover(class'X2Action_EnterCover'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded));
    
	SuppressionGameState = History.GetGameStateFromHistory(UnitState.m_SuppressionHistoryIndex);
	Action.AbilityContext = XComGameStateContext_Ability(SuppressionGameState.GetContext());
}

// this is only for removing from OTHER targets than the one being shot at
static function bool ShouldRemoveAreaSuppression(XComGameState_Unit SourceUnit, optional XComGameState NewGameState, optional bool bBeforeAmmoReduction = false)
{
	local bool bShouldRemove;
	local XComGameState_Item WeaponState;

	bShouldRemove = false;
	if (SourceUnit != none)
	{
		//check remaining ammo
		WeaponState = SourceUnit.GetItemInSlot(eInvSlot_PrimaryWeapon, NewGameState);
		if (WeaponState != none)
		{
			if (bBeforeAmmoReduction)
			{
				if (WeaponState.Ammo <= 1)
					bShouldRemove = true;
			}
			else if (WeaponState.Ammo < 1)
			{
				bShouldRemove = true;
			}
		}
	}

	return bShouldRemove;
}




DefaultProperties
{
	EffectName="Suppression"
	WOTC_APA_Supression_TriggeredName = "WOTC_APA_Supression_Applied"
	WOTC_APA_Supression_SingleTarget_TriggeredName = "WOTC_APA_Supression_SingleTarget_Applied"
}