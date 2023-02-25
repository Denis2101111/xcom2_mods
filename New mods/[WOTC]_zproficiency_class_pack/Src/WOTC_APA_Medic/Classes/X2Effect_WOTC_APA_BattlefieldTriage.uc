
class X2Effect_WOTC_APA_BattlefieldTriage extends X2Effect_Persistent config(WOTC_APA_MedicSkills);

var config array<name> BATTLEFIELD_TRIAGE_VALID_ABILITIES;
var name WOTC_APA_BattlefieldTriage_TriggeredName;


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

	EventManager.RegisterForEvent(EffectObj, 'XpHealDamage', BattlefieldTriageHeal, ELD_OnStateSubmitted, 25,,, EffectObj);
	`LOG("WOTC_APA_Medic - Event Registered: Battlefield Triage Event Listener for" @ XComGameState_Unit(TargetObj).GetFullName(), bLog);
}


// This is triggered by a Medikit heal
static function EventListenerReturn BattlefieldTriageHeal(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Unit					TargetUnit, SourceUnit, ExpectedSourceUnit;
	local XComGameState_Effect					EffectState;
	local XComGameStateContext_Ability			AbilityContext;
	local bool									bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	`LOG("WOTC_APA_Medic - Event Fired: Battlefield Triage", bLog);

	// Get the Expected SourceUnit
	EffectState = XComGameState_Effect(CallbackData);
	ExpectedSourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	`LOG("WOTC_APA_Medic - Battlefield Triage: Expected(CallbackData) Source Unit" @ ExpectedSourceUnit.GetFullName(), bLog);

	// Get the Source and Target Units for the Heal Event
	AbilityContext = XComGameStateContext_Ability(NewGameState.GetContext());
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID));
	`LOG("WOTC_APA_Medic - Battlefield Triage: AbilityContext(NewGameState) Source Unit" @ SourceUnit.GetFullName(), bLog);

	TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
	`LOG("WOTC_APA_Medic - Battlefield Triage: AbilityContext(NewGameState) Target Unit" @ TargetUnit.GetFullName(), bLog);

	// Check that the SourceUnit is the Expected SourceUnit
	if (ExpectedSourceUnit.ObjectID != SourceUnit.ObjectID)
	{
		`LOG("WOTC_APA_Medic - Battlefield Triage: Heal does not originate from Expected SourceUnit.", bLog);
		return ELR_NoInterrupt;
	}
	`LOG("WOTC_APA_Medic - Battlefield Triage: Expected SourceUnit found.", bLog);
	
	// Modify LowestHP for wound time reduction, if applicable
	if (TargetUnit.LowestHP < int(TargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_HP_PERCENT_CAP))
	{
		TargetUnit.LowestHP = int(TargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_HP_PERCENT_CAP);
		`Log("WOTC_APA_Medic - Battlefield Triage:" $ TargetUnit.GetFullName() $ "'s LowestHP set to: " $ int(TargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_HP_PERCENT_CAP), bLog);
		return ELR_NoInterrupt;
	}

	// If the target's LowestHP is the minimum of 1 and their HighestHP is too low to be eligible for boosts, give the minimum 1 HP boost
	if (TargetUnit.LowestHP == 1)
	{
		TargetUnit.LowestHP += 1;
		`Log("WOTC_APA_Medic - Battlefield Triage:" $ TargetUnit.GetFullName() $ "'s LowestHP set to: 2 (Minimum boost applied - Target's total HP too low to qualify normally)", bLog);
		return ELR_NoInterrupt;
	}

	return ELR_NoInterrupt;
}


// Check for valid abilities that do not trigger the XpHealDamage event (primarily for non-healing Stabilize abilities, etc.)
function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	local XComGameStateHistory		History;
	local XComGameState_Unit		TargetUnit, PrevTargetUnit;
	local name						AbilityName;
	local bool						bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;
	
	// Check that a valid ability was used
	if(kAbility == none)
		return false;

	AbilityName = kAbility.GetMyTemplateName();

	if (class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_VALID_ABILITIES.Find(AbilityName) == -1)
		return false;

	`LOG("WOTC_APA_Medic - Battlefield Triage: PostCostAbilityPaid triggered for valid non-healing ability," @ AbilityName, bLog);

	History = `XCOMHISTORY;
	TargetUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
	PrevTargetUnit = XComGameState_Unit(History.GetGameStateForObjectID(TargetUnit.ObjectID));

	///**/`Log("WOTC_APA_Medic - Battlefield Triage: Beginning checks for " $ AbilityName $ " applied to " $ PrevTargetUnit.GetFullName());
	///**/`Log("WOTC_APA_Medic - Battlefield Triage:" $ PrevTargetUnit.GetFullName() $ "'s current LowestHP/HighestHP: " $ PrevTargetUnit.LowestHP $ "/" $ PrevTargetUnit.HighestHP);
	///**/`Log("WOTC_APA_Medic - Battlefield Triage:" $ PrevTargetUnit.GetFullName() $ "'s LowestHP cap for Battlefield Triage to apply: " $ int(PrevTargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_HP_PERCENT_CAP));

	// Check that the target's LowestHP value is below the %-cap threshold
	if (PrevTargetUnit.LowestHP < int(PrevTargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_HP_PERCENT_CAP))
	{
		TargetUnit.LowestHP = int(PrevTargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_HP_PERCENT_CAP);
		`Log("WOTC_APA_Medic - Battlefield Triage:" $ PrevTargetUnit.GetFullName() $ "'s LowestHP set to: " $ int(PrevTargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_HP_PERCENT_CAP), bLog);
		return false;
	}

	// If the target's LowestHP is the minimum of 1 and their HighestHP is too low to be eligible for boosts, give the minimum 1 HP boost
	if (PrevTargetUnit.LowestHP == 1)
	{
		TargetUnit.LowestHP += 1;
		`Log("WOTC_APA_Medic - Battlefield Triage:" $ PrevTargetUnit.GetFullName() $ "'s LowestHP set to: 2 (Minimum boost applied - Target's total HP too low to qualify normally)", bLog);
		return false;
	}

	return false;
}


