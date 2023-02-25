
class X2Effect_WOTC_APA_EverVigilant extends X2Effect_Persistent;

// Register for the tick triggers to activate Overwatch
function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager						EventManager;
	local Object								EffectObj, TargetObj;
	local bool									bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	EventManager = `XEVENTMGR;
	EffectObj = EffectGameState;
	TargetObj = `XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID);

	/*»»»*/`LOG("WOTC_APA_EverVigilant - Registered Event Listener for" @ XComGameState_Unit(TargetObj).GetFullName(), bLog);
	EventManager.RegisterForEvent(TargetObj, 'WOTC_APA_EverVigilantTriggered', OnEverVigilantTriggered, ELD_OnStateSubmitted,,TargetObj,, EffectObj);
}

// Trigger the Overwatch ability
static function EventListenerReturn OnEverVigilantTriggered(Object EventData, Object EventSource, XComGameState NewGameState, Name EventID, Object CallbackData)
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

	/*»»»*/`LOG("WOTC_APA_EverVigilant - Triggering Ever Vigilant Overwatch", bLog);
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