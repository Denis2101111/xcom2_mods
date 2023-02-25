
class X2Effect_WOTC_APA_CombatStimulants extends X2Effect_TurnStartActionPoints;


simulated function AddX2ActionsForVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, name EffectApplyResult)
{
	local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;
	local string								Msg;
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded));
	Msg = Repl(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.strCombatStimulantsTickedFlyover, "<Duration/>", class'X2Ability_WOTC_APA_MedicAbilitySet'.default.COMBAT_STIMULANTS_TURN_DURATION);
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, Msg, '', eColor_Good, "img:///UILibrary_WOTC_APA_Class_Pack.perk_CombatStimulants", `DEFAULTFLYOVERLOOKATTIME * 2.5, true);
}


simulated function AddX2ActionsForVisualization_Tick(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const int TickIndex, XComGameState_Effect EffectState)
{
	local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;
	local string								Msg;
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded));
	Msg = Repl(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.strCombatStimulantsTickedFlyover, "<Duration/>", EffectState.iTurnsRemaining);
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, Msg, '', eColor_Good, "img:///UILibrary_WOTC_APA_Class_Pack.perk_CombatStimulants", `DEFAULTFLYOVERLOOKATTIME * 2.5, true);
}


simulated function OnEffectRemoved(const out EffectAppliedData ApplyEffectParameters, XComGameState NewGameState, bool bCleansed, XComGameState_Effect RemovedEffectState)
{
	local XComGameState_Unit	UnitState;
	local int					i;

	super.OnEffectRemoved(ApplyEffectParameters, NewGameState, bCleansed, RemovedEffectState);

	// Charge HP and Will penalties if unit is still alive
	UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	if (UnitState.GetCurrentStat(eStat_HP) > 0)
	{
		//i = Max(1, UnitState.GetCurrentStat(eStat_HP) - Round(UnitState.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.COMBAT_STIMULANTS_HEALTH_PENALTY));
		//UnitState.SetCurrentStat(eStat_HP, i);
		//if (UnitState.LowestHP > i)
			//UnitState.LowestHP = i;
	
		i = Max(1, UnitState.GetCurrentStat(eStat_Will) - class'X2Ability_WOTC_APA_MedicAbilitySet'.default.COMBAT_STIMULANTS_WILL_PENALTY);
		UnitState.SetCurrentStat(eStat_Will, i);
	}
}


function UnitEndedTacticalPlay(XComGameState_Effect EffectState, XComGameState_Unit UnitState)
{
	local int					i;

	if (UnitState.GetCurrentStat(eStat_HP) > 0)
	{
		//i = Max(1, UnitState.GetCurrentStat(eStat_HP) - Round(UnitState.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.COMBAT_STIMULANTS_HEALTH_PENALTY));
		//UnitState.SetCurrentStat(eStat_HP, i);
		//if (UnitState.LowestHP > i)
			//UnitState.LowestHP = i;
	
		i = Max(1, UnitState.GetCurrentStat(eStat_Will) - class'X2Ability_WOTC_APA_MedicAbilitySet'.default.COMBAT_STIMULANTS_WILL_PENALTY);
		UnitState.SetCurrentStat(eStat_Will, i);
	}
}


simulated function AddX2ActionsForVisualization_Removed(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult, XComGameState_Effect RemovedEffect)
{
	local XComGameState_Unit					OldUnit, NewUnit;
	local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;
	local int									HP, Will;
	local string								Msg;
	
	OldUnit = XComGameState_Unit(ActionMetadata.StateObject_OldState);
	NewUnit = XComGameState_Unit(ActionMetadata.StateObject_NewState);

	//HP = OldUnit.GetCurrentStat(eStat_HP) - NewUnit.GetCurrentStat(eStat_HP);
	Will = OldUnit.GetCurrentStat(eStat_Will) - NewUnit.GetCurrentStat(eStat_Will);

	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded));
	//Msg = Repl(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.strCombatStimulantsRemovedFlyover, "<HP/>", HP);
	Msg = Repl(Msg, "<Will/>", Will);
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, Msg, '', eColor_Bad, "img:///UILibrary_WOTC_APA_Class_Pack.perk_CombatStimulants", `DEFAULTFLYOVERLOOKATTIME * 3, true);
}