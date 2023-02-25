
class X2Condition_WOTC_APA_FleetFootedRapidDeploymentGrenadeType extends X2Condition;


event name CallAbilityMeetsCondition(XComGameState_Ability kAbility, XComGameState_BaseObject kTarget)
{
	local XComGameState_Unit		SourceUnit;
	local XComGameState_Item		SourceWeapon;
	local bool						bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));
	SourceWeapon = kAbility.GetSourceWeapon();

	/**/`Log("WOTC_APA_Medic - RapidDeploymentGrenade: Beginning checks for " $ SourceUnit.GetFullName(), bLog);
	/**/`Log("WOTC_APA_Medic - RapidDeploymentGrenade: SourceWeapon = " $ SourceWeapon.GetMyTemplateName(), bLog);

	if (SourceUnit.ActionPoints.Find('FleetFootedRapidDeployment') != -1 && SourceUnit.ActionPoints.Find(class'X2CharacterTemplateManager'.default.StandardActionPoint) == -1) 
	{
		if (class'X2Effect_WOTC_APA_RapidDeployment'.default.RAPID_DEPLOYMENT_VALID_GRENADE_TYPES.Find(SourceWeapon.GetMyTemplateName()) == -1)
			return 'AA_AbilityUnavailable';
	}

	return 'AA_Success';
}