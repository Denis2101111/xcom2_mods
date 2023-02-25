class X2Effect_WOTC_APA_AidProtocolDefense extends X2Effect_Persistent;


function GetToHitAsTargetModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local ShotModifierInfo ShotMod;

	if (Target.IsInWorldEffectTile(class'X2Effect_WOTC_APA_ApplyAidProtocolSmokeToWorld'.default.Class.Name))
	{
		ShotMod.ModType = eHit_Success;
		ShotMod.Value = -class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.AID_PROTOCOL_SMOKE_DEFENSE;
		ShotMod.Reason = FriendlyName;
		ShotModifiers.AddItem(ShotMod);
	}
}

function bool IsEffectCurrentlyRelevant(XComGameState_Effect EffectGameState, XComGameState_Unit TargetUnit)
{
	return TargetUnit.IsInWorldEffectTile(class'X2Effect_WOTC_APA_ApplyAidProtocolSmokeToWorld'.default.Class.Name);
}

static function SmokeVisualizationTickedOrRemoved(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	local X2Action_UpdateUI UpdateUIAction;

	UpdateUIAction = X2Action_UpdateUI(class'X2Action_UpdateUI'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded));
	UpdateUIAction.SpecificID = ActionMetadata.StateObject_NewState.ObjectID;
	UpdateUIAction.UpdateType = EUIUT_UnitFlag_Buffs;
}


DefaultProperties
{
	EffectName = "WOTC_APA_AidProtocolDefenseEffect"
	DuplicateResponse = eDupe_Refresh
	EffectTickedVisualizationFn = SmokeVisualizationTickedOrRemoved;
	EffectRemovedVisualizationFn = SmokeVisualizationTickedOrRemoved;
}