//// This is triggered by a Medikit heal
//static function EventListenerReturn BattlefieldTriageWill(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
//{
	//local XComGameState_Unit					TargetUnit, SourceUnit, ExpectedSourceUnit;
	//local XComGameState_Effect					EffectState;
	//local XComGameStateContext_Ability			AbilityContext;
	//local XComGameState_Ability					AbilityState;
	//local X2EventManager						EventManager;
	//local int									HealBonus;
	//local bool									bLog;
//
	//bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;
//
	//`LOG("WOTC_APA_Medic - Event Fired: Battlefield Triage", bLog);
//
	//// Get the Expected SourceUnit
	//EffectState = XComGameState_Effect(CallbackData);
	//ExpectedSourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	//`LOG("WOTC_APA_Medic - Battlefield Triage: Expected(CallbackData) Source Unit" @ ExpectedSourceUnit.GetFullName(), bLog);
//
	//// Get the Source and Target Units for the Heal Event
	//AbilityContext = XComGameStateContext_Ability(NewGameState.GetContext());
	//SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID));
	//`LOG("WOTC_APA_Medic - Battlefield Triage: AbilityContext(NewGameState) Source Unit" @ SourceUnit.GetFullName(), bLog);
//
	//TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
	//`LOG("WOTC_APA_Medic - Battlefield Triage: AbilityContext(NewGameState) Target Unit" @ TargetUnit.GetFullName(), bLog);
//
	//// Check that the SourceUnit is the Expected SourceUnit
	//if (ExpectedSourceUnit.ObjectID != SourceUnit.ObjectID)
	//{
		//`LOG("WOTC_APA_Medic - Battlefield Triage: Heal does not originate from Expected SourceUnit.", bLog);
		//return ELR_NoInterrupt;
	//}
	//`LOG("WOTC_APA_Medic - Battlefield Triage: Expected SourceUnit found.", bLog);
	//
	//// Activating extra healing and Will on Target Unit
	//TargetUnit.ModifyCurrentStat(eStat_Will, class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_TARGET_WILL_BONUS - class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_SQUAD_WILL_BONUS);
//
	//HealBonus = class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_HEALED_HP_BONUS;
	//if (TargetUnit.LowestHP < (TargetUnit.HighestHP - class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_MIN_HP_DAMAGE))
	//{
		//if ((TargetUnit.LowestHP + HealBonus) > (TargetUnit.HighestHP - class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_MIN_HP_DAMAGE))
		//{
			//TargetUnit.LowestHP = TargetUnit.HighestHP - class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_MIN_HP_DAMAGE;
		//}
		//else
		//{
			//TargetUnit.LowestHP = TargetUnit.LowestHP + HealBonus;
		//}
	//}
