
class X2AbilityCooldown_WOTC_APA_Class_UnitValue extends X2AbilityCooldown;

// Variables to pass into the effect:
var name		UnitName;	//»» Name of the UnitValue to retrieve


simulated function int GetNumTurns(XComGameState_Ability kAbility, XComGameState_BaseObject AffectState, XComGameState_Item AffectWeapon, XComGameState NewGameState)
{
	local XComGameState_Unit	SourceUnit;
	local UnitValue				UnitValue;
	local bool					bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	SourceUnit = XComGameState_Unit(AffectState);
	/**/`Log("WOTC_APA_Class - AbilityCooldown_UnitValue: Setting Cooldown of" @ kAbility.GetMyTemplateName() @ "for" @ SourceUnit.GetFullName(), bLog);

	// Retrieve the unit's current CQC radius unit value - do nothing if one is not found
	if (SourceUnit.GetUnitValue(UnitName, UnitValue))	
	{
		/**/`Log("WOTC_APA_Class - AbilityCooldown_UnitValue: UnitValue '" $ UnitName $ "' found - setting cooldown to" @ Round(UnitValue.fValue), bLog);
		return Round(UnitValue.fValue);
	}

	/**/`Log("WOTC_APA_Class - AbilityCooldown_UnitValue: UnitValue '" $ UnitName $ "' was NOT found - cooldown falling back to iNumTurns:" @ iNumTurns, bLog);
	return iNumTurns;
}