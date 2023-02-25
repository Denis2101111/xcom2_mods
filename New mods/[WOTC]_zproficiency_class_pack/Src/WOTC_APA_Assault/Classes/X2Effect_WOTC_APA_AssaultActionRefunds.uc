
class X2Effect_WOTC_APA_AssaultActionRefunds extends X2Effect_Persistent;

var name WOTC_APA_AssaultLargePartialMovementAction_TriggeredName;
var name WOTC_APA_AssaultSmallPartialMovementAction_TriggeredName;
var name WOTC_APA_AssaultNonMovementAction_RelentlessUnitName;
var name WOTC_APA_AssaultNonMovementAction_SweepAndClearUnitName;
var string MoveFlyover, ActionFlyover, FlyoverMessage;
var string FlyoverIcon;


function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{

	local XComGameStateHistory					History;
	local XComGameState_Unit					TargetUnit, PrevTargetUnit;
	local X2AbilityTemplateManager				AbilityTemplateMgr;
	local X2AbilityTemplate						AbilityTemplate, FlyoverTemplate;
	local X2WeaponTemplate						WeaponTemplate;
	local bool									bLightWeapon, bLog;
	local bool									bGrantMovePoint, bGrantActionPoint;
	local UnitValue								TrackerUnitValue, RangeUnitValue;
	local string								sMessageBridge;
	local X2EventManager						EventManager;
	local XComGameState_Effect					RemoveEffectState;
	local XComGameStateContext_EffectRemoved	RemoveEffectContext;
	local XComGameState_Ability					AbilityState;
	local GameRulesCache_VisibilityInfo			VisInfo;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	// Require the unit to have some action points before activating the ability (prevents triggering on overwatch or reaction attacks)
	if (PreCostActionPoints.Length == 0)
		return false;
	
	// Prevent triggering from Combatives or other melee counter attack abilities
	if (PreCostActionPoints.Length == 1 && PreCostActionPoints.Find(class'X2CharacterTemplateManager'.default.CounterattackActionPoint) != -1)
		return false;

	// Get Target's XComGameState_Unit
	History = `XCOMHISTORY;
	TargetUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
	PrevTargetUnit = XComGameState_Unit(History.GetGameStateForObjectID(TargetUnit.ObjectID));

	// Get the triggering ability template
	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplate = AbilityTemplateMgr.FindAbilityTemplate(AbilityContext.InputContext.AbilityTemplateName);

	// Get the triggering source weapon and whether it is a light weapon
	WeaponTemplate = X2WeaponTemplate(XComGameState_Item(History.GetGameStateForObjectID(AbilityContext.InputContext.ItemObject.ObjectID)).GetMyTemplate());
	if (WeaponTemplate != none)
	{
		if (WeaponTemplate.InventorySlot == eInvSlot_PrimaryWeapon && class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.RUN_AND_GUN_LIGHT_PRIMARY_WEAPONS.Find(WeaponTemplate.WeaponCat) != -1)
			bLightWeapon = true;

		if (WeaponTemplate.InventorySlot == eInvSlot_SecondaryWeapon && class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.RUN_AND_GUN_LIGHT_SECONDARY_WEAPONS.Find(WeaponTemplate.WeaponCat) != -1)
			bLightWeapon = true;
	}	

	// If SourceUnit has Breakthrough or Relentless and the attack was a turn-ending melee attack, check for actions
	if (SourceUnit.HasSoldierAbility('WOTC_APA_Breakthrough') || SourceUnit.HasSoldierAbility('WOTC_APA_Relentless'))
	{
		if (AbilityTemplate != none && AbilityTemplate.IsMelee() && SourceUnit.NumActionPoints() < 1)
		{
			if (SourceUnit.HasSoldierAbility('WOTC_APA_Breakthrough'))
			{
				FlyoverTemplate = AbilityTemplateMgr.FindAbilityTemplate('WOTC_APA_Breakthrough');
				MoveFlyover = FlyoverTemplate.LocFlyOverText;
				FlyoverIcon = FlyoverTemplate.IconImage;
				bGrantMovePoint = true;
			}

			if (SourceUnit.HasSoldierAbility('WOTC_APA_Relentless') && (!TargetUnit.IsAlive() || TargetUnit.bBleedingOut))
			{
				// Ensure Relentless has not already triggered more times than allowed this turn
				SourceUnit.GetUnitValue(default.WOTC_APA_AssaultNonMovementAction_RelentlessUnitName, TrackerUnitValue);
				if (TrackerUnitValue.fValue < class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.NON_MOVE_ACTION_ACTIVATION_LIMIT)
				{
					// Increment the activation tracker for Relentless
					TrackerUnitValue.fValue += 1.0;
					SourceUnit.SetUnitFloatValue(default.WOTC_APA_AssaultNonMovementAction_RelentlessUnitName, TrackerUnitValue.fValue, eCleanup_BeginTurn);
					FlyoverTemplate = AbilityTemplateMgr.FindAbilityTemplate('WOTC_APA_Relentless');
					ActionFlyover = FlyoverTemplate.LocFlyOverText;
					FlyoverIcon = FlyoverTemplate.IconImage;
					bGrantActionPoint = true;
	}	}	}	}


	// If SourceUnit has Breaching Maneuver or Sweep and Clear and the attack was against a disoriented or stunned target in CQB range, check for actions
	if ((SourceUnit.HasSoldierAbility('WOTC_APA_BreachingManeuver') && !bGrantMovePoint) || (SourceUnit.HasSoldierAbility('WOTC_APA_SweepAndClear') && !bGrantActionPoint))
	{
		// Retrieve the unit's current CQB radius unit value - do nothing if one is not found
		//if (SourceUnit.GetUnitValue(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_RADIUS_NAME, RangeUnitValue))	
		//{
			// Distance between Source and Target units must be less than the Source's CQB range
			//if (SourceUnit.TileDistanceBetween(PrevTargetUnit) <= RangeUnitValue.fValue)
			//{
				// If the ability was a hostile, turn-ending ability, check for actions
				if (AbilityTemplate.Hostility == eHostility_Offensive && SourceUnit.NumActionPoints() < 1)
				{
					if (!AbilityTemplate.IsMelee() && TargetUnit.GetMyTemplate().bCanTakeCover)
					{
						if (`TACTICALRULES.VisibilityMgr.GetVisibilityInfo(SourceUnit.ObjectID, PrevTargetUnit.ObjectID, VisInfo))
						{
							if (SourceUnit.CanFlank() && VisInfo.TargetCover == CT_None)
							{
								FlyoverTemplate = AbilityTemplateMgr.FindAbilityTemplate('WOTC_APA_BreachingManeuver');
								MoveFlyover = FlyoverTemplate.LocFlyOverText;
								if (FlyoverIcon == "") // Don't overwrite if Relentless' Icon is being used
								{
									FlyoverIcon = FlyoverTemplate.IconImage;
								}
								bGrantMovePoint = true;
					}	}	}
					
					if (PrevTargetUnit.AffectedByEffectNames.Find(class'X2AbilityTemplateManager'.default.DisorientedName) != -1 || PrevTargetUnit.AffectedByEffectNames.Find(class'X2AbilityTemplateManager'.default.StunnedName) != -1)
					{
						if (SourceUnit.HasSoldierAbility('WOTC_APA_BreachingManeuver') && !bGrantMovePoint)
						{
							FlyoverTemplate = AbilityTemplateMgr.FindAbilityTemplate('WOTC_APA_BreachingManeuver');
							MoveFlyover = FlyoverTemplate.LocFlyOverText;
							if (FlyoverIcon == "") // Don't overwrite if Relentless' Icon is being used
							{
								FlyoverIcon = FlyoverTemplate.IconImage;
							}
							bGrantMovePoint = true;
						}

						if (SourceUnit.HasSoldierAbility('WOTC_APA_SweepAndClear') && !bGrantActionPoint && (!TargetUnit.IsAlive() || TargetUnit.bBleedingOut))
						{
							// Ensure Sweep and Clear has not already triggered more times than allowed this turn
							SourceUnit.GetUnitValue(default.WOTC_APA_AssaultNonMovementAction_SweepAndClearUnitName, TrackerUnitValue);
							if (TrackerUnitValue.fValue < class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.NON_MOVE_ACTION_ACTIVATION_LIMIT)
							{
								// Increment the activation tracker for Sweep and Clear
								TrackerUnitValue.fValue += 1.0;
								SourceUnit.SetUnitFloatValue(default.WOTC_APA_AssaultNonMovementAction_SweepAndClearUnitName, TrackerUnitValue.fValue, eCleanup_BeginTurn);
								FlyoverTemplate = AbilityTemplateMgr.FindAbilityTemplate('WOTC_APA_SweepAndClear');
								ActionFlyover = FlyoverTemplate.LocFlyOverText;
								FlyoverIcon = FlyoverTemplate.IconImage;
								bGrantActionPoint = true;
	}	}	}	}	}	//}	}


	// Exit if no action points are being granted
	if (bGrantMovePoint || bGrantActionPoint)
	{
		if (bGrantMovePoint)
		{
			// If the unit already has the mobility penalty applied, remove it incase this application should use a different modifier
			if (SourceUnit.AffectedByEffectNames.Find('WOTC_APA_AssaultPartialMovementActionMobilityPenalty') != -1)
			{
				RemoveEffectState = SourceUnit.GetUnitAffectedByEffectState('WOTC_APA_AssaultPartialMovementActionMobilityPenalty');
				if (RemoveEffectState != none)
				{
					RemoveEffectContext = class'XComGameStateContext_EffectRemoved'.static.CreateEffectRemovedContext(RemoveEffectState);
					RemoveEffectState.RemoveEffect(NewGameState, NewGameState);
			}	}
		}

		// If a move and action point are being added, fill in the message bridge
		if (bGrantMovePoint && bGrantActionPoint)
		{
			sMessageBridge = "  -  ";
		}

		// Build the full Flyover Message
		FlyoverMessage = MoveFlyover $ sMessageBridge $ ActionFlyover;


		// Apply action points and mobility penalty, if applicable
		AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
		if (AbilityState != none)
		{
			if (bGrantMovePoint)
			{
				SourceUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.MoveActionPoint);
				EventManager = `XEVENTMGR;
				if (bLightWeapon)
				{
					EventManager.TriggerEvent(default.WOTC_APA_AssaultLargePartialMovementAction_TriggeredName, AbilityState, SourceUnit, NewGameState);
				}
				else
				{
					EventManager.TriggerEvent(default.WOTC_APA_AssaultSmallPartialMovementAction_TriggeredName, AbilityState, SourceUnit, NewGameState);
			}	}

			if (bGrantActionPoint)
			{
				SourceUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.RunAndGunActionPoint);
			}
		
			NewGameState.GetContext().PostBuildVisualizationFn.AddItem(PlayFlyover_BuildVisualization);
	}	}

	return false;
}



simulated function PlayFlyover_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory					History;
	local XComGameStateContext_Ability			AbilityContext;
	local StateObjectReference					TargetUnitRef;
	local VisualizationActionMetadata			ActionMetadata;
	local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;

	History = `XCOMHISTORY;

	AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	TargetUnitRef = AbilityContext.InputContext.SourceObject;

	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(TargetUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(TargetUnitRef.ObjectID);
	if (ActionMetadata.StateObject_NewState == none)
		ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
	ActionMetadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(TargetUnitRef.ObjectID);
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, FlyoverMessage, '', eColor_Good, FlyoverIcon, `DEFAULTFLYOVERLOOKATTIME * 2);

	// Reset Flyover strings
	MoveFlyover = "";
	ActionFlyover = "";
	FlyoverMessage = "";
	FlyoverIcon = "";
}


defaultproperties
{
	WOTC_APA_AssaultLargePartialMovementAction_TriggeredName = "WOTC_APA_AssaultLargePartialMovementAction_Triggered"
	WOTC_APA_AssaultSmallPartialMovementAction_TriggeredName = "WOTC_APA_AssaultSmallPartialMovementAction_Triggered"
	WOTC_APA_AssaultNonMovementAction_RelentlessUnitName = "WOTC_APA_AssaultNonMovementAction_RelentlessTracker"
	WOTC_APA_AssaultNonMovementAction_SweepAndClearUnitName = "WOTC_APA_AssaultNonMovementAction_SweepAndClearTracker"
}