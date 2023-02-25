
class X2Condition_WOTC_APA_ExtendedProtocolVisibility extends X2Condition config(WOTC_APA_SpecialistSkills);

var config array<name>	LIMIT_HACKING_SQUADSITE_FOR_CLASSES;


event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource)
{
	local XComGameState_Unit				SourceUnit, TargetUnit;
	local int								TargetID;
	local GameRulesCache_VisibilityInfo		VisInfo;

	SourceUnit = XComGameState_Unit(kSource);
	TargetUnit = XComGameState_Unit(kTarget);
	if (TargetUnit != none)
		TargetID = TargetUnit.ObjectID;
	else
		TargetID = XComGameState_InteractiveObject(kTarget).ObjectID;

	// Only evaluate for soldier classes specified for this additional restriction
	if (LIMIT_HACKING_SQUADSITE_FOR_CLASSES.Find(SourceUnit.GetSoldierClassTemplateName()) != -1)
	{	
		// If Source has the Gremlin squadsite effect, succeed
		if (SourceUnit.AffectedByEffectNames.Find('WOTC_APA_GremlinSquadsiteEffect') != -1)
			return 'AA_Success';

		// Otherwise, require the target to be in normal visibilty range
		if (!`TACTICALRULES.VisibilityMgr.GetVisibilityInfo(SourceUnit.ObjectID, TargetID, VisInfo) || !VisInfo.bVisibleGameplay)
			return 'AA_NotInRange';
	}

	return 'AA_Success';	
}