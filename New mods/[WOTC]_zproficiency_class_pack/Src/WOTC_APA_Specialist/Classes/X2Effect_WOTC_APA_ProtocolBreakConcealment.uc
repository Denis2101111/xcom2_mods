
class X2Effect_WOTC_APA_ProtocolBreakConcealment extends X2Effect;

var name WOTC_APA_ProtocolRetainIndividualConcealment_TriggeredName;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameStateContext_Ability	AbilityContext;
	local XComGameState_Item			GremlinItemState;
	local XComGameState_Unit			TargetUnit, GremlinUnitState;
	local XComGameState_Player			PlayerState;
	local XComGameState_Ability			AbilityState;

	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);

	AbilityContext = XComGameStateContext_Ability(NewGameState.GetContext());

	TargetUnit = XComGameState_Unit(kNewTargetState);
	GremlinItemState = XComGameState_Item(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.ItemObject.ObjectID));
	if (GremlinItemState == none)
	{
		GremlinItemState = XComGameState_Item(NewGameState.ModifyStateObject(class'XComGameState_Item', AbilityContext.InputContext.ItemObject.ObjectID));
	}
	GremlinUnitState = XComGameState_Unit(NewGameState.GetGameStateForObjectID(GremlinItemState.CosmeticUnitRef.ObjectID));
	if (GremlinUnitState == none)
	{
		GremlinUnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', GremlinItemState.CosmeticUnitRef.ObjectID));
	}

	PlayerState = XComGameState_Player(`XCOMHISTORY.GetGameStateForObjectID(TargetUnit.ControllingPlayer.ObjectID));
	if (PlayerState.bSquadIsConcealed)
		NewGameState.GetContext().PostBuildVisualizationFn.AddItem(BreakSquadConcealment_BuildVisualization);

	// If TargetUnit is and will remain concealed, trigger ability that modifies detection radius
	if (TargetUnit.IsIndividuallyConcealed())
	{
		if (TargetUnit.AffectedByEffectNames.Find('WOTC_APA_ABCProtocols_RetainIndividualConcealmentEffect') != -1)
		{	
			//AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
			`XEVENTMGR.TriggerEvent(default.WOTC_APA_ProtocolRetainIndividualConcealment_TriggeredName, TargetUnit, TargetUnit, NewGameState);
	}	}

	`XEVENTMGR.TriggerEvent('EffectBreakUnitConcealment', GremlinUnitState, GremlinUnitState, NewGameState);
}


static function BreakSquadConcealment_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateContext_Ability			AbilityContext;
	local int									SourceID;
	local VisualizationActionMetadata			Metadata;
	local string								Message;
	local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;

	AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	SourceID = AbilityContext.InputContext.SourceObject.ObjectID;
	
	Metadata.StateObject_OldState = `XCOMHISTORY.GetGameStateForObjectID(SourceID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	Metadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(SourceID);
	if (Metadata.StateObject_NewState == none)
		Metadata.StateObject_NewState = Metadata.StateObject_OldState;
	Metadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(SourceID);

	Message = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.strProtocolSquadConcealmentBrokenFlyover;
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(Metadata, AbilityContext));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, Message, '', eColor_Bad,, `DEFAULTFLYOVERLOOKATTIME * 3, true);
}


defaultproperties
{
    WOTC_APA_ProtocolRetainIndividualConcealment_TriggeredName = "WOTC_APA_ProtocolRetainIndividualConcealment_Triggered"
}