
class X2Effect_WOTC_APA_DisruptionField extends X2Effect_ToHitModifier;

var localized string	strDisruptionFieldFlyover;


// Register for the AbilityActivated Event Trigger
function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager						EventManager;
	local Object								EffectObj, TargetObj;

	EventManager = `XEVENTMGR;
	EffectObj = EffectGameState;
	TargetObj = `XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID);

	EventManager.RegisterForEvent(EffectObj, 'AbilityActivated', DisruptionFieldFlyoverCheck, ELD_OnStateSubmitted,,,, TargetObj);
}

static function EventListenerReturn DisruptionFieldFlyoverCheck(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Unit					TargetUnit, ExpectedTargetUnit;
	local XComGameStateContext_Ability			AbilityContext;
	local XComGameState_Ability					AbilityState;

	// Get the Expected TargetUnit and actual TargetUnit
	ExpectedTargetUnit = XComGameState_Unit(CallbackData);
	AbilityContext = XComGameStateContext_Ability(NewGameState.GetContext());
	TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));

	// Check that the TargetUnit is the Expected TargetUnit
	if (ExpectedTargetUnit.ObjectID != TargetUnit.ObjectID)
	{
		return ELR_NoInterrupt;
	}
	
	// Add the Flyover Visualization indicating the effect gauranteed a miss if the incoming shot was reaction fire
	AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID));
	if (X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc) != none)
	{
		if (X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc).bReactionFire)
		{
			NewGameState.GetContext().PostBuildVisualizationFn.AddItem(TargetFlyover_BuildVisualization);
		}
	}
	
	return ELR_NoInterrupt;
}

simulated function TargetFlyover_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory					History;
	local XComGameStateContext_Ability			AbilityContext;
	local XComGameState_Ability					AbilityState;
	local StateObjectReference					TargetUnitRef;
	local VisualizationActionMetadata			ActionMetadata;
	local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;
	
	History = `XCOMHISTORY;

	AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	TargetUnitRef = AbilityContext.InputContext.PrimaryTarget;
	AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID));
	
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(TargetUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(TargetUnitRef.ObjectID);
	if (ActionMetadata.StateObject_NewState == none)
		ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
	ActionMetadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(TargetUnitRef.ObjectID);
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(SoundCue'SoundParticleObjects.ShieldHitCue', default.strDisruptionFieldFlyover, '', eColor_Good, "img:///UILibrary_WOTC_APA_Class_Pack.perk_DisruptionField", `DEFAULTFLYOVERLOOKATTIME);
}


// Add modifier negating reaction fire
function GetToHitAsTargetModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local ShotModifierInfo				ShotInfo;
	//local XGUnit						TargetUnit;

	// If the incoming shot is reaction fire, guarantee the shot misses
	if (X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc) != none)
	{
		if (X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc).bReactionFire)
		{
			//TargetUnit = XGUnit(Target.GetVisualizer());
			//class'UIWorldMessageMgr'.static.DamageDisplay(TargetUnit.GetPawn().GetHeadShotLocation(), TargetUnit.GetVisualizedStateReference(), default.strDisruptionFieldFlyover,,,,,, eColor_Bad);

			ShotInfo.ModType = eHit_Success;
			ShotInfo.Reason = FriendlyName;
			ShotInfo.Value = -200;
			ShotModifiers.AddItem(ShotInfo);
}	}	}