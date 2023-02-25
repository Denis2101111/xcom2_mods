
class X2Condition_WOTC_APA_Class_AbilityRequirement extends X2Condition;

// Variables to pass into the condition check:
var array<name>	ExcludingAbilityNames;
var array<name>	RequiredAbilityNames;
var bool		bRequireAll;			//»» True (default) makes the RequiredEffectNames array behave as an 'AND' statement. False makes it an 'OR' statement.
var bool		bCheckSourceUnit;		//»» Evaluate against the ability's SourceUnit instead of the TargetUnit
var name		ExcludingErrorCode;		//»» Error code to use when an Excluded ability is present.
var name		RequiredErrorCode;		//»» Error code to use when Required abilities are not present.
var string		LogEffectName;			//»» Used only to identify the indiviual effect or ability being evaluated in the Log output.


event name CallAbilityMeetsCondition(XComGameState_Ability kAbility, XComGameState_BaseObject kTarget)
{
	local XComGameState_Unit	UnitState;
	local name					AbilityName;
	local bool					bHasRequired;
	local bool					bLog;
	
	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	/**/`Log("WOTC_APA_Class - AbilityRequirement: Beginning Ability checks for" @ kAbility.GetMyTemplateName() $ ":" @ LogEffectName, bLog);

	// Get the UnitState to evaluate against
	if (bCheckSourceUnit)
	{
		UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));
		/**/`Log("WOTC_APA_Class - AbilityRequirement: SourceUnit is" @ UnitState.GetFullName(), bLog);
	}
	else
	{
		UnitState = XComGameState_Unit(kTarget);
		/**/`Log("WOTC_APA_Class - AbilityRequirement: TargetUnit is" @ UnitState.GetFullName(), bLog);
	}

	/**/`Log("WOTC_APA_Class - AbilityRequirement:" @ ExcludingAbilityNames.Length @ "excluding abilities and" @ RequiredAbilityNames.Length @ "required abilities defined. bRequireAll is" @ bRequireAll, bLog);


	// Check that the Unit has ONE or ALL Required Abilities (depending on bRequireAll flag)
	if (RequiredAbilityNames.Length > 0)
	{	
		bHasRequired = false;
		foreach RequiredAbilityNames(AbilityName)
		{
			if (UnitState.HasSoldierAbility(AbilityName))
			{
				bHasRequired = true;

				if (bRequireAll) continue;
				else break;
			}
			else
			{
				if (bRequireAll)
				{
					bHasRequired = false;
					break;
		}	}	}

		if (!bHasRequired)
		{
			/**/`Log("WOTC_APA_Class - AbilityRequirement: Unit does not have a/all required abilities", bLog);
			return RequiredErrorCode;
		}
		
	/**/`Log("WOTC_APA_Class - AbilityRequirement: Unit has a/all required abilities", bLog);
	}


	// Check that the Unit has NO Excluding Abilities 
	if (ExcludingAbilityNames.Length > 0)
	{
		foreach ExcludingAbilityNames(AbilityName)
		{
			if (UnitState.HasSoldierAbility(AbilityName))
			{
				/**/`Log("WOTC_APA_Class - AbilityRequirement: Unit has an excluding ability", bLog);
				return ExcludingErrorCode;
	}	}	}

	/**/`Log("WOTC_APA_Class - AbilityRequirement: Unit has no excluding abilities", bLog);

	return 'AA_Success';
}


defaultproperties
{
	bRequireAll = true
	ExcludingErrorCode = "AA_HasAnExcludingAbility"
	RequiredErrorCode = "AA_MissingRequiredAbility"
	LogEffectName = "ability"
}