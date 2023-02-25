
class X2Effect_WOTC_APA_Reposition extends X2Effect_Persistent config (WOTC_APA_MedicSkills);

var config array<name>	REPOSITION_TRIGGER_ABILITIES;
var config array<name>	REPOSITION_KILL_OVERRIDE_ABILITIES;
var config array<name>	REPOSITION_KILL_OVERRIDE_EFFECTS;

var name WOTC_APA_Reposition_TriggeredName;


function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{

	local XComGameStateHistory								History;
	local XComGameState_Unit								TargetUnit, PrevTargetUnit;
	local X2EventManager									EventManager;
	local XComGameState_Ability								AbilityState;
	local GameRulesCache_VisibilityInfo						VisInfo;
	local UnitValue											ImplacableValue;
	local int												i;

	// Exclude shots taken after activating Run and Gun (or a variant)
	//if (PreCostActionPoints.Find('RunAndGun') != -1)
		//return false;
	
	// Limit Reposition triggering to once per turn - exclude any attacks made by a unit under the effects of Reposition's mobility penalty (via Command, etc.)
	if (SourceUnit.AffectedByEffectNames.Find('WOTC_APA_RepositionMobilityPenalty') != -1)
		return false;

	// Get Target's XComGameState_Unit
	History = `XCOMHISTORY;
	TargetUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
		
	// Require the ability be a standard shot as defined by the configurable REPOSITION_TRIGGER_ABILITIES array variable
	if (default.REPOSITION_TRIGGER_ABILITIES.Find(kAbility.GetMyTemplateName()) == -1)	
		return false;

	// Exclude kills made with any ability or effect active from the configurable REPOSITION_KILL_OVERRIDE array variables, allowing the overriding effect to handle the event
	if (TargetUnit != none && TargetUnit.IsDead() && TargetUnit.IsEnemyUnit(SourceUnit))
	{	
		// Excluded Abilities that always trigger on kills (such as Implacable) that should override Reposition
		for (i=0; i < REPOSITION_KILL_OVERRIDE_ABILITIES.length; ++i)
		{
			if (SourceUnit.HasSoldierAbility(REPOSITION_KILL_OVERRIDE_ABILITIES[i]))
				return false;
		}

		// Excluded Effects that trigger on kills (typically conditional or activated abilities, such as Serial) that should override Reposition
		for (i=0; i < REPOSITION_KILL_OVERRIDE_EFFECTS.length; ++i)
		{
			if (SourceUnit.IsUnitAffectedByEffectName(REPOSITION_KILL_OVERRIDE_EFFECTS[i]))
				return false;
		}

		// Special handling for Death From Above because it's not behaving nicely in the override array variables
		if (SourceUnit.HasSoldierAbility('DeathFromAbove'))
		{
			PrevTargetUnit = XComGameState_Unit(History.GetGameStateForObjectID(TargetUnit.ObjectID));
			if (TargetUnit.IsDead() && PrevTargetUnit != None && SourceUnit.HasHeightAdvantageOver(PrevTargetUnit, true))
				return false;
		}
	}

	// Prevent stacking with Implacable in a situation where a kill was previously obtained without ending the turn (Light 'em Up, Hip Fire, etc.)
	SourceUnit.GetUnitValue(class'X2Effect_Implacable'.default.ImplacableThisTurnValue, ImplacableValue);
	if (ImplacableValue.fValue != 0)
		return false;

	// Require the attack to hit
	if (!AbilityContext.IsResultContextHit())
		return false;

	// Special handling for Close Encounters because it can't be handled in the override array variables
	if (SourceUnit.HasSoldierAbility('LW2WotC_CloseEncounters'))
	{
		if (SourceUnit.TileDistanceBetween(TargetUnit) <= class'X2Effect_LW2WotC_CloseEncounters'.default.CE_MAX_TILES + 1)
			return false;
	}

	// Target must be either flanked, exposed (i.e., unit cannot use cover), or not yet alerted (thus not benefiting from cover)
	if(X2TacticalGameRuleset(XComGameInfo(class'Engine'.static.GetCurrentWorldInfo().Game).GameRuleset).VisibilityMgr.GetVisibilityInfo(SourceUnit.ObjectID, TargetUnit.ObjectID, VisInfo))
	{
		if (TargetUnit.GetMyTemplate().bCanTakeCover || TargetUnit.GetCurrentStat(eStat_AlertLevel) < 2)
		{
			if (!SourceUnit.CanFlank() || VisInfo.TargetCover != CT_None)
				return false;
		}
	}

	// Require that the action be turn-ending
	if (SourceUnit.NumActionPoints() == 0) 
	{
		AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
		if (AbilityState != none)
		{				
			SourceUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.MoveActionPoint);
			EventManager = `XEVENTMGR;
			EventManager.TriggerEvent(default.WOTC_APA_Reposition_TriggeredName, AbilityState, SourceUnit, NewGameState);
			return false;
		}
	}

	return false;
}


defaultproperties
{
    WOTC_APA_Reposition_TriggeredName = "WOTC_APA_Reposition_Triggered"
}