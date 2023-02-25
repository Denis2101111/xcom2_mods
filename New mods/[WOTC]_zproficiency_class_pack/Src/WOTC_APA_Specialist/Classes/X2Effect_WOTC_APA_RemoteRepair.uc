class X2Effect_WOTC_APA_RemoteRepair extends X2Effect_ApplyMedikitHeal;

var localized string strRepairedMessage;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameStateHistory		History;
	local XComGameState_Ability		Ability;
	local XComGameState_Effect		EffectState;
	local XComGameState_Unit		TargetUnit, SourceUnit;
	local int						RepairAmount;
	

	History = `XCOMHISTORY;
	Ability = XComGameState_Ability(NewGameState.GetGameStateForObjectID(ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
	if (Ability == none)
		Ability = XComGameState_Ability(History.GetGameStateForObjectID(ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
	TargetUnit = XComGameState_Unit(kNewTargetState);
	if (Ability != none && TargetUnit != none)
	{
		// Get RepairAmount based on equipped Gremlin
		RepairAmount = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.REMOTE_REPAIR_HP_T1_BASE;

		SourceUnit = XComGameState_Unit(History.GetGameStateForObjectID(ApplyEffectParameters.SourceStateObjectRef.ObjectID));
		if (SourceUnit.AffectedByEffectNames.Find('WOTC_APA_T2GremlinIndicatorEffect') != -1)
			RepairAmount = RepairAmount + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.REMOTE_REPAIR_HP_T2_BONUS;

		if (SourceUnit.AffectedByEffectNames.Find('WOTC_APA_T3GremlinIndicatorEffect') != -1)
			RepairAmount = RepairAmount + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.REMOTE_REPAIR_HP_T3_BONUS;
		
		// Modify TargetUnit HP
		TargetUnit.ModifyCurrentStat(eStat_HP, RepairAmount);
		`TRIGGERXP('XpHealDamage', ApplyEffectParameters.SourceStateObjectRef, kNewTargetState.GetReference(), NewGameState);

		if ((SourceUnit.ObjectID != TargetUnit.ObjectID) && SourceUnit.CanEarnSoldierRelationshipPoints(TargetUnit)) // pmiller - so that you can't have a relationship with yourself
		{
			SourceUnit.AddToSquadmateScore(TargetUnit.ObjectID, class'X2ExperienceConfig'.default.SquadmateScore_MedikitHeal);
			TargetUnit.AddToSquadmateScore(SourceUnit.ObjectID, class'X2ExperienceConfig'.default.SquadmateScore_MedikitHeal);
		}

		// Extend the hack control turn duration if the unit has the Advanced Repair ability
		if (SourceUnit.AffectedByEffectNames.Find('WOTC_APA_AdvancedRepairEffect') != -1)
		{
			if (TargetUnit.AffectedByEffectNames.Find('MindControl') != -1 && !TargetUnit.IsEnemyUnit(SourceUnit))
			{
				EffectState = TargetUnit.GetUnitAffectedByEffectState('MindControl');
				if (EffectState != none)
				{
					EffectState.iTurnsRemaining += 1;
		}	}	}
	}
}


simulated function AddX2ActionsForVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	local XComGameState_Unit OldUnit, NewUnit;
	local X2Action_PlaySoundAndFlyOver SoundAndFlyOver;
	local int Healed;
	local string Msg;

	OldUnit = XComGameState_Unit(ActionMetadata.StateObject_OldState);
	NewUnit = XComGameState_Unit(ActionMetadata.StateObject_NewState);

	if (OldUnit != none && NewUnit != None)
	{
		Healed = NewUnit.GetCurrentStat(eStat_HP) - OldUnit.GetCurrentStat(eStat_HP);
	
		if (Healed != 0)
		{
			SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded));
			Msg = Repl(default.strRepairedMessage, "<HealMod/>", Healed);
			SoundAndFlyOver.SetSoundAndFlyOverParameters(None, Msg, '', eColor_Good);
		}		
	}
}