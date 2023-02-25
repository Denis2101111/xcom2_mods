
class X2Effect_WOTC_APA_TakeCover extends X2Effect_Persistent implements(XMBEffectInterface);

// Register for the tick triggers to activate Hunker Down and Overwatch (with Ever Vigilant)
function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager						EventManager;
	local Object								EffectObj, TargetObj;
	local XComGameState_Unit					TargetUnit;
	local bool									bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	EventManager = `XEVENTMGR;
	EffectObj = EffectGameState;
	TargetObj = `XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID);
	TargetUnit = XComGameState_Unit(TargetObj);

	if (TargetUnit.HasSoldierAbility('WOTC_APA_TakeCover'))
		EventManager.RegisterForEvent(TargetObj, 'WOTC_APA_TakeCoverHunkerTriggered', TakeCoverHunkerTriggered, ELD_OnStateSubmitted,,TargetObj,, EffectObj);
	
	if (TargetUnit.HasSoldierAbility('WOTC_APA_EverVigilant'))
		EventManager.RegisterForEvent(TargetObj, 'WOTC_APA_EverVigilantOverwatchTriggered', EverVigilantOverwatchTriggered, ELD_OnStateSubmitted,,TargetObj,, EffectObj);
}

// Trigger the Hunker Down ability
static function EventListenerReturn TakeCoverHunkerTriggered(Object EventData, Object EventSource, XComGameState NewGameState, Name EventID, Object CallbackData)
{
	local XComGameState_Unit									SourceUnit;
	local StateObjectReference									HunkerDownRef;
	local XComGameState_Ability									HunkerDownState;
	local XComGameState											HunkerGameState;
	local bool													bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	/*»»»*/`LOG("WOTC_APA_TakeCover - Hunker After Movement Tick - Triggering HunkerDown", bLog);
	SourceUnit = XComGameState_Unit(EventData);
	HunkerDownRef = SourceUnit.FindAbility('HunkerDown');
	HunkerDownState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(HunkerDownRef.ObjectID));
	if (HunkerDownState != none && HunkerDownState.CanActivateAbility(SourceUnit,,true) == 'AA_Success')
	{
		HunkerGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState(string(GetFuncName()));
		SourceUnit = XComGameState_Unit(HunkerGameState.ModifyStateObject(SourceUnit.Class, SourceUnit.ObjectID));
		if (SourceUnit.NumActionPoints() == 0)
			SourceUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.DeepCoverActionPoint);					
		
		`TACTICALRULES.SubmitGameState(HunkerGameState);

		HunkerDownState.AbilityTriggerEventListener_Self(EventData, EventSource, NewGameState, EventID, CallbackData);
	}

	return ELR_NoInterrupt;
}

// Trigger the Overwatch ability
static function EventListenerReturn EverVigilantOverwatchTriggered(Object EventData, Object EventSource, XComGameState NewGameState, Name EventID, Object CallbackData)
{
	local XComGameState_Unit									SourceUnit;
	local StateObjectReference									OverwatchRef;
	local XComGameState_Ability									OverwatchState;
	local XComGameState											OverwatchGameState;
	local XComGameState_Item									WeaponItem;
	local X2WeaponTemplate										WeaponTemplate;
	local EffectAppliedData										ApplyData;
	local X2Effect												VigilantEffect;
	local bool													bLog, bPrimaryOverwatch;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	/*»»»*/`LOG("WOTC_APA_TakeCover - Hunker After Movement Tick - Triggering Ever Vigilant Overwatch", bLog);
	SourceUnit = XComGameState_Unit(EventData);

	// Check Primary weapon overwatch first
	OverwatchRef = SourceUnit.FindAbility('Overwatch');
	if (OverwatchRef.ObjectID != 0)
	{		
		WeaponItem = SourceUnit.GetItemInSlot(eInvSlot_PrimaryWeapon);
		WeaponTemplate = X2WeaponTemplate(WeaponItem.GetMyTemplate());
		if (WeaponItem != none && WeaponTemplate != none)
		{
			if (WeaponItem.Ammo > 1)
			{
				bPrimaryOverwatch = true;
		}	}
	}

	// Fallback to Pistol Overwatch next
	if (!bPrimaryOverwatch)
	{
		OverwatchRef = SourceUnit.FindAbility('PistolOverwatch');
	}

	OverwatchState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(OverwatchRef.ObjectID));
	if (OverwatchState != none)
	{
		OverwatchGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState(string(GetFuncName()));
		SourceUnit = XComGameState_Unit(OverwatchGameState.ModifyStateObject(SourceUnit.Class, SourceUnit.ObjectID));
		//  apply the EverVigilantActivated effect directly to the unit (triggers the right flyovers)
		ApplyData.EffectRef.LookupType = TELT_AbilityShooterEffects;
		ApplyData.EffectRef.TemplateEffectLookupArrayIndex = 0;
		ApplyData.EffectRef.SourceTemplateName = 'EverVigilantTrigger';
		ApplyData.PlayerStateObjectRef = SourceUnit.ControllingPlayer;
		ApplyData.SourceStateObjectRef = SourceUnit.GetReference();
		ApplyData.TargetStateObjectRef = SourceUnit.GetReference();
		VigilantEffect = class'X2Effect'.static.GetX2Effect(ApplyData.EffectRef);
		`assert(VigilantEffect != none);
		VigilantEffect.ApplyEffect(ApplyData, SourceUnit, OverwatchGameState);

		if (SourceUnit.NumActionPoints() == 0)
		{
			//  give the unit an action point so they can activate overwatch										
			SourceUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);					
		}
		SourceUnit.SetUnitFloatValue(class'X2Ability_SpecialistAbilitySet'.default.EverVigilantEffectName, 1, eCleanup_BeginTurn);
		`TACTICALRULES.SubmitGameState(OverwatchGameState);

		OverwatchState.AbilityTriggerEventListener_Self(EventData, EventSource, NewGameState, EventID, CallbackData);
	}

	return ELR_NoInterrupt;
}


// XMB Action Point Interface


function bool GetTagValue(name Tag, XComGameState_Ability AbilityState, out string TagValue);
function bool GetExtModifiers(name Type, XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, optional ShotBreakdown ShotBreakdown, optional out array<ShotModifierInfo> ShotModifiers);

function bool GetExtValue(LWTuple Data)
{
	local XComGameState_Unit			SourceUnit;
	local XComGameState_Ability			AbilityState;
	local XComGameState_Effect			EffectState;
	local X2AbilityCost_ActionPoints	ActionPointCost;
	local X2AbilityCost					Cost;
	local name							Type;

	if (Data.Id == 'GetActionPointCost')
	{
		SourceUnit = XComGameState_Unit(Data.Data[0].o);
		AbilityState = XComGameState_Ability(Data.Data[1].o);
		EffectState = XComGameState_Effect(Data.Data[2].o);

		if (AbilityState.GetMyTemplateName() == 'HunkerDown')
		{
			if (SourceUnit.ActionPoints.Find(class'X2CharacterTemplateManager'.default.MoveActionPoint) != -1)
			{
				Data.Data[3].i = 0;
				return true;
	}	}	}

	return false;
}



DefaultProperties
{
	DuplicateResponse=eDupe_Ignore
}