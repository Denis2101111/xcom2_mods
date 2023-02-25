
class X2AbilityTrigger_WOTC_APA_Class_ReactionShotEventListener extends X2AbilityTrigger_EventListener;


var bool bRequireCoveringFire;

simulated function RegisterListener(XComGameState_Ability AbilityState, Object FilterObject)
{
	local Object AbilityObj;
	local XComGameState_Unit UnitState;
	
	if( ListenerData.OverrideListenerSource != none )
	{
		AbilityObj = ListenerData.OverrideListenerSource;
	}
	else
	{
		AbilityObj = AbilityState;
	}
	
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
	if (UnitState.HasSoldierAbility('CoveringFire') || !bRequireCoveringFire)
	{
		`XEVENTMGR.RegisterForEvent(AbilityObj, ListenerData.EventID, OnAttackListener, ListenerData.Deferral, ListenerData.Priority, FilterObject,, AbilityState);
	}
}


//simulated function bool FixupRegisterListener(XComGameState_Ability AbilityState, Object FilterObject)
//{
	//local Object AbilityObj;
	//local XComGameState_Unit UnitState;
//
	//if( ListenerData.OverrideListenerSource != none )
	//{
		//AbilityObj = ListenerData.OverrideListenerSource;
	//}
	//else
	//{
		//AbilityObj = AbilityState;
	//}
//
	//UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
	//if (UnitState.HasSoldierAbility('CoveringFire') || !bRequireCoveringFire)
	//{
		//if (`XEVENTMGR.IsRegistered(AbilityObj, ListenerData.EventID, ListenerData.Deferral, ListenerData.EventFn))
			//return false;
//
		//`XEVENTMGR.RegisterForEvent(AbilityObj, ListenerData.EventID, OnAttackListener, ListenerData.Deferral, ListenerData.Priority, FilterObject,, AbilityState);
	//}
//
	//return true;
//}


static function EventListenerReturn OnAttackListener(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameStateContext_Ability	AbilityContext;
	local XComGameState_Ability			AbilityState;
	local X2AbilityTemplate				AbilityTemplate;
	local XComGameState_Unit			TargetUnit;

	AbilityContext = XComGameStateContext_Ability(GameState.GetContext());
	if (AbilityContext != none)
	{
		AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID));
		AbilityTemplate = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().FindAbilityTemplate(AbilityContext.InputContext.AbilityTemplateName);
		TargetUnit = XComGameState_Unit(EventSource);
		if (AbilityTemplate != none && AbilityTemplate.Hostility == eHostility_Offensive && (AbilityState.CanActivateAbilityForObserverEvent(TargetUnit) == 'AA_Success'))
		{
			AbilityState.AbilityTriggerAgainstSingleTarget(TargetUnit.GetReference(), false);
		}
	}	

	return ELR_NoInterrupt;
}