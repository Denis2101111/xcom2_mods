
class X2Condition_WOTC_APA_Class_RequiredChanceToHit extends X2Condition config (WOTC_APA_Class_Pack);

var config array<name>	EXCLUDED_ABILITIES;

var name				MinHitChanceValueName;


event name CallAbilityMeetsCondition(XComGameState_Ability kAbility, XComGameState_BaseObject kTarget)
{
	local XComGameStateHistory		History;
	local XComGameState_Unit		TargetUnit, AttackingUnit;
	local StateObjectReference		AbilityRef;
	local XComGameState_Ability		AbilityState;
	local name						AbilityName;
	local X2AbilityTemplate			AbilityTemplate;
	local UnitValue					MinHitChanceValue;
	local X2AbilityToHitCalc		ToHitCalc;	
	local AvailableTarget			Target;
	local int						HitChance, RequiredHitChance;

	History = `XCOMHISTORY;
	TargetUnit = XComGameState_Unit(kTarget);

	// Ignore this condition if the target has an excluded ability (abilities designed to burn overwatch shots, like Lightning Reflexes, etc.)
	foreach default.EXCLUDED_ABILITIES(AbilityName)
	{
		if (TargetUnit != none)
		{
			AbilityRef = Targetunit.FindAbility(AbilityName);
			AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityRef.ObjectID));
			if (AbilityState != none)
				return 'AA_Success'; 
		}
	}


	AbilityTemplate = kAbility.GetMyTemplate();
	AttackingUnit = XComGameState_Unit(History.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));
	if (AttackingUnit !=none)
	{
		AttackingUnit.GetUnitValue(MinHitChanceValueName, MinHitChanceValue);
		if (MinHitChanceValue.fValue > 0.0)
			RequiredHitChance = MinHitChanceValue.fValue;
		else
			return 'AA_Success';
	}
	

	ToHitCalc = AbilityTemplate.AbilityToHitCalc;	
	if(ToHitCalc != none)
	{
		Target.PrimaryTarget = kTarget.GetReference();
		HitChance = ToHitCalc.GetShotBreakdown(kAbility, Target);
		if(HitChance < RequiredHitChance)
		{
			return 'AA_HitResultFailure';
		}
	}

	return 'AA_Success'; 
}


defaultproperties
{
    MinHitChanceValueName = "WOTC_APA_RequiredChanceToHitValue"
}