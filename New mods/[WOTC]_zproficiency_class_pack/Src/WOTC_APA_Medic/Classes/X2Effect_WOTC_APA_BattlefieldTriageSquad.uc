class X2Effect_WOTC_APA_BattlefieldTriageSquad extends X2Effect;
//
//var private int		TargetID;
//
//simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
//{
	//local XComGameState_Unit			TargetUnit;
//
	//TargetUnit = XComGameState_Unit(kNewTargetState);
	//TargetUnit.ModifyCurrentStat(eStat_Will, class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_SQUAD_WILL_BONUS);
//
	////TargetID = TargetUnit.ObjectID;
//
	//// visualization function - doesnt display correctly
	////if (NewGameState.GetContext().PostBuildVisualizationFn.Find(BattlefieldTriage_BuildVisualization) == INDEX_NONE)
		////NewGameState.GetContext().PostBuildVisualizationFn.AddItem(BattlefieldTriage_BuildVisualization);
//}
//
//
//// Plays a Flyover message displaying Will gained
//function BattlefieldTriage_BuildVisualization(XComGameState VisualizeGameState)
//{
	//local XComGameStateContext_Ability			AbilityContext;
	////local int									TargetID;
	//local VisualizationActionMetadata			ActionMetadata;
	//local string								WorldMessage;
	////local X2Action_Delay						DelayAction;
	//local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;
//
	//AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	////TargetID = AbilityContext.InputContext.PrimaryTarget.ObjectID;
		//
	//ActionMetadata.StateObject_OldState = `XCOMHISTORY.GetGameStateForObjectID(TargetID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	//ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(TargetID);
	//if (ActionMetadata.StateObject_NewState == none)
		//ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
	//ActionMetadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(TargetID);
//
	//WorldMessage = "+" $ class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_SQUAD_WILL_BONUS @ class'X2TacticalGameRulesetDataStructures'.default.m_aCharStatLabels[eStat_Will];
//
	////DelayAction = X2Action_Delay(class'X2Action_Delay'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	////DelayAction.bIgnoreZipMode = true;
	////DelayAction.Duration = 1;
//
	//SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	//SoundAndFlyOver.SetSoundAndFlyOverParameters(None, WorldMessage, '', eColor_Good,, `DEFAULTFLYOVERLOOKATTIME, true);
//}