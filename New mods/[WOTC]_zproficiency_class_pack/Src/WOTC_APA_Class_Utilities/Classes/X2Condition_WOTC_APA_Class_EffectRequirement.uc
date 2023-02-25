
class X2Condition_WOTC_APA_Class_EffectRequirement extends X2Condition;

// Variables to pass into the condition check:
var array<name>	ExcludingEffectNames;
var array<name>	RequiredEffectNames;
var bool		bRequireAll;			//»» True (default) makes the RequiredEffectNames array behave as an 'AND' statement. False makes it an 'OR' statement.
var bool		bCheckSourceUnit;		//»» Evaluate against the ability's SourceUnit instead of the TargetUnit (must be set for self-targeting AbilityShooterConditions - they dont pass a kTarget!)
var name		ExcludingErrorCode;		//»» Error code to use when an Excluded effect is present.
var name		RequiredErrorCode;		//»» Error code to use when Required effects are not present.
var string		LogEffectName;			//»» Used only to identify the indiviual effect or ability being evaluated in the Log output.


event name CallAbilityMeetsCondition(XComGameState_Ability kAbility, XComGameState_BaseObject kTarget)
{
	local XComGameState_Unit	UnitState;
	local name					EffectName;
	local bool					bHasRequired;
	local bool					bLog;
	
	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	/**/`Log("WOTC_APA_Class - EffectRequirement: Beginning Effect checks for" @ kAbility.GetMyTemplateName() $ ":" @ LogEffectName, bLog);

	// Get the UnitState to evaluate against
	if (bCheckSourceUnit)
	{
		UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));
		/**/`Log("WOTC_APA_Class - EffectRequirement: SourceUnit is" @ UnitState.GetFullName(), bLog);
	}
	else
	{
		UnitState = XComGameState_Unit(kTarget);
		/**/`Log("WOTC_APA_Class - EffectRequirement: TargetUnit is" @ UnitState.GetFullName(), bLog);
	}

	/**/`Log("WOTC_APA_Class - EffectRequirement:" @ ExcludingEffectNames.Length @ "excluding effects and" @ RequiredEffectNames.Length @ "required effects defined. bRequireAll is" @ bRequireAll, bLog);


	// Check that the Unit has ONE or ALL Required Effects (depending on bRequireAll flag)
	if (RequiredEffectNames.Length > 0)
	{	
		bHasRequired = false;
		foreach RequiredEffectNames(EffectName)
		{
			if (UnitState.AffectedByEffectNames.Find(EffectName) != -1)
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
			/**/`Log("WOTC_APA_Class - EffectRequirement: Unit does not have a/all required effects", bLog);
			return RequiredErrorCode;
		}
		
	/**/`Log("WOTC_APA_Class - EffectRequirement: Unit has a/all required effects", bLog);
	}


	// Check that the Unit has NO Excluding Effects 
	if (ExcludingEffectNames.Length > 0)
	{
		foreach ExcludingEffectNames(EffectName)
		{
			if (UnitState.AffectedByEffectNames.Find(EffectName) != -1)
			{
				/**/`Log("WOTC_APA_Class - EffectRequirement: Unit has an excluding effect", bLog);
				return ExcludingErrorCode;
	}	}	}

	/**/`Log("WOTC_APA_Class - EffectRequirement: Unit has no excluding effects", bLog);

	return 'AA_Success';
}


defaultproperties
{
	bRequireAll = true
	ExcludingErrorCode = "AA_HasAnExcludingEffect"
	RequiredErrorCode = "AA_MissingRequiredEffect"
	LogEffectName = "ability"
}