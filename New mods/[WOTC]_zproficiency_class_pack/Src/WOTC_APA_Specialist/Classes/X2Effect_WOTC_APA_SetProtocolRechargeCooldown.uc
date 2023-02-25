
class X2Effect_WOTC_APA_SetProtocolRechargeCooldown extends X2Effect_Persistent;

struct AbilityRechargeEntry
{
    var name AbilityName;
    var name RechargeUnitValueName;
};

var localized string strProtocolRechargeFlyover;

// Variables to pass into the condition check:
var array<AbilityRechargeEntry>	AbilityRechargeEntries;		//»» Abilities that will recharge when the last charge is used (turns are based on the specified unit value)

function AddAbilityRechargeEntry(name AbilityName, name RechargeUnitValueName)
{
	local AbilityRechargeEntry RechargeEntry;

	RechargeEntry.AbilityName = AbilityName;
	RechargeEntry.RechargeUnitValueName = RechargeUnitValueName;
	AbilityRechargeEntries.AddItem(RechargeEntry);
}


function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	local AbilityRechargeEntry		AbilityRecharge;
	local UnitValue					UnitValue;
	local bool						bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	if (kAbility == none)
		return false;

	// Only add recharge charges when all normal charges have been depleted
	if (kAbility.iCharges != 0)
		return false;

	`LOG("WOTC_APA_Specialist - ProtocolRechargeCooldown: Ability Evaluated is" @ kAbility.GetMyTemplateName(), bLog);

	// Check to see if the ability used has a recharge entry defined
	foreach AbilityRechargeEntries(AbilityRecharge)
	{
		if (kAbility.GetMyTemplateName() == AbilityRecharge.AbilityName)
		{
			// Retrieve the unit's current recharge cooldown unit value - do nothing if one is not found
			if (SourceUnit.GetUnitValue(AbilityRecharge.RechargeUnitValueName, UnitValue))	
			{
				// Restore 1 charge to the ability and set the recharge cooldown timer
				`LOG("WOTC_APA_Specialist - ProtocolRechargeCooldown: Ability cooldown set to" @ UnitValue.fValue, bLog);
				kAbility.iCharges = 1;
				kAbility.iCooldown = Max(1, UnitValue.fValue);
				NewGameState.GetContext().PostBuildVisualizationFn.AddItem(RechargeFlyover_BuildVisualization);
			}
			return false;
	}	}

	return false;
}

simulated function RechargeFlyover_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory					History;
	local X2AbilityTemplateManager				AbilityTemplateMgr;
	local X2AbilityTemplate						AbilityTemplate;
	local XComGameStateContext_Ability			AbilityContext;
	local StateObjectReference					TargetUnitRef;
	local VisualizationActionMetadata			ActionMetadata;
	local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;

	History = `XCOMHISTORY;

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplate = AbilityTemplateMgr.FindAbilityTemplate('WOTC_APA_ProtocolPackages');
	AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	TargetUnitRef = AbilityContext.InputContext.SourceObject;

	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(TargetUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(TargetUnitRef.ObjectID);
	if (ActionMetadata.StateObject_NewState == none)
		ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
	ActionMetadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(TargetUnitRef.ObjectID);
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, default.strProtocolRechargeFlyover, '', eColor_Good, AbilityTemplate.IconImage, `DEFAULTFLYOVERLOOKATTIME * 2);
}