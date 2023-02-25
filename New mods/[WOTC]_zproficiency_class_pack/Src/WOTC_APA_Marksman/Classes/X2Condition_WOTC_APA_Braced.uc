
class X2Condition_WOTC_APA_Braced extends X2Condition;


// Variables to pass into the condition check:
var bool			bAllowTempBrace;
var array<name>		ExcludedAbilityNames;


event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource)
{
	local XComGameState_Unit	SourceUnit;

	SourceUnit = XComGameState_Unit(kSource);
	if (SourceUnit == none)
		return 'AA_NotAUnit';
	
	// If SourceUnit has the Braced effect, succeed
	if (SourceUnit.AffectedByEffectNames.Find('WOTC_APA_Brace_BracedEffect') != -1)
		return 'AA_Success';

	// If SourceUnit has the Temp Braced effect and it's allowed, succeed
	if (SourceUnit.AffectedByEffectNames.Find('WOTC_APA_Brace_TempBracedEffect') != -1 && bAllowTempBrace)
		return 'AA_Success';


	return 'AA_RequiresBraced';
}


event name CallAbilityMeetsCondition(XComGameState_Ability kAbility, XComGameState_BaseObject kTarget)
{
	local XComGameState_Unit	SourceUnit;

	// Fail for excluded abilities
	if (ExcludedAbilityNames.Find(kAbility.GetMyTemplateName()) != Index_None)
		return 'AA_AbilityUnavailable';

	// Ability must be sourced from the Primary Weapon
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));
	if (kAbility.SourceWeapon.ObjectID != SourceUnit.GetPrimaryWeapon().ObjectID)
		return 'AA_AbilityUnavailable';

	return 'AA_Success';	
}


DefaultProperties
{

}