//
	//// Visualization function
	//NewGameState.GetContext().PostBuildVisualizationFn.AddItem(BattlefieldTriage_BuildVisualization);
//
	//// Trigger multi-target ability to add Will to the rest of the squad
	//EventManager = `XEVENTMGR;
	//AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID));
	//EventManager.TriggerEvent(default.WOTC_APA_BattlefieldTriage_TriggeredName, AbilityState, SourceUnit, NewGameState);
//
	//return ELR_NoInterrupt;
//}
//
//
//// Check for valid abilities that do not trigger the XpHealDamage event (primarily for non-healing Stabilize abilities, etc.)
//function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
//{
	//local XComGameStateHistory		History;
	//local XComGameState_Unit		TargetUnit, PrevTargetUnit;
	//local name						AbilityName;
	//local XComGameState_Ability		AbilityState;
	//local X2EventManager			EventManager;
	//local int						HealBonus;
	//local bool						bLog;
//
	//bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;
	//
	//// Check that a valid ability was used
	//if(kAbility == none)
		//return false;
//
	//AbilityName = kAbility.GetMyTemplateName();
//
	//if (default.BATTLEFIELD_TRIAGE_VALID_ABILITIES.Find(AbilityName) == -1)
		//return false;
//
	//`LOG("WOTC_APA_Medic - Battlefield Triage: PostCostAbilityPaid triggered for valid non-healing ability," @ AbilityName, bLog);
//
	//History = `XCOMHISTORY;
	//TargetUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
	//PrevTargetUnit = XComGameState_Unit(History.GetGameStateForObjectID(TargetUnit.ObjectID));
//
	//// Activating extra healing and Will on Target Unit
	//TargetUnit.ModifyCurrentStat(eStat_Will, class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_TARGET_WILL_BONUS - class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_SQUAD_WILL_BONUS);
	//
	//HealBonus = class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_HEALED_HP_BONUS;
	//if (PrevTargetUnit.LowestHP < (PrevTargetUnit.HighestHP - class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_MIN_HP_DAMAGE))
	//{
		//if ((PrevTargetUnit.LowestHP + HealBonus) > (PrevTargetUnit.HighestHP - class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_MIN_HP_DAMAGE))
		//{
			//TargetUnit.LowestHP = TargetUnit.HighestHP - class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_MIN_HP_DAMAGE;
		//}
		//else
		//{
			//TargetUnit.LowestHP = TargetUnit.LowestHP + HealBonus;
		//}
		//NewGameState.GetContext().PostBuildVisualizationFn.AddItem(BattlefieldTriage_BuildVisualization);
//
		//// Trigger multi-target ability to add Will to the rest of the squad
		//EventManager = `XEVENTMGR;
		//AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID));
		//EventManager.TriggerEvent(default.WOTC_APA_BattlefieldTriage_TriggeredName, AbilityState, SourceUnit, NewGameState);
	//}
//
	//return false;
//}
//
//// Plays a Flyover message displaying Will gained
//static function BattlefieldTriage_BuildVisualization(XComGameState VisualizeGameState)
//{
	//local XComGameStateContext_Ability			AbilityContext;
	//local int									TargetID;
	//local VisualizationActionMetadata			ActionMetadata;
	//local string								WorldMessage;
	//local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;
//
	//AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	//TargetID = AbilityContext.InputContext.PrimaryTarget.ObjectID;
	//
	//ActionMetadata.StateObject_OldState = `XCOMHISTORY.GetGameStateForObjectID(TargetID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	//ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(TargetID);
	//if (ActionMetadata.StateObject_NewState == none)
		//ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
	//ActionMetadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(TargetID);
//
	//WorldMessage = "+" $ class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_TARGET_WILL_BONUS @ class'X2TacticalGameRulesetDataStructures'.default.m_aCharStatLabels[eStat_Will];
//
	//SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	//SoundAndFlyOver.SetSoundAndFlyOverParameters(None, WorldMessage, '', eColor_Good,, `DEFAULTFLYOVERLOOKATTIME, true);
//}


defaultproperties
{
	EffectName="WOTC_APA_BattlefieldTriage"
	WOTC_APA_BattlefieldTriage_TriggeredName="WOTC_APA_BattlefieldTriage_Triggered"
	DuplicateResponse=eDupe_Ignore
	bRemoveWhenSourceDies=true
}