
class X2Effect_WOTC_APA_FireDisciplineToggle extends X2Effect_Persistent;


var name				FireDisciplineToggleName;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit		UnitState;
	local UnitValue					MinHitToggleValue, MinHitChanceValue;
	local int						i, NewToggleValue, NewHitChanceValue;

	UnitState = XComGameState_Unit(kNewTargetState);
	UnitState.GetUnitValue(FireDisciplineToggleName, MinHitToggleValue);
	
	i = int(MinHitToggleValue.fValue);
	switch(i)
	{
		case 0:
			NewToggleValue = 1;
			NewHitChanceValue = class'X2Ability_WOTC_APA_MarineAbilitySet'.default.FIRE_DISCIPLINE_REACTION_CHANCE_LIMIT_2;
			break;
		case 1:
			NewToggleValue = 2;
			NewHitChanceValue = class'X2Ability_WOTC_APA_MarineAbilitySet'.default.FIRE_DISCIPLINE_REACTION_CHANCE_LIMIT_3;
			break;
		case 2:
			NewToggleValue = 0;
			NewHitChanceValue = class'X2Ability_WOTC_APA_MarineAbilitySet'.default.FIRE_DISCIPLINE_REACTION_CHANCE_LIMIT_1;
			break;
	}

	UnitState.SetUnitFloatValue(FireDisciplineToggleName, NewToggleValue, eCleanup_Never);
	UnitState.SetUnitFloatValue(class'X2Condition_WOTC_APA_Class_RequiredChanceToHit'.default.MinHitChanceValueName, NewHitChanceValue, eCleanup_Never);

	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
}


defaultproperties
{
    FireDisciplineToggleName = "WOTC_APA_FireDisciplineToggleValue"
}