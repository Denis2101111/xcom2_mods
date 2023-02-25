
class X2Effect_WOTC_APA_ReviveHealAmount extends X2Effect;

var int		iHealAmount;


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{

	local XComGameState_Unit			SourceUnit;
	local EffectAppliedData				ApplyData;
	local X2Effect_ApplyMedikitHeal		HealEffect;

	SourceUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(ApplyEffectParameters.SourceStateObjectRef.ObjectID));

	iHealAmount = 0;
	if (SourceUnit.HasSoldierAbility('WOTC_APA_AdvancedTraumaKits'))
	{
		iHealAmount = class'X2Ability_WOTC_APA_MedicAbilitySet'.default.TRAUMA_KITS_REVIVE_HEAL_BONUS;
	}

	HealEffect = new class'X2Effect_ApplyMedikitHeal';
	HealEffect.PerUseHP = iHealAmount;

	ApplyData = ApplyEffectParameters;
	HealEffect.ApplyEffect(ApplyData, kNewTargetState, NewGameState);
}

simulated function AddX2ActionsForVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	local XComGameState_Ability			AbilityState;
	local X2AbilityTemplate				AbilityTemplate;
	local X2AbilityTemplateManager		AbilityTemplateMgr;
	local XComGameState_Unit			OldUnit, NewUnit, SourceUnit;
	local X2Action_PlaySoundAndFlyOver	SoundAndFlyOver;
	local int							iHealed;
	local string						Msg;
	
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(XComGameStateContext_Ability(VisualizeGameState.GetContext()).InputContext.SourceObject.ObjectID));
	AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(XComGameStateContext_Ability(VisualizeGameState.GetContext()).InputContext.AbilityRef.ObjectID));	

	OldUnit = XComGameState_Unit(ActionMetadata.StateObject_OldState);
	NewUnit = XComGameState_Unit(ActionMetadata.StateObject_NewState);
	ActionMetadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(NewUnit.ObjectID);

	if (OldUnit != none && NewUnit != None)
	{
		iHealed = NewUnit.GetCurrentStat(eStat_HP) - OldUnit.GetCurrentStat(eStat_HP);
	
		SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext()));
		if (SourceUnit.HasSoldierAbility('WOTC_APA_AdvancedTraumaKits'))
		{
			AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
			AbilityTemplate = AbilityTemplateMgr.FindAbilityTemplate('WOTC_APA_AdvancedTraumaKits');
			Msg = AbilityTemplate.LocFriendlyName $ ": " @ Repl(class'X2Effect_ApplyMedikitHeal'.default.HealedMessage, "<Heal/>", iHealed);
			SoundAndFlyOver.SetSoundAndFlyOverParameters(None, Msg,'', eColor_Good, AbilityTemplate.IconImage, 2.5);
		}
		else
		{
			AbilityTemplate = AbilityState.GetMyTemplate();
			Msg = AbilityTemplate.LocFriendlyName $ ": " @ Repl(class'X2Effect_ApplyMedikitHeal'.default.HealedMessage, "<Heal/>", iHealed);
			SoundAndFlyOver.SetSoundAndFlyOverParameters(None, Msg,'', eColor_Good, AbilityTemplate.IconImage, `DEFAULTFLYOVERLOOKATTIME * 4);
		}
	}
}