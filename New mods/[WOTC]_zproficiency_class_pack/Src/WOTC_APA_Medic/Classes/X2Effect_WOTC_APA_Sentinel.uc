Class X2Effect_WOTC_APA_Sentinel extends X2Effect_Persistent config (WOTC_APA_MedicSkills);

var config array<name> SENTINEL_VALID_ABILITIES;

var name CounterUnitValueName;


function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	local UnitValue				CounterUnitValue;
	local XComGameState_Unit	TargetUnit;
	local name					OWShooterValueName;

	SourceUnit.GetUnitValue(CounterUnitValueName, CounterUnitValue);

	// Exit if the number of uses per turn have already been refunded
	if (CounterUnitValue.fValue + 1 >= class'X2Ability_WOTC_APA_MedicAbilitySet'.default.SENTINEL_USES_PER_TURN)
		return false;

	if (XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID)) == none)
		return false;

	if (SourceUnit.ReserveActionPoints.Length != PreCostReservePoints.Length && default.SENTINEL_VALID_ABILITIES.Find(kAbility.GetMyTemplateName()) != -1)
	{
		// Increment the use counter and refund reserve action points
		SourceUnit.SetUnitFloatValue (CounterUnitValueName, CounterUnitValue.fValue + 1, eCleanup_BeginTurn);
		SourceUnit.ReserveActionPoints = PreCostReservePoints;

		// Set UnitValue to limit to one shot per target
		TargetUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
		OWShooterValueName = name("OverwatchShot" $ TargetUnit.ObjectID);
		SourceUnit.SetUnitFloatValue(OWShooterValueName, 1.0, eCleanup_BeginTurn);

	}
	return false;
}


DefaultProperties
{
	CounterUnitValueName="WOTC_APA_SentinelActivations"
	DuplicateResponse=eDupe_Ignore
}