
class X2Effect_WOTC_APA_Medivac extends X2Effect_Persistent;


function RegisterForEvents(XComGameState_Effect EffectGameState)
{

	local Object EffectObj;

	EffectObj = EffectGameState;

	// Remove the default UnitRemovedFromPlay registered by XComGameState_Effect. This is necessary so we can suppress
	// the usual behavior of the effects being removed when a unit evacs. We need to wait until the mission ends and then
	// process the Medivac ability.
	`XEVENTMGR.UnRegisterFromEvent(EffectObj, 'UnitRemovedFromPlay');
}


function int ApplyMedivacHealing(XComGameState_Effect EffectState, XComGameState_Unit OrigUnitState, XComGameState NewGameState)
{

	local XComGameStateHistory		History;
	local XComGameState_Unit		TargetUnit, PrevTargetUnit;
	local bool						bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	History = `XCOMHISTORY;
	TargetUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(OrigUnitState.ObjectID));
	if (TargetUnit == none)
	{
		TargetUnit = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', OrigUnitState.ObjectID));
		NewGameState.AddStateObject(TargetUnit);
	}

	if (TargetUnit.IsRobotic()) { return 0; }
	PrevTargetUnit = XComGameState_Unit(History.GetGameStateForObjectID(TargetUnit.ObjectID));
	
	/**/`Log("WOTC_APA_Medic - Medivac: Beginning HP checks for " $ PrevTargetUnit.GetFullName(), bLog);
	/**/`Log("WOTC_APA_Medic - Medivac:" $ PrevTargetUnit.GetFullName() $ "'s current LowestHP/HighestHP: " $ PrevTargetUnit.LowestHP $ "/" $ PrevTargetUnit.HighestHP, bLog);
	/**/`Log("WOTC_APA_Medic - Medivac:" $ PrevTargetUnit.GetFullName() $ "'s LowestHP cap for Medivac to apply: " $ int(PrevTargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_HP_PERCENT_CAP), bLog);

	// Check that the target's LowestHP value is below the %-cap threshold
	if (PrevTargetUnit.LowestHP < Round(PrevTargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_HP_PERCENT_CAP))
	{
		TargetUnit.LowestHP = Round(PrevTargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_HP_PERCENT_CAP);
		TargetUnit.ModifyCurrentStat(eStat_HP, (TargetUnit.LowestHP - TargetUnit.GetCurrentStat(eStat_HP)));
	/**/`Log("WOTC_APA_Medic - Medivac:" $ PrevTargetUnit.GetFullName() $ "'s LowestHP set to: " $ int(PrevTargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_HP_PERCENT_CAP), bLog);
		super.UnitEndedTacticalPlay(EffectState, TargetUnit);
		return 1;
	}

	// If the target's LowestHP is the minimum of 1 and their HighestHP is too low to be eligible for boosts, give the minimum 1 HP boost
	if (PrevTargetUnit.LowestHP == 1)
	{
		TargetUnit.LowestHP += 1;
		TargetUnit.ModifyCurrentStat(eStat_HP, 1);
	/**/`Log("WOTC_APA_Medic - Medivac:" $ PrevTargetUnit.GetFullName() $ "'s LowestHP set to: 2 (Minimum boost applied - Target's total HP too low to qualify normally)", bLog);
		super.UnitEndedTacticalPlay(EffectState, TargetUnit);
		return 1;
	}

	return 0;
}


DefaultProperties
{
	EffectName="WOTC_APA_Medivac"
	DuplicateResponse=eDupe_Ignore
}