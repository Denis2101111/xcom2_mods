
class X2Effect_WOTC_APA_ProtocolSharedCooldown extends X2Effect;

// Variables to pass into the condition check:
var array<name>	AbilitiesToSet;		//»» The abilities on the target that will be set
var int			SetCooldownTo;		//»» Set the abilitystate's iCooldown to this value


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameStateHistory		History;
	local XComGameState_Unit		TargetUnit;
	local XComGameState_Ability		AbilityState;
	local bool						bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	History = `XCOMHISTORY;
	TargetUnit = XComGameState_Unit(kNewTargetState);

	// Locate the target's abilitystates that match the AbilitiesToSet array
	foreach History.IterateByClassType(class'XComGameState_Ability', AbilityState)
	{
		if (AbilityState.OwnerStateObject.ObjectID == TargetUnit.ObjectID)
		{
			if (AbilitiesToSet.Find(AbilityState.GetMyTemplateName()) != -1)
			{
				if (AbilityState.iCooldown < SetCooldownTo)
				{
					AbilityState = XComGameState_Ability(NewGameState.CreateStateObject(class'XComGameState_Ability', AbilityState.ObjectID));
					NewGameState.AddStateObject(AbilityState);
					AbilityState.iCooldown = SetCooldownTo;
}	}	}	}	}