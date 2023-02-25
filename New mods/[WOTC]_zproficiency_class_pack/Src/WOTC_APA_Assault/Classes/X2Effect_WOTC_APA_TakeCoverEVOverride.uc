
class X2Effect_WOTC_APA_TakeCoverEVOverride extends X2Effect;


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit									SourceUnit;
	local StateObjectReference									OverwatchRef;
	local XComGameState_Ability									OverwatchState;
	local bool													bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	SourceUnit = XComGameState_Unit(kNewTargetState);
	OverwatchRef = SourceUnit.FindAbility('Overwatch');
	OverwatchState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(OverwatchRef.ObjectID));
	if (OverwatchState != none)
	{
		/*»»»*/`LOG("WOTC_APA_TakeCover - Hunker After Movement Tick - Unit also has Ever Vigilant... triggering Overwatch", bLog);
		if (SourceUnit.NumActionPoints() == 0)
		{
			//  give the unit an action point so they can activate overwatch										
			SourceUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);					
		}
		SourceUnit.SetUnitFloatValue(class'X2Ability_SpecialistAbilitySet'.default.EverVigilantEffectName, 1, eCleanup_BeginTurn);
		OverwatchState.AbilityTriggerEventListener_Self(SourceUnit, SourceUnit, NewGameState, '', NewEffectState);
	}
}