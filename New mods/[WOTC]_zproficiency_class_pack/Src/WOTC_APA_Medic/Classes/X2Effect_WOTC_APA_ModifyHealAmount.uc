
class X2Effect_WOTC_APA_ModifyHealAmount extends X2Effect_Persistent;

// Variables to pass into the effect:
var int		HealModifier;		//»» Modify healing effects by this many HP
var string	strFlyoverIcon;		//»» The image path for an icon that can be used in the visualization flyover on the healing source unit
var string	strFlyoverMessage;	//»» String that can be used in a visualization flyover message on the healing source unit indicating why the heal was modified
var EWidgetColor FlyoverColor;	//»» Color to display the visualization flyover message in - defaults to eColor_Good (Bonus healing, etc.)

// NOTE: If the strFlyoverMessage is left blank, a Flyover will not be played. The "<HealMod/>" tag can be used in the strFlyoverMessage and it will
// be replaced with the respective stat modifiers configured for the effect. If the strFlyoverIcon path is left blank, the Flyover will be text only.
// Don't assign an EffectName - it must be left as the default to allow the Visualization Function to find the EffectState and retrieve the effect variables.

// Register for the OnHeal Event Trigger
function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager						EventManager;
	local Object								EffectObj, TargetObj;
	local bool									bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	EventManager = `XEVENTMGR;
	EffectObj = EffectGameState;
	TargetObj = `XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID);

	EventManager.RegisterForEvent(EffectObj, 'XpHealDamage', ModifyMedikitHeal, ELD_OnStateSubmitted, 75,,, EffectObj);
	`LOG("On Modify Heal - Registered Event Listener for" @ XComGameState_Unit(TargetObj).GetFullName(), bLog);
}


// This is triggered by a Medikit heal
static function EventListenerReturn ModifyMedikitHeal(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Unit					TargetUnit, SourceUnit, ExpectedSourceUnit;
	local XComGameState_Effect					EffectState;
	local XComGameStateContext_Ability			AbilityContext;
	local X2Effect_WOTC_APA_ModifyHealAmount	Effect;
	local bool									bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	`LOG("On Modify Heal - Event Fired", bLog);

	// Get the Expected SourceUnit
	EffectState = XComGameState_Effect(CallbackData);
	ExpectedSourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	`LOG("On Modify Heal - Expected(CallbackData) Source Unit" @ ExpectedSourceUnit.GetFullName(), bLog);

	// Get the Source and Target Units for the Heal Event
	AbilityContext = XComGameStateContext_Ability(NewGameState.GetContext());
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID));
	`LOG("On Modify Heal - AbilityContext(NewGameState) Source Unit" @ SourceUnit.GetFullName(), bLog);

	TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
	`LOG("On Modify Heal - AbilityContext(NewGameState) Target Unit" @ TargetUnit.GetFullName(), bLog);

	// Check that the SourceUnit is the Expected SourceUnit
	if (ExpectedSourceUnit.ObjectID != SourceUnit.ObjectID)
	{
		`LOG("On Modify Heal - Heal does not originate from Expected SourceUnit.", bLog);
		return ELR_NoInterrupt;
	}
	`LOG("On Modify Heal - Expected SourceUnit found.", bLog);
	
	// Activating extra healing on Target Unit
	Effect = X2Effect_WOTC_APA_ModifyHealAmount(EffectState.GetX2Effect());
	TargetUnit.ModifyCurrentStat(eStat_HP, Effect.HealModifier);
	`LOG("On Modify Heal - Heal Modifier is:" @ Effect.HealModifier, bLog);

	// visualization function
	if (Effect.HealModifier != 0 && Effect.strFlyoverMessage != "")
	{
		if (NewGameState.GetContext().PostBuildVisualizationFn.Find(ModifyHealAmount_BuildVisualization) == INDEX_NONE)
		{
			NewGameState.GetContext().PostBuildVisualizationFn.AddItem(ModifyHealAmount_BuildVisualization);
	}	}

	return ELR_NoInterrupt;
}

// Plays a Flyover message on the Healer with the strFlyoverMessage to indicate why this heal is being modified
static function ModifyHealAmount_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateContext_Ability			AbilityContext;
	local X2Effect_WOTC_APA_ModifyHealAmount	Effect;
	local XComGameState_Effect					EffectState;
	local int									HealerID;
	local VisualizationActionMetadata			Metadata;
	local string								WorldMessage;
	local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;

	AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	HealerID = AbilityContext.InputContext.SourceObject.ObjectID;
	EffectState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(HealerID)).GetUnitAffectedByEffectState(default.EffectName);
	Effect = X2Effect_WOTC_APA_ModifyHealAmount(EffectState.GetX2Effect());
	
	Metadata.StateObject_OldState = `XCOMHISTORY.GetGameStateForObjectID(HealerID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	Metadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(HealerID);
	if (Metadata.StateObject_NewState == none)
		Metadata.StateObject_NewState = Metadata.StateObject_OldState;
	Metadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(HealerID);

	WorldMessage = Effect.strFlyoverMessage;

	// Insert HealModifier into Flyover Message
	if (Effect.HealModifier > 0)
		WorldMessage = Repl(WorldMessage, "<HealMod/>", "+" $ Effect.HealModifier);
	else
		WorldMessage = Repl(WorldMessage, "<HealMod/>", Effect.HealModifier);
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(Metadata, AbilityContext));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, WorldMessage, '', Effect.FlyoverColor, Effect.strFlyoverIcon, `DEFAULTFLYOVERLOOKATTIME * 3, true);
}


defaultproperties
{
    DuplicateResponse=eDupe_Allow
	EffectName="WOTC_APA_ModifyHealAmount"
	FlyoverColor=eColor_Good
}