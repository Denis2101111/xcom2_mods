
class X2Condition_WOTC_APA_TargetRankRequirement extends X2Condition;

// Variables to pass into the condition check:
var int		iMinRank;			//»» Values of -1 (default) mean no min/max
var int		iMaxRank;			//»» Values of -1 (default) mean no min/max
var name	ExcludeProject;		//»» HQ Project that excludes effects with this condition, regardless of rank (used for projects that grant a higher tier effect, etc.)
var name	GiveProject;		//»» HQ Project that grants effects with this condition, regardless of rank (used for projects that grant this tier effect, etc.)


event name CallAbilityMeetsCondition(XComGameState_Ability kAbility, XComGameState_BaseObject kTarget)
{
	local XComGameState_Unit				TargetUnit;
	local int								iTargetRank;
	local XComGameState_Player				PlayerState;
	
	// Get Target's XComGameState_Unit and Rank
	TargetUnit = XComGameState_Unit(kTarget);
	iTargetRank = TargetUnit.GetSoldierRank();

	// Check for Player Strategy Projects (AWC Unlocks) that should supercede rank checks
	PlayerState = XComGameState_Player(`XCOMHISTORY.GetGameStateForObjectID(TargetUnit.ControllingPlayer.ObjectID));
	if (PlayerState != none && PlayerState.SoldierUnlockTemplates.Length > 0 && ExcludeProject != '')
	{
		if (PlayerState.SoldierUnlockTemplates.Find(ExcludeProject) != -1) { return 'AA_UnitRankOutOfRange'; }
	}

	// If a maximum rank applies and the target's rank is above this maximum, fail check
	if (iMaxRank != -1 && iTargetRank > iMaxRank) { return 'AA_UnitRankOutOfRange'; }

	if (PlayerState != none && PlayerState.SoldierUnlockTemplates.Length > 0 && GiveProject != '')
	{
		if (PlayerState.SoldierUnlockTemplates.Find(GiveProject) != -1) { return 'AA_Success'; }
	}

	// If a minimum rank applies and the target's rank is below this minimum, fail check
	if (iMinRank != -1 && iTargetRank < iMinRank) { return 'AA_UnitRankOutOfRange'; }

	return 'AA_Success';
}


defaultproperties
{
	iMinRank = -1
	iMaxRank = -1
}